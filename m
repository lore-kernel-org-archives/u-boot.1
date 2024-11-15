Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8928BD68BCB
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 16:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF6728906C;
	Fri, 15 Nov 2024 17:26:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B32jdxfC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73B508908A; Fri, 15 Nov 2024 17:26:56 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 498FA88ECC
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 17:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-460d2571033so13434371cf.1
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 08:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731688013; x=1732292813; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QFs4zkLu2pVMuHfNZEy8nB21I4T+y8K4ka7HdWN4llw=;
 b=B32jdxfCaQDuUXgyriJNDmTvKDFeD8A2Ld7iafkv8tLFqknTTNMmHuUNnS6llOq52q
 qZfrN6Uhk/FBC59YEl6JjMMLMDdL2uEKaYQB/233gIaZTkLCTaOle6Ey8oJehjl2j8C+
 DCznewwK6NumzNZSVv0FxL9VIDkbqTXrNU2Ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731688013; x=1732292813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QFs4zkLu2pVMuHfNZEy8nB21I4T+y8K4ka7HdWN4llw=;
 b=xJ3ev5oCZwLiTxRfBjFMQG7c4p521gC17KOJfGoOQs7BPG5VIB8apOZbUT3BdA50oJ
 2rc/im8agdn6IbOof6P2hGp4Q+j1TwaddiVpwI8yL9P6wbwLUFroAr9+sGrVYivpHLV7
 FSolAFvoNe+OagmiEsMBD/q7gzYZ4wtW9A8Z2upFEVVGgbjxuHwAhaQ3MezU4FjdpGL6
 vyKgLwISuDVbMzmPJWL5klrNaGBiosQlU9FPlQNYpRGJ829DvfZuV1R70a7aEHFvrD+Y
 A9BFveCzMDJJICaIKkiLg2YGyoCM2ANEp6xH69k0PARVui5fwYeW3hI+ww5d0Ab/BF1h
 MQRw==
X-Gm-Message-State: AOJu0YycKHOmnkXv/tqbwsz1g5BoOjjOzo3d56feW5egrP0uA+zdHVeL
 tsVGi7Fai5iTdv0sL6eVbD+mfCrhDqkwR7muKOBXLbnpE7G6jbDPtrB5AkC70TrwT4MtUOTLDNF
 OKDs=
X-Google-Smtp-Source: AGHT+IG0wjtGbS8Thv9djAO66Ubj9v1bcLOXi3rfgG+8HqqvXeF7fTO/tGwuZcvBpuYxRco4sEbXuw==
X-Received: by 2002:ac8:45d7:0:b0:460:c2f3:9017 with SMTP id
 d75a77b69052e-4636a7d507bmr17091911cf.17.1731688013043; 
 Fri, 15 Nov 2024 08:26:53 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635a9f23besm20577331cf.30.2024.11.15.08.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 08:26:51 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] docker.rst: Reword slightly around "buildx"
Date: Fri, 15 Nov 2024 10:26:49 -0600
Message-ID: <20241115162649.2395503-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115134807.3068947-2-sjg@chromium.org>
References: <20241115134807.3068947-2-sjg@chromium.org>
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

Try and be slightly clearer about what "buildx" is, and how to install
it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
I rephrased this slightly to try and be clearer as if you're using the
docker.io provided packages you need to just install the plugin.

Cc: Simon Glass <sjg@chromium.org>
---
 doc/build/docker.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/build/docker.rst b/doc/build/docker.rst
index 5896dd5ac4a6..81b394597ffb 100644
--- a/doc/build/docker.rst
+++ b/doc/build/docker.rst
@@ -4,8 +4,8 @@ GitLab CI / U-Boot runner container
 In order to have a reproducible and portable build environment for CI we use a container for building in.  This means that developers can also reproduce the CI environment, to a large degree at least, locally.  This file is located in the tools/docker directory.
 
 The docker image supports both amd64 and arm64. Ensure that the
-'docker-buildx' Debian package is installed (or the equivalent on another
-distribution).
+`buildx` Docker CLI plugin is installed. This is often available in your
+distribution via the 'docker-buildx' or 'docker-buildx-plugin' package.
 
 You will need a multi-platform container, otherwise this error is shown::
 
-- 
2.43.0

