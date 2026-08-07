Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96F9C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:02:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A3C260AA8;
	Fri,  7 Aug 2026 16:02:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0ZTRQSLZoZyI; Fri,  7 Aug 2026 16:02:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AE23560A9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786118551;
	bh=X5KE4wthu+ov86dPtcWVxGdC+QAz3NnKAWyzbIsyJzE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nO9Gkq4K++TNnMdkhgvhSE74riOsUZLLGNu3OqXobC1KdAz+aWW0FBXm3+7z75kMt
	 8wnOFQ5XZ0mQO1Ro30JtGB5DQD5ZLMAHnA/fYB79o+thZm7TOCVeFnEz7XZhyBzcd0
	 TcwUVnNdo5VPBomxppazitfLejO7n1OP0wT70awsvHRTD2nNJodm7GwPgiD2qiOFN4
	 4HCmanrUsrh+maOdPG5ocX3a1mOA2Mwk35z1obBBV2luknxaucedkdO/7SRUvtlBoi
	 ztHaLDQ3ymLmeRKCPhdKSSWYF6ufKRCnoEhFDAoarFY5vDIoC2oiMEe2z/4nB5v4Al
	 NviqUWCH2J/hg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE23560A9D;
	Fri,  7 Aug 2026 16:02:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D704198
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:02:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 43FEE40A3B
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:02:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x0__lzOlnCOO for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:02:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7A5E340A2D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A5E340A2D
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7A5E340A2D
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:02:24 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6aeaaef491cso1058865eaf.2
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 09:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786118543; x=1786723343;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X5KE4wthu+ov86dPtcWVxGdC+QAz3NnKAWyzbIsyJzE=;
 b=EALI2qNjR6tL0F1RV8l0bU6zQb+bdlNFcqcxFtPcIcwYKReVRQD2w84hwC4whXD0Xh
 9Ndg1f4LyHatHYU4YkkJu/UkXwo+DKpbyaDgaS/1RBwdYEnkPcVFq9C9hWckx35oL6/U
 rOPkFwXW+BA5xTFNdKQrX4FuqDPuaMV0ebg5NHz5c9iu3qLxcBdHx7+rJLcIvL724MLK
 5vfjyaH55F9A/x9eoGOnA0dNGb5VMS2aZYmUq58U0gDpdXZxlzGNHtq9TCQXsuLMiOox
 3GQZAhTbEXkT1F4iFXKyQtBpHFcPVM4NODMUVYrcu6yOEeeZfo61MkwmHQSB7sZW323R
 EJEA==
X-Gm-Message-State: AOJu0Yzw1DQZma9cXMf2CbcPp0u7GmePvzV9AuTVF67Gqui+hKxSn6Ze
 tkIDjBtELlJYVpaladipY8gWoaZNAVf3IIFersB8ct9WuFTzLuKVLwAd7LMQt3khaoA=
X-Gm-Gg: AR+sD10BisqFNBjrx+BvqHO/pUlSMZ6giD4B6AluEUBv/3x3C2r2f1wGOl/uZlUUqm1
 qczcYg/ReteBeQCb6HvrKSf4xu51SEubGp9/6870StfeWc+Li2mxIzA7NedxuiYrtinCQR0piuX
 kZmyRmCnx92B8ZRDXvA9LhgbFZSOuBKRH6eAFgGu7oMVpgjH/llEXeIv1em2i4E5HY+XGZrors8
 qZgGgRSOzENxsqflEgQ5V37zzkCbo1dut2l5P+9vek8C/vHlwcoXfZyFP46Ui+EpO2dRi66GjJf
 x9l+qP0o/6GGiwS/9LtzZfi5dSJUNJ6tEg+Omv63XNTEM3KMZliSW3rHyzrtvWCt0M51CrJKMtr
 8jwa9Lswaalsmg1hMUYof1J8y4IytcaC6PJ0oh11GJZEaviblgeql12RtY+y10P5VH46p+UME3N
 0aMjXwjI+BE8oY/ZbrCmQNW65DA5ZCQ7uW0fDG9kf8Ra6b0Oqd5pE0Lox3hL6Zbey5
