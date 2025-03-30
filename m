Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D46C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 16:24:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1A778171B;
	Sun, 30 Mar 2025 18:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lximbM4h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E89D081D3B; Sun, 30 Mar 2025 18:24:32 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFD0580FDA
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 18:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8CD523FE38
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 16:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1743351869;
 bh=4WXivJ1JToKzYpvnHsUKR9J8WtmoDUhrUAD8/glakd0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=lximbM4hypG09gA7e3ZxV4ER/3bvSNIf1ehZ2sNaxzu/IxcBf6zg30bpf1D9wmhUE
 3PvInokt2EXLU9acKu73q+1XubyQ1QGbAXeto4ON27/yKYrWBOWOG8tOqiWIa+1aMn
 EIA9vva8t5oMjIzJs/VakrmhcewQqTQYMlF4HEo45x7NYQgbatoWTzb8iTC6e1jz8p
 JSasZ9jglLhEUH9r9DQ4D+xyzgV3U01k8ATsT/7Jq+Sgr2VWPrtiV+U3bnvvfCSTqt
 yjyrPaBy7aodhHWANKezuRjiQWsLurwmbJgc578UFFSONtuGBoP1mYjBaD0J0UHiws
 x2xN65Dj4P+/A==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3912fc9861cso1464883f8f.1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 09:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743351869; x=1743956669;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4WXivJ1JToKzYpvnHsUKR9J8WtmoDUhrUAD8/glakd0=;
 b=dFy7n4oKBRp4lnczGIr6DISOGd2nqxriQVgIAK64lwwqX3q9y++cOj+IlkzeehccIh
 3tSHHWOCNLpLZuq4rd2hkxdZ0WCLOapEgRdHWRI72E3Vl2ikCAlzpTYkH1RPmJxrJGAu
 DJ55boYwFwFfEpyWOJFKScsA0HoONkBkswo98eTeWrzDjKS4qq9tjKyTBcdabj2bDUdB
 HoKn26tW0901vPTqTstqqd5RCmS3GJZ6WcDYVY+HEWpY2TufD3FHc4HR/hloQeqi3rtt
 +IVtEHnPHrod6DUiYMAZ9T9vEXvDIR8vBtZVD44QNVKbDrZkqEODeSAnrVGJSLXlH59F
 WHmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH1/tillBaTdGq0bSbXWoN5e2owPAXH+y+V2iT+TX8Q2U5sOaMT/us8wcyKapWpCvK35bq1P0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3L+JWi5i4Z4MRZU39fCal6Pi5hD8z4NXoXyf6Ej6gW21X7tYt
 LGqdOdvGYcYxdadZXEew94OCfgUlsFcry21VWOG9QURzj1l3j4DyohdMmIR4Ns9MEJUc3IcnAkf
 GwwR5auq74De3ayMP/Xmj4A6zR60bbPr2IYjaFQeQAQdTgM5lyszvm6JMZ+L3PJmwI+4=
X-Gm-Gg: ASbGnctu1zLYscoykqpO+cq9gwNF3jCC5JG9DotRAKjrlK7GriOAYORi+ZyTgqpgMkA
 JJ/dkXu+8N/1suTSsyrGWUQNMzbax86iJHw2UfEZkJDdi10CwVFBsuCPxrDRI5REX6rI5YsUkkl
 ggFX63OhCCEVoYp6X0WSIbl3LeCTIgyhyj3vhXR05F41fb68SPl4GPt+QWMLXck4BjTfILitGUD
 M7h1vunkQn8gdze1/84wdV1zlNKGsWAiusKYWuhWw6cFG5he2CCcl6PHgqh3fKKH95/zV2/4CIZ
 mfGpu6/vWFR+pkXklSGleQJg/KfVAEBSOnM+kXCriDo7uOrvE5qDu4UW219Vv+D1CEpdTNzHZiu
 QXHLVEHbbu9mmXelkhA==
X-Received: by 2002:a05:6000:2102:b0:39c:1257:dba9 with SMTP id
 ffacd0b85a97d-39c1257dcbcmr3664432f8f.57.1743351868854; 
 Sun, 30 Mar 2025 09:24:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG0SJ07DLdJcVjoKwWvKk8yNpSpug0jC5gpVYzfejqLdj/rdWZpZohkEoiNEEW0vA2/KkBDw==
X-Received: by 2002:a05:6000:2102:b0:39c:1257:dba9 with SMTP id
 ffacd0b85a97d-39c1257dcbcmr3664418f8f.57.1743351868434; 
 Sun, 30 Mar 2025 09:24:28 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6630a3sm8941956f8f.30.2025.03.30.09.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 09:24:27 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, E Shattow <lucent@gmail.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] riscv: dts: jh7110: add bootph-pre-ram for &pllclk
Date: Sun, 30 Mar 2025 18:24:21 +0200
Message-ID: <20250330162421.238483-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

Since commit f98cd471f06b ("clk: clk-composite: Resolve parent clock by
name") the StarFive VisionFive 2 board fails to boot.

Before that patch the SPL debug UART showed warnings like:

    clk_register: failed to get pll0_out device (parent of perh_root)
    clk_register: failed to get pll0_out device (parent of qspi_ref_src)
    clk_register: failed to get pll0_out device (parent of usb_125m)
    clk_register: failed to get pll0_out device (parent of gmac_src)
    clk_register: failed to get pll0_out device (parent of gmac1_gtxclk)
    clk_register: failed to get pll0_out device (parent of gmac0_gtxclk)

The &pllclk clock needs to be enabled early.

Fixes: f98cd471f06b ("clk: clk-composite: Resolve parent clock by name")
Suggested-by: Marek Vasut <marex@denx.de>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/dts/jh7110-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi b/arch/riscv/dts/jh7110-u-boot.dtsi
index ce7d9e16961..a9e318c4a31 100644
--- a/arch/riscv/dts/jh7110-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-u-boot.dtsi
@@ -102,6 +102,10 @@
 	bootph-pre-ram;
 };
 
+&pllclk {
+	bootph-pre-ram;
+};
+
 &syscrg {
 	bootph-pre-ram;
 };
-- 
2.48.1

