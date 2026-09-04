Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE028C624D3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 14:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 820E1811C9;
	Fri,  4 Sep 2026 14:47:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yCNqokYXHJsQ; Fri,  4 Sep 2026 14:47:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 96B67811C4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788533262;
	b=JHFDliN6lf1oXNjLVoIzFxvz+NdvwOiE5J2BkXXVPyjbavgzVKdP2e0yWvQu8iy89yQS
	 skQJKzleNI4oLrwx5JQ7zcXuDNuIIZ4knid9+FZPCtEQW8G1ZOeTZXywGaXsRE6ydURSN
	 FFPP/05xr9K86UGaMiehRuL2Dhy77YtmPJ95eNGVLsWyBFFhTmZSzPqKQQH8OfcZj2hC3
	 OfeE9pGakRgLSvfRj5npyW1k8QkfxWSEElg9chFgYLf2RPd8AqcshFYX/+w3YLczBWjtd
	 fEo+d0WSmGfipLqo8Ab+A1zEutOwI/bCKoz8rCJFdPZ5b48BdulScSI7iJZe/83hDFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788533262;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=g5BJjqLNqzd6xl++oWYFnvXPV+f7i/h01N+oypv2Yno=;
	b=Kr/v/r6uiQMFPM+LzE5IdcbFScKKenPA0HncdS+Db9ganWyVRXUSu2eDcBOZyBUDMgQ4
	 TZlP3jQzysJGitnicKZ51gS0JOltcy7GN95Zhk9/QbBlWmXCFxikaLkR40ULAx0M3xr/N
	 /Iv+hALxBw4MOtn0a6zQUl5bXPsTuLQqteDfIcn/w/xHr9qxsHEsKsEj6KXT9fNTRNvND
	 r6v13yl0YHprgAkUWD5n+uBfjWIiQ+9rYTpD9dGk0wcIKwVGeVaj/8j908vqzHXcv+LB1
	 N/RQWIBPhUZ20TQXz1c34BgwQNP3XHwmsPQDcx+Tkk6/4qOnzjZ3nOsx/dTc6vCgd9A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788533262;
	bh=g5BJjqLNqzd6xl++oWYFnvXPV+f7i/h01N+oypv2Yno=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wCrq5Rkl8BljC8+c5/w+rmZ+sE3Rjfnyi/g0Kep8jxe/U27LPXCHPXsS1ZiVeKZAR
	 bDKw5zxGV02h7rMTk5SBWLGj8aWM6nr4wE2h0KtFtdo0+M5vmrgYMli7wQMjX1pXvI
	 E1ZoC/yrlYIYTPGuNpw2DI48tRQOScBsgU9mSQT29+bZHLMTwN72j+RLpcpqb2rcdj
	 ZkUoHbqhuibm2u0BHRsmMRgB1KR4NkuMf+1lXwK6GXJvIkeJ9nkjYLjgU8ABzVitTz
	 8Cxhs56eT1uYsK6RV/9Rrd7KnHMlYmvIkp+XLtDiS7ST5hos/TJuCLtEg0nmkBzfTI
	 SeUSuwxi2e+6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96B67811C4;
	Fri,  4 Sep 2026 14:47:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A0795B2C
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:47:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 868EA60BF3
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:47:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PeOqBbel-J0C for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 14:47:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D2D6460BB6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::236"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788533252;
 b=qGvaYLXciQ1nz5DXN9Nzo13gIWGdpIiuHDbJZBb5GQRlYaJLM4GCkeU8qFU6iYyoEFo/
 GJKJTz/lpW3fl8NDMRGOwM08mr5s0+BD3iH7mPbU/NOJQ4pUAmRggKBLKezLhHhpMepGg
 eXdVuLvvF9zILBOYXsGt1YacvUT1mM58KMGC+wpuh9toIdLwSQyLnlFbfa2XbuC1PTpvl
 D9EDdcXIopjk6M87wJUC/ZuqzeQFGApogyVefD7o2oxopGq0O4LJ3w7DcqQqhveCDJv2/
 NbLtc2wVaPQfb4vbdOBrLDHu2D/WF6MMoEd73OXTTS5cVOWAXfL+zoOftILelxxZOPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788533252;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=g5BJjqLNqzd6xl++oWYFnvXPV+f7i/h01N+oypv2Yno=;
 b=GborbIZQUsV3LORiwVf1VlbBzWtofjgR4jtyG+s5vLaC+NBuqXdnshibp8dvsj7QbdHb
 TFeTUt9EtOor8onDE/x13OSZAEaWO+nPvUlKN719EPOE9HYq6ROSRQD/x0KSVtbtYI8Mw
 sZAPrvLniqNYe24fbQhBKYNt3qSJGqvXNTfebhyb3RRXnKw3NsdvJLUnStWNOa7gUa19k
 5ugNVQCTvAsylWWqctcF93bXYBNh7V+yroXqiFGDZHbp4nd+Q/Dj2mqOvkoMFftfWwc+b
 gNh5SJFhpG0XQTMiITcRIRVj59LO/WGZ4+xBC0GZ3sIqET5rjRXouikXuZUHDJiNeNA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ULzmxkgW; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::236"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ULzmxkgW
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D2D6460BB6
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:47:31 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4b2ff8ca537so854939b6e.3
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788533250; x=1789138050;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g5BJjqLNqzd6xl++oWYFnvXPV+f7i/h01N+oypv2Yno=;
 b=ULzmxkgW4Sk9YiB73nL/ULypiIyxfrnVvXPqxwfBeDvSjj1oacsqA7br+PMyP6ERkC
 ii7kj9lRLrTOz06UhgkhbvG/RnJGJ0HvCBkj1813Xpy+r93YldIjOn3Rxkwi9GdXIjRn
 NRxvC38mjrIVFQWT0WkkXyE3EEkqtvhX7apK3scwxIzXziVJOckHfmWDV8oil/ske8Nq
 cfkDP2cNwgkMvXJZGyr9PVi5GVu24+k4iq3UczEGrCrm0AMnN/eokN4/1xFZ+XlOLxJw
 02WwVuDxcDvtpJmmiUNlTlYnfwj0swlUGJmJewkfiSrbX+LIdzDlHWbgc6CKecO3OWzj
 eQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788533250; x=1789138050;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g5BJjqLNqzd6xl++oWYFnvXPV+f7i/h01N+oypv2Yno=;
 b=dkoQ6IxycqBFflG7L/QmnPySjsPhCA26giPbkZQCDPufFMJFHBoFisHlCt2xuONC4C
 le7cg30f7au5coaBM11LWP0KJ7KcO+zYYFNPkOHSp6fhKfLK8GMU2VcRof3wHBXxfmoM
 WbMAHYaNOLhubORLVi+0H5nZkHL09eViQ6MVeJIjGZ+A7knSnV2Zrb+KuvpJuQiG1NQr
 WB+GgEeiOJbXQBnQDuECVu8zXFKE/97RVrUXfPbhBTUx0BLfUsrQb4IbMJE9GY2UB/6j
 BwD+kjPPFNLG2lI/YDNGp2txjTldzYUolMf59ZLlrwG4cvWzOrhqAlgr7xdb+O2y0xE+
 d43w==
