Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E53C7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 19:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ECD981FEE;
	Mon, 23 Jun 2025 21:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NCMm/KH3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80A558210D; Mon, 23 Jun 2025 20:13:03 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9596C81E13
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 20:13:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vtpieter@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ade30256175so800320966b.1
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 11:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750702381; x=1751307181; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s9QcYNdSrGIUweoyZHEBK/csZMf3G3ug65tYQlC7diU=;
 b=NCMm/KH3TFoQ8MmarIEGbMGv6cmelcypDxxC9hfd4c2/KuvSCR6AYuRuNLegFEYopJ
 QpsX0Vcacx6qaV5bG6HDGMyR4D1+sOsPw6KXV4CFHj1GI26VW6viwDVVYLOJecBfhYQP
 5voGycLdn/RC4mMEzbuNZYbViRaICeD1U0wW1pR0gjhtQ88ud0kUm4JRRq5gDnf4TWhv
 icZRDtv0JkMbZZwEhKg0/amvW8VX8YiiB/BNzsCAFynLA2F+By+F/q/diie2u2eFqQwv
 TWhkuTfNkQ5kaC71KMlhcvc4G+KXy5+Dg2libf6WktF22aT8llChyW0lrJNFDS7RLiEt
 0HmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750702381; x=1751307181;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s9QcYNdSrGIUweoyZHEBK/csZMf3G3ug65tYQlC7diU=;
 b=IUJ5M5CrVz5Ook6wqzmpMF70Yrt4F4Niw6vdvO7XwbLRmJ4j6ybn/6yEo5IDp9bD8k
 cWOppc7FwVpKzy9BkfwNph29CeNFejL+M6WMHzZx257RPbK3D12SfHHRM7uuYB4ZhF2L
 HFuP+McyiihoWjgRn55lFGnQ/awohnB6+fVesT13fiHnZ9hM415LCxnFuL+Sih7MDDRJ
 6xlTqKOTwZCgiWYOavZA4jGqa8FlOgLjS3Vg4bUSLT7UmW/bByKqf4R7048W4nDb/V/8
 EuXYSwY50Am7c0bwVhxKuCchuoKi6fHBezCxWYYgdmvdbGJALZbaW2DZ6wDQSPyJtmKt
 aNIg==
X-Gm-Message-State: AOJu0YxBmURg4cKzfNJvWUeomZHrWIWKzOHuuheeT6WRUFVu5yMKYtxJ
 6y14BDPr3J+Kamocn7ZggDTINssUjO0u/ljPw5A8b1xvPWGkRpX/xODE8br/fA==
X-Gm-Gg: ASbGncsTBlf699v61zfZ4kCsr2reltg6wTB5r3vXFXG0QYX11se7t1F89kDXdolzEuY
 /iAk/PQF6CBJNIm3vNkuznCctlrvn1k7s4dWybI0dyRppFWbUDhLvHJlWZUCNAnzgNKX2mCwy3K
 reFi+GQqEJIQQY3/XWvURx5LezT8uMcZ8V0S6g8RfKiAMeeN1QQEmFnL1+skgdB3zCuW/U32FIb
 XXABQnVsHVNPYiSS441MoK/ITUg4l+PaAKTdfWgdhCVuqOI/KkUToJTKw1HNPSVUKcd195QLSZy
 XNnvNZfeyquf8YJoa4aOsWq0CyDMlsCnrgPQ3vjL+mzucId47SLBEXDIFx2WGUUD
X-Google-Smtp-Source: AGHT+IEac+7k6FPEMPBUCORqQ1JOTZSbCdqwR57v8gGl01r2d/eON5yGiwBuT8JXpZBeQNgTuBZHSw==
X-Received: by 2002:a17:907:3e8d:b0:ade:32fa:739e with SMTP id
 a640c23a62f3a-ae057953290mr1326159666b.2.1750702380590; 
 Mon, 23 Jun 2025 11:13:00 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.cern.ch. [2001:1458:202:99::100:4b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae0a18d9887sm59955366b.11.2025.06.23.11.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 11:13:00 -0700 (PDT)
From: vtpieter@gmail.com
To: u-boot@lists.denx.de
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH v2 0/3] Improve user feedback in case of FPGA bitstream load
 failure
Date: Mon, 23 Jun 2025 20:12:16 +0200
Message-ID: <20250623181222.1539194-1-vtpieter@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Jun 2025 21:13:31 +0200
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

In addition, a new defconfig was added to facilitate compiling
fpga-based sources and various compiler errors and warnings have been
fixed.

v2:
 * use log_% instead of puts()
 * harmonize user feedback format; remove useless strings
 * add a sandbox_fpga_defconfig; ammend fpga Kconfig
 * fix various compiler errors and warnings

v1: initial version

Pieter Van Trappen (3):
  Improve user feedback in case of FPGA bitstream load failure
  Amend fpga Kconfig and add a new sandbox_fpga_defconfig
  FPGA drivers files - correct compiler errors and warnings

 cmd/fpga.c                     | 101 ++++-----
 configs/sandbox_fpga_defconfig | 391 +++++++++++++++++++++++++++++++++
 drivers/fpga/ACEX1K.c          |   1 +
 drivers/fpga/Kconfig           |   1 +
 drivers/fpga/ivm_core.c        |   1 +
 drivers/fpga/lattice.c         |   4 +-
 drivers/fpga/spartan2.c        |   1 +
 drivers/fpga/stratixII.c       | 131 +++++------
 drivers/fpga/stratixv.c        |   2 +-
 drivers/fpga/versalpl.c        |   1 -
 drivers/fpga/virtex2.c         |   2 +
 drivers/fpga/zynqmppl.c        |   4 +-
 drivers/fpga/zynqpl.c          |   4 +-
 include/stratixII.h            |   6 +-
 14 files changed, 518 insertions(+), 132 deletions(-)
 create mode 100644 configs/sandbox_fpga_defconfig


base-commit: dbf7fd557a73ded3141db3c2cf5c572989378825
-- 
2.48.1

