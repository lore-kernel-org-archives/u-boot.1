Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DABC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 20:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C60A98214B;
	Tue, 15 Apr 2025 22:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Hqu8BCpz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDB4282B45; Tue, 15 Apr 2025 22:49:57 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8A0881F7E
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 22:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso66123935e9.3
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 13:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744750195; x=1745354995; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RVzjfgJ1ruBE2K57l18rXYnXk9sZTfi4931s5vuETM0=;
 b=Hqu8BCpzxZLC7javYDs7cjiMJq1ZUj+adZUMXMz6eOgadqZV+9COM5RhjR6tpDb1Mm
 Q2sD4vkvHtvHdqu9hvz6UCVNkeAkcNwfmmKtAlrwvJUscisPTL9TY91/lbtjt5cMr4/1
 HPz5cRoYolmP4MkqWjn6Peoi+xqYUFMAiKZ1jJrgWAj652WFIk2TIZPIZUvWy3dhttja
 eVoKYR+27A36YGoY7OtlSqoYmflnTl5fzr+xsc2UqrAxz/UY44+9A5goQDUXKk/9BYcm
 HCVhgZk8TzdR2zx3oB/WDkTZrECkfEl9vcEA+6y7X5Y5TYQoF944HM5oSE+yHV8xC90x
 hgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744750195; x=1745354995;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RVzjfgJ1ruBE2K57l18rXYnXk9sZTfi4931s5vuETM0=;
 b=m9Z3qaoX5AdmAaVMdjFVmBVlrKtDEIqfscU6ZYPCFvreQkTnjv7a6TiKubthJndpNp
 FRiC/uhfxcoi+MTM4n1m/YyJ/trt6LlCOR//4N6YIBRXVXn52nYi4fCLIQmrpxIE0iuU
 UEZA+oijUPyd/KS6Cek9tAaNt6dVRTu+mCR+X7XmmgbXU3oAvMdYzUM5LIep6T4aFSjz
 0BhFi0Aqtz+FF1axI1wy/OJ23Qzo94R6+r4OrsUpbGLM+rF+VgOdzAZNyMq+hQtZBHSE
 y3vahByer5SxL59uQ1GazXWHD+64PpZ7qOiGE/AD4PXJOO0DsLtaIi4+B/e4ZoYcJ6OG
 rt4g==
X-Gm-Message-State: AOJu0YyxPa8zG4+IVU1rC37XA7dOTvqTBsr8T2sMWyKfvh0Q2ua0NVRh
 6UQfy6bdEFcJr/q4+b17EYOEe9KQuJZkhBRykfxYvdxGNolsXPqlfrr8Jfb+S4k8Pu9UGCoT0nx
 YHAU=
X-Gm-Gg: ASbGnctEWFZ1YcSIOEkS5WpkmMDd70dx9ySKgliLhb007KPdEQf1UE/6S6dg6ykH24s
 9ksQAAEXju/ORaXbmQLxp+LkcMd3ttT4Lm6gC2KFESk/4nEz+1ZPDQ+tWBMY1KoBJ+hCJLPmevW
 2wbgxfnUVYmhfkkCT6xclrT2mEB8R/S2Yq26ROjRsS2PeoEtvbKwGuVUW0UL5H/HAANp7y19bXO
 emEprsGyUD8Xb2DQkOl5YODbWC7/mFEhMmx31VKKjSwXr0jVR76p6w7vOy30HYGL0VsZeJ6Lkzm
 R0Gghu0AGJtfRi9K8Hd4B2E2krePZ9HLIR/V3BbfEvTeYzvs4Lmsrbm+65A=
X-Google-Smtp-Source: AGHT+IH0FDxxvDMZSYgucRpta9k+DW58F5qA4IfRtA/xpqVlutJJU46C0R1n1tFMikaLSILSuCGLjg==
X-Received: by 2002:a05:600c:4686:b0:43d:745a:5a50 with SMTP id
 5b1f17b1804b1-4405a02c96dmr4052725e9.19.1744750194760; 
 Tue, 15 Apr 2025 13:49:54 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b4f3ed7sm617675e9.24.2025.04.15.13.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 13:49:54 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v2 0/2] ut: fix print_guid() and enable UNIT_TEST for
 qemu_arm64
Date: Tue, 15 Apr 2025 22:49:01 +0200
Message-ID: <20250415204917.1250109-1-jerome.forissier@linaro.org>
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


There is a bug in the print_guid() unit test in test/common/print.c when
PARTITION_TYPE_GUID is not enabled but either CMD_EFIDEBUG or EFI are.

The first patch fixes the issue and the second one enables UNIT_TEST in
the qemu_arm64 defconfig so that the unit tests are run in CI (this
platform has CMD_EFIDEBUG so the bug applies).

Changes in v2:
See changelog in individual patches.

Jerome Forissier (2):
  lib/uuid.c: use unique name for PARTITION_SYSTEM_GUID
  qemu-arm64: enable UNIT_TEST

 configs/qemu_arm64_defconfig | 1 +
 lib/uuid.c                   | 4 ++--
 test/common/print.c          | 8 ++++----
 3 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.43.0

base-commit: 8c98b57d72d5e5b94ed064fe1041e51216165334
branch: fix-qemu64-ut-v2
