Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF33C4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 04:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C823E87716;
	Sun,  3 Dec 2023 05:47:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WTJcfGDF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22CF287706; Sun,  3 Dec 2023 05:47:30 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1FC08759F
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 05:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6cb55001124so3466846b3a.0
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 20:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701578846; x=1702183646; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IEOYkIWxn19O59g7NbDrCHr3w21qrFPUzKKjjMYLCB4=;
 b=WTJcfGDF4f8MuK2mOwRSlBivZpdek4UOWTTJBRYHKJIIUWRmZ8Y9hfzR0VhwNSImEr
 kCwx79eM5tYYWhkbUz4bkBuAQf1sTOuwBTiEOnFoVrJ5qL2MQLuxe8F24AXFU57XNZcq
 P363vVubb4/8w7MbCiNu9NjvnUrPSWVVnGMRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701578846; x=1702183646;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IEOYkIWxn19O59g7NbDrCHr3w21qrFPUzKKjjMYLCB4=;
 b=k/ADTIiLcz/Y/WSwB6QFY/BrMtVTr92vWnQ9lIQpa6xpjgCNWVJFRrSEHpI80ywvq6
 fpq3qiZMKHGPM/DZHuSE9fb6FBmtKZcZQQlZcPzwr8HcY4PrM+SK2uIrbPQDOi2fYyqT
 uV+B2bau5WZA5vi4LnqBEQaq0ILhjAyP8bS9HvRAK4qiudaDffbmpIFaI/oHLwpscaNP
 tgb6zVOjjrwPvj/HOHmxHQkZTnEhsFEuwZCxXBr22EwepTSSzQB8r0A3repNyNVdWBa3
 wNzJoLri/4GiooqE28avDSf0xpIKIwLvMePUtbAYxnOwbpdq1ddt4leGfgE1ALG/McXc
 xcJw==
X-Gm-Message-State: AOJu0YxphoV/XrKpCrPnmMLqM1c8m1glxjgmIfBy0qJRUKTi0nQd0ouu
 iqMflH3Gxc+hbDz3OHt0ENU51KnsgO43wi+Giun/5g==
X-Google-Smtp-Source: AGHT+IE5P11DL5uhVbSIAb3M+scnJ+26HxRW9RDvzl+irSKylfrWaKc07ZJcq65wy3DNFSCbUBHayg==
X-Received: by 2002:a17:90a:4964:b0:286:7c14:6d0a with SMTP id
 c91-20020a17090a496400b002867c146d0amr1242897pjh.10.1701578845096; 
 Sat, 02 Dec 2023 20:47:25 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 5-20020a17090a018500b00283991e2b8esm6023919pjc.57.2023.12.02.20.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Dec 2023 20:47:24 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [u-boot-gitdm PATCH 1/2] Use Google LLC for Google
Date: Sat,  2 Dec 2023 21:46:57 -0700
Message-ID: <20231203044719.667116-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The name changed a few years ago, so update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 u-boot-config/domain-map | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/u-boot-config/domain-map b/u-boot-config/domain-map
index f64147e..63cb60f 100644
--- a/u-boot-config/domain-map
+++ b/u-boot-config/domain-map
@@ -17,7 +17,7 @@ amcc.com		AMCC
 amd.com			AMD
 anagramm.de		Anagramm GmbH
 analog.com		Analog Devices
-android.com		Google, Inc.
+android.com		Google LLC
 arastra.com		Arastra Inc
 areca.com.tw		Areca
 argos-messtechnik.de	Argos Meßtechnik GmbH
@@ -129,7 +129,7 @@ ge.com			General Electric
 gefanuc.com		GE Fanuc
 gentoo.org		Gentoo
 geomatys.fr		Geomatys
-google.com		Google, Inc.
+google.com		Google LLC
 gvs.co.yu		GVS
 hanscan.com		Hanscan
 hansenpartnership.com	Hansen Partnership
@@ -421,22 +421,22 @@ beckyb@kernel.crashing.org	NXP
 bflinux@yumbrad.com		Radiient Technologies
 
 # Bernie Thompson <bhthompson@chromium.org>
