Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4D1C83F1A
	for <u-boot@archiver.kernel.org>; Sat, 12 Jul 2025 05:43:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDD1B803DF;
	Sat, 12 Jul 2025 07:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cSnXM1pG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 835158277D; Sat, 12 Jul 2025 02:13:03 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08A61803DF
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 02:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=davidzangcs@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-73a44512c8aso761094a34.0
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 17:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752279179; x=1752883979; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o17V27T06MpSUqHpeWnRpWyVn5JserzB5tvov33pwss=;
 b=cSnXM1pGhNlfNy/EsYIqXmeB1NLfxDcjg/Br8u+NBCfWcqfrwGnsBXMHbUIXJ1hiEm
 tvZ5090lwDDKcf6T0kgFE4bnuSzDRjph2H7sJPlCA+GB9xcgoz3IEcTfVJTSjiZufxHz
 Ys77BUWb/IV6bs9RNf0WJBjhAaVWu1EnwzaQ//wRxSAXaicuTok9gKLzvkTgjXU8DDX7
 XNy6Os4hoiK7CDpBDOZFd80EflfivBLxrB26BfXnUcx8VyZDIbKKeGKcIm7g9rmgYzq2
 ZhSasTX0M4e4WX02HsBJQFMbReg5n1KM1m0FISqb5uDFiCUaio8fPmtCpt5u5j3kj0w0
 OykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752279179; x=1752883979;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o17V27T06MpSUqHpeWnRpWyVn5JserzB5tvov33pwss=;
 b=W8s/SsfPGIYxRJOvbSe+k+Lx/3HTnnz1BvKiTmwoUH787PjVeE7+lV6GLxuyq44E/t
 Dliw5uDB/DUiyFrrVdMPFY3elJhZ94SF9oieQPD0F+yWHDypvBgHi1tiEaO9IGaZdrqW
 bo1q/6Oqezqhr0MDBglXq9RySnS7OcAZon3QodInAPktEYZfjXjxUCEFeUzAwYbDnvEt
 ReUDCsYkHwOM8yTrrQ3Uh4AjtDWtpEosO6dXMMmivCLBIloV/4zvF8uykfdTdyMfsQ+f
 cceuSBOGRFPIQ4r8tjJRh0QRRuC6PI/l0S6tGYwtMqQiJ/Bw4zKK1bGIYuO5opTUuhm0
 BMrQ==
X-Gm-Message-State: AOJu0YwZ0/t+ZB9FTGSNqyS4JydLiWi/gRKr1sT5vOICutEgMQqRrQQ0
 yJGdimnW3EmNNMTOKvxq+5hEJHmgIh25x5IvPVljwnF8zv+DKpDur+3PpKInZQ==
X-Gm-Gg: ASbGncvO4+lqlj4r34RLc215Z6g8mps+gl+IHoFXSAFeknddTGxHKG7PXiZckm5qWUd
 UpC5DHH0ANfHHHBD7OCfeujdoGsPvUcGBVnBgA0B0rZoeJDIetX9zq0QmVLFYyBHD3//rcZOBzU
 4SYmPSZIvowgIH1tVZ0Zd4XLt2Rgf0yJGN/kX6zgwy/64ztaBq2Sm4sGGWlmRdLVJ0xzMApZ6O3
 2ao5H0R4sHJAVpDkcDIa3L5Rl/qA1qSDhddOv+GWraHWijn6M96i5Kwgrhf9OWEB8lFRDvjYTi/
 i/pNY4JVaN8leSd856I0lpcvtxmZkrDoRK+1Gc8Zbqd5VipIDfTp4lbo/F5o0xrfaoN3c5nKlWG
 JCdK8OYo2S/T8xfvKv0XijJW9c3GvhKncZFeF0sIdnwxy1Dsqgo2+06mQXr/Kl1hot1rbv2fBnl
 A=
X-Google-Smtp-Source: AGHT+IGWM0zFni4taAzb62dhzUGOL7nmWNiT1KA9zS7emRZJY8JQzcKjbGKDsnq9ueqL8aUAsi/AwQ==
X-Received: by 2002:a05:6871:70e:b0:2d4:e420:926c with SMTP id
 586e51a60fabf-2ff26389acfmr3066310fac.0.1752279179293; 
 Fri, 11 Jul 2025 17:12:59 -0700 (PDT)
Received: from dva-Latitude-E6440.lan (syn-024-027-011-011.res.spectrum.com.
 [24.27.11.11]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff11684d21sm931123fac.30.2025.07.11.17.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 17:12:58 -0700 (PDT)
From: David Zang <davidzangcs@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com,
	David Zang <davidzangcs@gmail.com>
Subject: [PATCH v2] soc: imx8ulp: Add celsius unit for temperature
Date: Fri, 11 Jul 2025 19:12:54 -0500
Message-Id: <20250712001254.232825-1-davidzangcs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 12 Jul 2025 07:42:59 +0200
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

Make temperature unit (celsius) more clear to reduce confusion.

Signed-off-by: David Zang <davidzangcs@gmail.com>
---
v2: Add commit log
 arch/arm/mach-imx/imx8ulp/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx8ulp/soc.c b/arch/arm/mach-imx/imx8ulp/soc.c
index b5dc45296d1..f80890e62ae 100644
--- a/arch/arm/mach-imx/imx8ulp/soc.c
+++ b/arch/arm/mach-imx/imx8ulp/soc.c
@@ -279,7 +279,7 @@ int print_cpuinfo(void)
 	if (!ret) {
 		ret = thermal_get_temp(udev, &temp);
 		if (!ret)
-			printf("CPU current temperature: %d\n", temp);
+			printf("CPU current temperature: %dC\n", temp);
 		else
 			debug(" - failed to get CPU current temperature\n");
 	} else {
-- 
2.34.1

