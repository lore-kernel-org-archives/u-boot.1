Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1230606A32A
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MSdauVM9;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eiXkNt15
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97F3E409FB;
	Tue, 10 Nov 2026 15:49:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UnW1YR4xmW_4; Tue, 10 Nov 2026 15:48:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3DCF6409EC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794325739;
	b=VHCXrCzC3jRFDMSHrS9+7SHAAjzvxoRsq2DFPP93paz8LPRKu+Nm5yMTh9DhbafOPLtt
	 OK+1uzlvLrq748IWDW/r9RgMF/7347lKy6K2m3zN3E0XrB+U+QH1afzundlaa6FED+8nZ
	 yXmP+BEtyr/efu2nb31B0PES7Z5cF6qaliQGx3p1sJjD1ofjeALgCABzbbBxQpCOFrqF/
	 mPkeuW0ufi10/QnHYuuSIM15Th+RNN+f0iERbi7JlwvBJZCovoUI9xckcBSCZMcPGYsQQ
	 Ne4kRmB+HjSYb2TyFM7xUf3Gwm2AsOMOguUV3n4KFZ4dzjOrJzVadcNhgQzqzYpiBDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794325739;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7xw6fJiE3BZIz1G8LCqwxEsiXuiRx04tLiUQFyKvaAA=;
	b=VMVIhZK2NJkE4PSPP1nLANEJodUa35dxWfiYZx0WvMP67HDlSOzml7wPTx69imY5uMpy
	 OgxJpxBo8RxlQhNFH1i7laEtInAP79AIxYRXV5b8Zbr2+GA/K5n7Z5YjX5dMtQjvkufHX
	 ZocXYc/ViwYLmh+e0WfuBcPQ6nHDiIKyqWSN2exA2HXTwUwFuisanFvqDo1nMr6cCgeI2
	 cnAVvoCtKRHKRx3V5kb+3MoDutIaX4mCK+4rfOtX68uVAgafDxc/TL/fgB3zgvDd8Xq9F
	 ko4KMX0tuur+qFgK4sIQnCZM66e60rmG4BG1ERD2JHs3rv9TAqpGdABdpEF+09kjW6Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794325739;
	bh=7xw6fJiE3BZIz1G8LCqwxEsiXuiRx04tLiUQFyKvaAA=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MSdauVM9vj2kZsEeQZEC8OstuIO54scK32oNd78DdeAPdxoDThaoUj1ZXNED636ae
	 +4Vn/Nt2XE3NeiJ25N9aJcKl+yQpFOzGZtdluSE7yrlWGuA8uSlHtXdryxQgiCk+ve
	 QHPRHMQqqD1QxeMLAOTde3iSvH1vBaWk8zCd1J8HxhAhFYrCdb4fMzXP4pHf2TpC8y
	 b3dBt5nTzByEHFI1LGSInbPmjLRebCWPYlRm335nv3kDcmwAIU+BNnE0uc5WuPw8+b
	 BEpaKN+h2UK3/6z4o4+tGkBR/CGjM0p82FCe1bmIkYYp1s9nn7pB8sYvHHJEWPh3Ol
	 bTLl/HW5MP90g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DCF6409EC;
	Tue, 10 Nov 2026 15:48:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D1238388
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:48:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B603681320
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:48:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D4Z6LiVfuXto for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 15:48:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 376C481319
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=arturkow2000@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=eiXkNt15
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 376C481319
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:48:55 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so26976895e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794325734; x=1794930534;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7xw6fJiE3BZIz1G8LCqwxEsiXuiRx04tLiUQFyKvaAA=;
 b=eiXkNt15k2o5/1oXOT66ULNHXKI25LNukfLCi4AZ4gjoGMSmXixJDFitkdAWz/tfTI
 rVnHpk5mSqb+6mcAws/WlFrV/eqRQVKwFJc47Hr2qkYgK0A9QH8foRPsPl0XR6MuDCvr
 57TzU/RHyS61v1hXs8qgci+YFLvU6M1hX293wYNnTRFQPEOTZUuXagejVMw/PJplLKc4
 TCaPGUuAbgF3GTwhbPHM7T69U02rM+Ll14BsG5xY2Kytnkp9xD+vxVik6K+g6h6zqfF8
 2qfxyobLO0UcLMkK/J25cd88ErviVvgZt7sykRUE9cn/3KBesgM7iySotUSidjPH+FF8
 S6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794325734; x=1794930534;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7xw6fJiE3BZIz1G8LCqwxEsiXuiRx04tLiUQFyKvaAA=;
 b=N1q8ztC2wkkyOvskB2FC8KQbdDnJneACZn31Ii1fXyXP43AtoaFDQtw3SBHDgeg/ad
 zcq6g+KllE3Et63Y7qm1Z7G3BmhINWrl5lbzKAttFb1BqHH01KiEMkx6FFszqLb0bXyj
 Ybi2QKGjI8XwG2pHn3vYdB/SFSr8ZKCgYxG2vtqXXSuGIsXz6Ed2tuT0NZHw0cfm2ZGU
 HJxBmmKer7K1RfDqG0U1pZ+QfN71Qi6SSoE7CNz4zOnxfXlEq2mdR0EfQQFJwY5Nb8Y9
 rHiuGtp/fQ/bX3zkN6TkOQ4W6CCb4q3sLOEcah8ynfZv5dCVc/uosYlar4aEBTIXgaaX
 aysA==
