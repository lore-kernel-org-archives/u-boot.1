Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F60CEDF15B
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 13:39:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BA3483AA9;
	Fri, 13 Feb 2026 14:39:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KVnsjBm8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86B2783B9D; Fri, 13 Feb 2026 14:39:38 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D226183015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 14:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d4c85307b2so181167a34.0
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 05:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1770989973; x=1771594773; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gIKR0OlXEvsQCeviATeZ23i1n8mDOhQHRskPstcn2MQ=;
 b=KVnsjBm8iFHh6jJOiyazkyRvacQyovj3cubXtvwGoEBvqrcXwrDEDnZoyAWTa850yW
 mulGRLmchrBRyN0bwRd3geKwHJ1cAtidEUuAbJZoCbwG8xQ1UfFUCJMQFMF2LFEoWCAK
 cuf3WaRDPd4c0ZpLSDurtd4CZ5zhniLJkIGMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770989973; x=1771594773;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gIKR0OlXEvsQCeviATeZ23i1n8mDOhQHRskPstcn2MQ=;
 b=JhgEvlH+7OYy6tuNBq2lNnY/WJUgyiiqD4iWVIJxO41ADzpwKY0UQWv2JBxS7bq9wk
 W1qVlaJ4gy6OkRfGlRRQx//rLTITwEk0FOEXpj1gXjJ8CZdTOYuy87sWg6MSyWCBcgSG
 req13CMndOFmbtS4hD9N71KoJ0ioynOfN+wOXlIdten2uNjbc05nINYDoqgGHVb0g9Kz
 mwHOL6Wb9AO3AHKx8rJ0XT+qYoxQRcqyULvip2U7EOJY2EAdRLKwcd79YhNsmhEyWGFO
 XtTnAmOOBUqZ400Dfw8B0FD1M0zWhr112SgH9/HSAjvSinYjoAf5XNxu6BbPRz/QqJZt
 c4fQ==
X-Gm-Message-State: AOJu0Yzfl2AqRC1pgTPq2YkEKtVn4OfMwaj63f44BS/eEsnxj3tNq4iW
 bT+W2On5P3/8YDXxZRRP/7UIuLk2KFvDLR5h56scFeJOMb1fDpYmvaizepTK8U9iopqt7jPwcrK
 GFMQ=
X-Gm-Gg: AZuq6aIZ1VOOz/6EMSICSswlurtDJ5j4Uku8R5IjzdB2mM/UKTy5S2Hb/+JqKSh6TCV
 Hkb3l2Oyfhr/e5QT+5MKFu7A2+Sr9nbHHQ+rjzMLo4ZRyUJolXx20YcrfcjRFNIb2ckwvWuCTPC
 HeAJBd6Mnojls1ZH72KVubyxrE3hiYnSdO1ReKzwKQlgkz00OeMJPq2zEvpZYMLhe1y5u3XFWtz
 SpmSEaD7Lt2Wh4wzjxbOdMq9zTkplBLLBcnENFUPm9v9ikmBNys9FYwVkZtVzm7B5DMhcZqsZ3f
 wlxaBQpMXtBXa1p5idpnENlQ7iSnBElbQ2N0riIwFmEW3nX4F0egzqaUvsM1IANEpWyzZt9eXS2
 nETO3O0+mRgQXU/NmzoujecYaf0vUMK45Fg2/B2GOu7APwLaWyQsgAYQpEBGWNwwDUxauoaD0FT
 0grt7qKlGpv1qo76wFCB2zhDhJSIb1
X-Received: by 2002:a05:6830:2aa7:b0:7c7:69c8:2ce with SMTP id
 46e09a7af769-7d4c4b31df0mr1034529a34.27.1770989972782; 
 Fri, 13 Feb 2026 05:39:32 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a75309a6sm6274212a34.3.2026.02.13.05.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 05:39:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <simon.glass@canonical.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] menu: Move shortcut-key handling to bootmenu_loop()
Date: Fri, 13 Feb 2026 06:39:09 -0700
Message-ID: <20260213133922.1431006-1-simon.glass@canonical.com>
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

The bootmenu_conv_key() function is shared with expo subsystem for key
input. Adding alphanumeric-to-BKEY_SHORTCUT conversion there causes expo
to swallow typed characters instead of inserting them as text, since
BKEY_SHORTCUT falls in the range that expo treats as a command key
rather than passing through.

Move the shortcut-key detection into bootmenu_loop() where it is
only used in the bootmenu context.

Fixes: 8c986521c3c9 ("cmd: bootmenu: permit to select bootmenu entry with a shortcut")
Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 common/menu.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/common/menu.c b/common/menu.c
index ae5afa14766..02df3b8f133 100644
--- a/common/menu.c
+++ b/common/menu.c
@@ -556,11 +556,6 @@ enum bootmenu_key bootmenu_conv_key(int ichar)
 	case ' ':
 		key = BKEY_SPACE;
 		break;
-	case 'A' ... 'Z':
-	case 'a' ... 'z':
-	case '0' ... '9':
-		key = BKEY_SHORTCUT;
-		break;
 	default:
 		key = BKEY_NONE;
 		break;
@@ -591,8 +586,10 @@ enum bootmenu_key bootmenu_loop(struct bootmenu_data *menu,
 
 	key = bootmenu_conv_key(c);
 
-	if (key == BKEY_SHORTCUT)
+	if (key == BKEY_NONE && isalnum(c)) {
+		key = BKEY_SHORTCUT;
 		cch->shortcut_key = bootmenu_conv_shortcut_key(menu, c);
+	}
 
 	return key;
 }
-- 
2.43.0

base-commit: 9e6b66409a3235ae73f1937929fe025911165bbb
branch: menu-fix-us
