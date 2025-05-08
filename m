Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54625C3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 12:41:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34B9B8288D;
	Fri,  9 May 2025 14:40:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="FY7L/CCa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 697D1829CD; Fri,  9 May 2025 00:23:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA9218295C
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 00:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=smelamud@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746742995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=+SprNmJ39BmJdY1vI/LQmkiny0AJGi6EXnzgT43o9Ek=;
 b=FY7L/CCaruUK45w3DwiPl+X0hvwsaDskQGgaIzyWeHFrbyIXYk7OLh9IxuiSvhqIQ7D0G4
 dZr6I21AMU+C4nZb2DnSeTW+GGHpgdZwtHKmwPHikzs+cYhXLI571IDF8a3Kttldrh2BO6
 eZVpatd+cBTgH/YFeoMpT7tfgWy26I8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-hybH1ldNMm67dXuH4ZCl7A-1; Thu, 08 May 2025 18:23:14 -0400
X-MC-Unique: hybH1ldNMm67dXuH4ZCl7A-1
X-Mimecast-MFC-AGG-ID: hybH1ldNMm67dXuH4ZCl7A_1746742993
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5fbf5fce18dso1526109a12.0
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 15:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746742992; x=1747347792;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+SprNmJ39BmJdY1vI/LQmkiny0AJGi6EXnzgT43o9Ek=;
 b=h4UDYQYl7ksGlWnfZC79ZGb4RluPVJXOgQqshfDvNNgU8har/nckRsS77eYnQBQU7k
 LCdjFKZOPalNGDwbr9TAX7i41CJdiOjBjTLiWXjPHqmZ+qDWEf01+i3cs0JB6vAqnE2+
 ibh+QcOn1I6qODgc+Ne6Cuqa+F1H7y6O+DSoZSKW/DZmQLzxUTjI+c6m2XiWPQhe2i/D
 xxYds0hdtK+WhM05fGYROqi2cSmymvq3/77YO1VUplhBdRlYDnBlGXMK44rB0MLQIX5v
 Q8H4+kmzMxabUh7TzzWEeCuw+2Cez27OeKnt9GV4vUO5H8Bo7owBXmNlvl+cBYRWyYB/
 P1BQ==
X-Gm-Message-State: AOJu0Yz1kDAzt26D6cj1EYt/bzCsMTelb3QtsVvXMC0ePgwUgZGn55vH
 L7A+0mrlkWC2IQwMhdwRDtvl843LK9CBcfbNyyaj6lodzCgRNnJK759ZX6E2NYcAyVl6FoSfZjI
 xMnBRAcSpo8ta7flrj0I6Zj6J5UFXzHHy0OVMjIukjIPS1FKa7MGvDp5E5cKtQ4xGNK6YnTzw3/
 FGEHt9MC43/SXxYi29DkYWtM+iw7b3xoC8iZsc
X-Gm-Gg: ASbGncunUjsMSo+AkXXY/UlG2jV4EmiCTLR1khBICkrNgBgjPg6GDNGJnW2dmq/kakx
 zpbNUWKrFDAuGwnD/cDq+ybdFay2peLwWYmN3VVQf8wMqESqKdrLBmbue6qyGW9td5BUW
X-Received: by 2002:a05:6402:5241:b0:5f6:59e5:5c6e with SMTP id
 4fb4d7f45d1cf-5fca07e9956mr821363a12.26.1746742991844; 
 Thu, 08 May 2025 15:23:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPbqQ72m7cpcCeEgKgWtkWyirtc5JKf4Ww6yE9n6Ng4suqvf044b2L9fJMeN7sCAT3G80xRKUUXDgU4KSopU8=
X-Received: by 2002:a05:6402:5241:b0:5f6:59e5:5c6e with SMTP id
 4fb4d7f45d1cf-5fca07e9956mr821351a12.26.1746742991402; Thu, 08 May 2025
 15:23:11 -0700 (PDT)
MIME-Version: 1.0
From: Shmuel Melamud <smelamud@redhat.com>
Date: Fri, 9 May 2025 01:23:00 +0300
X-Gm-Features: ATxdqUGKhjNQCwQvSdR_INu9iL_eZJVf6waYLikq7pWknD_LMJK317-JaCKyFtI
Message-ID: <CAMFVLy31c0ypTGpKx3ZE1kmjN_HpqCJh-GHBC+JAmPLMdCs6uQ@mail.gmail.com>
Subject: [PATCH] renesas: Renesas R-Car Gen4 watchdog driver
To: u-boot@lists.denx.de
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Marek Vasut <marex@denx.de>,
 Stefan Roese <sr@denx.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AExsQf2eLdVnw807ptF1_PAapxFdTCEjx7flMYxA97M_1746742993
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 09 May 2025 14:40:00 +0200
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

