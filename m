Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6325DC25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 07:26:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB19E8759B;
	Thu, 26 Oct 2023 09:26:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YW94W6LR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C56518750A; Thu, 26 Oct 2023 09:26:41 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91083874E6
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 09:26:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cc0e78ec92so1437585ad.3
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 00:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698305198; x=1698909998; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=crl60Str28pt651eqf4nmclTHVudykiY/eZ0krpY9aQ=;
 b=YW94W6LR/WM43A5vVValOvSQbyN/BwgWRryf306xNY4HygwMzXnFwP8QtvRCgP8QYv
 dxC5dExyiHbg1I7MAamBTDjBEXvgDGRYanSjfceAljj1VDNTTN2nwjro3p+wGVEADVay
 ynvdxnLfZKxJ7EqrPc+cia41pkaL5MMQpK+ZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698305198; x=1698909998;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=crl60Str28pt651eqf4nmclTHVudykiY/eZ0krpY9aQ=;
 b=BzHuUPyMy4tOAqkHurJBEbhNYy6nL8Y7vogI/cfnR2/G7m5d8QmlY4RJGOoNcWdvBo
 r3rqgNs9d59ARgzDL+2vRuPfJgoGS4Cv1UGzW+pBPUjy4DAUQNk1natVSYFb1RnB1Xjk
 GZV5YMCH2/FhKaeQ2FYDghkhLvGpMYoURncFjTjGoMVwX7FubaiQc+6D2m+HYeaxSqj8
 M1WOkW3epzW3/SonyzY1sCvAcHOC180bRFtq8s+TO9LzKD+EFqx0v0UJ3rXPSh3NAfeo
 K6BHkk9pgQizOUwYEY+mPh8RIen0YoqZwjhJMbC8X9Iggj7AVjP2Po4Fi4BzaDL15INo
 5Q1w==
X-Gm-Message-State: AOJu0YyalDJKiEQbRnBB1pqINzg9nsAzqdC9k4Hm+/e3ePtbpXms76jP
 fYadeFVw/ppC2gCILNtmF3T2yA==
X-Google-Smtp-Source: AGHT+IFAdvhaKLgojDavPL6jfCwALsYDKQgHxk5a0vAeNPu/TcvJvklixGPP43czx011qTe2l4IkQA==
X-Received: by 2002:a17:902:da92:b0:1c7:4f87:3dbe with SMTP id
 j18-20020a170902da9200b001c74f873dbemr17779216plx.31.1698305197884; 
 Thu, 26 Oct 2023 00:26:37 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.130])
 by smtp.gmail.com with ESMTPSA id
 n17-20020a170902e55100b001b7cbc5871csm10294023plf.53.2023.10.26.00.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 00:26:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Nick Terrell <terrelln@fb.com>,
 Nicolas Schier <nicolas@fjasle.eu>, Will Deacon <will@kernel.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: Add a build target for Flat Image Tree
Date: Thu, 26 Oct 2023 20:26:22 +1300
Message-ID: <20231026072628.4115527-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
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

Flat Image Tree (FIT) is a widely used file format for packaging a
kernel and associated devicetree files. This series adds support for
building a FIT as part of the kernel build. This makes it easy to try
out the kernel - just load the FIT onto your tftp server and it will
run automatically on any supported arm64 board.

The script is written in Python, since it is easy to build a FIT using
the Python libfdt bindings. For now, no attempt is made to compress
files in parallel, so build the 900-odd files takes a while, about
6 seconds with my testing.

The series also includes a few minor clean-up patches.


Simon Glass (3):
  kbuild: Correct missing architecture-specific hyphens
  kbuild: arm64: Add BOOT_TARGETS variable
  arm64: boot: Support Flat Image Tree

 MAINTAINERS              |   7 +
 Makefile                 |  10 +-
 arch/arm64/Makefile      |   7 +-
 arch/arm64/boot/Makefile |   8 +-
 scripts/Makefile.lib     |  16 ++-
 scripts/make_fit.py      | 285 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 324 insertions(+), 9 deletions(-)
 create mode 100755 scripts/make_fit.py

-- 
2.42.0.758.gaed0368e0e-goog

