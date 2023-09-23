Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAA9CE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D70B86BED;
	Sat, 23 Sep 2023 21:45:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hKEjKnVb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6968A8477A; Sat, 23 Sep 2023 21:44:59 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 375EB86B82
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-34fdc6209c6so12055325ab.3
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498295; x=1696103095; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K5jtx2WHp0zffwGgencE982tpB8EOBv/N1RySbZoLEA=;
 b=hKEjKnVbTMQFdp8G9jOhjvKDTI7tK3VpyBFrEDSMd5hYn/d3i7rrrZTNjerN5/BMtr
 jbGnzlIDrVjYqshpL1MPQF6gzDgHq/d88nW64vit+07D2O6m4jfPmweg1Qf9KETi3uIl
 e3qzIlPITzyLoliSY0e8uOxp14quUd5AC8nvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498295; x=1696103095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K5jtx2WHp0zffwGgencE982tpB8EOBv/N1RySbZoLEA=;
 b=AaFPTsTirAtY2MWrQdDvbGN51U8o0dPRE4uTYMo0Htx+XFE/7abFQPGLNnEjAP6VdV
 GksuK8i1IacM+X6mYyVbj+T2Vz4IG4hldaCFB4RPpQ7beaX9jCtiuhzkYcyL1LLCnPsT
 Rh3zmyDI50k7ctOyH5AyK1ZszuxBxM71rAdKQDTP3jKvWAAtIVUlT2jx99Yxmp95RRYp
 m6suO4td6Z2Mpume4CPx9JKflyxd6Qtyk34cN8jHXG1Rot1XGexYoHSaXbQqaavlajWI
 pawmljLGwf0HTe9sVDCMhrx6VuzE+NMjnibw7I4ltmUFG1iKC5NiSlutwFwetTOaZtnv
 LFuA==
X-Gm-Message-State: AOJu0Yyr3v6YqIPDZkCMNlcWTFNr1tPcor8p8f6KPWuLLEJY7xFwLhHA
 u3sc6r2YntiX8plNa18aiw15Kr5TYTSxcSCfYBA=
X-Google-Smtp-Source: AGHT+IGcqhe18GnqATi0/ariMrLVZSGPSD53An//V3hNqECc6FJGIpfJWf3ot4w4dKnptCuOdPScHg==
X-Received: by 2002:a05:6e02:d4c:b0:351:1d53:c770 with SMTP id
 h12-20020a056e020d4c00b003511d53c770mr3019189ilj.5.1695498294870; 
 Sat, 23 Sep 2023 12:44:54 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 26/27] qconfig: Rename the database file
Date: Sat, 23 Sep 2023 13:44:15 -0600
Message-ID: <20230923194424.1739224-27-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230923194424.1739224-1-sjg@chromium.org>
References: <20230923194424.1739224-1-sjg@chromium.org>
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

Use qconfig.db as the new name, to reflect the tool's purpose.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 .gitignore       | 4 ++--
 tools/qconfig.py | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/.gitignore b/.gitignore
index 002f95de4feb..7f64446db3c8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -107,5 +107,5 @@ __pycache__
 /pylint.cur
 /pylint.out/
 
-# moveconfig database
-/moveconfig.db
+# qconfig database
+/qconfig.db
diff --git a/tools/qconfig.py b/tools/qconfig.py
index dd55a696fda2..04118d942da6 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -44,8 +44,8 @@ STATE_AUTOCONF = 2
 STATE_SAVEDEFCONFIG = 3
 
 AUTO_CONF_PATH = 'include/config/auto.conf'
-CONFIG_DATABASE = 'moveconfig.db'
-FAILED_LIST = 'moveconfig.failed'
+CONFIG_DATABASE = 'qconfig.db'
+FAILED_LIST = 'qconfig.failed'
 
 CONFIG_LEN = len('CONFIG_')
 
-- 
2.42.0.515.g380fc7ccd1-goog