Add support of Renesas R-Car Gen4 watchdog timer. Timeouts up to
8184.0s are supported (CKS1 register is not involved). The watchdog
uses the clock type CLK_TYPE_GEN4_MDSEL, so handling of this constant
is added to gen3_clk_get_rate64() function.

Signed-off-by: Shmuel Leib Melamud <smelamud@redhat.com>
---
 drivers/clk/renesas/clk-rcar-gen3.c |   4 +-
 drivers/watchdog/Kconfig            |   8 ++
 drivers/watchdog/Makefile           |   1 +
 drivers/watchdog/renesas_wdt.c      | 172 ++++++++++++++++++++++++++++
 4 files changed, 184 insertions(+), 1 deletion(-)
 create mode 100644 drivers/watchdog/renesas_wdt.c

diff --git a/drivers/clk/renesas/clk-rcar-gen3.c
b/drivers/clk/renesas/clk-rcar-gen3.c
index 375cc4a4930..5745acf4023 100644
--- a/drivers/clk/renesas/clk-rcar-gen3.c
+++ b/drivers/clk/renesas/clk-rcar-gen3.c
@@ -68,7 +68,7 @@ static int gen3_clk_get_parent(struct gen3_clk_priv
*priv, struct clk *clk,
         if (ret)
             return ret;

-        if (core->type == CLK_TYPE_GEN3_MDSEL) {
+        if (core->type == CLK_TYPE_GEN3_MDSEL || core->type ==
CLK_TYPE_GEN4_MDSEL) {
             shift = priv->cpg_mode & BIT(core->offset) ? 0 : 16;
             parent->dev = clk->dev;
             parent->id = core->parent >> shift;
@@ -318,6 +318,8 @@ static u64 gen3_clk_get_rate64(struct clk *clk)
                         "FIXED");

     case CLK_TYPE_GEN3_MDSEL:
+        fallthrough;
+    case CLK_TYPE_GEN4_MDSEL:
         shift = priv->cpg_mode & BIT(core->offset) ? 0 : 16;
         div = (core->div >> shift) & 0xffff;
         rate = gen3_clk_get_rate64(&parent) / div;
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 1bb67f50352..a0f2948335f 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -335,6 +335,14 @@ config WDT_K3_RTI_FW_FILE

 endif

+config WDT_RENESAS
+    bool "Renesas watchdog timer support"
+    depends on WDT && R8A779F0
+    select CLK
+    select CLK_RENESAS
+    help
+      Enables Renesas SoC R8A779F0 watchdog timer support.
+
 config WDT_SANDBOX
     bool "Enable Watchdog Timer support for Sandbox"
     depends on SANDBOX && WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index e6bd4c587af..c4467d6e126 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_WDT_MTK) += mtk_wdt.o
 obj-$(CONFIG_WDT_NPCM) += npcm_wdt.o
 obj-$(CONFIG_WDT_OCTEONTX) += octeontx_wdt.o
 obj-$(CONFIG_WDT_OMAP3) += omap_wdt.o
+obj-$(CONFIG_WDT_RENESAS) += renesas_wdt.o
 obj-$(CONFIG_WDT_SBSA) += sbsa_gwdt.o
 obj-$(CONFIG_WDT_K3_RTI) += rti_wdt.o
 obj-$(CONFIG_WDT_SIEMENS_PMIC) += siemens_pmic_wdt.o
diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
new file mode 100644
index 00000000000..97550794a2e
--- /dev/null
+++ b/drivers/watchdog/renesas_wdt.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2025 Red Hat, Inc., Shmuel Leib Melamud <smelamud@redhat.com>
+
+#include <clk.h>
+#include <dm.h>
+#include <wdt.h>
+#include <asm/io.h>
+#include <dm/device_compat.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+
+#define usleep_range(a, b) udelay((b))
+
+struct renesas_wdt {
+    u32 cnt;
+    u32 csra;
+    u32 csrb;
+};
+
+#define RWTCSRA_WOVF    BIT(4)
+#define RWTCSRA_WRFLG    BIT(5)
+#define RWTCSRA_TME        BIT(7)
+
+#define CSR_MASK    0xA5A5A500
+#define CNT_MASK    0x5A5A0000
+
+/*
+ * In probe, clk_rate is checked to be not more than 16 bit * biggest clock
+ * divider (12 bits). d is only a factor to fully utilize the WDT counter and
+ * will not exceed its 16 bits. Thus, no overflow, we stay below 32 bits.
+ */
+#define MUL_BY_CLKS_PER_SEC(p, d) \
+    DIV_ROUND_UP((d) * (p)->clk_rate, clk_divs[(p)->cks])
+
+/* d is 16 bit, clk_divs 12 bit -> no 32 bit overflow */
+#define DIV_BY_CLKS_PER_SEC(p, d) ((d) * clk_divs[(p)->cks] / (p)->clk_rate)
+
+static const unsigned int clk_divs[] = { 1, 4, 16, 32, 64, 128, 1024, 4096 };
+
+struct renesas_wdt_priv {
+    struct renesas_wdt __iomem *wdt;
+    unsigned long clk_rate;
+    u8 cks;
+    struct clk clk;
+};
+
+static void rwdt_wait_cycles(struct renesas_wdt_priv *priv, unsigned
int cycles)
+{
+    unsigned int delay;
+
+    delay = DIV_ROUND_UP(cycles * 1000000, priv->clk_rate);
+
+    usleep_range(delay, 2 * delay);
+}
+
+static int renesas_wdt_start(struct udevice *dev, u64 timeout, ulong flags)
+{
+    struct renesas_wdt_priv *priv = dev_get_priv(dev);
+    u64 max_timeout;
+    u8 val;
+
+    max_timeout = DIV_BY_CLKS_PER_SEC(priv, 65536);
+    timeout = min(max_timeout, timeout / 1000);
+
+    /* Stop the timer before we modify any register */
+    val = readb_relaxed(&priv->wdt->csra) & ~RWTCSRA_TME;
+    writel_relaxed(val | CSR_MASK, &priv->wdt->csra);
+    /* Delay 2 cycles before setting watchdog counter */
+    rwdt_wait_cycles(priv, 2);
+
+    while (readb_relaxed(&priv->wdt->csra) & RWTCSRA_WRFLG)
+        cpu_relax();
+
+    writel_relaxed((65536 - MUL_BY_CLKS_PER_SEC(priv, timeout)) | CNT_MASK,
+               &priv->wdt->cnt);
+
+    writel_relaxed(priv->cks | RWTCSRA_TME | CSR_MASK, &priv->wdt->csra);
+
+    return 0;
+}
+
+static int renesas_wdt_stop(struct udevice *dev)
+{
+    struct renesas_wdt_priv *priv = dev_get_priv(dev);
+
+    writel_relaxed(priv->cks | CSR_MASK, &priv->wdt->csra);
+
+    return 0;
+}
+
+static int renesas_wdt_reset(struct udevice *dev)
+{
+    struct renesas_wdt_priv *priv = dev_get_priv(dev);
+    u8 val;
+
+    /* Stop the timer before we modify any register */
+    val = readb_relaxed(&priv->wdt->csra) & ~RWTCSRA_TME;
+    writel_relaxed(val | CSR_MASK, &priv->wdt->csra);
+    /* Delay 2 cycles before setting watchdog counter */
+    rwdt_wait_cycles(priv, 2);
+
+    writel_relaxed(0xffff | CNT_MASK, &priv->wdt->cnt);
+    /* smallest divider to reboot soon */
+    writel_relaxed(0 | CSR_MASK, &priv->wdt->csra);
+
+    readb_poll_timeout(&priv->wdt->csra, val, !(val & RWTCSRA_WRFLG), 100);
+
+    writel_relaxed(RWTCSRA_TME | CSR_MASK, &priv->wdt->csra);
+
+    /* wait 2 cycles, so watchdog will trigger */
+    rwdt_wait_cycles(priv, 2);
+
+    return 0;
+}
+
+static int renesas_wdt_probe(struct udevice *dev)
+{
+    struct renesas_wdt_priv *priv = dev_get_priv(dev);
+    unsigned long clks_per_sec;
+    int ret, i;
+
+    priv->wdt = dev_remap_addr(dev);
+    if (!priv->wdt)
+        return -EINVAL;
+
+    ret = clk_get_by_index(dev, 0, &priv->clk);
+    if (ret < 0)
+        return ret;
+
+    ret = clk_enable(&priv->clk);
+    if (ret)
+        return ret;
+
+    priv->clk_rate = clk_get_rate(&priv->clk);
+    if (!priv->clk_rate)
+        return -ENOENT;
+
+    for (i = ARRAY_SIZE(clk_divs) - 1; i >= 0; i--) {
+        clks_per_sec = priv->clk_rate / clk_divs[i];
+        if (clks_per_sec && clks_per_sec < 65536) {
+            priv->cks = i;
+            break;
+        }
+    }
+
+    /* can't find a suitable clock divider */
+    if (i < 0)
+        return -ERANGE;
+
+    return 0;
+}
+
+static const struct wdt_ops renesas_wdt_ops = {
+    .start = renesas_wdt_start,
+    .reset = renesas_wdt_reset,
+    .stop = renesas_wdt_stop,
+};
+
+static const struct udevice_id renesas_wdt_ids[] = {
+    { .compatible = "renesas,r8a779f0-wdt" },
+    { .compatible = "renesas,rcar-gen4-wdt" },
+    {}
+};
+
+U_BOOT_DRIVER(wdt_renesas) = {
+    .name = "wdt_renesas",
+    .id = UCLASS_WDT,
+    .of_match = renesas_wdt_ids,
+    .ops = &renesas_wdt_ops,
+    .probe    = renesas_wdt_probe,
+    .priv_auto = sizeof(struct renesas_wdt_priv),
+};
-- 
2.49.0

