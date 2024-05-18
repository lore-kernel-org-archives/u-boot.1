Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30838C25B74
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 03:56:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C8788858C;
	Sat, 18 May 2024 05:55:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="z6EC9Lkh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C0CB885DD; Sat, 18 May 2024 05:55:44 +0200 (CEST)
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::bb])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87FB2885DA
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 05:55:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Envelope-To: contact@jookia.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1716004539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wyNvppSTGhn3wUe60kYllC2fo0OEcJtGHNM0M+J5nMM=;
 b=z6EC9Lkh8SLMkW2aRcHJiJ0gzkmtNhOn2d/E606YTukgBOTbnvwn61FujtoQ33PO02jSW5
 HJwfcZiL4Jo4TPu9Ufo3f9y/UPohFHhkJl/1al8B8qUoMy23YOO2v1JlBsmv7VS4eqnuDe
 0Q8+scNwVq+He0T2xvvT4zAMrKKzYUNUk4n0QSq9IiTVTDyzvi5bFQZ989o+3/LTvremLg
 GlmafdFVW1Z1Lau2l8jfuxi3EhD7xaC7/fU6WhXD0Vj97quB+/aApQnT9+ui5+uCHTtDzS
 Xeb5Dj6TncpM0mCSy65d8jCfGGublXDKRQPKZjvfcj79dtSNitxZeXValsa0CA==
X-Envelope-To: lukma@denx.de
X-Envelope-To: rick@andestech.com
X-Envelope-To: seanga2@gmail.com
X-Envelope-To: ycliang@andestech.com
X-Envelope-To: sumit.garg@linaro.org
X-Envelope-To: u-boot@lists.denx.de
X-Envelope-To: trini@konsulko.com
X-Envelope-To: andre.przywara@arm.com
X-Envelope-To: jagan@amarulasolutions.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
Date: Sat, 18 May 2024 13:54:46 +1000
Subject: [PATCH FOR TESTING ONLY RFC 4/4] sunxi-d1s-t113: Add D1 and T113
 PWM node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240518-pwm_d1-v1-4-311fc5fe2248@jookia.org>
References: <20240518-pwm_d1-v1-0-311fc5fe2248@jookia.org>
In-Reply-To: <20240518-pwm_d1-v1-0-311fc5fe2248@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1716004499; l=1822;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=PSaBpMnS9T028VwU+QHXnHr/+Tw6JnLA0lC3FVSUDE8=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAsn05rH7Gsr0paecBZ6YNJMD
 1vpagFtiHQp+7FlUqCL3RM+iMGFwpLp9Ekt0mvRmwfn0E7bcbYl2/WdioXM/8BQUAAPRe
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT
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

This is based on the binding from the as yet unmerged kernel series:

https://lore.kernel.org/linux-kernel/20240131125920.2879433-2-privatesub2@gmail.com/

Signed-off-by: John Watts <contact@jookia.org>
---
 arch/riscv/dts/sunxi-d1s-t113.dtsi                   | 12 ++++++++++++
 dts/upstream/src/riscv/allwinner/sunxi-d1s-t113.dtsi | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/riscv/dts/sunxi-d1s-t113.dtsi b/arch/riscv/dts/sunxi-d1s-t113.dtsi
index 822f022eec..92b6432f77 100644
--- a/arch/riscv/dts/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/dts/sunxi-d1s-t113.dtsi
@@ -145,6 +145,18 @@
 			};
 		};
 
+		pwm: pwm@2000c00 {
+			compatible = "allwinner,sun20i-d1-pwm";
+			reg = <0x02000c00 0x400>;
+			clocks = <&ccu CLK_BUS_PWM>,
+				 <&dcxo>,
+				 <&ccu CLK_APB0>;
+			clock-names = "bus", "hosc", "apb0";
+			resets = <&ccu RST_BUS_PWM>;
+			status = "disabled";
+			#pwm-cells = <0x3>;
+		};
+
 		ccu: clock-controller@2001000 {
 			compatible = "allwinner,sun20i-d1-ccu";
 			reg = <0x2001000 0x1000>;
diff --git a/dts/upstream/src/riscv/allwinner/sunxi-d1s-t113.dtsi b/dts/upstream/src/riscv/allwinner/sunxi-d1s-t113.dtsi
index 5a9d7f5a75..435a1e66aa 100644
--- a/dts/upstream/src/riscv/allwinner/sunxi-d1s-t113.dtsi
+++ b/dts/upstream/src/riscv/allwinner/sunxi-d1s-t113.dtsi
@@ -145,6 +145,18 @@
 			};
 		};
 
+		pwm: pwm@2000c00 {
+			compatible = "allwinner,sun20i-d1-pwm";
+			reg = <0x02000c00 0x400>;
+			clocks = <&ccu CLK_BUS_PWM>,
+				 <&dcxo>,
+				 <&ccu CLK_APB0>;
+			clock-names = "bus", "hosc", "apb0";
+			resets = <&ccu RST_BUS_PWM>;
+			status = "disabled";
+			#pwm-cells = <0x3>;
+		};
+
 		ccu: clock-controller@2001000 {
 			compatible = "allwinner,sun20i-d1-ccu";
 			reg = <0x2001000 0x1000>;

-- 
2.45.1

