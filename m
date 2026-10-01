Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681DDCA5FDD
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 21:24:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A214810CB;
	Thu,  1 Oct 2026 21:24:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7-bGNupaeFdI; Thu,  1 Oct 2026 21:24:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 80949811B6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790889895;
	b=tYRSdH8cj1KPBm6yGNMgBLak9vCdiX4WiFUu4GyV6LxfjCZf8xeX1Pbl7TXgBtD1d1p6
	 S/P2Y+cfX+b2v4492NRK9r0cagJ0jKWOvd41pGJjNBKUpIW0iPBbGKWaK3ekll50ffPuL
	 ckHvYky4dzi4fLS0+62Ahdl48OSWFp8GmEeadjXdniUfHzrutlANJuq106T7C1viMANWn
	 DxbW9JYewMWXXCLRo5EVp2IyaJatRCmpxxCa6fWSMPrD1Jq6/rDclZnomz2rzJUloedqA
	 bfsBJ3it8vF+dYT7zcFXCYR/cgkeCLEK1BvozP5JipMuB9wUimzLlKZ6cDyaQ57u+Og==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790889895;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VJPm4qPMoK2JWW4E9llBn2d7dht83LDK7v01mD+TFBE=;
	b=XW6PbKV8jABTMApUzIDD1IU4Ulj3wBRKpb/EOe875EaFBFPp6fYyNkzpK4e7bFznKnj6
	 dZr3DVxJ5VFUMJJjg+dyKOq5/qoqsna2s6PmTwDs4NwO3osyJnr3xP/SOR0W67XXvSIfM
	 M7hHnoDaBlYLS0OqUQFAC7+7+9GgWEg7q3Em6e4fpwcRsVWAUtnLNsls2oDjuGa4eKCyX
	 jDMXqXyuiMi9iBDi0Zy/El78YuLNaHNez3PNErI1yjlobqnm+cdR5Nd9syxMksg+KJkkC
	 zQZdYx5vrXvL/R/T1BxO4z2ur8Znd2fI3BobfP8ond+WAVRUuzMpK7Fw8m3uu0gdrCw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790889895;
	bh=VJPm4qPMoK2JWW4E9llBn2d7dht83LDK7v01mD+TFBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BGsdpK9qWGkLKQrcsK+vAFYSHFkoKx4gukpkbIqnOQzzMRJlTZQwBywPBlZpZSNK1
	 T3LipYOqxcBfNM3WN2M9cX95z4uQbEmVYxVn4M7Wth+wqJ6OXdQmNT78bjOnKCeMh4
	 qrhFuiTMzM8ytHVZIVM0YFmcFOr6NwZI0cS1xjPv+bfZ40qQIZzoqfLwScDlYguVWy
	 CpGr1SkQ8LR6FYGMVk3pjNJM16MPxtwGvne3FDpZfsMEsG+rKdIWlGMz+sjqyZmBrF
	 0q0sK0GYpSEiSV4dGmSdZCZ5aahalm/bkeGIUYlJPXtaKUeXRYra6fFzE7nK/HwGxf
	 +R4d3e6Pd1M7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80949811B6;
	Thu,  1 Oct 2026 21:24:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B711A32F
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 87B706066B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IZTLZkyQYLWa for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 20:45:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2DD1B6063F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790887527;
 b=ain5E/2zTAg1X+FaH/P1KuGcM0moRue90DSgShuNcHb46DdWk0tZrcjI2ZEPBSOJXbK/
 Bed/qVumgVOcOH0ZDhZrq0oNX8YkETiwdB20yM/Oio0X2XBxonuISwI51mr2UzGnqHOUa
 o/abZuToZgDLWxDACEQGtKYq7W2lQDNSZ2+yhSqY1ylCbRfkLh2X9itYHHC+6OnDcXvba
 /3iymUD0lXzlOCjkkTLJ1/CPcfqEbS7TQnUoJjru2bCZj8TfNxokT7QQHKrs+BmF3bLqR
 ASCAffeHXZ281pG1JzEgtrCOEsFjRB4I6prZbkM82vefZ2/ag7HUjbnTPP42z6PRVjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790887527;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=VJPm4qPMoK2JWW4E9llBn2d7dht83LDK7v01mD+TFBE=;
 b=nvcQioJTtIDym2r6Qru7fi6jUzjDp3zYMJ6TmlkrzRGobYWtGZgERSd4CfZXPNUjVVuQ
 UH7LvAlkx6ssWHUED2pd7//HP/UBgfidBavcNYSa7Yi7CKAXzsB0QrGYSFejFQz+tMXmM
 gwb8dVvGWmbh1P7OUNJcF54kiUOOR38cfkG95JzRUHD5/uaJhjAdoZdXeikrnJN7cCsU9
 O2t24LmHV0r5AaSYg52LLNCeTTNvCcZZeq+Oh3SQ7XwzzLMwXJ4g7X1tYptBRWc65sQOf
 /6J9kAA0jPccYoZ+9eUigedJdSMIe6bwod3SoB5QBSoCdZ5ps6lUr3eEOZ7ai9EpBfg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jtTFVpm0; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::2a; helo=mail-pj2-x2a.google.com;
 envelope-from=lqing2013@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jtTFVpm0
