Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3036CA0EC3
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 12:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24CB186E95;
	Tue, 12 Sep 2023 14:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cq+Q2c+/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E15A386E9C; Tue, 12 Sep 2023 14:31:28 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2459586E71
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 14:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38CCVGfa127070;
 Tue, 12 Sep 2023 07:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694521876;
 bh=X6fftMeBOAxzmSqpCLNpuLIqh2YQSdh5tb9tp03MkF8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=cq+Q2c+/v45breWqS60s/ZPf8cvu5nM8pTiO3vFtUf7EXQp3FSGfRHoJYLw2mGkpU
 EG7X8CI6pKEKwQC/5Zr0mOtNg3NABB7L0ORc1J2O9h/48blpZVRvMrLJVG8l4pgCBL
 xr+BKJD97ydmcj7GBDXJhPWhjsbdseolX00F8Fnk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38CCVGYF025789
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Sep 2023 07:31:16 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Sep 2023 07:31:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Sep 2023 07:31:16 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38CCVGkt039205;
 Tue, 12 Sep 2023 07:31:16 -0500
Date: Tue, 12 Sep 2023 07:31:16 -0500
From: Nishanth Menon <nm@ti.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
CC: "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "ralph.siemsen@linaro.org" <ralph.siemsen@linaro.org>, "j-kacines@ti.com"
 <j-kacines@ti.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "n-francis@ti.com" <n-francis@ti.com>,
 "kamlesh@ti.com" <kamlesh@ti.com>, "afd@ti.com" <afd@ti.com>,
 "a-nandan@ti.com" <a-nandan@ti.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>,
 "lukma@denx.de" <lukma@denx.de>, "hnagalla@ti.com" <hnagalla@ti.com>,
 "a-bhatia1@ti.com" <a-bhatia1@ti.com>,
 "m-chawdhry@ti.com" <m-chawdhry@ti.com>, "j-choudhary@ti.com"
 <j-choudhary@ti.com>, "yanhong.wang@starfivetech.com"
 <yanhong.wang@starfivetech.com>, "christian.gmeiner@gmail.com"
 <christian.gmeiner@gmail.com>, "marek.vasut+renesas@mailbox.org"
 <marek.vasut+renesas@mailbox.org>, "rasmus.villemoes@prevas.dk"
 <rasmus.villemoes@prevas.dk>, "sabiya.d@ti.com" <sabiya.d@ti.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "xypron.glpk@gmx.de"
 <xypron.glpk@gmx.de>, "bb@ti.com" <bb@ti.com>, "rogerq@kernel.org"
 <rogerq@kernel.org>
Subject: Re: [PATCH v3 03/16] soc: ti: k3-socinfo: Add entry for J784S4 SoC
Message-ID: <20230912123116.quvwo57zojggxnzy@praising>
References: <20230908110551.861575-1-a-nandan@ti.com>
 <20230908110551.861575-4-a-nandan@ti.com>
 <7c117f6e95dc006ab1c2940f927d5ef90a494413.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c117f6e95dc006ab1c2940f927d5ef90a494413.camel@toradex.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 11:21-20230912, Marcel Ziswiler wrote:
> On Fri, 2023-09-08 at 16:35 +0530, Apurva Nandan wrote:
> > Add support for J784S4 SoC Identification.
> > 
> > Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> > Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> > ---
> >  arch/arm/mach-k3/include/mach/hardware.h | 1 +
> >  drivers/soc/soc_ti_k3.c                  | 3 +++
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
> > index 03b18f6bad..bada87d0b2 100644
> > --- a/arch/arm/mach-k3/include/mach/hardware.h
> > +++ b/arch/arm/mach-k3/include/mach/hardware.h
> > @@ -50,6 +50,7 @@
> >  #define JTAG_ID_PARTNO_J721S2  0xbb75
> >  #define JTAG_ID_PARTNO_AM62X   0xbb7e
> >  #define JTAG_ID_PARTNO_AM62AX   0xbb8d
> > +#define JTAG_ID_PARTNO_J784S4  0xbb80
> 
> Not sure whether it would be smarter to sort this based on the JTAG ID or the name of the define like you did.

The order followed at the moment is introduction order, which is not
proper.

Alpha sort on name is better.. but the file already does'nt follow the
same.. I suggest doing an alpha sort of the macro based on names as a cleanup patch
prior to introducing.

> 
> >  #define K3_SOC_ID(id, ID) \
> >  static inline bool soc_is_##id(void) \
> > diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
> > index b720131ae5..6f7fcf9e11 100644
> > --- a/drivers/soc/soc_ti_k3.c
> > +++ b/drivers/soc/soc_ti_k3.c
> > @@ -45,6 +45,9 @@ static const char *get_family_string(u32 idreg)
> >         case JTAG_ID_PARTNO_AM62AX:
> >                 family = "AM62AX";
> >                 break;
> > +       case JTAG_ID_PARTNO_J784S4:
> > +               family = "J784S4";
> > +               break;
> >         default:
> >                 family = "Unknown Silicon";
> >         };

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
