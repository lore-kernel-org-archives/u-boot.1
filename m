Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB002E7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:17:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D22B9806D3;
	Wed,  1 Jan 2025 23:17:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nEsz08Dz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E75EB806D3; Wed,  1 Jan 2025 23:17:00 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A71A5806C9
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:16:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2166651f752so169508975ad.3
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769816; x=1736374616; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1kQezJ9qfREjxzoPx7XBryc7v+8y+Y3wNyNOWSvoCeg=;
 b=nEsz08Dzu1A5/M8K9svPW/DNLz4FlAozQtKn7yyrbC+Gz2MlNE5YVVSGmFnPa7EC1o
 unUyEXltepo61qrPOIG1WDow28CEVcX3GFxLBh+ZzHoYocMqZCFac07fdtlfxGiPUySD
 V99E4dMQFWzfItnQj2yMF0/aygUAiEvFWpbKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769816; x=1736374616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1kQezJ9qfREjxzoPx7XBryc7v+8y+Y3wNyNOWSvoCeg=;
 b=cVFlT0tONrs66EygKJ+01qJKPwePZJohlU9vVhrImfl2XN5PfuFZwWQ/eh1f6m+UJn
 PXzJjq13/UOFNEBYxAC1qHtWmxJ99E5RIPto6LiNm0G2KELT3zPi0C/wib7+L06PyZXq
 rQqvm6QOFpKI8U7B+Q2MWUaS3kymESueZkNK4RkVAdmQSr8A05cMbojfhBlmWAWj/RLH
 HLWdpNHxIru0UUqMY6ad5uSSmPdZ0WpBWpUoZoJlSpQoLx9Y5qKM5aFQ/qfV8Cz3kQWg
 G//DDQmtwLtwJQkDnX+TG88vALSGmMilC69VJeEzPUWDAzEfQ53YAgzrZUOaTJjffAe1
 /SmA==
X-Gm-Message-State: AOJu0Yylf1KE4uJcIbbCCq2cPR05V/AO3GIoOEcoOUUYUIJenv6esMdM
 5bzq6f2T26ZpDeXXIERPQc1OZjhnIbRoKPcPC8gaRBxviUkHZvVs4cLUX/5SdOdywYzY/8ftT44
 =
X-Gm-Gg: ASbGnctlVqn5RlwJO67JeTcjwT6eogEiCRQAaImXHh0bulymIZLH5mo7JXZCLIS1NRE
 3GCCGh7bz8GN9z2v866Wcmydxxs8WiHLvlVwtPy19pKb8Ln6LVMWbRMvFzrm4bofm6UlUWgKXkp
 fA+GVihFcEkNPIIvDDEtpxOFmNn9EI4SNScpvy3pGMw/pA0HxQCWM+2O2YibEZIDUan6mIrY/PL
 EQWakT7+99AydKUQCRZZkr8U69XxlsvVRqPUByHaJhaKXmR1Ph4ML8=
X-Google-Smtp-Source: AGHT+IFbTJVw4EjLB2bGNEDjuNC6WFQUzZ4AoJ6pwoICPyH0K6zC5Xpy9YCzPJ/0rMi4f2CzHHm1mA==
X-Received: by 2002:a05:6a21:150c:b0:1e1:b44f:cfef with SMTP id
 adf61e73a8af0-1e5e046f687mr60439556637.17.1735769816295; 
 Wed, 01 Jan 2025 14:16:56 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:16:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 37/67] upl: Correct comment and condition in add_upl_memres()
Date: Thu,  2 Jan 2025 11:09:23 +1300
Message-ID: <20250101221003.1944600-38-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

Reword the function comment for clarity and correct the test for no
records.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_write.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/upl_write.c b/boot/upl_write.c
index 25ec6992573..b2e9ae85712 100644
--- a/boot/upl_write.c
+++ b/boot/upl_write.c
@@ -401,7 +401,7 @@ static int add_upl_memmap(const struct upl *upl, ofnode root)
 }
 
 /**
- * add_upl_memres() - Add /memory-reserved nodes to the tree
+ * add_upl_memres() - Add /reserved-memory nodes to the tree
  *
  * @upl: UPL state
  * @root: Parent node to contain the new node
@@ -413,7 +413,7 @@ static int add_upl_memres(const struct upl *upl, ofnode root,
 	ofnode mem_node;
 	int i, ret;
 
-	if (!upl->memmap.count)
+	if (!upl->memres.count)
 		return 0;
 	ret = ofnode_add_subnode(root, UPLN_MEMORY_RESERVED, &mem_node);
 	if (ret) {
-- 
2.43.0

