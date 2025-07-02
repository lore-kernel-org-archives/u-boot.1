Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8642AC83038
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBF7882F35;
	Wed,  2 Jul 2025 03:05:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D8JoJfGd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D745083082; Wed,  2 Jul 2025 03:05:23 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A345082F03
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-40a55314d06so2160943b6e.1
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418320; x=1752023120; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=YHDzfEeNlIFqL2Gnz24cugfrnPqynjDQGoyDlYrX3mw=;
 b=D8JoJfGdWGgKPFSIoSth1n0H/HT0u03CczXi6JAzyyse8qPlmz/q7caKu1qqtIv48L
 VjlTgkbdytOM14BCYjwwSg/K6zV2Tj8zVclXCsbzCZBBawFwt92KD3J+0crruUl2JGtf
 l9qwsDgh+n/qB+wzT0a7mhczbVgN2hqKXUJk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418320; x=1752023120;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YHDzfEeNlIFqL2Gnz24cugfrnPqynjDQGoyDlYrX3mw=;
 b=OSRW+6Uobw5LE9Uur0YbDQYi2jd6j+Dly60c4y2LkE2Q93efbN5gqVFfIqmvDL7lEd
 7OdiLdyaRFq0XjGvSndWwRavU2XP3IOpYqWbR3YWzDW7Mz1owYTEINUGdHI/YZK19tMX
 kX5Gda2caDK3BZCwEmpxrDeI3ei59Cf/oIn908wYGc+AnFjWs5eo9e56pH8rMEc5SyvI
 w0Pu28cW74R7IGDJ8NhgIVvAjpJPqYPnWFclO3zAtRPBlKwmnCzMHNfy2+jhhUt1BjD3
 ADoK/45FEuYeRCTpZLcScctb0UN/Ci2aom/NJXNCTXZYAZvj9axmnUZ2q39wWcc9y8Pr
 x3MA==
X-Gm-Message-State: AOJu0YxTpD5k3EwKqvpbRikDIfyXXUBZC2DDpx7f5kTcdonHG4iVZ5e+
 TSOC35ZBw8XXDzvZjrVbbMoVeIrlrvGPo4cCol9TsboatEeE1VS6729LQxcCRhGF6MCpY5J32rJ
 4YIyKiJw=
X-Gm-Gg: ASbGncuc2FJwqxq6wYUddpa8qxZ7dB0YAQVfeMNOlpgUpi4N98HDzhqWcSCsS2mIrvY
 xJDEZUEeyvmlhD8DIMIC/tYErMoB5FcwdGet+rgo8Vkvi8IALsVWroMJPXgpdhLzV/uHZ4opRhX
 YyicnFb/eTbXcvSrd4yufNikuOujkqPB48SjfRRiS6AuEEZwAWPkR9Evc5ndWBltQmYfYKpdMQc
 2Xtp7VZNIyLh0fOKmeOzvf22JPrNME6FtAiPNWPBcgCyVl/HCIX23IKvPvsoruB1/mZHWLvjI0u
 jLcQHps7H2eRmoEtO47XcHGKMllgAe41RHIwXAqJhkngcmKUix2knWbnnC1ZxdwMJK6kqMT3sNq
 GLsEF7zGlwl6lXlBaFUCcB30=
X-Google-Smtp-Source: AGHT+IHwF/ZkaNCmFMGob6109U1YfZIPB9NvXzKoFt5wkm8e34speQ7A/mV6buK2TZ03ma886vxVjQ==
X-Received: by 2002:a05:6808:1a29:b0:40a:a8ad:bc11 with SMTP id
 5614622812f47-40b887f771dmr728838b6e.17.1751418320210; 
 Tue, 01 Jul 2025 18:05:20 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b322892c8sm2312550b6e.5.2025.07.01.18.05.19
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:05:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] common/splash_source.c: Change bmp_load_addr to ulong from u32
Date: Tue,  1 Jul 2025 19:05:18 -0600
Message-ID: <20250702010518.19203-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The variable bmp_load_addr is used to hold the address in memory of
where to put the splash image (as a bmp). For 32/64bit correctness, this
needs to be a ulong and not u32 today.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 common/splash_source.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/common/splash_source.c b/common/splash_source.c
index 2df78a4f2d76..0710e302ba1f 100644
--- a/common/splash_source.c
+++ b/common/splash_source.c
@@ -26,7 +26,7 @@ DECLARE_GLOBAL_DATA_PTR;
 
 #ifdef CONFIG_SPI_FLASH
 static struct spi_flash *sf;
