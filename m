Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA95C71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 13:01:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 794F682D17;
	Tue, 17 Jun 2025 15:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aAc2uGK7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C22C382B0F; Tue, 17 Jun 2025 10:43:40 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C55C880C83
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 10:43:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jakobunt@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-60707b740a6so8295898a12.0
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 01:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750149818; x=1750754618; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ktNSHf8hcKjQd+gqW6bKd8NLFTDhdvdAH/Ol0HgPBm4=;
 b=aAc2uGK7DqC8pQ5vtUS6gIAPZZcVnbTW1cNYr3jio61aIsLjyPmZOiY5gJ5IKvXiM+
 Y4gccH6ANqKM8yiQhouQc0ln/q6qgwTmo6Q8wpKSSVBocRUEKKOzt26FutMg91tZxEga
 MmNhMekDa2dOpPzRMVkHOnKUBPHw4lc6JjJccO4hLoyUW3b/jjzP2Wv8l0rakmnou0JP
 rfwmvN4XQj7ebzYXUZ/xgat5BZS7QD91HsCaS8WjAevXtuM5YnZwNL1iMsD3V10lbWB/
 M/HbrSm9JO7v49EVd0i/Em8fTtxu7HbX1cKPAcGTpbI4Z3193N2mkIB4HY3KI/+C1qP+
 DY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750149818; x=1750754618;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ktNSHf8hcKjQd+gqW6bKd8NLFTDhdvdAH/Ol0HgPBm4=;
 b=C6rYs4JGVm2Sr10YtUSvEviLavw2LYYgvsI2LSZQaQBdpmFS6T0iZZpeMG12nW57RY
 GWk+G8+CBYoNY1gD+VvHNQnCknu3gYpQjEWo7uP8c0pysx3RTjs0++whVGnGBoeHudQF
 vSsqnbxzcSpnYbDEnGaXTmo+jfxa4RFw+3Bsl157SOdlhmoJrahzKZuQ3wzfwiYV0L4B
 PwG9OYlDU7q4h24e4gabWoDBihq16vBKmnt0/NEyMtgH0qJ4O9e/i0ZVSXnv8T7WPZz+
 UwkWKqo6yddm6dXtbvCwcHkBlskhLvQAh1UDsamMOaf8AuDdAVQogPXl7yfDEjZOKbg1
 zqJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC3o5OZc42o0Og8hhEAkXgsqk2VvxAqNWZlWMGG/lwg8LpebDGtzoZGWkX7b8vobUNAgWmrzY=@lists.denx.de
X-Gm-Message-State: AOJu0YzKT2MxTDoK1Xi+Wa7rS6vlD6TDgZhURLdCu0KsQ1BMbQ/BXd6L
 70uYE7cn1CKZ0NNqwiaajEz5nGticzNz7EinNLSo2t38iiEmcntfQdNmEPCuvKHz
X-Gm-Gg: ASbGncvOsFkKMoGZCJbXX3m3E1XSBkDUmMhJuqpI4UBo4WAysqxDZcyFOlLKg3Vsx32
 4XBkBEeGUL8mRiDxuy2PZIY/fhVNX1cyPe+8R7vJ+VbkHzjGBqP56qJ71Jv4UfcaIRf2abGKpJP
 okCFN8/zrAxKGyk3JsCghGjha1DQVXqa2Su+BTcoe3oDkfXuORELqeJmBgDTrYNZcrA7mkDpYwF
 ZANJFVFyaPfTC7YUdjLJ5XNjUqB/5aC6DMLDslJsI/lsdjbJU/RVoCCHoJc/UjxPHTh5/a5icuG
 7rfQxSCkEBlCtKwB1VYYbK8nCD+lfO4A9QJScVw38M/15ifXenQOoSgxZffDhM8sUgb1Rj9sOo6
 afa/wsm/hAljPxXhrabHow/DukSieL+DVkPW77z95
X-Google-Smtp-Source: AGHT+IEbkfiS5MMBjb1k4Y5qN8IcjJdZmePAy007Up8IFEDBV2XBqITtOIVi36EtOH3GyjcdHUkvnQ==
X-Received: by 2002:a05:6402:1d4a:b0:608:523c:1365 with SMTP id
 4fb4d7f45d1cf-608d097b95cmr9660630a12.29.1750149817934; 
 Tue, 17 Jun 2025 01:43:37 -0700 (PDT)
Received: from localhost.localdomain (ip092042140082.rev.nessus.at.
 [92.42.140.82]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-608b4addedcsm7511437a12.68.2025.06.17.01.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 01:43:36 -0700 (PDT)
From: Jakob Unterwurzacher <jakobunt@gmail.com>
X-Google-Original-From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
To: Klaus Goger <klaus.goger@cherry.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Cc: Heiko Stuebner <heiko@sntech.de>,
	u-boot@lists.denx.de
Subject: [PATCH] board: rockchip: unblock CAN bus in spl_board_init on Jaguar
Date: Tue, 17 Jun 2025 10:42:52 +0200
Message-Id: <20250617084253.1756035-1-jakob.unterwurzacher@cherry.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Jun 2025 15:01:34 +0200
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

GPIO0_B7 is routed to TXI of the on-board CAN transceiver. The
line has a pull-down per SoC default.

This means the CAN transceiver transmits a dominant zero
and blocks the CAN bus until Linux boots and reconfigures the pin.

Let's switch to pull-up as soon as we can (i.e. in SPL).
This cuts down the "bus is blocked" time from 10 seconds to < 1 second.

Of course, to this needs CONFIG_SPL_BOARD_INIT, so enable it
the Jaguar defconfig.

Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
---
 .../jaguar_rk3588/jaguar_rk3588.c             | 19 +++++++++++++++++++
 configs/jaguar-rk3588_defconfig               |  1 +
 2 files changed, 20 insertions(+)

diff --git a/board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c b/board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c
index a6d44f10db3..3f484646701 100644
--- a/board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c
+++ b/board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c
@@ -51,3 +51,22 @@ int rockchip_early_misc_init_r(void)
 
 	return 0;
 }
+
+#define GPIO0B7_PU_EN BIT(15)
+
+void spl_board_init(void)
+{
+	/*
+	 * GPIO0_B7 is routed to CAN TX. This SoC pin has a pull-down per default.
+	 * So on power-up, we block the CAN bus with a dominant zero. We want to keep
+	 * this blocking time to a minimum, so we want to get this pin high in SPL.
+	 *
+	 * The CAN driver in Linux disables the pull-down and sets the pin to
+	 * output high. We don't have a CAN driver in U-Boot and don't need one,
+	 * so we just use the easiest way to get the pin high, which is setting a
+	 * pull-up.
+	 */
+	struct rk3588_pmu2_ioc * const ioc = (void *)PMU2_IOC_BASE;
+
+	rk_setreg(&ioc->gpio0b_p, GPIO0B7_PU_EN);
+}
diff --git a/configs/jaguar-rk3588_defconfig b/configs/jaguar-rk3588_defconfig
index 03d38274b15..272f1ca8ded 100644
--- a/configs/jaguar-rk3588_defconfig
+++ b/configs/jaguar-rk3588_defconfig
@@ -27,6 +27,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-jaguar.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_CYCLIC=y
 CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 # CONFIG_BOOTM_NETBSD is not set
-- 
2.39.5

