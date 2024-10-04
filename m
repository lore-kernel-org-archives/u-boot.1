Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6A8CF885B
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 21:52:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC63A889C3;
	Fri,  4 Oct 2024 23:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728078752;
	bh=RVyuTUn67HA7hQbF+5Qh5gIYt//nUfRU5BmjQN1Fvjk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nzP1sNV1V6PqDkoG75VCWBTCUzVPCPIVgMh1256W12QtIQQegEdVW1SkbLg7AkaQL
	 v4ZASWBEwY4Ke3OHGr/UI0Li2SV9YVT4RemhoSHtkNNufE0rGozGSfDVNhqqlXbCJ8
	 GZ+x7VRFetju0FCCHveVy+Vio69/4TsqIRtGFK7U5+0Idqv9b01I7C3bi/RaRKF8q/
	 KJ4h2StGEFz1vEAv9ee/mpZD5ms5QJ/y0wCHZW7cCSBHfeWSn08vnOPpF1XyhA46Ez
	 V+0wFhL/ZAMmLKepFfrQjWZTm7TnXJ1e4vr/jKuV5Wo41ljVWxAIZV5Ko/tntvabk+
	 R34CXDbsBJAgg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E797E889C5;
 Fri,  4 Oct 2024 23:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728078751;
 bh=RVyuTUn67HA7hQbF+5Qh5gIYt//nUfRU5BmjQN1Fvjk=;
 h=From:To:Cc:Subject:Date:From;
 b=X53W/cpKDYZ+ui7NZWxIB/lgegIaze5IFBCOFogQJc9jbzYZ/45PlMDLNHQx9nVhD
 +JKq1XEjKBF1MfAqYJBRpHS0LNS+XXMja3uxIHLpU1cHitor1tfEUcz160y3vYTN8T
 NKS2pJfoK3pLBMofW/eawxbVbDb+DhQOhBA2wpoJzkyMfl9TevC8wRt4ULXQOkXmKz
 g7r8t4Ml0O3t9lwPClmLT/mFCLDfSnIXr/rvO2AXDPxLxEJ2jkBXSTBxF26M++ph8k
 XtHrtUdnmjjgx2nQMsreMy3rVr7FKyNbCIrD+44OfkodTHijuztSAaRYGjZyy00fUH
 2AIsaS8zBrNWQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: stm32: Update MAINTAINERS file globs for STM32MP DHSOM
Date: Fri,  4 Oct 2024 23:51:46 +0200
Message-ID: <20241004215213.252840-1-marex@denx.de>
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
 board/dhelectronics/dh_stm32mp1/MAINTAINERS | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/board/dhelectronics/dh_stm32mp1/MAINTAINERS b/board/dhelectronics/dh_stm32mp1/MAINTAINERS
index 865588f5b8b..d6c33c15aac 100644
--- a/board/dhelectronics/dh_stm32mp1/MAINTAINERS
+++ b/board/dhelectronics/dh_stm32mp1/MAINTAINERS
@@ -2,8 +2,7 @@ DH_STM32MP1_PDK2 BOARD
 M:	Marek Vasut <marex@denx.de>
 L:	u-boot@dh-electronics.com
 S:	Maintained
-F:	arch/arm/dts/stm32mp15xx-dhcom*
+F:	arch/arm/dts/stm32mp*dhco*
 F:	board/dhelectronics/dh_stm32mp1/
-F:	configs/stm32mp15_dhcom_basic_defconfig
-F:	configs/stm32mp15_dhcor_basic_defconfig
+F:	configs/stm32*_dhco*defconfig
 F:	include/configs/stm32mp15_dh_dhsom.h
-- 
2.45.2

