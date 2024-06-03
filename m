Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFC7C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 15:08:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2895688350;
	Mon,  3 Jun 2024 17:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="X1X+V4rN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A63E688350; Mon,  3 Jun 2024 17:08:34 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F43E88282
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 17:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=patrick.barsanti@amarulasolutions.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52b98fb5c32so1717167e87.1
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 08:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1717427311; x=1718032111;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xjusg0SwUurd/i2HT45Mm88san4GAPhGrMMT37/MxDw=;
 b=X1X+V4rNsLUXml5NxY8dRs41cqSsBQUZY+PD9XHZg3kVC/rOnQVe6v6DGCyB3cWbv3
 HgOzyTOH/IaJmPm0T+87mBp3uiwFhw2LCQdpe4pxsqkO1kNChOPdBsoo4abTpD+NEpSs
 IkYA+zme8GBSPdSYAl1G+Qscr2pk6PJGqUdDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717427311; x=1718032111;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xjusg0SwUurd/i2HT45Mm88san4GAPhGrMMT37/MxDw=;
 b=o5uwGqqxI9VKQy3IEg5LQUDJ8zM6aDEq4iUiCCKX4QISvZQToMs7wpaZTK79Uu3crO
 QgqZP6eC0+pVWFV+O+vWlzzf/YxKpDIOp+JLRpPQ9b54fgPK6XOR2fEYuaK1aO7Gdx2e
 Xd2w7rZpLWTgjCNiyk2aWEDFHnx7cv6ze+70eV17Xy2WZjAOpjJZgn6MXyJAuB00o5vy
 c5oT+DVwlM8ky1h+T2DWEmEoleJtZnlhQipKPesYa5jEeUcVVWsud+d/YvQ3Rfl/KZAL
 9ECxwwDOkEK1i/lXw6fjqrZv6iECDmja+3feXbARuxtSfdHNELWFNtvlKR/SThyn34g2
 enNA==
X-Gm-Message-State: AOJu0YzR84/Q3pEIizHVb7oqzMVaKHXJHmef2U/Ry/sq3KCWKPJZCT3q
 NgZ+8S8DwHlRpaZPcs1qlGfTQPFCczLjrtC+TGl2oAVfJIWQ1aB4ffSeFOIkd/DXTVrpf9g7K07
 U
X-Google-Smtp-Source: AGHT+IGH7ZZZnZe0Nasir8qrxcWm4krZqaUizi4b/ZHQZht4yS9GMpyQ7e4HB11xii1zxVW+nlTvwA==
X-Received: by 2002:a05:6512:2508:b0:529:b691:e37e with SMTP id
 2adb3069b0e04-52b895715eemr9274754e87.40.1717427310628; 
 Mon, 03 Jun 2024 08:08:30 -0700 (PDT)
Received: from localhost.localdomain (i116103.upc-i.chello.nl.
 [62.195.116.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68cb11fa2csm319735366b.198.2024.06.03.08.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 08:08:30 -0700 (PDT)
From: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: sjg@chromium.org, xypron.glpk@gmx.de, marek.vasut+renesas@mailbox.org,
 sumit.garg@linaro.org, afd@ti.com, bb@ti.com, mr.bossman075@gmail.com,
 leon@georgemail.eu, michael@amarulasolutions.com,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
Subject: [PATCH v2] Makefile: Fix include directory for OF_UPSTREAM
Date: Mon,  3 Jun 2024 17:07:49 +0200
Message-ID: <20240603150749.507797-1-patrick.barsanti@amarulasolutions.com>
X-Mailer: git-send-email 2.45.1
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

Always prioritizing u-boot includes causes problems when trying to migrate
boards to OF_UPSTREAM that have different local devicetree files with
respect to the upstream ones, if local DT headers are not dropped.
At the same time if local and upstream files are the same, migrations
can be, and have been, introduced without dropping local DT headers.
This also causes problems whenever upstream DTS and DT headers are patched.

For example, now migrating a board based on `imx6ul.dtsi` to OF_UPSTREAM
breaks it, as there are some missing defines in a local DT header file
(`imx6ul-clock.h`); the solution would be to drop it, which has not always
been done in previous OF_UPSTREAM migration patches for other boards
because most of the time the two are the same. This solution is also
vulnerable to ABI breakage, although this has not yet happened since the
introduction of OF_UPSTREAM support and is unlikely.

Maintainers assure backwards compatibility for DT headers when syncing the
upstream folder with the kernel.
The problem is that, at the current state, all boards that have not dropped
their local headers when migrating to OF_UPSTREAM will break once the
upstream devicetrees are patched, for example, to use any newly added
define which is not present in the local DT header file, even if those
changes are backwards compatible.

This patch fixes these problems by prioritizing upstream includes when
`CONFIG_OF_UPSTREAM=y`, while keeping current prioritization when it is
not.

Also in case of ABI breakage in the kernel, keeping redundant header files
(only until strictly necessary, e.g. until all boards including them have
been migrated to OF_UPSTREAM) together with this selective prioritization
of the include folder is a solution for keeping not-yet-migrated boards
from breaking.

Link: https://lore.kernel.org/u-boot/20240528084224.113385-1-patrick.barsanti@amarulasolutions.com/
Signed-off-by: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
Tested-by: Michael Trimarchi <michael@amarulasolutions.com>
---

Changes in v2:
- Reword and correct the commit message following the discussion
with Sumit, per Michael's suggestion.

 Makefile | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Makefile b/Makefile
index 79b28c2d81..899ae664ca 100644
--- a/Makefile
+++ b/Makefile
@@ -826,6 +826,19 @@ KBUILD_HOSTCFLAGS += $(if $(CONFIG_TOOLS_DEBUG),-g)
 
 # Use UBOOTINCLUDE when you must reference the include/ directory.
 # Needed to be compatible with the O= option
+ifeq ($(CONFIG_OF_UPSTREAM),y)
+UBOOTINCLUDE    := \
+	-I$(srctree)/dts/upstream/include \
+	-Iinclude \
+	$(if $(KBUILD_SRC), -I$(srctree)/include) \
+	$(if $(CONFIG_$(SPL_)SYS_THUMB_BUILD), \
+		$(if $(CONFIG_HAS_THUMB2), \
+			$(if $(CONFIG_CPU_V7M), \
+				-I$(srctree)/arch/arm/thumb1/include), \
+			-I$(srctree)/arch/arm/thumb1/include)) \
+	-I$(srctree)/arch/$(ARCH)/include \
+	-include $(srctree)/include/linux/kconfig.h
+else
 UBOOTINCLUDE    := \
 	-Iinclude \
 	$(if $(KBUILD_SRC), -I$(srctree)/include) \
@@ -837,6 +850,7 @@ UBOOTINCLUDE    := \
 	-I$(srctree)/arch/$(ARCH)/include \
 	-include $(srctree)/include/linux/kconfig.h \
 	-I$(srctree)/dts/upstream/include
+endif
 
 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 
-- 
2.45.1

