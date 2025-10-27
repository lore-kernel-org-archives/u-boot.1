Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFD9CCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F3B783979;
	Mon, 27 Oct 2025 17:47:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="e0Wc+Kv/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mIE1QAnE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4866D83923; Mon, 27 Oct 2025 17:47:16 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AE768397D
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:47:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cwKDL06sbz9sly;
 Mon, 27 Oct 2025 17:47:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0mc/MoGyPkyg2YMzwP8sc43DbKtvWU0xLnkv82eqYAg=;
 b=e0Wc+Kv/ECxgzvjvp+f8hDyd6EVmT3AU6ZoclYBcMA+1cpVk5OUqvTVczzgAuVnsB4xJ9s
 Rp7Uh1swPkEAy8F0+4p9ioC7b8N3sEQFiC7mfFLv82aMox99mr/1X/8enyCEuebQMoYgyi
 92i8YXR00Mcip5GSjqnsnM8rvFvsKdos4UrYarmMG3Sq9/Ave2oCOeWJkSws5CfsGyKfsd
 j35K88MS48cSb1J1Ml/xEJvoX9aBf7Oip7gF7eRMFe1WLcZRwNPTPhsZo1Tt+kdHGNYZjC
 Uu+neyqcyd0QKUd8xy5Aj641k8+DwZEFoTt+t0JJK1SkUSw/7ii3Edg2TZAErQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=mIE1QAnE;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0mc/MoGyPkyg2YMzwP8sc43DbKtvWU0xLnkv82eqYAg=;
 b=mIE1QAnEWvbF/yVnKUXiXCNcAEPZoFYXis9W01e4dQFOjN9iG9ME+2zRDqEB8uKNU/tkjz
 Q00iDmH0qZZLJTaLD+re2kBLe7tSebrtffQ5HAORs5buW4YfaXc2acRM3apKuxrkxMyO0o
 OQuyL92+ZyTMtS2VJ//7iLout0OS9lKiWnJagXRQUjKwYSlmwonxPm5WUbZ+rRMXz8vcg2
 +3fr3J5Kdyc/SPa+W6BqkkfsTLf5p0EUSBuB513+yHsHNboghwk0Tm1QBl9xo1lzqJn3/8
 6EqrwM5EuV1/eA0fUY00yfSdx71vnbYiu64KSh6yRauRxyjna+U7z1a6waXh1w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/12] net: rswitch: Inline FWRO, CARO, GWRO, TARO, RMRO macros
Date: Mon, 27 Oct 2025 17:45:39 +0100
Message-ID: <20251027164643.12443-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027164643.12443-1-marek.vasut+renesas@mailbox.org>
References: <20251027164643.12443-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1zna3xcay5bwj3tef6q6ri64gdfj97qw
X-MBO-RS-ID: b4328fb293ab636840e
X-Rspamd-Queue-Id: 4cwKDL06sbz9sly
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

Inline FWRO, CARO, GWRO, TARO, RMRO macros directly into the
follow up register macros. FWRO, CARO, GWRO, TARO are already
zero, drop them. RMRO is 0x1000, increment all registers which
add RMRO by 0x1000 directly. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/rswitch.c | 78 ++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 42 deletions(-)

diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index 096e1c99220..f31fd4ef738 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -36,53 +36,47 @@
 #define RSWITCH_ETHA_SIZE	0x00002000	/* with RMAC */
 #define RSWITCH_GWCA_SIZE	0x00002000
 
-#define FWRO			0
-#define CARO			0
-#define GWRO			0
-#define TARO			0
-#define RMRO			0x1000
-
 /* List of TSNA registers (ETHA) */
-#define EAMC			(TARO + 0x0000)
-#define EAMS			(TARO + 0x0004)
-#define EATDQDCR		(TARO + 0x0060)
-#define EATTFC			(TARO + 0x0138)
-#define EATASRIRM		(TARO + 0x03e4)
+#define EAMC			0x0000
+#define EAMS			0x0004
+#define EATDQDCR		0x0060
+#define EATTFC			0x0138
+#define EATASRIRM		0x03e4
 /* Gateway CPU agent block (GWCA) */
-#define GWMC			(GWRO + 0x0000)
-#define GWMS			(GWRO + 0x0004)
-#define GWMTIRM			(GWRO + 0x0100)
-#define GWVCC			(GWRO + 0x0130)
-#define GWTTFC			(GWRO + 0x0138)
-#define GWDCBAC0		(GWRO + 0x0194)
-#define GWDCBAC1		(GWRO + 0x0198)
-#define GWTRCR			(GWRO + 0x0200)
-#define GWARIRM			(GWRO + 0x0380)
-#define GWDCCR			(GWRO + 0x0400)
+#define GWMC			0x0000
+#define GWMS			0x0004
+#define GWMTIRM			0x0100
+#define GWVCC			0x0130
+#define GWTTFC			0x0138
+#define GWDCBAC0		0x0194
+#define GWDCBAC1		0x0198
+#define GWTRCR			0x0200
+#define GWARIRM			0x0380
+#define GWDCCR			0x0400
 /* List of Common Agent registers (COMA) */
-#define RRC			(CARO + 0x0004)
-#define RCEC			(CARO + 0x0008)
-#define RCDC			(CARO + 0x000c)
-#define CABPIRM			(CARO + 0x0140)
+#define RRC			0x0004
+#define RCEC			0x0008
+#define RCDC			0x000c
+#define CABPIRM			0x0140
 /* List of MFWD registers */
-#define FWPC			(FWRO + 0x0100)
-#define FWPBFCR			(FWRO + 0x4a00)
-#define FWPBFCSDCR		(FWRO + 0x4a04)
+#define FWPC			0x0100
+#define FWPBFCR			0x4a00
+#define FWPBFCSDCR		0x4a04
 /* List of RMAC registers (RMAC) */
-#define MPSM			(RMRO + 0x0000)
-#define MPIC			(RMRO + 0x0004)
-#define MRMAC0			(RMRO + 0x0084)
-#define MRMAC1			(RMRO + 0x0088)
-#define MRAFC			(RMRO + 0x008c)
-#define MRSCE			(RMRO + 0x0090)
-#define MRSCP			(RMRO + 0x0094)
-#define MLVC			(RMRO + 0x0180)
-#define MLBC			(RMRO + 0x0188)
-#define MXGMIIC			(RMRO + 0x0190)
-#define MPCH			(RMRO + 0x0194)
-#define MANM			(RMRO + 0x019c)
-#define MMIS0			(RMRO + 0x0210)
-#define MMIS1			(RMRO + 0x0220)
+#define MPSM			0x1000
+#define MPIC			0x1004
+#define MRMAC0			0x1084
+#define MRMAC1			0x1088
+#define MRAFC			0x108c
+#define MRSCE			0x1090
+#define MRSCP			0x1094
+#define MLVC			0x1180
+#define MLBC			0x1188
+#define MXGMIIC			0x1190
+#define MPCH			0x1194
+#define MANM			0x119c
+#define MMIS0			0x1210
+#define MMIS1			0x1220
 
 /* COMA */
 #define RRC_RR			BIT(0)
-- 
2.51.0

