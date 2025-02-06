Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDB1C0219B
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 22:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85D7880EFB;
	Thu,  6 Feb 2025 23:39:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WwNbPNXm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0B2580EF6; Thu,  6 Feb 2025 23:39:07 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9C6B80BAB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 23:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3ce868498d3so4150565ab.3
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 14:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738881543; x=1739486343; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z2cdcuC1dtRS40cX3W/SIWC4AX4cBUMfoUiEUX2yPSw=;
 b=WwNbPNXmXFX0+xwUfDZ6NJgsg/+tfqinamDLXDGRiElPo/auaJ81vNfX/i6HT5/Mdd
 6DvXkCjZj/9zYy99SSACbRG6bLd8CgV8A5dzu0dhqSjljQyeGnUE+V/wiVFGrufAMOL0
 PBJLh/dNv3AJy/zEJQ2dYRPfqipWPos8YMPPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738881543; x=1739486343;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z2cdcuC1dtRS40cX3W/SIWC4AX4cBUMfoUiEUX2yPSw=;
 b=UsTD0CEbODu+YGplO6PyvOm6Kcpqznt7emxL7wGMQrt+s9P4UdCk2N17Dlk1wnkPpS
 Eofbr4EFJKOMgO6ghOI19KN5JWJTiGKnj+GrjvD/9KHG/AaPpuQ0xnKBGTf9oqYq9y1G
 Zho8eQ2OUnajEj8sFqWXZy+WNgcoy/926TCPK2xssIQErE7HQk/JOxZX40/3ELszWKGT
 g246g9M4J9CfBBMF7UL8hBGKU0Tq3/xhoMsL49+Psx4eW6yfnAg7BN2t9nbDlhE/89st
 U9519rPVtbGKGckMOYCLcxKfJKARvAxeie7O90/dkkAIOBXfmdwR6MjG44vhyBBJfPvu
 pa/A==
X-Gm-Message-State: AOJu0YwAY8NZ0q3D17A+OSB9upclr53vsjV2uNK4GTP1F6suKBvMw/Ww
 1GHrWJsAPBTaoSMN7MAVnIpvtwTP9BSW3/QlofAtwh+0G2QF4+wrWtfTVbg5XIPpSt6OaW29dhY
 =
X-Gm-Gg: ASbGnctvpAkNn33539UjgtcjPr7YaAZOqhylQQVxoJ4iif9Y2GSd7m2psE0TcVTDNAX
 PYRmI60ZPdevYjZPwbgWESBEzp29V662QuyzfD1EeDPLOSjq4eZb20DLZrFDesTidDRZpg5ntgZ
 tZm2PtzrEXhFsouuUJ0a1YU2Cs36uv0CJ2sntex/G7KD8p54XCmulWg4m2dgHeihj/givXdXx0L
 RLjGmaqU92Mu0wnFvqA4oMq330LVmHoowPoAp9/CTmg5Atnqez1GVO/pBvfmaFqPbqFGYy2NzYT
 qAKaOJ43Qq6tcW34iATQomZJBtGlDXpb5HTdvea0EfYvqNF9oSOq
X-Google-Smtp-Source: AGHT+IEXYbK7vu+QJQYSIzgBf4+WUvWZfkiT0nF3dOa9Ju6sdLcWx7SODmMVbHxkx83hu+Tw2ZlFvw==
X-Received: by 2002:a05:6e02:2142:b0:3d0:4b3d:75ba with SMTP id
 e9e14a558f8ab-3d13dcee89amr7615405ab.4.1738881542981; 
 Thu, 06 Feb 2025 14:39:02 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e87921asm4583335ab.1.2025.02.06.14.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 14:39:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 1/2] CI: Move default image under global defaults
Date: Thu,  6 Feb 2025 15:38:55 -0700
Message-ID: <20250206223858.64672-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

This is a global default, so put it under 'default' like the tags.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

Changes in v2:
- Add new patch to move default image under global defaults

 .gitlab-ci.yml | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a55b0c9ee7a..3305f7b4df3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -9,10 +9,9 @@ variables:
 default:
   tags:
     - ${DEFAULT_TAG}
-
-# Grab our configured image.  The source for this is found
-# in the u-boot tree at tools/docker/Dockerfile
-image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240911.1-08Dec2024
+  # Grab our configured image.  The source for this is found
+  # in the u-boot tree at tools/docker/Dockerfile
+  image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240911.1-08Dec2024
 
 # We run some tests in different order, to catch some failures quicker.
 stages:
-- 
2.43.0

