Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA365CF884F
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 22:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D24B88CEB;
	Sat,  5 Oct 2024 00:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728082781;
	bh=yL49SaTjX5GX0n3o7ITzjZYtQ3214Wi61ViMoMNBgrA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=o5S+BiqqPgIKmb99DZBvPwB4QEy/fnlVr7g3GCVeYzQ3/Y8Wd+g0QtfqrQMmytOkj
	 LTVVRDUBX884CO5sm3qqtptrcORHuDXmaHhE7hLH8EskGu21+ETNnCwUfmCHufF/5Q
	 YCZ7kdA5NDv4EFsAu65x+VzWTuyjxtosrIx4L79RVu8d9JQeJwEE/JzdQZNoJOKnZu
	 fwgi+sX/7GiwdW+28xzGDpace/dBhEgU1x49eGD7F9YhYXXYt6dBW0Lox7UsgLcsEy
	 cCQmwix4aHI18HXOg/tf+47X3muDVn8I7DAlZ6O2oWWry66Xo6wqkuAhs9JNUgY4NB
	 WNpWr/11y1oLA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 65B4B8899C;
 Sat,  5 Oct 2024 00:59:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728082779;
 bh=yL49SaTjX5GX0n3o7ITzjZYtQ3214Wi61ViMoMNBgrA=;
 h=From:To:Cc:Subject:Date:From;
 b=RQBv7qDClksqr9hvUXJBInAVk+ALRlF9nTF5yIQVCo2KuLRcIriJ+/JFp3V4drqsl
 AXgB1objrVdWjSPOeXw8r0aShU5fN8E6lDmUn898acaPNGYORyVRWiIScpDDmQRb/k
 ov5Aq4WQHZYqxhM+Bh+woGSILESqhjXyqWCtwrtw6gG90/6I49qNBtPbTmBwAVaVTo
 7ttCDb/6REyD0sg98uPt3RdTG6nUKiAlDTycepD7irgvX5jDAvSa9LpiCT/wKeToUG
 UraSh2grlezmFizUVCPvFjVcHZaqH3sQqZH/uU2VHT2qKV9736KEt9jN41Vw+LjeBN
 14hZDefuPDNwg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 1/3] ARM: dts: stm32: Duplicate cpu0-opp-table node into
 stm32mp15-u-boot.dtsi
Date: Sat,  5 Oct 2024 00:57:52 +0200
Message-ID: <20241004225916.361000-1-marex@denx.de>
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

The cpu0-opp-table {} node does not exist in upstream Linux stm32mp151.dtsi
file, in order to enable conversion to OF_UPSTREAM, duplicate the node from
current U-Boot stm32mp151.dtsi into stm32mp15-u-boot.dtsi. This makes STM32
DTs buildable even with OF_UPSTREAM enabled. No functional change, since the
current U-Boot stm32mp151.dtsi already contains the cpu0-opp-table {} node,
stm32mp15-u-boot.dtsi is applied at the end, and does not bring in any new
content.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp15-u-boot.dtsi | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/arm/dts/stm32mp15-u-boot.dtsi b/arch/arm/dts/stm32mp15-u-boot.dtsi
index fe56f05616a..66d4c40c6a8 100644
--- a/arch/arm/dts/stm32mp15-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp15-u-boot.dtsi
@@ -56,6 +56,24 @@
 			status = "okay";
 		};
 	};
+
+	cpu0_opp_table: cpu0-opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+		bootph-pre-ram;
+		opp-650000000 {
+			bootph-pre-ram;
+			opp-hz = /bits/ 64 <650000000>;
+			opp-microvolt = <1200000>;
+			opp-supported-hw = <0x1>;
+		};
+		opp-800000000 {
+			bootph-pre-ram;
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1350000>;
+			opp-supported-hw = <0x2>;
+		};
+	};
 };
 
 &bsec {
@@ -82,14 +100,10 @@
 	bootph-all;
 };
 
-&cpu0_opp_table {
-	bootph-pre-ram;
-	opp-650000000 {
-		bootph-pre-ram;
-	};
-	opp-800000000 {
-		bootph-pre-ram;
-	};
+&cpu0 {
+	nvmem-cells = <&part_number_otp>;
+	nvmem-cell-names = "part_number";
+	operating-points-v2 = <&cpu0_opp_table>;
 };
 
 &gpioa {
-- 
2.45.2

