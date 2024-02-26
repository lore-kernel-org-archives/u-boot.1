Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC39C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5103987F3F;
	Mon, 26 Feb 2024 18:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ktOSP/G9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9303987F5B; Mon, 26 Feb 2024 18:26:30 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AECA687F3D
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-412a9a61545so2811225e9.2
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968386; x=1709573186; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mHLFcF0iiZ24FxU/mNg7v+xtI1q0/dVgQpZt2O6jjGk=;
 b=ktOSP/G9ktj2tNiY+eRulIsZuLJfa7p1ansITjYOi6fImTz8BRQ8EdMFgB95jxkgaV
 7yERv0i/YQfTOK1lHNtbfM3rmqoizbQW+YSGG3F89CM+OhIJtGsk6FfmeLXrK5cc+Dnj
 xNEl4oYp9q2JGyBeBozz7D2On4+Jy8m4W/lseb9i3ym2ail1uT8OSDBfxR9j53Yuwybh
 uKCggPKkoJUEOOPytHSLm3nKqf5WTtwuSgB14ITYEgF+Ph5vRZ8jCKvfjPj6S2xupsRJ
 5/mSK550SA4J4l/Rtoynqrp8JAt1AdS8lQWgJ5zqhAoW/4Yj+PcDxUCEO6S51//4SIKd
 D15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968386; x=1709573186;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mHLFcF0iiZ24FxU/mNg7v+xtI1q0/dVgQpZt2O6jjGk=;
 b=BpwTcXEq3MT81KSU9nfXYhY/PwgXfVPr1uj1kUea9w9vrcCmZxIAQY+iJtK0/3NHQ1
 FeVmBFITU3Kj32HcMN0ha6Y3nhMyK6+BMbgalpkTUt6G43zuZQOLbQfeImxZm1zl6F6y
 zFud9/UPuNjyNLhri7cvMP2HXv/8VDBXyHv3yBkf1Y0Rhrzz1q/zV5PE2uirMp4EGAm+
 Tzf0EjqrXG5lIBRJn0NZ06J6oXCFfC5MDDbUYT+swK/vLt58DQsiYmERh8qjX74pZl1b
 6V4SEmoa77y3JMv10DPqWT6V0fBz0/hr7wPPrCQv3LOgU+KyROwmnsxqElvoJewPUsrZ
 1jSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVWCzZI6oZb/RhJM5hUybZKHIRtxYkxuRe0m4wtGx4o1ef+dyak9iTjYxGtIZJ1DA+U5FoqJgky5lBrhZOSVAMuVxhwA==
X-Gm-Message-State: AOJu0YxA1TSgT0zMg7YdGUTdyXKPGnVjCgfPdRJwQFxTtysTMXT+F9xL
 q3ewxMJw5kq5Jebraw/C1Vi7y/mj6B0lduu6DrCODD+2/ThbaBQPJhvIGy2B4Mg=
X-Google-Smtp-Source: AGHT+IHHjZosKlfQAm9LNzMkHsRiHz9I9ITVGaaZiRDzKKicfCy26i4y90+2nygJPzEU8BUT+G1vVA==
X-Received: by 2002:adf:f58d:0:b0:33d:4f6d:de84 with SMTP id
 f13-20020adff58d000000b0033d4f6dde84mr5142737wro.6.1708968386247; 
 Mon, 26 Feb 2024 09:26:26 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:26:25 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 26 Feb 2024 17:26:08 +0000
Subject: [PATCH v5 04/39] dt-bindings: drop msm_sdhci binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-qcom-common-target-v5-4-10c8e078befb@linaro.org>
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
In-Reply-To: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1363;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=u3bmxMv62iX1kgO92yMvXpC+4qwcvY1EOjhQzN+P8p4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J3d+mvaQKaDQ8cibMKXqpaXffMzUD+/f6nvusMC3r
 Y8V15iodpSyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJ3PnM8L8waYncE6XGjGfL
 4mMVfLl+X5e7tiv33zHFckdmx2V2CjoM/wyz672fONw8c3pnmPPmzKVH3ERcpWUepXj8Ddc5/FB
 ibgsA
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

The upstream DT is supported here, so drop the U-Boot specific binding
docs.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 doc/device-tree-bindings/mmc/msm_sdhci.txt | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/doc/device-tree-bindings/mmc/msm_sdhci.txt b/doc/device-tree-bindings/mmc/msm_sdhci.txt
deleted file mode 100644
index 08a290c66931..000000000000
--- a/doc/device-tree-bindings/mmc/msm_sdhci.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Qualcomm Snapdragon SDHCI controller
-
-Required properties:
-- compatible : "qcom,sdhci-msm-v4"
-- reg: Base address and length of registers:
-	- Host controller registers (SDHCI)
-	- SD Core registers
-- clock: interface clock (must accept SD bus clock as a frequency)
-
-Optional properties:
-- index: If there is more than one controller - controller index (required
-	by generic SDHCI code).
-- bus_width: Width of SD/eMMC bus (default 4)
-- clock-frequency: Frequency of SD/eMMC bus (default 400 kHz)
-
-Example:
-
-sdhci@07864000 {
-	compatible = "qcom,sdhci-msm-v4";
-	reg = <0x7864900 0x11c 0x7864000 0x800>;
-	index = <0x1>;
-	bus-width = <0x4>;
-	clock = <&clkc 1>;
-	clock-frequency = <200000000>;
-};

-- 
2.43.1

