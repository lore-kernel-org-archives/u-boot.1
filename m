Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD31E88D82
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 05:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4131584150;
	Sat,  4 Apr 2026 07:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="h22NDijQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61D538407E; Sat,  4 Apr 2026 07:09:54 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83DFE8407E
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 07:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fnkDG5Fhwz9tnJ;
 Sat,  4 Apr 2026 07:09:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775279390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Hu/TjDPf87o26yaiqfVLWUmVUSBzYBEye82XsQZhIo=;
 b=h22NDijQtXXCfKsjHNw1FUXEZw8n0Ed2mBjKKqcU/0pfI37nlpw7ttdL8reuKRAB4Vabcj
 /uHB7gO6q4yDbuwjRuaYW1N2NZN4NDwubutWeN3eDZ71cWkpWCDZSvDbv586U9/6Kom3b9
 U73m66eQruhOsijSsyQO2dBU7+8+IlLpgmD6c9TDb7quCBPw6nk7aFkbVqwV65cRyIidSQ
 gBMOP5Lvfjcc95tFXHxh00Xa4j1JLmiv3Jo5yqJKz1Rv3XB8G9xrIJJJ3xWWOfWFUqk+NW
 MpvsRXwnYXrMmGFMIjYmTbd+IbpBoWX+/AuEEl1t+WKSUq60nslSQLKxyG8G2w==
Message-ID: <bbaedc24-3d77-4b5d-82d7-bdce82974d3b@mailbox.org>
Date: Sat, 4 Apr 2026 01:23:33 +0200
MIME-Version: 1.0
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH v3 4/6] board: nxp: imx9{4,5,52}_evk: Add qb save option
 in SPL
To: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>, uboot-imx@nxp.com,
 u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com,
 peng.fan@nxp.com, alice.guo@nxp.com, viorel.suman@nxp.com,
 simona.toaca@nxp.com, ye.li@nxp.com, ping.bai@nxp.com,
 sebastien.szymanski@armadeus.com, ravi@prevas.dk,
 joao.goncalves@toradex.com, ji.luo@nxp.com, semen.protsenko@linaro.org,
 tharvey@gateworks.com, qijian.guo@nxp.com
References: <cover.1775121078.git.simona.toaca@nxp.com>
 <a67c5f278a0824723d448fcf230dde2f93c6dda8.1775121078.git.simona.toaca@nxp.com>
Content-Language: en-US
In-Reply-To: <a67c5f278a0824723d448fcf230dde2f93c6dda8.1775121078.git.simona.toaca@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: qexhsk97tzxcpkwqae5cn76c5ygrzf7j
X-MBO-RS-ID: 66976cd776ecac2056e
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

On 4/2/26 11:40 AM, Simona Toaca (OSS) wrote:

[...]

> +++ b/arch/arm/mach-imx/Kconfig
> @@ -71,6 +71,14 @@ config CSF_SIZE
>   	  Define the maximum size for Command Sequence File (CSF) binary
>   	  this information is used to define the image boot data.
>   
> +config SPL_IMX_QB
> +	bool "Run qb save during SPL"
> +	depends on SPL && (IMX94 || IMX95 || IMX952)
> +	help
> +	  Automatically save DDR training data (Quickboot data)
> +	  to current boot device when needed (when OEI runs Training
> +	  flow and saves qb data to volatile memory).
> +
>   config CMD_IMX_QB
>   	bool "Support the 'qb' command"
>   	default y
> diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
> index 3e323a714c1..8b01897b928 100644
> --- a/arch/arm/mach-imx/imx9/Makefile
> +++ b/arch/arm/mach-imx/imx9/Makefile
> @@ -14,6 +14,8 @@ ifneq ($(CONFIG_SPL_BUILD),y)
>   obj-y += imx_bootaux.o
>   endif
>   
> -ifneq ($(CONFIG_XPL_BUILD),y)
> +ifeq ($(CONFIG_XPL_BUILD),y)
> +obj-$(CONFIG_SPL_IMX_QB) += qb.o
> +else
>   obj-$(CONFIG_CMD_IMX_QB) += qb.o
>   endif

The qb.o should not be gated beyond CONFIG_CMD_IMX_QB , the 
CONFIG_CMD_IMX_QB is used to gate cmd_qb.o . Fix this and introduce 
CONFIG_IMX_QB to gate the core code, then do this to simplify the 
conditional:

obj-$(CONFIG_$(PHASE_)IMX_QB += qb.o

...

Also, changes to arch/ should be part of 1/6 .