X-Gm-Message-State: APuU4Z/qJ8CpQZ9uHikONPD/eTvWiS1Z4MKMIWD+eAR4snsmvI2NGWt4
 E8cEFM6x8KuCuf2J5DWfYJp8YcLcClBxvefhXImAPVJCLuXBHfReNNcCJhScQJUY
X-Gm-Gg: AYBFou2f8+1OLF8qmx0Ft0333srbS/d7fF8lksxQukj6HcTp+r/d8Z/Vad0munoKyjT
 A1eMORYMu1WCma2afcq5G4VZ9T0+ylGJpiwXQfsBc450aPAfLNI+zYSz4ypx1R8lxY9IXVQdVVN
 g+XXvT0eS2ZN1uFjAMEQRmBaDb8Fcdk3a1bbK95mPOk2qND+qhIbulow/7rn3UQH/wLqLgBVBT4
 TRsjN2ktcXR5sFkrXwFoaNb3M4/IL1Qz09gKp2OaqPlP/QOuax66+C2oXYYAAdFikSm56IKJXUu
 4l283gJMp9zzvEc3oINzkb5nWtt3e7zSqKY2NkG7MH+Fqh6A0gvz91Y4JasMtn7+fGxeU7jQMrG
 SqKhaDlvfHvsor7YLX2S1uB9RCPtaB2N2jRO6UBk8j8ZkyqbJFIVgw6Imx+3mAB5fsctVBB7JJG
 6PuuLOaVnoj0f5SKRgaI2YmsZwWBxp5vGb+j8TilAK9lJ3ui/+E+7zL+DrQfiy7HO/icZkjlFfU
 C6BKKLYG0kGCAGBmp2vOuJetyDYQrLHKBlQTCu6dWKgyB6f5GDIQjEV7UQl0WicS15hTLr6FPHR
 nMzaCJg4PvtYTj7gHgc+nGSeUxlTAYbKvXsBB14G
X-Received: by 2002:a05:600c:500d:b0:4a2:18c4:61a5 with SMTP id
 5b1f17b1804b1-4ba0233cbf4mr52913745e9.6.1794325733584; 
 Tue, 10 Nov 2026 07:48:53 -0800 (PST)
