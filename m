Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8598C3ABA3
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 13:19:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F66181F0B;
	Thu,  1 May 2025 15:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O7cyCEs1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D510681E72; Thu,  1 May 2025 15:19:26 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8D5B8081A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 15:19:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-86135ae2a29so96649939f.2
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 06:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746105563; x=1746710363; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZjWjgSuJPkFS6p/u7pFz8UU77kJ6MUxLIYgDLjuLsrk=;
 b=O7cyCEs15hc/Bys3vMAoqE8qDMk2OmJw4Kz+Msz+aBG2FmpR7/lvnbokQpi4ZJscP+
 tHLr/uxpOFpo49K+rRGFIaVWvwtXPHUATaxXli3TXzdqctKnRqL7TTQmZXY5oT33AZMV
 MtgSXLvDFt0pZ/v5ur94KkGdirzYMvgWmpPL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746105563; x=1746710363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZjWjgSuJPkFS6p/u7pFz8UU77kJ6MUxLIYgDLjuLsrk=;
 b=abdQpqJTzNqGj0cDJV2m+oswhkShU00F43f36hkNwgQ1XBINBiLVmkqfTJkGTEvd8x
 9ct1Nv87QvCZjedVy69jMuOgaS+fm3c1DuxWKhOeSnVQh47VcKvCNzypPTKirYgkBwqa
 B4hNw5UEnQHy0NW2OD7xOlEQKeV5xMKhN/bGXzv3rUbEYM5LteLaU3Ig+/OmLLqcCDHT
 NN14lk7Bzp+iir3mu5uT40OZGjXDYn2QZsvL/l+ROzmEPTuRYiNq9jDxzD/FMqTc71gc
 EfbGfm5+R4BQTrsrkublySiOOo1Aea0Vci+x+iF0lykESF0VQ2kyIAvSOSg7YW8/T1FT
 PBLg==
X-Gm-Message-State: AOJu0YyOt/7nL9x9Zcx5UwFHSCEtNxtuj9Q4jt7dPKlVFomFSOTR/Uxm
 DUgdzQ2GuIXgTR92B80D0RHmCsbY1cHYmGUZ0vFFN4Upmhyne90gem5L+826dUaJFdZSOJZc6tg
 =
X-Gm-Gg: ASbGncsfMJeCr7D2z0P4cNy09kdJ9ohL7bCe85dtgvrUHXcJPSAw+goTVRXvUACUEam
 KhAP9NlvQ87+6wr3SGFXIS9vMgo/UwvSWKvxVulVsaUueb/m/5IntjRFYEZUDc8O8OagUAnq0TO
 Ngc0blzIGTk4MjGhWi2vemeeURfxzzzWaKNqkNBWe8dEbqBEEJuk1/UFCjER7fBRHWRJ0nRRDjN
 B/SyqUu0INcnwEUWtAYzhmRbeB466UHESaGr14ynU+gpv31EA0hOlsS/kkCq45LwzYOXs1AZ9MM
 lcaRIGeiSaLUQ7gLGlMBLtyk4ZFy1hSIZXztmgO0Exao7Fl+A8A79AnxkP7ZPy0OK8ATWqgS6Eq
 YNw==
X-Google-Smtp-Source: AGHT+IHxNaF3Ur0fpiYbh8os1VvPDIijc3Y9rL4XnmK/izNPosZtifQM++J34Hqf+50dUE1viUq7mA==
X-Received: by 2002:a05:6602:728b:b0:861:d8ca:3587 with SMTP id
 ca18e2360f4ac-86497f69743mr959473639f.4.1746105562841; 
 Thu, 01 May 2025 06:19:22 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f882fc9c2esm160328173.93.2025.05.01.06.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 06:19:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 1/3] boot: Add a function to check if a linux Image is
 supported
Date: Thu,  1 May 2025 07:18:33 -0600
Message-ID: <20250501131858.2160756-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501131858.2160756-1-sjg@chromium.org>
References: <20250501131858.2160756-1-sjg@chromium.org>
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

Move this logic into a function so we can give it a sensible name.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootm.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 0e63dd4adf3..2ed78295ead 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -654,6 +654,21 @@ static int handle_decomp_error(int comp_type, size_t uncomp_size,
 #endif
 
 #ifndef USE_HOSTCC
+
+/**
+ * booti_is_supported() - Check whether a Linux 'Image' is supported
+ *
+ * @os: OS to check
+ * Return: true if CMD_BOOTI is enabled and the arch suports this format
+ */
+static bool booti_is_supported(struct image_info *os)
+{
+	if (!IS_ENABLED(CONFIG_CMD_BOOTI) || os->os != IH_OS_LINUX)
+		return false;
+
+	return os->arch == IH_ARCH_ARM64;
+}
+
 static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 {
 	struct image_info os = images->os;
@@ -729,8 +744,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 		}
 	}
 
-	if (IS_ENABLED(CONFIG_CMD_BOOTI) && images->os.arch == IH_ARCH_ARM64 &&
-	    images->os.os == IH_OS_LINUX) {
+	if (booti_is_supported(&images->os)) {
 		ulong relocated_addr;
 		ulong image_size;
 		int ret;
-- 
2.43.0

