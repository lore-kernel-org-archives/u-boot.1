Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E78C982FA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 09:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A09060830;
	Wed, 23 Sep 2026 09:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cy0fiMz2NUC1; Wed, 23 Sep 2026 09:35:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EB81F60705
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790156126;
	b=cNKEexDZKRuF1lSq0Lott4ipFN3U3PevCAq4DJYqIQvAMlLwMdpb0COnoNXPJsb7XeoN
	 8gukdMIm8g1xMnLYqn60xiSHuC5igRNqr1zOBF4i3ro/aw5eNkrVf/v0iRYqHuCqiztQC
	 hscDwtJe/rnV9DPC/Z2rqZpAyUCBAdUuNuC5O3XTfKeOpkiuTFQ9fCa1olCuDdfaG9UMz
	 sta0Ugb2dpjPZE0Nnw5tyQzspZRU4oepUj7uZJrsFFqXwtvYeJBlFy5FvkapxgvCLyJOV
	 IckTmGpPWzLIoBoPMP83JhIBKzuIKEaxMt4xv+F1iiW/00UwJky7/RE62qh3ld4QiZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790156126;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Gz25oVKMZ8NjwsKL0KwR4/IhLbSzV16dZkwCidVdjw0=;
	b=qGTdtkTJCKF3JTF/7v+6ZgzNoAMNF95b9a8zyFBkFUFR2hBKtQ7yQrSCAvu9T//Eq7ei
	 Jm67n/UWNn5UakZXDwEdYSDJ4bcD08DSKsAHyqM3fW9ZUNwXjIgByrCqjwwvJw04a7E/m
	 qOBw1CgC+zykoVx+iBUrBABmqsz3NMqQFArdrLB3u89f8NMM3AV70qAPHiZh/ZzUrYfBs
	 p/fLFrJUA+aphnB0UtNbVE+A6yrjQhWqazwhHpOene/AnbBZPNRXj9gWCIV8X73JGPVqQ
	 uR+113k2SQl5qucJRARRVl4bN3pykj1d6XUW5XaqpOmBvhyytKCNmen0OUlzYlG7NWw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790156126;
	bh=Gz25oVKMZ8NjwsKL0KwR4/IhLbSzV16dZkwCidVdjw0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EdwGiNP++w62G8ZVcTg9mBBYXQ+M5wFunum6BavGoZlol5MUKyEtCX7Uxxi8luger
	 vgWtPklF64xFVDt1WARe2u9p/306QUcPAnpgpfWGOEiO10dvI0OS6iitbdaBko6/ya
	 Gdnp6OZTbKMhLV170XyMojfBdlLfa5sXUxuYFdiI2R3j1pG3iU2PfJl9BeS2gEuNLw
	 e793z6IL3H6adE76iBkKFK01eEjkp8YV526RcyrHBI8cfgNyYaQTZPe8RhQopxcl7T
	 7CX+Nrq4h933I9ptimf8D5HB1SKKQEAVr/dwDKPmHwpTM1djywD06yF3N2u1/gn9qq
	 FMUPeXqDL52Fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB81F60705;
	Wed, 23 Sep 2026 09:35:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D092194
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 09:35:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5F1E7405E7
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 09:35:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CHZdL7Qa5sKD for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 09:35:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 70610404C9
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790156123;
 b=pQ++47Nc2B9RCLTUAMaJfi5kSDfoF4S3EfhbWyLq0lcZB9OJjFIA670y7ucUo/acfWbV
 G3irLICaPc74coRcSP6t4DC8PH1U/4BeIHurNyvx25fzeXoyzt+VlRIUFhBW28USU0kk0
 qertvwqctBOaG3mVzBh77r1D5upv1+j1fKcOgju7rzzEES1Gyign2G3U7FXGYmRJJYHY4
 S/9bnprUMWacf1rovZ5ZJQKlpZbo+44ThWxJD/xu8jqpOqWHZM0VsJrcRYubAEWqgbULV
 29nWyiAyR1VaaYFQmvchCZ8MqxxAAX9i42XOLcATFdVX86sEYD/heGxL/ntiwwXbjAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790156123;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Gz25oVKMZ8NjwsKL0KwR4/IhLbSzV16dZkwCidVdjw0=;
 b=owHkyYYY9Aba3e9F2KKsGoD6LHKw7ftpi968MDXzUk8fIauHiVmtEwlbO86X9Gx9I1+F
 v/RDX+KPEb+gSdtQaohZ920Evd6Y7CAj/eEggvEReXdKVHsFNrRapwKc6yuB7uMKnfhdk
 7qfceRjuKS5GG/C5vd00WoTOqbS+zQpH562YWqYSsJ4Uj/LXB6PJIaYiB0uck/KGunXoh
 phTJYh2T/8yIPCZMm+K2aOIPwGXOtsiTut07tgCCnnuBgrAH3zzyvC748MkJk22CwIR6s
 4vRaWgCL2HeX7V4kepMjPOJ0S4neEE/WmzQfeYuRnzhlFCodPsYmGN8eiECraZfEb8A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GCX9KmPI; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=GCX9KmPI
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 70610404C9
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 09:35:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8351243CED;
 Wed, 23 Sep 2026 09:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670281F00898;
 Wed, 23 Sep 2026 09:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790156121;
 bh=Gz25oVKMZ8NjwsKL0KwR4/IhLbSzV16dZkwCidVdjw0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=GCX9KmPIcZLE1b22TLRYf+pVACRi1tPCrKPMaCRM7ZPpKiPw4a7OLF4DJvEwNkpYE
 QfsvvLvdpqYJLyeSeeiBxywVFcIaZNdTSkGqryxWKSMJ+qBI8HXTIEYlGSxR9X3+aC
 dD/FnKkcCKt94JwZWXYJwXo7NmECdNin/INqp1PXCNaIN/CZ3sq9p6qBtCngXIjiAq
 slPEDFBduJ9IQRjxY51QMi07BVrnR0diO5oP86arFp7IvlZafJUd/r5XBXuiXvytND
 qMLXYc/uSjO70JuLZNaYCP7628PZLp3fmuM2p6AYysEZzIPdmKt4zo0TsN+bC/JC/8
 +W0rlF+qvgxdQ==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 23 Sep 2026 09:34:30 +0000
