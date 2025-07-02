Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBAAC7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80AB48306D;
	Wed,  2 Jul 2025 03:05:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tnCDSET8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68DF38305C; Wed,  2 Jul 2025 03:05:21 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 061B982F35
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:05:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2ea34731c5dso2361953fac.0
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418317; x=1752023117; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=HpJonqWY0Lzsq40QUg0EPZ4qbKeAw2faaKgw/qxF5l8=;
 b=tnCDSET82Vbi6TvkbgSaJ1ajMzXhZEAxMgsevS8mVjGB/pmIf8A7UpjXomBm045pLp
 EI2NFcyPw55bd69gYamhDsuTPjcKVseLOopzYtBgSULT7Qybk3TGDN4q31w/D+R+5xUV
 XG3zhLmoWiZkUfLeDaV3ZpYT9YbD/garorczw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418317; x=1752023117;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HpJonqWY0Lzsq40QUg0EPZ4qbKeAw2faaKgw/qxF5l8=;
 b=IFSJV+Fc0u0fdcUQQO28YJzcufbr/5VsQ/ZdpkxnoDTnQet5fA+4GRVWYyswpv27Nf
 im2C1GcFhbOTHcLfe7+BzpozuFUo5ArL9OVXwYYlWGRneyHLJp/XjXjnJfWNK1KB1LLJ
 5+fK8+NhvmrHiGCUrMEYLr8FyFw/z44EclvCk2N7cA8E5k1WSrS1PDrtK4YyBYTPkNr7
 mJMKMY4MIMwBVuR/3cJhj6+6TdGiNHW0Bdhj8ojMjCNXPoH+FdNWctH1P7xM+/8o0C2D
 JdxB8GUHjlEdtM1h43rfHFmHbr0KdIlQc/QMEyTfOdBvsjQioiQtrME0hpUEU6H5it/T
 Ns9w==
X-Gm-Message-State: AOJu0YwOTw30dLwTtA+NYXIUBdd4JktHfQ/wWKMBguvcmHeDmW0LyWZn
 29SV4xyffOXHUkcIc2/J9YstM7M+CPIiruo20v0auuKhZRL+htTH8AKFYfxIYtLIJ44uy0MF9fM
 1rT+kQ14=
X-Gm-Gg: ASbGncv9+2sd4HMy5SGNYDOTUTUm5xuCdDiTzq6pKQ0dkn0EzOYjvo2DFOa2Hpvgzmg
 gGAJC1KuVylz4Oe6W/dHU49Pc72OtPsMeHLXOBRApiQPE5pNRJ2oJBkKFUNQ4N1f/NxidNMahiZ
 WVGt4XIVmCdsdWFOlavIXlcdXRtLIis+STWpRX1nH0cbtd3e0fvO/5LoQdP6UozU9TalGFYj9EZ
 P5uzMGWUmsLMM9RaT7CRXGr+MIwTUNXr91ssaaZzhJo9DXKDNIda0kU6dxJRL2wvARWjJMxK4P5
 4Mk9HpAiHJBSO2/rXrK/C9QXIllB2immr4fBkKRyw9W2hDgLQE41Jo3dNikVsaFv0dnT8xWVLA9
 w683SvPTdKHrIuvvbNHyYulzRh5HoURF1pA==
X-Google-Smtp-Source: AGHT+IHEW8xb0rZCCk/UUVGPE6KwJtlv1syKAoUMDQeXSjdxR4GZ3N9KB6etwWLh1FouZZBkpvdoNw==
X-Received: by 2002:a05:6871:e523:b0:2d6:241:aed5 with SMTP id
 586e51a60fabf-2f5c7a8ec2cmr791198fac.26.1751418316637; 
 Tue, 01 Jul 2025 18:05:16 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b0cf0sm3525379fac.29.2025.07.01.18.05.15
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:05:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] post: Add dependency on ARM || PPC
Date: Tue,  1 Jul 2025 19:05:14 -0600
Message-ID: <20250702010514.19184-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The post framework requires architecture specific implementation
details. At the moment this is only done for ARM and PowerPC so express
that requirement in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/Kconfig b/test/Kconfig
index 31016eedbf8a..77e7cad3984f 100644
--- a/test/Kconfig
+++ b/test/Kconfig
@@ -122,6 +122,7 @@ endif  # UNIT_TEST
 
 config POST
 	bool "Power On Self Test support"
+	depends on ARM || PPC
 	help
 	  See doc/README.POST for more details
 
-- 
2.43.0

