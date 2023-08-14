Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40161C001B0
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 21:58:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9F71869C5;
	Mon, 14 Aug 2023 23:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CPPnzKUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2438B869E2; Mon, 14 Aug 2023 23:56:31 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AF1A869D5
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 23:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bdf7086ae5so2635335ad.0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 14:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692050180; x=1692654980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m0gfmQRkqQENplE5JW0mNeBMe4WYfz66h5n3v37UEyk=;
 b=CPPnzKUSp/4Y1pFkiQ1ZAraSAFXXtJzQroPmOSNTPcuDhNbZ+qiN7DnlQ6yUN5Hv/0
 jBX7LUG8oeRNIV+lpGA4IxxcMKDyyAApwDYq2GBk178AgbfvnCgDoXA1WM+aneZQwtB/
 43If1II+xs3Q65h8zW33liWqAatj7el8H88lbNv9odC9TFLnJhzNL6+RcZzr8QPKlLsh
 7j39nzyH6mYKbe+L7ncIyUSPZiHIt3I2bh5wQBNZovmenLynCjSFUZhXqMmIitB10ryI
 9zovMOqF37q5jCBh65351MO/CBln/CPHMZ/ymRJOncPK98zacrCktJGiFfFdQ/TzTPUU
 MqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692050180; x=1692654980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m0gfmQRkqQENplE5JW0mNeBMe4WYfz66h5n3v37UEyk=;
 b=ehCsW1WBcvGbek8eY9YWcX62PKA230K+N41njtYAsZALEZd5iJnsMwnhY8Ab+6j0JD
 D53HWmDLX3DfVg5eDAX/9QnogFJtg0/SfJgW3ZNVyBxORzr6Kjt+whnj938iBCKu5j5m
 xOtLLwg2P5nl9SdF/JWwbKvjeIOg5Il/V3aVx7uMcw55uMRQSLk52EwWLtez+yPVjbPe
 Q2b2pnMbeBSncAZ5MM+Nb8OvzlK2nZ1DK8QJFK/9r0+4HKQXqXERCgig97FsxaC3xtxP
 VmbeAj87WbFdDgRZQHsyadmyKYz8G/y5rpBHrUQSM3LGYo1NOkoKYhB1MpTLwJBBdxNZ
 2bgg==
X-Gm-Message-State: AOJu0Yz8w42kFrAPSQc6H+X0L0Qf/JOettRdm8VcMhlER+yjc0TXT7IA
 PZe8vLknfUDwaXI8wIhUVoTcg0h4gU/uvhr3ItY=
X-Google-Smtp-Source: AGHT+IFXIQt3E6ihmiKlDt79tUImQ6/Z/zS73fOHQVIfPfDjpOZz788DGKxD7yUZQ43GajhVroeIVw==
X-Received: by 2002:a17:902:d2d0:b0:1b8:83a3:7db6 with SMTP id
 n16-20020a170902d2d000b001b883a37db6mr14080432plc.44.1692050180151; 
 Mon, 14 Aug 2023 14:56:20 -0700 (PDT)
Received: from localhost.localdomain
 ([2401:4900:1f3b:3924:6581:8508:2ecb:b5dd])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170903110400b001bba373919bsm9872075plh.261.2023.08.14.14.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 14:56:19 -0700 (PDT)
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.sharma@linaro.org,
 bhupesh.linux@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@linaro.org, rfried.dev@gmail.com, patrice.chotard@foss.st.com,
 jbx6244@gmail.com, kever.yang@rock-chips.com, eugen.hristev@collabora.com
Subject: [PATCH 16/17] configs/dragonboard845c_defconfig: Enable UFS + SCSI
 related configs
Date: Tue, 15 Aug 2023 03:24:56 +0530
Message-Id: <20230814215457.4075025-17-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
References: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
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

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 configs/dragonboard845c_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/configs/dragonboard845c_defconfig b/configs/dragonboard845c_defconfig
index e2676a37b5..0dd5ce6159 100644
--- a/configs/dragonboard845c_defconfig
+++ b/configs/dragonboard845c_defconfig
@@ -18,13 +18,23 @@ CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_CBSIZE=512
 CONFIG_CMD_GPIO=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_UFS=y
+CONFIG_DOS_PARTITION=y
+CONFIG_EFI_PARTITION=y
 # CONFIG_NET is not set
 CONFIG_CLK=y
 CONFIG_MSM_GPIO=y
 CONFIG_QCOM_PMIC_GPIO=y
+CONFIG_PHY=y
+CONFIG_PHY_QCOM_QMP_UFS=y
 CONFIG_PINCTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
+CONFIG_SCSI=y
+CONFIG_DM_SCSI=y
 CONFIG_MSM_GENI_SERIAL=y
 CONFIG_SPMI_MSM=y
+CONFIG_UFS=y
+CONFIG_QCOM_UFS=y
 CONFIG_LMB_MAX_REGIONS=64
-- 
2.38.1

