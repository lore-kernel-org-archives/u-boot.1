Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF37606A31B
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ezDHPYUr;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=WJmwAe/Q
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0D1440AA0;
	Sat, 24 Oct 2026 00:10:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d-6MuMSf9Khz; Sat, 24 Oct 2026 00:10:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F3BA040ACD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792800618;
	b=a9ioKSpRiMpSbZ3Vy+MVluy3DzgguvTuPVq/AwDKSEke+LCT4TsBGz5tU5LsZHQVGlYP
	 sTBlPp2b0COz0VdsxV5MhcXLlZRyHf2FaVil33WulYfvGDh+QsWaI4qMXML8aSK6WGSd6
	 kr1ZZIIfog6a8yqolD5OAXqi+MieiUeg6+1/ge1st90ecVCslCFpDsCOYTmOT5Px8GGdT
	 PojnyYkrW/5V9uGcNHy6caBmUHySs1xCJhJxFVFMEy0T86NBw3DSFrdCaD3k30hY94kzL
	 +cIre5IlXlzD5HTwkd9cqXETfS5Nw7s2w7VoJIEexkWbhUm9o3txOFzqV9pjfgtegoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792800618;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fXR6EIAol1Ogz5VmrYrJcNuAXYX7dqOfCTds7a0L2qQ=;
	b=NzW+pJCiIK3O0JSbTyeHQrMD12XmqAwi8sz/1WDAW6FDWOzAd0gGTqxf23R+pmPHKSbq
	 Q+RgRSSmJLJYbUvM36t/3vHSgA7uOF8BYBdTLBA8Yx0S25KJGanvbkopHmDj4qABNgxOD
	 jIAKLyCS0yhRlABl/WmwMeeI4/bT3l1ck2p4B2o7b7rba+M1G/M3EqUyXbtuMhVbh/Vh4
	 gY8GJ9K7w2SZ+zU+qrmzgDVhQhMtBLpagfqs9WXWlhvYuIVZXFJeuR4ZR6FdR0LH9kHTz
	 H7dYD84Oo18tno4jvkfWrwJVharjJYeHjZOhmGnOd4kdLXBW9my5pha6FPNfbAWe4Zw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792800618;
	bh=fXR6EIAol1Ogz5VmrYrJcNuAXYX7dqOfCTds7a0L2qQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ezDHPYUrOpVPQScJnZnL0qi8qZJE6tnt8RpDr+NiXxw+uUFp+UJM6lJLKc2m/efCY
	 DxgoIewodGhTO9yy9KH+LagmfakQVWfzeUaF5XpGNxoAU44BnpR4lEqgsQ7iEtcGrs
	 12X5ShTdH/+9N42kTawZSTxolOX5HNm6ouOIdvIZD5+vTHivMLAV7jAFZT6cguMTmp
	 ZE1Hd4wXvrkL6usSR3U0skwW0oKQ4+MfApnyD2CcTMj8pC61ltv+Tek/MYJmp//Npq
	 z6EfLikaGoIgAxlIa4I8pUKCOXoTDGMjZQeuKC5v48MPKwYBnUGFyrHtQOVLLA1R1h
	 eBVdhneA9h62g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3BA040ACD;
	Sat, 24 Oct 2026 00:10:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 559BA3B6
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:10:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B51E80C8B
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:10:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hYZLxmpvUGu1 for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 00:10:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 790C680C79
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::232"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792800613;
 b=C6Yp1ae2SlOXSVw2bOzOG70GfCXuNO4d4MYA0KP4ENkcxC0rWPdaq8OayztaYUnvrXtX
 6TJV86PBjEyMY4846Cy+RzvPzTaR0Iio7M9kxhyrWLBksUT4eKQyCkNNw2wAmV2+n3Fz8
 HL9kAvc8tUy35d/xaopyVhB6EcJj/CjaIIAQ6EEK6JxP0gcWL67+dCukkVO07HmIJCHWi
 5augTKqVfLWy6JQNCqDqGZLahNzLpnxVszHgYKpicq3MWEUecjLxRPUhlbjhy91Ef4nW2
 Ar/XAIcrUcXLjUWxxrFmkoMHzz6jjkLyV06isvaD4YGZxRw49ujGOr9EmpaiRddg0LA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792800613;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=fXR6EIAol1Ogz5VmrYrJcNuAXYX7dqOfCTds7a0L2qQ=;
 b=gQPr/ih506WA57H8wsoKdHMan3lC9kZi2A/bY+0EOS4uguPmDOcDwtkF+wlre72MhhJ2
 3GHXL2rV3Imfk4Lhmjp1yzV/j+Roqypb2UUThmXGb7mKefRetdtif7o9v2zUY9dU9Pq04
 KNm+eNX/E1vZIXtvA4s3G/kgHOYhG5wBKzZGM8k7g7nDn0CG0UBRir7iHG8NT/1BVQslJ
 O5dVeNPE3wcuy68v/kkw5LCVbV8+vNcafxtoSmRXwG/wNgeqcpqeKwdi040vRgwlnx2Nv
 pPFmMsWffTi0VyipUWjVY7z4/eRevW+vAix7Wo5zWAKMT3VaqJ4tZVEDauDQ20EGq5A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="WJmwAe/Q"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::232"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=WJmwAe/Q
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 790C680C79
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:10:13 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4f55a53898cso651517b6e.3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792800612; x=1793405412;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fXR6EIAol1Ogz5VmrYrJcNuAXYX7dqOfCTds7a0L2qQ=;
 b=WJmwAe/QhN7DYweHKfdsE+Oov+0+KXfPPCKmfk8CjhJIa6KS0qRKjgNPvR97WI2TNU
 D3gQNwMjwTXRVefOv1dEL9QMWHW1saizzsln9tCEWsr1r923qwTpSsQKmiCGtxginnh1
 wY478xMhiETHJnw4b5F8Oqne7vxAffUlYo8fGiLv8uqKCl6JQsJzrTX5P9wWeOEA6qYs
 E+sWE9Fgg1rz10IPBjBrmwzWdnGZxX2FJwz8a4buGtCanWz77BP40mTYZUuu5tx6xh2P
 hEkbHo58OK8pB9Myns8H4x/NvuVqBN7k/MXxn8kESe7CJdmbS2N9UwYU5JwbdBwvBtnl
 ifEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792800612; x=1793405412;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fXR6EIAol1Ogz5VmrYrJcNuAXYX7dqOfCTds7a0L2qQ=;
 b=qjSe6RflSl0c4PU7y1eJVdtAFqI500eF/1Zm+Oe8GV760j2tMU/OFFmVeTqfYgp/QJ
 pLtZ4qHKg692SLEIeWnt+CzA4RaEv1DpihmaiEjy7icOhR8EARpcxfW6ubn7vQp9ZU07
 Cf9Pu5wS1grR7bt4Lu6EPHSMMf/wawvxsKnkpikqw2+VYU74nAo4Su6kMLs/GfpAyAnp
 goVeXd5aUAx4v1hdeMwMVnz6WMwawC2ZKN+RimfJKgymO9cCDCBkVe31zpD/t1sCagUi
 FiE+hvS1vU4UmCC3Xnv3MN9uHXwu8bfQGi/0fXUgNEF1I6ze/WDQBUy5mVupUFa5AwV6
 oRew==
