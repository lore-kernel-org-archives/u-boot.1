Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A558EEAA7D
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4249886AAC;
	Fri, 15 Sep 2023 02:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X5fsghUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4775D86A23; Fri, 15 Sep 2023 02:23:10 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4639D8699B
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-792726d3aeeso56372239f.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737387; x=1695342187; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OmEukpPSvNSd2u0WZ8qOS0fGD2G5rugrZj681sRXvzY=;
 b=X5fsghUZYCeOYkaN2bEn5oLbpMQmV5Bf8uQ5WLFgRtu/LI0objDNQHFxcW4J1Lx88g
 kF9BrV2VC4ajPTxs1DxffqYytmBYTA5BhzLghd5MXHYt2rD/quQNPaRBeB+mfEYK0+Na
 XW8uYbDEcXNrV4YXYEY8zbVNFSIMPkczArX/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737387; x=1695342187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OmEukpPSvNSd2u0WZ8qOS0fGD2G5rugrZj681sRXvzY=;
 b=pIjDzQS6ClNTZIVY4xkuEP0hBSetUEDM4dfaISBV0woux6M0M93YYh5GtjXFDN0yt0
 3BBltkEPzF034ireDGlQjqlRFvSZlgsEEWlEpvSGGMXPFm0FCARcHl8zy1pNpsgXc2ua
 ZIIl9UnwxTholy/yllzPmY+3q8nkBwXGeFzVo0dHDLmqdaTURULOpLYls2lpGH298+g1
 XTTTdzdH8WowbGZ7JuxV/rFPg7z+WJI8h25la6JkVt1qmtQ6ddjVXeSm9+GHq0BbglDq
 01ApXBx5w+Jqd1CXUpbw86wKM/VXgrZAXwwo5U2TBUpjKPXNBqZzGon1/B8SyvjlWmq/
 W/OQ==
X-Gm-Message-State: AOJu0YzltKYwVt95xVb7YOB13EmkafqxmynBs/9Ux4Vvt+FxagrZ/iGD
 WNgip4X2fn/pHPrXfbXhjZqOKia/Tc4EGYNmC9E=
X-Google-Smtp-Source: AGHT+IFc9y3CtVhr6R0GbOoApljtlaro3zpTky1qp7z/fiqsf9qGr5k+NAnxw8ANZyyqdGwFf80lqw==
X-Received: by 2002:a05:6602:1cd:b0:791:2896:8db7 with SMTP id
 w13-20020a05660201cd00b0079128968db7mr67466iot.6.1694737386955; 
 Thu, 14 Sep 2023 17:23:06 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:23:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>,
 Maxim Cournoyer <maxim.cournoyer@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v2 26/27] qconfig: Rename the database file
Date: Thu, 14 Sep 2023 18:22:28 -0600
Message-ID: <20230915002236.798760-27-sjg@chromium.org>
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
2.42.0.459.ge4e396fd5e-goog

