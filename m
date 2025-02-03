Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2689FC02196
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:46:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDD3480834;
	Mon,  3 Feb 2025 18:44:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jhivj2ss";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40BF780840; Mon,  3 Feb 2025 18:44:25 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D9CA800B3
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:44:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5fc0c06e1deso2357669eaf.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604661; x=1739209461; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3dBno9de5osdQ+2uj9MGu4F5Py4PmaR9wHTWUDeIM6o=;
 b=jhivj2ssHwfJLpwmXEs8KMbZmeW3joDeLHDTNF7JCvxui28KZ5+A14AaiI01w+hBnY
 nxSUgSgLFuRTcDfCTVIYUClelCieGxHYW6h9hMmeicC5rk+aHfKrKROKuhCk1tCN3HgX
 tQiLTFEKHeObhFVn1I69nA+Oja86Y4MboEDwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604661; x=1739209461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3dBno9de5osdQ+2uj9MGu4F5Py4PmaR9wHTWUDeIM6o=;
 b=mj+KsJes7B+a9C/0QZTfkle8UpuAXW8T09MSM5pa2aSBJJwzYktYKPcZ3vN0jKhk1k
 zXGMHE/4dU9hmZ0DU2NpGDgnkJpfJ0elDY5qAGpsLTseHHxqfa7GjLqvmAWzT37Zz5c/
 NX6hJHgQF2MatzP/FqVBpWaiw/9nN+/RUkfebrszkZ5dUMEuMdxwkpZACC0W52uU0w9f
 l0aEUmA9wmZY+TV9+5uiUYpO7GFwie7EmZWGwrqlQH5IAELyUDPTBPtgX5fwfQClZblX
 wIWmZXOSQ/8t9cl0xpOi5H5vWXznqawRuuXG0fx58YUu32redCYqyfwQzN5F9glNpr8Y
 Idgw==
X-Gm-Message-State: AOJu0YyVC5GgxpgaKo+d5J1BHTEX/C428+vcKtpowanyB5aFrJQGAST1
 RLa7ytW5BaV/MgPhN4dGsdmS6CgPdYHJJoLw18hatCPO63W3xwc9F2+zGAPwc83EUaRcM3GElwc
 =
X-Gm-Gg: ASbGnctFL4o4VLjJPkRiIsY6QKk50+Jo3VxneD0ikbbvQEu11zUbltDlxZcvHDTdKoN
 MwWLcN9EEPsZNb0eM59Snk4ZGPipEzdGIf6o7SQ0On5cpMEtZxZJG78fOU8N1DkF9vbQVQQR4aG
 PwVjzmM+d9C13/Kn6K5MaYfZKqXUVsX+rbS3RrbCE9hJv3+/oayP3cXvdWCO9LIombhEa1eBFyK
 SAT3mq5rPIeNwDmSwGSJ5HKad1TZKQP6l+TqZHnnfkaQdxsEmXQByRtHprVXQXF9HIYwSiZEG6B
 SYhFJSuPgXmYoFmZz6s607Q4/JEDcoOWmXimSo3duFL/WWWh3CLB
X-Google-Smtp-Source: AGHT+IEQ5+1kf9iOMCaHA27ucvAPe5QxrE90jqgeV4+etaPBEKcOsFQiYCOsFRbRIGhssQjzy/Poeg==
X-Received: by 2002:a05:6808:1794:b0:3eb:623e:8503 with SMTP id
 5614622812f47-3f323a7e419mr15283453b6e.23.1738604661278; 
 Mon, 03 Feb 2025 09:44:21 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:44:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 25/32] efi: arm: Adjust how the monitor length is calculated
Date: Mon,  3 Feb 2025 10:42:18 -0700
Message-ID: <20250203174245.1331464-26-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

Adjust the conditions to support the EFI app when running on ARM.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/board_f.c | 4 ++--
 common/board_r.c | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 8baaa2341a3..6426a17edc6 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -263,6 +263,8 @@ static int setup_mon_len(void)
 {
 #if defined(CONFIG_ARCH_NEXELL)
 	gd->mon_len = (ulong)__bss_end - (ulong)__image_copy_start;
+#elif defined(CONFIG_EFI_APP)
+	gd->mon_len = (ulong)_end - (ulong)image_base;
 #elif defined(__ARM__) || defined(__MICROBLAZE__)
 	gd->mon_len = (ulong)__bss_end - (ulong)_start;
 #elif defined(CONFIG_SANDBOX) && !defined(__riscv)
@@ -270,8 +272,6 @@ static int setup_mon_len(void)
 #elif defined(CONFIG_SANDBOX)
 	/* gcc does not provide _init in crti.o on RISC-V */
 	gd->mon_len = 0;
-#elif defined(CONFIG_EFI_APP)
-	gd->mon_len = (ulong)_end - (ulong)_init;
 #elif defined(CONFIG_NIOS2) || defined(CONFIG_XTENSA)
 	gd->mon_len = CONFIG_SYS_MONITOR_LEN;
 #elif defined(CONFIG_SH) || defined(CONFIG_RISCV)
diff --git a/common/board_r.c b/common/board_r.c
index c4545e9b483..3fa2d44402e 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -124,7 +124,9 @@ __weak int fixup_cpu(void)
 
 static int initr_reloc_global_data(void)
 {
-#ifdef __ARM__
+#if defined(CONFIG_EFI_APP)
+	monitor_flash_len = (ulong)_end - (ulong)image_base;
+#elif defined __ARM__
 	monitor_flash_len = _end - __image_copy_start;
 #elif defined(CONFIG_RISCV)
 	monitor_flash_len = (ulong)_end - (ulong)_start;
-- 
2.43.0