X-Gm-Message-State: AFq9FYLkkyEIo1wdpxc4g2Rt5WuxRsrcetHPNx4pWwA2GVdKE/Deha8R
 SedGNXA+VQ/1vlmBt5dKY0F1d4UUv4Poonw2IBqr3rUOT/L96qpLn5gCXzh25yApsVk=
X-Gm-Gg: AYBFou2e6/woZQiPLBxYkQ8IhjXUxzxEV6UquYmmwsv+VbZhg64nDPba2xlok2zbqAH
 RIl0DFU+S4JMsvi2ep4T2W6o7foiqFO0AwSMP3UrRoGPYNOxASBUB3Q4YIC2nzNjTUp0IniVFb8
 8EmVCwwyz133cMvYZM7jDb8GLzOgkw2tZnA7PrWbcgXkOmyYr68Qn9kNmdeEQS6aJJPef3h/S4A
 8zX3ajpUn0gBTvhQRqNnRSC08yqL4NRivKhdTfMZ2x5XSmZKVFSknqTZKfifY737fWL3zaKYY0X
 ji5vdQyAgkEyoelwlWPS2kDoJsT1P6ajWSCt8jBhjvpmBL9JpKQ46oO3ZiUtRSE/QQW7Rl+S6jO
 XE9fSNWddP3/vpx8gCq7g9wpLa9OZ6Lj0ajZfnGpJyBCr3pQ7+W1rKksK8Zj6y5hBL8bomci2e3
 t0qQANPiOTPtdFu1HtvtFGJYLZoKe7CEVYK7Z4/i8BSozhAEQZ6+dR49hr18D+QJUAS6V7j6imS
 0LZbIJQ8D6NF4T+Tk3LN80+VTtbNBi1Cyfkd2ugTBqDQlYAaRzqDUNuSE8/
