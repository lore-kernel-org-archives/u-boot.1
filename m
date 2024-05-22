Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E152EC25B77
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 10:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59AED88096;
	Wed, 22 May 2024 12:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="gR/AvLy/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1002988473; Wed, 22 May 2024 12:14:42 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25DCB88096
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 12:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a5cdd6cfae7so112373266b.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 03:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1716372879; x=1716977679; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Gf2WQOkaa28aq44jbECvxipRFfi6tUcm49kTdGh7JMo=;
 b=gR/AvLy/rM69NqDt1vX0RZwYQDlksNsbwTUGvYEcBby+puQJnHu5WNN5hryExXQar7
 HC240KP2xwIBBLeRamMULCmFUxqqNlGrsK3fpZxjaLFElXnO3NlrbXd/vghU4pI5us9v
 8g+lFTZMfxWxSkirCCIeWuHkNVRTIdG63nHZHSNYk2F9tpWtFjRuJsv7bkOrC6x5jKgb
 /Ey7EcBfwx3KAZh0ASDsXLpivI2J2a8WUEXS4KE3VerhGLoeq2DjbkeM1z0O+XqXSYbW
 dRKCZ7+tr9ybzKlnh779aezhW/zvJm1aXKRM5SDJlDSP55GYLlSIhB4SjLppASWe3gpY
 Y2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716372879; x=1716977679;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gf2WQOkaa28aq44jbECvxipRFfi6tUcm49kTdGh7JMo=;
 b=RnnimYB2uXYPE9eFXZ5EVVY/9GQojBW24R6jnNCAIG5aF9xuaEiAcy6r6cf2m8R+8l
 4YFdLL+9WRoIQ3hh97ZbzzpISsRRHu2+UiiP7uTDigEx9kiYe9IdYuACKtrEy4A5UE5G
 f//pWRmI36kXU0FSHPsrV3lPF+7d1SOQbpquj2sHTaAor+xqHv6ssr5ZZBbatqmTevFr
 ar2AsLik35YHWRwRT2QuU5OAB5RuggQ8+T44JsnmxIGa2ZCBFcIsi7IkrmTGiG5UolI8
 tniaYOEFoSYFukdY1uKPWNi+0oUfhbavjnFxo9A5OrZvMgwQ52tRDIwObgKjIeGSY4/Q
 PCGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBinJPYpo2b9o+tm96b2L5Zc+/u0If5bPqGBbDdygnA033peUL4vSpdNxQ3AixlnJWT7fRJ4wb/i/r5K079WSDcGz+KQ==
X-Gm-Message-State: AOJu0YydEpKHjdF6bwXxzrJdLzZ9VAEmWy5JplIM60d7LQMgtyAZcPrl
 SnGIMP9D/q2nV9l6cet6+EoxogDDzI3eU4A+YwQwtG/Cd4PcFtTtoF+EiZ0unc4=
X-Google-Smtp-Source: AGHT+IHzZ+6dOyCVznjcTjWT2uKJwHtk+PX8mS7QWKQTcoiTSNXIiNy3cdTfqqE4+qSu5ZAGFJ3R6Q==
X-Received: by 2002:a17:906:b2cc:b0:a59:f2d2:49b1 with SMTP id
 a640c23a62f3a-a62230f6f8dmr138160966b.9.1716372879471; 
 Wed, 22 May 2024 03:14:39 -0700 (PDT)
Received: from fedora.. (cpe-188-129-47-65.dynamic.amis.hr. [188.129.47.65])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a5a8b634cdcsm1081502166b.93.2024.05.22.03.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 03:14:39 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, lukma@denx.de, seanga2@gmail.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, j4g8y7@gmail.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/5] clock: qcom: ipq4019: add ESS clock
Date: Wed, 22 May 2024 12:13:41 +0200
Message-ID: <20240522101437.225880-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.45.1
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

ESS clock is the Ethernet Subsystem clock, so lets add it as its
already configured by SBL1.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/clk/qcom/clock-ipq4019.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/clock-ipq4019.c b/drivers/clk/qcom/clock-ipq4019.c
index 0492e536e7..e416c9cdb0 100644
--- a/drivers/clk/qcom/clock-ipq4019.c
+++ b/drivers/clk/qcom/clock-ipq4019.c
@@ -125,6 +125,9 @@ static int ipq4019_clk_enable(struct clk *clk)
 	case GCC_USB2_MOCK_UTMI_CLK:
 		/* These clocks is already initialized by SBL1 */
 		return 0;
+	case GCC_ESS_CLK:
+		/* This clock is already initialized by SBL1 */
+		return 0;
 	default:
 		return -EINVAL;
 	}
-- 
2.45.1