Subject: [PATCH v2 7/8] reset: spacemit: Extract common K1 reset code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-01-k3-clock-reset-support-v2-7-6ec0abb1c7b5@kernel.org>
References: <20260923-01-k3-clock-reset-support-v2-0-6ec0abb1c7b5@kernel.org>
In-Reply-To: <20260923-01-k3-clock-reset-support-v2-0-6ec0abb1c7b5@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: spacemit@lists.linux.dev, u-boot-spacemit@groups.io, 
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Peng Fan <peng.fan@nxp.com>, 
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@flipper.net>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13174; i=dlan@kernel.org;
 h=from:subject:message-id; bh=HRgS40R875GNJ9FSro4CkQuBnRXJL+2KJ8meNXOdHek=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqs505IJ3XP2UZn8A8H5ph+ysFpNuzufx2zpY9T
 wOhrqdrgByJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCarOdORsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1v1A//fguEjfHb0MO+FJ3l860p+g2so1vkFOwdKEmx92LpQf5HCkH2VCuk7
 AUhSRn2cD2YxKUPm0YIuXZ3nSNoedRphvU64nij7pAoeg8GAIHJGaKXyX+46SB8/qGA7tNlNqdx
 aUYp8MPNnQkH6DI1qKt5/TxJNT+cbNDNNc7cTMD9AfjrDUZxkk3PlObbD+lu3I7qBjcYw0MSR+d
 X5mK6KId629DKVEa08d77EfAHilEcS97Abyin/PynMZZTt3VyLUe4nK7dJkvkGh4SYoSY//EieN
 TfxaWkJWup/FOu7oDgA+JozADJHuOU+JKkNSppRQsWbmrClYBmNiXzilpZAhWbHYtsv3UqLnVh8
 9abOSyEwVWWIFCFQQ+hr4+m6CP8SACJyTsA6+he8LLZCmbV9h4xwcVwFeSE/pi47eH+1vkztySE
 sUY1mN1dBT36g1TeI26hasAMahLl2n9HO9pDgOlEK9Duh5rASg91DAMUHdE60Mrqk5gGQMRQIfZ
 UfaTWEra8pLQhWOmT4GYnMn+7AS7bHVMaj3BMvbF4rOXVZbhPdbq1ROECs9FNjs6Xc9N5LTMT5M
 UPxM6O1yhOg4SPgg6zlG3B3xwzli6dwLNFuHueI15fYLfsBc0YqMLc5y0LCcsoMheGw85Gr+/Jy
 HUjTTHeK/Igk/Vvv1txoFjtJVUpgmY=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Based on upstream Linux:
  aba86f7bff0b ("reset: spacemit: Extract common K1 reset code")

