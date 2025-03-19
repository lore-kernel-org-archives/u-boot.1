Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B697C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 11:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA640810F4;
	Wed, 19 Mar 2025 12:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JfAdE2wS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9A408191C; Wed, 19 Mar 2025 12:59:30 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBD88810F2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 12:59:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf58eea0fso23544855e9.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742385568; x=1742990368; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o1LxAkN5axXrwoNx04Ff1ZMrfBFrMWqXzbS/ymyZ878=;
 b=JfAdE2wSVN4DTi1ltgzukZp1xFzraH5kANIzy0UPbc5zYGo8jhKEbftArs6ir67Hkk
 9EWmEcEBpNAT8IkVRuhkLhUFWIEVAL7aNyO6rbn2ypRH3S+DytsZnZhwE3DXCmdEBnua
 woHjq5VgVo0kf9DsS2dnLPXJX3iY+k0CmwKVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742385568; x=1742990368;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o1LxAkN5axXrwoNx04Ff1ZMrfBFrMWqXzbS/ymyZ878=;
 b=tMLF68FIKnbCfJGGtmrbWsgZ1z8//aSF5MFTgPyQbXaZmagPscZjNnsTN7dhd1YCyl
 L6uBXILDnaW+N5gYAUD+TmhxbPUfpcrG+DsEpArhrnedEqaicmeB6Rp2VVY1//X6BWex
 TGxdTZEWe47csCLN1eybt/WHgPLyyaXV+k5gX3RdmKmkODVScphC7UDL08pasLKyNNhh
 jQvPoxCsoZOxj+y8lkDehVTBG05ZWMXWoS7CNFsr2VtwQLUs4Xh1FBipwTggIZ1cWGtk
 g3TuQs/0HkBgYSYClmUuvmWFt0/4QWcKkugGocMW+hxFxTR21LFpajIBZeC71CIYD7Rd
 keRg==
X-Gm-Message-State: AOJu0YxP3vwIf9oXT7PTgnBZ7y3Wdpd3122lQwWNUVU+uFJ5+8gtd5Bx
 A2xKT2KpiCByDymsYZSBDTxbC2wc3vPAZ07UnmlkTVaZBl2T9JxhyFVa+NnAAgM535WCgwqsgAN
 g3w==
X-Gm-Gg: ASbGncv6NU5zokByMWMpQ6f7D+tVjd/ZQaK/Gl7v+TGFJAv51paOAMEoub9zzemPh59
 mJSgcR9I2dnkd+LT+vGoRXFChVzNO0Tv+2zjlYrQyc9x2BIo+tK8R7bEEKQ/FOExB6YI8qeATDP
 jhfXvBttPdAdeqdbVT3xTSfQyIgYwM02EmdxhE/A9B5RbSnpiI90ngoTz8jSvIW3l4lx8oO1KYO
 aU9UEhrQcryb0QzTxBgT41tR1Kebljtrr39Q5EvFBG8XViXjOklB92BxCFJJwquS5q/E879Q2xn
 8at7qELbv8AXOUKD243Kksm9keyiBQ4bL0m9pPcZYQ==
X-Google-Smtp-Source: AGHT+IFmg6+SCZIvsRkYWWyHvCb3px3T+rFv+JpyjCuPAa8WLWGdI0e5GtEZlRNJrjPlxQDIqpSzUg==
X-Received: by 2002:a05:6000:2711:b0:38f:2b77:a9f3 with SMTP id
 ffacd0b85a97d-39973b027e5mr1640294f8f.43.1742385567678; 
 Wed, 19 Mar 2025 04:59:27 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7ea16csm20606906f8f.82.2025.03.19.04.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 04:59:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul Kocialkowski <contact@paulk.fr>, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>
Subject: [PATCH 0/6] Test improvements
Date: Wed, 19 Mar 2025 12:59:02 +0100
Message-ID: <20250319115911.2204045-1-sjg@chromium.org>
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

This includes some small abuf and test improvements.


Simon Glass (6):
  abuf: Add a function to copy a buffer
  abuf: Add a way to printf() into a buffer
  test: Add a test for strim()
  membuf: Add an easy way to set up a buffer with data
  sandbox: Enable PHYS_64BIT for 64-bit builds
  lib: Provide a signed version of simple_itoa()

 Kconfig                       |  1 +
 arch/sandbox/include/asm/io.h |  4 +-
 include/abuf.h                | 32 +++++++++++++
 include/membuf.h              | 15 ++++++-
 include/vsprintf.h            | 14 ++++++
 lib/abuf.c                    | 49 ++++++++++++++++++++
 lib/membuf.c                  |  8 ++++
 lib/vsprintf.c                | 29 ++++++++++--
 test/lib/abuf.c               | 84 +++++++++++++++++++++++++++++++++++
 test/lib/str.c                | 17 ++++++-
 test/lib/string.c             | 31 +++++++++++++
 11 files changed, 276 insertions(+), 8 deletions(-)

-- 
2.43.0

base-commit: eac5568b56dc8d048931a0e0d8e0fe573176ae4e
branch: schb
