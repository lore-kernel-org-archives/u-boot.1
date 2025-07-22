Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556C7C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 04:43:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9523A831E0;
	Tue, 22 Jul 2025 06:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ljtOPyXA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 485C083285; Tue, 22 Jul 2025 06:43:36 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6D4A82BA7
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 06:43:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56M4hInN1414051;
 Mon, 21 Jul 2025 23:43:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753159398;
 bh=wfEG678T1q4Pc7xsIMxZt8iujxYuyl7zSEh2Sx/w5Ng=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ljtOPyXAB6leic9eHBLBR9KfTFP32kjiSmv0oM86bHFHEcRXF+STTjh1IFrE5WG81
 mslLqUl3Pix9iXnM8KIMDtWeYFeNfawxPnaqzlkMnGK9nV7/DeNkyEGxAQiTNRttPp
 6bmBrz/XLpWAH4cE2kdVxQe2OiykaWzpfMphQhOg=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56M4hHX61845789
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 21 Jul 2025 23:43:18 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 21
 Jul 2025 23:43:17 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 21 Jul 2025 23:43:17 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56M4hDZx754711;
 Mon, 21 Jul 2025 23:43:14 -0500
Message-ID: <d15f3fef-247c-4f07-be57-dc36a5c09202@ti.com>
Date: Tue, 22 Jul 2025 10:13:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] imx: power-domain: Enable refcounting on imx8mp
To: Frieder Schrempf <frieder.schrempf@kontron.de>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, <u-boot@lists.denx.de>,
 Samuel Holland <samuel.holland@sifive.com>, Wadim Egorov
 <w.egorov@phytec.de>, Heiko Schocher <hs@denx.de>, Fabio Estevam
 <festevam@denx.de>
References: <20250425-ge-ian-display-support-v1-0-8a7a0fe75023@bootlin.com>
 <20250425-ge-ian-display-support-v1-2-8a7a0fe75023@bootlin.com>
 <0a2c9ba5-a0fa-4cd7-9e29-0874cf085f2c@kontron.de>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <0a2c9ba5-a0fa-4cd7-9e29-0874cf085f2c@kontron.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Frieder

