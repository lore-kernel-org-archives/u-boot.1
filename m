Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD6BC369CB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 12:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7386E83208;
	Fri, 18 Apr 2025 14:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k7tNxyQT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B99EC831E4; Fri, 18 Apr 2025 14:51:25 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46CFB8214B
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 14:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3cfce97a3d9so7505335ab.2
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 05:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744980681; x=1745585481; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3RjGNaowiHCgWvU8zpIw+7oMiGSUSWQY6VQmuvRKOiI=;
 b=k7tNxyQTFSzi/ykpJaWzMAKFswtHnyCP+Wnaq9pJfM7P5JmJKOIU+8c0MKyi0V7WSK
 HxNYrJIlmRtG2Ygww1kSFATwB1VHAKRonyo7H69iirBJQR9wTRRIizayPFu+ZQ2ucb4S
 bG+/apMkZKjhFRrC1wQd96wLorB36CvZ5nh6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744980681; x=1745585481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3RjGNaowiHCgWvU8zpIw+7oMiGSUSWQY6VQmuvRKOiI=;
 b=NhYjPm4MHRabXe/SNUdPHqORvau+GpfR/dTQjwYFUrYPbqEKNvp0Z+IgUWgd9O/gWq
 6wqva6fAZz2fOVOrtvvpRgzJzd8idtf0/iLcHgax+aQlZxtEGsNS2gruTolatqDbdnPZ
 yCY30db7g970MtjsB3upzuVLN89+nT1TCV+Mbg4YH/ChIEEmEvK9lFvUoINpWUwROV/3
 574ix5VQZtZhtdEHSp44MtfBUShKJHNxv4YGOzFIDHz1nrCB1usYdac/6V88NG9ozkSi
 tjYenGbovr5k/q+tZpuH6d6P/nmIC+UdQD4odm7NpGGayNDxsZYgPF5eL5dKeO3EfdJw
 8ClA==
X-Gm-Message-State: AOJu0YzzPuLT4NPH0SoeGeJ8NMdtQe/ntAjA13iA5ohL8oBvDTnOuhMw
 vLvdaaG3LmtCzpcY/TDqceo0GOV7Qy2DQlNBIWjx5rvgNKxXGbT9LP9nmqBQesMUL7xti19NDNw
 =
X-Gm-Gg: ASbGncsTDWmo/zSCTIyVURkZqcOrRVhIkrr8EgXgrB4tWA/+jjSJBOi6U5hYt0W3u0v
 q0XIR/rtpCrE1KWYRb3ggt5/8gxRGjs7jeRyxTIJcz9sTDqybx8arz5zfgVsd8Y5jj5Di+rm6Ue
 +fUDpm5lcTJvCz8COa4KmSshrsTfV4OanYgS3ItmCnZgqU/ssKUntELxQt6eobiEheIJyhqiBY2
 kRkjIBuF8/x5CJ3URDO4sYqaCw8D57aYfO/BhOHi2CzSuYtMhrIQaDTr6UvvTOdhXEPO3mYMMjU
 x+9+njwTmpNV2twMNxImIQ4W8vnhYHwSkFswvcqPDGiIgegTKzAeFTT3ICpuH/2WiJ6mTfor3X0
 +Nw==
X-Google-Smtp-Source: AGHT+IH8pjn0TMAFxB9wd0z/Rvcc11Pui4vYKKvQnoXsW5T4wGLt1jGuXOBEuwPkXYixOz99U067eA==
X-Received: by 2002:a92:cd83:0:b0:3d6:d162:be12 with SMTP id
 e9e14a558f8ab-3d89428b81amr29587385ab.21.1744980680996; 
 Fri, 18 Apr 2025 05:51:20 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cc0a3sm427555173.20.2025.04.18.05.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 05:51:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 1/3] boot: Add a function to check if a linux Image is
 supported
Date: Fri, 18 Apr 2025 06:51:00 -0600
Message-ID: <20250418125111.2193434-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418125111.2193434-1-sjg@chromium.org>
References: <20250418125111.2193434-1-sjg@chromium.org>
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

