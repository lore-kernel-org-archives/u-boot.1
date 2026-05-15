Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406F7CD4F3C
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 20:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A85B884812;
	Fri, 15 May 2026 22:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dxMi8gY7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BBCC84839; Fri, 15 May 2026 22:33:36 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F083184694
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 22:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dcd17e19b6so137641a34.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 13:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778877212; x=1779482012; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f+A/O5muKkqrrVEO5Cx949L2EsPZIVTOPjPPg0b3JuM=;
 b=dxMi8gY7quuPGrILiKTj5RfDpn/pnBjGCH/S8fc0SlxN7Av+XzscIuHZGnicEY+PK5
 Jwia7RC3p81+a7/YyeZvbIC53byXbZHhkkWkMiUgfTfYLrCHmE9XbELOb+Prt+pK7lS1
 1EeJhbJR29y5vG5IcrRZMWJ0WgTt6u9qYIYxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778877212; x=1779482012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f+A/O5muKkqrrVEO5Cx949L2EsPZIVTOPjPPg0b3JuM=;
 b=iuWppDcBKHIeBBoeAnQOmR/DG6vmWwPDNvIhCu+dtG5mexHKknIsvDdodgh4Buf4NC
 g8lRvkluWipc0fvM+5E/sehW19f7KBqUkC0RNMkCENuVv+6mP4/aBLwvxYhyJJWpAKvF
 2yAcea8JO5jsQ6Saw8GNhpt1TksB1oCuJ0bP728PR0+016ufr+eQSSSd2pJeIFjT/FCg
 ESqLxmTRv7aGyM14ElCGWEFVd9DERQv2dA1dw9CVqTBOUN2tro72EM6Kujay40UhDwhJ
 8bxMuKf/eBUIE2ou+8A1nyZ/kmoUIWORcorIX8kuVb6ujI4t1aoK691foixBNyghutIa
 1kfA==
X-Gm-Message-State: AOJu0Yzy92yDCCIoOub3BPgjWw0T3fNzgHl+xH5sbG99SEO/bNTApcC1
 FsK4DCZyxHSM69jwJpZXrwoV6EGgi5ESw43nGmJZ38dXIDCX06+0ymlC/APw+ej2zSfzpbnGkN1
 2PXm1lA==
X-Gm-Gg: Acq92OHrIUH4KcxEKPTLdu3qgFCyVrpzkHhce5BOIvWCLcbxQR10+rhChZ63UfMlmCN
 53ECcZV6ppFPP2Ge1kr3ZUjZ1eF9OIE+7p2mmBDu89RcSDa80ax7QzH6ym/y9eWCxK5Z4TwHRka
 Ys5EeXBTbv6/E7PwY6DW3yM2uDOrJQWuEdqoAccuZXKrJFZn3bxpdxjyIuwH+ywBsG4QhXaV2X7
 aPlwj9Qs7FaC1h+AT7I7wzAMRMIndFp5CMSSXG+HdjQVlZKFcj/DZFVKnW1pS1envsJHwGnNh/+
 wlDdbNPOQngq0anWlvhNmn4kjl9JOo+1cGvdRTr5VSORdm6OAvJdtFJaE3ilV2XahrBYTSjZCTQ
 fTeJ2PZ1G74tftkpJNG6JROCEK8L/yTuRS/W8arMhw0Fyqjeq6UUVKAWi4KgH6z7Ds/BD3u8bQz
 K1a4ROufYQWFHPvzhPEQ==
X-Received: by 2002:a05:6830:2589:b0:7e1:cbe3:bb1b with SMTP id
 46e09a7af769-7e4de6a6079mr3705371a34.0.1778877212198; 
 Fri, 15 May 2026 13:33:32 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b95b82fsm2414906a34.12.2026.05.15.13.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 13:33:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 02/11] cmd: ini: Use strlower() to normalise case
Date: Fri, 15 May 2026 14:32:53 -0600
Message-ID: <20260515203311.2555651-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515203311.2555651-1-sjg@chromium.org>
References: <20260515203311.2555651-1-sjg@chromium.org>
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

ini_handler() lowercases four strings when CONFIG_INI_CASE_INSENSITIVE
is set, each with a hand-rolled loop whose strlen() in the condition
makes it quadratic in the string length.

Replace each loop with strlower() and fold the #ifdef pair into a
runtime IS_ENABLED() check so the body reads linearly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/ini.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/cmd/ini.c b/cmd/ini.c
index 96399017691..cf0a3ce8b3d 100644
--- a/cmd/ini.c
+++ b/cmd/ini.c
@@ -202,22 +202,17 @@ static int ini_parse(char *filestart, size_t filelen,
 static int ini_handler(void *user, char *section, char *name, char *value)
 {
 	char *requested_section = (char *)user;
-#ifdef CONFIG_INI_CASE_INSENSITIVE
-	int i;
 
-	for (i = 0; i < strlen(requested_section); i++)
-		requested_section[i] = tolower(requested_section[i]);
-	for (i = 0; i < strlen(section); i++)
-		section[i] = tolower(section[i]);
-#endif
+	if (IS_ENABLED(CONFIG_INI_CASE_INSENSITIVE)) {
+		strlower(requested_section);
+		strlower(section);
+	}
 
 	if (!strcmp(section, requested_section)) {
-#ifdef CONFIG_INI_CASE_INSENSITIVE
-		for (i = 0; i < strlen(name); i++)
-			name[i] = tolower(name[i]);
-		for (i = 0; i < strlen(value); i++)
-			value[i] = tolower(value[i]);
-#endif
+		if (IS_ENABLED(CONFIG_INI_CASE_INSENSITIVE)) {
+			strlower(name);
+			strlower(value);
+		}
 		env_set(name, value);
 		printf("ini: Imported %s as %s\n", name, value);
 	}
-- 
2.43.0

