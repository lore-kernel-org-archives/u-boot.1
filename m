Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EFCFD874A
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 11:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 080618423E;
	Tue, 17 Mar 2026 12:56:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="RNK4PsOL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A329D84056; Tue, 17 Mar 2026 06:07:10 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A32568401A
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 06:07:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7007410D7AE; Tue, 17 Mar 2026 06:07:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1773724028;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=eAlHmXoVszqrFVjsf5VS/rcMXsF1MAkgfBH72KB2ETA=;
 b=RNK4PsOLP7dhyB+S49opXHP9S/6AFCyCYKHmUPZiQanGJd0+ay2pQEF5Y9BkTPZh5OTFFD
 ZZ2dv00+6SRXgRBSIxCk/xtmDlZxTRXIWH8te8Zld7a2Az61niWTodRvAE4thr1qbZzu05
 /dgxpQaZeJzBSBa6qJgXy5iUoLdXZNdZaSZOjceLdx4Htm94WlY1tH/korHQGtqWU0o5so
 mhxmQY3oExCKiu/NrZldS/Rpdvg5WYpkfxT5h1ZxAOegEL4RVhhkYj7t7BWh61YOfwm9aa
 l0xrSKe2Gffzk1SOT23hv0XRJtjYBRR4j2nMKWsAa5T7FOkuyLAKUg6BLfS3mA==
Message-ID: <d3b42af1-65a8-401f-9dda-1f79cb0dde9a@nabladev.com>
Date: Mon, 16 Mar 2026 13:32:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] doc: board: nxp: Add Quickboot documentation
To: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>, uboot-imx@nxp.com,
 u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com,
 peng.fan@nxp.com, alice.guo@nxp.com, simona.toaca@nxp.com, ye.li@nxp.com,
 viorel.suman@nxp.com, ping.bai@nxp.com, sebastien.szymanski@armadeus.com,
 ravi@prevas.dk, joao.goncalves@toradex.com, ji.luo@nxp.com,
 tharvey@gateworks.com, qijian.guo@nxp.com
References: <cover.1773648510.git.simona.toaca@nxp.com>
 <be6b07edb38e4e0dc86e65f8bac7b6b3b0e29d01.1773648510.git.simona.toaca@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <be6b07edb38e4e0dc86e65f8bac7b6b3b0e29d01.1773648510.git.simona.toaca@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 17 Mar 2026 12:56:37 +0100
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

On 3/16/26 9:15 AM, Simona Toaca (OSS) wrote:

> +After successful saving, U-Boot clears the data in volatile memory so
> +that qb check fails at next reboot and the NVM isn't accessed again.
> +
> +There are 2 ways to save this data (both can be enabled):

Replace () with , .

> +1. automatically, in SPL (by enabling CONFIG_SPL_IMX_QB)
> +
> +- this will save the data on the current boot device (e.g. SD)
> +- other configs specific to the boot device need to be enabled (CONFIG_SPL_MMC_WRITE for saving to eMMC/SD)
> +- use for: automating qb save / saving qb data if using Falcon mode (skipping U-Boot proper)
> +
> +2. using qb command in U-Boot console (by enabling CONFIG_CMD_IMX_QB)
> +
> +- supports saving on the current boot device, or on another, specified device.
> +- if flashing via uuu, the command can be added in an uuu script (boot device needs to be specified)
> +- use for: saving the qb data during flashing / controlling the NVM to save to
> +
> +::
> +
> +        # To save/erase on current boot device
> +        => qb save/erase
> +
> +        # To save/erase on other boot device
> +        => qb save/erase mmc 0 # eMMC
> +        => qb save/erase mmc 1 # SD
> +        => qb save/erase spi   # NOR SPI

Can QB data be saved to arbitrary SPI NOR ?

Looking at this, why can this QB not use the same interface to select 
arbitrary block storage device/partition/... that e.g. FS_GENERIC does use ?