On 21/07/25 21:31, Frieder Schrempf wrote:
> Hi Miquel,
> 
> Am 25.04.25 um 08:49 schrieb Miquel Raynal:
>> Prevent enabling/disabling multiple times the same power domain to avoid
>> breakages due to the same power domains being referenced several times
>> by different device nodes.
>>
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> I've stumbled upon some issue that seems to be related to this patch. I
> saw you already had to bother with other breakages of existing
> boards/platforms in the previous implementation. Unfortunately it looks
> like this still causes some kind of regression in my case.
> 
> I'm working with an i.MX8MM board (kontron-sl-mx8mm_defconfig) and I see
> a crash as soon as I do "usb start" and then "usb stop" (log for the
> latter see below).
> 
> As soon as I revert this patch everything starts to work fine again. Do
> you have any suggestions? The power-domains involved here are pgc_otg1
> and pgc_hsiomix defined in imx8mm.dtsi.
> 
> Thanks
> Frieder
> 
> 
> => usb stop
> stopping USB..
> Sending event 6/(unknown) to spy 'efi_disk del'
> Sending event 6/(unknown) to spy 'efi_disk del'
> Looking for power-domain@0
> Looking for power-domain@0
>       - checking gpc@303a0000
>       - checking power-domain@0
>    - result for power-domain@0: power-domain@0 (ret=0)
>    - result for power-domain@0: power-domain@0 (ret=0)
> "Synchronous Abort" handler, esr 0x96000005, far 0x4ebacdc50
> elr: 0000000040249c94 lr : 0000000040249c6c (reloc)
> elr: 00000000fff4ec94 lr : 00000000fff4ec6c
> x0 : 0000000000000001 x1 : 00000000fbf22750
> x2 : 00000003efbab500 x3 : 00000000fffcdfb0
> x4 : 0000000000000020 x5 : 0000000000000020
> x6 : 00000000fbeea10f x7 : 00000000fbeea3d7
> x8 : 00000000fffffffe x9 : 00000000fbeea1ec
> x10: 00000000fbeea280 x11: 00000000ffffffd8
> x12: 00000000fbeeb1b0 x13: 00000000fbeeb1b0
> x14: 0000000000000002 x15: 0000000000000000
> x16: 00000000fff4edc4 x17: 0000000000000000
> x18: 00000000fbef4db0 x19: 00000004ebacdc50
> x20: 00000000fbeeace8 x21: 00000000fbf21ad0
> x22: 0000000000000000 x23: 0000000000000001
> x24: 0000000000000000 x25: 00000000fbf28f10
> x26: 0000000000000000 x27: 00000000fbf2ad40
> x28: 00000000fbf2ada0 x29: 00000000fbeeac70
> 
> Code: f9400693 d37ef662 ab130833 54000140 (b8626820)
> Resetting CPU ...
> 
> 
>> ---
>>  drivers/power/domain/imx8m-power-domain.c | 4 ++++
>>  drivers/power/domain/imx8mp-hsiomix.c     | 4 ++++
>>  drivers/power/domain/imx8mp-mediamix.c    | 4 ++++
>>  3 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/domain/imx8m-power-domain.c
>> index e54ba5d9a5476f678fb48fb16e7217b031acd78a..b44aae78e6de9733e1e53bbec80f54562487a76b 100644
>> --- a/drivers/power/domain/imx8m-power-domain.c
>> +++ b/drivers/power/domain/imx8m-power-domain.c
>> @@ -506,8 +506,12 @@ static int imx8m_power_domain_bind(struct udevice *dev)
>>  static int imx8m_power_domain_probe(struct udevice *dev)
>>  {
>>  	struct imx8m_power_domain_plat *pdata = dev_get_plat(dev);
>> +	struct power_domain_plat *plat = dev_get_uclass_plat(dev);
>>  	int ret;
>>  
>> +	/* Every subdomain has its own device node */
>> +	plat->subdomains = 1;
>> +
>>  	/* Nothing to do for non-"power-domain" driver instances. */
>>  	if (!strstr(dev->name, "power-domain"))
>>  		return 0;
>> diff --git a/drivers/power/domain/imx8mp-hsiomix.c b/drivers/power/domain/imx8mp-hsiomix.c
>> index 455ad53ef525e18ae45068fa5d8c2be8a1b79335..1ca43880ef56a03ae10e70f7e260022acc447dbb 100644
>> --- a/drivers/power/domain/imx8mp-hsiomix.c
>> +++ b/drivers/power/domain/imx8mp-hsiomix.c
>> @@ -201,8 +201,12 @@ int imx8mp_hsiomix_bind(struct udevice *dev)
>>  static int imx8mp_hsiomix_probe(struct udevice *dev)
>>  {
>>  	struct imx8mp_hsiomix_priv *priv = dev_get_priv(dev);
>> +	struct power_domain_plat *plat = dev_get_uclass_plat(dev);
>>  	int ret;
>>  
>> +	/* Definitions are in imx8mp-power.h */
>> +	plat->subdomains = 5;


Enabling LOG_DEBUG on drivers/power/domain/power-domain-uclass.c may
help further

Looks like setting of plat->subdomains needs updation? PD of HSIOMIX is
17 (plat->subdomains is 5?)

Looking at the numerous imx* devicetrees; plat->subdomains looks to be
very different across each platform so hardcoding it in the probe of the
power driver may not be a good idea I think?

>> +
>>  	priv->base = dev_read_addr_ptr(dev);
>>  
>>  	ret = clk_get_by_name(dev, "usb", &priv->clk_usb);
>> diff --git a/drivers/power/domain/imx8mp-mediamix.c b/drivers/power/domain/imx8mp-mediamix.c
>> index 78c32ca3d3a87febdefd5d128d39d817674b8d32..504c22f7d3631363d76eb21e43afd854258d4ea5 100644
>> --- a/drivers/power/domain/imx8mp-mediamix.c
>> +++ b/drivers/power/domain/imx8mp-mediamix.c
>> @@ -143,9 +143,13 @@ static int imx8mp_mediamix_bind(struct udevice *dev)
>>  
>>  static int imx8mp_mediamix_probe(struct udevice *dev)
>>  {
>> +	struct power_domain_plat *plat = dev_get_uclass_plat(dev);
>>  	struct imx8mp_mediamix_priv *priv = dev_get_priv(dev);
>>  	int ret;
>>  
>> +	/* Definitions are in imx8mp-power.h */
>> +	plat->subdomains = 9;
>> +
>>  	priv->base = dev_read_addr_ptr(dev);
>>  
>>  	ret = clk_get_by_name(dev, "apb", &priv->clk_apb);
>>
> 

-- 
Thanking You
Neha Malcom Francis
