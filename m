Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14A6E7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B66E86E12;
	Tue, 26 Sep 2023 16:15:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VzZtTjaS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 804D186BA6; Tue, 26 Sep 2023 16:15:49 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0E2886D87
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3514bf96fd2so9291025ab.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737740; x=1696342540; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fAT6POS982jMqRObPAFlcNVGm14d6IVPGmxTG2Mo/sA=;
 b=VzZtTjaS+aECAX27Agg9w/4+9I6Q+JT4bG/+gM31KSnyZWhJCfUVe+XYkOwyoVXcUa
 Q76c2a0oY4lRfJ7kLIIljRmG+skaOvRsCV+pkJjwnStrh9k2cYr4YxBf6orgtISCVBzp
 0XeEwvIj1gk/8uPmduVATnE7jubuy+rWNQEWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737740; x=1696342540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fAT6POS982jMqRObPAFlcNVGm14d6IVPGmxTG2Mo/sA=;
 b=idH85w10NrTdCTNWu4ijABau6Yn7ODxP+Q8uY7MAsDGxWNcb7ZjKRahFR5+uL7qeQ4
 nr2FDztk9m/Got1AcfGVQk3SIfmVF7X2S25HxRF4Frdw+FHSRnLtGFsBFsXOV9W9kKrB
 D5G9PaiHcuxEd87S6Y0RmlTApC9PJuMCq6YIOBipE8K8AVzsjZW4504sGTsZcex7aZmg
 O8Oe4XGXyNCp84krtMGn8KHFtX903wV4YEKdfRqxQnnPImoNjIaUsMtYm1GOtNaGbp6R
 3BT7zFHf46PuWozXBA2qbAmB98wUvFMdjHDhfrPi+QHnZYcRz6YKalyuPfSzry55fEVn
 yAMA==
X-Gm-Message-State: AOJu0YxzKR0Fy8UX+BZnoQEjPbNJk2COwcAP8Fed5tOsff8Dt45fbqQs
 3uguFPBn5PYTP00EAs1QNGNILYlFn1LzvTucEWk=
X-Google-Smtp-Source: AGHT+IHGdHqMtKddwlg4F8QRnX6Ss/rMFmAILjuMP/pCIaSgaYPJ1Rv7J9wZAz3KLkKLDwPV2qzuTg==
X-Received: by 2002:a05:6e02:1288:b0:351:111d:9cfc with SMTP id
 y8-20020a056e02128800b00351111d9cfcmr10707831ilq.21.1695737740404; 
 Tue, 26 Sep 2023 07:15:40 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 17/44] spl: Avoid an #ifdef when printing gd->malloc_ptr
Date: Tue, 26 Sep 2023 08:14:31 -0600
Message-ID: <20230926141514.2101787-18-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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

Use an accessor in the header file to avoid this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Rebase on the new patch

Changes in v2:
- Use the same condition for both pieces to avoid possible problems

 common/spl/spl.c                  | 9 +++++----
 include/asm-generic/global_data.h | 6 ++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 8967a140041b..2c36caa856fa 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -864,10 +864,11 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	} else {
 		debug("Unsupported OS image.. Jumping nevertheless..\n");
 	}
-#if CONFIG_IS_ENABLED(SYS_MALLOC_F) && !defined(CONFIG_SPL_SYS_MALLOC_SIZE)
-	debug("SPL malloc() used 0x%lx bytes (%ld KB)\n", gd->malloc_ptr,
-	      gd->malloc_ptr / 1024);
-#endif
+	if (CONFIG_IS_ENABLED(SYS_MALLOC_F) &&
+	    !IS_ENABLED(CONFIG_SPL_SYS_MALLOC_SIZE))
+		debug("SPL malloc() used 0x%lx bytes (%ld KB)\n",
+		      gd_malloc_ptr(), gd_malloc_ptr() / 1024);
+
 	bootstage_mark_name(get_bootstage_id(false), "end phase");
 #ifdef CONFIG_BOOTSTAGE_STASH
 	ret = bootstage_stash((void *)CONFIG_BOOTSTAGE_STASH_ADDR,
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index f8fc87f1e46e..937fb12516c1 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -588,6 +588,12 @@ static_assert(sizeof(struct global_data) == GD_SIZE);
 #define gd_set_pci_ram_top(val)
 #endif
 
+#if CONFIG_VAL(SYS_MALLOC_F_LEN)
+#define gd_malloc_ptr()		gd->malloc_ptr
+#else
+#define gd_malloc_ptr()		0L
+#endif
+
 /**
  * enum gd_flags - global data flags
  *
-- 
2.42.0.515.g380fc7ccd1-goog

