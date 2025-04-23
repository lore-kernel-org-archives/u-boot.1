Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD05C369C2
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 02:19:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84D7280F03;
	Wed, 23 Apr 2025 04:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=paulsajna.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=paulsajna.com header.i=@paulsajna.com header.b="iFQWPf0H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A76F80F6B; Wed, 23 Apr 2025 04:19:49 +0200 (CEST)
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch
 [79.135.106.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE46E805D7
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 04:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=paulsajna.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hello@paulsajna.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paulsajna.com;
 s=protonmail; t=1745374785; x=1745633985;
 bh=EQVY9HACiJa/+K7ZryglMK0KcEYLxfn6/gC5nHGB6ns=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=iFQWPf0HdNvH9Fio0WOtrE3EKVMoKv7zai3GCO92AMMRpjE+TGrBt4kH3Ck31rA4M
 /B8N4VYGjtA9R32dmq3y1VXsQ+HpWxB7RVzV8PQ+PZXPMPvJuyOAnd+QaAAXIfrwxR
 eGCGzEGUYImeLRD5Ebc7vlU2HYPeI6iIQrErWx3fvP56Z6wugg1X8YXEiWJIe+g/JG
 2jQJYUf3iL3McwPCSdvdmfFqfMO6vwUbaRN8LYUDYspjEXM3msbZA8TEtdafHsdTyV
 yWEl+vgkYSRs+Df27eKv3MTNVHadlvDfmX+kjxL6j2sMJsJhC039W2sXrIJf1Hdk7x
 +e73TXnUsSdHg==
Date: Wed, 23 Apr 2025 02:19:39 +0000
To: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>
From: Paul Sajna <hello@paulsajna.com>
Cc: u-boot-qcom@groups.io, Sam Day <me@samcday.com>,
 Paul Sajna <hello@paulsajna.com>
Subject: [PATCH v3] watchdog: qcom: introduce qcom-wdt driver
Message-ID: <20250422-b4-qcom-wdt-v3-1-730d4d5a858d@paulsajna.com>
Feedback-ID: 29073965:user:proton
X-Pm-Message-ID: f45e74759e820bcc711486da1436de7b5e7d9960
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

From: Casey Connolly <casey.connolly@linaro.org>

Some Qualcomm device vendors decide to turn the watchdog on in the
bootloader, resulting in the device being reset if it isn't petted every
~30 seconds. Introduce a driver to keep the watchdog happy and prevent this
annoying behaviour.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Paul Sajna <hello@paulsajna.com>
Co-authored-by: Paul Sajna <hello@paulsajna.com>
Tested-by: Paul Sajna <hello@paulsajna.com>
---
This patch introduces a simple watchdog driver for Qualcomm devices.

Some devices, including one I have been spending a lot of time with,
the LG G7 ThinQ (codename judyln, arch sdm845) will reset within 30
seconds if the watchdog is not serviced.

I have tested this patch from Casey Connolly that is over a year old and ha=
s
not yet been upstreamed, and it is very useful to me. I can hardly use
u-boot on this device without it. I have received Casey's permission to
work on upstreaming this patch.

This is my first contribution to U-Boot, and I am unfamiliar with
mailing list workflows, so please be patient :)
---
Changes in v3:
- Squash commit 1 and 2
- remove duplicated line of code
- Link to v2: https://lore.kernel.org/r/20250421-b4-qcom-wdt-v2-0-b2250efa0=
f39@paulsajna.com

Changes in v2:
- Add watchdog start
- Add watchdog reset
- Remove stop from the probe function
- Use dev_err instead of printf
- Update Casey's name
- Add myself as an author
-=20
- Link to v1: https://lore.kernel.org/r/20250413-b4-qcom-wdt-v1-1-db42cb93d=
ff8@paulsajna.com
---
 configs/qcom_defconfig      |   2 +
 drivers/watchdog/Kconfig    |   7 +++
 drivers/watchdog/Makefile   |   1 +
 drivers/watchdog/qcom-wdt.c | 117 ++++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 127 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 537806450dc4a61d3c617cdd2b0cfb8eab1c343c..0232f6d51c552bd06c8ba72b71e=
db5cb72fe0706 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -144,3 +144,5 @@ CONFIG_VIDEO_FONT_16X32=3Dy
 CONFIG_SYS_WHITE_ON_BLACK=3Dy
 CONFIG_NO_FB_CLEAR=3Dy
 CONFIG_VIDEO_SIMPLE=3Dy
+CONFIG_WDT_QCOM=3Dy
+CONFIG_WDT=3Dy
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 1bb67f5035231df9f6ce01adb08d074855393143..808f4e578e28e7812f93b393a7f=
7d95d9501cdd4 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -335,6 +335,13 @@ config WDT_K3_RTI_FW_FILE
=20
 endif
=20
+config WDT_QCOM
+=09bool "Qualcomm watchdog timer support"
+=09depends on WDT && ARCH_SNAPDRAGON
+=09help
+=09  Select this to enable Qualcomm watchdog timer, which can be found on
+=09  some Qualcomm chips.
+
 config WDT_SANDBOX
 =09bool "Enable Watchdog Timer support for Sandbox"
 =09depends on SANDBOX && WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index e6bd4c587af6133c405dde6dbada8050debc781c..5eaabd4aba58c815de4165f901a=
