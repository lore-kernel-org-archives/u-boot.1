Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D0DC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF3E7875EB;
	Mon,  4 Dec 2023 01:27:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fH5TBVQ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDC5387499; Mon,  4 Dec 2023 01:27:12 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC7ED8763E
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:27:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6cdea2f5918so2329609b3a.2
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649627; x=1702254427; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J1hJRXm9Vzaz/jO2hWTeRfJdgPAqplWlHEEPBLhfGIw=;
 b=fH5TBVQ8Nwh/CGVrrlfZVic0YTHdBOlp517EJ1mzNNlwobyfyc/4d3nOAE3PXfkkmw
 1wNtQCtGaQ/Wng9ICHYcp/32tDza+3yT2WzRn0Oswi9l9L9ZhiUKzHntLadOL/dTXj9r
 aNQooNIgufrm9VAr/SdPHLQSWSfO3OHktv/Do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649627; x=1702254427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J1hJRXm9Vzaz/jO2hWTeRfJdgPAqplWlHEEPBLhfGIw=;
 b=EeXdde2q5mrscjxFx2f9nuzyFihSl2gimbj0eBN28SuHVWfbFDVEFn2wtEMvKanmjV
 LlzIsQmBSNuHnttAhDT6MLJGByacrD8HGh3JoZDYlLhxfuDi63FRcAT5wzvTUS+PXS6R
 YjIGeaaKQrLthoIbvO8s7bQoJ0uZe5fsl6bly0moY7NcXs/B0zHppwo9wj4O4w5iBb0S
 AMZNZmaLO0u1+kpSEf8nMHK37HWJMSdUCLWKiLzd8fdeSzlrpjJ/VbTHElJgBRhB6kVh
 V6MgyeRBjO+aUVeWPIZ18A6wScpCc3MFBlE1eta0YJ8rW4E6K2SRhFHXj5CzUL8BJVxw
 KauQ==
X-Gm-Message-State: AOJu0YxM4gZoojPehXgp9vZCGOJcTEnVeIUGYOZqFw8BBmC5KxVHwljf
 TKzhdn6a8PB7rtTMOKtLzGyBicupgbrYeEvb1e8lRA==
X-Google-Smtp-Source: AGHT+IFvFoT99nxOI188lZ5MJ2iE0wk8WKdsjqg6e1eiUPP5v/j8YwifQq0oWLjyJ1sounDa3iQGcQ==
X-Received: by 2002:a05:6a20:974e:b0:18f:97c:5b8e with SMTP id
 hs14-20020a056a20974e00b0018f097c5b8emr685424pzc.92.1701649627120; 
 Sun, 03 Dec 2023 16:27:07 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a170902904500b001cfb971edfasm7097227plz.205.2023.12.03.16.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:27:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 02/18] bootm: plan: Drop passing of arguments
Date: Sun,  3 Dec 2023 17:26:18 -0700
Message-ID: <20231204002642.895926-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204002642.895926-1-sjg@chromium.org>
References: <20231204002642.895926-1-sjg@chromium.org>
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

It isn't clear how useful it is to pass the arguments of bootm to the
OS. For example, if "bootm 1000 2000 3000" is used, the three arguments
at the end are passed to the OS. This seems like a strange approach,
since the argument have already been parsed by U-Boot and processed.

Rely instead on the "bootargs" mechanism, which is the standard
approach.

Drop the helper function as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm_os.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index b5055d78706c..4aa1db848d6c 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -41,20 +41,6 @@ static int do_bootm_standalone(int flag, int argc, char *const argv[],
 /* OS booting routines */
 /*******************************************************************/
 
-#if defined(CONFIG_BOOTM_NETBSD) || defined(CONFIG_BOOTM_PLAN9)
-static void copy_args(char *dest, int argc, char *const argv[], char delim)
-{
-	int i;
-
-	for (i = 0; i < argc; i++) {
-		if (i > 0)
-			*dest++ = delim;
-		strcpy(dest, argv[i]);
-		dest += strlen(argv[i]);
-	}
-}
-#endif
-
 static void __maybe_unused fit_unsupported_reset(const char *msg)
 {
 	if (CONFIG_IS_ENABLED(FIT_VERBOSE)) {
@@ -211,16 +197,12 @@ static int do_bootm_plan9(int flag, int argc, char *const argv[],
 
 	/* See README.plan9 */
 	s = env_get("confaddr");
-	if (s != NULL) {
+	if (s) {
 		char *confaddr = (char *)hextoul(s, NULL);
 
-		if (argc > 0) {
-			copy_args(confaddr, argc, argv, '\n');
-		} else {
-			s = env_get("bootargs");
-			if (s != NULL)
-				strcpy(confaddr, s);
-		}
+		s = env_get("bootargs");
+		if (!s)
+			strcpy(confaddr, s);
 	}
 
 	entry_point = (void (*)(void))images->ep;
-- 
2.43.0.rc2.451.g8631bc7472-goog

