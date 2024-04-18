Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B10C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 19:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0966E886AA;
	Thu, 18 Apr 2024 21:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rsgb02T9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C370886A7; Thu, 18 Apr 2024 21:00:37 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C02D18869D
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 21:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id D67EDCE1905;
 Thu, 18 Apr 2024 19:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 017F7C32783;
 Thu, 18 Apr 2024 19:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713466830;
 bh=I/gWLJ/54Jrj+2I7OCqF3ATdRHZ5ajf3sCx+so4scNg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=rsgb02T9TaB0FdCaCuEuY3UIUuLREHGB2yOJ23pCiIc9FXGcEoiNFvYXQjnCle8yS
 6gmQL8bvMXIml5FS5mk7FH1VDnMADDo068AtNP2skZvr7nYiksLdLLv6o6PBUMQ8vn
 iZm3eyPY8veKKMQy3qBT8bCVt+9GVW1fJKOzxNMIylZfadd59c2GfismyzgbHPMBUj
 Ji5LX5wZTZvsf/N+UWESdMfF+QA6mMxQ9Q6MXvkoe6HTJadS6UyM56M8pVFelmQneU
 ahNHEV/04g4jb0AEDtmrNiX4sCAe2xfDLJxX4pjdPfooDoL7OhqMFn5ytgMk27PtkV
 pvAEDEJGrV0UA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id ED1C6C04FF8;
 Thu, 18 Apr 2024 19:00:29 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Thu, 18 Apr 2024 21:00:29 +0200
Subject: [PATCH v2 5/5] arm: apple: Do not list bootflows on boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-apple_config-v2-5-7e5c6b9a9db3@jannau.net>
References: <20240418-apple_config-v2-0-7e5c6b9a9db3@jannau.net>
In-Reply-To: <20240418-apple_config-v2-0-7e5c6b9a9db3@jannau.net>
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 asahi@lists.linux.dev, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=652; i=j@jannau.net;
 h=from:subject:message-id;
 bh=aKmGZalIZA4d3jN5L9yo43E4OSWpBFF1+lCA1zAzZAU=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhjTF3NNdt+0OSJ1iF1Cav3DTObVAQVcOQ7V5RSo55pWtH
 2YVn3HtKGVhEONikBVTZEnSftnBsLpGMab2QRjMHFYmkCEMXJwCMBGeKYwMXTf227KazXKKWiRr
 k+ZnkFEc9u73dRMF1Xs7/Ey3rTsiyvA/eZYF75yw8xxmRg7uGVEN8yRniFR+U//0Y7dX//2C/i8
 cAA==
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

From: Janne Grunau <j@jannau.net>

The bootflow list is only seen briefly and is probably more confusing
than helpful.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 configs/apple_m1_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/apple_m1_defconfig b/configs/apple_m1_defconfig
index c30aec7c55..4eac1a9e2d 100644
--- a/configs/apple_m1_defconfig
+++ b/configs/apple_m1_defconfig
@@ -8,6 +8,7 @@ CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_BOOTCOMMAND="bootflow scan -b"
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_CMD_SELECT_FONT=y
 # CONFIG_NET is not set

-- 
2.44.0


