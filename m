Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEF9C54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 22:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00E6E88020;
	Mon, 18 Mar 2024 23:38:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710801482;
	bh=vjFF/bnnk4O3I/SgIvTqhRhnNAmk9wJESsmLnf+b/aA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q3rFYW38F1tcTWV2nMAo8FWTXG5bkScvsZ/XXK1mXhqADv3Pt/kmy00ekOuEJWv3M
	 QXJFE4Le7/xOOTKqT/aVPKotHOGWdy5vwPJ5GEsWx9ijq98MYknJcJsHh3INwSjrAg
	 f04dTJOmb7Sef5do4SUEewXvMz92Lps3e6Qz6TAIfDc+9+5RwlB8RZzyKyeLQ2MUeB
	 k9W7bnOfcEBuPP0mS7c0lqX9zvwPhY4z/fYSaR0UEzkfrFSzg/3c8wodTL4EdX775s
	 oV8wqFznBG69mvZ+Jm5zGUza2VUrTzJ2hLxEr61oP7xXazn4ZiNqdu6eTbKha/VpL/
	 H8SwZ7Mkg8tYQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0FFAD87861;
 Mon, 18 Mar 2024 23:37:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710801477;
 bh=vjFF/bnnk4O3I/SgIvTqhRhnNAmk9wJESsmLnf+b/aA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YgOFx2VUA2CHF6Ki1LoIsv6X6UZat0ynt1sRO21dz83YW67JmKVWcO0/U8JbCo8Kd
 GANGXYS9I/nw/FMxFLQEU4DRxMClbEpzpyMf6Mm+uhLA/pTyAeQ1ESUhSGynD3Mw6y
 a1Pl9JYCfbP9egQMLDzMfNt/5E8TZTl8T9uk1sPkwY3I3Sh6MTGjFCQUeB5czfQq+k
 qjXvgHhblAMH7FmUsGnEu0yDECr8mJgYWf0NcxQa53LieyciC/vVSscmx4DOTm0Cna
 cmpQrZAcmszVzcBcIiJ8rf4Q2oVFvMD+bB8gzB14dsjzvxWeUPhgho1h8cg1WH/iPA
 g6WTGxjMd3Oiw==
Message-ID: <436b910c-2aeb-4c18-90ac-cb3d8fe37dca@denx.de>
Date: Mon, 18 Mar 2024 23:23:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: imx7 issues with Secure and Non-Secure boot mode
Content-Language: en-US
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Breno Matheus Lima <brenomatheus@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>
Cc: Tobias Junghans <tobias.junghans@veyon.io>, igor.opaniuk@gmail.com,
 Francesco Dolcini <francesco.dolcini@toradex.com>
References: <4b64a9de-a840-4065-a530-f81155b4b9f2@toradex.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <4b64a9de-a840-4065-a530-f81155b4b9f2@toradex.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 3/7/24 10:26 AM, Emanuele Ghidoli wrote:
> Hello,
> 
> I'm currently facing issues with our board, Colibri-imx7,
> regarding its behavior in different boot modes:
> 
> - Secure Mode (bootm_boot_mode=sec in U-Boot):
>    When running Linux in secure mode, the idle time management does not function
>    properly. The following error message is displayed during boot:
>    "CPUidle arm: CPU 0 failed to init idle CPU ops".
> 
> - Non-Secure Mode (bootm_boot_mode=nonsec in U-Boot):
>    In non-secure mode, the caam_jr fails to initialize correctly,
>    preventing the utilization of the hardware random number generation.
>    The error message shown during boot is:
>    "caam_jr 30901000.jr: failed to flush job ring before reset".
> 
> I have conducted tests using both mainline and 6.1 stable versions,
> with consistent results.
> 
> I have also reviewed the following threads for potential solutions:
> 
>   - https://lore.kernel.org/u-boot/2536787.mZni4QDSI2@crypto/
>   - https://lore.kernel.org/u-boot/CAByghJZn8d91uFr5JXSR=jXcfU4engZP_=buOk7MNNjaVeigLA@mail.gmail.com/
>   - https://lore.kernel.org/all/20220608170223.1536594-1-festevam@denx.de/T/
> 
> The first thread leave me thinking the only solution is to use OPTEE,
> but the last email is without any answer.
> So, I am considering the utilization of OPTEE, as it seems it might address
> the issues discussed in the threads.
> Could this configuration potentially resolve my current issues?
> 
> Your advice would be greatly appreciated.

Have a look at U-Boot

1f908b1898bd ("ARM: imx8m: Deduplicate CAAM init with arch_misc_init() 
call")

Do you call this CAAM initialization on your machine ?

If not, try it, does it have any impact ?
