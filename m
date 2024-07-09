Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BEEC2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 09:38:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E391A886CF;
	Tue,  9 Jul 2024 11:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CUtUk8+Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 115FC88664; Tue,  9 Jul 2024 11:35:12 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BE4C885F6
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 11:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a77e5929033so351156166b.0
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 02:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720517708; x=1721122508; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nIIvJbrAbNJRYWo+J18YgLbk7RXm9zDJv7nP2Beyq5g=;
 b=CUtUk8+ZBc2LvvQi2RwmLtMsLqpX3iA9VFkO2eliIqDaGusHn0+buvPn8esxj9XXVG
 dIp+Oh2Vke3jPDsXdoEI+ep58pOEfeynljT/1ECuMdzfad9Y03LN9oROvl5dDAN7N+zc
 5z6JdXRjg190HQeIgvO1QP7TcGLG5nU/NtmTsN5V7rDRe3RpWCk4EVf78JR436DQAHcR
 4cWcj58mMh7qWQdRVlPMhUjKWgQymeOCpLov6BibogPt1hKbYA0QbC9quKqnyVjdMoAx
 HNZ4oz5WLxd4dUBhcgoKcHG45VZw6HjV2/l0F2FNd6daKx2bdYzhy5rPwtNYlH8I9Iuo
 rydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720517708; x=1721122508;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nIIvJbrAbNJRYWo+J18YgLbk7RXm9zDJv7nP2Beyq5g=;
 b=MgEWMs3UmLZSMGgHL4U990bNjGzSbC1xrEFOBwAuehBBdSJYGU311NGUfJICwLCp9r
 8BqSiYFDg12wJhUB1ZuLev7iaKoveTFYAeI8AW5UJHjLqNpoJMCV2u1828zqi9pnvP6B
 8QkYYb/IrUaveBeOl9BGDgjkpdiLtMFcchEpGdUCBwR3ERDgpodm0G//v3nJff03PeqV
 JLnFPRO80DT4bObobm1TaM5WNkgsMV6qOdU6B5+OfJC/U3NSMqsUWWd14UYKJoDlOeK2
 K1zqJHADEmBgZZ0Rl07QJgZ3V8jVPVOTvP5c+HLfX2SRepjQWrIavixArlDoumWYMpJ8
 wzQA==
X-Gm-Message-State: AOJu0YzhFK9WqZzwXEuJ6zs7wRI8K+k6a2p00CxDErKhvJ0DtUe6YjX9
 v0BAuAOhpKSHg98XnSAzoetqwQuq152wZBTUUXMnnXBX9QTZ3rVKWz2vQzD7gH4=
X-Google-Smtp-Source: AGHT+IFTi5pWbbjrZMyfmCyv0BR4zfloBzv4cRYGDt4cMkaHZiSGtYsxWPqpLu72m6elY2XTDinPEA==
X-Received: by 2002:a17:906:c207:b0:a77:eb34:3b44 with SMTP id
 a640c23a62f3a-a780b6b1bc5mr117015266b.30.1720517708083; 
 Tue, 09 Jul 2024 02:35:08 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7fefaasm62884566b.140.2024.07.09.02.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 02:35:07 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Jul 2024 11:34:49 +0200
Subject: [PATCH v4 21/21] qcom_defconfig: enable rpmh regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-b4-qcom-rpmh-v4-21-c06d0a26644a@linaro.org>
References: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
In-Reply-To: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=gRFw9sllDNNt4nSyWXUL+01p1obRypQjKFtWQBwneRw=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmjQQ1Ni2XqOMwqVuW9CoIIcBXzgvNKiEJa+OWx
 AvXwDawCF2JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZo0ENQAKCRAFgzErGV9k
 tqt7D/9tTrf0NipV1VXVBcagSIbgr+ko4fWSVSlXMR9o3Eo3fD5IkFnILH8VLUmTxmvUnAd/xUX
 L4P9+9OwUrtk0+E1cL9QhhnelAsWxMcENtmL7+6E5FnWxI0rNtD16a6DGJaiZTUqBb20nNdwj4f
 bDAZIDTCQZsy01n5wviR5VFrDPTb9AjG5qJQRTuPGk6d2iHjq1bCCUJZzmXVmjsGC806uRwA6LJ
 HoLZ0D6H6mr3xIrPdLRz0CxJHeP+ipEVSVqaaSRAMXvkfmV2N/V3gfJHe2Qkv2s/5FLMoPg9scN
 SAbRT40LuKmFqFugoTQxYbJL0/p6SUoBsqC21T/HCIS4+RBVjSZ6EAWbTIQT6a/DudgyvygKDMI
 RGP2TJakBrLiKYuRv3v5JaSRTI0IupWEE2JFlRaCwTc5ctlNn2+lNQroamyjSoIUsu4o3/QtRIA
 jD16GAES/DC1Ylg+ppSUbgGyo+rj32vNa84LTvO2FopSq3l6LH/YSi1OLrUv15IiB+CXinseFsA
 2nkypxls7Gw4YQOI/qPVVfiyg0OUFpMa1RNwJspubecwz5xkoYioNrO7tvOZgaXEh7LAyYFRtes
 Th1MRitMmgZoKsU9KIR54d2F6eIB0qTfT3ayHiYacfSdBNAVTV2QBTf70qn7Zjklvk/yrlLQrft
 /B7btq4VSP1pgaQ==
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 60a8e38cc6bb..8a55bb9af708 100644
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

