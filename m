Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE718C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 16:51:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9378688B67;
	Mon, 26 Aug 2024 18:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sCEsmUZE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 954B088BA0; Mon, 26 Aug 2024 18:50:13 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0769088B59
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 18:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5dca9cc71b2so3267380eaf.2
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 09:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724691010; x=1725295810; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x1Lx2yaQ3H3anJsVnD0VtgCxaiNiB0ECUTK9k6vfrzA=;
 b=sCEsmUZEyQOwYlXZCmH4MGlkZoblFEb03wXGvcRH6ll3XEAkntkdqqR/fYhIgYrTwS
 HuktxGKaMhoUHxbBJMWHq9GnyHVZaHFCHamx4y4BNFZVldepXezdTDHFXtsCzDe8tX9p
 N0B0IoKnH9dE5bYvuoyOJLAln/p8q+xKbuGSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724691010; x=1725295810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x1Lx2yaQ3H3anJsVnD0VtgCxaiNiB0ECUTK9k6vfrzA=;
 b=Sz/f9oXSURJlO9Ns8QFVHsCJjO0qQ1SFe62T8DcJyyyTBGVwcrGzMGPm/1wkECwKBk
 L/2F6KQGjbq1VVO66L09WZ7GU7txYZBDHcjU57tfChxy7tc6x47M7GnL/TYpBklLl1aE
 IdUVTKJLlIJp6gcbysM2lp8AwCjeYd9aQICprUpTxjs9YV0HH+c2XLTwg3Ym2q/Lr9GW
 F3aofkIhUXRkoa6HMMCP12fBFved8NwFckfOMRnsZxZCFNWzzZih4ZiMPdYjIk2YVFEz
 hExu08mCUEC1kum5LM47FxxFFV0ZoErcH+SPKsbCkc9a+sPN1g+TVgv6MrfuGlZFSEn/
 UCVw==
X-Gm-Message-State: AOJu0YwO6N0rhKipB+naVGcYSGGOUT+cmCzSNEtqxebWFv/L3CF9Uc59
 iUmA8julqj4x5xikaa4My+R3AmiGtkD1Z32FVuT8YxyQQMTdzDTBsW5Wg23HKMRI/1xOui8ErJE
 2
X-Google-Smtp-Source: AGHT+IHmeKQ7a06aXWeccyvEAnfYja5g/X/NwLDZJCqyJxlD6eGo99CCgcoBSKI+ZXXkr4jOlp4G4A==
X-Received: by 2002:a05:6820:506:b0:5d5:d5ad:35f8 with SMTP id
 006d021491bc7-5dcc6289713mr11326675eaf.8.1724691009511; 
 Mon, 26 Aug 2024 09:50:09 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d1d242sm48576136d6.16.2024.08.26.09.50.08
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 09:50:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 6/6] binman: Update links for sending patches
Date: Mon, 26 Aug 2024 10:49:57 -0600
Message-Id: <20240826164957.2789525-7-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826164957.2789525-1-trini@konsulko.com>
References: <20240826164957.2789525-1-trini@konsulko.com>
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

When linking to our documentation for submitting patches, we shouldn't
point at the old wiki but instead our current documentation.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/binman/entries.rst      | 2 +-
 tools/binman/etype/atf_fip.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 124827037820..d82f7b89203d 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -221,7 +221,7 @@ FIPs so that binman and other tools can access the entire image correctly.
 
 .. _FIP: https://trustedfirmware-a.readthedocs.io/en/latest/design/firmware-design.html#firmware-image-package-fip
 .. _`TF-A source tree`: https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
-.. _`send a patch`: https://www.denx.de/wiki/U-Boot/Patches
+.. _`send a patch`: https://docs.u-boot.org/en/latest/develop/sending_patches.html
 
 
 
diff --git a/tools/binman/etype/atf_fip.py b/tools/binman/etype/atf_fip.py
index 73a3f85b9f4e..3da0dfcfc126 100644
--- a/tools/binman/etype/atf_fip.py
+++ b/tools/binman/etype/atf_fip.py
@@ -163,7 +163,7 @@ class Entry_atf_fip(Entry_section):
 
     .. _FIP: https://trustedfirmware-a.readthedocs.io/en/latest/design/firmware-design.html#firmware-image-package-fip
     .. _`TF-A source tree`: https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
-    .. _`send a patch`: https://www.denx.de/wiki/U-Boot/Patches
+    .. _`send a patch`: https://docs.u-boot.org/en/latest/develop/sending_patches.html
     """
     def __init__(self, section, etype, node):
         # Put this here to allow entry-docs and help to work without libfdt
-- 
2.34.1

