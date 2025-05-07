Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CC6C3ABC5
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 08:37:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0CF682169;
	Wed,  7 May 2025 10:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="gsP2yy+R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC9D08269F; Wed,  7 May 2025 10:36:44 +0200 (CEST)
Received: from sonic315-22.consmr.mail.ne1.yahoo.com
 (sonic315-22.consmr.mail.ne1.yahoo.com [66.163.190.148])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EA8B8007D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 10:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dullfire@yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1746607000; bh=I6n/UdZTRrDb9prcKFKx2/guBHBh6U/1GDfHxrXdXco=;
 h=From:To:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=gsP2yy+RxUyqDKNnJiIipqkP+azR9J61WB+PI39c8l77ZhVhiG0cA/I4nNjydEoYHyXZyTsmoXKzKJhHZ97jfDGax82Pv+C9E1ArDGF3FtfkQX7AdF4vDsTuNc9QlZFH/X9qj7BndXb9Ql6wlIlBELFRB4iiJteRLvEhKnLjiX4L8p8ieo6ucRnTQ5wFSV9TEo1LiJhDapYC8P1b2Z3mli02//eizN6qeVDwpzUofP7K5c4TuWFYuInkmbHJhwvRz7yJZdAMLYgU28hJVAOrUC+seHRnaUhbE0OzmRizIPVU7nJoHWFhOk1h+lA6VDzQ/Gi76L8x9YoFf6BYPruoSg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1746607000; bh=JLkdS4YERdS14RRGGKM9fPnJ3ezAZegFGb68s1qRwJk=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=EkGOoRAJ0Vsp83QT0aXUqMir+xtYq5/5d/THQfq/tF7GYdj0edrufVA8w67nlJazKpX991WsY7R9X24gPCVQe/1nS2BDEL3c9NdP8rGJ+npml40gE0XcK7wjj6IWCq2W1xoF/Ofe5ZHMfp7bd3lZ9rvqbNNmS4Ez4PdUp07WC4LylGGitdH+Fm708i+A7N+6kl7wPVLMFceluYTPVMAhYdl0valvo2NKO0VymrUD8JzSEMPdjTIHdmYYQU46ZmCJps/Bv/ORZqavzLVa2AhiFLXsQXYOPQzzFKuS1yS3OGNK5gFDJpwHGh5oDZRAG6uCVP4XOtg24RTsIsVMb9V8yw==
