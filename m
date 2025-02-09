Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA54AC02198
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA71180C5A;
	Sun,  9 Feb 2025 03:03:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L9VBGiAQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0389A8083F; Sun,  9 Feb 2025 03:02:34 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7028780A2A
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:02:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d15bacddbdso1157125ab.1
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066550; x=1739671350; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IHMDOF5RqwzQVDbF8LmN+Bpp7P1xCyUi0kNgfW6TnjY=;
 b=L9VBGiAQwYCUe9fk1R4pAH0qV1j/HcT3b7zG0EtrrRwaX4Ffe3pKqbaAVn2J8IcHg3
 0u215nYU0lCgeBVbl3zWlvTmxryLHeh4qQsudiYyzEzwlA2cha8xSU84ZSMqSAJKlvzZ
 TQDkbw540dvNyq0ozfGc+iILYwI030+qwR8tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066550; x=1739671350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IHMDOF5RqwzQVDbF8LmN+Bpp7P1xCyUi0kNgfW6TnjY=;
 b=xKTzf/Dbw4wmLMTJdhw/SVDqs0CCYc+Kzst9spOzT0BEqvXnq40LTzby1SMbhXTMxz
 rF30yBPiRRtmvq2fSiMfJViMoPlosG88sn5l5GDqF6wq0yqj8LpaVD9y2Zk2PGpY4ixQ
 sVRmAYI5HxQhw6dX/UWuw8fr/4o0gy+PMw1bT6cFmnObhE/ifvMvb/OwZWrCjSTIOXoD
 gMlkYrvCY9yBNudMGW2fOhoobzeAnDFIck12nvf1M8HSv1mmJVgmmkL2or/IcxvUFlx3
 hsj98CEH9+TSJjmwXjYcE8aGkc4I43CHoLqtWeHJbYNJF7vsMcXOg3r5aI6xuP6bsMAd
 6jzg==
X-Gm-Message-State: AOJu0YypPMKdF13nQVD8utgTrs/bO9bDA9ki8kRDYQIRm7QptNcqo9pK
 23p+E2u5d1opmKe7kcU+HfY8xn3yZ5IhIMQJWb6xwaikzjVC2f4eXrqdJTZdZOFZlLxqwjExiPk
 =
X-Gm-Gg: ASbGncuc7E6oLLWGSjm4ANHmwtoXvGH/TxefjAPQcXGRoWWgAr8GaNik+X7RuTsk7sm
 iC3Wuh5bbnkLedy3yjoMcPh8deoW7D57RTKtobtr3Wf8KfpMuYQHvAC2JsgCiJopx+O37880GEd
 9a6TKDfXB7SbpkEKZ5hTfGoXV/GlnR3TSGtk1b88WmdrqMpTaQPpkMlCYWMpaoYf9WgbDlpWSb/
 z5NB0itxB65/AbFlyVKjhPmx1rU1C/XYv/5pyJYOrkxmXgdHdUUTqRP0vRhl1tp72iUVyY0r796
 /ea1rFHqWwClxMI0NMm6F90q2d3y9SH+79GjGCiYywp4g3puJkUf
X-Google-Smtp-Source: AGHT+IE3UuSHQKoEgQFTV3GGJyctELaKXWAsRbxM26xafK4JjyhG2F/u9bXqbg2L3DWHjexj+jChrA==
X-Received: by 2002:a92:ca4d:0:b0:3d0:e52:7d33 with SMTP id
 e9e14a558f8ab-3d13df6ad24mr79438395ab.22.1739066549740; 
 Sat, 08 Feb 2025 18:02:29 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:02:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 17/29] efi: arm: Implement access to global_data for EFI
Date: Sat,  8 Feb 2025 19:01:16 -0700
Message-ID: <20250209020136.4108987-18-sjg@chromium.org>
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

The EFI app likes to use a simple variable for global data. Implement
this for ARM (for use only with 64-bit ARM at present).

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Mention '64-bit ARM' here, rather than just 'ARM'

 arch/arm/include/asm/global_data.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index 6e4471662a3..8d51111f095 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -115,7 +115,13 @@ struct arch_global_data {
 
 #include <asm-generic/global_data.h>
 
-#if defined(__clang__) || defined(LTO_ENABLE)
+#ifdef CONFIG_EFI_APP
+
+#define DECLARE_GLOBAL_DATA_PTR   extern struct global_data *global_data_ptr
+
+#define gd global_data_ptr
+
+#elif defined(__clang__) || defined(LTO_ENABLE)
 
 #define DECLARE_GLOBAL_DATA_PTR
 #define gd	get_gd()
@@ -144,7 +150,11 @@ static inline gd_t *get_gd(void)
 
 static inline void set_gd(volatile gd_t *gd_ptr)
 {
-#ifdef CONFIG_ARM64
+#ifdef CONFIG_EFI_APP
+	extern struct global_data *global_data_ptr;
+
+	global_data_ptr = (void *)gd_ptr;
+#elif defined CONFIG_ARM64
 	__asm__ volatile("ldr x18, %0\n" : : "m"(gd_ptr));
 #elif __ARM_ARCH >= 7
 	__asm__ volatile("ldr r9, %0\n" : : "m"(gd_ptr));
-- 
2.43.0

