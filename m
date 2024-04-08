Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8748ECD128A
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 13:08:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63D058811D;
	Mon,  8 Apr 2024 15:08:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gx6YRkSs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 998E28811C; Mon,  8 Apr 2024 15:08:12 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C55C187A80
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 15:08:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56e136cbcecso6002723a12.3
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 06:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712581690; x=1713186490; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mV4VyN0YmkTsIiuWVCwOOeVRvkCnX1jRxymwdbxZogc=;
 b=Gx6YRkSsHsDUdpKVoFJorC7Pd49IkUw8a+/RR+yEEp5xbVjTdfd182e6gH0zI3ftLU
 jayZP7XLYOfJejA4HUUqyNBPwHJzYW3OMRyAPNnu4ERmae7MN6OriEzlErszEFcmhRdc
 KUKPMx+8wAAMfZyTB3gCYJIvQD5X4xp/G/NLl9tK1VcLqLn68nJeLd34qpNNjWq7lNP/
 oEIqIkAUne6IGLT/ZoEkhNfkPjNWkjkLsT7FLNiKByyvszjFjG0vs0237UF498GpkxKS
 Ndu2+aP4rc3K/Slb3FHkb+S08siZwaD3Wp+CRbAD2iWEHRPgqAYqzcVy1HKT37/iihQ7
 w23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712581690; x=1713186490;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mV4VyN0YmkTsIiuWVCwOOeVRvkCnX1jRxymwdbxZogc=;
 b=TJUhjw5EUzlc28P0K6Y2KoCQxP/glu0TT1jqGfl7zTPjLbQaYiTKKjYN+/imBOmCLU
 XXjNuXKudxpGT8P7Tn9dzhbQzAX4A1fQTGpsPEb8ms00ErYpY7DFtvJgJ+7iFh9pLC7W
 WUEC5vLFO9iok9Syk1CCDhSGp6bAh8xjrz6Nsa6GrfKOZNAt97Y1lvVAVCZonxoHw5X9
 bUswn5rILtOpGpWORmj8PAGMEv+Lo37wx7dBWy4DNi/oukmVMoYzf9Oy08nuFLQt+t0W
 Br3A7xjHoiN8eXmyHRh3BbC0s/hHSttw45HbEqLM+hu70MV/kA+FuVLH5qYJy7b1p5K2
 0MWQ==
X-Gm-Message-State: AOJu0YziVNxDgukhT/S1HFqbodenpOpzcvB9IHZDTv0qNhoNF/IseReG
 fkZPlbAefkgljgTqXSH12DVNVlxVuN2ZS8PLgjiosYsLYFVU301wTs2rm+0OS1SArSiSh/h70Y4
 9H8Y=
X-Google-Smtp-Source: AGHT+IEm7cSo68fo+gX9equHXfMiRvcZoB8m+Z43jhAOIRNOlu9JuwHkYsDdZa3tEST5CzAfpBT8EQ==
X-Received: by 2002:a17:906:f584:b0:a51:dd18:bd21 with SMTP id
 cm4-20020a170906f58400b00a51dd18bd21mr1463734ejd.16.1712581689017; 
 Mon, 08 Apr 2024 06:08:09 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a170906844b00b00a4e23486a5dsm4394815ejy.20.2024.04.08.06.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 06:08:08 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 08 Apr 2024 15:07:42 +0200
Subject: [PATCH 4/4] qcom_defconfig: enable pinctrl for new
 qcm2290/sm6115/sm8250
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-b4-qcom-rbx-soc-v1-4-900db37b8bdf@linaro.org>
References: <20240408-b4-qcom-rbx-soc-v1-0-900db37b8bdf@linaro.org>
In-Reply-To: <20240408-b4-qcom-rbx-soc-v1-0-900db37b8bdf@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=768;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=nt/kdXq58BK/SmtljSbyBJYK8Pqm5tkbT9Y/WjWgtfk=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmE+w0nEqeA/rq9aXZmFaOXJNyLRHfuBqOd3siA
 B3wxdSeHqKJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhPsNAAKCRAFgzErGV9k
 tsTED/90nl1/UV8KON5wwBXaJOjyJ501RLAjgGQARmha65LTCYdIH694D7wdzwCZy+Zh8TV0K6L
 5zgBZ32ovXXmYI3/Zc8eHWuos1OEdMd34hd7/U1KWPbV0AAATDI2rz6uqUAazFfaA1OycueP6Lb
 g1RKSyYD1XqqOk1TQ274TH8FAyhdHMAO+oqQ87j0BQIljaMkrEowXzVMZojeNfQ6FGLxqXFFRAA
 joCBYnpclYk7nSg59tBRxZmjpPNykwX0ymy925+tqrGIkEgskPx4R9j3ZFEIzDGdAZU8ydyIbPp
 mj4cR1a3OopH8Q6dMVkYMJftDSNri6pLakms2qGq0NKCdpOzV/wHxxmVQYghj2YL6k36VlH7el+
 SH41DQuKy7nf05XARkvizPZr809W+ux3ZFdzLO9WjtNIgMqEOC0JmOWh+SzF8CU553QdEGXuHeD
 U90h0aZ4yDU1hK+G10RkKdZlkGVjEMQlJL4rkhAtSPPgGUP1zjmdO73nMjdw0dmL9TPKs0U2+ju
 qFs426SYoCB9oawLvyNOFKDKtXugHzgn3xInzCYjE0d+yufeci9urzCfcIoFcpCLRDG2+k6TrLT
 /L5cCJGIGkocWn5Oe1ZpOB0PJtalRHHYfAeUC/A5jHS05z4TlB6+2dsJDBDrmWixUC3+Ns1LRx7
 0sBJsAKBEPJKWDw==
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

Enable the clock and pinctrl drivers for qcm2290, sm6115, and sm8250.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index ae9c5b2461d4..592ffceb2077 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -67,10 +67,13 @@ CONFIG_RGMII=y
 CONFIG_PHY=y
 CONFIG_PHY_QCOM_QUSB2=y
 CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
 CONFIG_PINCTRL=y
+CONFIG_PINCTRL_QCOM_QCM2290=y
 CONFIG_PINCTRL_QCOM_QCS404=y
 CONFIG_PINCTRL_QCOM_SDM845=y
+CONFIG_PINCTRL_QCOM_SM6115=y
+CONFIG_PINCTRL_QCOM_SM8250=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y

-- 
2.44.0

