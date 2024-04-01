Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46859CD1288
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 20:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC16788324;
	Mon,  1 Apr 2024 22:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="A07yiIN/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49326882DC; Mon,  1 Apr 2024 12:07:56 +0200 (CEST)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8983288011
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 12:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cgmeiner@igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
 In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ap5mjiWwa9zJgvcCY07Qqr9MQUEN7mUZ0ufCKNwDnCk=; b=A07yiIN/PA7YGzZTx/rrq66qrU
 ab5IqhbcnQTJamWRyZiZO1lwpasN9T9SDzdv16MmtID1vVxnOqTB4gybq9aJ/XJhCKTiSRz8VwSfM
 zqnCq4LC+XFppb8VMpM7UaLk5p5vB9kC0dXAGBk+0Gasxg14w/qEFQSIgccDDjOsCvZcKsIcunLWz
 5RJ8RHGBr70/UuyK0apf9OlUQ1Wcd6cmfLfDebWaNxnpDfbJcSm6Ieht7vNjj2bHIPaGY5N2JFpjA
 IOMID2TjlVBK8IEQ76/0oVVcyeutPIBXXqYx8+WyDPpnuKLKW33Rcs/G3mYsQdSlI8fXVIi47cdk5
 nMpvzCHQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1rrEZt-00HZgs-EU; Mon, 01 Apr 2024 12:07:45 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
 by mail.igalia.com with esmtp (Exim)
 id 1rrEZr-008HoR-Cb; Mon, 01 Apr 2024 12:07:45 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
 by webmail.service.igalia.com with esmtp (Exim 4.96)
 (envelope-from <cgmeiner@igalia.com>) id 1rrEZr-005myh-0b;
 Mon, 01 Apr 2024 12:07:43 +0200
MIME-Version: 1.0
Date: Mon, 01 Apr 2024 10:07:43 +0000
From: Christian Gmeiner <cgmeiner@igalia.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: baruch@tkos.co.il, trini@konsulko.com, josua@solid-run.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] mx6cuboxi: Do not print devicetree model
In-Reply-To: <20240330210331.2820862-1-festevam@gmail.com>
References: <20240330210331.2820862-1-festevam@gmail.com>
Message-ID: <b263c9e133b61820141c9fb8da62e1aa@igalia.com>
X-Sender: cgmeiner@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 01 Apr 2024 22:41:06 +0200
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

Hi Fabio

> The mx6cuboxi_defconfig target supports several board
> variants. All of these variants use the hummingboard devicetree in U-Boot.
> 
> Currently, the devicetree model as well as the board variant name
> are shown:
> 
> ...
> Model: SolidRun HummingBoard2 Dual/Quad (1.5som+emmc)
> Board: MX6 Cubox-i
> ...
> 
> Printing the devicetree model that is used internally by U-Boot
> may confuse users.
> 
> Unselect the CONFIG_DISPLAY_BOARDINFO option so that only the
> board name is printed in board_late_init() instead.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---

U-Boot 2024.04-rc5-00003-g5565c24adb (Apr 01 2024 - 12:05:25 +0200)

CPU:   Freescale i.MX6Q rev1.3 996 MHz (running at 792 MHz)
CPU:   Extended Commercial temperature grade (-20C to 105C) at 26C
Reset cause: POR
DRAM:  2 GiB
Core:  84 devices, 19 uclasses, devicetree: fit
WDT:   Started watchdog@20bc000 with servicing every 1000ms (128s
timeout)
MMC:   FSL_SDHC: 1, FSL_SDHC: 2
Loading Environment from MMC... *** Warning - bad CRC, using default
environment

In:    serial
Out:   serial
Err:   serial
Board: MX6 Cubox-i
Net:   eth0: ethernet@2188000


Tested-by: Christian Gmeiner <cgmeiner@igalia.com>

Thanks & Regards,
Christian
