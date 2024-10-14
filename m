Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC12CD18158
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 22:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A1EA89280;
	Tue, 15 Oct 2024 00:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OTBsxZf9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1747988DEA; Tue, 15 Oct 2024 00:32:35 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3447889270
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 00:32:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a39f73a2c7so18456795ab.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728945149; x=1729549949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lVvfME+AG/WoQlXxQ2/am0Q9+Mhbq1pAcg9qSDtFdAE=;
 b=OTBsxZf93UyKEJWau5JJRIrLs9RFfn27n0hL9uTAgSTamKaLyt8AFiNRCqGk4yeibs
 r7ZOFSl03BzFldmIczqfBWYnK52EZfHJo3qe8VlvWBC/IMlPAn01SasksxHYZr8HBhTJ
 oiJV9kPAjHbtJoaOsXM7aGgZyR/7lMBcmYPog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728945149; x=1729549949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lVvfME+AG/WoQlXxQ2/am0Q9+Mhbq1pAcg9qSDtFdAE=;
 b=Z9shdTNSKOiDTqF36+BnOj8v5bNPbAHQqdvWHzDZn6mcp/EetcYRc+eDtQk/qtBwmo
 WrGQo1TcNwYpvvjWxnKqfmSCPiPY3BeITFgKWJmfBH/38ypnmdc2evPiKFkQ0bfYk5yA
 0whjWif4X4023PCkCJpp8uHOS05UxNDEGyBsFth6mX7WTcvt2O2r1zk9pJPhgoTGOZ52
 rAnhc0XbFmbeKAuZvRbdedJRGovhgOvVJdkFXtXMHH6WOv29QhIErrwEa3NIaJbNVJTi
 y0sNAHN1XQzK+p4oaPP3Cc5lHpJzg0HpkXPSYnpeGt5NzAwDAMUvGl2EGCv1XDb2RzYY
 hzug==
X-Gm-Message-State: AOJu0YyDEIFJzFl/1lbzdEwzSJnM1hbLrTeTd4rJij7PN6DlavZ+Oy3m
 LguDq/tbAHGelEfTM5TZQ35oew96is7E2zvv0bSrc6KEg8sOCnO2GCkLHtU/agvw+xULxScLc3+
 vOw==
X-Google-Smtp-Source: AGHT+IHdfr6V+IV76k9NEqTjqyDkUFKnAKGFj9nfu8h211E+7Ev7XLacsfznu6aSSlcZBmhJ06lSZw==
X-Received: by 2002:a05:6e02:19c9:b0:3a0:9aff:5047 with SMTP id
 e9e14a558f8ab-3a3b5fbd5b1mr118910235ab.22.1728945148802; 
 Mon, 14 Oct 2024 15:32:28 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbecc4924dsm14847173.153.2024.10.14.15.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 15:32:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 14/20] doc: Update coreboot's CI information
Date: Mon, 14 Oct 2024 16:32:06 -0600
Message-Id: <20241014223212.2212442-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014223212.2212442-1-sjg@chromium.org>
References: <20241014223212.2212442-1-sjg@chromium.org>
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

This is in the Dockerfile now, so update this section of the docs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 doc/board/coreboot/coreboot.rst | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/doc/board/coreboot/coreboot.rst b/doc/board/coreboot/coreboot.rst
index 7154f59c374..a177265c16e 100644
--- a/doc/board/coreboot/coreboot.rst
+++ b/doc/board/coreboot/coreboot.rst
@@ -181,16 +181,4 @@ coreboot in CI
 CI runs tests using a pre-built coreboot image. This ensures that U-Boot can
 boot as a coreboot payload, based on a known-good build of coreboot.
 
-To update the `coreboot.rom` file which is used:
-
-#. Build coreboot with `CONFIG_GENERIC_LINEAR_FRAMEBUFFER=y`. If using
-   `make menuconfig`, this is under
-   `Devices->Display->Framebuffer mode->Linear "high resolution" framebuffer`.
-
-#. Compress the resulting `coreboot.rom`::
-
-      xz -c /path/to/coreboot/build/coreboot.rom > coreboot.rom.xz
-
-#. Upload the file to Google drive
-
-#. Send a patch to change the file ID used by wget in the CI yaml files.
+To update the `coreboot.rom` file which is used, see ``tools/Dockerfile``
-- 
2.34.1

