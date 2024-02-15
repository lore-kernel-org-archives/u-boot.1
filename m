Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3188C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 20:52:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FCCC87EE0;
	Thu, 15 Feb 2024 21:52:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Uz5GxC4P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3631887EC6; Thu, 15 Feb 2024 21:52:40 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBE5F87E62
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:52:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-411d76c9ce3so10945285e9.3
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030349; x=1708635149; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N39MDro1gnB5OKwN6nLV9e9epMZfF4jPCx0mh/LkvsE=;
 b=Uz5GxC4PN3v208TX/NlF0dNbt9Sfa4tt2aJITqTOYPbd1EyKwYnYH3MVnM8l2EfYOA
 Z6Q9YwEllsABsst7tIczDDiX+0VNr4SHGoKIYIGgizQEW1xAz4uIINgVumx9PI8spXiv
 Aqh/ZbSXU9PpAarD0t+Enyq7Mgh8NUgmdWMiWoBDP8RCP4MpKPMKuyhPw6gGiKj2ClFo
 Du3OJxhZ5VD8ootF4RsUqkndkZns70tti/d4shl0nmfks1nZi47NQIB/No2Dz573Nu5S
 ptiMrQcLaeU8LmX5yVIkICzkWlhEIOLQ58e78JKuz/dm9jFbn1+E4HVPsrqVoEoU4HwO
 aWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030349; x=1708635149;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N39MDro1gnB5OKwN6nLV9e9epMZfF4jPCx0mh/LkvsE=;
 b=JdWe4q7q57pWaUqwWOZD7heMC2kvdoXPUyP1sn+7Z7vEtZlvYofqtWMUradjXUo3a9
 4ZTkZFjKxFxNCxMypa0fO5sldyrNlxbkRIAdgKWu/DqPOuaOzcaAS4z7Ee3ZHDxCIw4D
 IXXvJL+DDm1tUWp75ULTKGjE2CDtJIE/UeRAc9djTpgyo7wPiNKRWkT4JkdUweNDkLtR
 4tn81fVbqGDdXDCR3zh+BkANIbrSi1dYs/hOfHmrwTgRUbWrD7wC1tixC3ohhlvkzLo0
 Um6dQIsRSSg2yz6qQwBqpuhuLjhFShfqJ3uul/pIVhP4kWHM9KZiCNOp19Afvw7RxX+U
 sDuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXIG2inCp1O8fY8Hu9yh2WEyEHSgxyJOR0hnZJXJ1xXgx5fmC52wjXuZDGfmGyQQegTn/jdG+wTNNStJzy23YkWyANvA==
X-Gm-Message-State: AOJu0YxocVvf5+LZYk1QTTx1PnhmHcHAyXyqwKzPvr4xDqpa0zxYF1Vl
 EFboyBxSEvYfyOPdq70/WND99UrXfFqFXZskP2TTLfknFVxwZ8Rjq0sjN8mAmAD3zTnykV205br
 P
X-Google-Smtp-Source: AGHT+IGxd2dFnHTGS37I1ZBNO/GViy+bcjwGAIsP+Q2cjBbl1zRaCoFfduRAZr6QjSPju8RayaxL9A==
X-Received: by 2002:a05:600c:4f0d:b0:412:107d:cd6c with SMTP id
 l13-20020a05600c4f0d00b00412107dcd6cmr2059899wmq.28.1708030349243; 
 Thu, 15 Feb 2024 12:52:29 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:52:28 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:22 +0000
Subject: [PATCH v4 04/39] dt-bindings: drop msm_sdhci binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-4-ed06355c634a@linaro.org>
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1314;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=wZt3+aQITAxNEX/0oC7p19t8Im377hpNDdo1L6BzB9Y=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzlS1HOpeKrglj6y4tzjrCb+p7avGLiTGxlgsfFtl26
 r9Jc/reUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACYyt5Thf8iduv37zOYY76s9
 qevxJNg48pLvooxQJ+YpRwzUA+YxtjD8L1vtvyTzITfXnXbh6e6tPPYxDOeaTQ4HrbGep5P7rHi
 6FQA=
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

