Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CA3EA7951
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 01:42:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A9A683A64;
	Thu,  5 Feb 2026 02:42:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xze+gJMZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PVA24fCe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 274A78063E; Thu,  5 Feb 2026 02:42:08 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AD0A8341A
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 02:42:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4f60MK5gdvz9tCh;
 Thu,  5 Feb 2026 02:42:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770255725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bwgkI4qwNg9hLAjyAQBe4ya40f+2ynltovladp3iGQg=;
 b=xze+gJMZ4Dj1ls9IHLkzlNR9XCwXqsYsWSabWbFeApCAfIRGFu3W02CsFXWcAjsrRWzdu5
 nGuYEcD80crx72NmFCCZ9XKc9N5cdghxjPHkdYZZtRVSDh98GwQqNtrtLrgi1dLaWJDz5k
 ZQc4KWusgPWB+82PmpufLZOT1NVw1amCm542NtVSCbd/TLOzAYTRxjCiverhGufBWXS/fw
 /UDsXKQEQjm7xadEYkIfBSVhSgJDvqVrcsJm6HlwlJO2bQN0O2AQ2fAJi7oSmB99frqH1F
 67uYPnWW4MfyweCr0GNdV0evokfGrGnDjZ8kZOzVjr3Yx5CnGU47sniU9SjxRQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770255723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bwgkI4qwNg9hLAjyAQBe4ya40f+2ynltovladp3iGQg=;
 b=PVA24fCe738U3y7QZGp0GGgnzAZMZC2QgP8rZZNae6akK95BpZoszbzpOUdInLGJHT6Sbs
 HgLDCz/J6CCG8FJPWRunTXbb4Gfk/AgfqYRYQDVMq3iPDtiFRCj8exMVKOyqkDBUdP2Dd3
 Ju1TeOG0XIZZf4g/40W0drMp+wl7X0F128hk4FmTkr6+Wfp089biqxjdAEmSVS1LIlIk/b
 Raws8d7oTg9WoCNeSgnC/BO018vRfDnDViI2Dxup7jiP6B6HHKXcLC0QHHZ7eTlJOOyLB7
 2K20bCypujaaje6JQj3m2Xx29RrxpzcrnAS5CC+16NJr55VMv9s/j+BiYi1UMw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Alexander Graf <agraf@csgraf.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: [PATCH v3 1/2] configs: sandbox: Enable zip command
Date: Thu,  5 Feb 2026 02:40:44 +0100
Message-ID: <20260205014153.218621-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260205014153.218621-1-marek.vasut+renesas@mailbox.org>
References: <20260205014153.218621-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e0acbf7681e9212f5f6
X-MBO-RS-META: dgi9jj5s9q9g9eqocu16cxd755p6xdh4
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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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
V3: Add RB from Mattijs
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

