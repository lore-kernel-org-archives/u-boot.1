Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D3CC5DF6A
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 14:48:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 446F840F36;
	Fri, 14 Aug 2026 14:48:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oM62077zk3Xp; Fri, 14 Aug 2026 14:48:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3A3E240F2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786718899;
	bh=DLkUaaTAanazIDZlvBA81sb5gj7roJkWnlq29KYAeRk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wZ+R9L3xulp1AM+fKmOfqzz0vrUMzgUyj+7xxKpbFA4tEJUsAfRclUNGPEwb8V1p7
	 1V6hf86mD8PrtW9TfTsscIy8GtZazAOH6+WGAQuAIHGd65FjmvxlMLdpvCA8YWJTXr
	 aayZ1ORQ5qIjHhZaWtlW4jImNkTTV0jFBKERP9suDInJYvmw3dJ6fB7uQ5nTxmAFtI
	 muB7p+vehq9IJOU65eOAxVFmA0kilhp1dS1Nrh6oxsqX1CesHfxBb1zwvi5ozLl9h1
	 gvxP7Xo/oOCsuy7S7kA9ej8QhWee0c7IqrkuaujJHatPQbaDCDwbM7ey1wHOtP0ZDB
	 foV2I0PfJ7MvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A3E240F2F;
	Fri, 14 Aug 2026 14:48:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 90DCE33B
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:48:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7728A60866
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:48:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SHyNQfdikx9W for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 14:48:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7DE17607EC
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7DE17607EC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=WVj2GA8H
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7DE17607EC
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:48:14 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a051b737d8so1134176a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786718892; x=1787323692;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DLkUaaTAanazIDZlvBA81sb5gj7roJkWnlq29KYAeRk=;
 b=WVj2GA8HgBRhyPe9p/G4VPcgbFKiwGotyROQX4Ia4m1ff/2T6zPXUvF9gODVap6LfK
 NSc1DY7DtQJqfpLl65SoZpNoy7OadllwbPaA3W7EVoo7bWa5cSEkJi5BMh0JdSo/EmmO
 NpTOuB/Dd2CHUF5NZ32zYoXt8ihqbdJY2wKd83y+85NGKItdmPOJI7dLexXSPVp3U4YA
 c730kmO2XqBLzLp7zvdBhMhNFybBRV4eV4mL8TTmiG30lsEjlh/n5yba/fG2e8FHljGG
 eWzPqaLyUzrXe3KLkGNUpW72xIfh3Rj56x5uJ0z47uMCDERx1FygpZQm8aDvuFYDUKBo
 carw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786718892; x=1787323692;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DLkUaaTAanazIDZlvBA81sb5gj7roJkWnlq29KYAeRk=;
 b=V24s2ylMnrrooaR52hrQ9lZioduwHCwvjbwJt/Vdl34EZeB+bPYo2brEc9SZ7FtWOf
 sDfy4TECqcwJwY2bjXX4oxUCLc53jH4L5CYCLAhkRSxTZA3UXS3/UFsOKXXjmbdz8uj4
 5Dzy2Npsp5rCyOoX50ocYX1M5rVvgOJU7qFJdJ7Hm4ElFaOrb24681I+7/QncnejQWBr
 1pnn6TW6knZvRrPnNm5gci9+nnNWdlzdLetd+AsWbptJf22zBHrKH9mOfaoXj3D2SC5e
 sKkb3J5pmQcOustGlbINT/d45jUAXYz8ZQHHqUVSKodiEJAJt/KD7nSReymM3QedmQ8i
 1b5w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRCb6OtjS0u8hPRwvapLlcpEDH+v05mBul27exoACIwmb2BQNdlAKlrhOMW8UuFFNFtnvWcAY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Ywi4IJ2QgtzvOoA7y3DJqYLL5Zg3ECcWrparpCPL5K/hCzEztm9
 iCjrDKYeHcp/azSgcbIzAJeaomB1trjEGA4F1uUzxFDY/cwoe9M6W+RPMM3ZYWRyCG4=
