Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998D4E7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:25:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E84480726;
	Wed,  1 Jan 2025 23:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JD097gwK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AF528071F; Wed,  1 Jan 2025 23:23:32 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC1D780735
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:23:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ee50ffcf14so13342023a91.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770206; x=1736375006; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1fG7aUENpT6SjT8ofA4LE93iV3Odu40dca13iYjGlLs=;
 b=JD097gwKgx5037B6sIkThhxg8aM5PfXiDrzaeU1dczdS6VAVfjceOk+BCDEt2FHvH5
 JdTXluT/vn2PT0E1eHRuh27UdQnA5+uIi9aJbMdlPZLwtp67//q67btIqrgU97JCedLu
 Wr17PFutw+bv/gBTrsvqzmxFyF0JeNnuAxBLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770206; x=1736375006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1fG7aUENpT6SjT8ofA4LE93iV3Odu40dca13iYjGlLs=;
 b=LYw5dg4Jb5riBwTsEqkFVTHYa6y7Uwcw+3eb7+xxSh7+WpmzKEbrNYfwqTfpgLZfT1
 C9GFS2hpisffROamqxov3X2soHekHuYlhbr4vvXHavhAg1tngZnHeVIWKL1aX6/oC4eS
 uIMsW9E7BhRZQ9dWvBVotJlyY4D67utEhu5GgvXQFGHlA/3P2V66kR4nWwbMZWWgU/iv
 ACVntw3jUpoFJR3dLz7tCJwKBGJyKS0MzEcsUri77s06ZFwg69TbD3ZqblgneS6jNFWq
 NcPhyJYjvtyTZXz6hcsHntruijAclcyLuJs/U5cEaVqI4bo57CS2gVSagqfp/HNYY7uX
 xYIA==
X-Gm-Message-State: AOJu0YzM/k8LCt/oWqGSrNRF+cL8z9C6gA9VNdNnz/yKxBxoadYDekdi
 Roxbt9GtOfnJCq5G/6Z60Vh1O0Fn90WlRZJO5CMfzBWIg1qQTEJq6yQNOzPds2A1VzWRKYWLLaQ
 =
X-Gm-Gg: ASbGncthAYFeGK5aIgmtcNNveE58BM67FGHRb2feV8r+RZBeAsgVYyI7Rl5L80Q1tYh
 4iYTo8sFtdfB8xDpowpiO5ner0m2m/Ng8UUhz1SsC4uML5PggwWY8PFFVbCG7oTmYNDkK3DxCK0
 qEyIlaVwQ9oXhZZBj+q18JCGZZZgeEBSKUptiClJp/UBxEFUcRPRU/B6zIv3BGOF/hERx1Q1p0W
 OqIOhRMse4ehFH/xvZlrfzlLCsydjnluPgpq+xj3Mxr2o2tcMrlWW8=
X-Google-Smtp-Source: AGHT+IG6GNxBgfXrtTqWtH+1cGydWcFBDdWBXgxLLMa7Kp+DtczSoM3KXzkkKsK+RrwM+euqXJKxdw==
X-Received: by 2002:a05:6a00:66cb:b0:725:41c4:dbc7 with SMTP id
 d2e1a72fcca58-72abdae93e4mr66185620b3a.4.1735770205804; 
 Wed, 01 Jan 2025 14:23:25 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:23:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 64/67] scripts: Update qemu script to use 64-bit on x86 always
Date: Thu,  2 Jan 2025 11:09:50 +1300
Message-ID: <20250101221003.1944600-65-sjg@chromium.org>
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

Some UPL images such as EDK2 may change into 64-bit mode after starting.
Avoid a crash by always using the 64-bit machine QEMU. This seems to
have no ill effects for 32-bit code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/build-qemu.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/build-qemu.sh b/scripts/build-qemu.sh
index f9ee0072573..10ea99982d2 100755
--- a/scripts/build-qemu.sh
+++ b/scripts/build-qemu.sh
@@ -176,7 +176,8 @@ arm)
 x86)
 	BOARD="qemu-x86"
 	BIOS="u-boot.rom"
-	qemu=qemu-system-i386
+	# Use 64-bit version to allow UPL to change to 64-bit mode later
+	qemu=qemu-system-x86_64
 	suffix="i386"
 	if [[ "${bitness}" == "64" ]]; then
 		BOARD="qemu-x86_64"
-- 
2.43.0