X-YMail-OSG: kkBGk00VM1kVALgFfrhrIB7dH3N2.OcghQ1FZt2EkKFWLHGflzFD7.kuzSPhP8j
 cMK2pNf3ZMbOSbF6hROHzva9rCcx8VpdB02NWir9NIWKG4GnwwCA89yCVEh4mCP9HM3i7.KRSmPP
 BWwwQfnG3rk8SAQ9cwXImMGw03MZO0sx4cyUbacPH0UE9m8k.bzERaAhGyExX5TmFZhysRsFl3RO
 tVccYNBo6cF9zUiw1TLFRe.Y4f5Azdh46uTpdeqjOkWIlGNaDLXRpPiaijC4ee6tx.T.If.k_PRD
 0QfFF_Xd5SO9UQOkPjST0jJoJ_w285iAyZvE9qZQJJMrBCouNcS47n0XnClCjt70WCQ5_rT52wnD
 wyHxnv3Psldqel7yB2qgdpyevg4K076CHXwVWN3qrIONZKI13EaQzpF2aE5udVyoSjhtlrLVv_CO
 PEh3kgNKaP4X.TIO8NeHVN9XCnuJ4f4.XdumYIRIUOXNzCbMmSy5_nZGbwVfnvP1OWHWPfR6d6hl
 8a0ETvb13Y4soynPlUc_KZ_EkTvGlQwYeWoc.BtSr9Zm1PMsW4pLXCXqW1nHvfkjqN_J1xNM9e1D
 cP6.dD8wvC9U_s72bA0ZPJg4gmtnJfwbmRBQgNvd74RcH50l1h75w1KLYrmglfEF1cn7lMt8HgSB
 1_Gr2NeICX_.9zY8IDctm9Gw8PHlrwPHtAGJRuySroqLYksM_I5il.3D18ij78s0VOPT9ZIfsbr.
 y3m6COiuCKqXHzE.HG4JV7.4Qwn3nrwqUSdRzse3B7Y7uZZqIlnWOsrNFpEp_BCebot1wXlqNWnE
 2L.P1eaIH7Cnu7NkwUERGHCu0Nh0WJcHVjTJfilZALpb8kHX5ikkYA8jweRz761.B6Ulzv7lEi9F
 vqu3TJLZCueUv8PmWCTNs51.5okrGrACg_vKYj9cwIDd9WDlOWEGgLM.pxtfax98v4zi6BqCJPBo
 X_hmt0GRv7XZW0BN8Kko7YaBF30dxOF41zgOOizzotyf.gr3dLl8ssDohxgDD4HwkjsvbK8jy6Qg
 5L613hxlIjjzbxrwYh3Vxia36GPR9ye._K2roT52EA09wc3CwQKAMe7HT8OaStE9N8cOPlkdSPsm
 Pj0t89pFE_oW3i9bu_oWNTU6ZdjtsbXpQk2u6ubJdgZqe0KJD.RAQ3Ty3p3E56XAnotLbC4WNV7h
 OJCV6.0vH3czRPKgzaSUlOO2rYgQloZHBImkzEIcxQG3.kQTiIHtbSZbkt8BMIGqbVpLeNyFkfOP
 XaZU9Ixgmip4mVNuNdV7mdCCFuxGq2JmSHm6yPs2wHfmVRcfdz3Bv5cTqubwddlGVEFb437EycnX
 3Ps3mJrUqzOvnRuS42x7YAWQHllt77Ly4a0LOvqRFG3I804w2CH.7Thfnblijk6j22Z8pXyJqaz3
 RcpIJIYrm3FBSFRdIbWK5SlrbDzKR6zISR1ycRlRniv8VXJm9KZZG8xMy9gLYFihyffQ9Nt4cN39
 oZk554U4TmA1OmWocu0Cn1Ro2_rn3gBfCshWmES9.rUJyI2YjRXArjMWWQVvE80hB.Q6Mlyb7WC7
 Pe5EfpohqafNQZBuxmcYzUtbdgvh3LqpSy7er4r6Cn3K2ch0qL339ixFcjVzZRln9nsVNzCuqfkp
 Z.ecHVhvJcdLrgDB0hUp76Tnpsg3T9QVWQLNKZ1HW.Y24AxuwIzBCIng.Q0Fft0EB0xMxZZ5UY7j
 L4C.wuvEVytcscJQGCqxsU1gKsxO8MTULTl4rBVPOpHr6x_7Zuz_77Ag8_2fLB6CjYJhNFk0fANw
 sE2THn07LnVRjetug2OGLMLPSycY7tJ7zdVLovVv7VRkT9VR5QQPRRVWDGSFgn9jGBLGJYheo_y.
 CtLeLGLJegfed86.LCrrE.m0TZqzpqcSpVUNeWYI7EBvZNm5wllRI8Jd2s0aY1zGOKL748fBfPwJ
 _MRt4Y7A2yNiDGMtKpo9HANWFvE4n1ZlwcX822hGfsO2jeYqhDj4V.lH6tcahwd7OOP97mQihPsM
 HW_1LMfDrOczoGjZJlA4gQSceZ0.FN6uZMAcnQSL1KuwaQAiC2EQO7Num687C6UlKf4aPVDpHt1R
 wSTJsqYjRbKmOTuKAPudMN048bRzdDbwXHMhmljlHjD99nbuwvJBmjOOVV4fE1LTtOl.Xc36ybVr
 szbfJWS9gl00SDvRruAoYgFAcsXSPJkkinYMBkuDblx09GM7l7T1OMgp_mkqyjK7Maae4UK7xHpV
 ts4DmCsSacDKyRSjObrUyrl7o_xsyKzGVwC9vO20TTew9b8VfOnJgxLM.Eg--
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: a8c17928-36fa-4abb-a7a5-a9d5cf6b858c
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 May 2025 08:36:40 +0000
Received: by hermes--production-ne1-9495dc4d7-vqkqz (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 8092b2f4bc7549cca4e38513a06ea418; 
 Wed, 07 May 2025 08:36:32 +0000 (UTC)
From: Jonathan Currier <dullfire@yahoo.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Jesse Taube <Mr.Bossman075@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marex@denx.de>, Frank Li <Frank.Li@nxp.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Mark Brown <broonie@kernel.org>, u-boot@lists.denx.de
Subject: [RFC PATCH v2 3/5] ARM: dts: imx: Add flexspi (fspi) to imxrt1170 and
 it's evk.
Date: Wed,  7 May 2025 03:36:22 -0500
Message-ID: <20250507083625.6195-4-dullfire@yahoo.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250507083625.6195-1-dullfire@yahoo.com>
References: <20250507083625.6195-1-dullfire@yahoo.com>
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

Signed-off-by: Jonathan Currier <dullfire@yahoo.com>
---
 arch/arm/dts/imxrt1170-evk.dts              | 28 +++++++++++++++++++++
 arch/arm/dts/imxrt1170.dtsi                 | 13 ++++++++++
 include/dt-bindings/clock/imxrt1170-clock.h |  4 ++-
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/imxrt1170-evk.dts b/arch/arm/dts/imxrt1170-evk.dts
index 0d8e7016860..354352477c7 100644
--- a/arch/arm/dts/imxrt1170-evk.dts
+++ b/arch/arm/dts/imxrt1170-evk.dts
@@ -234,6 +234,34 @@
 					(IMX_PAD_SION | 8)	/* SEMC_DQS */
 			>;
 		};
