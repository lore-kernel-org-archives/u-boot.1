Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EB1C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 16:28:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FE1980562;
	Wed, 29 Jan 2025 17:28:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q2n5HrkR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23857809D2; Wed, 29 Jan 2025 17:28:20 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E00BF8036E
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 17:28:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-46b1d40ac6bso8282151cf.0
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 08:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738168097; x=1738772897; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=v5dj8H5veSAWm6dfJgNZEnvmVzO2XPi1qrbuhHf+Sm0=;
 b=q2n5HrkRzsHndOSOcnHSZHI5H26gIAqRzi2elCwFgiqjbv6Xo+ihgPXpo09m6UQpSv
 1o7VTeWS+Eoun3oN7wYi9pNH0DNw6mGmvL82fiMpruHWFG9QMwi4nhMIOdE7fK0yRKrS
 H+D0zn8TYyqi2fe7a4lcMhwrWXyJC5CR2CSsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738168097; x=1738772897;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v5dj8H5veSAWm6dfJgNZEnvmVzO2XPi1qrbuhHf+Sm0=;
 b=j/qEFq1de0JJwKyUEAXQT2x3cVKMkXev2B2cFvCqgJ8o6KNgaIJ2gJ31W7bfw84CJL
 k/uxCrwAl9m//H54d3dlJzhGqgvLokk2CUoKn+JWVm7qwtlgh49V14pMZVE+W4EJoWwz
 +h72SUdQ1roJ3jOX33/6PR5x5bouKHkf/PHn741/GkcT5F68fcjvTIF4LrwTtLCYDQ8J
 hEfOgzCRkDNgp+jxZ7OLbYV/dZ+rfKQ0Cv9V+eENlj4tNek8DWwvkVC9kdYP1cn0zlQ6
 MhA7vUzkE0gYM/Fd6DSOd2uuwGTXh2MAGWeViiANlchcCzoJdLGOyq6HlY8ZFjCd1XKK
 mPSw==
X-Gm-Message-State: AOJu0Yy1QQG1nwJD79qfnUtcPdOB9Zv5OFKIeLJHfE7IourZ9aNS1i7q
 JKaqE4VLqQAlGtXPXZvK55YRV33n7HqC3CWYzg5tXf/7xU/oW6SuiXizBohyz+WZgE3L9bmnV7C
 N
X-Gm-Gg: ASbGncsw29/FgskkPIlm108FIMAIm2ObdEDbanL/imIMVmRsdLljRO2GVGGkPnqBfYy
 MMwCDmrDu87eH8UkbKb6Er+Yh7CKTOYziTlcxJevDYbtayt9D5BZ2iWfdr3g4ujUpT9blBA5Ukn
 Z2+QY2FGH1dtxvMiw29x0OFMBBvuO959pfZSJW6b5bREws/PMV+xl91pDwxvoL4rzwgRRyq1+XL
 fDBpY128KyCt9I/BwrCoqsp6o+5xLXLDRMO1puKmAwkm45LdL7ClMxLUlUlhGjeqJLf0jJHgLPR
 D81qouMdnBay+E/1Hg==
X-Google-Smtp-Source: AGHT+IHnylemXBD+txjKjQXQsDMMCyjTzJqgVj4uTes8dlG20/cY8T+k1k+UaC+9rx9Fn2B/UIaYkw==
X-Received: by 2002:ac8:6f1a:0:b0:461:7558:892f with SMTP id
 d75a77b69052e-46fc49a77fdmr143497901cf.15.1738168096665; 
 Wed, 29 Jan 2025 08:28:16 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e6687efdcsm64414821cf.23.2025.01.29.08.28.15
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 08:28:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/2] test/py: Update to latest pyelftools version
Date: Wed, 29 Jan 2025 10:28:13 -0600
Message-ID: <20250129162814.2140325-1-trini@konsulko.com>
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

Version 0.27 of pyelftools was released in October of 2020. Update to
v0.31 which was released in March of 2024.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/py/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index 75760f96e562..47118f9f2b30 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -13,7 +13,7 @@ pbr==5.4.3
 pluggy==0.13.0
 py==1.11.0
 pycryptodomex==3.19.1
-pyelftools==0.27
+pyelftools==0.31
 pygit2==1.13.3
 pyparsing==3.0.7
 pytest==6.2.5
-- 
2.43.0

