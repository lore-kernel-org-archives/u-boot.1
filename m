Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B37D2FEE6
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 23:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFD6B84213;
	Wed, 28 Jan 2026 00:59:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bVz3ES/u";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bFyOGYGe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 759478420D; Wed, 28 Jan 2026 00:59:35 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 524C6840CF
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 00:59:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4f12Sh726lz9txS;
 Wed, 28 Jan 2026 00:59:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769558373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WKR4jW4hAolK9pfg0SYol1iveMmF6E36kKAgQhyhkhM=;
 b=bVz3ES/uQhCh3rNHKntPrSJgNRNMlT6A35U4cyrf/OG0hA6trJtblploMcbNlmR8HwDnaW
 upCa9ZOCi5/tUU7D5MNwUYz5iDQyBKcqZmH+yrLbfhFP2GuYeYW7MeWCQVAx5jvY+WzAfM
 lMPkcw6NT3jdWJ1/cd0xOrmWbTneIiemznjjlmyxr1d3+Fbj4mW15TMFJSkPLJC/yQMUEV
 6yueHJ795RUNZm3NSIe5NPDAY+/ZsrDM8+VbVvOVQdqxgKRIiAzxPQN34bHLVSPkb11bIC
 xphKJ/5gsJaoJW6acAbhOfpdadgh5Q7/TKvqUAIDOTgfLj3I1Hw24WSFpyHFWw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769558371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WKR4jW4hAolK9pfg0SYol1iveMmF6E36kKAgQhyhkhM=;
 b=bFyOGYGetsR/rCXYr3rk0QJeQIfzIZT4CnK4mMKy2D3PT0EQSeEZtHZMBAccMDRT0crJfO
 pmDw8vl3eZJ/6dF8Xlc/63Bk8qwCy13w6PmaAOI8vz6QrSAT0cfj6kt2IjNv6ecxN/epN+
 KHdrLWtVp8goyBC8M3tDd8SvcNFqfiiyRG2B8c1w93Ssg/rGgxb7AWEGF1vmAQeE7LUzrA
 X08unftY3r6kQhUpUYg6OT30kjkzHa7i3IDCQ5129YAADRszuYmzHrNTj9dvIX9d8MaqEp
 5eE35xUSXsw1s/e9UbudXNekNVFe4OX0oGmnkgaiLTMZGmJz6lk0zEa4twh4Cw==
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
Subject: [PATCH 2/3] configs: sandbox: Enable zip command
Date: Wed, 28 Jan 2026 00:57:21 +0100
Message-ID: <20260127235914.1503663-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260127235914.1503663-1-marek.vasut+renesas@mailbox.org>
References: <20260127235914.1503663-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8c86c9470428ebf6f8e
X-MBO-RS-META: qqfnd3ut7bpbngetqrx4ici6wgn949ax
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