X-Received: by 2002:a05:6808:148c:b0:53a:b182:9999 with SMTP id
 5614622812f47-55c00263132mr569150b6e.43.1792800612164; 
 Fri, 23 Oct 2026 17:10:12 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d2b5:d533:1cac:8248])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c04248804sm328636b6e.3.2026.10.23.17.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 17:10:10 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 23 Oct 2026 19:09:08 -0500
Subject: [PATCH 2/7] arm: mediatek: mt8189: use phase-aware PSCI reset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-mtk-genio-720-spl-v1-2-f2c0ee094fd0@baylibre.com>
References: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
In-Reply-To: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1277; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=aATxrsaoedVRe6CI51+HeY3G2r+TP6fJVjj6jhoz9UQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq2/c0CboabEKvHRkJDCUVF9tLlb6fz+GyTZWks
 MYA82nGA+aJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCatv3NBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AHPQH/iYv0u07i+JODtRmcAyZdD50p077ZtGEYbB4ns5
 MzgAEapHoCtUV7/QYN3+3DPd733PN0uUQPcxeuYxao1WnYD3nDm+TxTfco1UitjsCRczTHtHDXa
 gj9w7GqclxM8VLqn6yZZg35DwTWekOwq4GaK8ntvW8x8SMCgvZJ2SkNG2UfZOaXMDbZ6hvVGnJ1
 VaVYFOIoIJ6ztVgyUJFPJP/BL1aJfWBrZKhQj2Oi5vR6OuKFY5SW1FWYKXi/M3cillep8zYaiLD
 8SJdoR1c3/TBzpO0Cv6XWsyB2RVLVcNTEt17EHP7kDSpMl1eI6bN7D21VwglLRomlFG86c5EK/X
 fCz4=
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

Make reset_cpu() use PSCI only when it is enabled for the current phase
and fall back to the watchdog otherwise, as already done on MT8188.

SPL runs before BL31 is loaded, so a PSCI system reset is unavailable
there.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8189/init.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/mt8189/init.c b/arch/arm/mach-mediatek/mt8189/init.c
index c0b7050c6a3..a0de674c452 100644
--- a/arch/arm/mach-mediatek/mt8189/init.c
+++ b/arch/arm/mach-mediatek/mt8189/init.c
@@ -7,8 +7,10 @@
 #include <cpu_func.h>
 #include <fdtdec.h>
 #include <stdio.h>
+#include <wdt.h>
 #include <asm/global_data.h>
 #include <asm/system.h>
+#include <dm/uclass.h>
 #include <linux/kernel.h>
 #include <linux/sizes.h>
 
@@ -32,8 +34,15 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 
 void reset_cpu(void)
 {
-	if (!CONFIG_IS_ENABLED(SYSRESET))
+	struct udevice *wdt;
+
+	if (CONFIG_IS_ENABLED(PSCI_RESET)) {
 		psci_system_reset();
+	} else {
+		uclass_first_device(UCLASS_WDT, &wdt);
+		if (wdt)
+			wdt_expire_now(wdt, 0);
+	}
 }
 
 static const char *mediatek_get_segment_name_string(void)

-- 
2.53.0

