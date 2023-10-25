Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A137C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 05:15:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E96BB87A02;
	Wed, 25 Oct 2023 07:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fmRRCHwd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22082879DF; Wed, 25 Oct 2023 07:15:00 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFD63879DF
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 07:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-27d797f349fso1206211a91.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 22:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698210896; x=1698815696; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SUMAbMzHoHPTo3By3XoRLcFc4qPp57JA/75ABBehsIw=;
 b=fmRRCHwd7lElgJoIZx5DKxN3p557VwtHNUx7MI/vb/0yafvLW11RJipy/c8hDZkTNZ
 BJRY5GSgzCvygREsZfE4ERxsFL0BevRHAmTNy3l+eM5NPgbAjri2a/ZrYjVwlOIsp7Zb
 mFDaU6dDhh0ly9RBOELgDvkhXxQUm2P2qtyMxYQGcUDvsUkg/uEVZSgCTZTsT0tSAkQo
 /WlgewZG7RW0Tt+T23qs9G2l/CC9eA4nk3YlF+MBgtJfN0IovsXPDxXqdZfRuYx5r9wa
 ra/ARNBrvpC2gTJ68Fl3PpOp3ts1uZ7U/9aK8gGMeOYtzANz0JCdR9Y0JPkh3x+F/qAw
 kK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698210896; x=1698815696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SUMAbMzHoHPTo3By3XoRLcFc4qPp57JA/75ABBehsIw=;
 b=E8AqdtmwbyCowsVfP6jaMKVt452oJBjlfsShy/xKY3VUBR8ocgRSaPGxZwwYaoux6H
 4WExY0u3VLJhYlT0WcVh+UdSf8oPisB7Xg9aiq/8S3SIyuZ7Ekq63xI/NMOvvBdk9m6W
 s5VTrWA/1/qq7/eWVW9GzslQ7oycGYAl7fNVIx/L9ChArUnkHPWrTZFh3dusziFuZoc3
 zSBVTuA8iY91NB9+WYmLD7ezjqhY7lsrBUxH4lO2e0uhDnZYWu4oao0UC8ZKmTN4Go4O
 yf6DoY7WBisFbMW5Z3L8lmjliBunf2Qzx4dtX4MLQR8CBdF8GKnMNuOWn7BW8cz8t3FJ
 k2gw==
X-Gm-Message-State: AOJu0YzritbGG0yws7Hx4a51lY5hjoXtnt6ZVLKVpVhe9xPEdcLXfdJo
 pi5HtSApxbkOBE30JSO9bPFdaQ==
X-Google-Smtp-Source: AGHT+IG5TDl1b2dAOeAUytz4K+QRx1K5SYwH8/mdfDYYMwq86auCbNPvoSK2thLHYiB9ATQ/Ui1Cuw==
X-Received: by 2002:a05:6a21:9998:b0:15c:b7bb:2bd9 with SMTP id
 ve24-20020a056a21999800b0015cb7bb2bd9mr16042722pzb.6.1698210896127; 
 Tue, 24 Oct 2023 22:14:56 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:65fc:df7c:6edb:619f])
 by smtp.gmail.com with ESMTPSA id
 fz3-20020a17090b024300b002609cadc56esm7715815pjb.11.2023.10.24.22.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 22:14:55 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, michal.simek@amd.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 1/5] test: dm: skip scmi tests against disabled protocols
Date: Wed, 25 Oct 2023 14:14:23 +0900
Message-Id: <20231025051427.509602-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025051427.509602-1-takahiro.akashi@linaro.org>
References: <20231025051427.509602-1-takahiro.akashi@linaro.org>
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

This is a precautious change to make scmi tests workable whether or not
a specific protocol be enabled.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 test/dm/scmi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/test/dm/scmi.c b/test/dm/scmi.c
index da45314f2e4c..2f63f2da16fb 100644
--- a/test/dm/scmi.c
+++ b/test/dm/scmi.c
@@ -217,6 +217,9 @@ static int dm_test_scmi_power_domains(struct unit_test_state *uts)
 	u8 *name;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_SCMI_POWER_DOMAIN))
+		return 0;
+
 	/* preparation */
 	ut_assertok(load_sandbox_scmi_test_devices(uts, &agent, &dev));
 	ut_assertnonnull(agent);
@@ -317,6 +320,9 @@ static int dm_test_scmi_clocks(struct unit_test_state *uts)
 	int ret_dev;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_CLK_SCMI))
+		return 0;
+
 	ret = load_sandbox_scmi_test_devices(uts, &agent, &dev);
 	if (ret)
 		return ret;
@@ -382,6 +388,9 @@ static int dm_test_scmi_resets(struct unit_test_state *uts)
 	struct udevice *agent_dev, *reset_dev, *dev = NULL;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_RESET_SCMI))
+		return 0;
+
 	ret = load_sandbox_scmi_test_devices(uts, &agent, &dev);
 	if (ret)
 		return ret;
@@ -418,6 +427,9 @@ static int dm_test_scmi_voltage_domains(struct unit_test_state *uts)
 	struct udevice *dev;
 	struct udevice *regul0_dev;
 
+	if (!IS_ENABLED(CONFIG_DM_REGULATOR_SCMI))
+		return 0;
+
 	ut_assertok(load_sandbox_scmi_test_devices(uts, &agent, &dev));
 
 	scmi_devices = sandbox_scmi_devices_ctx(dev);
-- 
2.34.1

