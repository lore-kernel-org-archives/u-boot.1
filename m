Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73502C79FA1
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 15:30:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22E9D80C1E;
	Sun,  6 Sep 2026 15:30:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LDtJpNeVH7lx; Sun,  6 Sep 2026 15:30:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4EBD780C16
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788708636;
	b=Fj0noU5VE+DFPDtE/ixwloCkej0P2OYbPUJNZX/hKwWopmAO7QxWFVcL6QEqf7wvMXcb
	 gvwZs6skH5llwIQuc+D2i/MMure8XhTPfRQ36X6ynTPcdQ0mzr4R5YcaOgCoTizNPxVfv
	 6XKUuhUDmggCqbRuZoaz+ML0e6wpTCEwthUpLe2pJh0nF1ydWdqxh7EkbDFOpFIVoiZ0u
	 rmgtSisLtZZ4yPomoqa0rLc/ENPnJFpclmEkSZL/slsZMEfl83hH0L3gD4tPa3w5q64Ic
	 boRjnV7Zjfyq5N8M2eeUE+bIMuA1MVBxspboslw+/vvuQvNZJUznxv+NzzRtnuMUHXA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788708636;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bffQrxC9V6Ve/xv2+OZ/tWr6o0vze7CAY6iB6wxouvA=;
	b=DONVIScsRW4APQMuEwgypeCaEWpXp1WREsH7QmKomSPy5HRBeEr9h/dHNn3d0yBrbKOd
	 faAFJ2DHxNwwbJIl0VYBvVbDFuQBWMD29LsE4X2ZVXTKFscAJbQ6q33gitFJ+dvBzcnPc
	 goNnyhWb3SOt+6Iav+n9fLnpU2f+ApBY4uR78HkPwzIsXJZbTPDGFF5/xN5MHzwHhXxod
	 R3i4WrOiYrai7eaBcnKjv18G+KIjpsezm158fQ3AUpWA4BBvfd1NzsFIA4tZHiTjvA+t3
	 6iMbg2vnkakfFwUOw9SVrn0qbIxT/caUzwXHqEmDp4h7lQ+EUd//RRyEU2nLGwPsPGQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=e9bQSVxU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788708636;
	bh=bffQrxC9V6Ve/xv2+OZ/tWr6o0vze7CAY6iB6wxouvA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iH4fzhT236HTeMk7pA2hwbwYl8ImEIX7Q/APOlKgQphyFobA7MnFHArfibanN/SxO
	 gXUsHwifDxdLIbOMLj/i8GhsSeoKPnDQ9yYacMcIh3YMawGlYf/lfuEJb9j+fU7BpP
	 sTblx8WYjsZ6+XHP3Nxs3wgDjSFvoFmgsMLzJYGH+YqBUEKTwNcwRz6MszzPtb9/9d
	 /PgnkZdhiO8ng3a8vLx0mgD5oOltquweRAVNW3LaRfanUKF12iIEECSzW6YcluZrk2
	 plT/s0NyBdZq/zZMM+NCj2vnV6HG2NeFAuruN8WpZC3mQEjmMFQOu1w8TNCeDYQWcs
	 Zd6Ch7jpzARZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4EBD780C16;
	Sun,  6 Sep 2026 15:30:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 892A7388
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 15:30:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7222C80BCC
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 15:30:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ll43i6_OxDM5 for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 15:30:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 51CF080B9D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788708631;
 b=sx73aYuQiTmgwyEEsQX5P3mDYNuPamIV/bKsHVJvfYpSDHcEEt6v5pOW2WU2ac9qqc6Z
 li/lFBcSKSuX6+H1WtMtgdGScULRPjwRwOe6kflYaTRjgLijUV0QODDIFtI1r5s6e1Mgn
 TQidtnk+wJbkLWX+4FwLisurmCqIAbGQIKlgj5mYT0zYIhRTXM6iaN4O26+NquT3f1Nrn
 /3akATu+e7e8+Shqe8oojPwzIiXNGZ61x0T9NxqwTs1tcEDplRmO6zEZqV1CcU8tuTllf
 MNq9INpKidA6xdKxHFxyWFPh6Jl5nfmlxQ5tygQq1/V+wNGOHH5c57iWSiItbumqTKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788708631;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=bffQrxC9V6Ve/xv2+OZ/tWr6o0vze7CAY6iB6wxouvA=;
 b=X34SWahKiTRCkggiKtwZAVwqG249PDDYhvB6GHeJeP55BAyjlkeomC3CAI/KIq/3LMri
 lai/lyfdmackc7YY0IxcNujtndKpyYypSg6buDKd9jTTgbRI85WyE9RyL90k+ANJeIvDt
 +X9LrlR9Dldadystjzc2c6DjNDdZqL8MWjQB7M7dt1q3M3h0hw/oXBgUbhmXulF7sgMCA
 cYlSNUdi2Ymp8zUiFoIBEiKBC0RUJE811KKq+9ngDji+NMxXszCUQJrwG/YKr5j1SNx3d
 fTDxiM4EvorgpyCKQfEKSh9HA0upxUWdwBJ+ip+kDNqpzXPPztdMhoRno4AwaBuzOWw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=e9bQSVxU; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=e9bQSVxU
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 51CF080B9D
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 15:30:31 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48442ea8f59so3078503f8f.1
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788708629; x=1789313429;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bffQrxC9V6Ve/xv2+OZ/tWr6o0vze7CAY6iB6wxouvA=;
 b=e9bQSVxUbIPT4fJU7JctUCVTbimv3X2P/LARGIbg+s7Q87NnF7weZETb3/5TRr6WyA
 8+zKou7vZ+d6fTeKdH5Sm6MFvyYR12sji4gy+B7t5keIm7oGzIAA1aE8aOTqVxdUeTnu
 KxhZ/K/9LA1GyLZKQXVdiwYdCn9qLzGxQTeX9JydvsQ4Yy6HCoqaWBaqnkf8YPnHq0np
 M6uXzR6G6WolPP2gcyrHF51edyckXL4JUjPB+HVVraTB4D1ohJha9NDoD7T/PT10ncgO
 bqfQ9hPc/3D/liWxJcUQnuTSb7Wuvgy+KoAgTln2gwObmsvgsOFJnMaIg842SLuSr5gV
 wxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788708629; x=1789313429;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bffQrxC9V6Ve/xv2+OZ/tWr6o0vze7CAY6iB6wxouvA=;
 b=UHvG8zWEnad2J0h8gwyUUtv5HsGA1jHw3w1tV52lWVCSHviYg9kwE3taWt51i681Lg
 fKxyDmAWKMAuDtws8jxu5eSlcRMB2z1Bi3LsnAijdkTqt7+SpPjdp/aOh1tfmk2PYj5H
 cdJZp0UUxWNjsJV+6p4hcEBzyUfbH1uWLZmQReGAnTerOMfXWpMg8x0yEBJ/85oAP60+
 Fidzx1M5+ITijUR6lZlHr3Hktj9fxI6F3PsHtUwnp8a2jiiIf8BW6qOjtqexI/N4dCKF
 4dp8HKgZ9qulcxgx8gWkDbi7TrtwFdpffEscrR4t0Lculene69cSzemj9z/hP779BVt+
 VfHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBybtF+Q2dXgdKjS64tzii9k9xKa/Oga6lLW34aJIIfrmcphn1Ni8K7N3y7Q14ravuHolLia0UM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kIbunbQ/3XWZqfzqCMuTVeqJBF7gMEsosX1K34EM0Dg7ngXVwf
 OzK1v7zZM0Bj92OV/yELPbI/E++NUJXK0OLa1VuazjdWI+c6qq7mY/P9r0QEzQbKYsg=
