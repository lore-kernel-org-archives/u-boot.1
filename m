Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF5FC2BA1A
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 13:14:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6447188555;
	Fri, 21 Jun 2024 15:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="faF/jZQB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 672868853F; Fri, 21 Jun 2024 15:14:32 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12F30884FF
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 15:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7ec07f4170bso77334139f.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 06:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718975667; x=1719580467; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cFSaA6VXEcrgTv0f2bUiVlpqYrjIjc98DeuzLh+0B54=;
 b=faF/jZQBjaD0Ei3cnlT84qxayClfx/tAR8UI1ecvX6YJZUG553it96ZJtWNXpogNUw
 Bwl2xy+w3EGuSyLVU0RkdjQxdd3JQl/biuFpJkGzV0hgX9SOYP/yT2zPmQS16BUIo/+J
 yzO5c5M6YU5JFGF4H0/KHFCovo+LDXRHBwLyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718975667; x=1719580467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cFSaA6VXEcrgTv0f2bUiVlpqYrjIjc98DeuzLh+0B54=;
 b=gVbRjtw0MK7RBso84j5EJnAivN+229uvbCRyaQonp1VdbVUNFBULRrc9YbURWC9S/B
 D3Wsqq8p6SBQbrdmNSCBRNRsgS0PDp5XM9DE757VnjQ+g77HDlVxhLIEnZRcLw+N1FjQ
 FojSLl7v2rXceX9YmO8P3pP8mB9IA9EaEtt2nSdOUwrHb9qmsrrJs2jqbV14cZWVXg3o
 eJzBTwGL0v8N5D3/9CrduIM7wYEW/MGNL4wOym3WANZUBXQ5+fInbGPEhRQgcwMKUrfa
 Bo3YinDxvS+pCNMblUzHM+Z+cbgdPqXwneE6tJVBD5F8en3WDs9jkYccDigl98meIo0u
 tFvg==
X-Gm-Message-State: AOJu0YynsJ/thwfUuo4ts4Qp0v8xC4DFn7+wD4ZpyF9ubvSvA3PEFXYv
 wgznp3+TsHXqOq4jO7CWQo3P7IvD41ClUt9A+SEVjJqLM0Nt7d1vNdPejQLfSKg1wAqrwW9GbN/
 MVQ==
X-Google-Smtp-Source: AGHT+IFHnKNHLuD5+sL4i/1CylgLWjbptKLkEPzoZK36hNL/ZvfgLqYunIc/vVSoORGn9A6EvsxJZA==
X-Received: by 2002:a05:6602:1687:b0:7ec:1cf:6fc2 with SMTP id
 ca18e2360f4ac-7f13ee8bb5dmr878504839f.17.1718975667730; 
 Fri, 21 Jun 2024 06:14:27 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d12496fdsm346881173.163.2024.06.21.06.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 06:14:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH v2 2/6] buildman: Add python3-pycryptodome
Date: Fri, 21 Jun 2024 07:14:18 -0600
Message-Id: <20240621131423.2363294-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621131423.2363294-1-sjg@chromium.org>
References: <20240621131423.2363294-1-sjg@chromium.org>
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

This is used by some Binman entry types, so add it to allow more tests
to pass.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add to buildman requirements instead

 tools/buildman/requirements.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/buildman/requirements.txt b/tools/buildman/requirements.txt
index 564e54898a4..052d0ed5c6f 100644
--- a/tools/buildman/requirements.txt
+++ b/tools/buildman/requirements.txt
@@ -1,4 +1,5 @@
 coverage==6.2
 jsonschema==4.17.3
+pycryptodome==3.20
 pyyaml==6.0
 yamllint==1.26.3
-- 
2.34.1

