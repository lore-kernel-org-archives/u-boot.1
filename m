Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DB3C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 10:44:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FB5D8144A;
	Mon, 31 Mar 2025 12:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Dxhydjg0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFF2A81703; Mon, 31 Mar 2025 12:44:05 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE3CA8006D
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 12:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39ac9aea656so3574956f8f.3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 03:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743417839; x=1744022639; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YfHjgddKLCeqZBPtrkna8Ke5sG7Rtc3yvwwX7BWFmIg=;
 b=Dxhydjg0PDFyR5x9wBHaPrgdm0uWj5uYC+GhDCSsNcjBw05+U662TIV4UlB64hUKjY
 tpMMo+J1cbHpfTI1H4SPEAbZGaJ0ivU4ss6mof1Ide8DSAyYBX/taZiF4rkZBirh/Mkc
 linSDoLerm8/W9oYGBT6aLXte7+uYdLumuGe6FKuMdoEwGjoTkTpI2GzBxfcJBNNsbX3
 fcd+QnpeKPXMJ0SGwx3nGBxIaqTwV4JZAsSU5pX2vvk5KVmqH+MIZPQONbQM4cS5vJC5
 QFaiRJQ4gQDnqSiHFfaftb+gQ6CJZqjsTUyV0jiCHm4eAtw+3ezcCl27zZgl/sr4Ialo
 MFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743417839; x=1744022639;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YfHjgddKLCeqZBPtrkna8Ke5sG7Rtc3yvwwX7BWFmIg=;
 b=TdxcXzwyUmmMa3a89/44ss9359/tpellNIEVNu56UEWvgexO390g6qeEJRB9x3x5PX
 eT2MFxJS6uxAq4YXQY6eBFPV3Fqdmq/b8NV0fznrQtEU2afRFGXwnHYVxcenIwPRJpVU
 UG7ys5h0nM0a9astt2JvquL+amWtfLbufwKtk9Yinv7uDuLACvcWwEEs6U+efT8a5ztY
 QqcuGgUWcYgnjtzFSvC1y9k7DVe1liYMs/XWnsX55uC7H5+LHKekhpz2AiSf5f64kSYK
 reOqILPlnOqDMm0xKcAqjqwOwT42FhqUh2ztA5/ZT5bJPsqbZe5YIvUS5NCtV4hOWWo+
 Jbfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiyFRNpSERMDr8TKE2AW6ShVyrWAsH2hCcVJrcGwDjxNAZY263PXsO1r+FcDIyirTcL/rf5Io=@lists.denx.de
X-Gm-Message-State: AOJu0Yxy3cJ41QrF5ICTfwC9zcJqaIa8gdGUDgXhwxlY6FfEoxrCGFM4
 LZc/nB6Vwb43fG4CboE/oyg5M7vz9hDD0HtHFiZboDzymmYlocCLWtKn1CvxiYI=
X-Gm-Gg: ASbGncvVbaJRq9fcPriP2S5f4zR7805netFW/S1PEtbksjjjnoavicEx+7ceVEJ3WVp
 MilfWYqkJKCHKE0UkrutONAmhkg6GaCUUw+rFd2CpfnqJRIrgvgF8CfCLTA19PiDD6Gws8PgYel
 l4tt4KFmET/ghZd17PiwZIYYVaUJ8kdroY5YsuJEUex9bqk8/2A8BJRchPSxs49Z/8ORBILbS77
 2zFj6how3AhzaOmorZlBaa2YMySzjrObs4D2AFl7hoHPiNhgAW0Q7LpqCDtHzkTcihMIlopeE9e
 KUFJajNYxhj9erTUq3+v4atrVctt+dGq8MsidBzu6HdRakbol6C1jtZ2ibTYV7WbGm5Ie+GdbDD
 3hJd44TplVd/w
X-Google-Smtp-Source: AGHT+IHRlZ4XIh8dspRLJoCVAhdAOw2Q4c5TCQzoj3GXz3S+ToZs0IGWHgSK/p3NFxl+qhZ12ucs0w==
X-Received: by 2002:a05:6000:40e0:b0:391:4977:5060 with SMTP id
 ffacd0b85a97d-39c1211d5b0mr5629128f8f.53.1743417839269; 
 Mon, 31 Mar 2025 03:43:59 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82e83482sm164469675e9.14.2025.03.31.03.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 03:43:58 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: Sam Day <me@samcday.com>,
	u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH] mach-snapdragon: of_fixup: fix condition check in
 ft_board_setup()
Date: Mon, 31 Mar 2025 12:43:18 +0200
Message-ID: <20250331104327.321339-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.49.0
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

The fdt_node_check_compatible() function returns 0 on success which is
pretty confusing, and we were using it wrong!

Invert the condition check and refactor things to be more readable.

Additionally, add the check for the RB1 which needs the same fixup as
the RB2.

Reported-by: Sam Day <me@samcday.com>
Fixes: e64503f1fcdf ("mach-snapdragon: implement ft_board_setup() for USB role selection")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/of_fixup.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index 55368dd43b66..588c92c5cc91 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -160,16 +160,16 @@ int ft_board_setup(void *blob, struct bd_info __maybe_unused *bd)
 {
 	struct fdt_header *fdt = blob;
 	int node;
 
-	/* We only want to do this fix-up for the RB1 board, quick return for all others */
-	if (!fdt_node_check_compatible(fdt, 0, "qcom,qrb4210-rb2"))
-		return 0;
-
-	fdt_for_each_node_by_compatible(node, blob, 0, "snps,dwc3") {
-		log_debug("%s: Setting 'dr_mode' to OTG\n", fdt_get_name(blob, node, NULL));
-		fdt_setprop_string(fdt, node, "dr_mode", "otg");
-		break;
+	/* On RB1/2 we need to fix-up the dr_mode */
+	if (!fdt_node_check_compatible(fdt, 0, "qcom,qrb4210-rb2") ||
+	    !fdt_node_check_compatible(fdt, 0, "qcom,qrb2210-rb1")) {
+		fdt_for_each_node_by_compatible(node, blob, 0, "snps,dwc3") {
+			log_debug("%s: Setting 'dr_mode' to OTG\n", fdt_get_name(blob, node, NULL));
+			fdt_setprop_string(fdt, node, "dr_mode", "otg");
+			break;
+		}
 	}
 
 	return 0;
 }
-- 
2.49.0

