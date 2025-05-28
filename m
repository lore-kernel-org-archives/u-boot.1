Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2290AC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:33:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2B4183923;
	Wed, 28 May 2025 14:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H6zkGUsQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 709548399B; Wed, 28 May 2025 14:33:18 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46CB18004F
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-85b3f92c8dfso126907439f.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748435594; x=1749040394; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rtFvtt2Ujl5rTgt0jpI81ZHThHyg5TRIRCq025MoVNo=;
 b=H6zkGUsQ82w6FHLjjCoDGLKFgVpD0Q7AIeVZAN6AOZL//K/yrL4O9SIwdoabDqImPF
 S4UQYxSRPzuTA0FtTPESY+n1nXzq4TKgV3nkhTv3cK0AmRO8qyarAYBYSBB8/EICFpg7
 o+wVweayQEIsCpWCpcp+TMUD49x+ZYVxhw3zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748435594; x=1749040394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rtFvtt2Ujl5rTgt0jpI81ZHThHyg5TRIRCq025MoVNo=;
 b=TVb6JTxhAP3bQQ/lyHyXx+N2knqEOyUIRvSLgAYkc5HQNwOxMFVGNNFjlUgXtAs6f/
 tIAFCn210JxgHlbd+5RkKn5AOdPhq8Li9WbifN3771RF6Gn8jCiEBLDVJC4IIlxBlq2j
 c+8KkbPVjr1lZ1Po1EBmVsxturDNB7AedUPrp2isLmuO/RTJHc9ua5QGKfyxgN7l5QGS
 irMqOO+QcUd59iK8guuqIOglIcFO3JYXjKhDlDbm+tCAaELpgLCxoVeLr1eWmTKo2idW
 4rleO8NJmTUxRx6aNk6MMbeoPIt1V9yELgQ3rfbXnCswczeV0gKnetUgYMlY7YYXRR1U
 56kQ==
X-Gm-Message-State: AOJu0YwTqRfUPU6nTfHKqzca49ko8jPNDJcz3/RECTDH2/OtIj7QTjQS
 W/YFMsE7jvH95Kg0kIw506a6PJcox3igZVl7LMDD199gKQjHUE9uRzGC0TrjjZACDfn4IrN60Em
 E6Yzs1DmV
X-Gm-Gg: ASbGncswGPnXT4YvlJ3MilK07dat12kP4y5DhvrFdsEVHq+/qF5XGpWqAuOHXSOmDcg
 21UX1VtfkR/QCmI/Qsn+/t8Y+smTDtc1YyLF/mbXsGHz3dwvBinvEdg24h8q1EXhhqN/WtmmQiH
 hsfUQOcoRshqHGbuq/UA9g5MOFl5bTEfYuVDADPzN4b3reUvgyAXn76Q2PUUtIgK8gxBow7vxPH
 Ji4fvKnzmJyU9foPNVutV0NTbRaySaehMKjZB4Ru9px+BHa+bvaW14fvpiVMX/ChbfmVFdwWtvU
 1A5bnuGSembLFw01wc2Ogkli4TEZSFlnyTIUyl1RZdn8IlOK2Lldd6EKgs1SiNH1jlLy5Jy3jbf
 ICOEswRhYIVKR
X-Google-Smtp-Source: AGHT+IE4es9kH5RccOWhNEmXTbsWjxMBRu5oF4gdwt5fz0zzmRzlK1F6W/U/UXKIAicGDl23M4eedQ==
X-Received: by 2002:a5d:8058:0:b0:86c:cf7e:d85d with SMTP id
 ca18e2360f4ac-86ccf7ed9b6mr1189155839f.12.1748435594342; 
 Wed, 28 May 2025 05:33:14 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd4bb408sm205972173.58.2025.05.28.05.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 05:33:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 02/25] RFC: scripts: build-qemu: Support xPL with ARM
Date: Wed, 28 May 2025 06:32:04 -0600
Message-ID: <20250528123236.1138632-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528123236.1138632-1-sjg@chromium.org>
References: <20250528123236.1138632-1-sjg@chromium.org>
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

Add a -x flag to build/run xPL instead of the normal build.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Add RFC for test script

 scripts/build-qemu | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/scripts/build-qemu b/scripts/build-qemu
index 5798da3775c..8527e4b879e 100755
--- a/scripts/build-qemu
+++ b/scripts/build-qemu
@@ -61,6 +61,8 @@ def parse_args():
                         help='Show executed commands')
     parser.add_argument('-r', '--run', action='store_true',
                         help='Run QEMU with the built/specified image')
+    parser.add_argument('-x', '--xpl', action='store_true',
+                        help='Use xPL image rather than U-Boot proper')
     parser.add_argument(
         '-R', '--release', default='24.04.1',
         help='Select OS release version (e.g, 24.04) Default: 24.04.1')
@@ -142,15 +144,22 @@ class BuildQemu:
 
         # arch-specific setup
         if args.arch == 'arm':
-            self.board = 'qemu_arm'
-            default_bios = 'u-boot.bin'
+            if args.xpl:
+                self.board = 'qemu_arm_spl'
+                default_bios = 'image.bin'
+            else:
+                self.board = 'qemu_arm'
+                default_bios = 'u-boot.bin'
             self.qemu = 'qemu-system-arm'
             self.qemu_extra.extend(['-machine', 'virt'])
             if not args.kvm:
                 self.qemu_extra.extend(['-accel', 'tcg'])
             qemu_arch = 'arm'
             if self.bitness == 64:
-                self.board = 'qemu_arm64'
+                if args.xpl:
+                    self.board = 'qemu_arm64_spl'
+                else:
+                    self.board = 'qemu_arm64'
                 self.qemu = 'qemu-system-aarch64'
                 self.qemu_extra.extend(['-cpu', 'cortex-a57'])
                 qemu_arch = 'arm64'
-- 
2.43.0

