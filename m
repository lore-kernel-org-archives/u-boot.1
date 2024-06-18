Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACD8C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:19:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6653883CD;
	Tue, 18 Jun 2024 16:18:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NSxitAG+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF321883BB; Tue, 18 Jun 2024 16:18:58 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A78F88356
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6fa11ac8695so3070370a34.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 07:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718720335; x=1719325135; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=elVymhwo2OdpJadyrd8yaQq/Z18oiqjUd3sCF5Meh8E=;
 b=NSxitAG+jLiZ64HvpDKK2QqXEv/gm2FfTIUqsQQZAyvD1aKX8MHlUZp+oNi0VM8nPq
 MrL72vlXNIvAkkv52DzI9dHEQTiQ3x0fme1kYhBCoZlm7+z+FOgp+tmQBeaNhp/dy6K2
 ibdOwQmcyzh8tsqeYLcTraWDE1QBp2oa/qplU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718720335; x=1719325135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=elVymhwo2OdpJadyrd8yaQq/Z18oiqjUd3sCF5Meh8E=;
 b=m4tCaF8okx6m2JlAPg27phYDy0uvUVPR82LJaT7pk25M+rRa35i2ycDhAK2nBtCSqb
 Iyj4ZGatrvT9X8VPWVFSbDBzuYRFGf/v+YNdoumY8h+LnyuM+OHOlZ4MwglWMktTiTMS
 0ivqUrWkUc5zbMMDT7XGXqqbsoER6co1VkOlKp6noUyTp91K9po/impgCSHi1v3NkO5f
 Eye2myzKXVzeySJtgatHs0Q7Oq+0q4LOYnIHvqM77YwtfKvBQo+4UehgXh+D/G9iIeWP
 uQQhnCUjE+iTleLPrnj3xROOnTbGTFkQchbNfWnKdCF35VvmnO5DXj+9uon5fu408W6E
 L+hA==
X-Gm-Message-State: AOJu0YyrxzQO1aSKfeaY/BFPc6moEsoAdodjY5D4VNr140Egn3g93WjJ
 spWIvEciJ6Y+1tAwNwepzqFAa1vTHBq1ItduRVjsEXdlVdswyRCAQG+kZY9D+996x4m9WEEIMxE
 KpC1law==
X-Google-Smtp-Source: AGHT+IHpxtM41BaJv3KbA72dtPIYepS367SrMQXIP9kPFLbZClslXRslS4YycsghB2auTn8FTO9tZw==
X-Received: by 2002:a9d:6f01:0:b0:6fa:17c9:1978 with SMTP id
 46e09a7af769-6fb93b09545mr13325075a34.30.1718720335342; 
 Tue, 18 Jun 2024 07:18:55 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-187-190-205-45.totalplay.net. [187.190.205.45])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6fb5b1b0bd9sm1844183a34.27.2024.06.18.07.18.54
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 07:18:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 5/5] Azure: Count all of the machines we would build
Date: Tue, 18 Jun 2024 08:18:51 -0600
Message-Id: <20240618141851.3303112-5-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618141851.3303112-1-trini@konsulko.com>
References: <20240618141851.3303112-1-trini@konsulko.com>
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

Now that we have each stage of the world build using variables to define
what it will attempt to build, and that we have added in missing
machines, add a job to make sure that we would always be building
everything.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 116ce903b067..c43bb51066a5 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -196,6 +196,34 @@ stages:
     steps:
       - script: make pip
 
+  - job: count_built_machines
+    displayName: 'Ensure we build all possible machines'
+    pool:
+      vmImage: $(ubuntu_vm)
+    container:
+      image: $(ci_runner_image)
+      options: $(container_option)
+    steps:
+      - script: |
+          BMANARGS="-o /tmp --dry-run -v"
+          # First get the total number of boards
+          total=$(tools/buildman/buildman ${BMANARGS} | grep "Total boards to build for each commit" | cut -d ' ' -f 8)
+          # Now build up the list of what each job built.
+          built="$(tools/buildman/buildman ${BMANARGS} $(am33xx_kirkwood_ls1_mvebu_omap) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(amlogic_bcm_boundary_engicam_siemens_technexion_oradex) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(arm_nxp_minus_imx_and_at91) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(imx) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(rk) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(sunxi) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(powerpc) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(arm_catch_all) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(aarch64_catch_all) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(everything_but_arm_and_powerpc) | grep '^   ')"
+          # Finally see how many machines that is.
+          actual=$(tools/buildman/buildman ${BMANARGS} $built | grep "Total boards to build for each commit" | cut -d ' ' -f 8)
+          echo We would build a total of $actual out of $total platforms this CI run
+          [ $actual -eq $total ] && exit 0 || exit 1
+
   - job: create_test_py_wrapper_script
     displayName: 'Create and stage a wrapper for test.py runs'
     pool:
-- 
2.34.1

