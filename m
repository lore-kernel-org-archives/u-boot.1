Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208A4ECE58D
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B1A088F61;
	Tue, 10 Sep 2024 11:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="KvBfQJt/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A9DB88F53; Tue, 10 Sep 2024 11:12:05 +0200 (CEST)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 650F788F5A
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:12:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66B35FF803;
 Tue, 10 Sep 2024 09:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1725959521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Svddtvi7cD48Ekm0c6AilOas3WYIz3KEWwLXssqKH0s=;
 b=KvBfQJt/sk6HIELv26i8Hn3QjL0QppXnAIWSEqmOlwsheKT5SY7Pva+4V1VMMzF8HuitgL
 2NJQUVCNrj6p3DzglWQbosWUctwvTSn7Np6d80kglNKCffpIjy2SAiLfZCBy53PxUO0zzn
 Qy8BpLyh5yfgFIGrrbG+Z3F3DZ7hfGl0aX5xtvQU5+w/q5c6AyHUdJAIDw28I2EovAhqBK
 I+2qgXypn0E1QJCmd29NP4BGHsOEZKBZLotI0AktfmAje+K++bGJCwf5ZyCNypc1d3qs8M
 gRXTdT5WVsO9SrCAdwKBax0qpw2e+O7maI8z2NPsFVg/tlcjiIdgjFFgGJ5Meg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Anatolij Gustschin <agust@denx.de>,
	Tom Rini <trini@konsulko.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, <u-boot@lists.denx.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH] video: Fix VNBYTES() macro comment
Date: Tue, 10 Sep 2024 11:11:59 +0200
Message-ID: <20240910091200.101886-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
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

The VNBYTES() macro has been updated to silence possible warnings
regarding authorized (but unusual) uses of this macro, but the comment
was kept unchanged. A year has passed so let's fix the comment now to
avoid confusions.

Fixes: cc05d352fbc ("video: Add parentheses around VNBYTES() macro")
Suggested-by: Tom Rini <trini@konsulko.com>
Link: https://lore.kernel.org/u-boot/20240906183432.GG3879073@bill-the-cat/
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/video.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/video.h b/include/video.h
index 4d8df9baaad..59b56014874 100644
--- a/include/video.h
+++ b/include/video.h
@@ -57,12 +57,8 @@ enum video_log2_bpp {
 	VIDEO_BPP32,
 };
 
-/*
- * Convert enum video_log2_bpp to bytes and bits. Note we omit the outer
- * brackets to allow multiplication by fractional pixels.
- */
+/* Convert enum video_log2_bpp to bytes and bits */
 #define VNBYTES(bpix)	((1 << (bpix)) / 8)
-
 #define VNBITS(bpix)	(1 << (bpix))
 
 enum video_format {
-- 
2.43.0