-bhthompson@google.com		Google, Inc.
+bhthompson@google.com		Google LLC
 
 # Che-liang Chiou <clchiou@chromium.org>
-clchiou@chromium.org		Google, Inc.
+clchiou@chromium.org		Google LLC
 
 # Doug Anderson <dianders@chromium.org>
-dianders@google.com		Google, Inc.
+dianders@google.com		Google LLC
 
 # Dirk Behme <dirk.behme@googlemail.com>
 dirk.behme@googlemail.com	Dirk Behme
 
 # Duncan Laurie <dlaurie@chromium.org>
-dlaurie@google.com		Google, Inc.
+dlaurie@google.com		Google LLC
 
 # Gabe Black <gabeblack@google.com>
-gabeblack@chromium.org		Google, Inc.
+gabeblack@chromium.org		Google LLC
 
 galak@kernel.crashing.org	NXP
 
@@ -450,7 +450,7 @@ gvb.uboot@gmail.com		Custom IDEAS
 # => explicitly wants to be listed as "unknown"
 
 # Hung-Te Lin <hungte@chromium.org>
-hungte@google.com		Google, Inc.
+hungte@google.com		Google LLC
 
 # Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
 iwamatsu@nigauri.org		Nobuhiro Iwamatsu
@@ -476,7 +476,7 @@ menon.nishanth@gmail.com	Texas Instruments
 notasas@gmail.com		Grazvydas Ignotas
 
 # Stefan Reinauer <reinauer@google.com>
-reinauer@google.com		Google, Inc.
+reinauer@google.com		Google LLC
 
 reinhard.thies@web.de		Cameron
 
@@ -484,22 +484,22 @@ reinhard.thies@web.de		Cameron
 rgetz@blackfin.uclinux.org	Analog Devices
 
 # Anton Staaf
-robotboy@chromium.org		Google, Inc.
+robotboy@chromium.org		Google LLC
 
 # Ron Madrid <ron_madrid@sbcglobal.net>
 ron_madrid@sbcglobal.net	Sheldon Instruments
 
 # Sean Paul <seanpaul@chromium.org>
-seanpaul@chromium.org		Google, Inc.
+seanpaul@chromium.org		Google LLC
 
 # Luigi Semenzato <semenzato@chromium.org>
-semenzato@google.com		Google, Inc.
+semenzato@google.com		Google LLC
 
 # Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
 # => explicitly wants to be listed as "unknown"
 
 # Sonny Rao <sonnyrao@chromium.org>
-sonnyrao@chromium.org		Google, Inc.
+sonnyrao@chromium.org		Google LLC
 
 # Stelian Pop <stelian@popies.net>
 stelian@popies.net		Stelian Pop
@@ -517,22 +517,22 @@ smichak.uv@gmail.com		Micha Kalfon
 vapier@gentoo.org		Analog Devices
 
 # Vadim Bendebury <vbendeb@chromium.org>
-vbendeb@chromium.org		Google, Inc.
+vbendeb@chromium.org		Google LLC
 
 # Vincent Palatin <vpalatin@chromium.org>
-vpalatin@chromium.org		Google, Inc.
+vpalatin@chromium.org		Google LLC
 
 # Tom Wai-Hong Tam <waihong@chromiumng@chromium.org>
-waihong@chromium.org		Google, Inc.
+waihong@chromium.org		Google LLC
 
 # Bill Richardson <wfrichar@chromium.org>
-wfrichar@google.com		Google, Inc.
+wfrichar@google.com		Google LLC
 
 # Wolfgang Grandegger
 wg@grandegger.com		DENX Software Engineering
 
 # Simon Glass
-sjg@chromium.org		Google, Inc.
+sjg@chromium.org		Google LLC
 
 # Louis Yung-Chieh Lo <yjlou@chromium.org>
-# yjlou@google.com		Google, Inc.
+# yjlou@google.com		Google LLC
-- 
2.43.0.rc2.451.g8631bc7472-goog

