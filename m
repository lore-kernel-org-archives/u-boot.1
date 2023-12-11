Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0D7C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 18:08:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C506E86308;
	Mon, 11 Dec 2023 19:08:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="C9LSmtQG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A45B8778F; Mon, 11 Dec 2023 19:08:26 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FBD486308
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 19:08:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4C36241512
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 18:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702318102;
 bh=v0onybqrojPg9Xd8g6xMXk3ZEppw/5E+lTTvnYssTn8=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=C9LSmtQGkPliOHFr6ExIrE3VFMqfn8k/yMOnmHisAsJmKTymIibo7yvof6V2ZnB6J
 tLTlCpVChidQI9FX2G/kA4svmljY8uXfy0ewg8tpA/nkcIDjJCM49UuMbX+3GXwwbR
 yvTX5Pc2fiIqv6HNvspl8+veNjMpvEUw4gaEFSAE+PugQEedFhdcUe8mDBAFJ+9osH
 p/cdQjLNIwgLGcXF9XuW3QEZP22Fznisumt4WRh8G/Mu51rrLexlJGi7FK/hyCuTHI
 emTMwZ+Q9Og6lhlDtVwec7l/scVvA/n3QY72pALvNxYu9zGG+Wv1ln2cCDJBmFSaPd
 mNRJXURBWSV4g==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-334adbe43acso2593181f8f.0
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702318100; x=1702922900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v0onybqrojPg9Xd8g6xMXk3ZEppw/5E+lTTvnYssTn8=;
 b=oksVnl6DOUApeyZenj4OSbAXclC3s8WBHE2Xf7vctdirgrdLmnoyeF0dcNJ7Rsgumh
 C0KJ9uZIzBezTnfE/fFYJTU3CZ7/BF0CAQDawNtihANJ6P7YlpsZub0hzrj8qzc6Lcnl
 GkkohyAf7dBoKRVZAkNTzWj+SAwJazVnP9hzIyGulpTmOPz9JR/fbKUc7L6alL+vzFt2
 I2Xdt7WKN5VbnLdJjU15SEYGVoFd3GaTt9AMF4lOLPftyW+r079iAvqbSCOVHkAWwb0K
 J1v2Z1/8lM6ZKfMGOhfBLqm4n8OIGdDi/aR2pxhswgAGTCffxx7vB3xU1ZFL9NifxwvN
 d2lA==
X-Gm-Message-State: AOJu0Ywpx6HjrC5xf6y3WUvpdE1lOx713MXYoEcZbpqKPz29LEJzrd3t
 2naTtiD6g1UDuKbCufMBjNL2JTRp6teoDwH/Icphlb48sbdZPmy7lh+nWjdaHO24isnrSoPQk9D
 3iR7X8Hc7VXr7LNOZekGUMJoH5N9cK1c=
X-Received: by 2002:a05:600c:54c4:b0:40c:3984:4983 with SMTP id
 iw4-20020a05600c54c400b0040c39844983mr2415352wmb.76.1702318100609; 
 Mon, 11 Dec 2023 10:08:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGr7y1qiKX3ipSMjNr0T0g6mNgkhoDtoFsNZgwGNSbb91p/UTBQ9PUNGgg575JNw5Q+GJmjw==
X-Received: by 2002:a05:600c:54c4:b0:40c:3984:4983 with SMTP id
 iw4-20020a05600c54c400b0040c39844983mr2415344wmb.76.1702318100294; 
 Mon, 11 Dec 2023 10:08:20 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 g20-20020a05600c4ed400b0040c31bb66dcsm13461321wmq.20.2023.12.11.10.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 10:08:19 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Roman Kopytin <Roman.Kopytin@kaspersky.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/2] test: fit: Using variable 'old_dtb' before assignment
Date: Mon, 11 Dec 2023 19:07:32 +0100
Message-Id: <20231211180733.86629-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231211180733.86629-1-heinrich.schuchardt@canonical.com>
References: <20231211180733.86629-1-heinrich.schuchardt@canonical.com>
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

old_dtb can only be assumed initialized in the finally block
if it is assigned a value before the try statement.

Avoid a pylint error reported by current pylint.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2:
	mention pylint in commit message
---
 test/py/tests/test_fit.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index f45848484e..04f64fd4bc 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -390,10 +390,10 @@ def test_fit(u_boot_console):
 
 
     cons = u_boot_console
+    # We need to use our own device tree file. Remember to restore it
+    # afterwards.
+    old_dtb = cons.config.dtb
     try:
-        # We need to use our own device tree file. Remember to restore it
-        # afterwards.
-        old_dtb = cons.config.dtb
         mkimage = cons.config.build_dir + '/tools/mkimage'
         run_fit_test(mkimage)
     finally:
-- 
2.40.1

