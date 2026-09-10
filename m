Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160E6C79FB7
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 06:26:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D48E860824;
	Thu, 10 Sep 2026 06:26:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DKtjJ1j4-bAg; Thu, 10 Sep 2026 06:26:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 131F26082E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789021586;
	b=Hi0Ktk9vJuAxJsD9mmKv0pBzrGuFyUrVOKzdNCFk2GZK2lJpDSTm5++VEYD3VPLRACsm
	 SGjjqcoZWNEpqgCPdJhCvLXHIXMO+7W1FE0apZpkL6SEMfnSNfF1x8Q97UTa0d+0sMLNU
	 1YbYzZqJlCpRWpnfJ7Puq398bvGCRUtGPHXqXALoQejHorNLfCtrQbox/2TRW3g2/rQFC
	 rLE/zCJ4EKgkrPqMGI0sX0qM0XDsMfon2J9Zemmn334xiOjnLrKTksWZFnI7WTh4fFpUI
	 0YuM/00D2+xZXnnxuxh4bkmDVHmoGmWNUqzcrVqY1nQVwHtl753n27PhnNqNBnha8RQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789021586;
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
	b=NOuwv53KCYAXJWwhYQACSIxLc0JDDv6ASIOZrGyoEOARQj0jMZIuxEHIxSncRHbQ+X1M
	 IodWxD5BmnDQBDKbef7a0oy7f5i7Sb9KGJ9pWwZ3WguGMdduXrmrU8XEnN5Vsx+uZiJGo
	 5Y1cxj0J8VaEXor7vO73tB99KGDWrfY3xWCztQKREKVVObFo5t3dqXI4bs61WdoJ4a/UW
	 Vj9nJn6m58V2O1bslfIzcKa6QaD042SsSU3STM6v1L43typ/Kwx3QL7wzTqqrY+BaeI2A
	 WpVNsFJv493WwRVIBJ0+vG6RTFm4Jilm5qecMZzAw098loTbA1wG8rF2H7Bhl286yPw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789021586;
	bh=bffQrxC9V6Ve/xv2+OZ/tWr6o0vze7CAY6iB6wxouvA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p5qp3smIT/waplgb9CzsM+DpzopEf8PMGrx211E5oemlF4hUHIS+T9kb2AlVXFzxM
	 NIVxniG30gnpD5mPSZzAs7h/fAn+1KQ1Q8Je2XjKEOjYW1mLZ1TkJUtmOZGhWlUtKd
	 sCZuU6eqItcxIj4L5RkUmLSawrKeB503BfheoDE0lRBmJlY11ubQsI6txQrP6ASgJA
	 k6Vf8Ffu56EpnyX5JXwFAkSBEZpFLmQmT7Ka93Q62QNoKvvfHenRytccLBgqb47pq8
	 8expFTijTqhVieTs0ja0RUIjbmMvz4Jtes+5DThc6iyrdWQXWts90yLaDZWTYpaUKT
	 PZwrLjAK3x7yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 131F26082E;
	Thu, 10 Sep 2026 06:26:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 46BC314C
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:26:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24812407ED
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:26:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zUkacUoVoD_M for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 06:26:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CFD9540847
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789021578;
 b=KrcEMUg98PuO/weH3Za7LDY3f/qTsUkl/V3ivK5QrMFmOY3tBCqEAC8EfPGWKe+x4NsB
 dUmbsUmnNHAdjYtBZqPRYuAoGytu6gQmX5+2XHDCedSSEPJhX5IISQawV2JxpPyBG55Kc
 Fl8vP0eA5WVTDekv1kOTZkIq+iksgcd/mHpchAT+8o1/wqQfSfxBc5HAvoNJIleH/juYL
 R+xdeYWw25tAJuGZIFO+m4AIbH1UhsI82jkk2yfwod2kwSweH+vU20cF/ciMnlCMdntUb
 eNntiZKqkwL0n+xBtykJJPMynmXplbGfmWgh3ouiMUPge63mVOpV45l7LwUXuVGmzzg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789021578;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=bffQrxC9V6Ve/xv2+OZ/tWr6o0vze7CAY6iB6wxouvA=;
 b=mg/+W4WfejcPAFxHENDI+Bj1gu4UlKMrT3j7qLkrV2mZMKDH8BlW+J46PHBUPq6MSAIo
 fPiR/JhtV2+ZtguZdRg+t4LP951cJxcGAj/uZqPJ5ojaPdYhTRLQZOE0ul905Ma2MmNQK
 sKo/nDwBhMdeSER2aPmPXIFw+hVeMTS0iiUhTAOayX4Y2DCFlz+yHa48VfWfsrfQqzW3A
 BPHztKeFkuA5NcPtBspUIkyslLQFzwHxhuN/i70HdHCXWjKI5WNrJfblzf0LXPX8VubPJ
 a8pDvYPbRQ19hFsiasTRBc/3ga6Nz1SzDpb1tfqg2XvtkWS0BjMRfDR33K2qs5IRfPw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="J1JS/956"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=J1JS/956
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CFD9540847
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:26:17 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49d0e19300cso4787595e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 23:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789021575; x=1789626375;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bffQrxC9V6Ve/xv2+OZ/tWr6o0vze7CAY6iB6wxouvA=;
 b=J1JS/956M+dSV0GUguHBHSCNImiGdzHA/MdGFullYa6NyOOHQpCvkXmcufhvSxUGUl
 XXNAMG9RseookcFep6uOAWYvUcHBc9s8wNV4NX+rgj52vGyK8cxB92fLmMUcKYYEEYGC
 Cvrgbp0bd8t7mJeu4k6p5PzHGIBEXrx3ExjpeRWolCsviVogrlLHKU6YoE1vnYzpe+Fx
 wWxoo+xaXn6EvrZzunVICkb2awWEKar8CQqRgkQseEAm7bEO+oblYT9LDKgLbWyx6j8+
 AywUZ/Z1L4RIQWTJhtNhKM5N8LFRB1DXPWRaMpJowt4UxaqMAWV8DsWq6v24B+Mf/252
 iraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789021575; x=1789626375;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bffQrxC9V6Ve/xv2+OZ/tWr6o0vze7CAY6iB6wxouvA=;
 b=M5KuF6Z7n9shz9GxQ6LwOAUMWKAyTjUp5lnOXzicmw/wNZFU7q/+Tx4tNMRwyzInkn
 F5HoisK2ksaK7NFP5Z2V7rNCEaZq31Y/MlJdYFeaWkUseWgM6iX8k8KlZOUqDAx6QAeA
 OiyXIXPmXmvneBgzauNSi/IKyv2A/fX4lfnWvxbF5PMm99haM/6YMumFgbEzewPs5nVV
 VizCXebkNi1FX6Q6Fwx/DtT2qv9zit3bRd62WyI5cvyQWKYD8u0Sb4Gba6zBNtruw8NW
 R933Prd89yMx9jrxAPlTwl70VHUwI87xZY9TJiFnPH3olUMXHOOKje/93ead2A14HFG2
 ZDkg==
