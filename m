Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA83D5C0C4
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 02:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B702F80FA1;
	Tue, 16 Dec 2025 03:48:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YZQMl+Nh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F4D58036B; Tue, 16 Dec 2025 03:48:12 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9BF482BF2
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 03:48:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7e2762ad850so4256329b3a.3
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 18:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765853288; x=1766458088; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ecbjpQymzWhM5INOx/qY6mXIEdSbwEBhRyZ6tTIERU=;
 b=YZQMl+Nhki7/siFmP9RolrCQ/BSC5n8WqjZv1s0UHgfkjSLLbFuNKcDwHkg6fS0Cft
 UeuftkgVPOLDnPG4nmybv8aCqSkVRvk10cPjlmNK2HHilDLHj41Vm/VMGJbJLgcrk6ss
 kYqpZNPc+uYRopg9IA5lI0Iji3EA8imZDDj4b9Pq3bFttAUUZl1nZ/m1dUtmhN9hPgZa
 12+QckPkC9AU5pYBrpzNDo2FVGQRMjXft688Zfv3sCYTvRxTBbFA0tU5t06YPb1tlZCo
 k2kZEJgNsvoZwsN2os0U2oTThxx3ANGmARYu8i57MT/d0TlOcHfvMhNipPJNo7DxoX0k
 EWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765853288; x=1766458088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6ecbjpQymzWhM5INOx/qY6mXIEdSbwEBhRyZ6tTIERU=;
 b=EcLYWIZ7rqLJOwo5azVt4ttiuSD7mn2fGe5vLkqXm3s0FXXuxUe9Z/bsinJn3XZjUH
 S+xGbkjYyFz9aFNiP+W7LPuWy50pV5q8ufObXdFbuQSE+cx7fcByGRVxfFEpxPQUo2Cc
 5E7i4wJp6gPmPN/LyckbBq98IXuKeu3fh7Kk/MOG2/gphtip/LAdpgOG3r3Zr4La78iz
 LX2bro4hcR2jLIMlzfLkyGyG5X7xKl+cJfD3mVN+7bgA8x69ZtNoubvl2wxY516pFl+h
 dm8+3RI1ngoSOmRif80ha0YiEULTb3kuzJlH8v/tWolHES6HvsMScnCTTjo0NULzSKql
 4hkw==
X-Gm-Message-State: AOJu0YwmuzOkfDhn1lV/nuTaN6FeQySMOd+2ld81D0uDO3LBzhFcp1vV
 Lzb89Is/LDPBCqJTRfEgcJPiBikEbEltAa3EqSCVYyNAUend4cjDfwp2NjFVchEQ
X-Gm-Gg: AY/fxX59wtSXkxmHs1W4vw9ABjS7snspTIF4fJflx9GvYcrCQOjFdlWksWfZUQFM7zd
 U05mZnXFhjKfIzE3MZwZKByzFLCAJMOk5GbZb0zeGyn/GN1i//dncpMM4Mr7pZg8o1K9C8er0pu
 rhdE/tYfeK6UEzNBzX9z3omYi2hJj+SdsftMaMx7LY22y6LL0+WF2cHIv9No0XZW+kzqXQ2W3kk
 jIV/nDhNSipdCiHnJvmJnE2zhhQ99tq1c2A7qNRLIJymW3UGpw+Q4k0dkkFDsMuYilJuNuau1G9
 PgBTOhWKI/VpwW/69S0JG+95Vz6+49PuAJgGRuFUl94DSZOy5A4vU2c7Q2QDMxwZnrFkia1N1o0
 qBvmgLvcZxbshvr34K26bImcHPC9s8Bv2ZTDeE+5wyIeqqryevEYEF9Ii/KCR6OrFQG6H5+9npN
 veGJ7SgvCCd/5XvXGBQS3lja3rwod4Ni6Z
X-Google-Smtp-Source: AGHT+IGqtDBjldmdc5bt+vkNpkDoVzHCIU08viEmw+A99vjqJtE7xPLuNt48vGEpVCCkagZ1wmTYiQ==
X-Received: by 2002:a05:6a20:94c7:b0:357:78fa:b338 with SMTP id
 adf61e73a8af0-369ae77903emr13134269637.35.1765853288123; 
 Mon, 15 Dec 2025 18:48:08 -0800 (PST)
Received: from cs20-buildserver.. ([2402:7500:502:d4da:9fd1:87b1:de1a:188c])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c0c26eb1d05sm13401606a12.13.2025.12.15.18.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 18:48:07 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	jim.t90615@gmail.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Ted Lee <xrli@nuvoton.com>
Subject: [PATCH v1 3/6] pinctrl: npcm8xx: Remove incorrect spi0cs2_pins and
 spi0cs3_pins
Date: Tue, 16 Dec 2025 10:47:26 +0800
Message-Id: <20251216024729.1031306-4-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251216024729.1031306-1-JJLIU0@nuvoton.com>
References: <20251216024729.1031306-1-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Ted Lee <xrli@nuvoton.com>

Signed-off-by: Ted Lee <xrli@nuvoton.com>
---
 arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi b/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi
index cdbe19ccf50..cb57e1bcfd8 100644
--- a/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi
+++ b/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi
@@ -544,14 +544,6 @@
 			groups = "spi0cs1";
 			function = "spi0cs1";
 		};
-		spi0cs2_pins: spi0cs2-pins {
-			groups = "spi0cs2";
-			function = "spi0cs2";
-		};
-		spi0cs3_pins: spi0cs3-pins {
-			groups = "spi0cs3";
-			function = "spi0cs3";
-		};
 		smb3c_pins: smb3c-pins {
 			groups = "smb3c";
 			function = "smb3c";
-- 
2.34.1