Received: from [192.168.0.15] ([2a02:a312:c59b:a180:251a:f25f:80fa:af1d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fea745sm69814385e9.10.2026.11.10.07.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 07:48:53 -0800 (PST)
From: Artur Kowalski <arturkow2000@gmail.com>
Date: Tue, 10 Nov 2026 16:48:50 +0100
Subject: [PATCH v2] watchdog: add Tegra20 watchdog driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-wdt-tegra20-v2-1-b452b03bedb5@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/1XNQQ7CIBCF4auQWRcDpBLalfcwXRQY6RjbGsCqa
 bi7aY0Lly/5870VEkbCBC1bIeJCieYJWqYqBm7op4CcPLQMlFBaSmH402eeMcReCW681qittsJ
 7qBjcI17otWvn7rvTw17R5Y3YioFSnuN7v1vk1v3k5k9eJJfci9padzSqwfoUxp5uBzeP0JVSP
 ghT+rW4AAAA
X-Change-ID: 20261108-wdt-tegra20-8d66e6b6b0dd
To: u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Artur Kowalski <arturkow2000@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9565;
 i=arturkow2000@gmail.com; s=default; h=from:subject:message-id;
 bh=fKgki5/AFIkJkxIs/ln6XLmbkXBc46AbUX6yVjEdPak=;
 b=owGbwMvMwCVmYeTc/TaVxZzxtFoSQ9Znmyf53F0GUcIbV961lf7Gdf+Ujdit00zn2rgXhO3z/
 GOfHcjUUcrCIMbFICumyGL2UOgLzzyv9xtebu2EmcPKBDKEgYtTACYi/47hN7v7VnPzvDtRrCUH
 JM9b83NVbJg14+B+5ncnWr1XLd245BnD/9Rzk1We/brGufbRRLfW1F/v3PWPHysWaeOW2PhPSnz
 ZUX4A
X-Developer-Key: i=arturkow2000@gmail.com; a=openpgp;
 fpr=F60710C8D69E03A01A2801CD87A47D20C2709637
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The timer driver binds tegra_wdt to Tegra20's timer node as well, but
tegra_wdt programs timer 5 and watchdog 0, which only exist on Tegra30
and later. On Tegra20 they lie past the end of the timer block, so
starting the watchdog writes to unrelated registers.

Tegra20 has no watchdog block. Instead, the clock and reset controller
can reset the system when the interrupt of timer 1 or 2 fires while the
previous one is still pending, enabled through the WDT bits of
RST_SOURCE. Use timer 1 for it, which U-Boot doesn't use otherwise, as
it only reads the microsecond counter. Run it periodically with half of
the timeout as its period. Clearing the interrupt alone doesn't restart
the period, which would leave between half and all of the timeout after
a ping, so a ping also rewrites the timer setting, read back from the
timer, to restart it.

As this has nothing in common with the watchdog block of Tegra30 and
later, add it as a separate driver and make tegra_wdt depend on
!TEGRA20. The new driver keeps the tegra_wdt driver name, and the timer
driver also binds it when WDT_TEGRA20 is enabled.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
---
Add watchdog support for Tegra20. This makes it possible to recover
from hangs in U-Boot or early during Linux boot.

Linux doesn't handle a running Tegra20 watchdog yet. Its timer driver
uses timer 1 for CPU0's clock event device, which can reset the system
early during boot. A Linux series that keeps the timer driver off
timers 1-2 and adds Tegra20 support to tegra_wdt is under review [1].

There is also a Tegra20 quirk that affects any watchdog reset while
Linux runs: the watchdog resets the system through the clock and reset
controller, which doesn't reset the PMC, so the power partitions keep
their state. Linux powers the VDE partition off when its PMC driver
registers it, and whenever the VDE is idle. If the watchdog fires while
the partition is off, the boot ROM hangs and the device stays dead
until it is powered off. Linux already works around the same hang for
reboots (commit 8f0c714ad9be ("media: staging: tegra-vde: Turn ON power
domain on shutdown") and commit 510f276df2b9 ("mfd: tps6586x: Register
restart handler")). The Linux series either stops the watchdog before
the VDE partition is powered off or, with tegra_pmc.vde_always_on=1,
keeps the partition powered on.

For these reasons I haven't enabled the watchdog in any defconfig.

The patch was developed with the help of Claude Code. I have reviewed
it and tested it on an ASUS TF101 (Tegra20). Tegra30 and later are
untested, but tegra_wdt is unchanged apart from its Kconfig dependency.

[1] https://lore.kernel.org/lkml/20261110-t20-for-upstream-v1-0-5923449951fe@gmail.com/
---
Changes in v2:
- Move Tegra20 support into a separate driver, tegra20_wdt.c, exclusive
  with tegra_wdt.c and keeping its driver name
- Link to v1: https://patch.msgid.link/20261109-wdt-tegra20-v1-1-d04bbc5829e4@gmail.com
---
 drivers/timer/tegra-timer.c    |   2 +-
 drivers/watchdog/Kconfig       |  12 +++-
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/tegra20_wdt.c | 134 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 146 insertions(+), 3 deletions(-)

diff --git a/drivers/timer/tegra-timer.c b/drivers/timer/tegra-timer.c
index 778b65b6062..e76ec4a3a44 100644
--- a/drivers/timer/tegra-timer.c
+++ b/drivers/timer/tegra-timer.c
@@ -109,7 +109,7 @@ static int tegra_timer_probe(struct udevice *dev)
 
 static int tegra_timer_bind(struct udevice *dev)
 {
-	if (CONFIG_IS_ENABLED(WDT_TEGRA))
+	if (CONFIG_IS_ENABLED(WDT_TEGRA) || CONFIG_IS_ENABLED(WDT_TEGRA20))
 		return device_bind_driver_to_node(dev, "tegra_wdt", "tegra-wdt",
 						  dev_ofnode(dev), NULL);
 	return 0;
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 3c56c541505..2da75ded02d 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -467,9 +467,17 @@ config WDT_TANGIER
 
 config WDT_TEGRA
 	bool "Tegra watchdog"
-	depends on WDT && ARCH_TEGRA
+	depends on WDT && ARCH_TEGRA && !TEGRA20
 	help
-	  Enable support for the watchdog timer found in Tegra SoCs.
+	  Enable support for the watchdog timer found in Tegra30 and newer SoCs.
+
+config WDT_TEGRA20
+	bool "Tegra20 watchdog"
+	depends on WDT && TEGRA20
+	help
+	  Enable support for the watchdog of Tegra20 SoCs. Tegra20 has no watchdog
+	  block, so this uses timer 1 and the clock and reset controller to reset
+	  the system.
 
 config WDT_ARM_SMC
 	bool "ARM SMC watchdog timer support"
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 84faefdb4c2..50c983d6637 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_WDT_STM32MP) += stm32mp_wdt.o
 obj-$(CONFIG_WDT_SUNXI) += sunxi_wdt.o
 obj-$(CONFIG_WDT_TANGIER) += tangier_wdt.o
 obj-$(CONFIG_WDT_TEGRA) += tegra_wdt.o
+obj-$(CONFIG_WDT_TEGRA20) += tegra20_wdt.o
 obj-$(CONFIG_WDT_XILINX) += xilinx_wwdt.o
 obj-$(CONFIG_WDT_ADI) += adi_wdt.o
 obj-$(CONFIG_WDT_QCOM) += qcom-wdt.o
diff --git a/drivers/watchdog/tegra20_wdt.c b/drivers/watchdog/tegra20_wdt.c
new file mode 100644
index 00000000000..2d3d7bd120f
--- /dev/null
+++ b/drivers/watchdog/tegra20_wdt.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVIDIA Tegra20 watchdog driver
+ *
+ * Copyright (C) 2026 Artur Kowalski <arturkow2000@gmail.com>
+ *
+ * Based on tegra_wdt.c:
+ * Copyright (C) 2025 NABLA Software Engineering
+ * Lukasz Majewski, NABLA Software Engineering, lukma@nabladev.com
+ */
+
+#include <dm.h>
+#include <wdt.h>
+#include <asm/io.h>
+#include <asm/arch/tegra.h>
+#include <asm/arch-tegra/clk_rst.h>
+
+/* Timer registers */
+#define TIMER_PTV			0x0
+#define TIMER_EN			BIT(31)
+#define TIMER_PERIODIC			BIT(30)
+#define TIMER_PTV_MAX			GENMASK(28, 0)
+#define TIMER_PCR			0x4
+#define TIMER_PCR_INTR_CLR		BIT(30)
+
+/*
+ * Tegra20 has no watchdog block. Instead the clock and reset controller
+ * can reset the system when the interrupt of timer 1 or 2 is asserted
+ * while the previous one is still pending.
+ */
+#define WDT_EN			BIT(5)
+#define WDT_SEL_TMR2		BIT(4)
+#define WDT_SYS_RST_EN		BIT(2)
+#define WDT_MASK		(WDT_EN | WDT_SEL_TMR2 | WDT_SYS_RST_EN)
+
+/* Use Timer 1 as WDT counter */
+#define WDT_TIMER_BASE		0x0
+
+struct tegra_wdt_priv {
+	void __iomem *tmr_base;
+};
+
+static int tegra_wdt_reset(struct udevice *dev)
+{
+	struct tegra_wdt_priv *priv = dev_get_priv(dev);
+
+	/*
+	 * Clearing the interrupt alone doesn't restart the timer, so the
+	 * reset could follow as soon as half the timeout after the ping.
+	 * Rewriting the timer setting restarts its period. The register reads
+	 * back the setting (in periodic mode, the timer never clears TIMER_EN),
+	 * and while stopped it holds 0, so pinging doesn't start the timer.
+	 */
+	writel(readl(priv->tmr_base + TIMER_PTV), priv->tmr_base + TIMER_PTV);
+	/*
+	 * Clear the pending interrupt. Doing it after the restart is safe:
+	 * an interrupt from the new period that fired in between is just
+	 * cleared as part of this ping.
+	 */
+	writel(TIMER_PCR_INTR_CLR, priv->tmr_base + TIMER_PCR);
+
+	return 0;
+}
+
+static int tegra_wdt_start(struct udevice *dev, u64 timeout, ulong flags)
+{
+	struct clk_rst_ctlr *clkrst = (struct clk_rst_ctlr *)NV_PA_CLK_RST_BASE;
+	struct tegra_wdt_priv *priv = dev_get_priv(dev);
+	u64 period;
+
+	/*
+	 * The reset occurs on the second expiry of the timer after a ping,
+	 * so the timer period is half of the timeout. The timer has a fixed
+	 * 1 MHz clock and counts PTV + 1 ticks.
+	 */
+	period = timeout * 1000 / 2;
+	if (period < 1 || period > TIMER_PTV_MAX + 1ull)
+		return -EINVAL;
+
+	writel(TIMER_EN | TIMER_PERIODIC | (u32)(period - 1),
+	       priv->tmr_base + TIMER_PTV);
+	/*
+	 * Clear an interrupt left pending from earlier use of the timer,
+	 * which would otherwise reset the system on the first expiry, after
+	 * half the timeout. If the new timer has already expired, this counts
+	 * as a ping, which is harmless right after starting.
+	 */
+	writel(TIMER_PCR_INTR_CLR, priv->tmr_base + TIMER_PCR);
+
+	clrsetbits_le32(&clkrst->crc_rst_src, WDT_MASK,
+			WDT_EN | WDT_SYS_RST_EN);
+
+	return 0;
+}
+
+static int tegra_wdt_stop(struct udevice *dev)
+{
+	struct clk_rst_ctlr *clkrst = (struct clk_rst_ctlr *)NV_PA_CLK_RST_BASE;
+	struct tegra_wdt_priv *priv = dev_get_priv(dev);
+
+	clrbits_le32(&clkrst->crc_rst_src, WDT_MASK);
+	writel(0, priv->tmr_base + TIMER_PTV);
+	writel(TIMER_PCR_INTR_CLR, priv->tmr_base + TIMER_PCR);
+
+	return 0;
+}
+
+static int tegra_wdt_probe(struct udevice *dev)
+{
+	struct tegra_wdt_priv *priv = dev_get_priv(dev);
+	void __iomem *base;
+
+	base = dev_read_addr_ptr(dev);
+	if (!base)
+		return -ENOENT;
+
+	priv->tmr_base = base + WDT_TIMER_BASE;
+
+	return 0;
+}
+
+static const struct wdt_ops tegra_wdt_ops = {
+	.start		= tegra_wdt_start,
+	.stop		= tegra_wdt_stop,
+	.reset		= tegra_wdt_reset,
+};
+
+U_BOOT_DRIVER(tegra_wdt) = {
+	.name = "tegra_wdt",
+	.id = UCLASS_WDT,
+	.probe = tegra_wdt_probe,
+	.ops = &tegra_wdt_ops,
+	.priv_auto = sizeof(struct tegra_wdt_priv),
+};

---
base-commit: 2f797312a4e2c5d104786dbcde9f7db8e355ee6e
change-id: 20261108-wdt-tegra20-8d66e6b6b0dd

Best regards,
--  
Artur Kowalski <arturkow2000@gmail.com>

