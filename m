Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7B1606A320
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GceoljWj;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=dFNgQ+Px
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EF7881755;
	Fri, 20 Nov 2026 21:50:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3wysMuHox_xG; Fri, 20 Nov 2026 21:50:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5A97881774
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795211458;
	b=c7tMAlIsfLKykNx6KDDtUBLKG2jNHsMsBecvtbcnqZQgLkB9+asT99ywFHdlGavh3A+u
	 M09VNiILplU2dOOSaAU+UlUpERjXQkrmRLeDQZCffYPsZBfucvbUP23PdrHHHrXbjdYv2
	 xYFRODOzi1/yjwSSxZiljKVA1Xm82FrY6rqkMSUq3prpQeU0n3BhQET/ggb+7g8rlqEyR
	 YLR0haRZ4lPrhI0i2mR/46AahlfMWYelIJgQd+Zmc2DxwsHAe8OW/3o+tpwAS6gMHHEuv
	 4Z1xISo1WHYFr0zcX6T/mZt+BexgLw+LRpWOzOMo45LoaqpeBBKZ4WdLW4I7UOFYsJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795211458;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OtvEngsS8w1kiGO1fJ6FUXYP7guhnXEv27TjbUNFiMo=;
	b=QAlF2VNbeSw+C2XDPRgvhxY7ZhAYSBpjOhip4v2q1abnZG++QPmdRi5WcEfp+uK7acfW
	 EUzjdX7xsfad06b+bcH6w+kolGtlHU351PrrT8VBxvTLuFNLV0D39KmbwiqGyD+ohSa2k
	 Int9BqleJ02BDGH5JVELCD2J6ueGDxpDNMYsrP/zLu9fsnPDjXlqZPevazETF0wGNdH3Y
	 esYtrBY0anME5XhPsajZV82L7u8lcdRApbhFcLY6BLWf+HDolkc3ECVG8UP7llTrdILVm
	 lyXAOeO0vb//yHA/ABoeW/L0VfRAyelpbbPYSz/QDgMQZDtN0Fy9fNuasHzU7zgVv0g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795211458;
	bh=OtvEngsS8w1kiGO1fJ6FUXYP7guhnXEv27TjbUNFiMo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GceoljWjQ95HGFZHxQCFasSyMagRHL9UGkwRaPzIymXRI9nGOnaHn7dKMaLnGBDqF
	 Tj2krqSpnOPEIH4giez+uzoJbzGVU/RFeAw5XM3qDX1xSHWr5cABNWOg54kLphvctv
	 7/py6w6M2JJ089S7gBEH1tRx7sbxhLVDvo1pX2PNtLwiDJk60YA/00LuI1tOHgvhJU
	 /Ez0FzWt8nJECuL6KWh3FjFHm5kn+tjIv4uUjGNU9acWhK4Y6CVjVygJsYKjKhmMPg
	 joGBnpEn7Cb3Bw2jTKDZhjEq9SXBZBzVPHo12ipFsU1ZBtFkKPOj3gNEIsg5mDBvn3
	 AwG+G/BCMbumw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A97881774;
	Fri, 20 Nov 2026 21:50:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B7BE3465
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9C48960760
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0nQnHd2zWriq for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 21:50:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EAD50606C4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2f; helo=mail-oa1-x2f.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=dFNgQ+Px
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EAD50606C4
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:53 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-4adae3eb4d3so603289fac.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795211452; x=1795816252;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OtvEngsS8w1kiGO1fJ6FUXYP7guhnXEv27TjbUNFiMo=;
 b=dFNgQ+PxRuGc5YGykTw96vlj6G0W8K61HVzxmTjAvXJ8sQ6M4syiAVG71W4Ep1zJRa
 dprV6KYtPpIiV/7KV6wqtOyshoy4oxXBPBXDH5E3FA8OB9xWFHIlryUs2PR4wJsYUWb9
 o+h+QinWJ0O1nZaL75rLSzcMLlOZunDEy3qF9vL6kC8D4KHU2SbwcXc4A4KmVlmITEsV
 tqNvENp2xeJjg6UdaImWjMVW+Y0sTMsF1yZQdmR2pPa3BPJlGXZ0W7Qi6O7qwWxcC8Dq
 eCN5mKQrsiiUn++ykNPRnXIIGuIp6/qh91M8N43eCBHccGCwZzVEPeGlgktVZ9oyufkE
 g3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795211452; x=1795816252;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OtvEngsS8w1kiGO1fJ6FUXYP7guhnXEv27TjbUNFiMo=;
 b=day+qIO3MZLWQF78gqoYGK6LWjAYIphZV5foPDEnTs+m6rqN7iNznBIuD9kn9tpT7/
 8xPViiYqgFORVGWToCe0TBj1BynOZfS2kosBHzNn1n21C05N9lqteUp2Dx5Fo+9cltxn
 UfW2YB4bgDlkL6AFGq5LIuqFjWZsq/2bVwHWZAXaHuEqSnivQYw/LoCI5dWxzCYrLj7e
 g5AaIjbJHb8roafGlSAeXnaOcrH7is6lbI6ADfUsovAN1Iu291GZeIqmUBWJk1SNLerq
 rTWYd1286ypdfKvtzB0nuonFH+oAAAQgTxSv9e6r3DEMuXIH46FGA0D6VIZWfSS0BqCW
 228A==