ecfba0e0da255 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -54,3 +54,4 @@ obj-$(CONFIG_WDT_SUNXI) +=3D sunxi_wdt.o
 obj-$(CONFIG_WDT_TANGIER) +=3D tangier_wdt.o
 obj-$(CONFIG_WDT_XILINX) +=3D xilinx_wwdt.o
 obj-$(CONFIG_WDT_ADI) +=3D adi_wdt.o
+obj-$(CONFIG_WDT_QCOM) +=3D qcom-wdt.o
diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
new file mode 100644
index 0000000000000000000000000000000000000000..3601ba93774730f78574b2fd74b=
8c513e7ce22e1
--- /dev/null
+++ b/drivers/watchdog/qcom-wdt.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2014, The Linux Foundation. All rights reserved.
+ * Copyright (c) Linaro Ltd. 2024
+ *
+ * Authors:
+ *   Casey Connolly <casey.connolly@linaro.org>
+ *   Paul Sajna <hello@paulsajna.com>
+ *
+ * Derived from linux/drivers/watchdog/qcom-wdt.c
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <wdt.h>
+
+#include <asm/io.h>
+
+enum wdt_reg {
+=09WDT_RST,
+=09WDT_EN,
+=09WDT_STS,
+=09WDT_BARK_TIME,
+=09WDT_BITE_TIME,
+};
+
+struct qcom_wdt_match_data {
+=09const u32 *offset;
+};
+
+struct qcom_wdt {
+=09void __iomem *base;
+=09const u32 *layout;
+};
+
+static const u32 reg_offset_data_kpss[] =3D {
+=09[WDT_RST] =3D 0x4,
+=09[WDT_EN] =3D 0x8,
+=09[WDT_STS] =3D 0xC,
+=09[WDT_BARK_TIME] =3D 0x10,
+=09[WDT_BITE_TIME] =3D 0x14,
+};
+
+static const struct qcom_wdt_match_data match_data_kpss =3D {
+=09.offset =3D reg_offset_data_kpss,
+};
+
+static void __iomem *wdt_addr(struct qcom_wdt *wdt, enum wdt_reg reg)
+{
+=09return wdt->base + wdt->layout[reg];
+}
+
+int qcom_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
+{
+=09struct qcom_wdt *wdt =3D dev_get_priv(dev);
+
+=09writel(0, wdt_addr(wdt, WDT_EN));
+=09writel(1, wdt_addr(wdt, WDT_RST));
+=09writel(1, wdt_addr(wdt, WDT_EN));
+=09if (readl(wdt_addr(wdt, WDT_EN)) !=3D 1) {
+=09=09dev_err(dev, "Failed to enable Qualcomm watchdog!\n");
+=09=09return -EIO;
+=09}
+=09return 0;
+}
+
+int qcom_wdt_stop(struct udevice *dev)
+{
+=09struct qcom_wdt *wdt =3D dev_get_priv(dev);
+
+=09writel(0, wdt_addr(wdt, WDT_EN));
+=09if (readl(wdt_addr(wdt, WDT_EN))) {
+=09=09dev_err(dev, "Failed to disable Qualcomm watchdog!\n");
+=09=09return -EIO;
+=09}
+
+=09return 0;
+}
+
+int qcom_wdt_reset(struct udevice *dev)
+{
+=09struct qcom_wdt *wdt =3D dev_get_priv(dev);
+
+=09writel(1, wdt_addr(wdt, WDT_RST));
+=09return 0;
+}
+
+static int qcom_wdt_probe(struct udevice *dev)
+{
+=09struct qcom_wdt *wdt =3D dev_get_priv(dev);
+=09struct qcom_wdt_match_data *data =3D (void *)dev_get_driver_data(dev);
+
+=09wdt->base =3D dev_read_addr_ptr(dev);
+=09wdt->layout =3D data->offset;
+
+=09return 0;
+}
+
+static const struct wdt_ops qcom_wdt_ops =3D {
+=09.start =3D qcom_wdt_start,
+=09.stop =3D qcom_wdt_stop,
+=09.reset =3D qcom_wdt_reset,
+};
+
+static const struct udevice_id qcom_wdt_ids[] =3D {
+=09{ .compatible =3D "qcom,kpss-wdt", .data =3D (ulong)&match_data_kpss },
+=09{}
+};
+
+U_BOOT_DRIVER(qcom_wdt) =3D {
+=09.name =3D "qcom_wdt",
+=09.id =3D UCLASS_WDT,
+=09.of_match =3D qcom_wdt_ids,
+=09.ops =3D &qcom_wdt_ops,
+=09.probe =3D qcom_wdt_probe,
+=09.priv_auto =3D sizeof(struct qcom_wdt),
+};

---
base-commit: 0eebdd17888005751cd77cf3794c5292d36f481a
change-id: 20250413-b4-qcom-wdt-e7b913fc375e

Best regards,
--=20
Paul Sajna <hello@paulsajna.com>


