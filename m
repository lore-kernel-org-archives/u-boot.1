Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B8CC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 10:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB87284A90;
	Mon, 13 Jul 2026 12:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="vfdfyOjN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A9B184A78; Mon, 13 Jul 2026 12:02:58 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 414D884A9E
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 12:02:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-475417f010dso1345478f8f.2
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 03:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1783936976; x=1784541776; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3AflRww/at2Jmhwcs9yWzyyieS6s7AhUNnK846DJbmk=;
 b=vfdfyOjNpAVnvB2Yhb5+xTz2ytCNMkh8p5hXHnmApFuXvwvJAmTt+PPknnga6fF1PY
 083mUXm/aTy/HjEOoP4VPG9YsO6o0w7hYHPm4x0AM8irNUL50+nkpx7PLMTiCzSv74R2
 i00gBSWKyH/DChciZ3voXGabZ1065yvOupnz0ldLre3Ny5odsKLyLwtXyg3hBw9C8Kd8
 2rsdjKjGjgX0/o0boyJZ39s6EcPvuKIgbZQxX/KOabTOUZYUBA3guSpKkJwgqN87Ym3b
 xLAmuCmb4ZMqfqGIlOrr+1YDBnDyD5Z3Piw79KrDZKMIFhcJuPOC5QJYq1E9vEysi6HB
 ad0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783936976; x=1784541776;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3AflRww/at2Jmhwcs9yWzyyieS6s7AhUNnK846DJbmk=;
 b=FxJsF9hNubxN/q1afMqocAZj/itQpWEviO16pOyVG8jNm2bh3kF9fFDXrXlU3eTeK/
 0eimvQJxR2Fa8l1cGgxjT5iWK2y4dyNFIcWCjngurbU5pCneAES43BvRgdm01joQvThH
 I+fpjOAsYXChrFD9DY6OxBiubfrTxmqPkvwb6yiKNA+c8hhh62cyNM1k7WyTy6Ff+v2U
 vBA5rYstEv7J8J9QgTyY+JpH/AFSPWIpyDU5S+wGq7q7brE4vcXLOTENmHBZMGonZkka
 G9wRjVtMBPaxES9vj4hQgpAju03yA8nnf9mrF54Dr5U5WVe0fm+N+J5lyREl/E2zxTdZ
 ztxA==
X-Gm-Message-State: AOJu0YyyqrgeqLE8WUtvZYfHiYxOVdKyN2XBFAF3Hg+Z0CRY4DRxp33b
 KzB30FYV2xEVuZWZ1cS8SwfxKVzeGq1I8RrkorfuR/V1kmoeshlQKEj8yo4yOdhT0p8=
X-Gm-Gg: AfdE7clQir4SceZZbXW5hBqcFyxEdcAAUa4ZWEydWl/WFpzCUMwJB80rKFPLhPQGkXb
 yR6dnXJsBBgtt2L83ZiG/PRoDuVmaI2mPRJwNZ3bZyDnGC3m2AXacBzFX+/BrOC6HlGlj0F5pui
 gzGrWCp3llNrCvxYGe2MetimXFNfeY16S6XRoARx4yjz51gYSF8IKQFDww/Nw9zeN+/ulDSNUJ8
 R1oL87BbgNtfqjTwQYT8bPOHau2XTRnV+9OXnMHkYwP2xOouyLJeD7KhNWbmGqlCVV53zvfYHmP
 gY1hIoO3WcbCtNhvDxOKPD5u8vu+X8GflhmmTpSFs8g+6zzNI9jgc4FSwZHC5ssxf/YqmV5zs4R
 sbTgLl29CKV0XT5O/GHclSH/GpW2oVsZ+NPOeGOwFYv7MjWxbHUevsLtXTEPfMXD1yN3sk+a/oA
 VCpW/4W1/nqGNUz+PGgZ6FjmXOafsB8J6kNKCYsyyqqMwERZMlURxiWgJK0yx9JNU5
X-Received: by 2002:a05:6000:4010:b0:479:190:5873 with SMTP id
 ffacd0b85a97d-47f2dd02471mr9329386f8f.49.1783936975617; 
 Mon, 13 Jul 2026 03:02:55 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f25b23b7esm29135772f8f.18.2026.07.13.03.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 03:02:55 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 13 Jul 2026 14:02:44 +0400
Subject: [PATCH 3/7] rockchip: mkimage: Print boot0 and boot1 parameters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-rk3576-boost-v1-3-9d23aa08f674@flipper.net>
References: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
In-Reply-To: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2161; i=alchark@flipper.net;
 h=from:subject:message-id; bh=R/+LzmtzFclehwlkdevTcvJuvHiM9WNrLckOtZZxInE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSFbD8uLBR54Pap5R8mm+8yumP99JP72XWqKv8zTly8c
 jHzl2DD946JLAxiXAyWYoosc78tsZ1qxDdrl4fHV5g5rEwgQ6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 z9BIx1jHiIGLUwCm2qCUkeFL8ZST13/o33g8e4V+glFM0mTRNp1bHvyTJwnurf0UtcOY4b/rVp4
 DpbeVA2LWfO2QWe30526u+PyMN9fPf/SX3V0b/p4dAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

From: Jonas Karlman <jonas@kwiboo.se>

The v2 image format embeds boot0 and boot1 parameters, the vendor tool
boot_merger may write these parameters based on the rkboot miniall.ini
files.

E.g. a RK3576 boot image may contain a boot1 parameter that signals
BootROM or vendor blobs to use 1 GHz instead of the regular 24 MHz rate
for the high precision timer.

Add support for printing boot0 and boot1 parameters, e.g.:

  > tools/mkimage -l rk3576_idblock_v1.09.107.img
  Rockchip Boot Image (v2)
  Boot1 2: 0x100
  Image 1: 4096 @ 0x1000
  - Load address: 0x3ffc0000
  Image 2: 77824 @ 0x2000
  - Load address: 0x3ff81000
  Image 3: 262144 @ 0x15000

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 tools/rkcommon.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index fe0afc5629b3..992c90791ffc 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -62,6 +62,8 @@ struct image_entry {
  * @boot_flag:	[3:0] hash type (0:none, 1:sha256, 2:sha512)
  * @images:	images
  * @hash:	hash or signature for header info
+ *
+ * Other fields are not used by U-Boot
  */
 struct header0_info_v2 {
 	uint32_t magic;
@@ -69,7 +71,9 @@ struct header0_info_v2 {
 	uint16_t size;
 	uint16_t num_images;
 	uint32_t boot_flag;
-	uint8_t reserved1[104];
+	uint8_t reserved1[32];
+	uint32_t boot0_param[10];
+	uint32_t boot1_param[8];
 	struct image_entry images[4];
 	uint8_t reserved2[1064];
 	uint8_t hash[512];
@@ -510,6 +514,18 @@ static void rkcommon_print_header_v2(const struct header0_info_v2 *hdr)
 
 	printf("Rockchip Boot Image (v2)\n");
 
+	for (i = 0; i < ARRAY_SIZE(hdr->boot0_param); i++) {
+		val = le32_to_cpu(hdr->boot0_param[i]);
+		if (val)
+			printf("Boot0 %d: 0x%x\n", i, val);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(hdr->boot1_param); i++) {
+		val = le32_to_cpu(hdr->boot1_param[i]);
+		if (val)
+			printf("Boot1 %d: 0x%x\n", i, val);
+	}
+
 	for (i = 0; i < le16_to_cpu(hdr->num_images); i++) {
 		printf("Image %u: %u @ 0x%x\n",
 		       le32_to_cpu(hdr->images[i].counter),

-- 
2.53.0