X-Gm-Message-State: AFuF++mEwuFH6xldnfhe3Df5cKnWGE8uN+IRBa3FRYDYm2zuX3XXMw5D
 Dmi6P0pkv6b5KscQc82nZllZCktrof6UfVu6RmdGxCH1ARP8oPAtCnN5hUqW5Kaa0tQ=
X-Gm-Gg: AYBFou2IoCab4kvMtsfQ15DdR0sqP90hKOQD4cT6c6YL2+juiwrwiOLpXgLRBwfhLTb
 id8045Mr0iBq2Nx+VbnbjXHroevNon8rxb5mTGupGX5IBUhPiF4zuoMFp+94V4Ehk7tVL7EnY2P
 ECcXLLoMxwp5PAOffRwZL1yTlyRkCrAfCROhfvyC0ZiXK8aJkeEgTyrCHmzalEqOsHiXsAxATUB
 hqW0rDtqLRdTZiw0nskUZJCvDitAk4B39Ze+sald5XAQn1aKO9WKmpcgOkS28pCz7jAE8gTOx3v
 4ICZtH9p2A0t8VfnLzEyNystTJf+p7zX6/+n8EkTRZmljqbBjmrJ/MWIHkNql/zvNAr2CYq+dQQ
 De/Rw9DfCC2PC8zkCYQzOw/HeCoVgTH/mGAEQOxJHo0czGTHiyLq7Fwoi0QQWoxQWp19V69BxwM
 PbjoUmOD+JXMWymgDNWOXKexnwTSrzA1VDrKidrRE1yfbm5oomMmYiH6gRM32kHjI0Lb3oKQKAb
 Z4C
