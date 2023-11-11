Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048EAC4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 11:44:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3370C86F5E;
	Sat, 11 Nov 2023 12:44:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="BCIl4RQj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2011D86F7E; Sat, 11 Nov 2023 12:44:37 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B81786F07
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 12:44:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40842752c6eso22607635e9.1
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 03:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1699703074; x=1700307874;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=92ngT8tSBKi22kg6roS/LemoYD1szR4sTuLD1EI5+IY=;
 b=BCIl4RQjEtWI5hTAKg9JfCV+/rlwSDKrp/ulRiydhTNn3IxxBVhyBjPBvaZnYnSOwz
 iUCNB7svKwCqsmoZZTJvlju5AzRRTo7NCLmiY8Oq4e+itMdVM3+yb7Oqv+GPJnonFjlf
 vURPUVlL71ROpssOAJqeA85oKVMgAMUoaY/0e9IlSLv4zk0fSnchHLcRHS7mr4Yc7oDJ
 fiWW0daWLZXmEk84lqXnjPVGiFKoLr3tooxc5xTHPnW4tUmg/rtf+sG6AnwWIZqVyc91
 XgVamBvzrG0o4+0Bf2p4e96CsKFk+fjm+1LvPlPHchC+Ld4p3ckaCc82g+gP8ed5GXw+
 hEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699703074; x=1700307874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=92ngT8tSBKi22kg6roS/LemoYD1szR4sTuLD1EI5+IY=;
 b=kiAHciJsaaxK8cwW1mMMVFbVIfmcqlWJzrpx1XrgSe2zxvRDlZl5Uf23HhLaJQpuB6
 1Sh0JBKGaumGzYBH81MtjD9qAFYrprrtsjc5sTRLU+wPg4fWRFbDsEJ4ugpKIqPCeLFz
 BliJkaGmoiD9idBs7KN4qzHsUN2QhJiKc6qejLJzzeF9I0ZTd7YugLT0S4RhzrTaQfdS
 3TUc1+KyPU7LLbr1unQUaUwdMQVniFxovVpti5XtNv3YqbhnF1wDZLj5KqWTq1kPglC9
 NzfiIGNewFaHFDl1yuNZdEEjRNPeQlEUcsGLMROfA9EYfLM7VsSKFqT4EaZzJqO2EYfa
 MY7w==
X-Gm-Message-State: AOJu0YzOh3Ck5mdh8PPI0Co7gvtC7mPJTbIBKiuF2jIiCAN7/TJT5kSM
 xorHy9SiVa03yCNhOgW2iTuSq5IDrnONaOSSmjtW9LM5
X-Google-Smtp-Source: AGHT+IGMlsxTz16UiMY/wSozmnmEwSIa3n2wpjgr9ii39BRMf2IpRcG+AQCWZyxqe42g85/A3VJd0A==
X-Received: by 2002:a05:600c:2d8b:b0:406:4573:81d2 with SMTP id
 i11-20020a05600c2d8b00b00406457381d2mr1547258wmg.39.1699703073933; 
 Sat, 11 Nov 2023 03:44:33 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 j16-20020a05600c191000b004090798d29csm1957874wmq.15.2023.11.11.03.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 03:44:33 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, Shantur Rathore <i@shantur.com>
Subject: [PATCH] arm: dts: rockpro64: Add RockPro64 smbios
Date: Sat, 11 Nov 2023 11:43:21 +0000
Message-Id: <20231111114321.543394-1-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231110235806.525529-1-i@shantur.com>
References: <20231110235806.525529-1-i@shantur.com>
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

Signed-off-by: Shantur Rathore <i@shantur.com>
---
 arch/arm/dts/rk3399-rockpro64-u-boot.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
index 732727d9b0..a4453e76f6 100644
--- a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
@@ -9,6 +9,28 @@
 	chosen {
 		u-boot,spl-boot-order = "same-as-spl", &spi_flash, &sdmmc, &sdhci;
 	};
+
+        smbios {
+                compatible = "u-boot,sysinfo-smbios";
+                smbios {
+                        system {
+                                manufacturer = "PINE64";
+                                product = "RockPro64";
+                        };
+
+                        baseboard {
+                                manufacturer = "PINE64";
+                                product = "RockPro64";
+                        };
+
+                        chassis {
+                                manufacturer = "PINE64";
+                                product = "RockPro64";
+                        };
+                };
+        };
+
+
 };
 
 &sdhci {
-- 
2.40.1

