Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2627BD3B993
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 14:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1AD989C8B;
	Tue, 26 Nov 2024 15:20:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FsZwHQfF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38C39896AB; Tue, 26 Nov 2024 15:20:36 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8E1989C8A
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 15:20:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 05F283F297
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732630833;
 bh=94wCpJJwOLtY4a8xIBNrfmqM7I9+vDUUg5DwNTaYWqg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=FsZwHQfF2Zdv5/75Zqs8InzbGKfXj5kzfG5+89V+4JYqWToU8sjClBjuAr/V6V0BB
 s1I17L6QnYuU1gccBvz7cCbb2gduSQGI5eer6N3kpvTaY3mDk7mjNxuxCc5Wz4tw+2
 dsJ4sQRljtfgQNeL45yTLt6ChNMr7eLD2tKOZ1FmkocwMLDX65BVhX29NIYDOXnWh/
 5cHih6Lw9IDJMYgSyGX8+EgWl1KdfPxS3qojngXBf3avLaM1HJY3AwXUT1LW5ZlLhT
 SsslNDxQniCYftmPVnGQdlPk058pzZcH2cTNpq8f4ulDVHO2HtWrjUFNGXINLhUhMw
 uTxCDmgiwBB0Q==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-434a5ca6a67so6858835e9.1
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 06:20:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732630832; x=1733235632;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=94wCpJJwOLtY4a8xIBNrfmqM7I9+vDUUg5DwNTaYWqg=;
 b=GvSBR7FGbc+sITbLrm3c2C2T2Wn+f9+adJCTWMBbxhQzZBowVt0VVAaO074btQszEv
 63ObDtAZkWUK5l8S3WbACXYBXqOlMW6+VDEunAwr7IPOZdne3wbO4ep/evQU+Wce1WWL
 zMShFWgQlkjy2ihvTDVtx+gCkq5GOzu9hBaDY4b2lrTzlafvS8MYA2W2UBzctJFcE2Oc
 mGtTMtB/QuqfCyat5MwnkOdlEFb/x0FXZDTsRPaXAjvEhrqI4nUfOwsLD324JuCJD1q4
 0GiZkBsWcxKatWlhblGlQQTrlXcJd+JnFrmmBeufcME6BYcfTA5NR8LkzlJ936nx+Kr9
 hTQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUziceFeHA9+ExXUyoK3a9bC4r3BJjUWjrGYpBMxhfIAuhhSycNcwMFsvjZVGZFF3wIHsazdGA=@lists.denx.de
X-Gm-Message-State: AOJu0YzHiRC9KxCwlO1HVqQLPjAaauVUg3Og+K9DDUkbf0KIcYczaeh4
 BCBYb1rDu9kUicXopNxMJez8wWunRsSyyNl/3rHmGFU//qbv7Q+4Zs1KA89ICH3mEccgICcmb7B
 UyhNkIMgYTBahBZdHRJdQCjFecia+Q7Q8aTxXM6/FHPSOe5hyDwtv/39eroZcLfH4gr8=
X-Gm-Gg: ASbGnct3uGfJrigbNF65O03RFbvmJB2dmXDcoqABVX+soMSSd4QItntHRagb/KwDU3j
 uxmWcE/LbU2o6Kz2E1WYYK3fxIO7YN7GEmeniIo44Z03Qd9vP59DtITbRsGzXXieqx3ysRh9Mat
 JxTGRsHDOMZoV9XkRuSvBENL1APS2F4cuZl6zK6/TT+ypWOJas4n7nrTlbk1XlKaRS3jKJfe64E
 cjEVroFNtOi3KESoDZb3x+UYvo1FMDYCqoyxrtc6qiXszxVmDJYZL38nPe4/GTr+S4Qb1UIu27T
 qH4pUhuJ
X-Received: by 2002:a05:600c:348f:b0:434:9da3:602f with SMTP id
 5b1f17b1804b1-4349da36119mr88691385e9.16.1732630832606; 
 Tue, 26 Nov 2024 06:20:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCtFGu1bz93Fz8lulSHtFJy5Oxqf5PA2L0K5P3telRyEXf+86kSIh93Aab3ox4E7rdHGbQew==
X-Received: by 2002:a05:600c:348f:b0:434:9da3:602f with SMTP id
 5b1f17b1804b1-4349da36119mr88691155e9.16.1732630832226; 
 Tue, 26 Nov 2024 06:20:32 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:b920:5c3d:9b8a:b7bb:8983])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a36c7a9fsm38753595e9.44.2024.11.26.06.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 06:20:31 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Weizhao Ouyang <o451686892@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd/rng: fix long help text
Date: Tue, 26 Nov 2024 15:20:26 +0100
Message-ID: <20241126142026.68680-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

The number of bytes may only be specified if a device number id provided.

Correct the formatting.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/rng.c             | 4 ++--
 doc/usage/cmd/rng.rst | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/cmd/rng.c b/cmd/rng.c
index 2fb7202303a..4d91094a8ec 100644
--- a/cmd/rng.c
+++ b/cmd/rng.c
@@ -75,6 +75,6 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 U_BOOT_CMD(
 	rng, 3, 0, do_rng,
 	"print bytes from the hardware random number generator",
-	"list         - list all the probed rng devices\n"
-	"rng [dev] [n]    - print n random bytes(max 64) read from dev\n"
+	"list          - list all probed rng devices\n"
+	"rng [dev [n]] - print n random bytes (max 64) read from dev\n"
 );
diff --git a/doc/usage/cmd/rng.rst b/doc/usage/cmd/rng.rst
index 4a61e33d272..c071f01e841 100644
--- a/doc/usage/cmd/rng.rst
+++ b/doc/usage/cmd/rng.rst
@@ -12,14 +12,14 @@ Synopsis
 ::
 
     rng list
-    rng [dev] [n]
+    rng [dev [n]]
 
 rng list
 --------
 
 List all the probed rng devices.
 
-rng [dev] [n]
+rng [dev [n]]
 -------------
 
 The *rng* command reads the random number generator(RNG) device and
-- 
2.45.2

