Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E67C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 12:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2806C882B7;
	Mon, 24 Jun 2024 14:47:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zcA3hguC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9556988373; Mon, 24 Jun 2024 14:47:25 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AA4688137
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57ccd1111aeso5046920a12.0
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 05:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719233242; x=1719838042; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TrNS0WrO3zxbqdcRWPPIG2l/xj57+RHQEACow0lNkVQ=;
 b=zcA3hguCtOqZP7IAY6LSSYL8FPnbh1KKhrEbG3SuKdBASpojm8zl4clBeGfM/NBFFz
 10IPk8mRFOvvzzgnh/wug4prjbuYA+lstIvXifi2Hsjzb+aX89PPJ+TOdP3pRi6pM2xt
 VV7HqsD6m6bL1eJtMQfxoCSZbCWIVQVONYh78YB2pUtEde9UeNTzdu0DJjDOKOql2LIB
 TQVAbN75BlzqX/WwWGhdAHSZlXAWfmvxqyZpsbhb1OtIGyW7wjGDT+tmKL51HYBTMyBY
 59Hk28qM3TP0swAHKBiYoS19AOofGltNQJFs1OvycpMycECf5OWCnqX3lvHXECFOJ5Xf
 tuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719233242; x=1719838042;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TrNS0WrO3zxbqdcRWPPIG2l/xj57+RHQEACow0lNkVQ=;
 b=kiWcMcr34/UP+pnK0UQfsocT6JUgjiOeO32T+tFDRNjpDHw6S4Z/Ot9gybQNXyLQpU
 Z0kWaW2mEz9U0MyTZ2lv8LdnoU+l0QNOn6FsYJLUak+24SGimYkS15Sjo4AxFg7H+nZ+
 TZr48EPOGtnbWh89kKLf3E/jZ5CirHfiJJvMxYuhn1mtRA85vN6rMZsOWA71obl3nooL
 fAHSiVy1JKL4N06q3kcIswgbFTfoU6bloRrqH8vCuJvPhexmnYFkAPPJYzqGTARoCq8t
 ErVfJMbLoq3erO32q7icdg//jdE2AzYvkj0t7W1aeCv68R5hqCg/XRvZeYG3BqNhrx1A
 j5QA==
X-Gm-Message-State: AOJu0YyicyoiilY0nbC1Ic/aaMhy/zs1FQBTBXntiXIq5FNPSBuhZCz1
 3qapYIsAvH2SMvmrCeD7AtAkUCF+QxWmiCCPNors8eFtr6Ji4qHBTOmTHXbpayE=
X-Google-Smtp-Source: AGHT+IHOWoHI475Ye5bO+QjCW0EDDc//XvrhuW5fQvz3CLFI+Cb+Olcoxfygr1Xg9fadyV5witZ9jA==
X-Received: by 2002:a17:907:a4c7:b0:a6f:e529:adb5 with SMTP id
 a640c23a62f3a-a7242cda444mr347601366b.59.1719233242571; 
 Mon, 24 Jun 2024 05:47:22 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::52af])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fe0ec4fd4sm297669166b.200.2024.06.24.05.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 05:47:22 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	u-boot-qcom@groups.io
Subject: [PATCH v2] spmi: msm: demote to debug()
Date: Mon, 24 Jun 2024 14:46:27 +0200
Message-ID: <20240624124716.2610961-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.45.0
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

Most devices have buttons exposed via the PMIC, the button polling
therefore triggers a log spam if debug logging is enabled.

Demote these to debug() so that they aren't printed unless LOG_DEBUG is
defined explicitly for this file.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
Changes since v1:
- use debug() instead of just commenting out
- V1: https://lore.kernel.org/u-boot/20240607142229.50709-1-caleb.connolly@linaro.org
---
 drivers/spmi/spmi-msm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
index b0d6226041e5..a35cb0ba01e4 100644
--- a/drivers/spmi/spmi-msm.c
+++ b/drivers/spmi/spmi-msm.c
@@ -118,9 +118,9 @@ static int msm_spmi_write(struct udevice *dev, int usid, int pid, int off,
 		return -EPERM;
 
 	channel = priv->channel_map[usid][pid] & SPMI_CHANNEL_MASK;
 
-	dev_dbg(dev, "[%d:%d] %s: channel %d\n", usid, pid, __func__, channel);
+	debug("%s: [%d:%d] %s: channel %d\n", dev->name, usid, pid, __func__, channel);
 
 	switch (priv->arb_ver) {
 	case V1:
 		ch_offset = SPMI_CH_OFFSET(channel);
@@ -185,9 +185,9 @@ static int msm_spmi_read(struct udevice *dev, int usid, int pid, int off)
 		return -EIO;
 
 	channel = priv->channel_map[usid][pid] & SPMI_CHANNEL_MASK;
 
-	dev_dbg(dev, "[%d:%d] %s: channel %d\n", usid, pid, __func__, channel);
+	debug("%s: [%d:%d] %s: channel %d\n", dev->name, usid, pid, __func__, channel);
 
 	switch (priv->arb_ver) {
 	case V1:
 		ch_offset = SPMI_CH_OFFSET(channel);
-- 
2.45.0

