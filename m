Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8D0C021A0
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 02:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDE1A80F0B;
	Sun, 16 Feb 2025 03:04:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xxd6w8K1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDFA980C7E; Sun, 16 Feb 2025 03:04:11 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C3B2801B0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 03:04:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-8550803e1afso264422639f.1
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 18:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739671447; x=1740276247; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5MHvSNyUQKNyXRUyJwZ1GmQkZJmDkJwN13604/ZaeFE=;
 b=Xxd6w8K1ExUCna5PuEprzWnmbwBc/xCDVof+9zIdXU2+YGM1dA/AvCUc2Ht0+MQ1Le
 ALMbB+Xseig/y4hQnCnlA9WywhTqtz7pul6Hg+s73U5xyB08U/fChXLScXX6j1GNgBfE
 zXTvcxUrQO3gsedK0uQbY5E/54R07EoXe1udI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739671447; x=1740276247;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5MHvSNyUQKNyXRUyJwZ1GmQkZJmDkJwN13604/ZaeFE=;
 b=A1qkO5kJx10g5JhYQK81SebYtkAp7oAX56XWamX21LbvwaIIKNxdms/IiCbku9c+ta
 krRfNtn6wLTGREhEnN5/d65ooDZ3oFUws2voQ+H+Vq5VCVQgKRur0cNLuEhYp+mKV5U9
 rw9vjOouYd4Y2ir5ECNIxs52/Y7sfM+0b3P9jIu/S3uXp8AeTz9fVm1/9CrriFEL9VL2
 ugR5GOW7ZMcKI17TcaV+372UXtLOiQ88I55aByya8sqbESFoks1zefAto9dp0ASVswTI
 tM9yk7vHKDp/d2PSP1zU/LE8HI9uG4onmnDkbZoaT018YCHD67ksPAn+6a8K0+FfjW1D
 Tmtg==
X-Gm-Message-State: AOJu0Yy2a0mtLT6zXmTBEYgaL0DSBJ3QkRnbSnUVqvDrfiA9QhdXsV74
 MHiOPZEutX7nwuutfN2ak4G6dVkEuvnmGHQPSk5GewoBRdrRhFvdV0p6rZergsgjDLJZQBahJ6s
 =
X-Gm-Gg: ASbGncvBlPaPB13HzoyocaEM92fIhFBd6Y0JUJapO/+wq5iBBmv117S38FX1G0NUd1Y
 70uMKbevPEq/Dxvc8iUtTwBXz5z73qYNmaHam9BlUk38KLObGO+Gd0MWS8jRD0/kbTKmP/yAbRc
 Xy3yY5GgMa10zxFMey74FVO3cR/YLbLPUS6cH10sNKJihevSRT9g1V2MQD2K2GDXDQnI0sew06j
 nJr0rvZdrZu2q0ZglbBTpZvuS1IN6p3d1rxO5mjR0GkGw4dBw5KzNH2TpgvOOKQizBDzDfL7f1D
 YmNCgpPyTkg+AAvyLvmaojpSgd5cKmGILZ0J+jsHA0xH+AhaLB9/
X-Google-Smtp-Source: AGHT+IGcPHLsmNn6ybnpiYX7ny6mdtuLsonLizG0Ch83Ms5xyID7OVrldKqXrSQrM7gzwTjitpCyBg==
X-Received: by 2002:a05:6602:6408:b0:855:5072:d940 with SMTP id
 ca18e2360f4ac-8557a156632mr352197839f.13.1739671446893; 
 Sat, 15 Feb 2025 18:04:06 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85566e63bb7sm133525339f.25.2025.02.15.18.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 18:04:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/3] binman: x86: Tidy up skip-at-start settings
Date: Sat, 15 Feb 2025 19:02:34 -0700
Message-ID: <20250216020359.3878546-1-sjg@chromium.org>
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

A recent series [1] adjusted how Binman handles the skip-at-start
property.

This first patch in this series fixes a bug in coral due to this change.
The remaining two patches remove work-arounds which are no-longer needed
on x86

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=441782


Simon Glass (3):
  x86: Stop working around skip-at-start
  binman: Read the skip-at-start value on startup
  binman: x86: Write skip-at-start when end-at-4gb is used

 arch/x86/lib/fsp2/fsp_init.c  |  3 +--
 lib/binman.c                  | 16 ++++++++++++++--
 tools/binman/etype/section.py |  6 +++++-
 3 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.43.0

