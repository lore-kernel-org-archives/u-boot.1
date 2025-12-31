Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E327DEE644F
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 15:37:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D2A28409B;
	Wed, 31 Dec 2025 16:37:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="j61vyr7t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02FCF840A2; Wed, 31 Dec 2025 16:37:55 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B49F84097
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 16:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 928553F864
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 15:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767195472;
 bh=F/Dh57HGMvKfkA6T5vSJT/MtcyfJ7NGraux5FIPFL8M=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=j61vyr7td8MiPpOZ15vb+X9/NNoHsW6fACnma8pLdkWkPJu3f7IYdXcj9Ert9D/2a
 kW8fcEg2XqJRzBPLgtU2w/Uu5UzW4V+2b9/WoCKqWAeAEUpUbx5SfzDYViKHMa8dR5
 ZATwj9mQYPqYMJikI45NiGAKDEVImHLJPkTQKjeM9tOckoQIS+XPcvZm5KeF+ym0QP
 QT1szqmkZ7WjpdaLFuBTnInmH3XgAno8xPqLEPY88rWdR0c0Vph5nZH9UaDP2yKu6q
 TFM0Jgz4+w6I/J8awZKqxvSZ/9gIACsmrKFQUBKLwcY9bPtxl63ZS9tHOqSxNpUJp+
 xeU8Z1q9thAycyMazfZGrLvByhvxa9wwufI+ToYEwpuKHz4E/iG9IGpPN0v/OBaCtZ
 sLdmzyTs533sW9avejOuXUYqzjxr+Q0btIHBvBd+WkTyhCkwQkyABrx+3ZEzftFBSn
 lqiJ1YYiy6ag/pMa3UGREvdkBQOBTCV9UFiKjCS/sK7249aYh96/Oxd7iM4324s6e3
 M2B/JhQQFR+Zqi+BxNTMij5kH3HE/jtaVoao1+5lmpoP+76hTCUzMI7vupxmm01CDV
 kV93gQxH3QTcLlgXQ7YICsiYHe/HL6UXygpzlBGa3JkI3t0rMe+OF9ojucURwD4WMI
 dJzQDZvB7zO9D2MbPrzhPnbM=
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4325cc15176so5136355f8f.1
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 07:37:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767195472; x=1767800272;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F/Dh57HGMvKfkA6T5vSJT/MtcyfJ7NGraux5FIPFL8M=;
 b=smHZpwOntbqm+YCbE8H4PIP18vZl8DPQBnJgWUi2eH5qLydOIOUmoF12yZgsrLcaPu
 DXZs9/w65Q4sGnt90Jo3i9/zkW46QjjSFEnVwDG9rWxAoGhKCQZTBIi8v6er5WiLynGQ
 64wncfWNoPxaCx2GcTfQI90LW0uBCAnvKiSuKwsmaNsf/Fd3EBYqbuhm0gQvzNmcpCgt
 p1SMGQywfSpPp8Y3CO0wbI0kyxzlPHT8e1gViXM9YzLoDuChhVvY6pXLld00m1f2paiQ
 w+gJmXS7SWl/lbbcL+hden6/uuwCEaoy/UYXbMjzxwtBXHACcRUIvbFx8cFx0eLyNIhn
 HutA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvPT51VunH/lFkRog89XnwgKkEVUL6qsOjMIx3lD31lBXQXBHxHjuX5UFJXRCMecubsJU8j7k=@lists.denx.de
X-Gm-Message-State: AOJu0YwuCjAcSVvtBP2j9y/JiYAEund7541ROn4okjPTzKtNEFTthjo8
 gMiZ48cEclr1c3UOjvPXCqqMw0A1QnfXRztm54iw7x487Pe5wZ5Ofc19mAKqf9tQ1hUixCTR0h+
 0Q2hGk4bxneD0PFhDYK/fvTijV823XudPaVC4GHgVtay8pMyQVW3+L1rTQwnl1/34Y16AhhOCw/
 PqLzs=
X-Gm-Gg: AY/fxX4VANmwuqnMF0TjzdxSz3ppRZjdlEgjm62N4TP7QbLs9JQJOtVL3l83jb/0Yxt
 3o8T4vLtkdKnGLoETg/xnUO5JLkZ3I0oMwbyEH9zy7DnUwga1/qlTPgvIQtY2PCeMc6+ENeSExa
 mi937+Y88/rVX3avYVLS4ZUMhUoyR4FC01OAZALd/CaM4mLLJU3FxWZctj+exJuoFQXlgxdBuGn
 ZugLoUBEgzgieRfLWxPok/IccXdFS6adRBO5R8ubi4s80ZatLMQBdJQydOG49gwmqkv9aKA+dt4
 pgiIp54ydSedsDi45VGRQZn86QxN9FIpHezASxlOOej4Doy6MlCWbO5GiabtMyk4yZohqPX5C2m
 fkdawBhjyo3SmO56F0XgW3tjGMvYKQVxLV2qPeetBFkUVqGshEM8uOp2a16/xwKqgITisW32iH4
 1Q
X-Received: by 2002:a5d:5e01:0:b0:430:fb6d:1442 with SMTP id
 ffacd0b85a97d-4324e715b2fmr49604596f8f.62.1767195472098; 
 Wed, 31 Dec 2025 07:37:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkQhrtvfmvWsX7Lq5isBPAFU6BhF9Qk6oMmx3i+2B9kjKG5GxbN2qBwpwVZTYe0v73bL0Slg==
X-Received: by 2002:a5d:5e01:0:b0:430:fb6d:1442 with SMTP id
 ffacd0b85a97d-4324e715b2fmr49604578f8f.62.1767195471737; 
 Wed, 31 Dec 2025 07:37:51 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa0908sm74523800f8f.31.2025.12.31.07.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 07:37:51 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] video: correct label for cyclic video_idle
Date: Wed, 31 Dec 2025 16:37:19 +0100
Message-ID: <20251231153719.84716-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When the cyclic function video_idle() takes too long a message like the
following is displaced:

   cyclic function video_init took too long: 87707us vs 5000us max

The text "video_init" is misleading. Replace it by "video_idle".

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/video/video-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index 53641fc28b6..228d6bacc58 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -734,7 +734,7 @@ static int video_post_probe(struct udevice *dev)
 		uint ms = CONFIG_IF_ENABLED_INT(CYCLIC, VIDEO_SYNC_CYCLIC_MS);
 
 		cyclic_register(&uc_priv->cyc, video_idle, ms * 1000,
-				"video_init");
+				"video_idle");
 		uc_priv->cyc_active = true;
 	}
 
-- 
2.51.0

