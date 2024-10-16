Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341B4D2069F
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 06:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8B4F88D56;
	Wed, 16 Oct 2024 08:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729059979;
	bh=SdwD+Ozsi5ME+gTJn3ZdBY/JNauYpOBLZMecruahUB4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=vy5hiNs7rR/zYafBf3A3Ui7Nnb36e6GX2KuxCpktCfUBDQ59A/qNxGh9/LXkk33f9
	 kuo7kfI7wwHOtLWbTMlHlzOBZiG4hiMCyuAJpk0CHZsYqUbBrEW7/GspDNySz0pMFG
	 cWs5CsZHPr93T8ZUuDVONSHNWq5IUOhYbqko0/uhCGGPVnUdreTAYKyLuWmG0UoimR
	 re8MQradtQ+CrvTX+fFqoQ473wMWSNR+iKj8bDSfcQ9DN3VFTpKDEDCIr5JBpjA9Xa
	 JI+8jXgSYLxtCpGUBLTy27js3SdiDnm5NCENZLgvPCV2tiwtNyT+A1/V+G6QJavxzQ
	 FZU4F3aXVPNzA==
Received: from [192.168.1.107] (87-97-107-160.pool.digikabel.hu
 [87.97.107.160])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C36C888C7E;
 Wed, 16 Oct 2024 08:26:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729059978;
 bh=SdwD+Ozsi5ME+gTJn3ZdBY/JNauYpOBLZMecruahUB4=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=TtQrwArCutxQDOjTqD7ofVXxksPn11Kd3/Y/a1NW2rifbTnjqxk6dzJH8CVLAKWOc
 tIushtqEHh1lwrKU/8cWu1OeXmwtTnyAvPwNqa6TwWHhhnvJP5Fvdgy1oSjjNYhHrP
 TnRu37cKZN+cnkOKU6mHl7KQ1yFvOKAzBwYLTpZU40Q00MkrPRQmuzpV4QWVHCSbhq
 NVRsOCk7V8BjC9sRxRxbavbnBpn6YvqdNr8jjNbP5CPB3SubFU/pWlh74THP6MeR0F
 mxCnU+tdQBeuXhqqQtdOD5eXwy7Xq6KXsK/jijB+tnIatVelH/oyNjCE66haeTiXSx
 QYbZ7oljt5PHg==
Message-ID: <43626d40-90cd-4e8a-a7fd-f6c659a6fac7@denx.de>
Date: Wed, 16 Oct 2024 08:24:07 +0200
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
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <PAXPR04MB845969EF200C1F0A6AF7976488462@PAXPR04MB8459.eurprd04.prod.outlook.com>
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

On 16.10.24 08:11, Peng Fan wrote:
> Hi Heiko,
> 
>> Subject: imx8qxp: deneb board fails with current HEAD
>>
>> Hello Peng,
>>
>> I just rebased my current work on siemens deneb board with current
>> master:
>>
>> * d5cab0d6ad - (HEAD -> master, origin/master, origin/WIP/15Oct2024,
>> origin/HEAD) Revert "Makefile:
>> Drop SPL_FIT_GENERATOR / SPL_FIT_SOURCE support" changes (vor 3
>> Stunden) <Tom Rini>
> 
> 
> My bad. I had a patch in my local, this should resolve the issue you met.

No problem!

>  From 3e5f8ad6cb93b9538852230d01c01b52d5c1c9d1 Mon Sep 17 00:00:00 2001
> From: Peng Fan <peng.fan@nxp.com>
> Date: Fri, 11 Oct 2024 19:57:49 +0800
> Subject: [PATCH] clk: imx8: Add dummy clk
> 
> There is a dummy clk entry for i.MX8QM/QXP, so add the dummy clk enable
> and get rate. Otherwise "__imx8_clk_enable(Invalid clk ID #0)".
> 
> Fixes: 76332fae769 ("mmc: fsl_esdhc_imx: Enable AHB/IPG clk with clk bulk API")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/clk/imx/clk-imx8qm.c  | 4 ++++
>   drivers/clk/imx/clk-imx8qxp.c | 4 ++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk-imx8qm.c b/drivers/clk/imx/clk-imx8qm.c
> index 62fed7e3e32..466d71786cf 100644
> --- a/drivers/clk/imx/clk-imx8qm.c
> +++ b/drivers/clk/imx/clk-imx8qm.c
> @@ -48,6 +48,8 @@ ulong imx8_clk_get_rate(struct clk *clk)
>          debug("%s(#%lu)\n", __func__, clk->id);
>   
>          switch (clk->id) {
> +       case IMX8QM_CLK_DUMMY:
> +               return 0;
>          case IMX8QM_A53_DIV:
>                  resource = SC_R_A53;
>                  pm_clk = SC_PM_CLK_CPU;
> @@ -264,6 +266,8 @@ int __imx8_clk_enable(struct clk *clk, bool enable)
>          debug("%s(#%lu)\n", __func__, clk->id);
>   
>          switch (clk->id) {
> +       case IMX8QM_CLK_DUMMY:
> +               return 0;
>          case IMX8QM_I2C0_IPG_CLK:
>          case IMX8QM_I2C0_CLK:
>          case IMX8QM_I2C0_DIV:
> diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
> index 18bdc08971b..79098623bc8 100644
> --- a/drivers/clk/imx/clk-imx8qxp.c
> +++ b/drivers/clk/imx/clk-imx8qxp.c
> @@ -51,6 +51,8 @@ ulong imx8_clk_get_rate(struct clk *clk)
>          debug("%s(#%lu)\n", __func__, clk->id);
>   
>          switch (clk->id) {
> +       case IMX8QXP_CLK_DUMMY:
> +               return 0;
>          case IMX8QXP_A35_DIV:
>                  resource = SC_R_A35;
>                  pm_clk = SC_PM_CLK_CPU;
> @@ -248,6 +250,8 @@ int __imx8_clk_enable(struct clk *clk, bool enable)
>          debug("%s(#%lu)\n", __func__, clk->id);
>   
>          switch (clk->id) {
> +       case IMX8QXP_CLK_DUMMY:
> +               return 0;
>          case IMX8QXP_I2C0_CLK:
>          case IMX8QXP_I2C0_IPG_CLK:
>                  resource = SC_R_I2C_0;
> 

Heh, yes, that what I thought after I had sended my EMail... but
wondering why we use a dummy here and not like it is in linux:

                 clocks = <&sdhc0_lpcg IMX_LPCG_CLK_4>,
                          <&sdhc0_lpcg IMX_LPCG_CLK_5>,
                          <&sdhc0_lpcg IMX_LPCG_CLK_0>;
                 clock-names = "ipg", "ahb", "per";

?

Do you plan to send this patch?

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