Extract the common reset controller code from the K1 driver into
separate reset-spacemit-common.{c,h} files to prepare for additional
SpacemiT SoCs that share the same reset controller architecture.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/clk/spacemit/Kconfig                   |   1 +
 drivers/reset/Kconfig                          |   1 +
 drivers/reset/Makefile                         |   2 +-
 drivers/reset/spacemit/Kconfig                 |  15 +++
 drivers/reset/spacemit/Makefile                |   3 +-
 drivers/reset/spacemit/reset-spacemit-common.c |  93 ++++++++++++++++++
 drivers/reset/spacemit/reset-spacemit-common.h |  40 ++++++++
 drivers/reset/spacemit/reset-spacemit-k1.c     | 128 ++-----------------------
 8 files changed, 163 insertions(+), 120 deletions(-)

diff --git a/drivers/clk/spacemit/Kconfig b/drivers/clk/spacemit/Kconfig
index b22f65f2547..c305f433871 100644
--- a/drivers/clk/spacemit/Kconfig
+++ b/drivers/clk/spacemit/Kconfig
@@ -16,6 +16,7 @@ if CLK_SPACEMIT
 config CLK_SPACEMIT_K1
 	bool "SpacemiT K1 clock support"
 	select CLK_CCF
+	select RESET_SPACEMIT_K1
 	help
 	  This enables support clock driver for Spacemit K1 SoC.
 	  It's based on Common Clock Framework.
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index db764ed5ace..ad61ebf344a 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -280,4 +280,5 @@ config RESET_RZG2L_USBPHY_CTRL
 	  SoC.
 
 source "drivers/reset/stm32/Kconfig"
+source "drivers/reset/spacemit/Kconfig"
 endmenu
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 384f4336331..959aafe4d70 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -37,7 +37,7 @@ obj-$(CONFIG_RESET_DRA7) += reset-dra7.o
 obj-$(CONFIG_RESET_AT91) += reset-at91.o
 obj-$(CONFIG_$(PHASE_)RESET_JH7110) += reset-jh7110.o
 obj-$(CONFIG_RESET_RZG2L_USBPHY_CTRL) += reset-rzg2l-usbphy-ctrl.o
-obj-$(CONFIG_CLK_SPACEMIT_K1) += spacemit/
+obj-$(CONFIG_RESET_SPACEMIT_COMMON) += spacemit/
 
 obj-$(CONFIG_ARCH_STM32) += stm32/
 obj-$(CONFIG_ARCH_STM32MP) += stm32/
diff --git a/drivers/reset/spacemit/Kconfig b/drivers/reset/spacemit/Kconfig
new file mode 100644
index 00000000000..20e4cc6e4d8
--- /dev/null
+++ b/drivers/reset/spacemit/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config RESET_SPACEMIT_COMMON
+	bool
+	select DM_RESET
+	help
+	  Common reset controller infrastructure for SpacemiT SoCs.
+	  Shared by the K1 and K3 reset drivers.
+
+config RESET_SPACEMIT_K1
+	bool "SpacemiT K1 reset support"
+	select RESET_SPACEMIT_COMMON
+	help
+	  Reset controller for SpacemiT K1 (MPMU/APBC/APMU/APBC2).
+	  Bound from the K1 CCU/syscon devices.
diff --git a/drivers/reset/spacemit/Makefile b/drivers/reset/spacemit/Makefile
index 16722c68954..56f9fd1ab20 100644
--- a/drivers/reset/spacemit/Makefile
+++ b/drivers/reset/spacemit/Makefile
@@ -2,4 +2,5 @@
 #
 # SpacemiT reset drivers
 
