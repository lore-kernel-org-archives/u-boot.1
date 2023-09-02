Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE219C001DB
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 14:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 574B686467;
	Sat,  2 Sep 2023 16:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OtEV2aqZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5269867C7; Sat,  2 Sep 2023 16:53:27 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 769DB867B6
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 16:53:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-401da71b85eso393855e9.1
 for <u-boot@lists.denx.de>; Sat, 02 Sep 2023 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693666403; x=1694271203; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Msrb6/nmtExFC8B0sHWpf3s96bn/pi+WsRWwEFGprnc=;
 b=OtEV2aqZ8TV1H2++08itcAnau8FiWoEuqmnMkFutp0NXlqyqUW1eJpFeLLrfynqEft
 80Cz61yRJR5TlKhkV2hhfcCoVrS1i5gswmYQCZW+5K0Bw2xDUT/5dN2+s1qbGaEulTLi
 OWKzZ/U83pM+GJRdJaWFljoxpNWo6XBDExA7BV6tJNLLZNYAystvS8D2dnB8tpqgrig6
 bfG8HsqXzAXeWuow1U9lkKIhGBN6feUKTznuYAbS+UMW3hZU00ucOCSqP649ZTI3Sr54
 CdJi4mvwnw6bvlZZlHPqkylsYesNgvvqMFCUn6IZMZ113F+nFM8Y7SdYZKmKbl9CQQJ+
 j8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693666403; x=1694271203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Msrb6/nmtExFC8B0sHWpf3s96bn/pi+WsRWwEFGprnc=;
 b=gwz/++uGL5G5Qlz2R3zBCdhESRzpg0buI7ssHSEX9lk07jpVzChjcDdDPyP7Q/rKn3
 YClYNAyaI+T72LtBFBWw5c/PEwLU1qlX0dx6LIpY0FsoCgzVy+z9xqp4O0IXMbhGt3i+
 xN+cLKQecVb4UNaeQ8JQUaSjtTVCs3ZXoulgyvObcStngVGs/tKquEUAfZHg1YStJBFk
 ocsrzSMmc4BvE25SPaCetZ1+KRCEeCwhdi6ogYexLAHCb9Xrzta9UANQhAW3g0oKmzE3
 mDKOHaxRWACu76k6o8UBqy3aHfd5HrMC3v0x/NvLb4gWYX+g3A00R+0ho1mhX2vQZS2A
 714g==
X-Gm-Message-State: AOJu0YyPA5ljPUnWJJS7mCZRFE/3yRAwj0dalkFQambmanIDQ+yeF3DD
 0rXZOACB56cgcIusDSdSB/fQnGsRS17Wl6TE
X-Google-Smtp-Source: AGHT+IGu77gCo2GIMAmue9iNSqFb6sODNN5y5i7SpaP7wn1pNFdV5P5vF0n3tOPhPXpDk6eICLDJ8Q==
X-Received: by 2002:adf:f24d:0:b0:31d:d5db:5983 with SMTP id
 b13-20020adff24d000000b0031dd5db5983mr3839325wrp.27.1693666402505; 
 Sat, 02 Sep 2023 07:53:22 -0700 (PDT)
Received: from fedora.. (cust-west-par-46-193-56-152.cust.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 cc11-20020a5d5c0b000000b0031f34a395e7sm2385449wrb.45.2023.09.02.07.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 07:53:22 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, antoningodard@pm.me,
 Y.Moog@phytec.de, Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v3 3/7] scripts/gen_compile_commands.py: fix docstring
Date: Sat,  2 Sep 2023 16:53:06 +0200
Message-ID: <20230902145310.107054-4-jmcosta944@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902145310.107054-1-jmcosta944@gmail.com>
References: <20230902145310.107054-1-jmcosta944@gmail.com>
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

The referred tool is now in U-Boot. Replace "the Linux kernel" by
"U-Boot" to make the docstring coherent.

Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>
---
 scripts/gen_compile_commands.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
index 0227522959..63d036a773 100755
--- a/scripts/gen_compile_commands.py
+++ b/scripts/gen_compile_commands.py
@@ -5,7 +5,7 @@
 #
 # Author: Tom Roeder <tmroeder@google.com>
 #
-"""A tool for generating compile_commands.json in the Linux kernel."""
+"""A tool for generating compile_commands.json in U-Boot."""
 
 import argparse
 import json
-- 
2.41.0

