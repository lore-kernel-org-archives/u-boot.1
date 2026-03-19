Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496D61091916
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 20:03:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F09384051;
	Thu, 19 Mar 2026 21:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zV3T01Br";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF3BC83FE9; Thu, 19 Mar 2026 21:02:22 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA78283FF9
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-66f747175d8so716802eaf.0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773950534; x=1774555334;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F73okva4oW2YMOTCGfT9uyLu56FZ21+tOnM5ip8UeeM=;
 b=zV3T01BrSYwk7LzT01cBLeRvqe78LKFn5GGSMRL+yHFAO6u6zYBC9Pg1ODlvg0ATUV
 RlBR0pVJgKDwoG4TJ+zUfIUFHStaC8eFdnlQ9lCW6ykqfE95LzPehWd0KDlC9RNfMkC+
 uMSTma6szB9yCnwY7BB0My1NWJniZQpPr6b3aiqbmgpwYG8UZntJC1AAK+f3ArTp7DrM
 SbY92c24SL+Yrd0OlsgXW/t8tX6Sr7r2WXxAb+QmiuGqsM2oGJDlLwCd9or9pvCBG1Ec
 0fg36BEJuy2kbteM0BwQWZz6aBqaV/FJjT1vbAbvV22ogZ0dJnhDJ1vf2r5oYN7+1oMe
 6e0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773950534; x=1774555334;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F73okva4oW2YMOTCGfT9uyLu56FZ21+tOnM5ip8UeeM=;
 b=dZA0tNYdzKCF9kUWKPCNFisIv5T6s4N5QhzdtCfWtaT1E5vScWZmxlJlfxYtWx4K9q
 6hMkiYW+Y6ERtxtFk9hOOf9+uLT2xLg5pPVoN1qcB3aNI4WLWH0aSH8Q8DxtRR0Atlgn
 s25FancSdkZ2U5EcdIPFcjA6LptvZAHcs04UyysUWP/cDkeNLjBsrbNzgJBAHCPLtYGz
 QeQzZc/UDyaZ3233k6HMy94RAqMWkeyX7W/XGWyhqA3HfXBK0TCG+FB+jX0CTFir2u1P
 tt2PXpf5TCjbQKVSQm3BzUQwl13M9Du5584W27YyN4DBvrunmrUXv1LQrMDxdL4wSooN
 K9pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsoADSQ8nrELWD9DvJIIBY/okvUdV8G5Fi3WvmgGkA7Ax9oCNPn7B6OqBRZnMGmRj2z9apxKk=@lists.denx.de
X-Gm-Message-State: AOJu0YzAqzLhMvx1c7KhWyO2VJjBQrE3pcCo4coAkBigiNxEEEkcSyYT
 33XLnvwMDs/EtyzblwXnRdGuNMZGwlev/UhDzYyuUUvpuGTFftS74ciOKMbpqS05Y+Q=
X-Gm-Gg: ATEYQzwtZxMmWsZD6bgoMN3xiXNevN2W05YIYaNzMilcae+Bc9t3hv5wKdf34C2hvX/
 7Ffe7yh+6tx6r0nqmOEMftyCGYqGIbQwJ6+zlrE62p5fjYv5oC2vsWgEMVSDL/ojR/G4cHiKAe2
 B+IrLOOiBD8kITlasqBiBTbBD69iWO99gh+o0sOFvcUz6ctqVZFvZyK72Y+xtftL6r9gRdBAeWa
 NDpMOVZD1T0l/8aQjQeIpFMVXoYR2db4vIa2zCy1BCg12WTaqH3H7arbBRO3fLmX6PLkFluvGdf
 vWE19e9CPpS9hd2nrW/0hTBShyTCy/EgCXBGGE1jEdgGele+QDoMHpxROD1cKPul/mbyu8kgQVg
 PT09P0weZnaz13jM0wcO8E7qcJMFofwOty3fl9AKIIUy+d83DmYm0rL4hFoI9Bl7ZXKKdkdYSPX
 4NDTiXvAlj2NFjPt8AB8EBl4o2vXIQzc1JllRnMDc=
X-Received: by 2002:a05:6820:310b:b0:67b:b7fb:28b1 with SMTP id
 006d021491bc7-67c22ed13b1mr499109eaf.24.1773950534057; 
 Thu, 19 Mar 2026 13:02:14 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252acd32sm2826eaf.3.2026.03.19.13.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:02:13 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 19 Mar 2026 15:00:09 -0500
Subject: [PATCH 06/17] arm: mediatek: mt8188: check return value of
 fdtdec_setup_mem_size_base()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-mtk-init-fix-dram-v1-6-6171ec141f40@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=798; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Rlo1TUaKAomHp3eIXkyM1sdLm1jab2EAJiaffroIZz4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpvFXunvA1xipqP4VARiLze/4zYKvb0EnmK7ozz
 q8Y+noTWQSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabxV7hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A76gH/2h8b52lt2kYnu7p+O1WRCUDE63GWnoDgxSYdhg
 LtP++o9Gi9syEi/zm2sHr/8yNHpblyoVwaRp92u3cNstoLadEXozWfIuY8nUwPVCMD4jxgD0umX
 WmVWScenvd8HWcNq5uZfcOiOuslBlEWRtDikNrKM7NNT5Vv3r3GLW8gkdXDu/Kp0VaRanVY9O0S
 eWlA/2ZjQBiaLgwTLRdFxp03PS51iDks7Q/JUTD0wym9xDLxHOdiEPMy+qTbRmOUOmt8dUCygk0
 +4ti8B/YCDlRMZSzcNYH8ifcdaHV71J3uMSmOcN+059OWn6QUblgPNTtkDPr4wBFrYavMhjjcJ9
 5lgQ=
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

Check and propagate the return value of fdtdec_setup_mem_size_base() in
dram_init() for mt8188. This function could fail if the device tree is
malformed.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8188/init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/mt8188/init.c b/arch/arm/mach-mediatek/mt8188/init.c
index 61676e8437a..8f0db7455ed 100644
--- a/arch/arm/mach-mediatek/mt8188/init.c
+++ b/arch/arm/mach-mediatek/mt8188/init.c
@@ -22,7 +22,9 @@ int dram_init(void)
 	if (ret)
 		return ret;
 
-	fdtdec_setup_mem_size_base();
+	ret = fdtdec_setup_mem_size_base();
+	if (ret)
+		return ret;
 
 	/*
 	 * Limit gd->ram_top not exceeding SZ_4G.  Some periphals like mmc

-- 
2.43.0

