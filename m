Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAEEE81BD3
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 17:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3130C83CD3;
	Mon,  9 Feb 2026 18:12:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zR1CX3n9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95BBE839A5; Mon,  9 Feb 2026 17:40:29 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C90680325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 17:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7cfd65ea639so2987789a34.0
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 08:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770655226; x=1771260026;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WJkcOzgvtdS3lgvKIiIH0Y2i+93555r5yUco8FDXnwU=;
 b=zR1CX3n92GNOYlp+k6FsrV4p9uhXMdMnHt7j3ocy3Wa0srSQloW+JiiK4ifgiwnn1w
 mGiO6wJ1zNYPI4HpOXbzIpzlAri4zVKRpn5uAOF3ANiOJ+u8EBJU5MqiG+Ramt8gvWNZ
 zDoMFIyGngp4oPwSxkHv+Hoh38jL4woSqz4ngblT9ymDgovxq5q5RFWF2zOFIxoHipHi
 tx8L4hOzHUsPqnoIbDiRNg2SA5tb4+H8steR7RIOGZjzXJnt/KHjyh6LRD9kk0JMl8E6
 LGQjWpDXS7xqf3FPF9U/rU4GeQgbLPCEVLwmSm+/HFdImCl94TcXdaqX86F9T6izrQ9y
 YDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770655226; x=1771260026;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WJkcOzgvtdS3lgvKIiIH0Y2i+93555r5yUco8FDXnwU=;
 b=GdJsEquqXAofEmGFHwqFE1YP1ueaETU/KgPcMG7PYmRM8fH9SCzGM/vVruQqTOvt0s
 ud3SRfKfWm17+oExCz3xZrlLf4bDxcUDqO1Mx65Edif0Lm6ef2gZZoCuj/WCS/BwPcbR
 3kNm7YN8zAQ6VgaZgRwgig83Fi07Pu3AlwCpTCKmPStrGSIvmGPIAh3v+E/NS1QMT4AB
 l1NL+rJolw0nAW4NkWEn5RIQ8F03ksq0cxlggvm69PRAgQRSLS1ypFJWWiW039w0Azhd
 sdIPB1xwlCSXn/pgecs37ZeIPUIggZaoa7ihAO3cj+Tu3EcazlTnfITycBskGLq1ulsW
 0xVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkwqUnsVMVHme2hvtD43dKaCd01m8+gxHvKzAoXeVtD61m23DANyF9CLpfG/4fIbjfoqGOtqc=@lists.denx.de
X-Gm-Message-State: AOJu0YwJFQVKO6Zt7iK8kYdv/9XiTkzoJ5/RpMnWEbHGSb7S2nCqW/Mf
 ti13R+9j/CRzCde+cozCsbN5jIOq1kzbdCT7WD9h5bua1n9BGIn9N39fT6cRxcq4kvw=
X-Gm-Gg: AZuq6aK5YN2rQVJHJInWUPShVyj4y8x8N+zP0GMi2cWQMTYZgwX5P/9LMv58XNqZxMY
 jP4/bKZLFVM+ES59Rctcf5WZpAbHJQCxorYAoGiabz8Syk6sUw7macH+/bXJ7TVo3tfigNScIEJ
 sW2XHZD+0+YZ666rZIIFueZS60p7GsG2wExe8mgfNGX5WjGsdNy3jfL/zqV74WEx5kcbtMhipXp
 bfrQLdUu1uvGSxc75UworBzR6c9JalRRdFiahB5dSpcnW9wTxPf/HbsVyyp7KfQAB0/lS0uTsSR
 uBvDe44T2MFhfX8eLOH8PclfaGA3A2YjTUoMiDH8zSqp+aCSodHlgYigLGiOYOdOzUthktiDt1q
 /t6l77RW7ANJaRBCFwRu6zvi4M8A3a3cN1Th3WYIuEFi8gNPiXkZEj0YkZVZO/k9Q5mSJ3pWJGD
 2tJuCESWwy25sYm3o=
X-Received: by 2002:a05:6830:6202:b0:7cf:d784:5ca with SMTP id
 46e09a7af769-7d46447854emr4849096a34.19.1770655226228; 
 Mon, 09 Feb 2026 08:40:26 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cee0:eb0c:b683:ad1d])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d464785d7esm7731139a34.15.2026.02.09.08.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 08:40:25 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Feb 2026 10:39:29 -0600
Subject: [PATCH v2 4/7] arm: mediatek: make mtk_pll_early_init() static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-mtk-mach-clean-up-duplicates-v2-4-e3b22282c74d@baylibre.com>
References: <20260209-mtk-mach-clean-up-duplicates-v2-0-e3b22282c74d@baylibre.com>
In-Reply-To: <20260209-mtk-mach-clean-up-duplicates-v2-0-e3b22282c74d@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=BFjqKadARI0vggSmPYWo8UBjOg9AZyvkdYViC5PTO1w=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpig3c/RAk20JUMo1CiXv6g5ue/Ckb3GTijHgZo
 7+0ytPG+O6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYoN3BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AxSQH+wUuxl2toJO5P2pT4rDePHF4p0pmF0jkSWQLd/K
 FBIiawisglgvUarUcITi1Vxymh+ZpunE0O1E9ICki7bm41LVX4ttURpyO/GGguKRNIOYzZnQmAO
 XkGqmMzAPBgayHwYfDr/MZB5tJTmBwAuNwdBudtmHEunJn1/TUcUIcAINngeaPz1tS9GgD8ge2B
 kXD2BkUAOghn5LE/soBq8KCvagsHMvXB9ZFOeSjUBgYD+XDF3PTxqoIMaBqfasKt763eOV7vLiU
 PkJ02iICDY1azHiJSKWGlLUek93T5g4hz5pZCb3KO5rl+w3SyZ+8pAODwDU8P3ivS+U7y4W0t6w
 Bfuk=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Mon, 09 Feb 2026 18:12:16 +0100
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

Make the mtk_pll_early_init() function static in several files. It is
only used within those files, so there is no need to have it in the
global namespace.
---
 arch/arm/mach-mediatek/mt7629/init.c | 2 +-
 arch/arm/mach-mediatek/mt8516/init.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt7629/init.c b/arch/arm/mach-mediatek/mt7629/init.c
index 7cb8b72c364..ff027ed03ef 100644
--- a/arch/arm/mach-mediatek/mt7629/init.c
+++ b/arch/arm/mach-mediatek/mt7629/init.c
@@ -27,7 +27,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-int mtk_pll_early_init(void)
+static int mtk_pll_early_init(void)
 {
 	unsigned long pll_rates[] = {
 		[CLK_APMIXED_ARMPLL] = 1250000000,
diff --git a/arch/arm/mach-mediatek/mt8516/init.c b/arch/arm/mach-mediatek/mt8516/init.c
index 892bd441a33..82f8c509745 100644
--- a/arch/arm/mach-mediatek/mt8516/init.c
+++ b/arch/arm/mach-mediatek/mt8516/init.c
@@ -40,7 +40,7 @@ int dram_init_banksize(void)
 	return 0;
 }
 
-int mtk_pll_early_init(void)
+static int mtk_pll_early_init(void)
 {
 	unsigned long pll_rates[] = {
 		[CLK_APMIXED_ARMPLL] =   1300000000,

-- 
2.43.0

