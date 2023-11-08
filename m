Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F7BC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E0DF87745;
	Wed,  8 Nov 2023 17:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F8BbdykC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B94BD87741; Wed,  8 Nov 2023 17:49:44 +0100 (CET)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com
 [IPv6:2607:f8b0:4864:20::a35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C9D88770C
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-4a06fb5331bso2624654e0c.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462170; x=1700066970; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M4O93SIEutyf2e5iQZQwfIsnGixZNdti9wmiK2pAFk4=;
 b=F8BbdykCE3xEFpApqytbtKvy8enQ6ypCTrCsnzFXef26uRv9NBy89Aq+RUHTsAn08j
 Jbr8uuGi020Muhh2/j88RJUf9xYmlz5DtjpPTvqgMCRoHExlOtgE1I9fvMqyG4OdSYYQ
 //95Tuazq1Z2nE9aRb/OazwVnu/TGFzyTQHSKrCOOMwdsIxk8XGqFRRMqwZZV8L1oa0C
 feyzkiY51J1mTqzqPNKqGt9q9LYcY0FR2AdpKAjb54mmsofgLTKl6uQuZakEATY2E8fE
 0QN1XULXcMy/LJfxlu1EY9vzItEGZYUD0/Qdmd6Px7r3Zh2IHVj5giDphqtLSbJYvMtb
 IZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462170; x=1700066970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M4O93SIEutyf2e5iQZQwfIsnGixZNdti9wmiK2pAFk4=;
 b=chszI39yBaBJQhndfxCQ/IWce/pwFkptbgNT8vaoKeAhXMk0xqLF4Gf2EkrErCIDi1
 zZtd4lo1L/3oydfcqcjUT1m4TqFt5p5c2hHF9WUO0F3jh7s271GvNONLkkb3Le8ntYbs
 JCCgjqbdUUV8rUDCn4y5VwWRV5VtDfS5P0E2lc2iZnJ7a+OrCVQLYAk1Cmpf/uWWXtXm
 t0S+jhQHo8hW4+90XcrSCQ5BHEhakbCRajKiZDgUU3/Tobo6JGcVNTNW9q8zMU1eePvC
 mbYXxjVFJ4/3cG7ep+6iAMEzcvAJb9sSFwUKx+Cd3z3tIciDuE2jVOgX05mN4+J5KfC9
 AEqA==
X-Gm-Message-State: AOJu0Yz47aiIl5e1KiObSU/uXB4fffYxMKypgrOLd110DSLq+mLvyMMb
 z2DwRhsr0sgfExOLAR0ifUs=
X-Google-Smtp-Source: AGHT+IHynx3iRdE7nTPQ80woiP8TUMzjC4yCe9PChASl98yFF2xcHZn94ABbkiZGEIB1iLEPy43SeQ==
X-Received: by 2002:a1f:2415:0:b0:49d:c1f5:d491 with SMTP id
 k21-20020a1f2415000000b0049dc1f5d491mr2337068vkk.15.1699462170253; 
 Wed, 08 Nov 2023 08:49:30 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 c10-20020a05621401ea00b0066d04196c3dsm1251200qvu.49.2023.11.08.08.49.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:49:29 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v7 23/26] spl: Convert semihosting to spl_load
Date: Wed,  8 Nov 2023 11:48:55 -0500
Message-Id: <20231108164858.3497420-24-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231108164858.3497420-1-seanga2@gmail.com>
References: <20231108164858.3497420-1-seanga2@gmail.com>
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

This converts the semihosting load method to use spl_load. As a result, it
also adds support for LOAD_FIT_FULL and IMX images.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

(no changes since v6)

Changes in v6:
- Explicitly initialize load_info members

Changes in v5:
- Rework to load header in spl_load

Changes in v2:
- New

 common/spl/spl_semihosting.c | 52 +++++-------------------------------
 include/spl_load.h           |  1 +
 2 files changed, 7 insertions(+), 46 deletions(-)

diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
index 9b0610b8fc8..941fa911040 100644
--- a/common/spl/spl_semihosting.c
+++ b/common/spl/spl_semihosting.c
@@ -8,18 +8,7 @@
 #include <log.h>
 #include <semihosting.h>
 #include <spl.h>
-
-static int smh_read_full(long fd, void *memp, size_t len)
-{
-	long read;
-
-	read = smh_read(fd, memp, len);
-	if (read < 0)
-		return read;
-	if (read != len)
-		return -EIO;
-	return 0;
-}
+#include <spl_load.h>
 
 static ulong smh_fit_read(struct spl_load_info *load, ulong file_offset,
 			  ulong size, void *buf)
@@ -40,8 +29,7 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
 	const char *filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
 	int ret;
 	long fd, len;
-	struct legacy_img_hdr *header =
-		spl_get_load_buffer(-sizeof(*header), sizeof(*header));
+	struct spl_load_info load;
 
 	fd = smh_open(filename, MODE_READ | MODE_BINARY);
 	if (fd < 0) {
@@ -56,38 +44,10 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
 	}
 	len = ret;
 
-	ret = smh_read_full(fd, header, sizeof(struct legacy_img_hdr));
-	if (ret) {
-		log_debug("could not read image header: %d\n", ret);
-		goto out;
-	}
-
-	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
-	    image_get_magic(header) == FDT_MAGIC) {
-		struct spl_load_info load;
-
-		debug("Found FIT\n");
-		load.read = smh_fit_read;
-		spl_set_bl_len(&load, 1);
-		load.priv = &fd;
-
-		ret = spl_load_simple_fit(spl_image, &load, 0, header);
-		goto out;
-	}
-
-	ret = spl_parse_image_header(spl_image, bootdev, header);
-	if (ret) {
-		log_debug("failed to parse image header: %d\n", ret);
-		goto out;
-	}
-
-	ret = smh_seek(fd, 0);
-	if (ret) {
-		log_debug("could not seek to start of image: %d\n", ret);
-		goto out;
-	}
-
-	ret = smh_read_full(fd, (void *)spl_image->load_addr, len);
+	load.read = smh_fit_read;
+	spl_set_bl_len(&load, 1);
+	load.priv = &fd;
+	ret = spl_load(spl_image, bootdev, &load, len, 0);
 	if (ret)
 		log_debug("could not read %s: %d\n", filename, ret);
 out:
diff --git a/include/spl_load.h b/include/spl_load.h
index 2618109cee0..2a20e866cd8 100644
--- a/include/spl_load.h
+++ b/include/spl_load.h
@@ -102,6 +102,7 @@ static inline int _spl_load(struct spl_image_info *spl_image,
 	(IS_ENABLED(CONFIG_SPL_NAND_SUPPORT) && !IS_ENABLED(CONFIG_SPL_UBI)) + \
 	IS_ENABLED(CONFIG_SPL_NET) + \
 	IS_ENABLED(CONFIG_SPL_NOR_SUPPORT) + \
+	IS_ENABLED(CONFIG_SPL_SEMIHOSTING) + \
 	0
 
 #if SPL_LOAD_USERS > 1
-- 
2.37.1

