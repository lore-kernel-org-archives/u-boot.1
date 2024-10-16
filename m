Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8561D206A0
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 06:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A03888C98;
	Wed, 16 Oct 2024 08:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729060935;
	bh=2cdgMwaZzqW9+HRQM/sa6yAHsbFhzwAKywCtkyID2Cc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=MXC82CwjsGAfNkSDtHAaTWRuMRx+pmJg+qoTLJr5EwjRC/wKlBKioiDQcaB+soxME
	 Nt2+dogrXVDIG+x9kS2b2mvoM2RS9pG6f/HDkl6nrbMfmo9j/oHwXP/th1AVwUH+0Z
	 wpGSPt6oO/z/VbsYOSgyRCmxeLV0sM5SW8icktHHjpvxVzwAyC8W3o6UJ76/5/fuX8
	 otfhaKtLbHGBOsDP0FVEcmAEBunMFhApLA0Mi9XdPBIHKCA7xqfxwLWeQd5TF9OSi7
	 7P0UvG5/vffh9bTSWkotmiQeoG46NkFXwrQCwPhDgR39lCOAV5UXjIO2RhIJhVthDe
	 V+fleSqui+4ww==
Received: from [192.168.1.107] (87-97-107-160.pool.digikabel.hu
 [87.97.107.160])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1BC4188C7C;
 Wed, 16 Oct 2024 08:42:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729060934;
 bh=2cdgMwaZzqW9+HRQM/sa6yAHsbFhzwAKywCtkyID2Cc=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=qhL0JNCjLzXsNiLf9k0sHLBd0FPL7YTEx2UrQYpD05dQaHGTY4PpNNYiofYcp+qad
 b4Bux6HAnNYzjTc5FshSkjzV0/VfacnS1S5v5tFSvdyqC0c/Y6fAFEsoAzfYS66Aq3
 g8JNL8OY3NALE22L/CiGWxAhb/UgqIY48hVtipwVK60iOXc2MdzsqXtusHnQ1hSFN3
 /6/KnQ1XToiVuu3/0uwzmW7TDxVvb/EPJh+8pELKGB55f5EfDsRkRiPvd0vMbAKi9W
 GunR4kz3OLqNcubkMNBHZH4v3DgQoeck3V+JxIEjDtm/XZx3UX7NX0TYC+f6By27+f
 zfhgOyV4Ddegg==
Message-ID: <a1e87efa-36aa-38e8-c1e5-eedf53ff3f10@denx.de>
Date: Wed, 16 Oct 2024 08:40:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: imx8qxp: deneb board fails with current HEAD
Content-Language: en-US
To: Peng Fan <peng.fan@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Leto, Enrico (BT CPS R&D ZG FW CCP)" <enrico.leto@siemens.com>
References: <67ebc675-d681-3b63-b642-f32f5e6a6b38@denx.de>
 <PAXPR04MB845969EF200C1F0A6AF7976488462@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <43626d40-90cd-4e8a-a7fd-f6c659a6fac7@denx.de>
 <PAXPR04MB8459AA14EEBD7F061BC37B1188462@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <PAXPR04MB8459AA14EEBD7F061BC37B1188462@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Peng,

