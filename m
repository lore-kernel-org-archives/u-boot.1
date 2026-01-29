Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCF5D73E87
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 23:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEC8F84158;
	Fri, 30 Jan 2026 00:57:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KPD0Lx1m";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aCLjY3PB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDF968414B; Fri, 30 Jan 2026 00:57:03 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 855E784144
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 00:57:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f2GJr0YNPz9tyY;
 Fri, 30 Jan 2026 00:57:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769731020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r7J7XBUm+AGJ7kXi6iNoZtySJ0ZDcvfpdWSUqhMQuy4=;
 b=KPD0Lx1myhMYLffOR6jMnUtNKeZCPvOObqHzFSo36EYsmbgkM4ms9g7U2okmDFxI7ULM4a
 kwbU8en2WFbD2rh89R9Xxl23MS73LS+blyxB/1xIVJsOAaT0gR8CyWHjXj8Fpc6sY4F8J+
 nEzbk5hrq6dCJxXAycQGpuXDHvJXzqUYg5ttxPbHwFVv22iVy1+eOe7vDglP4oEVJLiqx+
 He0oVB8pM82ZF8gLVKHOveHVnrgtwlNwyqoqwzuRgqkqXgBdZAFOvNR4jLtsU2cIKNhSX7
 vvtjeJ/bWaBhXd9bLhhu78YJCYMnckQYiFZCfmHhDKHS1e685JktA6c7Bxyl1A==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=aCLjY3PB;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769731018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r7J7XBUm+AGJ7kXi6iNoZtySJ0ZDcvfpdWSUqhMQuy4=;
 b=aCLjY3PBI0d0WqVJFb+EXSLHO4XV1YgewkLboh6y6hcR9HR+jkVGmHor19Ze3sQq9ShcTQ
 SYhocV9fQeyKaTf9+8dOmTkNu379KJ+mo15fGP30GVUchV+FmkNBuen9n2Fu8i2OFYWM6X
 /W833O3A1Ti+IxR/oCdtFdNNuqK9kDbNyzgumzUFVrcgPfYW9UgiqooOcXV2+r0ScQVAvH
 BEJTba3Ib7syVMqlysKZ9kFmKOlt7+7kesNv3tlnTWp0li2XgvpYRoHgNXFeL4cC1Uh9pD
 vC/o2++drLmE+rKX+gBB+pJEmguIJfai0m/9TYLJ7J85KdZqOxUcOBD6t5a+aw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Graf <agraf@csgraf.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: [PATCH v2 1/2] configs: sandbox: Enable zip command
Date: Fri, 30 Jan 2026 00:55:52 +0100
Message-ID: <20260129235647.660906-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260129235647.660906-1-marek.vasut+renesas@mailbox.org>
References: <20260129235647.660906-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: s3akjzbh7nozg6g48ong3s8g57ic885q
X-MBO-RS-ID: e99acaa9185fbd649c8
X-Rspamd-Queue-Id: 4f2GJr0YNPz9tyY
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

What is not being built and tested in CI, breaks. Enable the 'zip'
command in sandbox to get it build tested in preparation for an
actual unit test.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Alexander Graf <agraf@csgraf.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome@forissier.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Cc: u-boot@lists.denx.de
---
V2: No change
---
 configs/sandbox64_defconfig | 1 +
 configs/sandbox_defconfig   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 440e5efa340..60a30d04875 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -47,6 +47,7 @@ CONFIG_LOOPW=y
 CONFIG_CMD_MD5SUM=y
 CONFIG_CMD_MX_CYCLIC=y
 CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_ZIP=y
 CONFIG_CMD_BCB=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_DEMO=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 92fb5f844b1..f9e3c921d3d 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -75,6 +75,7 @@ CONFIG_CMD_MD5SUM=y
 CONFIG_CMD_MEM_SEARCH=y
 CONFIG_CMD_MX_CYCLIC=y
 CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_ZIP=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_DEMO=y
 CONFIG_CMD_FPGA_LOADP=y
-- 
2.51.0

