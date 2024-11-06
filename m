Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508C7D59F40
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 15:35:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B6E088F92;
	Wed,  6 Nov 2024 16:35:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l+cFX+vA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AC0C88F92; Wed,  6 Nov 2024 16:35:52 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E68A891CD
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 16:35:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-83ab94452a7so288052339f.3
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 07:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730907348; x=1731512148; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aaTLHh5lP+wfgIbXx9DOhDBfyUHCsV0VyrLyYw8ts18=;
 b=l+cFX+vAyg6c0MTynJ1eAqYCb+ZdSr/btQADfnpQtU1NowiKnLX/lAZMZ2lFZULUqn
 FH+DRCoXUjo6rxiM/6dGtpUmCpPfwkym1s8rrgaBDLoVQ7bRPdRW2H2gZrYACVVsB3wr
 NL6O0W+W7PXwdxdu/GPuFPF0S8MLO3YS6zWPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730907348; x=1731512148;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aaTLHh5lP+wfgIbXx9DOhDBfyUHCsV0VyrLyYw8ts18=;
 b=CeSy+7U765mCyzKU5dBqSjFtqwc24/aWelAPcwwNnjBpqnBS1Xe0sdH4885WbBSgg4
 mvAxwqhP+gWWWXFOgWUseg0NFfbXEFg19/PPdrw4ISXZQwCTZTvBBmQ2A0dtTxPwXEsc
 pxL2U/tnvD4mhqhpzaVUI6T6zK+ng6/FtS3LEa7YmTSf10Oda6A+hpeXQGPrnBaU4joU
 gydggMvevVXEoabbu97BMiVH2AxuCRBf3yg2FsNaxKtBZ3brqwOODlFg5R9oFa+J/Mu0
 Kawov+bAUPHu32AEUnnLVHTfvxxlMAOexTbm5nP/CfP3tmFCDT9cjbV/Yu2GMiRWxArc
 gnvA==
X-Gm-Message-State: AOJu0YyUl65MsxOkJRBR7bzePShOerUX9f9duWYFqvDHVAtS/NoGHSD0
 XrvHGnFFBXiI3VtvXpXZV2oi6pLh1ChojKHh9k8eT9c5n9NsjsahO6MsfVWa7v6KCqds/4nhxL4
 =
X-Google-Smtp-Source: AGHT+IG9jtF/bUv1zVIYMXb3292Miif2cN6OOc+s/VD1b3PRZLJLKRqV6h1S18dzwSRqhFxTb0Fm0A==
X-Received: by 2002:a05:6602:608a:b0:82c:ddfc:c57b with SMTP id
 ca18e2360f4ac-83b566ee5ecmr2780747339f.5.1730907348119; 
 Wed, 06 Nov 2024 07:35:48 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de04888328sm2892220173.3.2024.11.06.07.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 07:35:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>,
 Masahiro Yamada <masahiroy@kernel.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2] Makefile: Fake external blob with BINMAN_ALLOW_MISSING=1
Date: Wed,  6 Nov 2024 08:35:43 -0700
Message-Id: <20241106153544.1277835-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

This flag was lost by a previous change and has never been restored.
Without it, binman cannot fully handle missing blobs which are
themselves inputs to mkimage.

Discussion on this at [1] indicated that this was necessary but the
patch was not updated.

Restore the flag so that all missing blobs are reported.

Link: https://patchwork.ozlabs.org/project/uboot/patch/20221206020336.315465-1-trini@konsulko.com/

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 93685d0dcb9 ("Makefile: With BINMAN_ALLOW_MISSING=1 don't error")
---

Changes in v2:
- Use Link: and avoid a line break

 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7275a02f24c..f92f46b3ab7 100644
--- a/Makefile
+++ b/Makefile
@@ -1398,7 +1398,8 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
                 --toolpath $(objtree)/tools \
 		$(if $(BINMAN_VERBOSE),-v$(BINMAN_VERBOSE)) \
 		build -u -d u-boot.dtb -O . -m \
-		--allow-missing $(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
+		--allow-missing --fake-ext-blobs \
+		$(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
 		-I . -I $(srctree) -I $(srctree)/board/$(BOARDDIR) \
 		$(foreach f,$(of_list_dirs),-I $(f)) -a of-list=$(of_list) \
 		$(foreach f,$(BINMAN_INDIRS),-I $(f)) \
-- 
2.34.1

