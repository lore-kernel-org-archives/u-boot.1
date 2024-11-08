Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4A6D5E12A
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 05:23:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46EDE891CD;
	Fri,  8 Nov 2024 06:22:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731043325;
	bh=PFpL1/hcZ28idJdkT6kJmtslUqSl3wse+U2HFjU2pZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YPA7wycZoNdIQjTv4ulMPaxg0VOogsh9A1wZXpAmpFT0AiM6+XRsBZDsfTufD8TR5
	 BmISIUgune+ySgTuQhnEtn9R7taUDIHZ4fu6zAUhvNBhaq0bDHi1UJU3QpNI4pkvd+
	 wTqB0a576Ad9BxGc77+qgPMH66n+QtpYAKHGPKadwjfxOnNjptO5mIBJSTRRxLsZVz
	 OWplOqsGtCkl7JtEfjrVvUHYp3/OkHfh7IowCvfoIwhrnhClFtDvMztn3Nws4UHOLi
	 aCvvwQmzsXZ7sq6WEq9IwdahN15FkpOQYCDQ3QzbaBTXeF3Mglf6+g1azMZeqkLF6o
	 a4GLTuvbK8VSQ==
Received: from localhost.localdomain (87-97-112-21.pool.digikabel.hu
 [87.97.112.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A30A488E3C;
 Fri,  8 Nov 2024 06:22:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731043322;
 bh=PFpL1/hcZ28idJdkT6kJmtslUqSl3wse+U2HFjU2pZ0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cay6tnhXqnrnGpt2yvE8iU/Fb1LZsyVA8dVbw0gd2VNw2cGAOnUxMH5CjtMtXasgZ
 BnIaftN/JF8oO895XNpvjS+NbgLgvoyqBxyYRgeX9TlYmtrfMQHm/e2EXDxj4m0ZaA
 PAKxrHGZgKVw4WRDU5KcO5N5Eq2/Dq6AVAKNaKN0nBN4p/gh7u4IlIGxJPWDxqOmcK
 8QDAt2ASVh3CoUHCUqk/f5Rdo7NhhLWJoozArPzH/XIl41iM6miCy8gNUnso6mUK0+
 fjR6nIg3rnacOt5itjzMcQBY7vHQX8VQpv0ju6SZYXzb64rFLWbFD/kU0Q9pRb6d7W
 lbJ+qeEDC46PA==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Enrico Leto <enrico.leto@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 12/22] siemens: capricorn: add missing ARCH_MISC_INIT
Date: Fri,  8 Nov 2024 06:21:33 +0100
Message-Id: <20241108052143.26874-13-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241108052143.26874-1-hs@denx.de>
References: <20241108052143.26874-1-hs@denx.de>
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

add ARCH_MISC_INIT to capricorn configuration. Add
it in
arch/arm/mach-imx/imx8/Kconfig

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 arch/arm/mach-imx/imx8/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/imx8/Kconfig b/arch/arm/mach-imx/imx8/Kconfig
index 9a43beda6fa..bfe30bece52 100644
--- a/arch/arm/mach-imx/imx8/Kconfig
+++ b/arch/arm/mach-imx/imx8/Kconfig
@@ -60,6 +60,7 @@ config TARGET_CAPRICORN
 	select BOARD_LATE_INIT
 	select FACTORYSET
 	select IMX8QXP
+	select ARCH_MISC_INIT
 
 config TARGET_IMX8QM_MEK
 	bool "Support i.MX8QM MEK board"
-- 
2.20.1

