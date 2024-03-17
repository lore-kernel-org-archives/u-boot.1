Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDDBC54E67
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 14:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A089687F0A;
	Sun, 17 Mar 2024 15:54:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DnPh+Owl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E993487D06; Sun, 17 Mar 2024 15:54:56 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A2B487D0A
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 15:54:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 3C13DCE0104;
 Sun, 17 Mar 2024 14:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AC7BC43394;
 Sun, 17 Mar 2024 14:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710687289;
 bh=AFc7n4mKSavFmzkVpvu2rqiaKI0HeqSMl+SkIaar5+M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=DnPh+OwlRnVJp7L70OH64DRnz7tP7RglxlSzO0RoDoK507/PWOB9nJzMFyE8/DMGn
 ce61soTGgDyNq9K2/d8L426OQx+8FEG8FcEGFMnNto5mdhzhZus7xOuih775XgV1l5
 cXgIcfzX929+hcbDsXsNAxTpqrhbrLymtgDGQhXOG+FFisgDDm4jnGlnKEXBTqgy1q
 /F6HRF7DtTGCvgLjONm3ssocBJAEFKxDmDY/RZQiCaAOeAqM/OTtlbMVnPbFt42uhi
 Z92NdGT4ja5rJQbw91BHsoe6JyPrA9Fjqnbks0kQkeNIdfAHnJKmzOb8Pvxvy6cPfT
 G6r2f5yRBPu2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 65F2BC54E60;
 Sun, 17 Mar 2024 14:54:49 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Sun, 17 Mar 2024 15:54:47 +0100
Subject: [PATCH 1/4] apple_m1_defconfig: Turn on CONFIG_SYS_64BIT_LBA
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240317-apple_config-v1-1-1b862bc140a9@jannau.net>
References: <20240317-apple_config-v1-0-1b862bc140a9@jannau.net>
In-Reply-To: <20240317-apple_config-v1-0-1b862bc140a9@jannau.net>
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 asahi@lists.linux.dev, Janne Grunau <j@jannau.net>, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=818; i=j@jannau.net;
 h=from:subject:message-id; bh=5YcL4gGQm/14duZ94SDLQIWzeXI+jl0sijBSTVNX2I8=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtTvLOYr3hyr5dS2M71nfZezNDM5i+2pLcPEAi7TH10eu
 1786P7fUcrCIMbFICumyJKk/bKDYXWNYkztgzCYOaxMIEMYuDgFYCI9yxkZTv19w7vjddTsNt8l
 +moWTz7PuCV8ImdDa8FexQPHnB1mZzL8UxPYxBXLo2clv+Dgy5dzk55uNgrby8gsu+R2UGWFy2k
 PLgA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
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
Reply-To: j@jannau.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Hector Martin <marcan@marcan.st>

This makes USB HDDs >2TiB work. The only reason this hasn't bitten us
for the internal NVMe yet is the 4K sector size, because the largest SSD
Apple sells is 8TB and we can handle up to 16TiB with that sector size.
Close call.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 configs/apple_m1_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/apple_m1_defconfig b/configs/apple_m1_defconfig
index e00d72e8be..31d966f0ab 100644
--- a/configs/apple_m1_defconfig
+++ b/configs/apple_m1_defconfig
@@ -10,6 +10,7 @@ CONFIG_SYS_PBSIZE=276
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_LATE_INIT=y
 # CONFIG_NET is not set
+CONFIG_SYS_64BIT_LBA=y
 CONFIG_APPLE_SPI_KEYB=y
 # CONFIG_MMC is not set
 CONFIG_NVME_APPLE=y

-- 
2.44.0

