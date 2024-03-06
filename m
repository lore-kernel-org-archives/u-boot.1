Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97532C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 13:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D90D086FB2;
	Wed,  6 Mar 2024 14:34:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2EED87B07; Wed,  6 Mar 2024 14:34:46 +0100 (CET)
Received: from esa1.ltts.com (unknown [118.185.121.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A75D587C61
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 14:34:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=ltts.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhargav.r@ltts.com
IronPort-SDR: DwiZfOjeyW/vbsDMrPOf7V66cgqFbWXN1KQ9kcu6ViynLiRVDAKu3bbtxPmUlYQZfkFrQGoeKn
 EO9z7sd6CC/Q==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
 by esa1.ltts.com with ESMTP; 06 Mar 2024 19:04:38 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: d-gole@ti.com
Cc: bhargav.r@ltts.com, jh80.chung@samsung.com, kamlesh@ti.com,
 m.nirmaladevi@ltts.com, sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH v1 4/5] power: regulator: tps65941: use function callbacks
 for conversion ops
Date: Wed,  6 Mar 2024 19:04:29 +0530
Message-Id: <20240306133429.159907-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240223094156.qhzclrbnuiedbfg7@dhruva>
References: <20240223094156.qhzclrbnuiedbfg7@dhruva>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Fri, 23 Feb 2024 15:11:56 +0530, Dhruva Gole wrote:
> On Feb 23, 2024 at 14:42:11 +0530, Bhargav Raviprakash wrote:
> > Use function callbacks for volt2val, val2volt and slewrate lookups.
> > This makes it easier to add support for TPS65224 PMIC regulators.
> > 
> > Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> > ---
> >  drivers/power/regulator/tps65941_regulator.c | 61 +++++++++++++++-----
> >  1 file changed, 48 insertions(+), 13 deletions(-)
> 
> Add Tom Rini in To or CC please.
> 

Sure

> > 
> > diff --git a/drivers/power/regulator/tps65941_regulator.c b/drivers/power/regulator/tps65941_regulator.c
> > index cf54e30df5..cdfbc3f4de 100644
> > --- a/drivers/power/regulator/tps65941_regulator.c
> > +++ b/drivers/power/regulator/tps65941_regulator.c
> > @@ -35,6 +35,17 @@
> >  #define TPS65941_LDO_ID_3         3
> >  #define TPS65941_LDO_ID_4         4
> >  
> > +#define TPS65941_BUCK_CONV_OPS_IDX  0
> > +#define TPS65941_LDO_CONV_OPS_IDX   0
> > +
> > +struct tps65941_reg_conv_ops {
> > +	int volt_mask;
> > +	int (*volt2val)(int idx, int uV);
> > +	int (*val2volt)(int idx, int volt);
> > +	int slew_mask;
> > +	int (*lookup_slew)(int id);
> > +};
> > +
> >  static const char tps65941_buck_ctrl[TPS65941_BUCK_NUM] = {0x4, 0x6, 0x8, 0xA,
> >  								0xC};
> >  static const char tps65941_buck_vout[TPS65941_BUCK_NUM] = {0xE, 0x10, 0x12,
> > @@ -79,7 +90,7 @@ static int tps65941_buck_enable(struct udevice *dev, int op, bool *enable)
> >  	return 0;
> >  }
> >  
> > -static int tps65941_buck_volt2val(int uV)
> > +static int tps65941_buck_volt2val(int /*idx*/, int uV)
> 
> IMHO /*idx*/ does NOT look good.
> Check something like __maybe_unused attribute
> 
> [...]
> 
> -- 
> Best regards,
> Dhruva Gole <d-gole@ti.com>

Thanks for the feedback. Will use '__maybe_unused' in next version.

Regards,
Bhargav
