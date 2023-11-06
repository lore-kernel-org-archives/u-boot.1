Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B96C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 02:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4FDF8706C;
	Mon,  6 Nov 2023 03:32:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bApkZADh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26BE386B75; Mon,  6 Nov 2023 03:27:26 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9C6386FBE
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:26:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-66d11fec9a5so22063476d6.1
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 18:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699237574; x=1699842374; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L3YNKzQh57wSdqHqzaPvwXhzRcSbhwqakd58cy11rEE=;
 b=bApkZADh+OtbGiObC3qlZEzmkPc/tWbRPwbRjytJRtf6nXQ+KTNe7IWmfvbzTYkOU+
 6c0wl1HM9K5UB/9xhbraDXgtEDVnF3qTTXmIpTfrM6Mx+VauU5stT/ii+uW8D99qFTdx
 QU7RGFiSJcQ3RrN+Aj94b6Gk33gZSlix809M6X30EBjnbo/sS32vKakeuijuKB3AQbwW
 WMB3/AYkfCk6AnoqTTOHbtqQX8AnTyXfxdG4OUCbAWSqvCrevad8ClMyeZaxEnJdVGYk
 YvvmekFwWc0A/1+hNt68nqoXfqIkkTUqtYgwtPEV14Vg9EWHXPWe4FjIZdmcEsgHUX76
 OQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699237574; x=1699842374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L3YNKzQh57wSdqHqzaPvwXhzRcSbhwqakd58cy11rEE=;
 b=rhBImZrTE7KAAjkOYcULZ2jwVhsx18M5FEQZyVVAoybK7ekGI0kjrcV/PjqicodIUN
 9ap7fX/GW/bBWTahktg8FcL6YyDAMF/4epjfxG9WvqSkJe0qTT81nvbkXmDLqh7F6OUc
 XS3tklypNHQC441Y1+2S09khdlWq1gbJrnBSvN7EmHihg1sSilJXXaQYlLc0nUZyVWcC
 ufVSTzNKIJrKMzh3KLxCqJ1nOqiROX9dV5v4gQWlk49ZnIHQH7Wtk9cmm9selFAz+S2X
 8Hp/AYHiTbeWiANPCN3xqIY25cKRypQ8l21Qcgi2UMHcGjK54KToGK/2p6yRKspFDtoP
 fRUw==
X-Gm-Message-State: AOJu0YxWESzT5qRF9SKGMNW8UDYanNqzr/ZgOxPWmMrf3AUtdWJjwotP
 SKiagJHgbk29peNXMP0Od+UfK46swl45jQ==
X-Google-Smtp-Source: AGHT+IExygaHgIktryPm38ZRuKxtY+cD8sc0MAkzaVh/4mUfnsQsNQW/XNL2PL1l9KsKtJ9y1ZlZSw==
X-Received: by 2002:a05:6214:27ef:b0:671:8612:170e with SMTP id
 jt15-20020a05621427ef00b006718612170emr23327576qvb.23.1699237574684; 
 Sun, 05 Nov 2023 18:26:14 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 pm24-20020ad446d8000000b0066d1b4ce863sm3040926qvb.31.2023.11.05.18.26.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 18:26:14 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <seanga2@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Stefano Babic <sbabic@denx.de>, uboot-imx@nxp.com
Subject: [PATCH v6 07/25] spl: Take advantage of bl_len's power-of-twoness
Date: Sun,  5 Nov 2023 21:25:45 -0500
Message-Id: <20231106022603.3405551-8-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106022603.3405551-1-seanga2@gmail.com>
References: <20231106022603.3405551-1-seanga2@gmail.com>
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

bl_len must be a power of two, so we can use ALIGN instead of roundup and
similar tricks to avoid divisions.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v6:
- New

 common/spl/spl_fit.c           | 2 +-
 common/spl/spl_imx_container.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 70d8d5942d9..6084ead0919 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -194,7 +194,7 @@ static int get_aligned_image_overhead(struct spl_load_info *info, int offset)
 	if (info->filename)
 		return offset & (ARCH_DMA_MINALIGN - 1);
 
-	return offset % info->bl_len;
+	return offset & (info->bl_len - 1);
 }
 
 static int get_aligned_image_size(struct spl_load_info *info, int data_size,
diff --git a/common/spl/spl_imx_container.c b/common/spl/spl_imx_container.c
index 127802f5cb7..1cc51782766 100644
--- a/common/spl/spl_imx_container.c
+++ b/common/spl/spl_imx_container.c
@@ -33,13 +33,13 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 	images = (struct boot_img_t *)((u8 *)container +
 				       sizeof(struct container_hdr));
 
-	if (images[image_index].offset % info->bl_len) {
+	if (!IS_ALIGNED(images[image_index].offset, info->bl_len)) {
 		printf("%s: image%d offset not aligned to %u\n",
 		       __func__, image_index, info->bl_len);
 		return NULL;
 	}
 
-	sectors = roundup(images[image_index].size, info->bl_len) /
+	sectors = ALIGN(images[image_index].size, info->bl_len) /
 		info->bl_len;
 	sector = images[image_index].offset / info->bl_len +
 		container_sector;
@@ -69,7 +69,7 @@ static int read_auth_container(struct spl_image_info *spl_image,
 	u32 sectors;
 	int i, size, ret = 0;
 
-	size = roundup(CONTAINER_HDR_ALIGNMENT, info->bl_len);
+	size = ALIGN(CONTAINER_HDR_ALIGNMENT, info->bl_len);
 	sectors = size / info->bl_len;
 
 	/*
@@ -103,7 +103,7 @@ static int read_auth_container(struct spl_image_info *spl_image,
 	debug("Container length %u\n", length);
 
 	if (length > CONTAINER_HDR_ALIGNMENT) {
-		size = roundup(length, info->bl_len);
+		size = ALIGN(length, info->bl_len);
 		sectors = size / info->bl_len;
 
 		free(container);
-- 
2.37.1

