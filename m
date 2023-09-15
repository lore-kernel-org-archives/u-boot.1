Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9EEEEAA7F
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:24:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D478867C7;
	Fri, 15 Sep 2023 02:23:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Esx5EBkl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 659638693D; Fri, 15 Sep 2023 02:22:57 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55C8B86906
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-79565370aa3so59135439f.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737374; x=1695342174; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rC3VySPVAwfkBQ6EUfmdqQXeiGlI0E5RP8O/HfLq2ZY=;
 b=Esx5EBklOUPmzB+NMMcdYHoOpqJTNHYhUXcc8s7ls+SAt+NBGM8vkK91FrVO8b6Heq
 6MbXJY6gsvYh6nibG9IW13SHdwuya91/XzPdaOxgbexY8Jvrlj5rgVmg1rfoOI82W+mP
 zRkQZ8aC/oo+g98AXbXFTRraDNnVYN7IT3528=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737374; x=1695342174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rC3VySPVAwfkBQ6EUfmdqQXeiGlI0E5RP8O/HfLq2ZY=;
 b=A8UcXe4snzIwfynaCXzx6K/p8Cis/OmkVSu8QSDzFlO/JUeM/czK/Zd/E/+GGHE7MW
 COrXR8aXHl4yDTSAyCKgQSz6tQ4coRXvhGtmo/SvT71dZM0Ef/GNGNVNsqImPCuOqu8z
 qFeujdWjn4NyL3WcRT5LfvxyfZEbgkJrLXyVtM0m/AR8qSVFrtMqZLeVRv1CqlqYufPu
 kE+AeeM28xm4n3NlldvbeLHwyMH5lPZr613XrV+oY1ySXFBuMrQoR6Izi7J+SFoBfWTa
 QBa/AeV89XIMzgjSw1jsx19lHkSEQW8KdTggm+LrnDnUkD+8xeAK2n7yOE1T1L5WVDB7
 YI/w==
X-Gm-Message-State: AOJu0Yw4v0KdW2tEli5GRTiIgkppKunsZGbNGo5Pdg1Qs4Q+cL4w8OQD
 6PV9cz3Nj6KbS/mqWFtj2lSGugq+VtX9YvbAkxA=
X-Google-Smtp-Source: AGHT+IEzFl650av70mFXQAUWF/vJMtkFBUGTL+ZPgGkbAT1WCWPqKYfCyq6h0t3b6c1sSNjMgiq2pQ==
X-Received: by 2002:a5e:880a:0:b0:794:d7e8:d239 with SMTP id
 l10-20020a5e880a000000b00794d7e8d239mr49592ioj.17.1694737373980; 
 Thu, 14 Sep 2023 17:22:53 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:22:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 08/27] moveconfig: Correct some regular-expression strings
Date: Thu, 14 Sep 2023 18:22:10 -0600
Message-ID: <20230915002236.798760-9-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230915002236.798760-1-sjg@chromium.org>
References: <20230915002236.798760-1-sjg@chromium.org>
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

Use the 'r' prefix for these strings to avoid pylint warnings.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 36202fe5134c..0b0ce64e81fe 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -1153,10 +1153,10 @@ def prefix_config(cfg):
     return op + cfg
 
 
-RE_MK_CONFIGS = re.compile('CONFIG_(\$\(SPL_(?:TPL_)?\))?([A-Za-z0-9_]*)')
-RE_IFDEF = re.compile('(ifdef|ifndef)')
-RE_C_CONFIGS = re.compile('CONFIG_([A-Za-z0-9_]*)')
-RE_CONFIG_IS = re.compile('CONFIG_IS_ENABLED\(([A-Za-z0-9_]*)\)')
+RE_MK_CONFIGS = re.compile(r'CONFIG_(\$\(SPL_(?:TPL_)?\))?([A-Za-z0-9_]*)')
+RE_IFDEF = re.compile(r'(ifdef|ifndef)')
+RE_C_CONFIGS = re.compile(r'CONFIG_([A-Za-z0-9_]*)')
+RE_CONFIG_IS = re.compile(r'CONFIG_IS_ENABLED\(([A-Za-z0-9_]*)\)')
 
 class ConfigUse:
     def __init__(self, cfg, is_spl, fname, rest):
-- 
2.42.0.459.ge4e396fd5e-goog

