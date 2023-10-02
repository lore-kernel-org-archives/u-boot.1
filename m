Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F0CE784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F383870E9;
	Mon,  2 Oct 2023 03:17:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P3Is6o1w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1D86870CE; Mon,  2 Oct 2023 03:17:14 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43EFE87217
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:17:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-35130c8bc79so43206775ab.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209370; x=1696814170; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YaXyl8l9IE1Ay3mZ4aDEW89FI2M64gvXbwCJx6dVXaM=;
 b=P3Is6o1wGpVIry7i5W08F+pY9JQSggJib7Op954SvMGgS1G9iwtmkf51NV6smhAimK
 dsTfTL21S/clAlezyDYONNHHhTTjbkWEeQx18Q7nLsD2v5iFGwE9ubXl4+zSyeKTxhvb
 wJm8P0m0rf7Bh8Af1H8IZSB5XOOz4UgqzCayw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209370; x=1696814170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YaXyl8l9IE1Ay3mZ4aDEW89FI2M64gvXbwCJx6dVXaM=;
 b=Hnb9uXMcPr3U6K/RwO0UXNG/NUAgQuoe9NgOwUil7hLJZBgjsKX1LS1TXnGH8Xk5q8
 zSvi4mx7cjKALEokE6TtHta1s7QyaUW4kmA11bNCuot9CRqf1xhEaIhj8vxeMMCZjSZm
 qa5anmqlY0h1Z4u0xEFgQanSDZHsh41riJA0pro62BCEr0VT0qQc3e0Irfhb3Pa+hSPr
 7iIaP2qNWTvbxfSaAKiNOrx8Bt1D76JFzGHih9hbdo+IYVULB2JkA91X3oG2rWPqbs43
 NJaToefZ+w4CCAfnUFvBoYKph7gGH5vzYkRTl5sMleP1S5iR1pFNCCE9IKm4pQxCQxjO
 545A==
X-Gm-Message-State: AOJu0Yz7v6PKZflSGdCJe2H0yGxCP4HV2gskelyzZjmuXzk+e8PC0xuF
 COaLkwSTpN1XBPJHLFkgYOcMB1nIKqxvXVv+s9g=
X-Google-Smtp-Source: AGHT+IEnH7WbdMi8BF09xJtY3kryQECYXgHGRk+CY6HqbvHS4Gzt8r9WPw6Nv6PkHXv3TZRR/3D0LQ==
X-Received: by 2002:a05:6e02:1a62:b0:34f:bac9:f53d with SMTP id
 w2-20020a056e021a6200b0034fbac9f53dmr12776003ilv.17.1696209370365; 
 Sun, 01 Oct 2023 18:16:10 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH 07/34] test: bdinfo: Add missing asserts
Date: Sun,  1 Oct 2023 19:15:17 -0600
Message-ID: <20231002011553.463514-8-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

Calling into sub-test functions should be done using ut_assertok() so
that the test exits immediately on failure. Add those which are
missing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd/bdinfo.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 0f09a5a3e1db..9ada7523fc27 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -136,8 +136,8 @@ static int lmb_test_dump_region(struct unit_test_state *uts,
 static int lmb_test_dump_all(struct unit_test_state *uts, struct lmb *lmb)
 {
 	ut_assert_nextline("lmb_dump_all:");
-	lmb_test_dump_region(uts, &lmb->memory, "memory");
-	lmb_test_dump_region(uts, &lmb->reserved, "reserved");
+	ut_assertok(lmb_test_dump_region(uts, &lmb->memory, "memory"));
+	ut_assertok(lmb_test_dump_region(uts, &lmb->reserved, "reserved"));
 
 	return 0;
 }
@@ -188,7 +188,7 @@ static int bdinfo_test_move(struct unit_test_state *uts)
 	ut_assertok(test_num_l(uts, "fdt_size", (ulong)gd->fdt_size));
 
 	if (IS_ENABLED(CONFIG_VIDEO))
-		test_video_info(uts);
+		ut_assertok(test_video_info(uts));
 
 	/* The gd->multi_dtb_fit may not be available, hence, #if below. */
 #if CONFIG_IS_ENABLED(MULTI_DTB_FIT)
@@ -199,7 +199,7 @@ static int bdinfo_test_move(struct unit_test_state *uts)
 		struct lmb lmb;
 
 		lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
-		lmb_test_dump_all(uts, &lmb);
+		ut_assertok(lmb_test_dump_all(uts, &lmb));
 		if (IS_ENABLED(CONFIG_OF_REAL))
 			ut_assert_nextline("devicetree  = %s", fdtdec_get_srcname());
 	}
@@ -224,6 +224,9 @@ static int bdinfo_test_move(struct unit_test_state *uts)
 		ut_assertok(test_num_l(uts, "malloc base", gd_malloc_start()));
 	}
 
+	if (IS_ENABLED(CONFIG_X86))
+		ut_check_skip_to_linen(uts, " high end   =");
+
 	ut_assertok(ut_check_console_end(uts));
 
 	return 0;
-- 
2.42.0.582.g8ccd20d70d-goog

