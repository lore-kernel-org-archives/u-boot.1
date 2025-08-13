Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0F6C87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 10:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4AA8832DD;
	Wed, 13 Aug 2025 12:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Vo3ocvs6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBCE28331B; Wed, 13 Aug 2025 12:10:14 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A229E832DD
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 12:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 6B80920D0B;
 Wed, 13 Aug 2025 12:10:12 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aZCTnHscN_Y4; Wed, 13 Aug 2025 12:10:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1755079811; bh=teE0V3WEbCMZ8UJQLvTIn+6i/Zr/DHA74VT0mUSQFhs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Vo3ocvs6FPzTJOW8hpPtY286UAad7PgHUo+4y10XQfXwT+XeUzM7S3m9EiPvrlfvD
 l72FvbX+o0etzSBtDGSp8L4MnXQ/4zCQ8UntlbhHECMzo6/3kYdcPHcKMvLQNBk1ko
 wge1XXfnow80Zd2C618MA4PeFt3Z3nIGx5aSWAvWlsuWZFvZ00sR+zCthP4hRwsclk
 NFafgCXVFZFWiHiLaY6SlmXLOZLXwQ6LGTMSR97G4J3GRnhPliMaZ/M508rbfFL4R7
 tC5C59jq5wprZU6FHekE/DfceB20N+22mtIJCaTKYaL00CBabzGn9rQuoM5ilRewqu
 V0ZWHBDyy4ZWg==
From: Yao Zi <ziyao@disroot.org>
To: Yao Zi <ziyao@disroot.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Wei Fu <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH 1/4] configs: th1520_lpi4a: Enlarge SYS_MALLOC_F_LEN to 0x10000
Date: Wed, 13 Aug 2025 10:09:24 +0000
Message-ID: <20250813100926.51725-3-ziyao@disroot.org>
In-Reply-To: <20250813100926.51725-2-ziyao@disroot.org>
References: <20250813100926.51725-2-ziyao@disroot.org>
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

For TH1520, we want clock and pinctrl drivers to bind before relocation
along with the UART which makes use of them, since upstream devicetree
specifies pinctrl properties for the UART.

This requires a large malloc pool before relocation, let's enlarge it.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 configs/th1520_lpi4a_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/th1520_lpi4a_defconfig b/configs/th1520_lpi4a_defconfig
index 2763cbb428a..731fe378ac8 100644
--- a/configs/th1520_lpi4a_defconfig
+++ b/configs/th1520_lpi4a_defconfig
@@ -1,6 +1,6 @@
 CONFIG_RISCV=y
 CONFIG_SYS_MALLOC_LEN=0x800000
-CONFIG_SYS_MALLOC_F_LEN=0x3000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-- 
2.50.1

