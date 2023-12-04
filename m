Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBED3C07E97
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:33:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 354B3876E0;
	Mon,  4 Dec 2023 01:30:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MRD66SIE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B181878B0; Mon,  4 Dec 2023 01:30:24 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 311C987655
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3b84e328327so2008996b6e.2
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649820; x=1702254620; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WBKfOX0oyCgS8sh3X9QbYgMz5Msp1TjdFWgouRmMUQY=;
 b=MRD66SIEe635XMfJ9bCYgyv2VB4Qo32BvFdyt4I12oe7a5LblzO50ID3BEzM5gLC87
 DuGu32WD37enil+dyaiWhx89ZqrIMUgSenuVQGex1Z0jSAJCjq0gLAs56jCLH6qXcB8E
 L2DTRXhsZVD5j8NfkF/HHot7cRSsxqpidJPmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649820; x=1702254620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WBKfOX0oyCgS8sh3X9QbYgMz5Msp1TjdFWgouRmMUQY=;
 b=ky+/3mtVAdJDXjv1hRC4/eyDYU5zywPh6R8tq7lqNbdRQsXuL5KYs6z1qyZ+IhL4ht
 MeJY/ui4eImfDCry/hRnM378R/2QW32G/rA+ILheUIyYYz8SbjxuZVGAF1Lx3/I1kKo6
 CK8UFikKMACsuN/rp2QBGwZvfRJlman5p0DZliMgiWT2FPNiRVlX6KddSSLJxWDmsLja
 rnbKFE+1/lE2MR6deeDUZ+eDXafm2kEFszB0TzxmSXr2r9bqvjX6DINRuFAcKKfxUJeC
 /Q8ruRkZEbT+0rHuY1TK31ke7H0ppaV5A4s55T0GwkyBV+wsquGrsP+Wxhi9RQZC1AXb
 qckw==
X-Gm-Message-State: AOJu0Yw4YMAj1qEIwN+Pbw/uaAmQCWx2FAlsq+hfLkH/dsQDih2UV5tb
 m/t629kAH/Ri6gXteH1rKHeD9aBtqnq+ZFAyk7/JUQ==
X-Google-Smtp-Source: AGHT+IEwPVB7zEcgXqjcuTO9xC3f5hRqfnprA2i0iUQt/7JHGIFhrPxmzH0apQU0YBEvDaAl6sp4mw==
X-Received: by 2002:a05:6808:221c:b0:3b8:b063:6b96 with SMTP id
 bd28-20020a056808221c00b003b8b0636b96mr4010948oib.69.1701649820836; 
 Sun, 03 Dec 2023 16:30:20 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 o24-20020a056a001b5800b006ce3a0b4bfasm2346433pfv.24.2023.12.03.16.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:30:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 07/13] x86: zboot: Drop intermediate zboot_setup() function
Date: Sun,  3 Dec 2023 17:29:32 -0700
Message-ID: <20231204002944.897949-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204002944.897949-1-sjg@chromium.org>
References: <20231204002944.897949-1-sjg@chromium.org>
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

Move error checking into the caller so that do_zboot_setup() can call
zboot_setup() directly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/x86/zboot.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index d39ab6a9698f..f392b6b3e493 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -74,11 +74,10 @@ static int do_zboot_load(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-static int _zboot_setup(void)
+static int do_zboot_setup(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
 {
-	struct boot_params *base_ptr = state.base_ptr;
-
-	if (!base_ptr) {
+	if (!state.base_ptr) {
 		printf("base is not set: use 'zboot load' first\n");
 		return CMD_RET_FAILURE;
 	}
@@ -87,13 +86,10 @@ static int _zboot_setup(void)
 		return CMD_RET_FAILURE;
 	}
 
-	return 0;
-}
+	if (zboot_setup())
+		return CMD_RET_FAILURE;
 
-static int do_zboot_setup(struct cmd_tbl *cmdtp, int flag, int argc,
-			  char *const argv[])
-{
-	return _zboot_setup();
+	return 0;
 }
 
 static void zboot_info(void)
-- 
2.43.0.rc2.451.g8631bc7472-goog

