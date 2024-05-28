Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E6CC27C43
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 22:22:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B780885D2;
	Wed, 29 May 2024 00:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XTwhAdku";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63820884DB; Tue, 28 May 2024 19:05:51 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6DB38844E
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 19:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liujianfeng1994@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f47f07acd3so9642805ad.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716915947; x=1717520747; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tyutPEpvl5BVcbdAsDb7NHG0/3uXq4tpfe5W7CpHykI=;
 b=XTwhAdkuDeExFVn7bTf0DKxj4gSHlMORuCsA52J+GJrz54EM/LSd0qEF/aZJXtCzyF
 z6jVWqoMwx93TRaYukR01HzQc8zCb28ZncxrQADTKSlahepIDiqGgvytMKNOC0Yhj7Ww
 U1FgCevc73H1gsLxA1kH2BbKSdQGJkYKG6qM8vRD+ocbdr08cLaoXAgQtu5j8uIwJBG7
 CABUySFNlK8ADy/7kL2QCDFOd87QpylARc22FT07c9oSxjNm8CPWFFJVB2+8v3Ln4+de
 aAPCTHkbyY3d1fq49q7HxBD2IpmipqafQy7XkaO4jJ5OItV+0ihc9qpHFzxkZHcJH6yU
 VXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716915947; x=1717520747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tyutPEpvl5BVcbdAsDb7NHG0/3uXq4tpfe5W7CpHykI=;
 b=mVb9M77jMu7uCSQcSDiqgk266BRoNV5X2Xqn/OkYtAQVc8SS/GJhYfCoXVB34zXgoT
 jNl8FNiQX/ZVnbNYF13eS+fkGBMMoyDtR3+XBTGneUf93nPiRS1kXH9ve3Cgf/Q9SQ8A
 srGlRLqnsZP9a7JQ4nJKM1UY9hEd4L+QdUHuJ7eeTjStQ2ZhVnvDpxvqmMb8E5Jnr1T/
 gwIn0COfVzcSRDpu9vYgMLJek4MmwNWO2NR0XDqkrRtWo2ylaT2jHoXVDm0F/WqhXNXG
 Vq/H8ym2+PzV84WVobLS2u2fnLdWgH8Wfk3Kj/QUYx2CSn27Xx5AqbRblBbH0PCLt6XW
 6sPg==
X-Gm-Message-State: AOJu0YyLGyvRHYASTFN29z2ZxCs709iElKVc7aAomTqeNPwzJ5eXZ9bg
 lceeCC6lIfa7VtvOW8SYSKlQW2mn+r4W0e1G/kljrrO8Luv5vYSLdnOYMQxgdZERsg==
X-Google-Smtp-Source: AGHT+IEqoC1KZy6PKWsocmFaj3JFR93XRIHt7+JGiI6y+6yudKhb++czu+O7evpCcnktsdkHlaLzng==
X-Received: by 2002:a17:903:1211:b0:1f2:fb02:3dfd with SMTP id
 d9443c01a7336-1f4486b95c1mr167868345ad.11.1716915947090; 
 Tue, 28 May 2024 10:05:47 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f47efff203sm53037705ad.241.2024.05.28.10.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 10:05:46 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: u-boot@lists.denx.de
Cc: Niklas Cassel <cassel@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 07/10] arm64: dts: rockchip: add rk3588 pcie and php IOMMUs
Date: Wed, 29 May 2024 01:04:03 +0800
Message-Id: <20240528170406.353616-8-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528170406.353616-1-liujianfeng1994@gmail.com>
References: <20240528170406.353616-1-liujianfeng1994@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 May 2024 00:21:20 +0200
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

From: Niklas Cassel <cassel@kernel.org>

The mmu600_pcie is connected with the five PCIe controllers.
The mmu600_php is connected with the USB3 controller, the GMAC
controllers, and the SATA controllers.

See 8.2 Block Diagram, in rk3588 TRM (Technical Reference Manual).

The IOMMUs are disabled by default, as further patches are needed to
program the SID/SSIDs in to the IOMMUs.

iommu: Default domain type: Translated
iommu: DMA domain TLB invalidation policy: strict mode
arm-smmu-v3 fc900000.iommu: ias 48-bit, oas 48-bit (features 0x001c1eaf)
arm-smmu-v3 fc900000.iommu: allocated 65536 entries for cmdq
arm-smmu-v3 fc900000.iommu: allocated 32768 entries for evtq
arm-smmu-v3 fc900000.iommu: msi_domain absent - falling back to wired irqs

Additionally, the IOMMU correctly triggers an IOMMU fault when
a PCIe device performs a write (since the device hasn't been
assigned a SID/SSID):
arm-smmu-v3 fc900000.iommu: event 0x02 received:
arm-smmu-v3 fc900000.iommu:      0x0000010000000002
arm-smmu-v3 fc900000.iommu:      0x0000000000000000
arm-smmu-v3 fc900000.iommu:      0x0000000000000000
arm-smmu-v3 fc900000.iommu:      0x0000000000000000

While this doesn't provide much value as is, having the devices as
disabled in the device tree will allow developers to see that the rk3588
actually has IOMMUs on the SoC.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Link: https://lore.kernel.org/r/20240502140231.477049-2-cassel@kernel.org
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: cd81d3a0695cc54ad6ac0ef4bbb67a7c8f55d592 ]

(cherry picked from commit ea9a34aa0d786cbf4b87f1ba528e69b07219738f)
Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

(no changes since v1)

 dts/upstream/src/arm64/rockchip/rk3588s.dtsi | 24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
index b0a59ec5183..6ac5ac8b48a 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
@@ -579,6 +579,30 @@
 		status = "disabled";
 	};
 
+	mmu600_pcie: iommu@fc900000 {
+		compatible = "arm,smmu-v3";
+		reg = <0x0 0xfc900000 0x0 0x200000>;
+		interrupts = <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
+		#iommu-cells = <1>;
+		status = "disabled";
+	};
+
+	mmu600_php: iommu@fcb00000 {
+		compatible = "arm,smmu-v3";
+		reg = <0x0 0xfcb00000 0x0 0x200000>;
+		interrupts = <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
+		#iommu-cells = <1>;
+		status = "disabled";
+	};
+
 	pmu1grf: syscon@fd58a000 {
 		compatible = "rockchip,rk3588-pmugrf", "syscon", "simple-mfd";
 		reg = <0x0 0xfd58a000 0x0 0x10000>;
-- 
2.34.1