-static int splash_sf_read_raw(u32 bmp_load_addr, int offset, size_t read_size)
+static int splash_sf_read_raw(ulong bmp_load_addr, int offset, size_t read_size)
 {
 	if (!sf) {
 		sf = spi_flash_probe(CONFIG_SF_DEFAULT_BUS,
@@ -40,7 +40,7 @@ static int splash_sf_read_raw(u32 bmp_load_addr, int offset, size_t read_size)
 	return spi_flash_read(sf, offset, read_size, (void *)(uintptr_t)bmp_load_addr);
 }
 #else
-static int splash_sf_read_raw(u32 bmp_load_addr, int offset, size_t read_size)
+static int splash_sf_read_raw(ulong bmp_load_addr, int offset, size_t read_size)
 {
 	debug("%s: sf support not available\n", __func__);
 	return -ENOSYS;
@@ -48,7 +48,7 @@ static int splash_sf_read_raw(u32 bmp_load_addr, int offset, size_t read_size)
 #endif
 
 #ifdef CONFIG_CMD_NAND
-static int splash_nand_read_raw(u32 bmp_load_addr, int offset, size_t read_size)
+static int splash_nand_read_raw(ulong bmp_load_addr, int offset, size_t read_size)
 {
 	struct mtd_info *mtd = get_nand_dev_by_index(nand_curr_device);
 	return nand_read_skip_bad(mtd, offset,
@@ -57,14 +57,14 @@ static int splash_nand_read_raw(u32 bmp_load_addr, int offset, size_t read_size)
 				  (u_char *)bmp_load_addr);
 }
 #else
-static int splash_nand_read_raw(u32 bmp_load_addr, int offset, size_t read_size)
+static int splash_nand_read_raw(ulong bmp_load_addr, int offset, size_t read_size)
 {
 	debug("%s: nand support not available\n", __func__);
 	return -ENOSYS;
 }
 #endif
 
-static int splash_mmc_read_raw(u32 bmp_load_addr, struct splash_location *location,
+static int splash_mmc_read_raw(ulong bmp_load_addr, struct splash_location *location,
 			       size_t read_size)
 {
 	struct disk_partition partition;
@@ -89,7 +89,7 @@ static int splash_mmc_read_raw(u32 bmp_load_addr, struct splash_location *locati
 }
 
 static int splash_storage_read_raw(struct splash_location *location,
-			       u32 bmp_load_addr, size_t read_size)
+			       ulong bmp_load_addr, size_t read_size)
 {
 	u32 offset;
 
@@ -111,7 +111,7 @@ static int splash_storage_read_raw(struct splash_location *location,
 	return -EINVAL;
 }
 
-static int splash_load_raw(struct splash_location *location, u32 bmp_load_addr)
+static int splash_load_raw(struct splash_location *location, ulong bmp_load_addr)
 {
 	struct bmp_header *bmp_hdr;
 	int res;
@@ -252,7 +252,7 @@ static inline int splash_umount_ubifs(void)
 
 #define SPLASH_SOURCE_DEFAULT_FILE_NAME		"splash.bmp"
 
-static int splash_load_fs(struct splash_location *location, u32 bmp_load_addr)
+static int splash_load_fs(struct splash_location *location, ulong bmp_load_addr)
 {
 	int res = 0;
 	loff_t bmp_size;
@@ -342,7 +342,7 @@ static struct splash_location *select_splash_location(
 }
 
 #ifdef CONFIG_FIT
-static int splash_load_fit(struct splash_location *location, u32 bmp_load_addr)
+static int splash_load_fit(struct splash_location *location, ulong bmp_load_addr)
 {
 	int res;
 	int node_offset;
@@ -439,7 +439,7 @@ int splash_source_load(struct splash_location *locations, uint size)
 	struct splash_location *splash_location;
 	char *env_splashimage_value;
 	char *devpart;
-	u32 bmp_load_addr;
+	ulong bmp_load_addr;
 
 	env_splashimage_value = env_get("splashimage");
 	if (env_splashimage_value == NULL)
-- 
2.43.0

