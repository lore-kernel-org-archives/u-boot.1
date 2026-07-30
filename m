Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC80C55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:18:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1EA43810CF;
	Thu, 30 Jul 2026 14:18:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lEgueCwVoeAi; Thu, 30 Jul 2026 14:18:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 116AE81152
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785421126;
	bh=0mdjnwykf6mexMZcrrfxa3Cf99MqYekgOh2Va7XXrfY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RMBJIrtQ3cbqgIJvH7FEuP70aK/yc2JDsVqvkJcLYjxxwqwUWcezzzfCFJokRx5uI
	 nMp7JgcjJcntPq3e2+ZKQOXEfFtWWUUyPbcFAq+bNj2cQ5I8q90V9JnPCZ/zfooLMA
	 0uola76WdTxulDWrj2AS2RtAvflqKeUyzFwCzgr2b3dEJcD1OgeX1QlQPbTEI/Wu+r
	 Q6vMmVpsjLbErWiiMRHlsJize6BwADqiqTTUHN/WsXN4XpA189JMR4LPyuUkQLbaB8
	 AWXaAUYOt7UB5q9AmQYQeiQES9H2Qs0agls3ZhqcyM6TBNxZcGCljKRJlwLJz8Z7os
	 kR9DBbw1iLlOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 116AE81152;
	Thu, 30 Jul 2026 14:18:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3FA0A27C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:18:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 259D440BAB
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:18:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L2p-YCEzTE1i for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:18:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2034D40B56
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2034D40B56
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2034D40B56
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:18:42 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c15ba3a2b4bso261262366b.1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 07:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785421121; x=1786025921;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0mdjnwykf6mexMZcrrfxa3Cf99MqYekgOh2Va7XXrfY=;
 b=Omfc13KBi57D8Uf1PtzspDfGU5DQxYrmQ/fr9jGSOrukZDYrc8IogeJwL0bFCYgnsh
 FEUEvCiEXC5l6C0v5ySye4RxtMcLN7+hgOJpfvDoE6bRf1jrkfRYE3N1/gOJDUui22FA
 sKz0yv0renF7657ANzL9ELgHbIEpi04PpGpFWWnT5IOD6Bc4d2lSCK3+xJB+MJOdUhVM
 dBbOPDoob5VQRMQ8bMr2Nn80wNYGzHK7SZ+TalJQ034RoS1GnujgglYlS3U/XAu/Deoh
 URqjWZHPElNOEyicypo3O0vPIjzCq58VxcX0OPRe7LcByNcymqloP/+UjytGa7tJLS5z
 fldw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpBT9i/jUVFAlg+2/W+PZ0fWhXpnuGianZ8TnV1x0Ukb3jA6GdTtTy8BGYcOUn7oRZKT39B2LU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz+4f2Azoc0bNQPdh2Ql20ILY1MVCgRsSO70IP9lAguLHb/C7U6
 VAqCFrEtQ9Yx5G4Ol6yOjGcHA2pCE3TCVtOMYf7YwRYNWlXuVakEh2x0UKOFUBUnK0A=
X-Gm-Gg: AR+sD121XdDfLJVLRMSSgA4Y7RnUv3pMHO678G9hQDYawWTv/wtf19DOi89tVE9r8Qr
 ufGSAKlIgXYmLSpI6ImzokDEwcBZseZ9UCWFNzyUpCGTgbddAG+qbFScFofbdopCb56oSHWMj+/
 bQ+wUOThTehX+6IIZ3V5J2L/LGodV38boG6gj3P9TXUpGu1ORxXJj8f2hQQoCgCWJd0J2JD2oms
 YSw46v90aD93YEDUahzL8RfCH9I7TAR1eMCO4zg30ne/n6/1LlcobzXotKXpf7lcj/rKgXutWX1
 4xJkukFE94qtSZzf0G73wTkvGX0l2LxGiUT73JgoY1r7vcQhauYeFDUgslsli1xL1+ZD46QQQQE
 eDMnCDa6auAdMq4Ut9uQKWtS2sesdu2OxDxLpLB9tuR53b9YNuMpkWdvjFhfv9bmw/B7iyy2VOS
 QgFwo0SIKosZf+tNK4ofwqzslELyR6TYZgy/z3+AY/JJ0YFMvovY5CKBDKi1hE7tkXas/USzyPI
 udF0ERHBWz0xWTkIyBAuaj0P3xDFuQc479l2YQ60UwSEzXAMkjqk2QMKt+64ScS8KoL238d2i2I
 fXbQHQ==
