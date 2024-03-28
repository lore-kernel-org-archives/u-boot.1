Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B25FC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 11:44:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69B3A88173;
	Thu, 28 Mar 2024 12:43:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Z5UASUiN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA47A87F36; Thu, 28 Mar 2024 08:18:09 +0100 (CET)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 209C98758B
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 08:18:04 +0100 (CET)
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
 bh=VYJYvb6yUeLNhjmoTnTAOkjLGUBlcCQjP+Y+xOFu2h0=; b=Z5UASUiNPmslHV/SVfGA7CHYUW
 3Ze9GwPeS2ugmcwuQWacCkFZC2Vp8ezlorr7nXMa0c426EbTaf6KCortO3c/l4SwDydqQz2RqjQM+
 iBPO5MxYJ2R5tlwL9M9KzbD/tbp9NSQ9ZGFXVUdWcOMygs2LakWBOh1IPZkwx6YB0MexlCOcmbFZt
 BGr1pe5fDEHda6v2QrR2W7SrbRja7Q8GLdqxmoDSAX+nNEuEfYdqF1zH4qHtbqgAwr2YJSjq/bANU
 lFPyyGpqE28Zck/T21h8oJtC4hNVk2jMBuASwr8b9WsFbrunjuJCQSrVleZhluwkM8EB1jQf6696T
 xz2jBbZQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1rpk1N-00GAAX-FQ; Thu, 28 Mar 2024 08:17:57 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
 by mail.igalia.com with esmtp (Exim)
 id 1rpk1L-00ElEY-Dt; Thu, 28 Mar 2024 08:17:57 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
 by webmail.service.igalia.com with esmtp (Exim 4.96)
 (envelope-from <cgmeiner@igalia.com>) id 1rpk1L-00539d-0i;
 Thu, 28 Mar 2024 08:17:55 +0100
MIME-Version: 1.0
Date: Thu, 28 Mar 2024 07:17:55 +0000
From: Christian Gmeiner <cgmeiner@igalia.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: baruch@tkos.co.il, trini@konsulko.com, josua@solid-run.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH] mx6cuboxi: Do not print devicetree model
In-Reply-To: <20240327170359.2167228-1-festevam@gmail.com>
References: <20240327170359.2167228-1-festevam@gmail.com>
Message-ID: <fbc0c244d688872c793366a6aeb15ba5@igalia.com>
X-Sender: cgmeiner@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 28 Mar 2024 12:43:31 +0100
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
> U-Boot 2024.04-rc5-00003-g774ec4fda8 (Mar 27 2024 - 16:48:35 +0100)
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
> board name is printed instead.
>

This is not what this patch is doing. show_board_info() is the only
caller of checkboard()
so we end with the following output:

U-Boot 2024.04-rc5-00005-g50decee264-dirty (Mar 28 2024 - 08:09:58
+0100)

CPU:   Freescale i.MX6Q rev1.3 996 MHz (running at 792 MHz)
CPU:   Extended Commercial temperature grade (-20C to 105C) at 34C
Reset cause: POR
DRAM:  2 GiB
Core:  84 devices, 19 uclasses, devicetree: fit
WDT:   Started watchdog@20bc000 with servicing every 1000ms (128s
timeout)
MMC:   FSL_SDHC: 1, FSL_SDHC: 2
Loading Environment from MMC... *** Warning - bad CRC, using default
environment

Thanks & Regards,
Christian
