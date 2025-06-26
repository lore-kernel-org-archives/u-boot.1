Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA3DC7EE32
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 12:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D238082E52;
	Thu, 26 Jun 2025 14:57:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cwlPAiyw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 672C982D88; Thu, 26 Jun 2025 11:35:37 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1117780E9A
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 11:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vtpieter@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-adfb562266cso154903466b.0
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 02:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750930528; x=1751535328; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B44fRuYzf92yelObfrdtJdAMSvipm/ETtJdMuUR4vXc=;
 b=cwlPAiywB9dkaXfXKDZLalflWrbJmKZGfTH/FvzxE3ke28YqdZrL1grFFtnKbNSYON
 zgeGKPExLeZRcuRnd4zuyMGc7+atXqXFm90o3IIpTVtovsS7SeJ/GxdPEKcIDPffghQ9
 g5fOsWV36NWmzkCLdfWfbRSEOs7BnyM5WISjMXKmZDTuJ4nhrRDjyhD5xXnQX7OHRIAC
 PBSMD/zTNdOb17wgGvpA2qULqUN8cX0JObEBmPuw+Lul/KPMgbsF4YbAwY3XFAp8oOQm
 vGwvX+7gpvrZWeTi5cETl/k9OxSukXyS/pFpyw6LMMlkfG9pbPMDbg5tjnsjcP5rqexj
 0Zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750930528; x=1751535328;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B44fRuYzf92yelObfrdtJdAMSvipm/ETtJdMuUR4vXc=;
 b=v6yUMUtj1vF1yEJ+4wtLfornjP8WWEsxSVDAiqXzoypYDwn8dR5oBhDx3l6ifkk+zZ
 Cb/MF8d2RTHJrIdEk/ULL+n51NFdAX3UcVaqk1R5BtB5uyqX7Pc1x00hOP259dHFo8Uo
 llCZacVkUBUcUgj7UslB3qNzX/ccZ9/A8y9p7fl3mx0l1CM00fGRG5KeIDaZ2uFW6kkV
 v88IyMNYDurb3l/1WV3J36+KqXce6qknlxbar2vA4OSXkrCbXelFSDcDoOhf06RrkN0d
 Oy2QDsn23mu3VKeizi/1oBY/fOdEjEmtvU9s6yW8sN2uJWhzp/gH4WCbClOxg8ZvVWi4
 PdMA==
X-Gm-Message-State: AOJu0YyEZX/Wh7G7VHKdnMMJchbRAPGmKGLBgVHNm7n9vJ1AR7TMr/Jk
 eJq8A53+R9fU6SL0TH2fX905HZQyqD5Be/yqpL1Dv4S+Xdtq0FHMctb5aHyzyA==
X-Gm-Gg: ASbGnctPHBPX50SS0RiG41BE2SBrhL5yrsSPp0vDAv/YZrPCW3JjrEOUmv0fYMALqQr
 qnIPdoHqaNYERehpsA3PLRz0GnT/pT+K6Hg0oTvee7im3XoUdHcLhj3DmgsHncJ5jS2ydxXS7Am
 fI75swRD1FcK0P81/FRYUih+pRMWu9pt/Nd9Ueat2dexfQTJmxKfllgCQaYsXMTXaennKonB/Pl
 V3n86vcxKx5p87L+imRxIDPvANGwJ9dgcLjIcW3holb4Jm5qFY58WMr+opxfnkVSEMQ2ewXb1S8
 xDd+VBTG/g7JsEljHcWYWUaMYUtkNvhBneELlknip2t9pveiK9V8bVUz16CksRJH
X-Google-Smtp-Source: AGHT+IEeHOYdnvAMqEiNZGn2bHNoEGlSiWmF6zUXWTkLr/7rrg4t63ezu8Oz6cTo4NRPGeINhgGKqQ==
X-Received: by 2002:a17:907:97cf:b0:ad2:2569:696d with SMTP id
 a640c23a62f3a-ae0bec49fafmr628417966b.15.1750930528153; 
 Thu, 26 Jun 2025 02:35:28 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.cern.ch. [2001:1458:202:99::100:4b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae0d950eae0sm76670766b.149.2025.06.26.02.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 02:35:27 -0700 (PDT)
From: vtpieter@gmail.com
To: u-boot@lists.denx.de
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH v3 0/4] Improve user feedback in case of FPGA bitstream load
 failure
Date: Thu, 26 Jun 2025 11:35:12 +0200
Message-ID: <20250626093519.115655-1-vtpieter@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Jun 2025 14:57:08 +0200
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

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

The main motivation for this patch series is to make the `fpga *`
commands' return more explicit because simply returning the command
usage without indicating the root cause is not helpful.

In addition, a the sandbox_defconfig was amended to facilitate
compiling fpga-based sources and various style, compiler errors and
warnings have been fixed.

v3:
 * enable FPGA configs in sandbox_defconfig instead of new one

v2:
 * use log_% instead of puts()
 * harmonize user feedback format; remove useless strings
 * add a sandbox_fpga_defconfig; amend fpga Kconfig
 * fix various compiler errors and warnings

v1: initial version


Pieter Van Trappen (4):
  Improve user feedback in case of FPGA bitstream load failure
  Amend drivers/fpga Kconfig for FPGA_SOCFPGA
  Enable FPGA commands and drivers at sandbox_defconfig
  FPGA files - correct compiler errors and warnings

 cmd/fpga.c                | 101 ++++++++++++++---------------
 configs/sandbox_defconfig |  20 ++++++
 drivers/fpga/ACEX1K.c     |   1 +
 drivers/fpga/Kconfig      |   1 +
 drivers/fpga/ivm_core.c   |   1 +
 drivers/fpga/lattice.c    |   4 +-
 drivers/fpga/spartan2.c   |   1 +
 drivers/fpga/stratixII.c  | 131 +++++++++++++++++---------------------
 drivers/fpga/stratixv.c   |   2 +-
 drivers/fpga/versalpl.c   |   1 -
 drivers/fpga/virtex2.c    |   2 +
 drivers/fpga/zynqmppl.c   |   4 +-
 drivers/fpga/zynqpl.c     |   4 +-
 include/stratixII.h       |   6 +-
 14 files changed, 147 insertions(+), 132 deletions(-)


base-commit: 40e083353a1610276f12fdbe613bf12004452656
-- 
2.48.1

