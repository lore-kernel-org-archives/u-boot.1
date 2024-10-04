Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39230CF8852
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 23:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7425988D06;
	Sat,  5 Oct 2024 01:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728086214;
	bh=LC2dVoBJu3cIBzEkaDMa8CPywry2XCJxPj7EobxdSkc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0J1fJyjzsvI5DTC+RLt9IUQJiabFLHpuHayWPSUF2071xE2H56WOcz86VKElyNo1j
	 +/WgJCWCLN6RlZ2oUH4leqb6sQgyCdfcDk7k3ppUpVK7ZAyQjJ19JKWgupGgTg8tHT
	 +kg6pkqCKyjEMGJMhi0ASdnTiixrtz7ewayTpqUfvPIo/ZdKh6oY16TTMbPGhSLlEe
	 GW5bXykIdF3315F3YQo72NIU9LzD2Txgo4pdZ1JAqhqk0llZgxhaV1A6tPF6U5KkFL
	 8WfwD682OBmNo1CvKqSRocbtfopB7VHzxgkwdB3EnD7DUYBy5Y01626tyFgXDq729b
	 mmwajLM2vjYVA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 37AAE88B0B;
 Sat,  5 Oct 2024 01:56:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728086212;
 bh=LC2dVoBJu3cIBzEkaDMa8CPywry2XCJxPj7EobxdSkc=;
 h=From:To:Cc:Subject:Date:From;
 b=noN+8RnFv+/1uQPneOdOMh5SRzUU7xhhOgPefQgxRvQ36xP9iJ9iykV8GxQnUINDc
 UQVwiU4TN71ZkcOfnpKVYlGg50E0cuIZK/GLy2QmRzTIlp9mTWnRiu9NoHLtK6wiky
 3quHUj43T3OmvQEGCvf0coK3DUIeEqUnWt/q4swO4ga6NGt9zo5iiQ59xXnwGe/K0d
 HyHDogacSorWy0LLbGwkwuU1Z21XsPccg8tzIAloWsk59HIVQ8b7Wj2QNlMRKdB1tj
 Uh3coe+xgKewD0YDm4YXq3Z2+a4BAEgDHUxuOrJPj2Uq0knvjUkIA1tU5GUKMcptaJ
 OiJooYzEjqC2g==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2] ARM: stm32: Update MAINTAINERS file globs for STM32MP DHSOM
Date: Sat,  5 Oct 2024 01:56:21 +0200
Message-ID: <20241004235641.395703-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

Update the MAINTAINERS file glob to cover all of STM32MP DHSOM related files.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
V2: Use multiple N: instead of multiple F:
---
 board/dhelectronics/dh_stm32mp1/MAINTAINERS | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/board/dhelectronics/dh_stm32mp1/MAINTAINERS b/board/dhelectronics/dh_stm32mp1/MAINTAINERS
index 865588f5b8b..fdd579013a0 100644
--- a/board/dhelectronics/dh_stm32mp1/MAINTAINERS
+++ b/board/dhelectronics/dh_stm32mp1/MAINTAINERS
@@ -2,8 +2,5 @@ DH_STM32MP1_PDK2 BOARD
 M:	Marek Vasut <marex@denx.de>
 L:	u-boot@dh-electronics.com
 S:	Maintained
-F:	arch/arm/dts/stm32mp15xx-dhcom*
-F:	board/dhelectronics/dh_stm32mp1/
-F:	configs/stm32mp15_dhcom_basic_defconfig
-F:	configs/stm32mp15_dhcor_basic_defconfig
-F:	include/configs/stm32mp15_dh_dhsom.h
+N:	stm32mp.*dh[cs]o
+N:	dh_stm32
-- 
2.45.2