X-Forwarded-Encrypted: i=1;
 AKwUvBztZt4lRysGYxNLs/jlTzMnaDb8UX8i6u/80Imhz4DkMZt4XgPvjobOmEzjxVWYtGT6B1C7FHY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m/Ta9Ml7JxUlHH3tRm+q4LVbvo0OWeb2pLZl/uCCptyc5p5adh
 HtzOgXTMrAhPoOo/klh+SdkMq4ntJUYmoMdPU7HOqGvMT9psHEXOrv4Egq+EsbaKhUs=
X-Gm-Gg: AYBFou3O2xE0ujZG0t9c88UhExAbOgesdkXWT4vjjZvbAfNdXEAPaVHVg/VNlxljX/6
 k55UOm42UhjRd0GpYUTgGqGhH5dzVfN71ss/2eK0/5fcAYDIsZYGkUsiPURSM4tvyZm7Ff3TrHQ
 rcksqjvpPOdl+8lBYgrgJF8aXDbJPF3nROFQx13A23ooiSeBJRPkxHEiPoHchapMS9HkGoF14DW
 r7T2WOZv8zOJEyERkackFBGq+NsKBCVPKApX4ac1vw9cnweJ9pjow3ciWuES7F/uLjYilZ0PXnu
 9qRXk/oVOCUa4r1u3PBdHrOLAP8bJ4P+qmpRaPIojrtTC7iNuqRkR4x2nZNlOKGQkrL3mcKZyJh
 o8bPs8wgMJ8wuDJ5ZNycGJ4+/h57bRLRIiVoqD8ozpx7FlMbjoNxZpdGMpQDIIEPxkcLc1kqrnX
 eoqa3ZvgixhuLq0Z93LCaDc1Dh/2sJy3ixKC9EBR7tda1UNGtZ0p46IHuftHW9mTh7tmSPOV4x0
 tHfvYDLbAn6cIl0ku17gWVv5rd+RzWUCVM0c/tTG50SOba//Ghrt0xYgruiXgxGX4Hf78c2dEHy
 7YEEdl1vLjqLSjQ=
X-Received: by 2002:a05:600c:4f44:b0:49d:e0c:e55e with SMTP id
 5b1f17b1804b1-49d25914e45mr48857215e9.23.1789021575251; 
 Wed, 09 Sep 2026 23:26:15 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c38e3asm52279585e9.9.2026.09.09.23.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 23:26:14 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 10 Sep 2026 08:25:53 +0200
Subject: [PATCH v7 4/6] arm: dts: mediatek: support signed Genio 510 and
 700 bootloader FIT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-ccaione-upstream-mt8390-spl-v7-4-0a5cf09c5761@baylibre.com>
References: <20260910-ccaione-upstream-mt8390-spl-v7-0-0a5cf09c5761@baylibre.com>
In-Reply-To: <20260910-ccaione-upstream-mt8390-spl-v7-0-0a5cf09c5761@baylibre.com>
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
 <pablo.sun@mediatek.com>, Chris-QJ Chen <chris-qj.chen@mediatek.com>
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

