Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995C3C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5193080BAB;
	Mon, 20 Jan 2025 22:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GD16h2tQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2061580BAB; Mon, 20 Jan 2025 22:27:46 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4CB080BA4
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-844eb33827eso147585139f.2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408462; x=1738013262; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GtNYYbm/QlopIlPsWbOyQCrLep0pitK0nEl3X9+/ExM=;
 b=GD16h2tQkmXhwTc1UNLXGIv5m+P9WaeuGWUagu/AXUnuzvaV8QH5lLrPeBDRCxDzj9
 vUNi3EDUQnd6VOjeJjbD550Nnb7KIMzWZrfH5cvUAKiM5WB+98yreN5MIjhgu+m72bpm
 /8qC9s/jvva7CFQ/7Bw6DvHeUjkQCkjJzLm3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408462; x=1738013262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GtNYYbm/QlopIlPsWbOyQCrLep0pitK0nEl3X9+/ExM=;
 b=R0fGnQY2vxavXJr1lEQVmiDgnGOMRgZb5NlcAd0+feSPYlf3Rfq9+qvxmKn5RGL72t
 3YMNdwSzvYkwUXZpQAIJbfWdW2I6lGlq1h3i6XTqUZNCgVFTEMbQWvbdDJHatrOmgQu1
 ya04dlrxIEFRaC5ulH57MfWT6HYyvq1ep2UiP8jiINkYovXJfJwZhEjgBdbIb/DXOWZk
 Ry1yd3UO47CyipnqKI49PVNx5PWCeLRAI5bGLI6VpWcCM1m7MjDppOihksQc0P832BvM
 KnSJcvC/MmsQwQ0Qety/VxgS1viK0xqsNHueOjloSUqxVoZCgFzsajjL4TnaspTTX5JD
 ZEOA==
X-Gm-Message-State: AOJu0YzMkh43Kf0ueAKy0bWk00+10wZgIeypg1FeqYHyc/G4ReYI6sa5
 xmUqRcs/9U6RG872Uc2dbeP5i8/mYo+byOtDuvlW5edkir50VcvStYJtl/U+mf4IYAW1CWJ3dmw
 =
X-Gm-Gg: ASbGnctdCc4L7s4p+bYB7lamkA51vjmjNoCNUJTjNmChbOzYQT5V9DM4UjNGpeba7/W
 UukEPr3aG3ZNLVayKy94j2IxhLnDc1ObHVrILdOquZTkYFZdUPeCx3kNJWBx6xYQQhU7pmjR0Pt
 Y75/oeutXB01QT1VOYA3vpIIKBiOaajMTXnIXk3NrdJ52IYiYUDGmo11EN0nvY0gXBnlxgsgTqP
 OkDGz+ECHt8DbGpiuYI6m34BDfuTeij+LB1cwoGeD25g5PI4CYtonUGTCfiaCXY6YL3Bt6zcLMc
 U5BTkHaCC8l480kj5fb/Yjb8X6Kmntk=
X-Google-Smtp-Source: AGHT+IENogScdez0DTK5Uafx/5ZNcfmzmVzy+L/MBGpkaTKKweKbbD0Q7A1mMrTXp7rVeerEz4k33A==
X-Received: by 2002:a05:6602:4a0e:b0:843:e667:f198 with SMTP id
 ca18e2360f4ac-851b616d44amr1089585439f.2.1737408462115; 
 Mon, 20 Jan 2025 13:27:42 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:27:40 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 41/44] test: Sort the test suites
Date: Mon, 20 Jan 2025 14:26:03 -0700
Message-ID: <20250120212613.516664-42-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120212613.516664-1-sjg@chromium.org>
References: <20250120212613.516664-1-sjg@chromium.org>
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

Put the suites in order by name, for easier code-maintenance. This also
helps find test results for a particular swuit in the 'ut all' output.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/cmd_ut.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 0b8bfe603b9..2e5519b55f9 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -90,7 +90,10 @@ int cmd_ut_category(struct unit_test_state *uts, const char *name,
 	NULL, \
 	}
 
+SUITE_DECL(addrmap);
 SUITE_DECL(bdinfo);
+SUITE_DECL(bloblist);
+SUITE_DECL(bootm);
 SUITE_DECL(bootstd);
 SUITE_DECL(cmd);
 SUITE_DECL(common);
@@ -99,25 +102,25 @@ SUITE_DECL(env);
 SUITE_DECL(exit);
 SUITE_DECL(fdt);
 SUITE_DECL(font);
-SUITE_DECL(optee);
-SUITE_DECL(overlay);
+SUITE_DECL(hush);
 SUITE_DECL(lib);
+SUITE_DECL(loadm);
 SUITE_DECL(log);
 SUITE_DECL(mbr);
-SUITE_DECL(mem);
-SUITE_DECL(setexpr);
 SUITE_DECL(measurement);
-SUITE_DECL(bloblist);
-SUITE_DECL(bootm);
-SUITE_DECL(addrmap);
-SUITE_DECL(hush);
-SUITE_DECL(loadm);
+SUITE_DECL(mem);
+SUITE_DECL(optee);
+SUITE_DECL(overlay);
 SUITE_DECL(pci_mps);
 SUITE_DECL(seama);
+SUITE_DECL(setexpr);
 SUITE_DECL(upl);
 
 static struct suite suites[] = {
+	SUITE(addrmap),
 	SUITE(bdinfo),
+	SUITE(bloblist),
+	SUITE(bootm),
 #ifdef CONFIG_UT_BOOTSTD
 	SUITE_CMD(bootstd, do_ut_bootstd),
 #endif
@@ -128,25 +131,22 @@ static struct suite suites[] = {
 	SUITE(exit),
 	SUITE(fdt),
 	SUITE(font),
+	SUITE(hush),
+	SUITE(lib),
+	SUITE(loadm),
+	SUITE(log),
+	SUITE(mbr),
+	SUITE(measurement),
+	SUITE(mem),
 #ifdef CONFIG_UT_OPTEE
 	SUITE_CMD(optee, do_ut_optee),
 #endif
 #ifdef CONFIG_UT_OVERLAY
 	SUITE_CMD(overlay, do_ut_overlay),
 #endif
-	SUITE(lib),
-	SUITE(log),
-	SUITE(mbr),
-	SUITE(mem),
-	SUITE(setexpr),
-	SUITE(measurement),
-	SUITE(bloblist),
-	SUITE(bootm),
-	SUITE(addrmap),
-	SUITE(hush),
-	SUITE(loadm),
 	SUITE(pci_mps),
 	SUITE(seama),
+	SUITE(setexpr),
 	SUITE(upl),
 };
 
-- 
2.43.0

