Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32400CEE35A
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 21:00:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76FCB83A26;
	Tue, 18 Nov 2025 22:00:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fFlTaG7j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3757E83A64; Tue, 18 Nov 2025 22:00:23 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F12B83A3B
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 22:00:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c75dd36b1bso1733478a34.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 13:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763499619; x=1764104419; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ytXvTOZGhy3WxRZw3HyjE9JNt1LZRwRURu9NBbi7QzY=;
 b=fFlTaG7jiHiITUZG/C9U0pZX7cnD1iqpLqbYtpsKyxR/4scAfFnSN9JVuiWZVV2Ruc
 r9z60BLfNoGlp0jAsaQVHHnse/ecw3pGgfjOVGgyh+v3lN5IbW1Rkz9SQfgxhiOmsGnw
 3OywZU0MC/I7fZffELZAoJ6bv83cFPTmiqA3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763499619; x=1764104419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ytXvTOZGhy3WxRZw3HyjE9JNt1LZRwRURu9NBbi7QzY=;
 b=rL2iCpTaFuLlAH2WmNWJU5sEChVo36wLPJqc9sRkvIrWeGBJYsmumBDqx4epxDy0AE
 xLdWM2yAj/JRSwqCid+hO/6OIukRbmpVo4l+OiJjhLoeG228MaLRl/Hjh0JlUbIYY1jC
 nq/K6ZdAoMk35nxgpkobbncNgwWw5A23+jRVtIzEwccnyNVxjDzt0jmgm1GMGNhmZIeG
 NvVHzj2fBfWqZg1NRZAaIvPnJiISFzKj7RxdYlidYf9CThf/hSDXA0KDtb/doIWsaTxL
 wrARR9i183b/GGUl8nJTtw1vcF//xvWcVnFscKRcA+8X2zogJkzIE/8PFRRp02oQhYrC
 IcHw==
X-Gm-Message-State: AOJu0YzB3+ggmvDZRwEHXqKa8TuyPn+jkQH7z6VbFIzjBU/GZTfMznUF
 P6jkIZFzZUxUoxL5Zes5OIiAjSJWUCC1TPjOuKg5IgK7VKMdOhw/pTFttutxDTLIahjB4T6HSvA
 sUj38m6LDGQ==
X-Gm-Gg: ASbGncuDO6gGE3VdDz+S+EgSG2qHL5nBRIuanMudq7MCUDMWfYDmMzKxxdGy+N62XHS
 Rbyy150dcgKM5AgWe0FUOxnSH5SI7nKTI/l6nqR3C/N8xPYY8f+Gh8qrsxi1JlhT8filAGpnnxs
 0q72jqcnJJOxkearTfCaLisIw9iDhBoLIkooowCq2dCd9tAGFCYbStVt/NfwnJyjzAppt8c9R2p
 phlzDYg2yZ5/H2ZHdFASY2Tm2UmF+zHF3IXQ9yjqCaJ9dUVa23DalP6JjoF/EC+BwF9ooopEAVn
 wRoi9Qjkeo5mAd0+Qy6SrM1ziKB2qOgMdYkiCJw0kIm46Tx7b7eJ/WT9FD3JOoFotrvnoBqMP8I
 kN2unaEuYMG2UgcXDgCA151CzAByLY0iI2MuQGiUCq4gRSQZawC/wgBQTyNCQXBDQZrYBH1nM50
 xC40h+A8hqqkA+PFPo55zlIRucmxxu2C0mSpOxa2DgjSmPKocmBqUHiCz+6loQ300=
X-Google-Smtp-Source: AGHT+IFjgN2Y0N4A+H8IJ9+LB45ubd9MGTX4GpUdUYcVK4mtLkcemXrojnGCcz1eS2zhiZkSwlYPLQ==
X-Received: by 2002:a05:6830:2aab:b0:7c6:e92f:41df with SMTP id
 46e09a7af769-7c74446b276mr12443458a34.12.1763499618785; 
 Tue, 18 Nov 2025 13:00:18 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c75610f638sm3583110a34.21.2025.11.18.13.00.18
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 13:00:18 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2 4/4] Gitlab sage, Docker: Add snmp and rsync
Date: Tue, 18 Nov 2025 15:00:15 -0600
Message-ID: <20251118210015.624758-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118210015.624758-1-trini@konsulko.com>
References: <20251118210015.624758-1-trini@konsulko.com>
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

Add snmp and rsync to the normal docker image. While these tools are
only required for the lab on sage, I think it's a small enough addition
to be worth always including at this point. A higher level TODO I think
may be to see if we can / should split the resulting container up, or
if there's host tooling we can remove at a later step, after building
all the software we require.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .gitlab-ci-sage-lab.yml | 2 --
 tools/docker/Dockerfile | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci-sage-lab.yml b/.gitlab-ci-sage-lab.yml
index 815c93087f4f..6b941b4b2f7e 100644
--- a/.gitlab-ci-sage-lab.yml
+++ b/.gitlab-ci-sage-lab.yml
@@ -26,8 +26,6 @@
       pip install -r test/py/requirements.txt -r tools/binman/requirements.txt
         -r tools/buildman/requirements.txt -r tools/u_boot_pylib/requirements.txt
         labgrid setuptools
-    # Add more tools
-    - sudo apt-get update && sudo apt-get -y install snmp rsync
     # Acquire and turn on the exporter.
     - labgrid-client reserve --wait board=${LABGRID_EXPORTER} &&
       labgrid-client -p ${LABGRID_EXPORTER} acquire &&
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index fd8765af4585..bcb95a8cae3f 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -131,7 +131,9 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	python3-tomli \
 	python3-venv \
 	rpm2cpio \
+	rsync \
 	sbsigntool \
+	snmp \
 	socat \
 	softhsm2 \
 	sparse \
-- 
2.43.0