-obj-y += reset-spacemit-k1.o
+obj-$(CONFIG_RESET_SPACEMIT_COMMON)	+= reset-spacemit-common.o
+obj-$(CONFIG_RESET_SPACEMIT_K1)		+= reset-spacemit-k1.o
diff --git a/drivers/reset/spacemit/reset-spacemit-common.c b/drivers/reset/spacemit/reset-spacemit-common.c
new file mode 100644
index 00000000000..34ed0862b9c
--- /dev/null
+++ b/drivers/reset/spacemit/reset-spacemit-common.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SpacemiT reset controller — common implementation (U-Boot)
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <malloc.h>
+#include <reset-uclass.h>
+
+#include "reset-spacemit-common.h"
+
+static int spacemit_reset_xfer(struct reset_ctl *rst, bool assert)
+{
+	struct spacemit_reset_priv *priv = dev_get_priv(rst->dev);
+	const struct spacemit_reset_data *e;
+	u32 v;
+
+	if (rst->id >= priv->table_size)
+		return -EINVAL;
+
+	e = &priv->table[rst->id];
+	if (e->assert_mask == 0 && e->deassert_mask == 0)
+		return -EINVAL;
+
+	v = readl(priv->base + e->offset);
+	v &= ~(e->assert_mask | e->deassert_mask);
+	v |= assert ? e->assert_mask : e->deassert_mask;
+	writel(v, priv->base + e->offset);
+
+	return 0;
+}
+
+static int spacemit_reset_assert(struct reset_ctl *rst)
+{
+	return spacemit_reset_xfer(rst, true);
+}
+
+static int spacemit_reset_deassert(struct reset_ctl *rst)
+{
+	return spacemit_reset_xfer(rst, false);
+}
+
+static int spacemit_reset_request(struct reset_ctl *rst)
+{
+	struct spacemit_reset_priv *priv = dev_get_priv(rst->dev);
+
+	return rst->id < priv->table_size ? 0 : -EINVAL;
+}
+
+const struct reset_ops spacemit_reset_ops = {
+	.request	= spacemit_reset_request,
+	.rst_assert	= spacemit_reset_assert,
+	.rst_deassert	= spacemit_reset_deassert,
+};
+
+int spacemit_reset_probe(struct udevice *dev)
+{
+	struct spacemit_reset_priv *priv = dev_get_priv(dev);
+
+	priv->base = (void __iomem *)dev_remap_addr(dev);
+	if (!priv->base)
+		return -ENODEV;
+
+	return 0;
+}
+
+int spacemit_reset_bind(struct udevice *parent, const char *drv_name,
+			const struct spacemit_reset_data *table,
+			size_t table_size)
+{
+	struct spacemit_reset_priv *priv;
+	struct udevice *rst_dev;
+	int ret;
+
+	ret = device_bind_driver_to_node(parent, drv_name, "reset",
+					 dev_ofnode(parent), &rst_dev);
+	if (ret)
+		return ret;
+
+	priv = malloc(sizeof(*priv));
+	if (!priv) {
+		device_unbind(rst_dev);
+		return -ENOMEM;
+	}
+	priv->table = table;
+	priv->table_size = table_size;
+	dev_set_priv(rst_dev, priv);
+
+	return 0;
+}
diff --git a/drivers/reset/spacemit/reset-spacemit-common.h b/drivers/reset/spacemit/reset-spacemit-common.h
new file mode 100644
index 00000000000..cde52b3fc1d
--- /dev/null
+++ b/drivers/reset/spacemit/reset-spacemit-common.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * SpacemiT reset controller — common definitions (U-Boot)
+ */
+
+#ifndef _RESET_SPACEMIT_COMMON_H_
+#define _RESET_SPACEMIT_COMMON_H_
+
+#include <linux/types.h>
+
+struct udevice;
+struct reset_ops;
+
+struct spacemit_reset_data {
+	u32 offset;
+	u32 assert_mask;
+	u32 deassert_mask;
+};
+
+struct spacemit_reset_priv {
+	void *base;
+	const struct spacemit_reset_data *table;
+	size_t table_size;
+};
+
+#define RESET_DATA(_offset, _assert_mask, _deassert_mask)	\
+	{							\
+		.offset		= (_offset),			\
+		.assert_mask	= (_assert_mask),		\
+		.deassert_mask	= (_deassert_mask),		\
+	}
+
+extern const struct reset_ops spacemit_reset_ops;
+
+int spacemit_reset_probe(struct udevice *dev);
+int spacemit_reset_bind(struct udevice *parent, const char *drv_name,
+			const struct spacemit_reset_data *table,
+			size_t table_size);
+
+#endif /* _RESET_SPACEMIT_COMMON_H_ */
diff --git a/drivers/reset/spacemit/reset-spacemit-k1.c b/drivers/reset/spacemit/reset-spacemit-k1.c
index 129e1cc96f1..75000ff64e0 100644
--- a/drivers/reset/spacemit/reset-spacemit-k1.c
+++ b/drivers/reset/spacemit/reset-spacemit-k1.c
@@ -7,46 +7,19 @@
  * Copyright (C) 2026 RISCstar Ltd.
  */
 
