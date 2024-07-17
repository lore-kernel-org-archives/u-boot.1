Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D52CC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 15:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78C9E88A68;
	Wed, 17 Jul 2024 17:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K/cqPPWS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B675488A66; Wed, 17 Jul 2024 17:57:21 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0333488777
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-36798e62aeeso4532850f8f.1
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231838; x=1721836638; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BaYSCVGcaDkHZNdS8h1Wk+vjoasBL1c+dBg7UpUMyiE=;
 b=K/cqPPWSF7L3ow8rTTV0nWEaQ3/HpOTN+Oa2DTiXT2TB4KnDb5vmwkFR1JlDngp0Or
 avviaPbRUNHuMwEK/9gXjdJoCAMIJ0f9QeLweY/Vf9kZmr1CwlpVFVbxRc0GkoSdAsbU
 nOcLKUVOO6iR5B4a5ApXPA+/9UGsOTZKJY++k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231838; x=1721836638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BaYSCVGcaDkHZNdS8h1Wk+vjoasBL1c+dBg7UpUMyiE=;
 b=d/DeGd0fOafojgC94kLS5fMmHUlHD+27H0yKTZsNoEGAIFeobIYkajBS9UV+yuiPft
 /VsWNmGBC6o4C5b7r88q+qy1wOUdVGJR3JgEm6G5QduLlQz6YHV1Y+RJo21P4WL1qX0Q
 ZGd1SJVIjC/kYL6u04AUKQOMTkU/jLKW00sU5g4b2kqGm23PpJqxnOJ17L2Yqg8GcHOe
 jo5HkHwYcZ5nmiZDwNiBmMoZV15la9drm8Yjnej5As37FYmiNv48UQqHWb/K6R6Cw9Ti
 X0aobWSiJmVN7s3tRG3rqHVqYHWdeFSjP5lavhx2DofY302naQdPHcUavPGXRRE8O5Is
 9tVw==
X-Gm-Message-State: AOJu0Yw8tWd/tDMcfxv6Z051fFR7+4Ako2ghZr/4MWidDoc5YqS/qNCx
 kGWkikPKNm1H5U1sxwbuWtS7lrSAI7dnjahEm7S8PrNkjQZZXT3PBn6FjyzhLg5hPsSgbrlW+pE
 =
X-Google-Smtp-Source: AGHT+IGw0HVo6jAQNdBjkYWVy79AGoX/bVuHiKdWEb/AeKpftLwOfhjQ58sjMi3Mss8FwM67CT8sWg==
X-Received: by 2002:a05:6000:1e92:b0:367:98e6:362b with SMTP id
 ffacd0b85a97d-368316f85cdmr1307163f8f.42.1721231838052; 
 Wed, 17 Jul 2024 08:57:18 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 01/24] qconfig: Fix pylint error in read_database()
Date: Wed, 17 Jul 2024 16:56:49 +0100
Message-Id: <20240717155712.2913651-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717155712.2913651-1-sjg@chromium.org>
References: <20240717155712.2913651-1-sjg@chromium.org>
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

Fix this error by initing the variable before the loop:

tools/qconfig.py:880:22: E0606: Possibly using variable 'defconfig'
   before assignment (possibly-used-before-assignment)

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 04118d942da..2492b37444a 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -873,6 +873,7 @@ def read_database():
     all_defconfigs = set()
 
     defconfig_db = collections.defaultdict(set)
+    defconfig = None
     for line in read_file(CONFIG_DATABASE):
         line = line.rstrip()
         if not line:  # Separator between defconfigs
-- 
2.34.1

