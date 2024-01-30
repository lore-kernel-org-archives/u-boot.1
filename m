Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2D1C47DDF
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:06:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51A2287E35;
	Tue, 30 Jan 2024 15:05:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jn2qhJpb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 260C287E11; Tue, 30 Jan 2024 15:05:25 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A48ED87DC9
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:05:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5110c166d70so3952917e87.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706623518; x=1707228318; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QjNkUgvj8IKCn47nD27ZLOuWhgx8wnDUftRjmP3lksY=;
 b=Jn2qhJpb2vJ9HktJ7wJmThwn5nBsjK1pRQ+d3oCpx14WXgaShmu7AVg6ZvrMZo7jNw
 Dlr3wrQwElMroP6YxNh9DfDLdscuCoMw93hstL3VSHsjcn8M04DfJJPBCsKZPb6e6LnS
 2mLv6xOZT5KSu3wYca1uEeTwZ/Ko/8LbB+Mn4dOU6+7xCPcwCKMZPnrcqko+nvWOpGiu
 A/dBWNbpSYo3/38Pnczg3pMetL/4rkzCHvj4flDavLbve529aXOPz1HF5wD9eCQwAMBw
 cTQMxVSf+M81uzxxXcmadCVOEPa3+rRKtH+7eEbfhHNNViWBJ0TdG5u+OaTbZ6RiFmF+
 opDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706623518; x=1707228318;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QjNkUgvj8IKCn47nD27ZLOuWhgx8wnDUftRjmP3lksY=;
 b=OySkGb5UXIYHooAIIHOLvJI0nbr1Fk8fVQ/9BkjuCqMQYelDSHdnDv8PzhsKjIVDca
 a1fajM6BI5j83g/Cn04uvRYA8LQy2sOqb/Nl0G6c8OdMhRUWGw48s3rfzZyDA1DURagD
 Dmy2Ee5IcIc2ofegPikOUM653sDGzpE//nUx+sr2e5Djmumcaswgybatymi3t1dNwEoT
 Xl71wHO2NjrnnD0ED18vI0edxpTygYrS9flB0CdAHSSDOZAydVD+yaOyNF887GcDkCHI
 DAU/Izc2FAdwoVBGTlmvmJzStJeRz19qAn4Z8Y4eWrMZrytUtlWTS2kuYx20cMxIHuLm
 FBwQ==
X-Gm-Message-State: AOJu0YxBzcvoMG50TB46WPQvT/fAuGjJgbDW4DH6VjxHo46HmyXECJVb
 UNHrhXCFN08ETDye6UPSlTRPnzox/hVeZQQV0QhILnrc0uoYANZhB0Yz5R1k+sA=
X-Google-Smtp-Source: AGHT+IER3CjrjrshMUgls0OpG0Jn/oEChyq2HQ4qS3/0s4YNaOkt17ZwkMPKNGPB0qLnCCf4Xy3XRA==
X-Received: by 2002:a19:e00e:0:b0:510:16ff:69aa with SMTP id
 x14-20020a19e00e000000b0051016ff69aamr3205183lfg.50.1706623518097; 
 Tue, 30 Jan 2024 06:05:18 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b0040f035bebfcsm1799017wmo.12.2024.01.30.06.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:05:17 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 30 Jan 2024 14:04:57 +0000
Subject: [PATCH v3 09/36] serial_msm: fix pinctrl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-b4-qcom-common-target-v3-9-e523cbf9e556@linaro.org>
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=548;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=2G6nKfYMzLqLXFDSBh6E+zCGYuEDCBtH7xXlX+1sl8Q=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSdTAJH/VT1VWqnG2pwv5+lYvUg45SY+Nn0VY4PuWQK2
 qylVEo6SlkYBDkYZMUUWcRPLLNsWnvZXmP7ggswc1iZQIYwcHEKwES+pzL801H7Gnn1Vpfbzdyf
 exnCOXb3cb1WnhbSFVC+QWYK3/lmI4Z/1rXpRz4UmWy8vWbdRK3WTVvEM26c0fHlbox5nWHqPdP
 nMAA=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

There is not "uart" pinctrl state.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/serial/serial_msm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index 0148ddb54df6..c2da313c94e2 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -204,7 +204,6 @@ static int msm_serial_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	pinctrl_select_state(dev, "uart");
 	uart_dm_init(priv);
 
 	return 0;

-- 
2.43.0

