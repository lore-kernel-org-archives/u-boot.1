Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D0AC3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 02:39:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E41EA87DD2;
	Mon, 18 Dec 2023 03:39:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bChwSZF5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5C6E87DD1; Mon, 18 Dec 2023 03:39:16 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EF5D87DC2
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 03:39:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d03f03cda9so6757885ad.0
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 18:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702867153; x=1703471953; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1tKfvzfDa8NGiiAEbBmpMamIEwVygPzTfOnYpGKXyEU=;
 b=bChwSZF5ykuUZ8Op9s13eZvJtK3Md1GCCDJWPFCwKjnvvie5LAhI9yAKB8k6C7CbrS
 V5qq3hh5tFpSFNCb13rfDhXGT+Lj7VHqOYJZBWiOUrUBQFbMlitIIXc7CnjkpGAQm1yn
 x79knpOKcAC5ceaSfMcO5ag+K66NegbWYvENTT5WMGIEAI2tPgX5g5YrmDiGcoApZZwj
 NgpKWDx8RSatvBfKxYNP3e9gou67lwjvNX94kbFrTxCkD3TmYF9Ev+7MyYg3gtCERF9w
 7o94TsZqO55RB9hxEviGaf5k7jj7g8gFQcgsyxpgFqMIX0EE/tvcohCdY0Hp7I/di29I
 pGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702867153; x=1703471953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1tKfvzfDa8NGiiAEbBmpMamIEwVygPzTfOnYpGKXyEU=;
 b=Lrg/KAJ04I8R2qwYMBn2iA2fLoPpSziy8ovo/d0TstLxe/E6TUwgDh5SbHLpO1W94+
 gcxvQbqTUX0BEtFhbhxCG3SptbJ6n+CkjuyYO54X2c3pbyzb98OmVRRIZ2umSKMT3VcN
 uad1vpEPOkENJsZuFkcoRXLr8QO4GZnPwdAPO7i7JNE/zfOmsbSuPenvCnlr29fAchud
 9s4UAxo87QGMriwq/gzZnACDgYltPDcCKlmX/feeYAHSdScPAwEZytyjPc3h/LOIRFaQ
 dwRkNq0IpsDjqGe2OIpDXCgDxEyBWSwW29+Qha5eh3RBLkXuPMPa3HvqDj1tocDOYz5l
 stvA==
X-Gm-Message-State: AOJu0YwEP42DfegmbXcLGzVpdvMLvUXJX0q3xZKbV6/PL7hzPB572tRv
 UUXU40PfgRVx+xewqeF8pFSYjg==
X-Google-Smtp-Source: AGHT+IFNwVvPzQhMC+SJgxT+hI8N7Eh+cKnxovyF4AFrXUyhXxRx8OPdglDBqc7Vxo3z4x7VkaS3yQ==
X-Received: by 2002:a17:902:e746:b0:1d3:c23a:6859 with SMTP id
 p6-20020a170902e74600b001d3c23a6859mr713209plf.1.1702867152942; 
 Sun, 17 Dec 2023 18:39:12 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:a448:a260:721d:a9f0])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a1709029a9800b001d316770044sm13754305plp.56.2023.12.17.18.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 18:39:12 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v3 4/4] fs: remove explicit efi configuration dependency
Date: Mon, 18 Dec 2023 11:38:42 +0900
Message-Id: <20231218023842.281336-5-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218023842.281336-1-takahiro.akashi@linaro.org>
References: <20231218023842.281336-1-takahiro.akashi@linaro.org>
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

Now it is clear that the feature actually depends on efi interfaces,
not "bootefi" command. efi_set_bootdev() will automatically be nullified
if necessary efi component is disabled.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 fs/fs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/fs.c b/fs/fs.c
index f33b85f92b61..82ee03b160e9 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -791,10 +791,9 @@ int do_load(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
 		return 1;
 	}
 
-	if (IS_ENABLED(CONFIG_CMD_BOOTEFI))
-		efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
-				(argc > 4) ? argv[4] : "", map_sysmem(addr, 0),
-				len_read);
+	efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
+			(argc > 4) ? argv[4] : "", map_sysmem(addr, 0),
+			len_read);
 
 	printf("%llu bytes read in %lu ms", len_read, time);
 	if (time > 0) {
-- 
2.34.1