X-Gm-Gg: AR+sD10EEa0bx9IXIwHhudtuJamLlj7v8TpHsA/qOmuBs7uXfNCBMklTCHjVtzEET0u
 gugEgbbJnfDnBwtpd+/harf2DhM29sb40MTFWEih8RFNcvaG5Q6waTC0c/N9GtSNAr80WRgPqYz
 4AEQK/9cI6ESgMb4pxpHxdVPiHVkC5JIRgDOKCpDGxk+zd8jiYs8/WHQ/2pf4eSimNcSmQvi33r
 CF06XgxaUgyvmX0w169l1FuaWrjuf/o5C5vmH9B/CcOA96QyuZXT2SRS9QOYE2fWNeI7FZb3nb/
 qPH1pDbunX+sLpLdEf6JXtIeCrLVIKD9QJo8DqepxHvoDSANK/Fn1XgT/R4TkMAgxDrhV1KRtTS
 LmR84zz/Av4XE4yJ+B8A69hZccejBzHBPRuc3+/fKEULv4JDR46H5BnQ4Gax8BY1MZvsfEjYwjB
 JDwJL25UjW9IiMVPEDY/PGWlWD5tJbB04epj42ZpBNapiHa9qCrmmu0+rkZxQx+cWW5NV/HTbEU
 RgKxCp2GkCxJMJSDlaPUh5/Iugu/HkacDc9pZz7odNYYGzPQcQhJhZ8j0o=
X-Received: by 2002:a17:907:8b90:b0:c20:5797:162c with SMTP id
 a640c23a62f3a-c212a2661b9mr287774966b.16.1786718892120; 
 Fri, 14 Aug 2026 07:48:12 -0700 (PDT)
Received: from macbook.tail959722.ts.net (static-226232.rol.raiffeisen.net.
 [195.254.226.232]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c212378d9fcsm114992666b.34.2026.08.14.07.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 07:48:11 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 14 Aug 2026 16:47:54 +0200
Subject: [PATCH v4 4/6] arm: dts: mediatek: support signed Genio 510 and
 700 bootloader FIT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-ccaione-upstream-mt8390-spl-v4-4-f4f92978a79e@baylibre.com>
References: <20260814-ccaione-upstream-mt8390-spl-v4-0-f4f92978a79e@baylibre.com>
In-Reply-To: <20260814-ccaione-upstream-mt8390-spl-v4-0-f4f92978a79e@baylibre.com>
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
 arch/arm/dts/mtk-genio-bootloaders-binman.dtsi | 11 +++++++++++
 arch/arm/dts/mtk-genio-loader-spl-binman.dtsi  | 16 ++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm/dts/mtk-genio-bootloaders-binman.dtsi b/arch/arm/dts/mtk-genio-bootloaders-binman.dtsi
index c43d8c32507..de97b2c3705 100644
--- a/arch/arm/dts/mtk-genio-bootloaders-binman.dtsi
+++ b/arch/arm/dts/mtk-genio-bootloaders-binman.dtsi
@@ -12,6 +12,9 @@
 		fit {
 			description = MTK_BOOTLOADERS_DESCRIPTION;
 			#address-cells = <1>;
+#ifdef CONFIG_SPL_FIT_SIGNATURE
+			fit,sign;
+#endif
 
 			images {
 				uboot {
@@ -88,6 +91,14 @@
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
diff --git a/arch/arm/dts/mtk-genio-loader-spl-binman.dtsi b/arch/arm/dts/mtk-genio-loader-spl-binman.dtsi
index e49ad5c471f..30de2ec621c 100644
--- a/arch/arm/dts/mtk-genio-loader-spl-binman.dtsi
+++ b/arch/arm/dts/mtk-genio-loader-spl-binman.dtsi
@@ -11,6 +11,22 @@ ddr-loader {
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

