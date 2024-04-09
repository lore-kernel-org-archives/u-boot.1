Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FEFCD128A
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 18:04:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58B5888196;
	Tue,  9 Apr 2024 20:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I2MnXh24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E7FD87F01; Tue,  9 Apr 2024 20:03:17 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF94E880D6
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 20:03:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a51a1c8d931so546023166b.0
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 11:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712685795; x=1713290595; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R0pR7USvI+Ih/FdJ1dMA4BzTcYnSBcRZgZ9bLcEt9nA=;
 b=I2MnXh24vDVbLzOb9Drwnhcw/oUWbMrFQGRqZQSUxo1iNLRcx+OEai8k8EkgI1scjF
 85w1xgHSSAQUXUpFiD2DXG3BVC+YGO5FDFwpfGvwZopdT593dGlU90oqv8RqME2RZrSX
 GcuJ6xDXAW49ByQMjjnX3ai4dJt84L7UQCVv4K3MJt9kw32FWMJhW/sDcG80yfFzW2vY
 pxIjkwS2+Gg5cCNIB6QR/62soIgh+TW+T1ad28Lc9j34Sa2KNZ3Sysu3D+XWmqkTm006
 AUbUvRkqHREpZcKE4LLyVF/Io88s7GIoez7qDgSXlVMc/onnj3FduGdXuwW7vFuy50S3
 4DYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712685795; x=1713290595;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R0pR7USvI+Ih/FdJ1dMA4BzTcYnSBcRZgZ9bLcEt9nA=;
 b=j/Y0oPfmjbcZ6/lkTP0BgEgTCe8fE5MgynHHAMg3e6n1EOicO0xqktZQpSEBxy1CWV
 jsmbFdJ8xXH/TGl0iShLprkIienAPJjqh7aBzwu77uDMnsURxpUoxZKSQST6f79oNKP7
 +mociLG10egkJXdBzufFetPs3klM1meuKNXKFad8L5Yf8jYymN3O0bdIJNHAdpAVrXaz
 dhtNP3ZSOzUDuYxfs40q0APVnMPBZeKSnRbG2XDBLkeRjVQKM+FB380CJK4y/AI5YhFK
 W6Qfk+KouxzYFlXkf9FrEyvuxZGcN5Er2O+6OQmO98kPLF9l+xA4Tl3mA22/WsV9x+Zc
 OPJQ==
X-Gm-Message-State: AOJu0YzrSzF/hW7HWX4cbivH+GDAEbTWKgE+93P2r61P7geuniLuHRI0
 Jr/95Sucl/U7OdK8ys037sdZnviT/AeXr5pMq0oFCxyi9cEtY6aobMwjR3F4SBQ=
X-Google-Smtp-Source: AGHT+IFivJsQC90EJjqy8hFHPRxm5R8NznND09OtYTIy5FM+sDwhDTFxE3Yujfnng3919KiIeyg6sA==
X-Received: by 2002:a17:906:3492:b0:a51:b931:59c2 with SMTP id
 g18-20020a170906349200b00a51b93159c2mr146451ejb.73.1712685795284; 
 Tue, 09 Apr 2024 11:03:15 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a170907272400b00a4e5866448bsm5928783ejl.155.2024.04.09.11.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 11:03:14 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Apr 2024 20:03:05 +0200
Subject: [PATCH 6/7] pinctrl: qcom: sdm845: add special pin names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-b4-qcom-mmc-fixes-v1-6-5039164ecbf7@linaro.org>
References: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
In-Reply-To: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=kvJA2hpDrvXL5Le9dVlPd02xqhweuffSPTKkrxeYBNo=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmFYLY2jKbBZWPPDKbWgwMi5egMc6k4+UAoMEDM
 LiuclyMnQOJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhWC2AAKCRAFgzErGV9k
 ts/VD/wIVwIsYAsl4ZJEe+Wl3x9b/5kKfmPqgbHLcaV4V9BL4VcA+JQmnkbpb6PKIdHIIFDI5Gg
 iIGxITozvsLJREZplFmmIRKe9rq02M3UW0sML9ST0IuLv2gmu/pXboYaG/LdjeqWsHs1bIxdFr8
 /5cG8VJfrSqyPp8BqgeyALcxD8E/m4Qg8tcX3Gpo7sUjSPmXG9eUSx8IQP3J+roGGEahUcn/ErP
 3URw8mDuBGZHBxVdS3M7Xotk2V36XANcPDokRBBa47tn9EQdFX9W02KHqogPRYjKRtpF4t/Xp1d
 P8To2o1uRveyEVmI7jaDFnkPmvk58HstsVq5wuvRGz6lufeG1hhas7OmwnpRDxzUcqz5DdtS8ww
 IwKJnol1PRVxuKf3dZDw4zUjC5vcahhC7hNCL195pZlS/fMxJ4lJ6VI9HvNbPPgU94EbV3Mq1+h
 +QsrTBGea5tDtH1n732Pt0L1jQujpChoPkTddj6NdwkG27rYeoASMsqOFzWXuMRrwDStxbX10Tn
 5GEgqMDWstjMET5Utz5lbaVdVa3KNHFVvXtzPPZ33IKsDOCC9UcxcrfPSQDTOqhp1WEsNxQ4I7f
 AgokHlQIMKvMZcRqXaDQ4djfpoeBw9OQDyk/1Qju/WPQpxgPxJKjACU/mTAElU+VwbJdKYLskcI
 5Avbzl5cYrkhEmw==
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

Adjust sdm845_get_pin_name() to return the correct names for the special
pins. This fixes a non-fatal -ENOSYS error when probing MMC.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-sdm845.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
index 459a4329ec80..c1e5cc01fded 100644
--- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
+++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
@@ -65,9 +65,20 @@ static const char *sdm845_get_function_name(struct udevice *dev,
 
 static const char *sdm845_get_pin_name(struct udevice *dev,
 					unsigned int selector)
 {
-	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+	static const char *special_pins_names[] = {
+		"ufs_reset",
+		"sdc2_clk",
+		"sdc2_cmd",
+		"sdc2_data",
+	};
+
+	if (selector >= 150 && selector <= 154)
+		snprintf(pin_name, MAX_PIN_NAME_LEN, special_pins_names[selector - 150]);
+	else
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
 	return pin_name;
 }
 
 static unsigned int sdm845_get_function_mux(__maybe_unused unsigned int pin,

-- 
2.44.0

