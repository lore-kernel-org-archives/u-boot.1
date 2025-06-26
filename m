Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1751C7EE32
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 13:26:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 514F082B34;
	Thu, 26 Jun 2025 15:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BBMbL8m+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9416880E9A; Thu, 26 Jun 2025 15:26:21 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA64B82C4C
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 15:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a54700a46eso521259f8f.1
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 06:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750944363; x=1751549163; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yIh/3CNdYDlFIFYyHnQQwKnIFwdo6D2LR+WpgUyluyE=;
 b=BBMbL8m+JaI/Wtsm7bhT7dEAZCC9liIYFMNUMCRtH1zYpzS/mqCF5+7V1JcTyDsn+N
 d7mt9qAgQ2/KfGgEsgEp4wRdWMkKf1Wp3JrWHcJwuEHlMpQiL+jEQfOPO1Nb2NAMkYBH
 FfGRHY+BDgew/F3f2T8DIyxSjo6jcvZftcr7orv1/wZRzOy33vS01neRfIC1ROar2l9L
 1kz0RaChvOogsBgD6gtErkscAmxX//GHlbpTz6hT2Px2/2EibFZdx/jjwEzLFyVKWsCC
 jZZKxMuc0WkgnRAbs7tutTOW+qhP7e05aC8qi3X2Akgm3LWr6FtU0MW/jJ2Oqs/M0sUE
 /HGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750944363; x=1751549163;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yIh/3CNdYDlFIFYyHnQQwKnIFwdo6D2LR+WpgUyluyE=;
 b=lOzPstOfDs2uSyGwK/O0qAyfosv3JDeQFwdl5lvJgkS6fGkldvID7QU1y850uXWQv7
 Lu6kZhLQNt4okp9RfTNHhagk+KkGXNnCciVBJR7u846ZIFA+9JS6aR+pw69OwJgjv7vm
 ZYKAKbBauTPX1F62aCXH07nl2b59zns5GYgCRz41ohLpcn+Ksr7DVq5fjqw89H7NSR2k
 BMW4H3IPHFJjUNFaT+ZPxAHR43uN3aRLOTNc/GnpT3Ow6Q/I04g1hhzJ14ELSlMpv55W
 6kuuhCWenjjkoUups1SvzffOnFK9Mg05KM9ivfmI0IW6kcj5Q9Xc3gdNkCgMUyo64eRg
 10Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeBaxPJIOKet/FP+HOkvLp2N20RCctCiLt1Iq1HcKoeSj232yrFT45yCXzLWqwG1GZtBPq8cg=@lists.denx.de
X-Gm-Message-State: AOJu0YwoTDwTPGuq7yS6/6D5NHHwkwk8CbY4RSauuz24A3qsTfACwjqZ
 bmXEsslzirCXE10nLWwP94l1yOVohpUI9GKtadkabX3qGwM4//mo9fYvzirVh69lQWNL5CQlCYG
 LWKoL
X-Gm-Gg: ASbGncsmTECN3aDMMw1avvg+AMZqcGdsyMi7dCO4osM1NtEZAfjxooTJMgMncWcZdO5
 sOGETzyyKD7izSeeIhImobE4EMZuG2fk2tqD77rJP80KIfahdb7va30TVQPe6jochYzwyY+LSeA
 bIxEFyVy+x1dJcQSWqo4TOxHkedBGihqErsxhk9m6Vzh6tr4xjiFzL5CIgQDKhhL/isXq9RPm2+
 RANz0sHKhiX2kDksiGEuW6FKrEmyI5HcbGX67vAkjJFzP01/COg4OyemZFsElikcwubO9YcrFVk
 DHQdWichEdqICr+XuVHbPLW7JVOqVB9J7TAQIMRxrmV11LdStbJdAObLFt38DW89KdOfCLzjIIa
 +NAeShdLUfyIys6iBcvtJn6SfE9Z+/zXnUw==
X-Google-Smtp-Source: AGHT+IHRcGU8kS7W9ZNm83ecMB7euOQGEelWG6ChLNLVKGYGOSlfaTRwz7nWp3bg9joSX2V8b+hfhg==
X-Received: by 2002:a05:6000:41c7:b0:3a5:2ec5:35ba with SMTP id
 ffacd0b85a97d-3a6ed65e7e0mr5318423f8f.30.1750944363232; 
 Thu, 26 Jun 2025 06:26:03 -0700 (PDT)
Received: from toyger.localdomain (p5b29ef66.dip0.t-ipconnect.de.
 [91.41.239.102]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453888886ddsm18224695e9.0.2025.06.26.06.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 06:26:02 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sam Day <me@samcday.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH] qcom_defconfig: enable USB mass storage gadget
Date: Thu, 26 Jun 2025 15:25:45 +0200
Message-ID: <20250626132550.353332-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.50.0
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

Enable the USB mass storage gadget to make it easy to access the
internal storage on the board.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 7a1f80265771..d7f18820297d 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -39,8 +39,9 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CAT=y
 CONFIG_CMD_BMP=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_RNG=y
-- 
2.50.0

