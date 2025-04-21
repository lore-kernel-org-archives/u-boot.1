Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37735C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 08:34:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26FC08059D;
	Mon, 21 Apr 2025 10:34:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="d0s2eSh3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F667806FC; Mon, 21 Apr 2025 10:34:34 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 743F580107
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 10:34:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8714C3F27B
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 08:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745224470;
 bh=VlfY6phWSgHLHUKacT+DjC0iCpjLaoJSwjLhPjIwxBY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=d0s2eSh3jyxkvfT7LlncQdAgzBsV13xfO+XyNMbwtlsRvSWG17lMptdVS9aZioDxC
 fImZ5LqC2D40VhvMV4/EgHilKkTHwNlZNzHABLaPFjYnV12IyxGH5T9s1GmsSAhiwd
 wwd5YNv12MQfyVT4uBA7wqPcaejl2Me8w/1rE2m0YZDhFa8b7x2cRGhzmLA2DSlalU
 /YwUXhPbbbQezgJS3Ln0p4JCDth/p4L1NBzc+M+b3SSdlieB88jZzpJ86f4CuysDXN
 PcVHSJzuljdW+ujMm5lGfV+uckHgqSUed5RZt8yoFMZuVn0z5HYCDUL3tMyLczRVju
 VBEXxQPYLQ2Mw==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43941ad86d4so15269725e9.2
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 01:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745224468; x=1745829268;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VlfY6phWSgHLHUKacT+DjC0iCpjLaoJSwjLhPjIwxBY=;
 b=koJYursyavgfJ7hbsSv73lb/4iljpt9zch++LYWeiQbU7I3siFck1PV3XZIl0JJvCr
 bn87jh/7oGBGJ8b7FDegXguPh6OZB05Crt8j2X4ErKXwfNTWQEqJDJ9ol91hlxciHI6O
 OON2b1QOdq+XhkbIH1TKCIOGyTGGh5C1pOAqhE8DyJlE8n2qM/lHwjR8xg39KnvqzJyB
 1dxjrk+EIXy/TRdVAYh40Eu06dSxMpZYrF4Iu0wva5XG/UanOzDhKGd0DfgIFsIzqvVd
 digdz6V0HNe3CHMp/PkDq7/hDSo5MiBnRHFY1mqsY/smbzwpw8yK+rKPl6gbz7J/F/5E
 oFng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJjOIl13m/It3LAhhludfmaV7TvJtADKRulU/tvd70D4Jqi8C9DHIQckgQx3KpFyCeAmDaEdI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4j5NRcllcSXCY6jj/wf6SuUqiPgrsizcC8bkytiezAG8Z3BHB
 3xGkKuVB9/WWAU7UXKu3Oc0U452jRyanEIzN1ihMJX3UnWeW93ehfW8Ob4AALWESJGhig92kD3q
 YkEFrBcE0b0XOxzBZ3q23Cz6As3YJ6LHZLZZeGesoqyRI/pGKFwtE9Q8eScMaK6ky6Pw=
X-Gm-Gg: ASbGnctfrardPjmUkIiUvNnx0lj1Um0OZuYpXQxA6P+H4ssAiX8ngMaiso6rVLclIRb
 MpnJKR8oTxxWncELeG6I8f+gqFkt2XtQGSHtOJ+vAsQ7ns5QGZP7+KAzG88QixWAAxJ160jx+2U
 oI/mi7pHKvefYkl+bA0Ur4n+91uoMg2gVZ9ncGG/XEsA7n9TczHjtn+eGvfUjIdLZKSLL67i1Mr
 6lVVhfbhYd4rAiUKZQqOgJflkKmmXCcf6sNEdFWVUNa+lGqj/JZiESbtMmppURiQLOPU2In+FkP
 Mybg68604tbbIxCCkFQSZMdYREWUqOHdywQVg6yIro/fSwkC3arvDwfS26e5RZImLlid9P6eTjJ
 q+oTZxb/pqyTBmw==
X-Received: by 2002:a5d:64ae:0:b0:39c:3107:c503 with SMTP id
 ffacd0b85a97d-39efba5bfffmr9257411f8f.31.1745224468361; 
 Mon, 21 Apr 2025 01:34:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0VbTOup6kdnrJwv3mCust6rJKPXVQMZz5VaRyuZSLanwQf/1+YEBFi3d4CKdn/C6zKP9FHw==
X-Received: by 2002:a5d:64ae:0:b0:39c:3107:c503 with SMTP id
 ffacd0b85a97d-39efba5bfffmr9257397f8f.31.1745224468019; 
 Mon, 21 Apr 2025 01:34:28 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43cbf1sm11349102f8f.54.2025.04.21.01.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 01:34:27 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 1/1] Dockerfile: use nasm from distfiles.macports.org
Date: Mon, 21 Apr 2025 10:34:24 +0200
Message-ID: <20250421083424.476809-1-heinrich.schuchardt@canonical.com>
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
 tools/docker/Dockerfile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 772e980d0d1..7361408ba35 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -286,6 +286,7 @@ RUN mkdir /tmp/trace && \
 # Build coreboot
 RUN wget -O - https://coreboot.org/releases/coreboot-24.08.tar.xz | tar -C /tmp -xJ && \
     cd /tmp/coreboot-24.08 && \
+    sed -e 's|www.nasm.us\/pub\/nasm\/releasebuilds|distfiles.macports.org\/nasm|' util/crossgcc/buildgcc && \
     make crossgcc-i386 CPUS=$(nproc) && \
     make -C payloads/coreinfo olddefconfig && \
     make -C payloads/coreinfo && \
-- 
2.48.1