X-Gm-Message-State: APuU4Z+oobNh3xhyyPXYt34Z96/toxnKX3qpw3VFFzJvvU8OHS3kErga
 hyw2TKkaOipX0mPnyTs0oR+Qj4S/MKuGi30MC8u+3l3Ntl0ghxxIw5OtINGLPC2MjH0=
X-Gm-Gg: AYBFou0scZo/r4NGudARmonRPdwuEC4Cy96tKrWjL6svuGEjmJ1Wfx7ZplMol36M0QU
 NQqfXLXsiPdO1GGOTi83sNo2PPaDGpGSOvcqgjygq5FPvw8Q6OykkSv+b2cfNPzuyuctnVytUmy
 O1SRhddZSeNj7bv5ohr+HB7VgvgLtOtGN13axHCRAnalQZlCPh5GddOOs2BLFtsa7T9foafi/Ir
 P3gL60pxh4t+XLy5HIszS8iWxsXEudt5KcnW5TdTV9ruz7mKGZGTjjD+I+aDucO7gQpkiLB9nmi
 P4IVaaUPjcr83x31+PInYg8I8bGk63iqaM/XTKxsZ45KxRRA92t0ULnBgm7az1RmAJh1lXSAaAb
 MsOUpwtNFTlFLnWOme52X9r4QivipGskKKRbnkY6B81A17jcXrAuweTScJBp2xojf7dD1Wx7YSr
 34fondR7cOselfWspD4mlWvOn2KxBHnDnLRiDHvWt34grLbP8NbptwtntmoRnE6bCw7DeoOSOXa
 4YcRoehq2g6Hs9nrkaC88v/nQpzt5IkxWdQGTV7X7ozqxkhjFWQUu9wdIxeId9cvu9ExX7qmIxC
 257mc5L4eFoIhBOls5zwlQ2Z+2it/LSM4kcpOJy+h/6r0bqX6mFPig==
X-Received: by 2002:a05:6871:c903:b0:459:2c03:6302 with SMTP id
 586e51a60fabf-4bc81a9da7dmr4492442fac.11.1795211452365; 
 Fri, 20 Nov 2026 13:50:52 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d4f:b590:5bb3:988b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bd044fc4besm2846726fac.7.2026.11.20.13.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 13:50:51 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Nov 2026 15:49:33 -0600
Subject: [PATCH v2 6/8] arm: mediatek: make the BootROM header info
 configurable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-mtk-genio-720-spl-ufs-v2-6-3ef93cb27dcc@baylibre.com>
References: <20261120-mtk-genio-720-spl-ufs-v2-0-3ef93cb27dcc@baylibre.com>
In-Reply-To: <20261120-mtk-genio-720-spl-ufs-v2-0-3ef93cb27dcc@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1408; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=M5YVenP2TIYM9+2NEtnLjoX5Mt7F/WGTcvYqGvMD5Lg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBrAMCX4zlwqwfgswmKfMl+Ny/H1df2i2//k4d2M
 RPa8o8qMkqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCawDAlxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A7mQH/1xhHlAEUgSyK2BbIAqyQjUBF8F38nitV21Gsur
 rfzfXoTFAWrj+MEkBaRFDBCmqsPZx4TF2GE0sqiWTE7/EbzrhbniqqXvuPOL3Hx5PKFcVvLbytm
 A/J+Rkcwf/kNwZkLq65BgQ/TTReYbNaBXf3VzGW2WPRdqgCIom5nBtYC66a9l9+P0i2arZ1iOB3
 u5nojYTYS76t2buWMHAODgum1qsnPKt9V+jUT1AX9eKXYg/qLYaKjrjnP1VZz+i8TI/ZVgr+Wxi
 0d+DbxXUzSa6zwNg0Xtgkh06MtC/ZF2V84eq9We7xFyLD+mbcK5FC71RwXrUTeYl7M7RiAkWDfm
 BB/0=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a prompt to MTK_BROM_HEADER_INFO so that a configuration can
override the per-SoC default. Some SoCs can boot from more than one type
of storage, and the BootROM image header has to name the one that the
image is written to.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/Kconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index ba46ef89c6b..7171cd7a984 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -215,11 +215,16 @@ config SYS_CONFIG_NAME
 	default "mt8518" if TARGET_MT8518
 
 config MTK_BROM_HEADER_INFO
-	string
+	string "MediaTek BootROM image header options"
 	default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629
 	default "media=emmc;arm64=1" if TARGET_MT8188 || TARGET_MT8189
 	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8366 || TARGET_MT8183 || TARGET_MT8195
 	default "lk=1" if TARGET_MT7623
+	help
+	  Option string passed to mkimage -n when generating the MediaTek
+	  BootROM image (mtk_image). The media key must name the storage
+	  that the image is written to, for example "media=emmc" or
+	  "media=ufs". See doc/README.mediatek for the supported keys.
 
 config SPL_MTK_FIRMWARE_AB
 	bool "MediaTek firmware A/B boot in SPL"

-- 
2.53.0

