Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C768DC369D5
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 09:11:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27B8881E25;
	Mon, 21 Apr 2025 11:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RIgavUpA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F80F81E72; Mon, 21 Apr 2025 11:11:55 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 160D581E1F
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 11:11:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 466F741A0C
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 09:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745226712;
 bh=oDQ2C2gWp1HOFZKhmZ6dOskrDG5N4Y3NswuRe5CEmvI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=RIgavUpAYzJnLcoH6TH3jeR0SDVsmv0x2hIqin3vv4GyrTggyH7VUvOQ49YK0stOR
 vBsJWh80xRb1rvaoXs73InwMewZ8FUQCZqCcZcEtpempSKmv6kOFV+6bH/uYLPjgd+
 boCMDUtmEGhxYqToSuwrUpp9bABHa1QHQLWekkxYBv7GkEx+Y9rN+8Kg2biB9oe3JR
 HN7VzbRS0VIOyYRM2ThtlBzPVNNjmxBX8WqZabwniOUfd5R8u/J/eqzwHE9oM+4GC3
 YsuxzTaQFEAnJkJU//GXwFeqtZQLh5+3MZQ/I6X1IL0Npgmdb0SqnZeUClbaKrcSVD
 iXT71i0rrrq/w==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3912d5f6689so2094104f8f.1
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 02:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745226708; x=1745831508;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oDQ2C2gWp1HOFZKhmZ6dOskrDG5N4Y3NswuRe5CEmvI=;
 b=THHqmEPCTd6bXhwJ8uGjK3G1Udlp70Ka3Uv9jvRqn0BAod22Lk0WhX4uowNe5niqGH
 CbHrcA1DieU3M7b2lU1nyL4goMExFAWjaTyP1KHnWcFVptbYNTxJhdZMBsHcDVs5YW61
 TIW4LQVsaboEEJ+DCDoFghpCuzWeEJdG5gVEjcKC0wxDoJlriZLqpTmcGzgkr4tUbGGk
 NX4dXIOcRs5K9945qLhlu+5SoQDbAb3QL1vJ2Z6RA7idr6jHQilVje+A3C5pTc04D5SC
 MSct4d2enEZ8yKAHUP/D/BUvXYglXw8wwV6rip+7u/ru38Vt19auT1GM/96aILa/k+VG
 YTWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCRh1wGrpdhHpCx/j8EudWDxz8dfiv98/dMyBx/bwAxWNbiG4DCkGl23FhO2ajGRZTqr8oQhE=@lists.denx.de
X-Gm-Message-State: AOJu0YxNk2wuQoyd7RY0VFASOzpX3J6jKznwLfPDpvESb6d/DIUi0ogV
 JWHU4EBlyVLpjOWBCZi3PR5PRUa6V1q8yBwa8wzWuSQuZsw8ZzE6YbVfNgj17C/A1mSE4fQ8vZp
 sqQBoJexYVs9PzHbOgbqKYD9wGsFkcP0slDNXj5SZRtnTXZT3ysGdDM+z+yoQCT+bGWU=
X-Gm-Gg: ASbGncvidgsKJEJirjIKr9ljQovOjXWZr2TbpvJq3L4RltVZvQ5W4bxVOw0xrlAGFu7
 oDLg6Enp8ArL5J+JjPSO24ZZfN75aLWfVdQtzSJgMuucAUB+FBOra+hSvnkWZAXJ6wvUnasvi3s
 zcKofTyNWjfuZj8OnT7QCqSpWwgC+tlMjmyKL4b/yT83oD9KCgqYdvT1kCjccv+j7iXLIYTTZs0
 g6F8HDWFRNatPCzrNwj0vxRc8TU34sJ+R2XaSD17+68Kxbt74fcQiRhEbVz1fVrzJa8Wdm89/Fy
 LPlRDXwyglDyZiCbWWkucIEIYLHdYBDZT747MR3eRYqc8MHtHbzQuDUUCyxfia5LpT+jdO542ra
 jDkJEzxU26M+dQg==
X-Received: by 2002:a5d:584a:0:b0:39c:141a:6c67 with SMTP id
 ffacd0b85a97d-39efbad398fmr8280825f8f.45.1745226708672; 
 Mon, 21 Apr 2025 02:11:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ6txp1hh7/idQ/aVoFsCwmA7Z/aqqe3Oufk1a+mSEjPebLxm8DRjbkMHl8L6TYveRNqVctg==
X-Received: by 2002:a5d:584a:0:b0:39c:141a:6c67 with SMTP id
 ffacd0b85a97d-39efbad398fmr8280810f8f.45.1745226708320; 
 Mon, 21 Apr 2025 02:11:48 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4331a9sm11411330f8f.36.2025.04.21.02.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 02:11:47 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC v2] Dockerfile: use nasm from distfiles.macports.org
Date: Mon, 21 Apr 2025 11:11:41 +0200
Message-ID: <20250421091141.762386-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

nasm.us is currently not available.
Download nasm from distfiles.macports.org.
The build script for coreboot verifies the SHA1 checksum.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	correct sed command
---
 tools/docker/Dockerfile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 772e980d0d1..f314e38dfe7 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -286,6 +286,7 @@ RUN mkdir /tmp/trace && \
 # Build coreboot
 RUN wget -O - https://coreboot.org/releases/coreboot-24.08.tar.xz | tar -C /tmp -xJ && \
     cd /tmp/coreboot-24.08 && \
+    sed -i 's|www.nasm.us\/pub\/nasm\/releasebuilds\/\${NASM_VERSION}|distfiles.macports.org\/nasm|' util/crossgcc/buildgcc && \
     make crossgcc-i386 CPUS=$(nproc) && \
     make -C payloads/coreinfo olddefconfig && \
     make -C payloads/coreinfo && \
-- 
2.48.1

