Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B8C606A893
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ucbCG023;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=XOBh8G9T
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8BAC80F65;
	Mon, 16 Nov 2026 14:01:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tF_5GMeUvcqQ; Mon, 16 Nov 2026 14:01:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B0BBA80EF9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794837676;
	b=DIcB+MfAXSCQlW5VTziVkGovic/XA81AR8YC0Xn43qMGipM8x4lWw7hOsuStnsVQaNYG
	 l3eJrtGD1qia2mhoXM69tlT1aFled7A61kwqPt/lkolRPyUommbDt8LkjAwN+9RJ2TAFa
	 bESM9ROobn2u6N04qQoQMgq/KlTD00JjWHdLtzJp5A+UvXiD38hQNsGP6SBtCssxXxPC9
	 9ZhDVbDEZi5OWXaQCzt8cPzx4t6Pa/7P7incwkad8IXlhscIXA7yZMNgeEKU03/ALryAH
	 YwUQCtGDmXYCmxa4FvUTjCC/+0iJg1j40qb29jGmxNF1yMZgW76FG9TVbdBBwsB5BdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794837676;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=SVNmdJopW68+0PQQfvU19swwxMZfupLyP4Qx7LHqo74=;
	b=HHGKBaKG2wQGz5cNPretZX+YmlGj6pVUoeJ5lv9RTGyPZCV9tEPHoaSKpGfT6riy5X/7
	 maunVHZkubhxKec7qHiIisq3NE7nt2h53/ZniHyM4Fjz+D4ts81ijBb46OIgerhIHuY+A
	 Hcbb7dD5sBAKNpExyXUiWcPKg8p5U1epOyu4cIAJdOZ/GlI14SYEuMvgS8tux232OXnq8
	 7reTXcpXRqcFV3VFREYJb4loT9Bm+zpF7TGdYT/Dggu2bzj1QREb25ShftMqsL8opwTqk
	 Y9JidmeG9DePgSJJlEoWOjmSZMbux/nw4CEr/8bOXDBgwD69twNAg9E+1dAOc9dPWJA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794837676;
	bh=SVNmdJopW68+0PQQfvU19swwxMZfupLyP4Qx7LHqo74=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ucbCG023AXz2m8H42H4ayDgRIhaVfvwoTAJt5XDSEGVqhlckx5trNX97gZCRVST6N
	 BJ46ZFLXaJwBYUGuo/3+rP/1k1S10BBh1LVYsjBvw76nBRz0T3rkpxQ3F3GMGR+P0B
	 foeNl5ZdNk+fhx1wLuKVWbY6RoCAP2unl5JCx27txdAkYiAg7cJvUh9xAvZcE6KwCk
	 N/KUt5XPYeKzj5aYEWdHAk7lEL120+1pnvSZIUp4z5nRpePjRn32DjvB1pGhc8e5KN
	 fWivg/qmmembwzzTqx7g3JUMydHod0cYHlUZdGHnr69I7LyETwJFUqZb8+J7dx/PBt
	 c4Ace+B/ijYkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0BBA80EF9;
	Mon, 16 Nov 2026 14:01:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B3BC12FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:01:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B030040706
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:01:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3i_G-xLOBC5v for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 14:01:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 72DF44069A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=XOBh8G9T
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 72DF44069A
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:01:11 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4a2f4ca0dcfso105436f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794837669; x=1795442469;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SVNmdJopW68+0PQQfvU19swwxMZfupLyP4Qx7LHqo74=;
 b=XOBh8G9TDKDiCLFjtsl5p6PSgRX4PtPggY4ExUBXEe0eWPe0MbxfB7mT21iCAJ7d4E
 Ox9Ygfl5cEBaNqR/DCY5bhyric+m0EQfd6z3Ye4G/tBNLAMSGLxJLWZ6PJwy1UXL0gt7
 iy99mUGFGPbmicBjIRdh5NUCXeBZemVN4VII3L8fOG0Z/RcwO2zNOmeNimm16Ew0Mk6q
 H+CuM1UHiYMGPxXxXv7bPlBJ9KwRXii3ym+yA7LS/lxJWb3yJHvqtgbGbsJBFu78BWap
 W664t/064FMt3TLTw79myIN+2dtrnQFOhNze1tw98fCOg8OaPGttJhDxCfywNWjzcAHN
 ICLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794837669; x=1795442469;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SVNmdJopW68+0PQQfvU19swwxMZfupLyP4Qx7LHqo74=;
 b=C1ed7woM2I2qLUcrDpWIhPAsYVwQk7WJLkvSAuLN6Nnco0XQSCsYJOvQuodvYNJP0i
 sz8q64x2o7veEr1SvIQ2Dd4bUW7JUJlPzxuLfZnS/eqmUGzscedBigc4acFKIxfzgf+t
 Scyr0uIoLDPe5bq8qNPoIROFiB5z9PS7J0tWUVN1YxRi6hcgkDs3hc5xV/vsHAn2P52G
 3oOiJC/qaeBtH5Ki2/pWhdQQcE0lVzCEgf2P/gdeOiJIWKfdfehXvpDw7R9veKoY0XF/
 41dvs9nNYd8RsjJHhm6KI5N2b2IKuUGyG0izZfoaa8qkuJdByP2IRMOAGU8QG9n/Pugp
 PAvQ==
