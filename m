Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3C7CCFA13
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 08:12:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C94F988E11;
	Thu, 26 Sep 2024 10:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="doEv/rOn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C729E88E3E; Thu, 26 Sep 2024 10:03:47 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7468988E25
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 10:03:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2f761461150so10208531fa.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 01:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727337822; x=1727942622; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k+td+bn1sYI2kmc3DCFaQ6qTxQDzn/n6yrNIueFnBvk=;
 b=doEv/rOnr10IDowK8XY13lqM637RRtmH4u2ymerojKtVDtvXi8EpWhu6+AazYtR0bJ
 rPpAZwcOLzHER93Lq2ctGGGxDC4uXV/warmVbQPA8V51Y0Fa6XzHk7xlwi+1jcgkTTtt
 Hd3NzN4oG6FtQJGh/J0ASROleJ2J7QSeQaQsUPJMxzaWXdSPFoCiF9zHDhaaLLbmjJ+p
 GPuwLC9SyiV3+IylD8V+FMamYq0Ehs47F5XfjtW2oCFobESVqPvzTLGXDgZy+KbtNrqI
 6B4LkzCT9t5rX8MtFLA5g9TrZyxCg+ZmysKZj0FsIkCnbO3ARueKfmx8kNC70JEj16pW
 TvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727337822; x=1727942622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+td+bn1sYI2kmc3DCFaQ6qTxQDzn/n6yrNIueFnBvk=;
 b=reBDcKtaM4OIKayHzgvZPJOEQlYI/3T+l1WR50tlp7RHV4hQB1zQznvmx4N2D7GR9p
 tBynBA4K4NoF/mr0pQ9ahfn8TyP6Z1jiw4ERPfNTJjcPm8bRd6A7XNjlYTbIHyczXUNr
 QOmsQl5K6FXbJBqzSf34keP8kgt0ZPW7G5a6x1U1xKjm1qeLOwoK0y3yYQjh1e8kchBU
 +K9Al4SsN4VzMkx8F2ZAxP94AEVy7dop/Za9Ql+6GQhY7kNqb4/lsufZ4ulc6vOO+1R2
 h9rcTN4BDuQxc7x3UP+EIskK4IiLV8sz7HeRr9FosV5CltBV7cct0KmYHsD6MS/4aPyA
 7b8Q==
X-Gm-Message-State: AOJu0Yy7nEyZleU4eJb2/UkZlQkI5LWfWp2yPMg8ST7038eSR+vm3Re9
 0/pWPoVK3Cz6jxH+nRwZza551PLCSIATFME+juNHCO8P6blRiuq/pr7mAp5hodozEnoqsgzGTDS
 HijI=
X-Google-Smtp-Source: AGHT+IEtiL6A+X6CMQ4LGDxeg7rMSKAwMAfDYoL6CEGkbrIlpm5koOFd0bVqreqj1K/05Bah+V1ymw==
X-Received: by 2002:a2e:d12:0:b0:2f6:62a1:25ff with SMTP id
 38308e7fff4ca-2f91604ced6mr37983791fa.28.1727337821640; 
 Thu, 26 Sep 2024 01:03:41 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 01:03:41 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 36/36] azure-pipelines: Enable qemu_sbsa
Date: Thu, 26 Sep 2024 09:59:24 +0200
Message-ID: <20240926080021.148031-37-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926080021.148031-1-patrick.rudolph@9elements.com>
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
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

Add QEMU's SBSA ref board and run tests on it.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 .azure-pipelines.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 93111eb612..2881851ecf 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -250,6 +250,11 @@ stages:
               wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
               export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
           fi
+          if [[ "\${TEST_PY_BD}" == "qemu-arm-sbsa" ]]; then
+              wget -O /tmp/bl1.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/bl1.bin;
+              wget -O /tmp/fip.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/fip.bin;
+              export BINMAN_INDIRS=/tmp
+          fi
           # the below corresponds to .gitlab-ci.yml "script"
           cd \${WORK_DIR}
           export UBOOT_TRAVIS_BUILD_DIR=/tmp/\${TEST_PY_BD}
@@ -415,6 +420,9 @@ stages:
         qemu_arm64:
           TEST_PY_BD: "qemu_arm64"
           TEST_PY_TEST_SPEC: "not sleep"
+        qemu_arm_sbsa_ref:
+          TEST_PY_BD: "qemu-arm-sbsa"
+          TEST_PY_TEST_SPEC: "not sleep"
         qemu_m68k:
           TEST_PY_BD: "M5208EVBE"
           TEST_PY_ID: "--id qemu"
-- 
2.46.0

