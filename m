Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CE2C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 20:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6695A80AE5;
	Wed, 29 Jan 2025 21:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q6cKXaN1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8EAB80B9B; Wed, 29 Jan 2025 21:47:18 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B125F80ADF
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 21:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6d8fd060e27so812256d6.1
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 12:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738183635; x=1738788435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=USvXdv7Zh7hTN0g0pVd1ue/OFhTtjqOLeriVeQBMBC4=;
 b=q6cKXaN1LKvLY/xwzu5uLnH3yeJswDxdIEfxeAlQqDG+1hUWdbHOtjebHFTDIxi9om
 3UUGOXntaozin1yl+tn7MTuD32fm2CtpcSf/lWd+OtzffxmAvSvsRiUGkZLi8SQHw2Wu
 0l8BldNzjj4s6WeEB1oPjxlq+XThuHmZ+0kx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738183635; x=1738788435;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=USvXdv7Zh7hTN0g0pVd1ue/OFhTtjqOLeriVeQBMBC4=;
 b=k0rc+Hc6PqAEnkq7xfxaiN/3GMOaz2D+6Wmg/DPIADvo7wKaZ7LkfiMYfkWjOm0JIm
 uTxhlSao3YUZavENWTwOj36d98iKRO1V7wIE7vxnsnxcOD3WNQyWFH8eGFQbFx41mJaD
 TSJMTnqwBdCpd+MeUCET5Ork60dpDGua64BUUtPiYlRwpiMNKDlYVPI1+FcbLtE0IPeu
 NJC3BfL0Ugk5T7IgsUvGC3mNNFVpJpICY+JRZZ9U8f8AOneouIUlJ1ryMzHnPfAhUB2R
 oOtURoUJL64jEPkLpUga9GJCb0pDDQ4KxNskcpQon5BP+xdzg/24GMD/PtmO9zK7pD5d
 OmiA==
X-Gm-Message-State: AOJu0YwBDbjPqxnP+8qS8Su8xlZbtuoc4lCIzG87DGo45N1jx5deNX2t
 Uh++mNK9FlppIY5PSULPWM6m4rHvvkBp8hSg8Oj4X4RBryOpX6NbTYfAASRP/e+Ow46097wXVMa
 1
X-Gm-Gg: ASbGncvwVINV9VC65I1z8UWtQUf4iYEbOQWuad7fj6EHq9ibz2UAGs7sjpE3NrvoS3o
 oKkctfdocV6pEHFOhJal0bUCZQeVkNdyePt97qh5fI6UIuWWIF0Ck8DpkXPMeI7AfNPHXTsNgm0
 Jpr81u5Z578YEAIuEqO0z+S12UnVmVZxtKANG8RLmnZLXzpM9CALNYO5kHJhR4iaDZFe4AVtrEG
 TsFbcovZgHLP5ZhFYjjU1zFeh7rACm0ijwPTpViJRVLD4Q+bSVNUAAthIkQSJbywZFClZvzF/6g
 Hihj3XLf5uykM/O1jw==
X-Google-Smtp-Source: AGHT+IH2QINU2kBnQcRVTJ736igSXLVfRZGCbP0qOhzgr8U8+Qtb+BcEudcXaQ/iHvpaccRJvklC6w==
X-Received: by 2002:ad4:5e85:0:b0:6df:9740:68a3 with SMTP id
 6a1803df08f44-6e243cabf83mr81647886d6.38.1738183635486; 
 Wed, 29 Jan 2025 12:47:15 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e20514f174sm59779446d6.28.2025.01.29.12.47.14
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 12:47:14 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] Gitlab: Add results.xml to the list of artifacts as well.
Date: Wed, 29 Jan 2025 14:47:12 -0600
Message-ID: <20250129204712.2170920-1-trini@konsulko.com>
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

Whereas with Azure the JUnit results file is available for download,
Gitlab doesn't default to including it as an artifact to download and
only makes it available via its own JUnit parser. Fix this by listing it
as an artifact to save as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .gitlab-ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 74dc05d58a70..215419dd2263 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -105,6 +105,7 @@ stages:
     paths:
       - "*.html"
       - "*.css"
+      - results.xml
     reports:
       junit: results.xml
     expire_in: 1 week
-- 
2.43.0

