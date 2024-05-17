Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF313C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 17:49:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28932884F5;
	Fri, 17 May 2024 19:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="isK4PJHz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80D7E8818C; Fri, 17 May 2024 19:49:38 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 595AD884DC
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 19:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-de462979e00so454848276.3
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 10:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715968175; x=1716572975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dJIBPSaNBte8/5D2N5KpRdFZseY2ahDeWfW6lKPKN40=;
 b=isK4PJHzdzpwiwjUWqMz8nXx5z0xR7n4xfuDqHqPCf/3ULIhzKSIO62x6OfHj4YP1F
 xODc9qV0ydAXzzrNRumXEnBno1UxWMF4HUDyc3ckEZ4tEldj1ms8zmsSHw9ZQ9guZ775
 dFBMqnKm5IVAAw1P6EHsVK+MAHqUcxom4RAB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715968175; x=1716572975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dJIBPSaNBte8/5D2N5KpRdFZseY2ahDeWfW6lKPKN40=;
 b=eZTog1FGIlDOiXxD8VGgQW4MRYNjCrLhtiHLqNp7EcTeOS/kmIt1Ox4Tqi2beazpLL
 OJlmhK1nrYhyn62fwE9wawgMNxZnO7QqgLIES2mgwjfhodmhudvJSLNlQ5NtpZM7gEJO
 cTKDs5sn3W3SXTQR81rIxnRP3ne4wfE+nexyJ/IbcdD0ub1RKRfufpkhswNWk24/mmVu
 CWn/YVXGIhr1RvNkroirXbEUIniQr0IijtSs6lnnmy3WMphOLxppUlRmBdja0GOyNA5K
 TIflRgN17F3cdhqHVpg/ol3YiYKt+aJxEHnfC2sKM8Nxk+rR5n8Eg1uWL7Rhn3ZyryqB
 Elqg==
X-Gm-Message-State: AOJu0Yz8rh2EDGb3avHuzYwsf974VUuXY6YO6NwUWY2lH8BW/klB8Xu8
 y9Wrekr3o5/BHRRk9g733ygAUZgzcsAF/sIeMH2wVbXa4tt4mi9MtSu3at4BCtCC10oQpQDv0X7
 Vld4=
X-Google-Smtp-Source: AGHT+IE4w3iACzfoDs2FyvO14n8uQmY/G+Sv2SnHgyE4lfQkIHKcpRvQf4kKXTxQ9aDyij91Ae54+A==
X-Received: by 2002:a25:2b8a:0:b0:de6:143b:193 with SMTP id
 3f1490d57ef6-dee4f3aa52fmr21737183276.50.1715968174892; 
 Fri, 17 May 2024 10:49:34 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1cccf3sm87724996d6.86.2024.05.17.10.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 10:49:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [v3 2/2] doc: process.rst: Document device tree resync rules
Date: Fri, 17 May 2024 11:49:30 -0600
Message-Id: <20240517174930.1028063-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517174930.1028063-1-trini@konsulko.com>
References: <20240517174930.1028063-1-trini@konsulko.com>
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
Changes in v3:
- Actually commit the changes I intended for v2

Changes in v2:
- Address Quentin's feedback

Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/develop/devicetree/control.rst |  9 ++++++---
 doc/develop/process.rst            | 13 +++++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index 4cc1457d4ea8..ca4fb0b5b10f 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -113,9 +113,12 @@ SoC being used via Kconfig and set `DEFAULT_DEVICE_TREE=<vendor>/<name>` when
 prompted by Kconfig.
 
 However, if `dts/upstream/` hasn't yet received devicetree source file for your
-newly added board support then you can add corresponding devicetree source file
-as `arch/<arch>/dts/<name>.dts`. To select that add `# CONFIG_OF_UPSTREAM is not
-set` and set `DEFAULT_DEVICE_TREE=<name>` when prompted by Kconfig.
+newly added board support then one option is that you can add the corresponding
+devicetree source file as `arch/<arch>/dts/<name>.dts`. To select that add `#
+CONFIG_OF_UPSTREAM is not set` and set `DEFAULT_DEVICE_TREE=<name>` when
+prompted by Kconfig. Another option is that you can use use the "pick" option of
+`dts/update-dts-subtree.sh` mentioned above to bring in the commits that you
+need.
 
 This should include your CPU or SoC's devicetree file. On top of that any U-Boot
 specific tweaks (see: :ref:`dttweaks`) can be made for your board.
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

