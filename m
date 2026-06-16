Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8647CD98E4
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 14:30:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BD4D84956;
	Tue, 16 Jun 2026 16:30:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X58HW7S4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74A8484956; Tue, 16 Jun 2026 16:30:03 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC3EA84940
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 16:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e716b9e534so2314776a34.3
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781620198; x=1782224998; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FstUuGeIcGM41KY8Cq5gmtAFiADhlNP/guY7a7q5GgM=;
 b=X58HW7S46UX26cHs/UvgCtwOOV7y4yR/KtZvXfZk+g7JecuhQCNf/Ot+HHrr+EERO9
 bc3jtYQGkc6YUvGwpH2ad0dYoOaLClJZ59aeR3T3BGDT336uX9TqdpWrhuVc47v8e4kz
 tk6ZHCjTu9sCmljOiE0ls63w5arAdVgYRBR/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781620198; x=1782224998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FstUuGeIcGM41KY8Cq5gmtAFiADhlNP/guY7a7q5GgM=;
 b=pKxmiqmg7SEeR9oK0QKpgLnkFi5Cpe3mL7CkSZzRmrp0+Cs9tN1uKv8jS2SxzBrNHL
 SGmXLHVX4kp0I+g8OIbdD8JmJ2GmgIPXSly9eeV3+xxodm2h8wV7OAXgOHDYodJmRYO/
 +P+pOhh+whUliZgAAEV448b3bU9LELMcvN9/g2UthILrA376Cdad14CEmC+wc/KM52ST
 GgBRGb9ZyMVvTdFI2W4uHml3WMdflTXiPoORaYqWe9mJgvYFEDJMAfFAFCPVMwL7IMnM
 uKV2rgMlHr9H11gs6nd2CpXOPrrsJ/rR0xIzoqenrf7FNEWBNz+Jce436X1A4X/97QqJ
 BHnw==
X-Gm-Message-State: AOJu0YzjJDYKTu1OICMhFN2mn23BwbgujT7yZ+lbF6LGx2qK9DDJLjKd
 wcvfNkalKRhGRSthoStVVrvvIRTmKeQ+OtBJvPsEbl9dX+BqgH0A1ApUtJ+VuSsMBopRXYhXegk
 YtmE=
X-Gm-Gg: Acq92OGtSgVbVK0EDPmLFXfAvi8+unQ+LzgLWDhUj3jLfVXWlT0FF02zQyVMVS8jU/H
 9nNQw2Ns8PkXlhVbd38ixj8+YwRCfN2UZlxCw1oDS1bjahBrtFg1Uecve2vOcdJg8kYy4Jl2U6r
 IJ2bl2URvSz4y3JVSAyUoujB65JafNbidIS1zGH9DdzvHeNSx6wdH0vQEHrQEmpYvHs+ks+tcDf
 teBf2maQzAGV05U64kmEjTDO9OnYTtFMxQQ3nm3k27k/ZkSoc9HeCisprAYTuOk39+IAa5DBgeu
 iy+yTi2WvniS3v2mhMG5BRjtbjsHoBcSIIsRsgtVN+41ZitNMgCCL3W+88kpTGE4TPLOJ2aB7FF
 DmBC/NnxPhQbbm4oVaZCYR+WBDwpZDsIvWexVysRH9Jo4+5Qz7lzPxSxe5S+9A1LbBAUbwknjWK
 oqpmSMeJvyGKWoL1bCiA==
X-Received: by 2002:a05:6830:83bc:b0:7dc:d967:63de with SMTP id
 46e09a7af769-7e8fc30e7a2mr2919902a34.3.1781620198595; 
 Tue, 16 Jun 2026 07:29:58 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e79f6fb5edsm7263749a34.26.2026.06.16.07.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 07:29:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymondmaoca@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 7/9] tools: docker: Drop patman from the CI image
Date: Tue, 16 Jun 2026 08:28:47 -0600
Message-ID: <20260616142859.54136-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616142859.54136-1-sjg@chromium.org>
References: <20260616142859.54136-1-sjg@chromium.org>
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

The CI runner image pre-caches pip packages by downloading each tool's
requirements.txt from master. A later patch removes patman's
requirements.txt from the tree, so stop fetching and installing it.

The same step already installs setuptools explicitly (patman's
requirements list it too), so this needs nothing further.

This takes effect the next time someone rebuilds the image; the existing
image keeps working in the meantime.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/docker/Dockerfile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 73bf6cdd2c5..a91a1060cc4 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -362,7 +362,6 @@ RUN wget -O /tmp/pytest-requirements.txt https://source.denx.de/u-boot/u-boot/-/
 RUN wget -O /tmp/sphinx-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/doc/sphinx/requirements.txt
 RUN wget -O /tmp/binman-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/tools/binman/requirements.txt
 RUN wget -O /tmp/buildman-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/tools/buildman/requirements.txt
-RUN wget -O /tmp/patman-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/tools/patman/requirements.txt
 RUN wget -O /tmp/u_boot_pylib-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/tools/u_boot_pylib/requirements.txt
 RUN python3 -m venv /tmp/venv && \
 	. /tmp/venv/bin/activate && \
@@ -370,7 +369,6 @@ RUN python3 -m venv /tmp/venv && \
 		-r /tmp/sphinx-requirements.txt \
 		-r /tmp/binman-requirements.txt \
 		-r /tmp/buildman-requirements.txt \
-		-r /tmp/patman-requirements.txt \
 		-r /tmp/u_boot_pylib-requirements.txt \
 		setuptools pytest-azurepipelines && \
 	deactivate && \
-- 
2.43.0

