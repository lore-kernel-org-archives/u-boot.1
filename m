Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF00E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC0AE80040;
	Wed,  1 Jan 2025 23:16:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="al83Oy2V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51F928069A; Wed,  1 Jan 2025 23:16:43 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E454580040
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-216426b0865so142771905ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769797; x=1736374597; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6IBU9z6U5X0jpOsLlOO/RQ8+cmyntmScfALoAtgzYYI=;
 b=al83Oy2VgNdzcAavVcwNI/egK6ApulI8HWekcSDtWewWEJTj32BY+E7Jh9WYKutjfO
 RycYxrlFXJrbCPMfmXk9gfEzJcLTq3i6hWlSlXbX3CWFAaMXKqwUMA704dB0ljC3oau6
 ly5jfeqHNYdmkNLHkZgxIVJMR+Wn9UClWd8ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769797; x=1736374597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6IBU9z6U5X0jpOsLlOO/RQ8+cmyntmScfALoAtgzYYI=;
 b=kB4GEUqxME5RNIhW0UAtWmoPka3vZKNP8v4bzJmE0CWtsl0Q1QdyRwL37ANyRAo+Fx
 GRPez49XF7avIriKKKFZjyJIRFPxdKiaNQDK1aj4yFnxLZk1/ARk6bPHLOBZqHKQSVsW
 JOJsZL/wrHSzKBifkl17d07zaUrvYzuMfUWUVwzxEabp14FsGeJzOjbq4cMVjKrx3Jnw
 04noyMORZXFnsBb8HWFTsQ+P1rOb0fpFTWEaUiFbcVMuP39zz05CwRtYcrypHkyZUDK+
 /4MhAiDXYj3ml9frundP4MopGVW5aPCXl2op+ZMWfeQ06PGeL8lC6/3bTvzCRlQInDnj
 2thQ==
X-Gm-Message-State: AOJu0YxVZJ7iyX3xL5uLV/CyXZwhHtCv+CVELKr1B10eOtJFmIyZsXun
 SB1TfV6M4EPjWJsB9DZ9KHniqQRlxKkFq7Bb40IqOwkzDhIjK7qv+I22v1aJCe7DdpHmj+DB9BE
 =
X-Gm-Gg: ASbGncvX6wTKUOI62j6MORz5iAGd4turkQvJ09z5av/Gw8ZbzIFBmOTdh6cpwn/1R3v
 kxPV+Fy4cgHXtz9ioGgQRFrKqx8KaLqY0mGAIDjzLtYL2jup9kDtFOm9iCREIiTytlsRrWhsxrc
 CAd9wfGtvsm940VMVbxMChZCMxNm4jsZX/uPQpZH9MtYgYiChSdQHOHiqHCXPydGAvKMG1Pvv41
 cqomq7uJRJIYb1nh9BlT7qSX3cP0VfQ1cqIDt1DGkvmR7lp/R1SBh8=
X-Google-Smtp-Source: AGHT+IFcG6erehoFhx2E+nHGAykbPXs8c99bs2+sLONznVzGMA4YAf0SfpGXcbsYrHDJIVtbbZ8OTw==
X-Received: by 2002:a05:6a00:600c:b0:71e:16b3:e5dc with SMTP id
 d2e1a72fcca58-72abde84e5cmr62728142b3a.19.1735769796857; 
 Wed, 01 Jan 2025 14:16:36 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:16:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 32/67] x86: Enable UPL handoff for SPL
Date: Thu,  2 Jan 2025 11:09:18 +1300
Message-ID: <20250101221003.1944600-33-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

Add the GD_FLG_UPL so that a UPL-handoff is created.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/spl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/lib/spl.c b/arch/x86/lib/spl.c
index aad748532d0..7a033505101 100644
--- a/arch/x86/lib/spl.c
+++ b/arch/x86/lib/spl.c
@@ -298,6 +298,9 @@ void spl_board_init(void)
 	if (IS_ENABLED(CONFIG_QEMU))
 		qemu_chipset_init();
 
+	if (CONFIG_IS_ENABLED(UPL_OUT))
+		gd->flags |= GD_FLG_UPL;
+
 	if (CONFIG_IS_ENABLED(VIDEO)) {
 		struct udevice *dev;
 		int ret;
-- 
2.43.0

