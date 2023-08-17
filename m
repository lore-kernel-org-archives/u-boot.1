Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C53C2FC04
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 05:45:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C458B86A51;
	Thu, 17 Aug 2023 07:45:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="pOQrOVQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED47886A33; Thu, 17 Aug 2023 07:45:07 +0200 (CEST)
Received: from s.wrqvtzvf.outbound-mail.sendgrid.net
 (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BCDD8693A
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 07:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:in-reply-to:references:mime-version:to:cc:
 content-transfer-encoding:content-type:cc:content-type:from:subject:to;
 s=s1; bh=nW65KjGed3+EtWiVzspMAR6N9gwMQqUSLtmCieeETjo=;
 b=pOQrOVQcKluNxuUn5/tBnRfYaJl1Ej3GCdWVYbkZMkXJxlbqZp35OlhCJzQa5jILE43X
 iH5NiOBhUcF3IaNLXpXJ17hyTs3aV/YFVMjXWPlDVHI2A3WF9fQyosMBO0NtxJ9DcX35Dg
 84QtPkbCggDfV6daWQjolovirmXD78OnxEOhG6EA53mKTRD7Ev+GLoBBPea8OaJDovj3EI
 yI51gxs5Ml0HVp7WpY0Kif/DNOHuTAlobHEfUVD9G+lcLhcyvsS5GiPYVp1wbgIK1bZa5q
 rhKK0jk3hsF3KLBc9cViW1PkHKflL0WZPYnbm4LoLxoenTaL1gAxjJP+Q+bEgvjw==
Received: by filterdrecv-d7bbbc8bf-r6vsn with SMTP id
 filterdrecv-d7bbbc8bf-r6vsn-1-64DDB3DF-93
 2023-08-17 05:45:03.800542824 +0000 UTC m=+4364931.997297312
Received: from bionic.localdomain (unknown) by geopod-ismtpd-canary-0 (SG)
 with ESMTP id 804i5vbcTNa_uLxZBcgMUw
 Thu, 17 Aug 2023 05:45:03.596 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 2/2] rockchip: rk356x: Enable poweroff command
Date: Thu, 17 Aug 2023 05:45:04 +0000 (UTC)
Message-ID: <20230817054457.472342-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817054457.472342-1-jonas@kwiboo.se>
References: <20230817054457.472342-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h0Lzda9GCx5D1Mysp?=
 =?us-ascii?Q?BwNclZyqU1huUP1CWoI7Ivb4YNkEb9ighUCHbwb?=
 =?us-ascii?Q?q2H=2FkfBW47HdNQIJsASIjtMCILERlyxszgZzJS=2F?=
 =?us-ascii?Q?lTHqRyt3IfsIadiLhQi3AjVZ8B+ngqqHORRmKam?=
 =?us-ascii?Q?9gqqwbHacjZnY6PTEaYsqXkApbLUjHGHTrDUzT?=
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Akash Gajjar
 <gajjar04akash@gmail.com>
Cc: u-boot@lists.denx.de
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
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

With PMIC_RK8XX, SYSRESET and CMD_POWEROFF options enabled it is
possible to power down a board using the poweroff command and turn the
board back on using a power button.

Enable the poweroff command on RK356x boards that have a button wired
to PMIC pwron.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2:
- Split patch
- Collect r-b tag

 configs/quartz64-a-rk3566_defconfig       | 1 +
 configs/quartz64-b-rk3566_defconfig       | 1 +
 configs/rock-3a-rk3568_defconfig          | 1 +
 configs/soquartz-model-a-rk3566_defconfig | 1 +
 4 files changed, 4 insertions(+)

diff --git a/configs/quartz64-a-rk3566_defconfig b/configs/quartz64-a-rk3566_defconfig
index d55b224feacd..6853cd6c44b4 100644
--- a/configs/quartz64-a-rk3566_defconfig
+++ b/configs/quartz64-a-rk3566_defconfig
@@ -52,6 +52,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_PMIC=y
diff --git a/configs/quartz64-b-rk3566_defconfig b/configs/quartz64-b-rk3566_defconfig
index b98c81f9dcef..aa29fff14643 100644
--- a/configs/quartz64-b-rk3566_defconfig
+++ b/configs/quartz64-b-rk3566_defconfig
@@ -50,6 +50,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_PMIC=y
diff --git a/configs/rock-3a-rk3568_defconfig b/configs/rock-3a-rk3568_defconfig
index 44ff054df665..409aa95acf06 100644
--- a/configs/rock-3a-rk3568_defconfig
+++ b/configs/rock-3a-rk3568_defconfig
@@ -49,6 +49,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_PMIC=y
diff --git a/configs/soquartz-model-a-rk3566_defconfig b/configs/soquartz-model-a-rk3566_defconfig
index c3958579db73..a0884a797d58 100644
--- a/configs/soquartz-model-a-rk3566_defconfig
+++ b/configs/soquartz-model-a-rk3566_defconfig
@@ -43,6 +43,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_PMIC=y
-- 
2.41.0