X-Gm-Message-State: APuU4Z+zwiAHIaaAilZCdwmw856ohLI9IBelSRdypZKvaYFqfzdiKuBd
 NA5F3FVfQaLYbFnbqoVjBQaEStVP7aC8pULlSHDNpb70tnOCQJQTPszYmqEUCmKny3M=
X-Gm-Gg: AZFdTZfIpCUDnHn4GvF9j2ng91tQhJA3/CpEnx7l85nw8un7G/xWzt1RLusfG0ec1ks
 ZMVGnitsqMev1CX+1kmStwiXxuIIocFNMDOnLeT2RaEhVAg3cnnXmS9mvoN9yUBKsNzMLIrlB+A
 KV6h9N261/Xwgcxpsd3vvwKZ4BSxrnxRi+RqkB7eM1BWiONDKE5EqgvQyGe/bE06MaGmL7BIyAR
 qSQLDH6sIZjMNehBbYd2WIeTZhFluCAz4F4RoSLkP1e6A61g6vl/hjk3DTj2QHvVy5Iw8JKbJqw
 323dmzSGZ51DhdDMtprAfRhZqeiPOehGmJREalb0z59F4dCTQNTchsVdWXAV+NgJPlz15lymMnZ
 cqFAI4U1nSoTZIoeAzqVMqn596ApWw++S8uinsQRLf6uodyjQL7kJuBd+z01fIkC4DZMkG2XXip
 Gk+rukgiYcPEC4y4Et6bR3L6xB2XXJR6j+TQ6yUo097D2F/Y0Ztxudz8PjXcPY18H5KJyYpI3bR
 +3VlGAbD1jEccZHUxkJ7IR8UtbUGfqntXEXxLA8wOvl83ZRroYC73rZqES5/KEUPJTE3oqsld1C
 LB4fhXlPlf135f77RsM23ePIv5q96GgI4V+6huwn5/wsXRaFl9fozoR4EMUBPJnXgS2AaSTvyDx
 1AKTReYKJ3Wo2oFTqwWykJIMTJyxL/IP/vx3xhmClRuFC93Ev067nirM9cLqZ7tROF/c=
X-Received: by 2002:a05:6000:2886:b0:48b:69d4:bb35 with SMTP id
 ffacd0b85a97d-49cfc832e91mr21515612f8f.12.1794837669475; 
 Mon, 16 Nov 2026 06:01:09 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c69406640sm22119355f8f.12.2026.11.16.06.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:01:08 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 16 Nov 2026 15:00:53 +0100
Subject: [PATCH v3 7/7] spl: fastboot: support raw U-Boot images
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ccaione-upstream-spl-fastboot-boot-v3-7-7b39e7a348c6@baylibre.com>
References: <20261116-ccaione-upstream-spl-fastboot-boot-v3-0-7b39e7a348c6@baylibre.com>
In-Reply-To: <20261116-ccaione-upstream-spl-fastboot-boot-v3-0-7b39e7a348c6@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>, 
 Rob Herring <robh@kernel.org>, York Sun <york.sun@nxp.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Boards with fixed U-Boot load and entry addresses do not need an image
container for RAM boot. Allow raw downloads when SPL_RAW_IMAGE_SUPPORT
is enabled, using the board's existing address configuration and the
completed download length.

Keep recognized FIT and legacy images on their respective validation
paths, so an invalid container cannot fall back to raw execution.

