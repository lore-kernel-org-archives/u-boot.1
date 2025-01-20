Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF0DC02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B32E980A0C;
	Mon, 20 Jan 2025 22:27:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hz6+2jPf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF2F080A46; Mon, 20 Jan 2025 22:27:23 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 896C3801CF
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3ce7c4115e8so20369935ab.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408440; x=1738013240; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zp9xAMpjLdkQ5Lw4HJXoDVpkpWSsXjipqB+flXk9Uz0=;
 b=Hz6+2jPfFOiZ9pH8jp8rc8jAcFcT6ZjJ1r19I/w9wNylC1EFWpSaDXyh5WkOkfkOcS
 ROJg2QjP1F39deo68gRjgM1OqRuz6qvXm2KecYlKz49hIPOdHPia4jgq9hCiztziacB2
 YspmzAfWItaC4pL9q/NAVD5XPo0PmQAXvyWS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408440; x=1738013240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zp9xAMpjLdkQ5Lw4HJXoDVpkpWSsXjipqB+flXk9Uz0=;
 b=pXyzXBZIXAvRusM+TaclFrJ9He1iXny+qUv5f7JG9hsyZaJJ8IIAcp7CCKYDi5Wsny
 F8kAWwPgKPQuYZaETpM4dxH0E8Aji7lWp5nvw6Prmgfkdm/mpf1WtF7TQfKLiNuSeLXj
 0q8+wkDPfEcYMsqjnOPoACySXO6dCTrnQ8wxBZSp3XTm+2lOvFzLKiWeH7xopOKb66vg
 pGCIz33OTvn3dMNf7JvG9w2EeZpnF6Fpam4t5xthB2EhbTqlIKfohHOEkBZBVU5n5Kmj
 Z0kvw3otY31zN6QSaOqNhXmDMgeHdv/C3AWa3SFlGyg1dUdqVV7fqukuhGcKjcMfhS+t
 VvFw==
X-Gm-Message-State: AOJu0Yzv+jwggbFJWDCrGkQOPY6YaHF2yT0V89zJ/lcbdp/chRmVHdZM
 cf9xL6bzOWUVxZ6ar6X27xEM4FEeEijYTi7tVC3vAIAg9ipmeej7+ei6ks52Tk+0BCgRdLiuNuI
 =
X-Gm-Gg: ASbGncv7td9CIZOtYCl9rR3rNaHzl46/OaOoPGpXGhStce36uinAOdIRMvNgl1JvqiW
 Inar6cC9DkiPMh0CFFEJznRe7FqeQFdBXVxPWIZtKMaBbxHUUYpH9ewWgD32+D2O7+mXDdwqBnT
 0SRxl9xWjZFJSjvE/3Prr+vp0i1kpnZyapZP8DP0MRvktai8/q0sQnfLJTn4INNJozNa5ggJ6Vq
 9Ibv3tWPliNvOm17WhXUwsNE5ZDNgUJ3hti2GdqS8rbekogvhnVN8SWmeYGGnbsSehy9IOMWMkF
 AMbAsRsGChol21sAouFl2u4cRzJ0y4g=
X-Google-Smtp-Source: AGHT+IFxQyjBcRaycx9FPXxjfHlKq356T8fGvsVvH4NcQ31h8V6pyeQrS7pWSPO2fIk6k8lNM8V28g==
X-Received: by 2002:a92:de50:0:b0:3a9:cde3:2ecc with SMTP id
 e9e14a558f8ab-3ce84a1ab85mr154242255ab.6.1737408439772; 
 Mon, 20 Jan 2025 13:27:19 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:27:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 28/44] test: Drop the function for running addrmap tests
Date: Mon, 20 Jan 2025 14:25:50 -0700
Message-ID: <20250120212613.516664-29-sjg@chromium.org>
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

Use the new suite-runner to run these tests instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/test/suites.h | 2 --
 test/cmd/addrmap.c    | 9 ---------
 test/cmd_ut.c         | 2 +-
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index 77af692be3c..54fddaa6bac 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -30,8 +30,6 @@ int cmd_ut_category(const char *name, const char *prefix,
 		    struct unit_test *tests, int n_ents,
 		    int argc, char *const argv[]);
 
-int do_ut_addrmap(struct cmd_tbl *cmdtp, int flag, int argc,
-		  char *const argv[]);
 int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
 int do_ut_hush(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
diff --git a/test/cmd/addrmap.c b/test/cmd/addrmap.c
index fd0117102e2..1f2deb15052 100644
--- a/test/cmd/addrmap.c
+++ b/test/cmd/addrmap.c
@@ -24,12 +24,3 @@ static int addrmap_test_basic(struct unit_test_state *uts)
 	return 0;
 }
 ADDRMAP_TEST(addrmap_test_basic, UTF_CONSOLE);
-
-int do_ut_addrmap(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(addrmap);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(addrmap);
-
-	return cmd_ut_category("addrmap", "cmd_addrmap_", tests, n_ents,
-			       argc, argv);
-}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 71283d6dd14..611171740a9 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -175,7 +175,7 @@ static struct suite suites[] = {
 #endif
 #endif
 #ifdef CONFIG_CMD_ADDRMAP
-	SUITE_CMD(addrmap, do_ut_addrmap),
+	SUITE(addrmap),
 #endif
 #if CONFIG_IS_ENABLED(HUSH_PARSER)
 	SUITE_CMD(hush, do_ut_hush),
-- 
2.43.0

