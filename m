Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4DAC43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 19:34:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E68084A1D;
	Sun,  5 Jul 2026 21:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UyRu6ehf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B554A84A1D; Sun,  5 Jul 2026 21:33:46 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4547284987
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 21:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6a17e36fa79so614677eaf.1
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 12:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783280023; x=1783884823; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xyt4kRmTO9AYpr9a87JLrYKLFaoVMn6SZg0W7GtzBFY=;
 b=UyRu6ehfLCXrN7y55PYkqOmPDsbvBlnJiGzdE/8QqihWsi5pi2F34uuxgMSWFtWyO3
 Azz7FOyLCUhZjesAkIRbmAAi6FisHzeHBTrwwb3pk3szRkRI0n39a5mh7knd1+CSZsI/
 IXsQADM5GzI3I4NL/nEXzvKj50g9OKHKBaWq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783280023; x=1783884823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xyt4kRmTO9AYpr9a87JLrYKLFaoVMn6SZg0W7GtzBFY=;
 b=UAVDWX0sUHpD41SdtCUu3ZBrkJstlHDLhMMzjn5r9y5fscyt3XtNltvGgHOv3/aRrl
 zxMsiv6kTuZDFfjqxqpPLI9v1LY37U+462kIlp+0jAEEvpYQ9ChKb5ZF5uIy97zdqjoO
 /y+AmREb69xsXZRWQC7HhE/ABr63jTJUubVDJyt9eBB0twhZxil9xLKIoDI15zsBwVH5
 eYKYj2odpr5TlOJl1a6+/2ZzICb8aeipV+99Um33qpNwKRxVqYZQ0dcjHk7+NPkl/eCq
 yGQYKkr58OttSv5thsU8vOgLkK5BZbBXhfFxE+TQhrdNZZByG0iDMiTrXYyBDsn5nPi+
 P3Fg==
X-Gm-Message-State: AOJu0Yxwziu4GP3VsdnQB2tOmp9GQP/2mWpXw7cA4u3vuHNMZwg5MH4Q
 yOsd39RRCuL5vTJDujEvgqTTParCaUOVHQRR8qvLPaQym95fequ8Ypr3dGIUfgWTrldUwg3sB7p
 gbigTRA==
X-Gm-Gg: AfdE7cnxWzVKiaVjOh6RMkU3msOlV9CbvOuq31XgfUpnCq9kdInnqgt8C1jbyNRe3wl
 5cBZuav/8u/nf3nalcWPtR41T+NmIvUPp/8TLJa4q/5WNnaEFPvg8QxU8ROZ79KJBZeNGW206FR
 kX+q+qSUCT18dc4F8nuh0Xevko7g4mISBWC/bQC+3YMKvTeZN+V3E3GwFG2mcT0FCusLnV7UP09
 xtAYYUmugFv2Ck671HGrZwsy6uiqVdeI2fleZD6JcmK2NHgZ/4bdjS7syMJ2k0CY4hr6ZMmL6QK
 eIK/B5DhDwZXL5K9AKGtfVykKysqGWFRkf4PXNeAjTxOx5GpnQ1QcSPUHbma0UF0hQ2bBeUabzV
 eBb+at/xtYcFr0t7YL2CJDpq9YP5WO41JyfkpRxl/8JbfRspeNgWl6dII6fNTUbELJcBC
X-Received: by 2002:a05:6820:81d1:b0:6a1:50f0:cccc with SMTP id
 006d021491bc7-6a32f625c3fmr4070963eaf.65.1783280022637; 
 Sun, 05 Jul 2026 12:33:42 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a3103e064esm7513448eaf.14.2026.07.05.12.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:33:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymondmaoca@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 09/11] tools: docker: Drop patman from the CI image
Date: Sun,  5 Jul 2026 13:32:20 -0600
Message-ID: <20260705193251.2190705-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705193251.2190705-1-sjg@chromium.org>
References: <20260705193251.2190705-1-sjg@chromium.org>
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

The CI runner image pre-caches pip packages by downloading each tool's
requirements.txt from master. A later patch removes patman's
requirements.txt from the tree, so stop fetching and installing it.

The same step already installs setuptools explicitly (patman's
requirements list it too), so this needs nothing further.

This takes effect the next time someone rebuilds the image; the existing
image keeps working in the meantime.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/docker/Dockerfile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 73bf6cdd2c5..a91a1060cc4 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -362,7 +362,6 @@ RUN wget -O /tmp/pytest-requirements.txt https://source.denx.de/u-boot/u-boot/-/
 RUN wget -O /tmp/sphinx-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/doc/sphinx/requirements.txt
 RUN wget -O /tmp/binman-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/tools/binman/requirements.txt
 RUN wget -O /tmp/buildman-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/tools/buildman/requirements.txt
-RUN wget -O /tmp/patman-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/tools/patman/requirements.txt
 RUN wget -O /tmp/u_boot_pylib-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/tools/u_boot_pylib/requirements.txt
 RUN python3 -m venv /tmp/venv && \
 	. /tmp/venv/bin/activate && \
@@ -370,7 +369,6 @@ RUN python3 -m venv /tmp/venv && \
 		-r /tmp/sphinx-requirements.txt \
 		-r /tmp/binman-requirements.txt \
 		-r /tmp/buildman-requirements.txt \
-		-r /tmp/patman-requirements.txt \
 		-r /tmp/u_boot_pylib-requirements.txt \
 		setuptools pytest-azurepipelines && \
 	deactivate && \
-- 
2.43.0

