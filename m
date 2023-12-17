Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71241C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 16:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5FA387CB0;
	Sun, 17 Dec 2023 17:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XBv5SygQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0EE087C9D; Sun, 17 Dec 2023 17:36:40 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBD9C87C8A
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 17:36:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7b7876fe9f0so110799539f.2
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 08:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702830996; x=1703435796; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hvfKorHiLwQ68nfwxgcQf7CCwi4tDJmEAEYkBojmuBs=;
 b=XBv5SygQbViEvy9VozASTUyydTkg2n9Bi+wlvoPFtt3QM7x35LiCZBX6WoMbLMmSrm
 AAnxws4pNFhH3LloTyhZNUvqTbxFSrDtWfbN43h3gt2oKodTepWKwh4Ef6zVh6po/96T
 4KuUINmsLALD+CEUeV16TLPoLUhzwnb1CNLqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702830996; x=1703435796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hvfKorHiLwQ68nfwxgcQf7CCwi4tDJmEAEYkBojmuBs=;
 b=SSMNu0JULUYpJaqiIV3E7KsbFP5SQ+R0VTmhmPcmgkgAubKJie9d/tLdeKrwEVNZoq
 psIEF7q5OQXO5/gxVtqkUDuABO+ddkGTDdLvzbiphY7hWB8xyPoQXK1cMld4+DPO++Vd
 wRqFfd3FsIz639mTOI26J7h7OeSGPD/FXEEsg4PkwcmH5Sg0URUTvR3R1BJeh7AroANI
 miKVuilj/+UfFZ9zQFdY3gWLmjjWBDLuL8IpNuQWQ3q82y/koHsiysDnvRkhCyCjE595
 KDgFsIkcqvwWSBsvEKtOSqDXqx2A45j/K1befjHJY9j7/PB5tJVz/fxqJswQC9hqot+t
 ipIw==
X-Gm-Message-State: AOJu0YyZomUDWkD1N+4MQ3Y1igbmLTPJOwz5qSR6K6oZljYSfp2oviJk
 dEwYl6qGzdi+3rqH5/LYTQy7qEu5p/4x6ImpPhqa8g==
X-Google-Smtp-Source: AGHT+IHkj/qctGMJPa64Sw+d+UecnPeZYrESd133tERyOlV4UOO/pPfuEcMD6A2Widnnv1U5M9Jggg==
X-Received: by 2002:a6b:7110:0:b0:7b4:28e4:8509 with SMTP id
 q16-20020a6b7110000000b007b428e48509mr17004569iog.11.1702830996418; 
 Sun, 17 Dec 2023 08:36:36 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 ei10-20020a05663829aa00b00466917fbfc4sm4925770jab.71.2023.12.17.08.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 08:36:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 03/10] fdtgrep: Correct ordering of flags
Date: Sun, 17 Dec 2023 09:36:16 -0700
Message-ID: <20231217163627.2339802-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231217163627.2339802-1-sjg@chromium.org>
References: <20231217163627.2339802-1-sjg@chromium.org>
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

Two of the flags are out of order, so fix this.

Also adjust the ordering of one flag in the main switch()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/fdtgrep.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/fdtgrep.c b/tools/fdtgrep.c
index f5493aaed3d8..41d8b41252dd 100644
--- a/tools/fdtgrep.c
+++ b/tools/fdtgrep.c
@@ -953,6 +953,8 @@ static const struct option usage_long_opts[] = {
 	{"include-mem",		no_argument, NULL, 'm'},
 	{"include-node",	a_argument, NULL, 'n'},
 	{"exclude-node",	a_argument, NULL, 'N'},
+	{"out",			a_argument, NULL, 'o'},
+	{"out-format",		a_argument, NULL, 'O'},
 	{"include-prop",	a_argument, NULL, 'p'},
 	{"exclude-prop",	a_argument, NULL, 'P'},
 	{"remove-strings",	no_argument, NULL, 'r'},
@@ -961,8 +963,6 @@ static const struct option usage_long_opts[] = {
 	{"skip-supernodes",	no_argument, NULL, 'S'},
 	{"show-stringtab",	no_argument, NULL, 't'},
 	{"show-aliases",	no_argument, NULL, 'T'},
-	{"out",			a_argument, NULL, 'o'},
-	{"out-format",		a_argument, NULL, 'O'},
 	{"invert-match",	no_argument, NULL, 'v'},
 	USAGE_COMMON_LONG_OPTS,
 };
@@ -984,6 +984,8 @@ static const char * const usage_opts_help[] = {
 	"Include mem_rsvmap section in binary output",
 	"Node to include in grep",
 	"Node to exclude in grep",
+	"-o <output file>",
+	"-O <output format>",
 	"Property to include in grep",
 	"Property to exclude in grep",
 	"Remove unused strings from string table",
@@ -992,8 +994,6 @@ static const char * const usage_opts_help[] = {
 	"Don't include supernodes of matching nodes",
 	"Include string table in binary output",
 	"Include matching aliases in output",
-	"-o <output file>",
-	"-O <output format>",
 	"Invert the sense of matching (select non-matching lines)",
 	USAGE_COMMON_OPTS_HELP
 };
@@ -1125,6 +1125,9 @@ static void scan_args(struct display_info *disp, int argc, char *argv[])
 		case 'H':
 			disp->header = 1;
 			break;
+		case 'I':
+			disp->show_dts_version = 1;
+			break;
 		case 'l':
 			disp->region_list = 1;
 			break;
@@ -1180,9 +1183,6 @@ static void scan_args(struct display_info *disp, int argc, char *argv[])
 		case 'v':
 			disp->invert = 1;
 			break;
-		case 'I':
-			disp->show_dts_version = 1;
-			break;
 		}
 
 		if (type && value_add(disp, &disp->value_head, type, inc,
-- 
2.43.0.472.g3155946c3a-goog