On 16.10.24 08:33, Peng Fan wrote:
>> Subject: Re: imx8qxp: deneb board fails with current HEAD
>>
>> Hello Peng,
>>
>> On 16.10.24 08:11, Peng Fan wrote:
>>> Hi Heiko,
>>>
>>>> Subject: imx8qxp: deneb board fails with current HEAD
>>>>
>>>> Hello Peng,
>>>>
>>>> I just rebased my current work on siemens deneb board with current
>>>> master:
>>>>
>>>> * d5cab0d6ad - (HEAD -> master, origin/master,
>> origin/WIP/15Oct2024,
>>>> origin/HEAD) Revert "Makefile:
>>>> Drop SPL_FIT_GENERATOR / SPL_FIT_SOURCE support" changes (vor
>> 3
>>>> Stunden) <Tom Rini>
>>>
>>>
>>> My bad. I had a patch in my local, this should resolve the issue you
>> met.
>>
>> No problem!
>>
>>>   From 3e5f8ad6cb93b9538852230d01c01b52d5c1c9d1 Mon Sep 17
>> 00:00:00
>>> 2001
>>> From: Peng Fan <peng.fan@nxp.com>
>>> Date: Fri, 11 Oct 2024 19:57:49 +0800
>>> Subject: [PATCH] clk: imx8: Add dummy clk
>>>
>>> There is a dummy clk entry for i.MX8QM/QXP, so add the dummy clk
>>> enable and get rate. Otherwise "__imx8_clk_enable(Invalid clk ID #0)".
>>>
>>> Fixes: 76332fae769 ("mmc: fsl_esdhc_imx: Enable AHB/IPG clk with
>> clk
>>> bulk API")
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>    drivers/clk/imx/clk-imx8qm.c  | 4 ++++
>>>    drivers/clk/imx/clk-imx8qxp.c | 4 ++++
>>>    2 files changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/clk/imx/clk-imx8qm.c
>>> b/drivers/clk/imx/clk-imx8qm.c index 62fed7e3e32..466d71786cf
>> 100644
>>> --- a/drivers/clk/imx/clk-imx8qm.c
>>> +++ b/drivers/clk/imx/clk-imx8qm.c
>>> @@ -48,6 +48,8 @@ ulong imx8_clk_get_rate(struct clk *clk)
>>>           debug("%s(#%lu)\n", __func__, clk->id);
>>>
>>>           switch (clk->id) {
>>> +       case IMX8QM_CLK_DUMMY:
>>> +               return 0;
>>>           case IMX8QM_A53_DIV:
>>>                   resource = SC_R_A53;
>>>                   pm_clk = SC_PM_CLK_CPU; @@ -264,6 +266,8 @@ int
>>> __imx8_clk_enable(struct clk *clk, bool enable)
>>>           debug("%s(#%lu)\n", __func__, clk->id);
>>>
>>>           switch (clk->id) {
>>> +       case IMX8QM_CLK_DUMMY:
>>> +               return 0;
>>>           case IMX8QM_I2C0_IPG_CLK:
>>>           case IMX8QM_I2C0_CLK:
>>>           case IMX8QM_I2C0_DIV:
>>> diff --git a/drivers/clk/imx/clk-imx8qxp.c
>>> b/drivers/clk/imx/clk-imx8qxp.c index 18bdc08971b..79098623bc8
>> 100644
>>> --- a/drivers/clk/imx/clk-imx8qxp.c
>>> +++ b/drivers/clk/imx/clk-imx8qxp.c
>>> @@ -51,6 +51,8 @@ ulong imx8_clk_get_rate(struct clk *clk)
>>>           debug("%s(#%lu)\n", __func__, clk->id);
>>>
>>>           switch (clk->id) {
>>> +       case IMX8QXP_CLK_DUMMY:
>>> +               return 0;
>>>           case IMX8QXP_A35_DIV:
>>>                   resource = SC_R_A35;
>>>                   pm_clk = SC_PM_CLK_CPU; @@ -248,6 +250,8 @@ int
>>> __imx8_clk_enable(struct clk *clk, bool enable)
>>>           debug("%s(#%lu)\n", __func__, clk->id);
>>>
>>>           switch (clk->id) {
>>> +       case IMX8QXP_CLK_DUMMY:
>>> +               return 0;
>>>           case IMX8QXP_I2C0_CLK:
>>>           case IMX8QXP_I2C0_IPG_CLK:
>>>                   resource = SC_R_I2C_0;
>>>
>>
>> Heh, yes, that what I thought after I had sended my EMail... but
>> wondering why we use a dummy here and not like it is in linux:
>>
>>                   clocks = <&sdhc0_lpcg IMX_LPCG_CLK_4>,
>>                            <&sdhc0_lpcg IMX_LPCG_CLK_5>,
>>                            <&sdhc0_lpcg IMX_LPCG_CLK_0>;
>>                   clock-names = "ipg", "ahb", "per";
>>
>> ?
> 
> The current U-Boot support for i.MX8 not reuse the device
> tree from kernel. The device tree diverges.

Yes, I know...

>> Do you plan to send this patch?
> 
> You mean "[PATCH] clk: imx8: Add dummy clk"?

Yes.

> I could post it out. But If you wanna to add more
> stuff, feel free to take it over and do that.

Please post it, thanks! You can add my

Reviewed-by: Heiko Schocher <hs@denx.de>

When posted, I will test it.

> I not have plan to sync the DTB for i.MX8.

bye,
Heiko
> 
> Regards,
> Peng.
> 
>>
>> bye,
>> Heiko
>> --
>> DENX Software Engineering GmbH,      Managing Director: Erika Unter
>> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
>> Germany
>> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email:
>> hs@denx.de

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
