Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DEECF6498
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 01:50:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC34F88D9A;
	Mon, 30 Sep 2024 03:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PoxGtDtr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FBED88D9C; Mon, 30 Sep 2024 03:50:12 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91EF188DC0
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a1a412638fso16590815ab.1
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661007; x=1728265807; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4Zbsl3FmgVUUNcL4fqwwQH2wLjEgIXNiyEBtDIEC5M=;
 b=PoxGtDtr05Y7s3F58PQvMjY/yV+jP6EYvKpi5Lh7kKoFR/vxtsuXyCWJSaQxRNvFrd
 lO1SJYr2VYhUuHMJU+xnIxUSwAOAkggTFR1rsFR+yS7wA7fZWpVA3mitQ1iimr2Jfbbv
 b0y0zu2xjXLOl5tnp9RSxVHPl4ngzfJ1hsKik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661007; x=1728265807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T4Zbsl3FmgVUUNcL4fqwwQH2wLjEgIXNiyEBtDIEC5M=;
 b=cN/4hAL0ajktvg1ZP2TuZdF+kMYn/+hVJAS1au+sYA15V86w8TLz4zF062Ljtf2MO9
 URFWqr1iVc1aPwyTGn7HLXnLtDXCaLfcnyAH4ktIIfuZTGMFWxT6p8haqYZdy9DiEDE8
 0Kz/iTKuOTe1rxsrbohg70pJoLbCjRztX6XrNYVeAgNi35Fkj20waSnGo9iqNvKboXCl
 D04ZceLGCsowZcv5gtbR0KgIkcs/LEN9f9Yu14WfiLB2hTbLX5roBHhJ594OcN8H3Z7O
 16olAxUWoEd9gD+dYiFrQLAh+f0igjcFoJO6LLANmYpm2JXNC9736KfYec91Gb4kncqG
 dvrQ==
X-Gm-Message-State: AOJu0YwQUpRinaUhCO3m1Qa9L3WWiW4FQdWedBS1yENZaiKjG5xBPr9a
 2m7y17yEk4uAM8rGB00eBiZEdm0nTblVNxP7tmuBX05UIKl00z+ophY0cedgd5GgXWApXNqIO2X
 lHA==
X-Google-Smtp-Source: AGHT+IGGLDED+867h+JLL8GrTt15WCc9rv4mk+hC01pD2xCMpeZSojF4sRPgia9EgVuOioXw6lUdxQ==
X-Received: by 2002:a05:6e02:1848:b0:3a0:9043:59ac with SMTP id
 e9e14a558f8ab-3a3452bf576mr84287025ab.25.1727661006956; 
 Sun, 29 Sep 2024 18:50:06 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v3 02/33] boot: Drop unnecessary ifdef for LOAD_FIT
Date: Sun, 29 Sep 2024 19:49:25 -0600
Message-Id: <20240930014956.1434060-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
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

Use the normal SPL_TPL_ approach for this option.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/boot/Makefile b/boot/Makefile
index f4675d6ffd5..40e2337de0f 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -58,9 +58,7 @@ obj-$(CONFIG_$(SPL_TPL_)FIT_CIPHER) += image-cipher.o
 
 obj-$(CONFIG_CMD_ADTIMG) += image-android-dt.o
 
-ifdef CONFIG_SPL_BUILD
-obj-$(CONFIG_SPL_LOAD_FIT) += common_fit.o
-endif
+obj-$(CONFIG_$(SPL_TPL_)LOAD_FIT) += common_fit.o
 
 obj-$(CONFIG_$(SPL_TPL_)EXPO) += expo.o scene.o expo_build.o
 obj-$(CONFIG_$(SPL_TPL_)EXPO) += scene_menu.o scene_textline.o
-- 
2.34.1

