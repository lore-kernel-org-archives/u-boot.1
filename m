Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331C8C25B76
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 12:07:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97AD98830C;
	Mon,  3 Jun 2024 14:07:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="qJxMzyvG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61D8D88307; Mon,  3 Jun 2024 14:07:00 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C60D881B8
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 14:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57864327f6eso6893417a12.1
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 05:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1717416418; x=1718021218; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yU6hLR83tqYJFupL36Q/2WMiY9agKZbS+dKnPGk1q7I=;
 b=qJxMzyvGDjv6sMjjj3ZfxLGlosx0vi/BZ6sIQ6xo3q/lFm2q98u+2v8UOaVhmgxaL+
 r/+vpvSI+37hrDuTva+kd/BDgUnD+AAsfLXaPfE9d7fp8J3xvpD3qwhcn39D6QjLQYhm
 fOQvHQ9VA8f2+7llxRu/SbGPJngKJpEGhufzcEtduMmzG0K07FL0wxyhTQsiWHaecGLN
 BCWDOeSAK4CfVtbiIic4ncen6uURgn9ledfuqS4vVK7VSvR5BMRuMl2LUiRff3OyOP6q
 jSYU9ER3hnN4PHw0Cm/8Q3kzeJl88N9aE1tTxoBG1p6sWn7g5qfwAx/6rhYn2aQP6q+S
 qoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717416418; x=1718021218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yU6hLR83tqYJFupL36Q/2WMiY9agKZbS+dKnPGk1q7I=;
 b=BA2Kxka/YQQPYM3HsZZsPlDXWCEYtQ2nV05yTAtblLgqEYMP2h9Iy+eWMr3z1RgU7x
 G5qIbr9TbIwtO0tDqAtPMVno+q/REci7vuHePcmBAGyGajZ4PkuiEQM0hcN/SLK6kHHW
 RUg5oJZ2ph0Hy5i0AeY5IkS4gq4QNvvic7oFMbEaiZtN00rIYvMbGT/r0/KtXwukmOza
 A+OdIAi1sPi9MCHbYSvUuWK3NnmbmZUedjJmFnt1eooJxr4NLFroyo5myGY7UlZpmRkS
 OEeon6KqyJP7hwq/LwHLZq8EYVD4WgJLz89LbQw5EnKLfSzX2bZqImrzbWPEV5Axi7g1
 IBXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv79VsKNbq8qPm6cRUyQZrMBglaoFbSeQIEtVusvZ7nCv9GYWyKLmLkvUdtURa9qOF0pIh7yrgOR3b9WBv3yTCndosXg==
X-Gm-Message-State: AOJu0YwYFTLOHiC9IE7Qj/X1udJP/YBYie6JTB9r56rDMcco+3IMxUbp
 0AUVI2SvrSQ/QmmWvNxfjnrStBonTQH6dy9cRFMkYCmhIZ++KSecdPGYlDaIz292V32z1xwPsKT
 n
X-Google-Smtp-Source: AGHT+IFjw4dqU7v+hZSmCHcukLt3PCLn2iCbwc6MQeTqwr0BXNinRRvzbpcIoJUiHQZZraOMpK+LLQ==
X-Received: by 2002:a05:6402:348c:b0:572:b83e:e062 with SMTP id
 4fb4d7f45d1cf-57a4da051demr5986710a12.3.1717416416948; 
 Mon, 03 Jun 2024 05:06:56 -0700 (PDT)
Received: from fedora.. (cpe-188-129-45-221.dynamic.amis.hr. [188.129.45.221])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-57a5cbece23sm2380391a12.61.2024.06.03.05.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 05:06:56 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, lukma@denx.de, seanga2@gmail.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 3/5] clock: qcom: ipq4019: add missing networking resets
Date: Mon,  3 Jun 2024 14:06:14 +0200
Message-ID: <20240603120651.154670-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603120651.154670-1-robert.marko@sartura.hr>
References: <20240603120651.154670-1-robert.marko@sartura.hr>
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

IPQ4019 has more networking related resets that will be required for future
wired networking support, so lets add them.

This syncs the driver with Linux.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-ipq4019.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/qcom/clock-ipq4019.c b/drivers/clk/qcom/clock-ipq4019.c
index 09be203d4b..fca7626ada 100644
--- a/drivers/clk/qcom/clock-ipq4019.c
+++ b/drivers/clk/qcom/clock-ipq4019.c
@@ -124,6 +124,12 @@ static const struct qcom_reset_map gcc_ipq4019_resets[] = {
 	[GCC_TCSR_BCR] = {0x22000, 0},
 	[GCC_MPM_BCR] = {0x24000, 0},
 	[GCC_SPDM_BCR] = {0x25000, 0},
+	[ESS_MAC1_ARES] = {0x1200C, 0},
+	[ESS_MAC2_ARES] = {0x1200C, 1},
+	[ESS_MAC3_ARES] = {0x1200C, 2},
+	[ESS_MAC4_ARES] = {0x1200C, 3},
+	[ESS_MAC5_ARES] = {0x1200C, 4},
+	[ESS_PSGMII_ARES] = {0x1200C, 5},
 };
 
 static struct msm_clk_data ipq4019_clk_data = {
-- 
2.45.1

