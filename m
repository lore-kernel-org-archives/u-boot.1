Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72821C35FFC
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 23:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4228E81DB4;
	Sun, 23 Mar 2025 00:31:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZacTaQ+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C161D81DB4; Sun, 23 Mar 2025 00:31:20 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C379980C93
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 00:31:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZKwYc4vVSz9sZv;
 Sun, 23 Mar 2025 00:31:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742686276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OCvTs1nyxVHs/z/1kaIyvM771X19N/N2ZZ5dBTD11RA=;
 b=ZacTaQ+9daXPAaG5uXS94Czwtw5b3kgDlCdMp/Zl5hcQFux+ED0qVU3VGEkiXBMgvyqYiR
 UHxn7xh56YwgrX4LJ/d0LoVEdz3C0mP5j9updLx1GNOELvZ3eWFlmQ4zbG/r/FxeREPOq+
 CwNEf91JZTrZgSrHQNfdsBYJD9frRGfeXL6pP3znx+7kuJeHvDqhSJWiJG8MA5+2GnUnHE
 tLSEKDMHhxJLSehUkuWTQTpPdicu6/UN/OFTKd9GROQ/92TmGFSTLUDjT1wt439QNKbqGS
 5iOUx8S88x1xYObCd8TSDdZzy0STTboUhchULHLwYbCttJf07immnxACK6BkXQ==
Message-ID: <c6dbb067-c3f1-4c0e-89b9-37de7dc28968@mailbox.org>
Date: Sun, 23 Mar 2025 00:30:32 +0100
MIME-Version: 1.0
Subject: Re: [PATCH V3 4/6] imx: imx8m: Imply CPU_IMX by default
To: Adam Ford <aford173@gmail.com>, u-boot@lists.denx.de
Cc: aford@beaconembedded.com, festevam@gmail.com,
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Enrico Leto <enrico.leto@siemens.com>, Peng Fan <peng.fan@nxp.com>,
 Yannic Moog <y.moog@phytec.de>, Sumit Garg <sumit.garg@kernel.org>,
 Gilles Talis <gilles.talis@gmail.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Ye Li <ye.li@nxp.com>, Wadim Egorov <w.egorov@phytec.de>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20250322183812.784676-1-aford173@gmail.com>
 <20250322183812.784676-5-aford173@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250322183812.784676-5-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 3b4yxbp3cdq4cd8anezty3ctm1nasqbr
X-MBO-RS-ID: 64f44e87e7e59f4bf3f
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

On 3/22/25 7:38 PM, Adam Ford wrote:
> The imx8_cpu driver is a CPU Driver that supports the i.MX8M
> family, and when it is enabled, it acts as an alternative to
> arch/arm/mach-imx/cpu.c, but the imx8_cpu supports the driver
> model where cpu.c does not.  Imply this newer driver by default.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>   arch/arm/mach-imx/imx8m/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
> index 8ee699a343c..988495d217a 100644
> --- a/arch/arm/mach-imx/imx8m/Kconfig
> +++ b/arch/arm/mach-imx/imx8m/Kconfig
> @@ -9,6 +9,8 @@ config IMX8M
>   	select ROM_UNIFIED_SECTIONS
>   	select ARMV8_CRYPTO
>   	imply IMX_TMU
> +	imply CPU
> +	imply CPU_IMX

Keep the list sorted .