Reject raw downloads when SPL FIT signature verification is enabled
to prevent bypassing that verification with an unsigned image.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 common/spl/spl_ram.c      | 28 ++++++++++++++++++++++++---
 doc/android/fastboot.rst  |  9 ++++++---
 drivers/fastboot/Kconfig  |  2 +-
 test/image/spl_fastboot.c | 48 ++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 75 insertions(+), 12 deletions(-)

diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
index d93f4526d5f..211e439db60 100644
--- a/common/spl/spl_ram.c
+++ b/common/spl/spl_ram.c
@@ -52,21 +52,43 @@ int spl_ram_load_fit(struct spl_image_info *spl_image, void *fit, size_t size)
 	return spl_load_simple_fit(spl_image, &load, 0, fit);
 }
 
+static int spl_ram_load_raw(struct spl_image_info *spl_image, void *buf,
+			    size_t size)
+{
+	if (CONFIG_IS_ENABLED(FIT_SIGNATURE))
+		return -EPERM;
+	if (!IS_ENABLED(CONFIG_SPL_RAW_IMAGE_SUPPORT))
+		return -ENOEXEC;
+	if (!size || size == SIZE_MAX)
+		return -EINVAL;
+	if (size > CONFIG_SYS_BOOTM_LEN)
+		return -EFBIG;
+
+	spl_set_header_raw_uboot(spl_image);
+	if (size > ULONG_MAX - spl_image->load_addr)
+		return -EOVERFLOW;
+	spl_image->size = size;
+	memmove(map_sysmem(spl_image->load_addr, size), buf, size);
+	return 0;
+}
+
 int spl_ram_load(struct spl_image_info *spl_image, void *buf, size_t size)
 {
 	struct legacy_img_hdr *header = buf;
 	struct spl_ram_image image = { .data = buf, .size = size };
 	struct spl_load_info load;
 
-	/* Require a complete magic word to identify a headered image. */
+	/* A buffer too short for a magic word can only be a raw image. */
 	if (size < sizeof(header->ih_magic))
-		return -EINVAL;
+		return spl_ram_load_raw(spl_image, buf, size);
 
 	/* FIT images can contain multiple payloads with separate load addresses. */
 	if (image_get_magic(header) == FDT_MAGIC)
 		return spl_ram_load_fit(spl_image, buf, size);
+
+	/* Only unknown magic selects raw; recognized formats keep their errors. */
 	if (image_get_magic(header) != IH_MAGIC)
-		return -ENOEXEC;
+		return spl_ram_load_raw(spl_image, buf, size);
 
 	/* Legacy images need a complete header and an uncompressed payload. */
 	if (CONFIG_IS_ENABLED(FIT_SIGNATURE))
diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
index 73241e717b8..73b7825d726 100644
--- a/doc/android/fastboot.rst
+++ b/doc/android/fastboot.rst
@@ -157,9 +157,12 @@ FIT verification uses the board's existing SPL configuration.
 ``CONFIG_SPL_LEGACY_IMAGE_FORMAT`` also permits uncompressed legacy U-Boot
 images, using their header's load address and entry point. Legacy CRC checks
 follow ``CONFIG_SPL_LEGACY_IMAGE_CRC_CHECK``.
-With ``CONFIG_SPL_FIT_SIGNATURE``, legacy downloads are rejected to prevent
-bypassing FIT verification.
-Raw U-Boot binaries are not supported.
+``CONFIG_SPL_RAW_IMAGE_SUPPORT`` permits a raw ``u-boot.bin``. SPL uses its
+configured or binman-provided load address and entry point, and loads exactly
+the downloaded bytes. The image must match that address and firmware handoff
+contract; raw images carry no size, checksum or signature of their own.
+With ``CONFIG_SPL_FIT_SIGNATURE``, legacy and raw downloads are rejected to
+prevent bypassing FIT verification.
 
 The loader accepts these images directly or inside the Android v0 wrapper
 added by the standard fastboot client; separate ramdisk and second-stage
diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index ea3be618470..b56cd4fafb3 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -71,7 +71,7 @@ config SPL_FASTBOOT_BOOT
 	bool "Boot images downloaded with fastboot in SPL"
 	depends on ARM || MIPS || RISCV || SANDBOX
 	depends on SPL_FASTBOOT && SPL_FRAMEWORK
-	depends on SPL_LOAD_FIT || SPL_LEGACY_IMAGE_FORMAT
+	depends on SPL_LOAD_FIT || SPL_LEGACY_IMAGE_FORMAT || SPL_RAW_IMAGE_SUPPORT
 	depends on !SPL_LOAD_FIT_FULL && !SPL_USB_SDP_SUPPORT
 	help
 	  Enable fastboot boot to load a downloaded image through the SPL
diff --git a/test/image/spl_fastboot.c b/test/image/spl_fastboot.c
index 1263416ba8d..b519ac8911f 100644
--- a/test/image/spl_fastboot.c
+++ b/test/image/spl_fastboot.c
@@ -124,10 +124,13 @@ static int check_images(struct unit_test_state *uts, void *image, size_t size,
 					   NULL, NULL));
 	ut_assertok(check_download(uts, image, size - 1, NULL, NULL));
 
