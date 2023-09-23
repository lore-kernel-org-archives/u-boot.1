Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A82FCE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 857F186BF2;
	Sat, 23 Sep 2023 21:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OahNonYz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61A388477A; Sat, 23 Sep 2023 21:45:00 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EFF486BAE
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-79f95439795so92795939f.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498294; x=1696103094; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TitffzogbOJ4dL2o84OfjjBpduEKjwJVPYGSo8rsIj0=;
 b=OahNonYz3DGlsjJaxSeWxQ6jxCssEhwkM45rgYtZdeVbv7UBKiHFLFUWCsWW1M7lkd
 zrbcVmQBna6ixTopeVNHvQfkSJ+30+PoCsxbs4auk4yNtB9XnG74SwBFdWEyfdE/2B4P
 hz0fyMTpsRbmTnvsLgZjnxsT3C2xLIwvUaSQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498294; x=1696103094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TitffzogbOJ4dL2o84OfjjBpduEKjwJVPYGSo8rsIj0=;
 b=d+6GflEQ0/29fNYyVYWCEwtBDZAQkzAuDEisMcVE+GzhTYiVaPbZnYShFBF0C9h0gQ
 bTw/p1Fp6xKzT02+otDxYzDuD91PB29DsglNEhmigyz0FArAhuclWVyz3ieohufVzu0G
 A7Wcdp0RosCU3DgiSEFvAmU1vTl//rUU8cCwSCTAO+Xfp1Ea25rlwI5znNZi4IrcN7Bj
 1xqZEBPbxtHOMtzve2JrUSyHWAAcn0Hbq5jxPctTlN8ScNyMGyp6WhrC/e9Cw3wabXJJ
 sLSveIRLrxL+ErvH672SKLpDyg/ZsyqffDQFRaKdbGs+dNOk88MBNT3gSrBo/MweWp/i
 /37Q==
X-Gm-Message-State: AOJu0YwFtQdq6tmEohG3WqHrRUpoZwiV5I/cx+RgngGps0BF4Jbni//c
 NAZtrdshHJ0J6rut4nwZuXm1MCh4Yfh40TqW6fo=
X-Google-Smtp-Source: AGHT+IECPAtMdS4Me3HaQElTSzjV+VGlCjCCgA01uVgqi5g0dVWJZPCrscQpmKAwVgMJ736dYk0SkA==
X-Received: by 2002:a5e:c915:0:b0:79f:95cd:10f6 with SMTP id
 z21-20020a5ec915000000b0079f95cd10f6mr5126084iol.8.1695498294056; 
 Sat, 23 Sep 2023 12:44:54 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 25/27] moveconfig: Rename the tool to qconfig
Date: Sat, 23 Sep 2023 13:44:14 -0600
Message-ID: <20230923194424.1739224-26-sjg@chromium.org>
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

This does not move configs anymore, but queries them, based on a database
it can build. Rename the tool to better reflect its purpose.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/{moveconfig.py => qconfig.py} | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename tools/{moveconfig.py => qconfig.py} (99%)

diff --git a/tools/moveconfig.py b/tools/qconfig.py
similarity index 99%
rename from tools/moveconfig.py
rename to tools/qconfig.py
index ed75d3277d60..dd55a696fda2 100755
--- a/tools/moveconfig.py
+++ b/tools/qconfig.py
@@ -5,7 +5,7 @@
 #
 
 """
-Move config options from headers to defconfig files.
+Build and query a Kconfig database for boards.
 
 See doc/develop/moveconfig.rst for documentation.
 """
@@ -900,7 +900,7 @@ def do_imply_config(config_list, add_imply, imply_flags, skip_added,
     all x86 boards will have that option, avoiding adding CONFIG_CMD_IRQ to
     each of the x86 defconfig files.
 
-    This function uses the moveconfig database to find such options. It
+    This function uses the qconfig database to find such options. It
     displays a list of things that could possibly imply those in the list.
     The algorithm ignores any that start with CONFIG_TARGET since these
     typically refer to only a few defconfigs (often one). It also does not
-- 
2.42.0.515.g380fc7ccd1-goog

