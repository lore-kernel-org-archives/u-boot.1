Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BC1E7717F
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 19:08:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4800889538;
	Sun,  8 Dec 2024 20:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ObvvCy48";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BB508954B; Sun,  8 Dec 2024 20:08:02 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69497894AE
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 20:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b6c3b1ee59so104835585a.0
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 11:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733684879; x=1734289679; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WHlELdmKGzdhxcsd9zuaSJHWyH58fse7NExRX29a0T8=;
 b=ObvvCy48GTIt1FvV6VlLPNd7/1tFbI5KvYiQRdtv1Jegpp+e9KekwBPvwpAYbmO5gp
 WGdxo2ACx9X/LAUdOucbgqFVi83bTyOYVezHbIyaVsQ5o0cbxhlRyEQaS3fy37ErB2hZ
 M3ddXi/aVZMCk9C4A7J8khPnT2XDR5JE7wz+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733684879; x=1734289679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WHlELdmKGzdhxcsd9zuaSJHWyH58fse7NExRX29a0T8=;
 b=pQ9cqAAe50Eek+N3oY/EJw+ttrpOvzCyWeBh5gBi+bR6NuODvss3GE1sRjS3Df9EMd
 P5rMwVaX/hpOPvMpao28cmw+NePSJTVnEXbDQhssiOLMKdAZgwwiMIANbaxP5YOy2tN7
 KQrw0/3TjdJtk+pmlgrCVwWZop0RJFbFfsOL70cyo+qcqzv/cURoeU0rCCy3aP6LVkCr
 qemzDzOIdlF7S64yzyDRa5imMogw6dBuupifBxoX+EaWrFY5AY9QA7DVMMgX8ua/nMFv
 1Vjz4fl/EcOSE0qGndZ4y+MJGlh+7jAWoLYhLBZZus3aN1vIYmCK6k/5BRbcjo7Fn81v
 ThzA==
X-Gm-Message-State: AOJu0YyW+WGcWVArjpCheOxGehefIWxwFT3cIzyBu9TZRFeb99eyKW3M
 4cfwCQU0bWhp+qgpxsmdbuq1Cep1ih1Jfw+hwSsYqx7zptKe/umsAWVswsnzOgtsV40PPXTFXAb
 gR2w=
X-Gm-Gg: ASbGncs1MnyxAkuSTMDL5QVXskbKJGF5La/A28uFuXCMza+Qt+RUL3Sh+JJ5t3CmzvP
 c61go6bMsADT4UoFpNyVz0BS5stM5de2tsc6G0nyuhHrarSWoZyjjAQ0iM+913R2I4JFJaO4m+B
 2P4esWArcnc+ksr4tx0/C8sqwYgqg763Rdjf/St/OfuWpbzYD2rrYb0nvqsgsFricfLt01GQ7Hb
 PEHLuZl5M/UyIS1jfTVuNnW7lafOCJBXtoE9kezS+aAIEFO6vS9WsjLKJYhxKdCcDpjGkFmPQ==
X-Google-Smtp-Source: AGHT+IEJ7f95jcZxMSvg4bplgX9QFg4a/gzJC/sFpl5DvTDyIpZtp9TSe3osvJrsaVllv+J/+8Xb/w==
X-Received: by 2002:a05:620a:1d0b:b0:7b6:d237:abf4 with SMTP id
 af79cd13be357-7b6d237ae37mr352328285a.39.1733684879372; 
 Sun, 08 Dec 2024 11:07:59 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da66ddeasm41154076d6.25.2024.12.08.11.07.58
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 11:07:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 7/9] docker: Prefer the kernelorg toolchains over "root"
Date: Sun,  8 Dec 2024 11:07:30 -0600
Message-ID: <20241208190741.4192601-8-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208190741.4192601-1-trini@konsulko.com>
References: <20241208190741.4192601-1-trini@konsulko.com>
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

We should always look in our downloaded toolchains first and then for
host-provided toolchains.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/docker/Dockerfile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 5d77e2b62696..348605a2b6a3 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -318,8 +318,8 @@ RUN virtualenv -p /usr/bin/python3 /tmp/venv && \
 	rm -rf /tmp/venv /tmp/*-requirements.txt
 
 # Create the buildman config file
-RUN /bin/echo -e "[toolchain]\nroot = /usr" > ~/.buildman
-RUN /bin/echo -e "kernelorg = /opt/gcc-${TCVER}-nolibc/*" >> ~/.buildman
+RUN /bin/echo -e "[toolchain]\nkernelorg = /opt/gcc-${TCVER}-nolibc/*" > ~/.buildman
+RUN /bin/echo -e "root = /usr" >> ~/.buildman
 RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
         /bin/echo -e "\n[toolchain-prefix]\nxtensa = /opt/2020.07/xtensa-dc233c-elf/bin/xtensa-dc233c-elf-" >> ~/.buildman; \
     fi
-- 
2.43.0

