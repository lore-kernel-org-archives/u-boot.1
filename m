Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8D8C02198
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56B86808E6;
	Sun,  9 Feb 2025 03:03:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V4ro3748";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CC0E80B9E; Sun,  9 Feb 2025 03:02:21 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BE2C809A5
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:02:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d15ce78fecso265225ab.2
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066532; x=1739671332; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nlP6bUxcy2ZERKgB0l2T8o+gOQZt1svTpktojBx+cFY=;
 b=V4ro3748qxf/jjIZEy52DoMGteSxXg8cUE2wTnwTs6UdNlMh85R9dhNIJVljGCJ/zz
 E0nn/z7ue8jHArE6WpKwOW60g3ycnzbsdHtPK/15y2udKaVv51qCdW/XU1jZv5DJLJbD
 n2kHKYUYutoz7QSORPXe4F5k2i33h5quJS54Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066532; x=1739671332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nlP6bUxcy2ZERKgB0l2T8o+gOQZt1svTpktojBx+cFY=;
 b=U2njZyIWapj+GG9TK9JIvjIqJusSDPliAU5uPsPAPoXlwAuYk7BLTa0v48bI5aburt
 nvA8+qdSlkoOs8gohoUkc+Aj8/QRaHUC+gqaIc3CLEz4k3lJKl82g4X5kMIYhNt6+jA6
 L3RkIJybFlYsQTBhq1/Yez/JVxeh+k0RkXi8A3jF+GQ4i/8aGnPqEh2OvLjAL+UzUqji
 zUTYfE5e9LhVU+pGfL+KwrMfRxL66TOHoNqW7nDryinaErviLKSmH54p8V9Q2piZvoeG
 qFB0/QdM/mW7ikxBPzL6At7Jh2WiSNY+3lxqnaY5X27TWt+w7W8rA9CshzrHqwlxbXzT
 WNGQ==
X-Gm-Message-State: AOJu0YyvTyj7iWhephaZXwotsJzScL/aiLzQEn6nVldjptfYskiUdWV4
 yk/lNvpufNBNvxV94qKv+EvTT/qtqypho4Isj+fQDD0IcXL/tT3ORCuzl7tJOYbWbYe1jM4Q15w
 =
X-Gm-Gg: ASbGncvivAvGDLvYpNpbJIkjFcfqrNo/FDkxQ1kEFojaNtIMlrDj4BM8m8gITuu+VaG
 LGB/LcwOaboIFh4/Nf1sFZ1vzODst5BFzF5mkB4YeXd0X7C+DahtP0c0j1QR+aiN1BfDBjcKALb
 QKQG6cxEH70Jbv2ZQ3hMmEbTzfsoyb+pBE0QZvBmbnDq3RbJW1v3eNmOUie5zAbRpCY9RpETWzZ
 UfjcaRjsYrvgiRlPn4D8yY58Xmc2SC7oh8l9p4y3791QNKbMPP9dwtPa55CDWwHaRjQk5Pdfz1x
 EpDMMch37rwOm2M8//6MlunWMa3Zq5gY/mej2pLb0EBy5q3GORVt
X-Google-Smtp-Source: AGHT+IEWjz1Fkm88o5aFiZHdWhfSeyeS602JRZJr/gRSbt2WAE0MiVcqdjl9mwunjX8Mxi/O+IGbGg==
X-Received: by 2002:a05:6e02:3112:b0:3cf:bb6e:3065 with SMTP id
 e9e14a558f8ab-3d13da217ddmr82637265ab.0.1739066531754; 
 Sat, 08 Feb 2025 18:02:11 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:02:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 10/29] efi: x86: Allow setting the global_data pointer with
 EFI
Date: Sat,  8 Feb 2025 19:01:09 -0700
Message-ID: <20250209020136.4108987-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209020136.4108987-1-sjg@chromium.org>
References: <20250209020136.4108987-1-sjg@chromium.org>
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

Provide a function which sets this pointer, for use in the EFI app.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/include/asm/global_data.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/global_data.h b/arch/x86/include/asm/global_data.h
index 06bd80ccc13..1bd1fa92078 100644
--- a/arch/x86/include/asm/global_data.h
+++ b/arch/x86/include/asm/global_data.h
@@ -142,6 +142,13 @@ struct arch_global_data {
 /* TODO(sjg@chromium.org): Consider using a fixed register for gd on x86_64 */
 #define gd global_data_ptr
 
+static inline void set_gd(volatile gd_t *gd_ptr)
+{
+	extern struct global_data *global_data_ptr;
+
+	global_data_ptr = (void *)gd_ptr;
+}
+
 #define DECLARE_GLOBAL_DATA_PTR   extern struct global_data *global_data_ptr
 # else
 static inline notrace gd_t *get_fs_gd_ptr(void)
-- 
2.43.0