X-Received: by 2002:a05:6820:6acf:b0:6ab:1d3:bbf2 with SMTP id
 006d021491bc7-6b0421ab9f1mr565030eaf.25.1786118543099; 
 Fri, 07 Aug 2026 09:02:23 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02bc25c74sm2679993eaf.5.2026.08.07.09.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 09:02:22 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 11:01:32 -0500
Subject: [PATCH v2 5/5] arm: dts: add mt6366 PMIC include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-mtk-pmic-mt6366-v2-5-d9fdef581fb1@baylibre.com>
References: <20260807-mtk-pmic-mt6366-v2-0-d9fdef581fb1@baylibre.com>
In-Reply-To: <20260807-mtk-pmic-mt6366-v2-0-d9fdef581fb1@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Julien Masson <jmasson@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4275; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=hhyMebogwCzs3ajsMBggrZOfr//nVqhzJhHXmtwX7j4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdgGCSep92zvVj0z+4pCQ7ht5J8KCNYv6L05Wy
 ppuBlOZrJOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanYBghYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ALN4IAJPC0UVFxNV0ua9xgxFgUazNkHrMlZsBcyhlrSQ
 dzFJhwO0kS0HtxCh2OJtS075XSE8HmWFhIzA0yToKUHQREIM8tCKJjSE0PtMIo6xURlyeg0YuQw
 YFBjLWrpw2U1gmi211Cwjqt3yJu+QpjG6IclX+JOgHnO1c4/fRtQHQ5XOPLkBc6b7TS8p8fLJMb
 czlhYyxjTN+155VRaCjYZhiNR0oVAgj+VxokfeOyypWSDz4dMtL313y82RBseKXf9FZ/e8YMR+8
 co7gRsuVPfL2YeEEWijVrF2yUgSTTUyaTm5gL0UrZp8362VYIDFqWFUA1dIhrZKC+mao14aBRID
 g1HQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786118543; x=1786723343;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X5KE4wthu+ov86dPtcWVxGdC+QAz3NnKAWyzbIsyJzE=;
 b=PYReR/GC2hTlW2kNcvIYmD0b+wP9HKPyUygVNdjnqSoQx5zyDWp7Q4QyAOe7dQMKnl
 NhH3xUnSoMNMcy7wZPK5iSuQgmjMse8ejGuU1rwiz7FSpv0GAE7UPMRvHLnzW3eSKYL3
 PPUcgC3YegrZoJ0jKUncudGkjGFsvfJPeUUB101mU3QP8BDU58QR7cM0p+1YFnijK8NK
 3d84b56+bz0zVAYFCgHygIxDySD59CUhddsIWp3ikFuGp1ZAVv2S8PyhLS2GJNoJpDwS
 tcRe3waxb65h2JX+vLokA8httv8QOe8Mp7AQHJYFvQLwbBg6vy2rP1OI3EBXheKfS2WO
 G3ww==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=PYReR/GC
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a mt6366.dtsi file for the MediaTek MT6366 PMIC. For now, this just
includes the regulators since that is all that U-Boot uses. This should
eventually be replaced by an upstream devicetree file.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt6366.dtsi | 168 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/arch/arm/dts/mt6366.dtsi b/arch/arm/dts/mt6366.dtsi
new file mode 100644
index 00000000000..23cc2b62c6f
--- /dev/null
+++ b/arch/arm/dts/mt6366.dtsi
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (c) 2026 MediaTek Inc.
+ */
+
+&pwrap {
+	pmic: pmic {
+		compatible = "mediatek,mt6366", "mediatek,mt6358";
+
+		regulators {
+			compatible = "mediatek,mt6366-regulator", "mediatek,mt6358-regulator";
+
+			mt6366_vdram1_reg: vdram1 {
+				regulator-enable-ramp-delay = <0>;
+			};
+
+			mt6366_vcore_reg: vcore {
+				regulator-enable-ramp-delay = <200>;
+				regulator-always-on;
+			};
+
+			mt6366_vpa_reg: vpa {
+				regulator-enable-ramp-delay = <250>;
+			};
+
+			mt6366_vproc11_reg: vproc11 {
+				regulator-enable-ramp-delay = <200>;
+				regulator-always-on;
+			};
+
+			mt6366_vproc12_reg: vproc12 {
+				regulator-enable-ramp-delay = <200>;
+				regulator-always-on;
+			};
+
+			mt6366_vgpu_reg: vgpu {
+				regulator-enable-ramp-delay = <200>;
+			};
+
+			mt6366_vs2_reg: vs2 {
+				regulator-enable-ramp-delay = <0>;
+				regulator-always-on;
+			};
+
+			mt6366_vmodem_reg: vmodem {
+				regulator-enable-ramp-delay = <900>;
+				regulator-always-on;
+			};
+
+			mt6366_vs1_reg: vs1 {
+				regulator-enable-ramp-delay = <0>;
+				regulator-always-on;
+			};
+
+			mt6366_vdram2_reg: vdram2 {
+				regulator-enable-ramp-delay = <3300>;
+			};
+
+			mt6366_vsim1_reg: vsim1 {
+				regulator-enable-ramp-delay = <540>;
+			};
+
+			mt6366_vibr_reg: vibr {
+				regulator-enable-ramp-delay = <60>;
+			};
+
+			mt6366_vrf12_reg: vrf12 {
+				regulator-enable-ramp-delay = <120>;
+			};
+
+			mt6366_vio18_reg: vio18 {
+				regulator-enable-ramp-delay = <2700>;
+				regulator-always-on;
+			};
+
+			mt6366_vusb_reg: vusb {
+				regulator-enable-ramp-delay = <270>;
+				regulator-always-on;
+			};
+
+			mt6366_vcn18_reg: vcn18 {
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			mt6366_vfe28_reg: vfe28 {
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			mt6366_vsram_proc11_reg: vsram-proc11 {
+				regulator-enable-ramp-delay = <240>;
+				regulator-always-on;
+			};
+
+			mt6366_vcn28_reg: vcn28 {
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			mt6366_vsram_others_reg: vsram-others {
+				regulator-enable-ramp-delay = <240>;
+				regulator-always-on;
+			};
+
+			mt6366_vsram_gpu_reg: vsram-gpu {
+				regulator-enable-ramp-delay = <240>;
+			};
+
+			mt6366_vxo22_reg: vxo22 {
+				regulator-enable-ramp-delay = <120>;
+				regulator-always-on;
+			};
+
+			mt6366_vefuse_reg: vefuse {
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			mt6366_vaux18_reg: vaux18 {
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			mt6366_vmch_reg: vmch {
+				regulator-enable-ramp-delay = <60>;
+			};
+
+			mt6366_vbif28_reg: vbif28 {
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			mt6366_vsram_proc12_reg: vsram-proc12 {
+				regulator-enable-ramp-delay = <240>;
+				regulator-always-on;
+			};
+
+			mt6366_vemc_reg: vemc {
+				regulator-enable-ramp-delay = <60>;
+			};
+
+			mt6366_vio28_reg: vio28 {
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			mt6366_va12_reg: va12 {
+				regulator-enable-ramp-delay = <270>;
+				regulator-always-on;
+			};
+
+			mt6366_vrf18_reg: vrf18 {
+				regulator-enable-ramp-delay = <120>;
+			};
+
+			mt6366_vcn33_bt_reg: vcn33 {
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			mt6366_vmc_reg: vmc {
+				regulator-enable-ramp-delay = <60>;
+			};
+
+			mt6366_vaud28_reg: vaud28 {
+				regulator-enable-ramp-delay = <270>;
+				regulator-always-on;
+			};
+
+			mt6366_vsim2_reg: vsim2 {
+				regulator-enable-ramp-delay = <540>;
+			};
+		};
+	};
+};

-- 
2.43.0

