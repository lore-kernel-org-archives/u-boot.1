Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B190FCD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87E99848A9;
	Mon,  1 Jun 2026 14:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="XWQFuOJ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 454F7846D3; Mon,  1 Jun 2026 10:04:00 +0200 (CEST)
Received: from mail-106116.protonmail.ch (mail-106116.protonmail.ch
 [79.135.106.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E086846F8
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 10:03:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780301037; x=1780560237;
 bh=2YBakumJvbj+1IlnuFm20S/8HLSTRp0C+Q0LGNm6dBQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=XWQFuOJ8jSP5yj0uT9poh92rH34Hi5be52sEAPiyUEyKgC7TRtBy3dxLUNJDbcPxJ
 /sNGXLhJGjKleCLKGHe1/r/Qha8OKia+Gxi9SER0Km3RDb5Xh7yU4VNqMuLeMqrfkN
 d4z2txC3iP0zALqhm1+gSaBhj4cGtqo40aI6vsMCFRDF/JtHW6poxLpnnUH3jAsaV+
 cBDjT1pG2MyyTEiggESPPlUPAUJlZTA5QFFu9hTwkJh02mATN9YD7r3pPO1z+MFice
 6FUaZGyGhHKvtF9EFz1VjpfyoT24LGLllAKu+wGOlO3QJXd1nudfh4CjuUMhBmHp1h
 z9eGR3KS/anpQ==
Date: Mon, 01 Jun 2026 08:03:47 +0000
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
From: Sam Day <me@samcday.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Eugen Hristev <ehristev@kernel.org>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Aswin Murugan
 <aswin.murugan@oss.qualcomm.com>, David Wronek <david.wronek@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Lukasz Majewski <lukma@denx.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Jens Reidel <adrian@mainlining.org>, Sam Day <me@samcday.com>
Subject: [PATCH 02/16] timer: Qualcomm KPSS timer support
Message-ID: <20260601-qcom-armv7-v1-2-c4b7f7aae1eb@samcday.com>
In-Reply-To: <20260601-qcom-armv7-v1-0-c4b7f7aae1eb@samcday.com>
References: <20260601-qcom-armv7-v1-0-c4b7f7aae1eb@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 34cd794f48cd205b5f271c19d51b145482688769
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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

SoCs like MSM8960 and APQ8064 do not support the generic ARM CP15 timer.
Instead KPSS must be used as a timer source.

Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/timer/Kconfig           |  7 +++
 drivers/timer/Makefile          |  1 +
 drivers/timer/qcom-kpss-timer.c | 98 +++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 106 insertions(+)

diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
index 500a25638a9..8de8ce6c14a 100644
--- a/drivers/timer/Kconfig
+++ b/drivers/timer/Kconfig
@@ -223,6 +223,13 @@ config ORION_TIMER
 =09  Select this to enable an timer for Orion and Armada devices
 =09  like Armada XP etc.
=20
+config QCOM_KPSS_TIMER
+=09bool "Qualcomm KPSS/SCSS timer support"
+=09depends on TIMER && ARM
+=09help
+=09  Select this to enable the Qualcomm KPSS/SCSS digital general
+=09  purpose timer used on older 32-bit Snapdragon SoCs.
+
 config RISCV_TIMER
 =09bool "RISC-V timer support"
 =09depends on TIMER && RISCV
diff --git a/drivers/timer/Makefile b/drivers/timer/Makefile
index d8b3f2b65d4..3bd167d73c2 100644
--- a/drivers/timer/Makefile
+++ b/drivers/timer/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_NOMADIK_MTU_TIMER)=09+=3D nomadik-mtu-timer.=
o
 obj-$(CONFIG_NPCM_TIMER)        +=3D npcm-timer.o
 obj-$(CONFIG_OMAP_TIMER)=09+=3D omap-timer.o
 obj-$(CONFIG_ORION_TIMER)=09+=3D orion-timer.o
+obj-$(CONFIG_QCOM_KPSS_TIMER)=09+=3D qcom-kpss-timer.o
 obj-$(CONFIG_RENESAS_OSTM_TIMER) +=3D ostm_timer.o
 obj-$(CONFIG_RISCV_TIMER) +=3D riscv_timer.o
 obj-$(CONFIG_ROCKCHIP_TIMER) +=3D rockchip_timer.o
diff --git a/drivers/timer/qcom-kpss-timer.c b/drivers/timer/qcom-kpss-time=
r.c
new file mode 100644
index 00000000000..543fb2fa44f
--- /dev/null
+++ b/drivers/timer/qcom-kpss-timer.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm KPSS/SCSS timer driver
+ * Adapted from Linux drivers/clocksource/timer-qcom.c
+ *
+ * Copyright (C) 2007 Google, Inc.
+ * Copyright (c) 2009-2012,2014, The Linux Foundation. All rights reserved=
.
+ */
+
+#include <dm.h>
+#include <div64.h>
+#include <errno.h>
+#include <timer.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define TIMER_COUNT_VAL   0x04
+#define TIMER_ENABLE      0x08
+#define TIMER_ENABLE_EN   BIT(0)
+#define DGT_CLK_CTL       0x10
+#define DGT_CLK_CTL_DIV_4 0x3
+
+#define QCOM_TIMER_DGT_OFFSET   0x24
+#define QCOM_TIMER_DGT_RATE_DIV 4
+
+struct qcom_kpss_timer_priv {
+=09void __iomem *source_base;
+=09void __iomem *counter;
+};
+
+static u64 notrace qcom_kpss_timer_get_count(struct udevice *dev)
+{
+=09struct qcom_kpss_timer_priv *priv =3D dev_get_priv(dev);
+
+=09return timer_conv_64(readl(priv->counter));
+}
+
+static int qcom_kpss_timer_probe(struct udevice *dev)
+{
+=09struct timer_dev_priv *uc_priv =3D dev_get_uclass_priv(dev);
+=09struct qcom_kpss_timer_priv *priv =3D dev_get_priv(dev);
+=09u32 rate;
+=09int ret;
+
+=09ret =3D dev_read_u32(dev, "clock-frequency", &rate);
+=09if (ret)
+=09=09return ret;
+
+=09uc_priv->clock_rate =3D rate / QCOM_TIMER_DGT_RATE_DIV;
+
+=09writel(DGT_CLK_CTL_DIV_4, priv->source_base + DGT_CLK_CTL);
+=09writel(TIMER_ENABLE_EN, priv->source_base + TIMER_ENABLE);
+
+=09return 0;
+}
+
+static int qcom_kpss_timer_of_to_plat(struct udevice *dev)
+{
+=09struct qcom_kpss_timer_priv *priv =3D dev_get_priv(dev);
+=09phys_addr_t base;
+=09phys_addr_t source_base;
+=09u32 cpu_offset;
+
+=09base =3D dev_read_addr(dev);
+=09if (base =3D=3D FDT_ADDR_T_NONE)
+=09=09return -EINVAL;
+
+=09cpu_offset =3D dev_read_u32_default(dev, "cpu-offset", 0);
+=09source_base =3D base + cpu_offset + QCOM_TIMER_DGT_OFFSET;
+=09priv->source_base =3D map_physmem(source_base, 0x100, MAP_NOCACHE);
+=09priv->counter =3D priv->source_base + TIMER_COUNT_VAL;
+
+=09return 0;
+}
+
+static const struct timer_ops qcom_kpss_timer_ops =3D {
+=09.get_count =3D qcom_kpss_timer_get_count,
+};
+
+static const struct udevice_id qcom_kpss_timer_ids[] =3D {
+=09{ .compatible =3D "qcom,kpss-timer" },
+=09{ .compatible =3D "qcom,scss-timer" },
+=09{ }
+};
+
+U_BOOT_DRIVER(qcom_kpss_timer) =3D {
+=09.name=09=09=3D "qcom_kpss_timer",
+=09.id=09=09=3D UCLASS_TIMER,
+=09.of_match=09=3D qcom_kpss_timer_ids,
+=09.of_to_plat=09=3D qcom_kpss_timer_of_to_plat,
+=09.probe=09=09=3D qcom_kpss_timer_probe,
+=09.ops=09=09=3D &qcom_kpss_timer_ops,
+=09.priv_auto=09=3D sizeof(struct qcom_kpss_timer_priv),
+=09.flags=09=09=3D DM_FLAG_PRE_RELOC,
+};

--=20
2.54.0


