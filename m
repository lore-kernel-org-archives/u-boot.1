Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77291C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:12:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9665C888B3;
	Mon, 15 Jul 2024 12:09:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J1yMZI1x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2884188897; Mon, 15 Jul 2024 12:08:59 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D52288840
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a77c4309fc8so525902766b.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038137; x=1721642937; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9fS17EJfpRajXdHZM+aigrI8s0lABvMSNi6Hs5iNv8s=;
 b=J1yMZI1x0HS9XfHP3SstVBP4fAjJbXa6XyexMX8EOT6jv1VT3Qkw7LCq4pABDFkP4i
 dUcGzm17GFQp44TCrygXFfo/MqGwU3mpQhoSp+Zkcjq/7XduvopvZK66BmIXPE8ZYoHK
 sljzSSsSYTuW8Wtl5Z1FqK03jtXTeJeW+SbsevYBQdB0BRZbYr+xX3njXo1FycNxQ13Z
 49xMUilYgdHCM8WlPLlAc5tpdPeOuuaZoNUsLUoL8diPaVr7gRQEkjnlBwqXaWrk9sXu
 EjbUtTgxPHkWDOPP+DH/r8oTjiYvtDPSpRCmIdimo6u3w6aYzBjQ5IgctQ5TW5GGh0Ed
 8/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038137; x=1721642937;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9fS17EJfpRajXdHZM+aigrI8s0lABvMSNi6Hs5iNv8s=;
 b=pP9LL9N4yQMNoH6jesfrhUTEZn1EbrNUQw9ncO6DKrVIM0Wks/+IeT8ei0YBpfyqGZ
 OKFovK/AXep6vo2EHTW8SuI7JNNqZGTNknCV4Esi8jA2i/GqW2AVYDKxJ/cwhSoOaw2+
 0X5/aLzFgLNS9cXWgWDyx/dBIR10H96rG5e98TRrPCTCaBIziMvNF/hCWUtI3p78rcc0
 G1+DbIKP4hu4eEHHyKiIExK6T7qoG83ikZBQMwKq6xVMMR7Te6na7kk/Sp6BWdSCWBop
 Ik9kTFCvY0Dp2SI83NnnrcJLyf24Fi3WMsv6Je9TGautzN0mBxhbQS9eC057/NuOvAh6
 GLPg==
X-Gm-Message-State: AOJu0YyRYLC9eqfOTXJslV465bQijFHC59iEVQ9HrBrNNG/AX/a5sxDC
 oU5BNXHFMTv6Qfe5Zqt+3Iq/YgmPv857UKGksa3vZi0s9/HkAoTEsC0faxurdwM=
X-Google-Smtp-Source: AGHT+IHpgmgTrPLjvR1DSnzYNuwJ8r8og0zXkMv7PwRB2/xCJjNqudkcT3ZqMNSuJhPIuIOxhX/mQQ==
X-Received: by 2002:a17:906:8c3:b0:a74:e717:4259 with SMTP id
 a640c23a62f3a-a780b704f06mr1094240866b.41.1721038136787; 
 Mon, 15 Jul 2024 03:08:56 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7eb4sm198102266b.60.2024.07.15.03.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:08:56 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Jul 2024 12:08:23 +0200
Subject: [PATCH v6 24/24] qcom_defconfig: enable rpmh regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-qcom-rpmh-v6-24-0c948a25d018@linaro.org>
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
In-Reply-To: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1068;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=L0Z3UjALgAoIr8Xjx+Xnl++TWCG7gLgrnDFM/1FfGKY=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmlPUIakXZaY5tkFwRidvYEkF1JjwE5+/k3Cf0j
 cgICpHtJ9iJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpT1CAAKCRAFgzErGV9k
 tro5EACi+BQKT6M5zFel4Ze8ksflYfzcHUl5Itu4nbCb8PF6MFTQ1Y5olEA9K5VCUvOTKdjZWr4
 5qmZHJ08DCKkV/mteSKqF1TCWVtc+E8a9a2afLHMyqG58/QIkR1ePYyGyN3pPiHR2SK3STMDsWo
 65SaMzcRCeG7jqgT+BWegiBi38TjvZ0nh82a9Wc7FbvvydnR6YpCxECTx1Xcdm0cfdTMKIAzSi2
 JHl+DqIgsajEhmjOGOko3sxhAnPnfBPWNqHE/0z6hXxqRwpgfNyqVHUifGeBAElwr+4q7muboH3
 nY7HXtYGS5VBiBJ3u+Uh6s7KXi9CcvipTWAa6+H4xGGZQiFjL+Kwpy29nO4Vm64n/ssm1u9R2kC
 S11N9ObgSMvQlFOulnaofrB6sFekj1SOVzeRFfBH0t6D4cxhLRTl1B4doq+jjRkqmtImteoHRpm
 Vnmap8Lyy0FDUDrFvHFZvHuD07vY34TxaRKrWvj5fCr3rHpVk+JVFiTt3PQOilepfTXJqo1AGe+
 5MKeam3Lp43gTump2OKkHdPZp/fkAcITk9rp7MFqHrPACRuFoQx29Mr0R7KMsunWirrsyODNbRR
 kXpLgQMYqISJGS4tUO/56zY5WHfg0vIlg9P/0GOpwWBZVgtxGf0TmmMFnbjOMVVrv1ZdQFpdB/v
 dy11tyhwRaaf87Q==
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

Enable RPMh, cmd-db, and RPMh regulators. Additionally enable
CMD_REGULATOR for debugging.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index ac5ffe772ade..1cbad9db72eb 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -35,8 +35,9 @@ CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CAT=y
 CONFIG_CMD_BMP=y
 CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
@@ -90,11 +91,15 @@ CONFIG_PINCTRL_QCOM_SM8650=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_QCOM_RPMH=y
 CONFIG_SCSI=y
 CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y
+CONFIG_SOC_QCOM=y
+CONFIG_QCOM_COMMAND_DB=y
+CONFIG_QCOM_RPMH=y
 CONFIG_SPMI_MSM=y
 CONFIG_SYSINFO=y
 CONFIG_SYSINFO_SMBIOS=y
 CONFIG_USB=y

-- 
2.45.2