-	magic = fdt_magic(image);
-	fdt_set_magic(image, 0);
-	ut_assertok(check_download(uts, image, size, NULL, NULL));
-	fdt_set_magic(image, magic);
+	if (!IS_ENABLED(CONFIG_SPL_RAW_IMAGE_SUPPORT) ||
+	    CONFIG_IS_ENABLED(FIT_SIGNATURE)) {
+		magic = fdt_magic(image);
+		fdt_set_magic(image, 0);
+		ut_assertok(check_download(uts, image, size, NULL, NULL));
+		fdt_set_magic(image, magic);
+	}
 
 	/* The Android envelope is independent of the payload format. */
 	if (type != FIT_INTERNAL)
@@ -139,7 +142,7 @@ static int check_images(struct unit_test_state *uts, void *image, size_t size,
 	ut_assertok(check_download(uts, wrapped, wrapped_size, info, data));
 	ut_assertok(check_download(uts, wrapped, sizeof(*hdr) - 100, NULL, NULL));
 	ut_assertok(check_download(uts, wrapped, wrapped_size - 1, NULL, NULL));
-	/* Android padding must not make a truncated FIT payload look complete. */
+	/* Android padding must not make a truncated payload look complete. */
 	hdr->kernel_size = cpu_to_le32(size - 1);
 	ut_assertok(check_download(uts, wrapped, wrapped_size, NULL, NULL));
 	hdr->kernel_size = cpu_to_le32(size);
@@ -190,3 +193,38 @@ out:
 SPL_IMG_TEST(spl_test_fastboot, FIT_INTERNAL, 0);
 SPL_IMG_TEST(spl_test_fastboot, FIT_EXTERNAL, 0);
 SPL_IMG_TEST(spl_test_fastboot, LEGACY, 0);
+
+static int spl_test_fastboot_raw(struct unit_test_state *uts)
+{
+	u8 image[31], buffer[sizeof(image)], *dest;
+	struct spl_image_info expected = {}, loaded = {};
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_SPL_RAW_IMAGE_SUPPORT))
+		return -EAGAIN;
+	generate_data(image, sizeof(image), __func__);
+	spl_set_header_raw_uboot(&expected);
+	dest = map_sysmem(expected.load_addr, sizeof(image) + 1);
+	dest[sizeof(image)] = 0xa5;
+	fastboot_init(buffer, sizeof(buffer));
+	ut_assertok(download_image(uts, image, sizeof(image)));
+	ut_assertok(run_fastboot_command(uts, "boot", FASTBOOT_COMMAND_BOOT, "OKAY"));
+	fastboot_boot();
+	ret = spl_fastboot_load(&loaded);
+	fastboot_init(NULL, 0);
+	ut_asserteq(0xa5, dest[sizeof(image)]);
+	if (CONFIG_IS_ENABLED(FIT_SIGNATURE)) {
+		ut_asserteq(-EPERM, ret);
+		ut_asserteq(0, loaded.size);
+		return 0;
+	}
+	ut_assertok(ret);
+	ut_asserteq(expected.load_addr, loaded.load_addr);
+	ut_asserteq(expected.entry_point, loaded.entry_point);
+	ut_asserteq(expected.os, loaded.os);
+	ut_asserteq(sizeof(image), loaded.size);
+	ut_asserteq_mem(image, dest, sizeof(image));
+	return 0;
+}
+
+SPL_TEST(spl_test_fastboot_raw, 0);

-- 
2.56.0