X-Gm-Gg: AYBFou18vOUW3raQrwjiG3tIsxEGtKk15ZXlL4lnUnzJOZI/vq0dNv49QtGhXnFvzGB
 Xx4YEe1yarHUNhbHSpaipiIp3pd5rBQg6Y/EeiHqqRIgTTr6T6iz1VBbFpBvKOaYNnB1v6A3VBM
 lrXbOpikedIU7VarVxkoNchXgjb+DEZqyeaadYqJptvBmTdYydSA5BbaLqQ8pLs9nB0ImsHMv5Q
 EjSLdY9oSiisRpSaeW5u257Ta3lQ4SG5koMINWthMyOmQDlaH/Camty7CQMUfBBZHz7/vP4cLj4
 u9kWpOG6W2EKPv7E1AQDYfiKA7sjSkkc5iYoT2B+NiBI7/80cLI+OkAZlI6KSGyKqszO+ErKQdQ
 CRD/aKDzMWTsLCLX6tQTYmcO7RkoqH2wQVLdsAeCglt73+6pLnXqQ8APG2Hy7AhiSOcsxmsl6W/
 hIl/DAWTSbY4QEeytj6LvRtyVVULGh9SLUHdKl/rLH71Q8PS/fTRi5/TncNPjCHSGCpAPW7xdma
 4CSeQuiDJdR5CIqPqf7YocZ2/iFnGJQo0gGHlU3yZYoVrICNk2nCw==
