Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA2AC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 16:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90E6888545;
	Tue, 28 May 2024 18:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="USXWf2jq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 409F88841D; Tue, 28 May 2024 10:46:54 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3563E88402
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=patrick.barsanti@amarulasolutions.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a621cb07d8fso64135866b.2
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 01:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1716886011; x=1717490811;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t2SWL/rYa8niV3/RQpnBIm2+jnJ2QW3c+pGyrDmW7Uo=;
 b=USXWf2jqwH0YsZ36lwRBv43LFebdvsC3CEp8GsFcijVaDEJ2iacf64CUEocjYQdRpG
 L3THKdvEC1CPvqWi7O2KwLL7kA48GPKKRX3nO54bxIHw7Ldhe5nI9WxalEZpoiNjgn3S
 0gzoNDMYlTZhcTUw+LJgbcltoD0mKP7ZyE1+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716886011; x=1717490811;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t2SWL/rYa8niV3/RQpnBIm2+jnJ2QW3c+pGyrDmW7Uo=;
 b=BZ1rTHV1OMKFonxI3LbzL/m71KGkkqjuC7sSrmBFk3wbnHsUBVwTDAjnuZp8G2SOPz
 3H+0TmZkM85xHvM+DCuPxRDhXgP4gSOuLH0tzUDtVIUEEXZf2NfnnXP49u6P885b0ef4
 8FlP3hLUeMTC1jNhCGQ/KigkMMgrYjn4nRMHrK47HThkJl04Qly8NaHNiAmNN7lCO2BI
 JrviulfmWCIQhFn54KAJkacjn3j8b5V7aS/pWhjGzWCdbFMRNBAf6T10QAbzlxChN2Jm
 7md8DRE5/C9zTHWhruuNooH24W/UegmVIW6LPhhLzE2kUEm52BEhZrbdEdUKUvof6A9s
 cKyA==
X-Gm-Message-State: AOJu0YyqHGa1BU5VZpGrMGMBKKGok7ztTYKYcEmCJuTn5Ska/pOsWUoX
 ZThAfM9yeRHNCoUezOuCUAsFopBZklAvGXfpJi0v0iG5QTf/5O8EF54EQGwEo/PvpvrExOKZo1w
 o9Kw=
X-Google-Smtp-Source: AGHT+IEXzpw/Y089rZexau67cWL5+wuOVvA0S+SHnuh/njUAmfAHqsWZCEV8sg545s5ZSSJJApoQgQ==
X-Received: by 2002:a17:906:b00d:b0:a59:df1d:f5ae with SMTP id
 a640c23a62f3a-a62641bbae3mr809325466b.31.1716886010905; 
 Tue, 28 May 2024 01:46:50 -0700 (PDT)
Received: from localhost.localdomain (i116103.upc-i.chello.nl.
 [62.195.116.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c93b4fdsm586851466b.79.2024.05.28.01.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 01:46:50 -0700 (PDT)
From: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: sjg@chromium.org, xypron.glpk@gmx.de, afd@ti.com, sumit.garg@linaro.org,
 marek.vasut+renesas@mailbox.org, bb@ti.com, mr.bossman075@gmail.com,
 leon@georgemail.eu, linux-amarula@amarulasolutions.com,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
Subject: [PATCH] Makefile: Fix include directory for OF_UPSTREAM
Date: Tue, 28 May 2024 10:42:24 +0200
Message-ID: <20240528084224.113385-1-patrick.barsanti@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 28 May 2024 18:47:36 +0200
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

Always prioritizing u-boot includes causes problems when trying to
migrate boards to OF_UPSTREAM that have divergent devicetree files with
respect to the upstream ones.

For example, migrating a board based on `imx6ul.dtsi` to OF_UPSTREAM
breaks it, as there are some missing defines in the local dtsi file;
the solutions would be to either patch it, which defeats the purpose of
OF_UPSTREAM, or delete it entirely. This last option would then break all
the other boards which have not yet been migrated to OF_UPSTREAM.

The opposite problem also exists: by always prioritizing upstream
includes, if changes are made in the kernel headers and devicetree
files that are not backwards compatible, again all boards which have not
been migrated to OF_UPSTREAM will break.

This patch fixes this problem by prioritizing upstream includes when
`CONFIG_OF_UPSTREAM=y`, while keeping current prioritization when
it is not.

Signed-off-by: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
---
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
2.43.0

