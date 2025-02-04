Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84E5C02193
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 00:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B05880087;
	Wed,  5 Feb 2025 01:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="anw2R83N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 594E4807D9; Wed,  5 Feb 2025 01:08:05 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED03D8078B
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 01:07:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5f2e31139d9so2895761eaf.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 16:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738714076; x=1739318876; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HNqoTObLkIOwcJaEwvUjbA8BGqREN/SAPmRaX/QEnLw=;
 b=anw2R83NJP8OaYb4XZD1sVfA9QrWRR/vReHPiTaR5FQBVlpya3RqLxEDOihnmjiCWy
 aGTovXaNnUZJo9aopCIFqVqRavj4aFLvjBF2LQGqk9uA727i5G/Pdr+H5CMMZeqtHORA
 rHZAi/TXhqqmT+Ea3sFJU4MVj01ptpF5topQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738714076; x=1739318876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HNqoTObLkIOwcJaEwvUjbA8BGqREN/SAPmRaX/QEnLw=;
 b=l6Qp2ZnfdfbvewTTvUob3EmBjDv1aGIQcNvqVR8QlE6gwHSSIfQIu9W01uRWO1MKmT
 T32GpreEoYoS4KWZ5SrkEzjr6vlY2PFR0MaLmnLGYbCXwj1pEc34BqNQbTf3L/l1bxYb
 IRD16TbRjXTMu8syaOj4OClBODTGb+6pMCq/zRlKcPUQrNwLMMIOIqToeynIVyeE9n6y
 uCc184RjJ2Mxg6TTpso+EMdzSskqfiDqQFhLLxle/5KfEnSZqBkO/PcdmPOXC5z1S5zS
 BQydM8kIwr2JsnfpzCVtAT0b+79s01tpDs4gtM9h3Mr00bCZ2j93oQHmODC+GUIsh2qJ
 YJew==
X-Gm-Message-State: AOJu0YzwIIogNxPEoGegdLUeABqBrXf6FHOR3UVEIB6wu0w+Z1N/6sBU
 u2yEJKPANAdfG1z2ZT4d+qNtliX+mrgY00Ou0x0cpa6u3mzj2R8A6J34rm135SARKZjpZIj/7RC
 GIQU=
X-Gm-Gg: ASbGncsDsV7eqwD7I8xnVqIccO9D/2asH22HQv7pXr7qpoi59o/EREySGnm5p45OLjP
 l/E4/u9CcqGT3TDiRpdPiozy/BJBu+aJDYjKst3HJbDQT3XwvkmUOKkDnF3T/2c+hYBcVvZNW5+
 FpxPZg9Deuo7D2xlKGg7ERb6d4ZHYZQiHc5vkULCKHMjgQPO5IJ5qjLxyUogbHUw7PtyoIyhA/3
 0BxV/rJQ8OU58atf2u9XErS3FVQgeQww3JmS+xTLiuc3IgJeYQfa/ftpV8AsLYIYGW1yO81mwq/
 4OTJBvXNJEwhr7zm9g==
X-Google-Smtp-Source: AGHT+IGf6QD4jQJ6zK7V/RCvqFOgfr28UMU8VQnKLXuQd/DhlCYXwR0fsJYwXT6BIh8PIRbHQx3srg==
X-Received: by 2002:a05:6820:2208:b0:5fa:9407:a416 with SMTP id
 006d021491bc7-5fc4799f449mr624614eaf.4.1738714075659; 
 Tue, 04 Feb 2025 16:07:55 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc105d40b7sm3428552eaf.36.2025.02.04.16.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 16:07:54 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 5/6] python: Recreate test/py and tools/buildman
 requirements.txt files
Date: Tue,  4 Feb 2025 17:12:08 -0600
Message-ID: <20250205000743.949790-6-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205000743.949790-1-trini@konsulko.com>
References: <20250205000743.949790-1-trini@konsulko.com>
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

Use the "pipreqs" tool to re-create these files, with a few manual
corrections. We still need to include pytest-xdist which the tool does
not detect. We also for now don't upgrade most of the required tools as
that creates problems with various tests, which should be resolved
independently.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 test/py/requirements.txt        | 28 +---------------------------
 tools/buildman/requirements.txt |  7 ++-----
 2 files changed, 3 insertions(+), 32 deletions(-)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index 75760f96e562..acfe17dce9f0 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -1,30 +1,4 @@
-atomicwrites==1.4.1
-attrs==19.3.0
-concurrencytest==0.1.2
-coverage==6.2
-extras==1.0.0
 filelock==3.0.12
-fixtures==3.0.0
-importlib-metadata==0.23
-linecache2==1.0.0
-more-itertools==7.2.0
-packaging==24.1
-pbr==5.4.3
-pluggy==0.13.0
-py==1.11.0
-pycryptodomex==3.19.1
-pyelftools==0.27
-pygit2==1.13.3
-pyparsing==3.0.7
+pycryptodomex==3.21.0
 pytest==6.2.5
 pytest-xdist==2.5.0
-python-mimeparse==1.6.0
-python-subunit==1.3.0
-requests==2.32.3
-setuptools==70.3.0
-six==1.16.0
-testtools==2.3.0
-traceback2==1.4.0
-unittest2==1.1.0
-wcwidth==0.1.7
-zipp==3.19.2
diff --git a/tools/buildman/requirements.txt b/tools/buildman/requirements.txt
index 052d0ed5c6f7..d48650cd1e58 100644
--- a/tools/buildman/requirements.txt
+++ b/tools/buildman/requirements.txt
@@ -1,5 +1,2 @@
-coverage==6.2
-jsonschema==4.17.3
-pycryptodome==3.20
-pyyaml==6.0
-yamllint==1.26.3
+filelock==3.0.12
+importlib_resources==6.5.2
-- 
2.43.0