Received: from mail-pj2-x2a.google.com (mail-pj2-x2a.google.com
 [IPv6:2607:f8b0:4864:39::2a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2DD1B6063F
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:26 +0000 (UTC)
Received: by mail-pj2-x2a.google.com with SMTP id
 d9443c01a7336-2e2e688de2eso20729875ad.3
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 13:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790887526; x=1791492326;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VJPm4qPMoK2JWW4E9llBn2d7dht83LDK7v01mD+TFBE=;
 b=jtTFVpm0ezVbJc050CsW76jtGg8s4vkceJsmue+5Fjeufnvp/eYcYMFEjM2XZ1kCbp
 /Zvcwb9RrsST6sAqHRuLHDcZHlhphnuf4V4olq7x0Tv2uuV+ZRYIEd3/+JWAgkOjTUy+
 c8ld7OyTaqxjSp0XrMDm7wqj9cHl5sCJIgccFsBpk9QsesNe5qhng0ZqTYdNb1OT1vzE
 jR9e6DD05Gk7+n+BU1vlxucIVfWzoh/mvk3ZgDp+Bdo15E7jzR/akot0EN//HheznUPy
 S3q8paBn2tNqEOAcLxgi1fCrT6u1Oop9KjjhQDVWA9+Hj0b9V6y8ZnNunZXQu3fgcSP4
 /91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790887526; x=1791492326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VJPm4qPMoK2JWW4E9llBn2d7dht83LDK7v01mD+TFBE=;
 b=de1b7knFegXcw7jhmO2SsZ5o46ytl48jUZRaOTcCws9kKjXGJ6WwD10Hwp49NE8hAI
 u9qLir0yyztYRjTCWhqqQkpA1rZRkqT12WDazyCYOzypthJOCuI/kzfVUVkh0hBcj9AB
 2IhOO5iIstERElzzEOVO1wNN4pgWFx6H8raZFpdizMGrI7hrnDT/7BRM03P7pB09IHO8
 u6tEUNB3VVyxS/OcfEDVpOKzZO3UUneQ5ltC6Q1oKErjY1k+qnMlfLVF3Ofr5qI8veLn
 q9LOtXGPs6Ek/1BBBHNYdUnEjk/NrxxSHlJTTHJFAZFI2JFltZFmfiDIEOFSQE1iKxn7
 p7JA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1771YUysLPyy0Y2Og8vOpsGvlkfHGY/1+Dk2sqEM2fMBpBL+HgLWls4D0Xg2V+NseAPPX84U=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI0u4UliJb9xhqenyWk3c+rduMutzYDRmZC2GvGl2rriDKrxkiI
 Fsb8HzceTmUqrWE1D/fhDc9AnB+Z/EIji8rnS+17u/7jYFxMyAAQFkim
X-Gm-Gg: AYBFou2CSqetiDTMb9uDDxwuOIfzocVXN0gPTA6FM6AS6fOxf5hyprNY5P6Osi1+BQF
 exzgLzaqLcIXAfhdPvziH+g+xCzeoAU3Tneib0cMzFJSiwICtyXAW4XCsY4rcA5cflGo7Z8yEQc
 4c8a3CobYwbCHmnhfMVdm7rC5sEcb80gcP53oKlluanR91hHH7UR9JHOQrtimXe5O6rTEKTmKl1
 15Cwhw9WH5LDriu8aY/bR3JxooYotJSjCj8Kb6fv0cyMRUkw+4XahbaAZr/m+UnVg6B75O9avBQ
 eCyryJOi3Bffp17WaPxRStSxJZnN0CtY47k8CxIjtwsb/PAezUqf3giOtM5jJQW/6Afu6rvT6s8
 vVZ1nk4cEqmwi5aroMALj4GXz37nBBbBi8O1bKgF9uRPaT6sMBPhGADAJOYlgfs2dLFs6i0INU/
 bLiWfNCAqjMgvlAnadOORgLiZ1O61qljzAwIQ0hPY10iKZCSJY3DQXQ9RHyNT4XsMcnd4Ncq/zI
 MpY+eZW57hp3FPDpDy6dn3sUj6qrKhjhZK3qa9Dt89wosRv
X-Received: by 2002:a17:90b:5343:b0:3a0:ca1d:b40d with SMTP id
 98e67ed59e1d1-3a6cecac6c2mr621339a91.55.1790887525981; 
 Thu, 01 Oct 2026 13:45:25 -0700 (PDT)
Received: from localhost.localdomain
 ([2409:8a30:2e86:1710:20ae:2ce4:794c:d830])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6cd634734sm883877a91.17.2026.10.01.13.45.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Oct 2026 13:45:25 -0700 (PDT)
From: Qing Li <lqing2013@gmail.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Qing Li <lqing2013@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 8/9] arm: dts: qcom: sm8150-xiaomi-crux: add board devicetree
Date: Fri,  2 Oct 2026 04:44:51 +0800
Message-ID: <7f913d7096cef3c3ece881c9c71fc9dc09687715.1790887323.git.lqing2013@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1790887323.git.lqing2013@gmail.com>
References: <cover.1790887323.git.lqing2013@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 01 Oct 2026 21:24:42 +0000
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

Add the devicetree for the Xiaomi Mi 9 Pro 5G (crux, SM8150). It is
based on the sm8150-xiaomi-cepheus devicetree by Alexey Minnekhanov,
with the crux-specific reserved-memory layout taken from the stock boot
image; the covered peripherals are UFS and its PHYs, PM8150 regulators,
the volume key and a simple framebuffer.

Only the USB 2.0 HS PHY is referenced: U-Boot has no driver for the
SM8150 QMP USB3/DP PHY and DWC3 fails to probe when a PHY in its list
cannot be resolved.

The devicetree has not been synced to dts/upstream yet, so it lives in
arch/arm/dts/. Also add a MAINTAINERS entry for the board.

Signed-off-by: Qing Li <lqing2013@gmail.com>
---
 arch/arm/dts/sm8150-xiaomi-crux.dts | 612 ++++++++++++++++++++++++++++
 board/qualcomm/MAINTAINERS          |   5 +
 2 files changed, 617 insertions(+)
 create mode 100644 arch/arm/dts/sm8150-xiaomi-crux.dts

diff --git a/arch/arm/dts/sm8150-xiaomi-crux.dts b/arch/arm/dts/sm8150-xiaomi-crux.dts
new file mode 100644
index 00000000000..64f32b52491
--- /dev/null
+++ b/arch/arm/dts/sm8150-xiaomi-crux.dts
@@ -0,0 +1,612 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, Alexey Minnekhanov <alexeymin@postmarketos.org>
+ * Copyright (c) 2026, Qing Li <lqing2013@gmail.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/input/gpio-keys.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include "sm8150.dtsi"
+#include "pm8150.dtsi"
+#include "pm8150b.dtsi"
+#include "pm8150l.dtsi"
+
+/*
+ * Rewrite reserved memory maps inherited from sm8150.dtsi to match the ones
+ * used on xiaomi-cepheus.
+ * Note: this list is ordered by its memory address in sm8150.dtsi.
+ */
+/delete-node/ &xbl_mem;   /* crux: 85d00000+1M dump, 85e00000+1.25M aop */
+/delete-node/ &aop_mem;
+/delete-node/ &aop_cmd_db;
+/delete-node/ &tz_mem;      /* same address but larger, no place for rmtfs_mem! */
+/delete-node/ &rmtfs_mem;   /* moved to completely different address */
+/delete-node/ &adsp_mem;    /* same start address, but larger size */
+/delete-node/ &mpss_mem;    /* same size, shifted higher, due to larger adsp_mem */
+/delete-node/ &venus_mem;   /* same size, shifted higher */
+/delete-node/ &slpi_mem;    /* same size, shifted higher */
+/delete-node/ &ipa_fw_mem;  /* same size, shifted higher */
+/delete-node/ &ipa_gsi_mem; /* same size, shifted higher */
+/delete-node/ &gpu_mem;     /* same size, shifted higher */
+/delete-node/ &spss_mem;    /* same size, shifted higher */
+/delete-node/ &cdsp_mem;    /* same size, shifted higher */
+
+/ {
+	model = "Xiaomi Mi 9 Pro 5G";
+	compatible = "xiaomi,crux", "qcom,sm8150";
+	chassis-type = "handset";
+	qcom,msm-id = <0x153 0x20000>;
+	qcom,board-id = <0x2b 0x1>;
+
+	aliases {
+		serial0 = &uart2;
+		display0 = &framebuffer;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		stdout-path = "serial0:115200n8";
+
+		framebuffer: framebuffer@9c000000 {
+			compatible = "simple-framebuffer";
+			reg = <0 0x9c000000 0 0x2400000>;
+			width = <1080>;
+			height = <2340>;
+			stride = <(1080 * 4)>;
+			format = "a8r8g8b8";
+			/*
+			 * That's (going to be) a lot of clocks, but it's necessary due
+			 * to unused clk cleanup & no panel driver yet (& no dispcc either)..
+			 */
+			clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
+				 <&gcc GCC_DISP_SF_AXI_CLK>;
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vol_up_pin_a>;
+
+		vol_up {
+			label = "volume_up";
+			gpios = <&pm8150_gpios 6 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_KEY>;
+			linux,code = <KEY_VOLUMEUP>;
+			wakeup-source;
+			debounce-interval = <15>;
+		};
+
+	};
+
+	reserved-memory {
+		xbl_dump_mem: memory@85d00000 {
+			no-map;
+			reg = <0x0 0x85d00000 0x0 0x100000>;
+		};
+
+		xbl_aop_mem: memory@85e00000 {
+			no-map;
+			reg = <0x0 0x85e00000 0x0 0x140000>;
+		};
+
+		aop_cmd_db: memory@85f20000 {
+			compatible = "qcom,cmd-db";
+			no-map;
+			reg = <0x0 0x85f20000 0x0 0x20000>;
+		};
+		tz_mem: memory@86200000 {
+			no-map;
+			reg = <0x0 0x86200000 0x0 0x5500000>;
+			phandle = <0x594>;
+		};
+
+		adsp_mem: memory@8be00000 {
+			no-map;
+			reg = <0x0 0x8be00000 0x0 0x2200000>;
+		};
+
+		mpss_mem: memory@8e000000 {
+			no-map;
+			reg = <0x0 0x8e000000 0x0 0x9600000>;
+		};
+
+		venus_mem: memory@97600000 {
+			no-map;
+			reg = <0x0 0x97600000 0x0 0x500000>;
+		};
+
+		slpi_mem: memory@97b00000 {
+			no-map;
+			reg = <0x0 0x97b00000 0x0 0x1400000>;
+		};
+
+		ipa_fw_mem: memory@98f00000 {
+			no-map;
+			reg = <0x0 0x98f00000 0x0 0x10000>;
+		};
+
+		ipa_gsi_mem: memory@98f10000 {
+			no-map;
+			reg = <0x0 0x98f10000 0x0 0x5000>;
+		};
+
+		gpu_mem: memory@98f15000 {
+			no-map;
+			reg = <0x0 0x98f15000 0x0 0x2000>;
+		};
+
+		spss_mem: memory@99000000 {
+			no-map;
+			reg = <0x0 0x99000000 0x0 0x100000>;
+		};
+
+		cdsp_mem: memory@99100000 {
+			no-map;
+			reg = <0x0 0x99100000 0x0 0x1400000>;
+		};
+
+		cont_splash_mem: memory@9c000000 {
+			reg = <0x0 0x9c000000 0x0 0x2400000>;
+			no-map;
+		};
+
+		cdsp_sec_mem: memory@a4c00000 {
+			reg = <0x0 0xa4c00000 0x0 0x3c00000>;
+			no-map;
+		};
+
+		ramoops@b0000000 {
+			compatible = "ramoops";
+			reg = <0x0 0xb0000000 0x0 0x400000>;
+			console-size = <0x200000>;
+			ecc-size = <0>;
+			ftrace-size = <0>;
+			pmsg-size = <0x200000>;
+			record-size = <0>;
+		};
+
+		/*
+		 * Downstream dynamically allocates rmtfs_mem region using
+		 * dma_alloc_coherent and adds 4k guard pages before and after
+		 * it to workaround some "XPU limitation".
+		 */
+		/* rmtfs_lower_guard */
+		memory@f4100000 {
+			no-map;
+			reg = <0x0 0xf4100000 0x0 0x1000>;
+		};
+
+		rmtfs_mem: memory@f4101000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0 0xf4101000 0x0 0x300000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
+
+		/* rmtfs_upper_guard */
+		memory@f4401000 {
+			no-map;
+			reg = <0x0 0xf4401000 0x0 0x1000>;
+		};
+	};
+
+	vdd_boost_vreg: vdd-boost-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_boost_vreg";
+		startup-delay-us = <4000>;
+		enable-active-high;
+		regulator-always-on;
+		gpio = <&pm8150b_gpios 5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_boost_en_pin>;
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+	};
+
+	/* S4 is modeled as a fixed regulator in vendor sources */
+	vreg_s4a_1p8: pm8150-s4-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_s4a_1p8";
+
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+
+		vin-supply = <&vph_pwr>;
+	};
+};
+
+&apps_rsc {
+	pm8150-rpmh-regulators {
+		compatible = "qcom,pm8150-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+
+		vdd-l1-l8-l11-supply = <&vreg_s6a_0p9>;
+		vdd-l2-l10-supply = <&vreg_bob>;
+		vdd-l3-l4-l5-l18-supply = <&vreg_s6a_0p9>;
+		vdd-l6-l9-supply = <&vreg_s8c_1p3>;
+		vdd-l7-l12-l14-l15-supply = <&vreg_s5a_1p9>;
+		vdd-l13-l16-l17-supply = <&vreg_bob>;
+
+		vreg_s2a_0p6: smps2 {
+			regulator-min-microvolt = <600000>;
+			regulator-max-microvolt = <600000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_s2a_0p6";
+		};
+
+		vreg_s5a_1p9: smps5 {
+			regulator-min-microvolt = <1904000>;
+			regulator-max-microvolt = <2040000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_s5a_0p6";
+		};
+
+		vreg_s6a_0p9: smps6 {
+			regulator-min-microvolt = <920000>;
+			regulator-max-microvolt = <1128000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_s6a_0p9";
+		};
+
+		vreg_l1a_0p75: ldo1 {
+			regulator-min-microvolt = <752000>;
+			regulator-max-microvolt = <752000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l1a_0p75";
+		};
+
+		vreg_l2a_3p1: ldo2 {
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l2a_3p1";
+		};
+
+		vreg_l3a_0p8: ldo3 {
+			regulator-min-microvolt = <480000>;
+			regulator-max-microvolt = <932000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l3a_0p8";
+		};
+
+		vreg_l5a_0p875: ldo5 {
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l5a_0p875";
+		};
+
+		vreg_l6a_1p2: ldo6 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l6a_1p2";
+		};
+
+		vreg_l7a_1p8: ldo7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l7a_1p8";
+		};
+
+		vreg_l9a_1p2: ldo9 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l9a_1p2";
+		};
+
+		vreg_l10a_2p5: ldo10 {
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l10a_2p5";
+		};
+
+		vreg_l11a_0p8: ldo11 {
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l11a_0p8";
+		};
+
+		vreg_l12a_1p8: ldo12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l12a_1p8";
+		};
+
+		/* L13 is unused, but min/max are 3000000 for it. */
+
+		vreg_l14a_1p8: ldo14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l14a_1p8";
+		};
+
+		vreg_l15a_1p7: ldo15 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1704000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l15a_1p7";
+		};
+
+		vreg_l16a_2p7: ldo16 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l16a_2p7";
+		};
+
+		vreg_l17a_3p0: ldo17 {
+			regulator-min-microvolt = <2856000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l17a_3p0";
+		};
+
+		vreg_l18a_0p8: ldo18 {
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l18a_0p8";
+		};
+	};
+
+	pm8150l-rpmh-regulators {
+		compatible = "qcom,pm8150l-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+
+		vdd-l1-l8-supply = <&vreg_s4a_1p8>;
+		vdd-l2-l3-supply = <&vreg_s8c_1p3>;
+		vdd-l4-l5-l6-supply = <&vreg_bob>;
+		vdd-l7-l11-supply = <&vreg_bob>;
+		vdd-l9-l10-supply = <&vreg_bob>;
+
+		vdd-bob-supply = <&vph_pwr>;
+		vdd-flash-supply = <&vreg_bob>;
+		vdd-rgb-supply = <&vreg_bob>;
+
+		vreg_bob: bob {
+			regulator-min-microvolt = <3350000>;
+			regulator-max-microvolt = <4000000>;
+			/* tavil-slim-pgd will request 3300000 */
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+			regulator-allow-bypass;
+			regulator-name = "pm8150l_bob";
+		};
+
+		vreg_s1c_1p1: smps1 {
+			regulator-min-microvolt = <1128000>;
+			regulator-max-microvolt = <1128000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_s1c_1p1";
+		};
+
+		vreg_s8c_1p3: smps8 {
+			regulator-min-microvolt = <1352000>;
+			regulator-max-microvolt = <1352000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_s8c_1p3";
+		};
+
+		vreg_l1c_1p8: ldo1 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l1c_1p8";
+		};
+
+		vreg_l2c_1p3: ldo2 {
+			regulator-min-microvolt = <1304000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l2c_1p3";
+		};
+
+		vreg_l3c_1p2: ldo3 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l3c_1p2";
+		};
+
+		vreg_l4c_1p8: ldo4 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <2928000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l4c_1p8";
+		};
+
+		vreg_l5c_1p8: ldo5 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <2928000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l5c_1p8";
+		};
+
+		vreg_l6c_2p9: ldo6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-name = "pm8150l_l6c_2p9";
+		};
+
+		vreg_l7c_3p0: ldo7 {
+			regulator-min-microvolt = <2856000>;
+			regulator-max-microvolt = <3104000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l7c_3p0";
+		};
+
+		vreg_l8c_1p8: ldo8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l8c_1p8";
+		};
+
+		vreg_l9c_2p9: ldo9 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-name = "pm8150l_l9c_2p9";
+		};
+
+		vreg_l10c_3p3: ldo10 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l10c_3p3";
+		};
+
+		vreg_l11c_3p3: ldo11 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l11c_3p3";
+		};
+	};
+};
+
+&pm8150_gpios {
+	vol_up_pin_a: vol-up-active {
+		pins = "gpio6";
+		function = "normal";
+		input-enable;
+		bias-pull-up;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+	};
+};
+
+&pm8150b_gpios {
+	vdd_boost_en_pin: vdd-boost-en-pin {
+		pins = "gpio12";
+		function = "normal";
+		output-low;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
+	};
+};
+
+&pon {
+	mode-recovery = <0x1>;
+	mode-bootloader = <0x2>;
+	mode-rtc = <0x3>;
+	mode-normal = <0x20>;
+	mode-panic = <0x21>;
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
+&tlmm {
+	/* gpios 0..3 are NFC spi, gpios 126..129 are FP spi */
+	gpio-reserved-ranges = <0 4>, <126 4>;
+
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&usb_1 {
+	status = "okay";
+	qcom,select-utmi-as-pipe-clk;
+};
+
+&usb_1_dwc3 {
+	/* U-Boot has no driver for the SM8150 QMP USB3/DP PHY, and the
+	 * DWC3 driver fails to probe if any phy in the list is missing.
+	 * Use USB 2.0 only, like the working raphael U-Boot DT.
+	 */
+	phys = <&usb_1_hsphy>;
+	phy-names = "usb2-phy";
+	snps,has-lpm-erratum;
+	snps,hird-threshold = /bits/ 8 <0x10>;
+	maximum-speed = "high-speed";
+	dr_mode = "peripheral";
+};
+
+&usb_1_hsphy {
+	status = "okay";
+	vdda-pll-supply = <&vreg_l5a_0p875>;
+	vdda18-supply = <&vreg_l12a_1p8>;
+	vdda33-supply = <&vreg_l2a_3p1>;
+};
+
+&usb_1_qmpphy {
+	/* No QMP USB3 PHY driver in U-Boot: keep it disabled */
+	status = "disabled";
+};
+
+&ufs_mem_hc {
+	status = "okay";
+
+	reset-gpios = <&tlmm 175 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l10a_2p5>;
+	vcc-max-microamp = <750000>;
+	vccq-supply = <&vreg_l9a_1p2>;
+	vccq-max-microamp = <700000>;
+	vccq2-supply = <&vreg_s4a_1p8>;
+	vccq2-max-microamp = <750000>;
+};
+
+&ufs_mem_phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l5a_0p875>;
+	vdda-phy-max-microamp = <90200>;
+	vdda-pll-supply = <&vreg_l3c_1p2>;
+	vdda-pll-max-microamp = <19000>;
+};
diff --git a/board/qualcomm/MAINTAINERS b/board/qualcomm/MAINTAINERS
index 3767a2a7949..501483597dd 100644
--- a/board/qualcomm/MAINTAINERS
+++ b/board/qualcomm/MAINTAINERS
@@ -22,3 +22,8 @@ QUALCOMM DRAGONWING QCS9100
 M:	Varadarajan Narayanan <quic_varada@quicinc.com>
 S:	Maintained
 N:	qcs9100
+
+XIAOMI MI 9 PRO 5G (CRUX)
+M:	Qing Li <lqing2013@gmail.com>
+S:	Maintained
+N:	xiaomi-crux
-- 
2.50.1 (Apple Git-155)

