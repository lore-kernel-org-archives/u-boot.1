Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEF6C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 13:58:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B81348144A;
	Wed, 16 Apr 2025 15:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bL+a3xpB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15C4E82E34; Wed, 16 Apr 2025 15:58:04 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE77980944
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 15:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so5283435e9.1
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 06:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744811881; x=1745416681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eAgJNbjm6PTVLNRBjL1Y+EWtlgnvN5b4MEkilmjETT4=;
 b=bL+a3xpBcTmJ/zK3f0LlBfkrlnQyBn/fQWwRNxvQyjSgdFf7i1v1q9Yc1uG4NKEAXc
 C3s+ZImznA9ABz9V4nvqYN8Dt7AWQkMGJAVc/LEwRMeyvpGfgJKIyABjevwCXS5aAsCf
 8EiZQ6lorZGK4SzaoZzkE9xTaHwsCwFF8aaj1CfWgcAC/wL43xywrCzfXIHN3OVpEiOo
 HUtnOsVGbNKKDHozErI694c0dJC0sBLgz8y3DSzLXcJTGzrzHuhNQ8FDMDY+wHm2EGJg
 LIYZpGjsBhQSPUMqjyhkX1cRt/1ZaoY09HuOrTrLlXI0NorORrnqug06LbWQGrHXxuQW
 xSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744811881; x=1745416681;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eAgJNbjm6PTVLNRBjL1Y+EWtlgnvN5b4MEkilmjETT4=;
 b=YvDNfXsyjjC7pEO27v00pRsKUg2UGq92hIqa55VpX8FNqHCAhgJO9aaji4lYbW+dKA
 U3OyPNK/6ebvN3sLvmUha3EUKgZeIdv09DSYmsjBvbx6+0Q6+catfIaZwlLbPWTSOVJ9
 NTLPyveQT4NcAxC93503LPjIGPjUIeJi5RtZ5Tp1xv9ktG40LwOHXo6Rp/L2Gux1nJZH
 RWKTmYF2N6z3+g16cRZdzx//tgz4YBxbwTHuS/Ad6bRYOBEeK3W8+c/BkoV5EJxegkyP
 w6e+fqzT5nmyFvhPMVQQUG89+B1IA+VLAIdFH1fQdGW+k8551K0DfwEWnon7coH1HprW
 XXtQ==
X-Gm-Message-State: AOJu0YzpCexX5rRqdYL/iCPwsmH4XcvwtoACkgNaAD4N8rUYoiJEdqCn
 gx5iXxSXI3BP+N9IqMzssWzmYJ1puJvxWqmVjAU12uzuCNH2yTSUWMgAUiOOof00FNaoAQHqpdb
 1tFM=
X-Gm-Gg: ASbGnctqGekCK5XS6pVDaq6QB1G7pm2svFmqBHrFXvOuPM8T5UVO9WLmQD/lu6YUWrv
 0ulMmpNlr1zUgtKukWjzqp7DEdwu+XQQi1SOU0pRyrthlsGTuE9W6t5v8KY26usT21aAZtOLmVs
 T1IIVz8TlweCflKfHRnPxEagiI4h5q1fw+4uH4ksgo+5VRQTor10Yx6qgC2vGP2/zv6R1uDQk+C
 XA4WMCcy2Lu6eDXl2kX27Ok7YihJL+81woWf54A+Kp5ydp8CzMy7LIXTL9I6qC0YDMGoaXeGryQ
 T/gG8f4iB9aASNWwcgt5Va6/SaUDgD4g4fSMqO9ZTgHtGgtw
X-Google-Smtp-Source: AGHT+IE/7YfYnrCq0x6ahAP5wnx3ENo0H7zZCbGRmZFQKTXh+3taEfweL8qhcVP2oOhvSqGXn0jH/g==
X-Received: by 2002:a05:600c:5490:b0:43d:16a0:d98d with SMTP id
 5b1f17b1804b1-4405d7c5282mr16406225e9.15.1744811880972; 
 Wed, 16 Apr 2025 06:58:00 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7ba5:2291:675f:52e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b5437c7sm22013765e9.39.2025.04.16.06.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 06:58:00 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v1 0/2] Enable UNIT_TEST for all qemu* generic targets
Date: Wed, 16 Apr 2025 15:57:29 +0200
Message-ID: <20250416135744.1995084-1-jerome.forissier@linaro.org>
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

Enable CONFIG_UNIT_TEST in most of the configs/qemu*_defconfig files
to increase test coverage in CI, and fix what needs to be fixed.


Jerome Forissier (2):
  test: run some test commands only if HUSH_PARSER is enabled
  configs: enable CONFIG_UNIT_TEST for all qemu* generic targets

 configs/qemu-arm-sbsa_defconfig      |  1 +
 configs/qemu-ppce500_defconfig       |  1 +
 configs/qemu-riscv32_defconfig       |  1 +
 configs/qemu-riscv32_smode_defconfig |  1 +
 configs/qemu-riscv32_spl_defconfig   |  1 +
 configs/qemu-riscv64_defconfig       |  1 +
 configs/qemu-riscv64_smode_defconfig |  1 +
 configs/qemu-riscv64_spl_defconfig   |  1 +
 configs/qemu-x86_64_defconfig        |  1 +
 configs/qemu_arm64_defconfig         |  1 +
 test/cmd/command.c                   | 31 ++++++++++++++--------------
 11 files changed, 26 insertions(+), 15 deletions(-)

-- 
2.43.0

base-commit: a08425586799374ccded78eb5fdef6e2235e1ad9
branch: qemu-enable-unit-test