X-Received: by 2002:a05:600c:5397:b0:49c:e37e:4389 with SMTP id
 5b1f17b1804b1-49cf82cba17mr158467655e9.4.1788708628690; 
 Sun, 06 Sep 2026 08:30:28 -0700 (PDT)
Received: from [127.0.0.1] (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf770fcf5sm238069605e9.6.2026.09.06.08.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 08:30:28 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sun, 06 Sep 2026 17:30:21 +0200
Subject: [PATCH v6 4/6] arm: dts: mediatek: support signed Genio 510 and
 700 bootloader FIT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-ccaione-upstream-mt8390-spl-v6-4-4d4a11d5741d@baylibre.com>
References: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
In-Reply-To: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>
X-Mailer: b4 0.16.0
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

The unsigned bootloader FIT only provides hashes, so SPL cannot establish
a chain of trust before loading BL31, OP-TEE and U-Boot.

When SPL FIT signature verification is enabled, sign the complete
configuration and require its public key in the SPL control devicetree.
The configuration signature covers the firmware, all loadables and
U-Boot's control devicetree.

Use binman's u-boot-spl-pubkey-dtb entry to inject the key while
preserving the fixed SPL region expected by the external DDR loader.
Unsigned builds keep using the existing image layout.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mtk-genio-bootloaders-binman-u-boot.dtsi | 11 +++++++++++
 arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi  | 16 ++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm/dts/mtk-genio-bootloaders-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-bootloaders-binman-u-boot.dtsi
index d8aea85f47e..cbf35b7a353 100644
--- a/arch/arm/dts/mtk-genio-bootloaders-binman-u-boot.dtsi
+++ b/arch/arm/dts/mtk-genio-bootloaders-binman-u-boot.dtsi
@@ -13,6 +13,9 @@
 			description = MTK_BOOTLOADERS_DESCRIPTION;
 			#address-cells = <1>;
 			fit,fdt-list-val = "u-boot";
+#ifdef CONFIG_SPL_FIT_SIGNATURE
+			fit,sign;
+#endif
 
 			images {
 				uboot {
@@ -91,6 +94,14 @@
 					fit,firmware = "atf", "uboot";
 					fit,loadables;
 					fdt = "uboot-fdt";
+#ifdef CONFIG_SPL_FIT_SIGNATURE
+
+					signature {
+						algo = "sha256,rsa3072";
+						key-name-hint = "bootloaders";
+						sign-images = "firmware", "loadables", "fdt";
+					};
+#endif
 				};
 			};
 		};
diff --git a/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
index c97797405b7..2dd13d261a0 100644
--- a/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
+++ b/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
@@ -12,6 +12,22 @@ ddr-loader {
 	size = <CONFIG_MTK_GENIO_DDR_LOADER_SIZE>;
 };
 
+#ifdef CONFIG_SPL_FIT_SIGNATURE
+u-boot-spl {
+	type = "section";
+	size = <CONFIG_SPL_MAX_SIZE>;
+
+	u-boot-spl-nodtb {
+	};
+
+	u-boot-spl-pubkey-dtb {
+		algo = "sha256,rsa3072";
+		required = "conf";
+		key-name-hint = "bootloaders";
+	};
+};
+#else
 u-boot-spl {
 	size = <CONFIG_SPL_MAX_SIZE>;
 };
+#endif

-- 
2.55.0