+
+		pinctrl_flexspi1: flexspi1grp {
+			fsl,pins = <
+				IOMUXC_GPIO_SD_B2_05_FLEXSPI1_A_DQS     0xa
+				IOMUXC_GPIO_SD_B2_06_FLEXSPI1_A_SS0_B   0xa
+				IOMUXC_GPIO_SD_B2_07_FLEXSPI1_A_SCLK    0xa
+				IOMUXC_GPIO_SD_B2_08_FLEXSPI1_A_DATA00  0xa
+				IOMUXC_GPIO_SD_B2_09_FLEXSPI1_A_DATA01  0xa
+				IOMUXC_GPIO_SD_B2_10_FLEXSPI1_A_DATA02  0xa
+				IOMUXC_GPIO_SD_B2_11_FLEXSPI1_A_DATA03  0xa
+			>;
+		};
+	};
+};
+
+&flexspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi1>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <250000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
 	};
 };
 
diff --git a/arch/arm/dts/imxrt1170.dtsi b/arch/arm/dts/imxrt1170.dtsi
index 2de775f043f..08665eaf06a 100644
--- a/arch/arm/dts/imxrt1170.dtsi
+++ b/arch/arm/dts/imxrt1170.dtsi
@@ -246,6 +246,19 @@
 			#interrupt-cells = <2>;
 		};
 
+		flexspi1: spi@400cc000 {
+			compatible = "nxp,imxrt1170-fspi";
+			reg = <0x400cc000 0x800>, <0x30000000 0x10000000>;
+			reg-names = "fspi_base", "fspi_mmap";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <130>;
+			clocks = <&clks IMXRT1170_CLK_DUMMY>,
+				<&clks IMXRT1170_CLK_FLEXSPI1>;
+			clock-names = "fspi_en", "fspi";
+			status = "disabled";
+		};
+
 		gpt1: gpt1@400ec000 {
 			compatible = "fsl,imxrt-gpt";
 			reg = <0x400ec000 0x4000>;
diff --git a/include/dt-bindings/clock/imxrt1170-clock.h b/include/dt-bindings/clock/imxrt1170-clock.h
index 8ab8018a15e..d3d21cf310d 100644
--- a/include/dt-bindings/clock/imxrt1170-clock.h
+++ b/include/dt-bindings/clock/imxrt1170-clock.h
@@ -43,6 +43,8 @@
 #define IMXRT1170_CLK_GPT1			33
 #define IMXRT1170_CLK_SEMC_SEL			34
 #define IMXRT1170_CLK_SEMC			35
-#define IMXRT1170_CLK_END			36
+#define IMXRT1170_CLK_FLEXSPI1_SEL		36
+#define IMXRT1170_CLK_FLEXSPI1			37
+#define IMXRT1170_CLK_END			38
 
 #endif /* __DT_BINDINGS_CLOCK_IMXRT1170_H */
-- 
2.45.3

