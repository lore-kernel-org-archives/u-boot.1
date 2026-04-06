Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09872FB5178
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 23:26:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2A1B840AB;
	Tue,  7 Apr 2026 01:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="gWtuWWLF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3BE183EC6; Tue,  7 Apr 2026 00:59:04 +0200 (CEST)
Received: from mxd-3-715.seznam.cz (mxd-3-715.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:715])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 891428352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 00:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Michael.Srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-7644845457-lgzgl
 (smtpc-mxd-7644845457-lgzgl [2a02:598:96:8a00::1200:715])
 id 764c64162d42307f77e5a848; Tue, 07 Apr 2026 00:58:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1775516309; bh=3QEHYkepJY02VOU4+3mCsIzwJ5f6I+RHWWybrsaMJiM=;
 h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 Content-Language:From:Content-Type:Content-Transfer-Encoding;
 b=gWtuWWLFGW8uSa88eIpwAfyiY+tvJ/xa7dNs/f60madpD+FYFl6ObQLupEwdWt+cv
 vAbh3kMTBVR/CKbwGDB3a4iZ2vwMalZGcojnnlNbMhTmAbR8Onjwn7rhKWmudETY+9
 Ec3BbO3TRLNlMubJo6MnUIINfr7gp98C5vkt1wRZcMB53Y9XSYABqQP+uRuW268j/c
 nphAuqGOEgMT8rjQH4foXvf30XbJe4gAh7FQy3iIApuL8oI+aWBkelzUf0ALMdgQjc
 UuhZjBn6SeID1GwEN4XtVODXDsIU0zNoirvxN7jFjxK1bhvpg4toTkHT8wzLJmLOIU
 ObSzOwieJw0Tg==
Received: from [192.168.0.240] (ip-111-27.static.ccinternet.cz
 [147.161.27.111])
 by smtpd-relay-789d8dfb5c-8rrnf (szn-email-smtpd/2.0.71) with ESMTPA
 id feb8c3df-61cd-4df0-80d0-a3bcb9e87d95;
 Tue, 07 Apr 2026 00:57:35 +0200
Message-ID: <555cd716-ff3b-420e-beba-f0aa82b235e7@seznam.cz>
Date: Tue, 7 Apr 2026 00:57:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] of_live: support in SPL
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Heiko Schocher
 <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
References: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
 <20260404-qcom_spl-v1-2-9e6c2ac66587@seznam.cz>
 <CAFLszTjTU_RMf6hh97+mTgxDMN97Z86XR+gFDyZadX5vq4qdnQ@mail.gmail.com>
Content-Language: en-US
From: Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <CAFLszTjTU_RMf6hh97+mTgxDMN97Z86XR+gFDyZadX5vq4qdnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 07 Apr 2026 01:26:10 +0200
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



On 4/6/26 17:51, Simon Glass wrote:
> Hi Michael,
>
> On 2026-04-03T23:18:18, Michael Srba <michael.srba@seznam.cz> wrote:
>> of_live: support in SPL
>>
>> Add CONFIG_SPL_OF_LIVE and if set, initialize of_live in spl.c
>>
>> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>> diff --git a/dts/Kconfig b/dts/Kconfig
>> @@ -86,6 +86,11 @@ config OF_LIVE
>> +config SPL_OF_LIVE
>> +     bool "Enable use of a live tree in SPL"
>> +     depends on SPL_DM && SPL_OF_CONTROL
>> +
>> +
> Please can you add help text here? The main OF_LIVE option has a
> helpful explanation. Also there should only be one blank line after
> the entry.
>
It seems some SPL options just refer to the full option and some copy
the explanation, my worry with the latter is that it will most definitely not
stay in sync, but I'm happy to go with either approach.
>> diff --git a/common/spl/spl.c b/common/spl/spl.c
>> @@ -510,6 +511,15 @@ static int spl_common_init(bool setup_malloc)
>> +     if (CONFIG_IS_ENABLED(OF_LIVE)) {
>> +             ret = of_live_build(gd->fdt_blob,
>> +                                 (struct device_node **)gd_of_root_ptr());
>> +             if (ret) {
>> +                     debug("of_live_build() returned error %d\n", ret);
>> +                     return ret;
>> +             }
>> +     }
> The U-Boot proper code in initr_of_live() wraps of_live_build() with
> bootstage_start()/bootstage_accum() using BOOTSTAGE_ID_ACCUM_OF_LIVE.
> Please can you do the same here for consistency and SPL boot-time
> tracking.
I wasn't sure if SPL supported that, probably should've tried harder to check.
will fix.
> Regards,
> Simon