X-Received: by 2002:a05:6808:4482:b0:4b3:7b31:8df7 with SMTP id
 5614622812f47-4b962733118mr4651568b6e.14.1788533250067; 
 Fri, 04 Sep 2026 07:47:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4a5f:f4c7:21f3:4b8a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47554935962sm2118988fac.12.2026.09.04.07.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 07:47:29 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 04 Sep 2026 09:46:32 -0500
Subject: [PATCH 5/6] arm: dts: mediatek: mt8189: add the power controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-mtk-power-domain-mt8189-v1-5-ab9d8cd0f01a@baylibre.com>
References: <20260904-mtk-power-domain-mt8189-v1-0-ab9d8cd0f01a@baylibre.com>
In-Reply-To: <20260904-mtk-power-domain-mt8189-v1-0-ab9d8cd0f01a@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Sam Shih <sam.shih@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, David Woodhouse <dwmw2@infradead.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4515; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=4lzixhO56uFjoxH2JqTRle62ljq3vDYvWrCv27jaiMw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmtnrWccM7zK59RjToY3c4xSaKtp4sxr+bf31d
 KwVuvxkewGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaprZ6xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ApbQH/3h8ges14bH1EHtEaAc1AxBpoOliR92Wl7XF5Xx
 9T38ugX3XQe3fKdVH71gYDctiBOohIT/rKh84YltgwGa7rFcViA6gT1ic8yReIEW4VUG5iImhIr
 ekcCQdackIdnG6LQmco5/pPDarTUB6R9e958Y3PhO0H1oEa5fOcFIQrz7YQV9dH79ZUPl44xU8Q
 iwZpqWhIX70w/F+zzNyvp7XWkLMHUlTY++E7Qee6JeSUAUl4dRbHS3I+HNnKAvii3dfxrAMbYk/
 4kGZAY5Bz6UpxYGvwcz4EJQbKnpY0n7bXAbMuvzxHs4Lo0Ix/CUCEUgpFJrY8hd7/NhZxD9Czgx
 jFtM=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Describe the System Power Manager with the MM_INFRA and DISP domains and
the SSUSB domain, and add the infra-ao syscon that its bus protection
steps poke. Label the display and mm-infra clock controllers so the
domains can reference them.

Add the power-domains properties to xhci1, xhci2 and xhci3. These were
left out previously since we did not have the power controller yet.

