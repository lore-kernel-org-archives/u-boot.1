Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125DFC83F17
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 20:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BDCC8352B;
	Wed, 23 Jul 2025 22:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l2BDi+kQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9D0483577; Wed, 23 Jul 2025 22:27:29 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 613E78313F
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 22:27:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-73e8cc38e80so685114a34.1
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 13:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753302446; x=1753907246; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=q1jKJAnghDlqAa/e4vruQ0azzTRywMSc54Y6/jQTCYk=;
 b=l2BDi+kQjgHs+4QbLUiXuMhBiZ/3c0MzbpkVWgHW43+F1+t7Nnnn+cqWyp6yaOHzKs
 TArAXGUjTA+iLiJue5w1V1UXJPZe56x/EzIo1AczoJIMUzRMe6IjR7qlJ+4ueDstekC0
 SH+l1KGmolw6lFMnHdVSle4asgNzU1YHM+358=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753302446; x=1753907246;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q1jKJAnghDlqAa/e4vruQ0azzTRywMSc54Y6/jQTCYk=;
 b=fLZYThANP0H3kUSQJGhx+HLGmOUo3MSBoUEkxc8JBi/3AoC4Tj+w19LbgdBy3vhoYQ
 NpfRs10gUV1YsPQkSkzIR+gO1+ZDegtLkFPHZSXPya8lTwBeCXunSq+3dZs5khKQL6v0
 1HmZbBvBSsPPwvuBdCJLi5yKl2W/+8cIDqIS3EO952Im6flloeauMCco0qSaOzbxH96A
 VInfFSLlScZ3pn1QIeVHiBnAI8BPUgJep4yfW+K4bZk+wEBiOEEAjZ1zfyvxNAFdjTCh
 M/ZOUcTOTWGQkeor99VDCwULLZvsYvQkngEVG3j+HnSmN5bmk669oGZVgWRSslfjdjxH
 Rh0w==
X-Gm-Message-State: AOJu0Yz4Z8RJZ+Ho8JBFVJPFXDs3NP1lk5pSpv6ZU0Wkxz10HuVWfL8H
 ZOmYxh8dse+7NXqtFZvCaTbS4COeoB8i28/nG8keCzJyyO12ExOwHc+Kd79JlXh/O61o44c53VC
 mkgx9Zp0=
X-Gm-Gg: ASbGncvqi0yebZ/KjPTCs0Co57uUroncPVqrIjxlMt0DXZm5Ix9eqLVdL5EnW/h66b9
 +2vRmnyXN6PbeAO7oKbiMScg20RKu8Pdxi8o4t9mmO60QYnuMVSuFenS++PW/r9mSqJfxmefek9
 GlmxKTJcue1qNMkm/zBUUugIQqzQAFrBf7DosyAUwA0hgIJPV4Zbx0vxDngXnfExAzsW9i2a8oR
 H4cSSv/P6skHJ9w1o17K1A+fxJtqd9lu97oD/QMH6Xc9AGPQJ+Fis6wFnngd/6u1+W5B5IOE+Id
 38qyQDxRdp3tTHYcDiCJx8+2QAqu2m2NauyajiQOxTB9i/Z0KDhBeQ5bfddI4MOrp99kGN2fCek
 ZaV1XBEORdKCHfmwbeqpe2Uz5Z2ka9M5teRIU/nbAzBQlNjccpl5p100J/1qhHEiQm3et3w==
X-Google-Smtp-Source: AGHT+IFKa64u2LMP1ythOiwRbiVKpgZ1naapJLj11D2K6y0HwJIxJd5z4asRFIbcG78Sd9PRwkNIdg==
X-Received: by 2002:a9d:7dd8:0:b0:735:a6df:babc with SMTP id
 46e09a7af769-73ebb838cfdmr5994216a34.3.1753302446030; 
 Wed, 23 Jul 2025 13:27:26 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e8354c931sm4158710a34.9.2025.07.23.13.27.25
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 13:27:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] Azure: Temporarily switch to GitHub mirror of
 u-boot-test-hooks
Date: Wed, 23 Jul 2025 14:27:24 -0600
Message-ID: <20250723202724.228868-1-trini@konsulko.com>
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

In order to unblock this CI workflow for the moment, switch to using a
mirror of u-boot-test-hooks on GitHub rather than source.denx.de.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index b3fd4ceef135..966a66ff5678 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -251,7 +251,7 @@ stages:
           # the below corresponds to .gitlab-ci.yml "before_script"
           cd \${WORK_DIR}
           git config --global --add safe.directory \${WORK_DIR}
-          git clone --depth=1 https://source.denx.de/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
+          git clone --depth=1 https://github.com/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
           # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
           # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
           ln -s conf.qemu_arm64_na /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
-- 
2.43.0

