Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E959CC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8DCA88818;
	Sat, 13 Jul 2024 15:21:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="i2jNNW9O";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Pdeb/tcY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 029D788811; Sat, 13 Jul 2024 15:21:14 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 195E786E40
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WLpxz607hz9spD;
 Sat, 13 Jul 2024 15:21:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AbqqLdXe6kvNmF/Kin//JB7cWJcQEPLnUmo94FMauA8=;
 b=i2jNNW9O/ExiHbDC+qMHe7t2QgvQAMZzPBmSRSOycmGXm3ZsccN7L9jzyelq4077VsoPEX
 HUobiDStyBCE8KppRn7bOXvNlkMbmE/oshpVm6CrvnPb2ZuRtCUKObo7FpHQLH2hVS56hC
 +/BfUo5nsZFUZ1chTgho3Ukb2r1TF3jBizRtBKh245WKZemb1X2Rk1/MjxhTAVni5GZdNt
 72Xdka2n+qUqF3I9ZtGpxn+YfsB7LbsBcq7rKzxwEQ11WKO8rYEQVludfKdh+1g7SqVI2A
 MnBikCJKsyLTdqfEIDl6RnQCKwz9JyPLnhMu1t7vqKgW0WqreUnvBN1Pwr7Ufw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AbqqLdXe6kvNmF/Kin//JB7cWJcQEPLnUmo94FMauA8=;
 b=Pdeb/tcY2oj/uhc4A78F3Y2jopEAgyWa1vfkfzopDy8M6+zHshTS8UEh3ECKGk2lrM2eoY
 G3y7C4BENa6pFgcM6epEsqmUk/bRWpzy3ICv+cIuPUTGsX+xdyZAofH+neuHIaN2Q0CnbS
 yj1AAYP7319uqCbD1s6JToKbjppJAQ+Lb2O3MeOnSi0c6/Na7yDQWzxVxovGTz2D3NOsIe
 JtLZRFN8/MhIyKPbwdOg3QbouAwEg88cl9d25JcjlBNzuZXXMhd+3lWeKdrspnKH4dxuHS
 BmZ7z6rH/GWqY5gZ44/s4LSj1cpf4Oo9eQzcuS6CYnmNmq3088xz6Xs0lXKsxA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/45] arm: include: fsl: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:18:56 +0200
Message-ID: <20240713132021.57650-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2209f7ccf7cbe430d91
X-MBO-RS-META: 9i8fpspwymrm8ssdsh83zrerjpnfttjy
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/include/asm/arch-fsl-layerscape/immap_lsch3.h     | 1 -
 arch/arm/include/asm/arch-fsl-layerscape/stream_id_lsch2.h | 1 -
 arch/arm/include/asm/arch-fsl-layerscape/stream_id_lsch3.h | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch3.h b/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch3.h
index ca5e33379ba..306f797f7a8 100644
--- a/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch3.h
+++ b/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch3.h
@@ -190,7 +190,6 @@
 #define SCR0_CLIENTPD_MASK		0x00000001
 #define SCR0_USFCFG_MASK		0x00000400
 
-
 /* PCIe */
 #define CFG_SYS_PCIE1_ADDR			(CONFIG_SYS_IMMR + 0x2400000)
 #define CFG_SYS_PCIE2_ADDR			(CONFIG_SYS_IMMR + 0x2500000)
diff --git a/arch/arm/include/asm/arch-fsl-layerscape/stream_id_lsch2.h b/arch/arm/include/asm/arch-fsl-layerscape/stream_id_lsch2.h
index c18c51ed2c7..b08274e361b 100644
--- a/arch/arm/include/asm/arch-fsl-layerscape/stream_id_lsch2.h
+++ b/arch/arm/include/asm/arch-fsl-layerscape/stream_id_lsch2.h
@@ -37,7 +37,6 @@
  *
  */
 
-
 #define FSL_INVALID_STREAM_ID		0
 
 /* legacy devices */
diff --git a/arch/arm/include/asm/arch-fsl-layerscape/stream_id_lsch3.h b/arch/arm/include/asm/arch-fsl-layerscape/stream_id_lsch3.h
index 140849d4e1f..09199dfad25 100644
--- a/arch/arm/include/asm/arch-fsl-layerscape/stream_id_lsch3.h
+++ b/arch/arm/include/asm/arch-fsl-layerscape/stream_id_lsch3.h
@@ -97,7 +97,6 @@
 #define FSL_PEX_STREAM_ID_END          (0x100)
 #endif
 
-
 /* DPAA2 - set in MC DPC and alloced by MC */
 #define FSL_DPAA2_STREAM_ID_START	23
 #define FSL_DPAA2_STREAM_ID_END		63
-- 
2.43.0

