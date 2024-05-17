Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149CBC25B79
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 15:46:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C319988253;
	Fri, 17 May 2024 17:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i39PxvN7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F407D87ECC; Fri, 17 May 2024 17:45:56 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D983688001
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 17:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-69b514d3cf4so8041476d6.0
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 08:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715960753; x=1716565553; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k+7e7rwitc8Rh83GYr+WvJx8rbZDtTT1AJOIbD6kJv0=;
 b=i39PxvN7R/aoW5t+B1FSbYi/ZkJY16iJ+98zl2sO5K8ZzJ44kjCR3CKUzQ3shJSBY9
 mPg3g5UeA0CTJjJWDi3AWoHQfPu05xJRBUgS8f8qRbmGBOCTylIhukVokFabASlkJf+q
 xQmMRTK4Gba4JYJFXmnx3ocEvmwg/Iqh/Btp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715960753; x=1716565553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+7e7rwitc8Rh83GYr+WvJx8rbZDtTT1AJOIbD6kJv0=;
 b=FvrCT8DCFp19aAMn49VcI9ZqIWLb4h+Yi44Jtvu/J3TepUKfNjFZe2/0XfBuClyyIo
 hWR+qCmFqjmwPIZjQ1ENKiK+giyzA+l1+/2GgcL14G4lcvMV06C6ld4EuiWelAJA3Q0/
 P70XpJqp4DDjptOLyynKyWtcaqbnK4XNEBoqKlGEEfBEwNWsvyH4SFxBfoANbyTZMJbR
 vE1P93u5lJ01pD7dx0FkaTKYdsTH21/mDfseEou3GlSGoNzvI4zVcGaxoXLl/Ez3+yET
 MAam5pqCesek/cTfNkSlZh0iJuN8png3nTAR/Y55/DmIzgFZ88YC4zOkKByolgzwWIxT
 Blvw==
X-Gm-Message-State: AOJu0YyrRuZepHzujRT5mM4bbhwlC9pJ92kZL6mJIwGBORq2GiW6qgD6
 ToJFnIKoDTixC9DBvanTvnccKonc+abHzrRH5omsLKUOT9sWZIXbXKDGYMugndjRh7cUHlbm2gl
 ml6U=
X-Google-Smtp-Source: AGHT+IEfTlFzH1UMNf9z/zK59NV2T65oqcDB8nlNMDn9eTQLob6hHl+SGQCstC7W000C8Tj+lbESrg==
X-Received: by 2002:a05:6214:4506:b0:69b:bcc7:f823 with SMTP id
 6a1803df08f44-6a16814eee2mr331470176d6.14.1715960753573; 
 Fri, 17 May 2024 08:45:53 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a35384037esm33953326d6.73.2024.05.17.08.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 08:45:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [v2 2/2] doc: process.rst: Document device tree resync rules
Date: Fri, 17 May 2024 09:45:49 -0600
Message-Id: <20240517154549.1020534-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517154549.1020534-1-trini@konsulko.com>
References: <20240517154549.1020534-1-trini@konsulko.com>
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

Document the logic of when we do a full resync of the device trees used
by OF_UPSTREAM as well as that cherry-picking is allowed as needed.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Address Quentin's feedback

Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/develop/process.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/develop/process.rst b/doc/develop/process.rst
index a66540a698c1..0542b3fc1245 100644
--- a/doc/develop/process.rst
+++ b/doc/develop/process.rst
@@ -108,6 +108,19 @@ Differences to the Linux Development Process
   In U-Boot, ``"-rc1"`` will only be released after all (or at least most of
   the) patches that were submitted during the merge window have been applied.
 
+Resyncing of the device tree subtree
+------------------------------------
+
+As explained in :doc:`devicetree/control` some platforms make use of device tree
+files which come from a git subtree that mirrors the Linux Kernel sources
+itself. For our purposes, we only track releases and not release candidates for
+merging in our tree. These merges follow the normal merge window rules.
+
+In the case of specific changes, such as bug fixes or new platform support,
+these can be "cherry-picked" and are subject to the normal merge rules. For
+example, a bug fix can come in later in the window but a full re-sync only
+happens within the merge window itself.
+
 .. _custodians:
 
 Custodians
-- 
2.34.1