The power controller node, its domains and the clock and label names
follow the MT8189 device tree that is in flight for Linux, so this part
should match once that lands. The display clock controller keeps the
"mediatek,mt8189-dispsys" compatible for now; upstream splits that
register range into a separate mmsys node, which is left for whenever
display support is added.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8189.dtsi | 52 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/mt8189.dtsi b/arch/arm/dts/mt8189.dtsi
index c965b00bb5c..f3a350c51b8 100644
--- a/arch/arm/dts/mt8189.dtsi
+++ b/arch/arm/dts/mt8189.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy.h>
+#include <dt-bindings/power/mediatek,mt8189-power.h>
 #include <dt-bindings/reset/ti-syscon.h>
 
 / {
@@ -144,6 +145,45 @@
 		compatible = "simple-bus";
 		ranges;
 
+		scpsys: syscon@1c001000 {
+			compatible = "mediatek,mt8189-scpsys", "syscon", "simple-mfd";
+			reg = <0 0x1c001000 0 0x1000>;
+
+			/* System Power Manager */
+			spm: power-controller {
+				compatible = "mediatek,mt8189-power-controller";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#power-domain-cells = <1>;
+
+				power-domain@MT8189_POWER_DOMAIN_MM_INFRA {
+					reg = <MT8189_POWER_DOMAIN_MM_INFRA>;
+					clocks = <&topckgen_clk CLK_TOP_MMINFRA_SEL>,
+						 <&mminfra_config_clk CLK_MMINFRA_SMI>;
+					clock-names = "mminfra", "ss-mminfra";
+					mediatek,infracfg = <&infracfg_ao>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8189_POWER_DOMAIN_DISP {
+						reg = <MT8189_POWER_DOMAIN_DISP>;
+						clocks = <&topckgen_clk CLK_TOP_DISP0_SEL>,
+							 <&dispsys_config_clk CLK_MM_SMI_LARB>;
+						clock-names = "disp", "ss-disp";
+						mediatek,infracfg = <&infracfg_ao>;
+						#power-domain-cells = <0>;
+					};
+				};
+
+				power-domain@MT8189_POWER_DOMAIN_SSUSB {
+					reg = <MT8189_POWER_DOMAIN_SSUSB>;
+					mediatek,infracfg = <&infracfg_ao>;
+					#power-domain-cells = <0>;
+				};
+			};
+		};
+
 		watchdog: watchdog@1c00a000 {
 			compatible = "mediatek,mt8391-wdt",
 				     "mediatek,wdt";
@@ -240,6 +280,7 @@
 				 <&pericfg_ao_clk CLK_PERAO_SSUSB1_FRMCNT>;
 			clock-names = "sys_ck", "ref_ck","mcu_ck",
 				      "dma_ck", "xhci_ck", "frmcnt_ck";
+			power-domains = <&spm MT8189_POWER_DOMAIN_SSUSB>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			wakeup-source;
@@ -264,6 +305,7 @@
 				 <&pericfg_ao_clk CLK_PERAO_SSUSB2_FRMCNT>;
 			clock-names = "sys_ck", "ref_ck","mcu_ck",
 				      "dma_ck", "xhci_ck", "frmcnt_ck";
+			power-domains = <&spm MT8189_POWER_DOMAIN_SSUSB>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			wakeup-source;
@@ -313,6 +355,7 @@
 				 <&pericfg_ao_clk CLK_PERAO_SSUSB3_FRMCNT>;
 			clock-names = "sys_ck", "ref_ck", "mcu_ck",
 				      "dma_ck", "xhci_ck", "frmcnt_ck";
+			power-domains = <&spm MT8189_POWER_DOMAIN_SSUSB>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			wakeup-source;
@@ -344,13 +387,18 @@
 			status = "disabled";
 		};
 
+		infracfg_ao: syscon@10001000 {
+			compatible = "mediatek,mt8189-infra-ao", "syscon";
+			reg = <0 0x10001000 0 0x1000>;
+		};
+
 		clock-controller@1000c000 {
 			compatible = "mediatek,mt8189-apmixedsys", "syscon";
 			reg = <0 0x1000c000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
-		clock-controller@14000000 {
+		dispsys_config_clk: clock-controller@14000000 {
 			compatible = "mediatek,mt8189-dispsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
 			#clock-cells = <1>;
@@ -368,7 +416,7 @@
 			#clock-cells = <1>;
 		};
 
-		clock-controller@1e800000 {
+		mminfra_config_clk: clock-controller@1e800000 {
 			compatible = "mediatek,mt8189-mm-infra", "syscon";
 			reg = <0 0x1e800000 0 0x1000>;
 			#clock-cells = <1>;

-- 
2.43.0