X-Received: by 2002:a17:907:e1cd:20b0:c1c:4d19:f733 with SMTP id
 a640c23a62f3a-c1fbcb4a409mr28632666b.40.1785421121000; 
 Thu, 30 Jul 2026 07:18:41 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.retail.telecomitalia.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa851b369sm78608266b.9.2026.07.30.07.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 07:18:39 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 30 Jul 2026 16:18:10 +0200
Subject: [PATCH v3 4/6] arm: dts: mediatek: support signed Genio 510 and
 700 bootloader FIT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-ccaione-upstream-mt8390-spl-v3-4-82fb3bca27a4@baylibre.com>
References: <20260730-ccaione-upstream-mt8390-spl-v3-0-82fb3bca27a4@baylibre.com>
In-Reply-To: <20260730-ccaione-upstream-mt8390-spl-v3-0-82fb3bca27a4@baylibre.com>
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
 Alexey Charkov <alchark@gmail.com>, Julien Masson <jmasson@baylibre.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785421121; x=1786025921;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0mdjnwykf6mexMZcrrfxa3Cf99MqYekgOh2Va7XXrfY=;
 b=ARY39MRgZw/NzfcQtD5NS0Em8iSEv9yjm6JDV8gTkWk29i5e+91CbnGfQtYGnD2fA/
 lUfY0CTMb49NjIIPsqq1P7hPmvj1o43SvzxGwilw11Pmdo2wsot7cN5JeJ0PL3G8uusc
 N3OIpS03bEeQG5AmJGMkY3j2StSCS/KvHvH2I4/WLmcfohW8IdM6PPKFqLEGiGf7wyGV
 oqmgkRMLMzAN6OV/iVCaOhlcL9Jz6eZmMYlektWSjYSpsmdGZ5eZ1ngwoaqoEwO/VWBd
 EIGo9tTmYuneL7d95m88XvbDMkvf87Zdl3V+t2dk8lM5AAyY2FExd5SlWMCJGwEi+GT+
 koxA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ARY39MRg
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
 arch/arm/dts/mt8390-genio-common-binman.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/dts/mt8390-genio-common-binman.dtsi b/arch/arm/dts/mt8390-genio-common-binman.dtsi
index c16282027c6..1fa5502c17e 100644
--- a/arch/arm/dts/mt8390-genio-common-binman.dtsi
+++ b/arch/arm/dts/mt8390-genio-common-binman.dtsi
@@ -31,9 +31,25 @@
 					size = <0x4b000>;
 				};
 
+#ifdef CONFIG_SPL_FIT_SIGNATURE
 				u-boot-spl {
+					type = "section";
 					size = <CONFIG_SPL_MAX_SIZE>;
+
+					u-boot-spl-nodtb {
+					};
+
+					u-boot-spl-pubkey-dtb {
+						algo = "sha256,rsa3072";
+						required = "conf";
+						key-name-hint = "bootloaders";
+					};
 				};
+#else
+				u-boot-spl {
+					size = <CONFIG_SPL_MAX_SIZE>;
+				};
+#endif
 			};
 		};
 	};
@@ -44,6 +60,9 @@
 		fit {
 			description = MTK_BOOTLOADERS_DESCRIPTION;
 			#address-cells = <1>;
+#ifdef CONFIG_SPL_FIT_SIGNATURE
+			fit,sign;
+#endif
 
 			images {
 				uboot {
@@ -120,6 +139,14 @@
 					firmware = "atf";
 					loadables = "uboot", "optee";
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

-- 
2.55.0

