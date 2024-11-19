Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8B0D4414D
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 11:38:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8645389579;
	Tue, 19 Nov 2024 12:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ElnMf2fJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEB108951C; Tue, 19 Nov 2024 12:37:50 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A63D78952A
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 12:37:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38230ed9baeso2532064f8f.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 03:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732016268; x=1732621068;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vtbTU7FLjCl8orbIaLhCYTw3PmzNbPP9nFpN4ROC+FU=;
 b=ElnMf2fJfgEBQ46+fJnxO1/Vh8LCTgtVqKSXgdj/jdBpE82ukr78D0QfJ869BgbMkQ
 tn76T1bbWZyMsppNFdqklIOBtlIheiaFmQCAgWZ3jsUSK68g7AnjkIESsWjYTrE6CBpq
 7CeOwvH5Z8ydq0jDsVSzk98D9b2cJC5IlKjRkySUEHJ++mzJmn9LRYWFRdcFaOnJlYxD
 gVRfmIcNyQ0PvMK8FTUfCzefudaB9AmUunDKvlPTQytHx8ebMPFPJrvqKnitZRUd4RtY
 LgSIgNglhlF9HdDfbf1hybsh1GmLGCA2RmsccpsGsVl+XIg5m4ng5PZIfbh/PShWhZBJ
 XFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732016268; x=1732621068;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vtbTU7FLjCl8orbIaLhCYTw3PmzNbPP9nFpN4ROC+FU=;
 b=bco9BlAFRHEVhmRyxtOpG88KwugYiJyt+cXlHdS63JC7013UfRxTP2YGrbh8edKAOq
 5EFYrzE4a4QDQbd3DmJ8J/z5NpnibZC6opXYk0JeLorTSJJI6fuijV8W6cC/E6/0dTxk
 JJ3NOlXC9R51SDWfMLRFOtrrxjp/+X7aLglxA6bKJxLbQ/Md0u+Xsp+JABG4zjom2qs0
 A6f7AiZPWKy+jBqZySkHgB54jwBzdOisQ00T5zLYgQJrAwxTG2FCXKeIASjp2BuTfN+6
 1AvvTy1lI792mP9NZRkMGlWISaYrjos9VFUdkjlIhyg9zwo03ai6R+4XJSa6s4i4UCrd
 tZsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJE+6U8C8qWwWJk50B1avY0NokhmpFEcJFpEmeEKSP2nkYYymLNAImwyhBLRKlQdPNLA1CFJc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5qbL0neHgA3wZt4Sx8AW79DG4rpI8joTe2NGeBkDz40R0Uo9l
 IJSYswoT+gFYl9VxuFsyYXTFTVnRbliMkqQM3z2779tI6Wi+jpUFxtFChgAQI98=
X-Google-Smtp-Source: AGHT+IEBPT4bYyGwfkt4HQMtOmqYXe/9FNToq35yIq0uimkcEXhMgGy9cU8XLVZ6lpLoVhZ3zm5XyA==
X-Received: by 2002:a05:6000:410b:b0:382:4b6b:bcfd with SMTP id
 ffacd0b85a97d-3824b6bbe46mr2352557f8f.33.1732016268172; 
 Tue, 19 Nov 2024 03:37:48 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:cc39:27ba:4c6c:3c84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3824259dda3sm7580388f8f.77.2024.11.19.03.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 03:37:47 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Tue, 19 Nov 2024 12:37:38 +0100
Subject: [PATCH v3 1/5] bootstd: android: add support of bootimage v2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-adnroidv2-v3-1-45baa486fb31@baylibre.com>
References: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
In-Reply-To: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
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

Android bootmeth only support boot image v3/4.

Add support of Android Boot Image version 2 [1].
Vendor boot image is only supported in version 3 and 4 so don't try to
read it when header version is less than 3.

[1] https://source.android.com/docs/core/architecture/bootloader/boot-image-header#header-v2

Tested-by: Julien Masson <jmasson@baylibre.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 boot/bootmeth_android.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 19b1f2c377b9..2e7f85e4a708 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -259,16 +259,12 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 		goto free_priv;
 	}
 
-	if (priv->header_version != 4) {
-		log_debug("only boot.img v4 is supported %u\n", priv->header_version);
-		ret = -EINVAL;
-		goto free_priv;
-	}
-
-	ret = scan_vendor_boot_part(bflow->blk, priv);
-	if (ret < 0) {
-		log_debug("scan vendor_boot failed: err=%d\n", ret);
-		goto free_priv;
+	if (priv->header_version >= 3) {
+		ret = scan_vendor_boot_part(bflow->blk, priv);
+		if (ret < 0) {
+			log_debug("scan vendor_boot failed: err=%d\n", ret);
+			goto free_priv;
+		}
 	}
 
 	/*
@@ -476,12 +472,13 @@ static int boot_android_normal(struct bootflow *bflow)
 	if (ret < 0)
 		return log_msg_ret("read boot", ret);
 
-	ret = read_slotted_partition(desc, "vendor_boot", priv->slot, vloadaddr);
-	if (ret < 0)
-		return log_msg_ret("read vendor_boot", ret);
-
+	if (priv->header_version >= 3) {
+		ret = read_slotted_partition(desc, "vendor_boot", priv->slot, vloadaddr);
+		if (ret < 0)
+			return log_msg_ret("read vendor_boot", ret);
+		set_avendor_bootimg_addr(vloadaddr);
+	}
 	set_abootimg_addr(loadaddr);
-	set_avendor_bootimg_addr(vloadaddr);
 
 	ret = bootm_boot_start(loadaddr, bflow->cmdline);
 

-- 
2.34.1

