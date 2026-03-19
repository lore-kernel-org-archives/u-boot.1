Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B57A1091916
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 20:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 831D384008;
	Thu, 19 Mar 2026 21:02:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uLcP6Dxs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AF1E83FDB; Thu, 19 Mar 2026 21:02:12 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A08C83FC0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-67bac077116so616560eaf.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773950528; x=1774555328;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0WHK25gYVi4/IFRVx39IWUPwtsMKimMWPdtsrJiL/3I=;
 b=uLcP6DxsKd29v86pwlaDKOHbQKuCRjHePymJ5jNpRrCenySDxN1XJh0g/uti+K/2/A
 b/71fDngDnfihPYcUztNIWrjUrdtDXSa2VJFRfHUf9mge30MqLfWLWtkneW/AOc/bB2E
 iaIbDppp1+Dgi/7TTLY/o8AVhwUVM9mOIjCzRmypTVr0xow5YYrFwUBxG4B3eNjwfFkZ
 aT9klF21/vg265KR0ltQJLEh/MSe6j/Z43/f+pY+H+v0PU324oNRyoWVyFKFPoDwxnS4
 RRIY2sTMzPwpvZQZLshgsMQEiUnHnUHGcWQTm6rQV1D74apyJZhC8P2838PbRnrC95ae
 4GaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773950528; x=1774555328;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0WHK25gYVi4/IFRVx39IWUPwtsMKimMWPdtsrJiL/3I=;
 b=mOVXNvB9EtQMPUkFS84ohJ5ZjHfDWw10Gmi/Vtcx5M33a6Ecve7+0sqT53SfHcIr6a
 F7Qs/HipfG8aVb+3wmAzIGuGMpknr7enz8g/6rGg6CVJW+0yKjHGWccGcnJR1n2f1+ST
 mgPvAXLj1H98Vn/pKkAjxotOWQeraebROmeXZVX5jSquI3GWy/P4OKB/6iThlB+2J71E
 qfp9MD78a7GsHqMpRiRRHqIPyuHhJUH0Cq6UM1gcaMOXL88Ubcos0jbT16HwKTndQ2lv
 rG/ShpcmhU4M0G4hqKSQVGRQHLcGjjmZx8NXkxgErJwTIp5ML1QSJnvkt1bjLddPKxrv
 BQZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+kp0Trn4WsWRguBU0x9RKsQxaviHulTme8VnMSvDzpfbBonY8s3bQvTilxx/sAnqRg1o1JP0=@lists.denx.de
X-Gm-Message-State: AOJu0YwBKPk/bNKI2+qJIwYDvq3PYdQ0zp5b6gqE5N5p3btiw6R2HnO2
 ppCDzKf3IxMKfQKhPE969UyEqtiajLYQMYsw6fYiqImMld2VjgIVImxFi1qoNr5CDI0=
X-Gm-Gg: ATEYQzxNHmAIEd09jwbqvMfOa4CE5ZuH2Bqz4pN47Q5kc/D1fVmSzWbbpDYp8EpTEVB
 /wkoHVfKoS3VnXv+PWNL5Q/Tv51wfGQBEQzmxpPIBx5RWaa07f9rL+De6JH63O69URVku9hKBwM
 PIEiEqpRhAnYAyHd69jL+vkeNMQxVizu6rQONxDJ3/5dXprOyZaHA+zp25ftVXQp8D0b1kxB3dy
 dW0nGzQbA60TU/8AHtIlRyrrzn17fFIJMwb4vHDCT5Dd5+fhp6JeYilMuZnlZmyU+wjU3FBt4mJ
 Jbmz274+gZMhUBiz9JjaDog105KHInLy7NJPw/M8RwsgoLEdZzORJokZT281BwLo75LLdUqDWyl
 josohDdqmUhcMw/wCy7VveQ//ZdYDMVFWewTQzjgtsBNwgFZuD52+8mBdU680gIeOMvDBIcSsxx
 zlK5J52br7LknuTlEkamXeQrQgzQfV
X-Received: by 2002:a05:6820:1349:b0:67c:1deb:4f69 with SMTP id
 006d021491bc7-67c22bb5697mr530847eaf.14.1773950528558; 
 Thu, 19 Mar 2026 13:02:08 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252acd32sm2826eaf.3.2026.03.19.13.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:02:07 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 19 Mar 2026 15:00:04 -0500
Subject: [PATCH 01/17] arm: mediatek: mt7987: drop dram_init_banksize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-mtk-init-fix-dram-v1-1-6171ec141f40@baylibre.com>
References: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
In-Reply-To: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=803; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=QnRE/FP+AtVi+Ldcw5EAOYToJaXxSEoG3ygBF9guRKc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpvFXNGqKUnH9TDHfIb8/YFw3Q5p4EoNq1R05W+
 X4Q9GeiFRKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabxVzRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Af0sH/RV548ozgwfZ8QNgyY6qKJC2U+Z9XeHorGeqRL1
 +cFAODly+jbX+3DJlSQvRRmrk8YmQRtU1TBs5CUyRya/QMe+j7NfrRhN/chAQGTTEu6CgBvMHK9
 A+YKS896MmPAtDATWauOIiWTaDkmrwSdEYiqCmhPxdq6q5kkdV0ndTEECwYI/ruuRDyIMTcJwLR
 w+tJ0vdpOoJsQgPMnZQv0gkb4OSiOCQFMIqgxwBzymeE2QkWfXkBpbRumzPS9aEA4zVII6CiI0r
 xs68R9e7ACdpD71zNmX8KxdXaeUNpELnG5EnStcQrWNBKzOQToe+Bl63YUxD4aDEBddqpTtkgnO
 vaAo=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Drop override of dram_init_banksize() weak function for mt7987. This is
effectively the same as the default implementation, so we do not need
to override it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt7987/init.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt7987/init.c b/arch/arm/mach-mediatek/mt7987/init.c
index 6364ab497f7..f16a25843a9 100644
--- a/arch/arm/mach-mediatek/mt7987/init.c
+++ b/arch/arm/mach-mediatek/mt7987/init.c
@@ -27,14 +27,6 @@ int dram_init(void)
 	return 0;
 }
 
-int dram_init_banksize(void)
-{
-	gd->bd->bi_dram[0].start = gd->ram_base;
-	gd->bd->bi_dram[0].size = gd->ram_size;
-
-	return 0;
-}
-
 void reset_cpu(ulong addr)
 {
 	psci_system_reset();

-- 
2.43.0

