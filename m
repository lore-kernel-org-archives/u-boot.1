Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328C0EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 11:23:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41CC6864C4;
	Tue, 22 Aug 2023 13:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FHT6cZoM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A130386410; Tue, 22 Aug 2023 13:22:48 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13C1F864A3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 13:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52a1ce529fdso423196a12.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 04:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692703364; x=1693308164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WTekSEOIV3j+ZTlF30eg6yHH9f51XSbpuCY0WmT3Fm8=;
 b=FHT6cZoMwXbykH28gmzXkXMFqBYyidoe3l3cmo+ProjuarhjrgdjgV9cHHL5jXUHr1
 wZC5r+Je6jf6mPFFW+RWRYyJKYdtxFrfC8VbwrqBVUX4VM8deZ3+Tt/btDNtWD3nKO44
 7Px6CgRiuPVNgYwE8i+TAsEzfwg9nAZYCCdfKDFCq3Wr8BTKnGPG2AmZsDtZyhRbeZ+n
 AuHVxNIw5fz7dLB3UvEhr5nr3R3otQz5TvdKSrNbeADlhKj0UhH8ApNptzri33gJTaXW
 FpIAXVXhQJrVFhBNHna6yoWKbVxKzNiiLadxYFgdcAtQONPhpiUAHqR3iVsgtk1riuvO
 cXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692703364; x=1693308164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WTekSEOIV3j+ZTlF30eg6yHH9f51XSbpuCY0WmT3Fm8=;
 b=UlhByy/Qa/oEwJYqhBHk/9Q8RtKqPWzTw07q8JGvcFcR27FEozAQuANzDwSUVgeMUS
 Z+iLQ/j3xd4wzhHUoO/Jabi7ei29/xMpQs0DIETKOCWfce7Kcr0DNxC8XzSsraKE96fw
 DOIq6HORSk2ZM0kOrtYt4OB96xBXykBTTaLBIW0Y8s2p2bMK+1Cy9Zjyh40iKK55bw1L
 ONI6Q0rRZomWIopQ/lurbMpQXiadg+OGg/9IeXBVF4kv+VAtRLvmMWMF0ad6bstEUmTi
 op5uStk00mcwmezr76GOQ57MrHEKfpnqnyvfdBgF2C4zFniH4rMJjwKNMwHekWfA6sBn
 gcxA==
X-Gm-Message-State: AOJu0YzKyPryWZ0SjaJyv9JlIBAT5eLvJLzH0uhw76BkK9hDPC21wui4
 4o88rnm37SeX7fAbBrj94NpU9Vo1LfpV3w==
X-Google-Smtp-Source: AGHT+IGUa2IT3SHPLV/yMOepWrUVovgD8BPXw3CRFE57TFhUQCYmYe3B6yXswOrQMQFp1cBKKt40cQ==
X-Received: by 2002:a17:907:7718:b0:978:acec:36b1 with SMTP id
 kw24-20020a170907771800b00978acec36b1mr7436036ejc.17.1692703364616; 
 Tue, 22 Aug 2023 04:22:44 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 mh9-20020a170906eb8900b009934855d8f1sm8041456ejb.34.2023.08.22.04.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 04:22:44 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 04/19] ARM: dts: tf201: configure dock USB phy
Date: Tue, 22 Aug 2023 14:22:02 +0300
Message-Id: <20230822112217.4646-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822112217.4646-1-clamor95@gmail.com>
References: <20230822112217.4646-1-clamor95@gmail.com>
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

TF201 unlike other transformers uses non-fused xcvr value for
its dock USB port. With out it dock USB and SD reader will not
work.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra30-asus-tf201.dts        | 5 +++++
 arch/arm/dts/tegra30-asus-transformer.dtsi | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/dts/tegra30-asus-tf201.dts b/arch/arm/dts/tegra30-asus-tf201.dts
index 54f359ef96..59e19f9766 100644
--- a/arch/arm/dts/tegra30-asus-tf201.dts
+++ b/arch/arm/dts/tegra30-asus-tf201.dts
@@ -6,4 +6,9 @@
 / {
 	model = "ASUS Transformer Prime TF201";
 	compatible = "asus,tf201", "nvidia,tegra30";
+
+	usb-phy@7d008000 {
+		/delete-property/ nvidia,xcvr-setup-use-fuses;
+		nvidia,xcvr-setup = <5>;      /* Based on TF201 fuse value - 48 */
+	};
 };
diff --git a/arch/arm/dts/tegra30-asus-transformer.dtsi b/arch/arm/dts/tegra30-asus-transformer.dtsi
index 4eee1df084..d144a56445 100644
--- a/arch/arm/dts/tegra30-asus-transformer.dtsi
+++ b/arch/arm/dts/tegra30-asus-transformer.dtsi
@@ -123,6 +123,10 @@
 		status = "okay";
 	};
 
+	usb-phy@7d008000 {
+		status = "okay";
+	};
+
 	backlight: backlight {
 		compatible = "pwm-backlight";
 
-- 
2.39.2