-#include <asm/io.h>
 #include <dm.h>
-#include <dm/device-internal.h>
-#include <dm/lists.h>
 #include <dt-bindings/clock/spacemit,k1-syscon.h>
 #include <linux/bitops.h>
-#include <malloc.h>
-#include <reset-uclass.h>
 #include <soc/spacemit/k1-reset.h>
 #include <soc/spacemit/k1-syscon.h>
 
-/* ===================================================================
- * Per-syscon reset signal tables.
- *
- * Indexed by the kernel-side per-syscon-local IDs from
- * <dt-bindings/clock/spacemit,k1-syscon.h>. Each entry is
- * (offset, assert_mask, deassert_mask): bits in assert_mask are set
- * when the reset line is asserted; bits in deassert_mask are set when
- * deasserted; the union (assert_mask | deassert_mask) is the set of
- * bits the controller will overwrite on each transition.
- *
- * Layout mirrors the kernel-side K1 reset driver.
- * ===================================================================
- */
-
-struct spacemit_k1_reset_data {
-	u32 offset;
-	u32 assert_mask;
-	u32 deassert_mask;
-};
+#include "reset-spacemit-common.h"
 
-#define RESET_DATA(o, a, d) {					\
-	.offset = (o), .assert_mask = (a), .deassert_mask = (d)	\
-}
-
-static const struct spacemit_k1_reset_data k1_mpmu_resets[] = {
+static const struct spacemit_reset_data k1_mpmu_resets[] = {
 	[RESET_WDT]	= RESET_DATA(MPMU_WDTPCR,		BIT(2), 0),
 };
 
-static const struct spacemit_k1_reset_data k1_apbc_resets[] = {
+static const struct spacemit_reset_data k1_apbc_resets[] = {
 	[RESET_UART0]	= RESET_DATA(APBC_UART1_CLK_RST,	BIT(2), 0),
 	[RESET_UART2]	= RESET_DATA(APBC_UART2_CLK_RST,	BIT(2), 0),
 	[RESET_UART3]	= RESET_DATA(APBC_UART3_CLK_RST,	BIT(2), 0),
@@ -100,7 +73,7 @@ static const struct spacemit_k1_reset_data k1_apbc_resets[] = {
 	[RESET_CAN0]	= RESET_DATA(APBC_CAN0_CLK_RST,		BIT(2), 0),
 };
 
-static const struct spacemit_k1_reset_data k1_apmu_resets[] = {
+static const struct spacemit_reset_data k1_apmu_resets[] = {
 	[RESET_CCIC_4X]		= RESET_DATA(APMU_CCIC_CLK_RES_CTRL,	0, BIT(1)),
 	[RESET_CCIC1_PHY]	= RESET_DATA(APMU_CCIC_CLK_RES_CTRL,	0, BIT(2)),
 	[RESET_SDH_AXI]		= RESET_DATA(APMU_SDH0_CLK_RES_CTRL,	0, BIT(0)),
@@ -156,7 +129,7 @@ static const struct spacemit_k1_reset_data k1_apmu_resets[] = {
 	[RESET_MC]		= RESET_DATA(APMU_PMUA_MC_CTRL,		0, BIT(0)),
 };
 
-static const struct spacemit_k1_reset_data k1_apbc2_resets[] = {
+static const struct spacemit_reset_data k1_apbc2_resets[] = {
 	[RESET_APBC2_UART1]	= RESET_DATA(APBC2_UART1_CLK_RST,	BIT(2), 0),
 	[RESET_APBC2_SSP2]	= RESET_DATA(APBC2_SSP2_CLK_RST,	BIT(2), 0),
 	[RESET_APBC2_TWSI3]	= RESET_DATA(APBC2_TWSI3_CLK_RST,	BIT(2), 0),
@@ -166,89 +139,22 @@ static const struct spacemit_k1_reset_data k1_apbc2_resets[] = {
 	[RESET_APBC2_GPIO]	= RESET_DATA(APBC2_GPIO_CLK_RST,	BIT(2), 0),
 };
 
-/* ===================================================================
- * Driver
- * ===================================================================
- */
-
-struct spacemit_k1_reset_priv {
-	void __iomem *base;
-	const struct spacemit_k1_reset_data *table;
-	size_t table_size;
-};
-
-static int spacemit_k1_reset_xfer(struct reset_ctl *rst, bool assert)
-{
-	struct spacemit_k1_reset_priv *priv = dev_get_priv(rst->dev);
-	const struct spacemit_k1_reset_data *e;
-	u32 v;
-
-	if (rst->id >= priv->table_size)
-		return -EINVAL;
-
-	e = &priv->table[rst->id];
-	if (e->assert_mask == 0 && e->deassert_mask == 0)
-		return -EINVAL;	/* not owned by this syscon */
-
-	v = readl(priv->base + e->offset);
-	v &= ~(e->assert_mask | e->deassert_mask);
-	v |= assert ? e->assert_mask : e->deassert_mask;
-	writel(v, priv->base + e->offset);
-
-	return 0;
-}
-
-static int spacemit_k1_reset_assert(struct reset_ctl *rst)
-{
-	return spacemit_k1_reset_xfer(rst, true);
-}
-
-static int spacemit_k1_reset_deassert(struct reset_ctl *rst)
-{
-	return spacemit_k1_reset_xfer(rst, false);
-}
-
-static int spacemit_k1_reset_request(struct reset_ctl *rst)
-{
-	struct spacemit_k1_reset_priv *priv = dev_get_priv(rst->dev);
-
-	return rst->id < priv->table_size ? 0 : -EINVAL;
-}
-
-static const struct reset_ops spacemit_k1_reset_ops = {
-	.request	= spacemit_k1_reset_request,
-	.rst_assert	= spacemit_k1_reset_assert,
-	.rst_deassert	= spacemit_k1_reset_deassert,
-};
-
-static int spacemit_k1_reset_probe(struct udevice *dev)
-{
-	struct spacemit_k1_reset_priv *priv = dev_get_priv(dev);
 
-	priv->base = (void __iomem *)dev_remap_addr(dev);
-	if (!priv->base)
-		return -ENODEV;
-
-	return 0;
-}
 
 U_BOOT_DRIVER(spacemit_k1_reset) = {
 	.name		= "spacemit_k1_reset",
 	.id		= UCLASS_RESET,
-	.ops		= &spacemit_k1_reset_ops,
-	.probe		= spacemit_k1_reset_probe,
-	.priv_auto	= sizeof(struct spacemit_k1_reset_priv),
+	.ops		= &spacemit_reset_ops,
+	.probe		= spacemit_reset_probe,
+	.priv_auto	= sizeof(struct spacemit_reset_priv),
 	.flags		= DM_FLAG_PRE_RELOC,
 };
 
 int spacemit_k1_reset_bind(struct udevice *parent,
 			   enum spacemit_k1_reset_syscon syscon)
 {
-	struct spacemit_k1_reset_priv *priv;
-	struct udevice *rst_dev;
-	const struct spacemit_k1_reset_data *table;
+	const struct spacemit_reset_data *table;
 	size_t table_size;
-	int ret;
 
 	switch (syscon) {
 	case SPACEMIT_K1_RESET_MPMU:
@@ -271,19 +177,5 @@ int spacemit_k1_reset_bind(struct udevice *parent,
 		return -EINVAL;
 	}
 
-	ret = device_bind_driver_to_node(parent, "spacemit_k1_reset", "reset",
-					 dev_ofnode(parent), &rst_dev);
-	if (ret)
-		return ret;
-
-	priv = malloc(sizeof(*priv));
-	if (!priv) {
-		device_unbind(rst_dev);
-		return -ENOMEM;
-	}
-	priv->table = table;
-	priv->table_size = table_size;
-	dev_set_priv(rst_dev, priv);
-
-	return 0;
+	return spacemit_reset_bind(parent, "spacemit_k1_reset", table, table_size);
 }

-- 
2.55.0

