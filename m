Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E76C282EC
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:29:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0C068141E;
	Thu,  6 Mar 2025 01:27:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EHpD6xW/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 191078122F; Thu,  6 Mar 2025 01:27:08 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9123F81658
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:27:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-85add67e9c1so5833339f.0
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220819; x=1741825619; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRrKav6bI3WCH6d1Us4kSdyfhPdRdWDYp2hbq98yhek=;
 b=EHpD6xW/KwlBvYlvPCR27hZTpSsQcdxHDcesr3i86HfMKEzSEEjLBwoqiOQL/fTFZI
 IPngj1AwO75ac1a/1wA8VF6/A8XhNENAqHxP590dtUmxUhj9q3QKOv1nGB4lawOKuoHr
 ikITreRAzZ6hPxvReKBjk2hj5noW/k7obP4eQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220820; x=1741825620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRrKav6bI3WCH6d1Us4kSdyfhPdRdWDYp2hbq98yhek=;
 b=jHnPaAw/XhwET2By1N3V9F42keDhvysR93FCMJNB+L2DeoNaWihElMQgcvYka72n+8
 soA7Uh0YZ4U5RS3Ac0+g2iUJ0SCd01CqZsB2FJmt98rK8DprSpxk4jnOUyQAkOQhEOVq
 SeSAT7XuQGcTXqMUnZT9n5Z0RWxNbNIx0OzVeFhCuKtCvAGWNdhqS7t7SHfclmD/fW1L
 AI4Z7tg2LhnpouKm/DlM4An+1lTzvq21BcATHajKgIXJf1KSfsvKNHs9ZuNwazppM5Po
 l7YEhBFf2OEmFIZ0YMW3VQG3a1JBbj9iCHSOXLVPnh4+szWmMPVUt+3VG0EYt1YESUI1
 Z8qg==
X-Gm-Message-State: AOJu0YwaJno6gyp8PC5zl4mJrIaRfhkyexmXS4eGOfng1bv74WISMvYP
 MJ3Kp7H4qt8uAEUzptiznLzXE4tzU3sHo+T5q6OJRGdeQOQxa6wRni+UrCenSSzHx2a9bNiLVRQ
 =
X-Gm-Gg: ASbGncuuBxKHy/I0prwJIT2tdFKKRfaBcJeMA0Oig5wTM58tG2jttwWo+EzmS7DuVsA
 LRSx1Zb04ygLgvrx1jUZYFcW74j7bnEYaDpYmwQyM/snyT7TVENIJP22HLGPf/HKl0cJtJgLF6B
 aG029y+SSjsV8uV5Cb76KNTQlkQYxfmEoZyDNDLP1sCeO3+iJVS4YyAvVy8SLB5McxQBqFOFRz5
 CTy+8CYkKcBXQOEB+FEK+4HOEl4EV6TdVER2HCT2Ix2KdtMWq2UojkwYSuuJG+I2lYCBid2pdMp
 KfdOaWattq+/iPRTmiCQ8TFPS7rkwi8vgqLHUD5BKlMGHf1RRvnC4gvoDXfiIXcUsj/l5QtHXkc
 0K6200w==
X-Google-Smtp-Source: AGHT+IER+dnZl8jK171Z70v18xjDjI4NKwX2QjWjZFGgSqRcKt/q63nktaF+dS7u888NU4tAs2g+yw==
X-Received: by 2002:a05:6602:254a:b0:85a:ecc9:48b7 with SMTP id
 ca18e2360f4ac-85b0eb11749mr149075039f.6.1741220819661; 
 Wed, 05 Mar 2025 16:26:59 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:26:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v5 13/29] bootm: Allow building bootm.c without
 CONFIG_SYS_BOOTM_LEN
Date: Wed,  5 Mar 2025 17:25:07 -0700
Message-ID: <20250306002533.2380866-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306002533.2380866-1-sjg@chromium.org>
References: <20250306002533.2380866-1-sjg@chromium.org>
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

This code cannot be compiled by boards which don't have this option. Add
an accessor in the header file to avoid another #ifdef

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 boot/bootm.c    | 8 ++++----
 include/bootm.h | 8 ++++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 854ac7ec738..c719a50ef9a 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -633,11 +633,11 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	load_buf = map_sysmem(load, 0);
 	image_buf = map_sysmem(os.image_start, image_len);
 	err = image_decomp(os.comp, load, os.image_start, os.type,
-			   load_buf, image_buf, image_len,
-			   CONFIG_SYS_BOOTM_LEN, &load_end);
+			   load_buf, image_buf, image_len, bootm_len(),
+			   &load_end);
 	if (err) {
-		err = handle_decomp_error(os.comp, load_end - load,
-					  CONFIG_SYS_BOOTM_LEN, err);
+		err = handle_decomp_error(os.comp, load_end - load, bootm_len(),
+					  err);
 		bootstage_error(BOOTSTAGE_ID_DECOMP_IMAGE);
 		return err;
 	}
diff --git a/include/bootm.h b/include/bootm.h
index c471615b08c..d174f18ac18 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -89,6 +89,14 @@ struct bootm_info {
 #define bootm_x86_set(_bmi, _field, _val)
 #endif
 
+static inline ulong bootm_len(void)
+{
+#ifdef CONFIG_SYS_BOOTM_LEN
+	return CONFIG_SYS_BOOTM_LEN;
+#endif
+	return 0;
+}
+
 /**
  * bootm_init() - Set up a bootm_info struct with useful defaults
  *
-- 
2.43.0

