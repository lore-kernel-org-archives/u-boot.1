Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F2DC47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 12:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D64587BDD;
	Wed, 31 Jan 2024 13:49:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="bFZiQ4F3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99031876EA; Wed, 31 Jan 2024 13:49:32 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B603487BC4
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 13:49:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33ae3be1c37so532583f8f.0
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 04:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1706705369; x=1707310169; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9ewp29h7S15WTg0Ww4Pwq0FHhbhWAA5B3F29UviF9/U=;
 b=bFZiQ4F39bfeh/3x+5cy7VYvrdRiwBhFQRWKnLlGgARY++Da5UM+29L3kSzKczAmgj
 lj2JNe5NuWbTaZZVhj+vFm9vY+RiTLi2FjhEOuciI3uPWP5mtEdKprXr9duhwYXpkLLU
 EZE9vGfwa6G2S5aBy+ULHgSgk8mfx3wL0oD+37FhMy9Od1E4p5w2dil+mCziJOWg1UpK
 bQc+SM1mGGt/7HsDA8SiKkLWAbfyYNGtv7u7HLKv1zaT4k/xxRlHDuY31U4ReEGxfT2H
 IqePD1tK/AltnV74gZcqNNDfu+C87X7fD9cJ/tX0Z3JbK1UnYNQeHHpiL7D85OvTgNF1
 chSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706705369; x=1707310169;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ewp29h7S15WTg0Ww4Pwq0FHhbhWAA5B3F29UviF9/U=;
 b=e4ewlZ9lGfU7jzyi5LXSsTxzBfXxfhA06vL4d49Nfz6QM2YLTcFfy8ca0Aux+ANkp8
 5MQy1/U5p818TYwBFA4OXd+pEAv4BGb6KkClWRdCcOdTPU+6+Ik+tK727aezMiJvQiXN
 WpHiBFEYNDcuXWNL8FIOZkkmiBNFDHF8TBmd7IjKWaC9F73Q3NPH0jS81vXlDNdoWkZ9
 qQcyg5JqNuZD+EuOqUEWDQi4EvepFRdmfOO3nRKT2idD1U6OnceldxDiB43Imrrb+aXp
 WjTyOVvJH9gN4qMAMC7CX7YcDf0UBB8ad3d+hGTj2Jhx8J8T1cc40mk65DkAF2964AKK
 26nw==
X-Gm-Message-State: AOJu0YyozkOJrpYfIjESmoj1e8l9nmrnhpNvlQu9JJEzjXYIjo6/jfFY
 SaCwjyLxTH+5PVoTYrYlbmdWulyLfbGxG31AnQgvk15xDnY29ZraerqFM7PyDRyxLq5qNSbDV34
 w/Bg=
X-Google-Smtp-Source: AGHT+IHoGlXmKd3jfuKuz1plpfAbUfTBR1fDm42lyfnqKxFz2zVa0aGko0sfU1lCo8E2f9+eRmFzUw==
X-Received: by 2002:a5d:64c3:0:b0:337:aa92:74cb with SMTP id
 f3-20020a5d64c3000000b00337aa9274cbmr2040157wri.0.1706705369505; 
 Wed, 31 Jan 2024 04:49:29 -0800 (PST)
Received: from localhost ([109.108.76.111]) by smtp.gmail.com with ESMTPSA id
 cl3-20020a5d5f03000000b0033afd49cac7sm3618650wrb.43.2024.01.31.04.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 04:49:28 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH v1 1/2] imx: scu_api: add implementation of sc_pm_reset_reason
Date: Wed, 31 Jan 2024 13:49:25 +0100
Message-Id: <20240131124926.222556-1-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
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

Add implementation of sc_pm_reset_reason() call for obtaining
reset reason.

Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
---

 drivers/misc/imx8/scu_api.c    | 22 ++++++++++++++++++++++
 include/firmware/imx/sci/sci.h |  6 ++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/misc/imx8/scu_api.c b/drivers/misc/imx8/scu_api.c
index 3e3002ba6df..6e2c678e614 100644
--- a/drivers/misc/imx8/scu_api.c
+++ b/drivers/misc/imx8/scu_api.c
@@ -882,6 +882,28 @@ void sc_pm_reboot(sc_ipc_t ipc, sc_pm_reset_type_t type)
 	misc_call(dev, SC_TRUE, &msg, size, &msg, size);
 }
 
+int sc_pm_reset_reason(sc_ipc_t ipc, sc_pm_reset_reason_t *reason)
+{
+	struct udevice *dev = gd->arch.scu_dev;
+	struct sc_rpc_msg_s msg;
+	int size = sizeof(struct sc_rpc_msg_s);
+	int ret;
+
+	RPC_VER(&msg) = SC_RPC_VERSION;
+	RPC_SVC(&msg) = (u8)SC_RPC_SVC_PM;
+	RPC_FUNC(&msg) = (u8)PM_FUNC_RESET_REASON;
+	RPC_SIZE(&msg) = 1U;
+
+	ret = misc_call(dev, SC_FALSE, &msg, size, &msg, size);
+	if (ret)
+		printf("%s: res:%d\n", __func__, RPC_U8(&msg, 0U));
+
+	if (reason)
+		*reason = RPC_U8(&msg, 0U);
+
+	return ret;
+}
+
 int sc_pm_get_resource_power_mode(sc_ipc_t ipc, sc_rsrc_t resource,
 				  sc_pm_power_mode_t *mode)
 {
diff --git a/include/firmware/imx/sci/sci.h b/include/firmware/imx/sci/sci.h
index f832982b3de..7d8499f070a 100644
--- a/include/firmware/imx/sci/sci.h
+++ b/include/firmware/imx/sci/sci.h
@@ -75,6 +75,7 @@ int sc_pm_set_clock_parent(sc_ipc_t ipc, sc_rsrc_t resource, sc_pm_clk_t clk,
 int sc_pm_cpu_start(sc_ipc_t ipc, sc_rsrc_t resource, sc_bool_t enable,
 		    sc_faddr_t address);
 void sc_pm_reboot(sc_ipc_t ipc, sc_pm_reset_type_t type);
+int sc_pm_reset_reason(sc_ipc_t ipc, sc_pm_reset_reason_t *reason);
 sc_bool_t sc_pm_is_partition_started(sc_ipc_t ipc, sc_rm_pt_t pt);
 int sc_pm_resource_reset(sc_ipc_t ipc, sc_rsrc_t resource);
 
@@ -385,6 +386,11 @@ static inline void sc_pm_reboot(sc_ipc_t ipc, sc_pm_reset_type_t type)
 {
 }
 
+static inline int sc_pm_reset_reason(sc_ipc_t ipc, sc_pm_reset_reason_t *reason)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int sc_seco_v2x_build_info(sc_ipc_t ipc, u32 *version, u32 *commit)
 {
 	return -EOPNOTSUPP;
-- 
2.34.1

