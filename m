Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E928CC61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 22:50:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B165B607B0;
	Tue, 25 Aug 2026 22:50:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l2ppXq8x5hn0; Tue, 25 Aug 2026 22:50:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787698238;
	bh=qbJQOjqUUfaYs6H+mTRr8nub8ioxXUZ/j5lq66+XLKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OVLtRTgXLL0JnfnJHODP5hq34xd+SyiO2jBTs3ld+ZLJ6aAfNd3IFmLsKHaPf9eNy
	 KE+n4MFF6qt3PQe2FkNrc35s8oStKxuew5I0wz4HIa6c1fQjyFnRgdLK+4KCO8YYt4
	 EMG3nWj4cUNnWWG9SBjfHh/JD/Q7UJhBZW5e6fZby3IexxYoTWl4LEuLxpVFz0IEMr
	 M1P1wCrbGfKt9hP3Fz6ujzqvra1LGsM4ipL/J60oEQv8268PEhPLpyxE9io1mMk3Mr
	 K/eBulwjPAxQz0+aLtbj3iQhELL63vZn02Qm5lQ/ECtiGKwKxQWcKVnd0nNCkuzlT8
	 YCLuuhnAPTm5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19C8A607AB;
	Tue, 25 Aug 2026 22:50:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B2440230
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 98F40400A4
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aYwQiq8t4-tR for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 22:44:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=34.2.90.19;
 helo=sonic.asd.mail.yahoo.com; envelope-from=maskachoska@yahoo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com
 header.a=rsa-sha256 header.s=s2048 header.b=Tyg9oFVL
Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com
 [34.2.90.19]) by smtp2.osuosl.org (Postfix) with ESMTPS id 9242F4008D
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787697862; bh=qbJQOjqUUfaYs6H+mTRr8nub8ioxXUZ/j5lq66+XLKA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=Tyg9oFVLlMrHhev8PMdiHRna81kAiifMzr5X1tcEN6F7zWJNj2qnGy7C/TB3cxKv1PId6zzfBGvi6Scy/q+PlWgHUQx6y4PaaJOQTcxDr+pA0DmXa9Oo3/QjL/7zEua58yQPl2KoXtRokKBqOs3jRln4jAK0UMo6tYW8FMU0NAYbVLuQY3staJdW2kYCTNRnCn7BAB082RmQWqac/Oub39WEYVwQe2eINg0u5My/pRSprsUx/2ZcHtZuwK3Yx/1TWfatKPEsJeC2jURcXTDNEgqAhlX9zC6V0WG+R8eaYM97jhcDtdFVC/ydPnfk6npfOKcpHH4bXDDQ9GVFYYRz1g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787697862; bh=l352TiCZGbi0YUXei5rdnDVJ94oV/GOJ4zQWdjkdoWI=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=LMUUxV2bOhjQAEZzLE4wHa8f1LfSD9qcaSnVHm9XLrZm6HRSgNrjRYdgN62F2s1zOHj8x4wQ+5ihGL/4a9nS0e9xU9XxESI+Ymh2oaWLIkW1cGr4b+HzmBEzI06ACP/GjAbqWmypHsUcFDNgyaZnrpnhlLWsgLVaK7dpGt945Sed5C86RdQ92HB8BJbFVJJz9h18zCgonO1nW0TziE0lGrgf08hv5TQPHXgQBt2skgV4ClpsLy5HL9B5g1G23DUpFd56kzjTEN6SfO07QjWMho3Bc8K6rMb/uZfFLdZcqgdlYARO3pccB8ws4gTW3EMr5OwvhyJU9aLV/vm4xR8Cjg==
X-YMail-OSG: dlQo0E8VM1kfzZSKhk3H3vBZb5l.xo61nIahPoftaSyzsl2i347xivm6qqJ116E
 ifR6KZSPxepEbNRKGYIed.HY9261Uc4QU88UqsgfqhbDSwPkVFWX_BTFMZ4UUnXJGHFCQdOWL12A
 rsMfR_vHvWj4F.8Ww_lJ8FZraWPmSVihcjG50Zow3uYZP_c44BN9QgC7QjROYefcB5V4dEoMkdK2
 BQw6zBC_0GU1.dOvRsroTeyrzXj1fon_seMRf98O6Qx3QkZ6jy4LuaIDERLNuJOVW7QJ.2.Iy7nS
 OPGvyrWc4.YBdehVNPdpNIE5RligTBGzOfK.CplaiRusFggh6gbqKRWelDnuGl.dOgukIzgqMdaK
 tQ2sheMCkdxoJhwV164p2owh8eRfdpY_m3nNtxTotCjGQIJWq5vw7loonrVTI8PY6FMjB_cHVL9L
 tWIOqLC6tM3rLzrifR68Os9htA_p3_0d1zz1Qyfkpa.yu10ESAWxOz0mrlZcJbBk1FljLM42OgTJ
 SBd.P.57MHQhmYPDqS7fwvG0Hd34Xj.6jYfTWm4n6WWKfsXjZjLtgZbJGmH0eymthzd4G3c6Q.IB
 e_AMjRCmY5MIwkvtRhXg2s8O5yVTdNRnKCqy5rQGRu.my54oFdZUZPyvzxK6tMR2881QMHUjkrAH
 YD7gbrl7_b5QMxa7BdZUHHMUbxxzzCiHEZ_rNKyQifxy5lJiDt5Z68AFKCkQG.K9sUjKPLzTNLqC
 EqDkhdkAmVPFdgfj54rSZCEwCPDGcu0IwVRzpGZN6w6JjKuwKqLf9rmbxC4YFMMqc3mZUDzuA7uw
 US1rbZwYQ6UI3ZVATgyVlcbkEgE5jZVi_kKSYaXsRhdsza734ey7XwOyeEjnYpaqYw7HZjDzan_w
 m0CaUNyAnRLfmBDn4PttocOooxDF7lhnXHgijQ.B06jnqtLzP6Aovmz4fmuofWug2GB5hu_ge5RU
 pblndsOKxlsg5Ho7ykocy25BULrgIKNRaOBQ9N2suZsibp_LGQdoXHM_grNTiNScOLvKJUxTB0yo
 VZxh6oY.XJbajwxAhDbDtFzWVovL8mIWmU6EPYN8Ji_N_RkpNAusxhkV81zyyHZIVMRtYwQ4G8m7
 k4xicOZnGGZlIBij.luMTzBa4jLir5PpT6v.zSTdZMdDivkN2MqxUshEDGX7yHYM2uPIhESTmFMm
 l98A0Of6ElOvegFNtW_WKV6jtDRLpg940O1rVJP53rreC5g3zdU6QWsLpeK3_NwAuBtd__evfaKp
 rrzBCpujevNkFRCkkpIW_shjdWT.gwWSHicn_L4_ta5u2IdrFT5uAxi_aHMEiCDHGk5WxJ9W8uX2
 biZn3Kpx_BMWE2_x6lYZTnxpLIncMelOauNIAhwdWjA2rrnNzsZctrUFobJ8zSzT.h0yfb6etYfp
 4WAqQ9p0MFzQzX5eZ05JyYEdAU.ovRIVrrRzADtFCYlapmblhrv.CP0FoWzvffQUkQKKoMqSoEqe
 C.jRkodaDKX3c.374f3apItc5c1tDljodgoYcGbFwic4V3uFM8i1Rz5kSc2D3qKFkw0Oeq9h0vi7
 Seg3pGY9u._5WZpY1SV7wRdwqYnt6inGuZ_TK8AZIf2STN3xtVBY4Fmh.7TUmvlfJDgR_RkFI2D5
 R70Og_uEnE.2xRLePyEzMGQ17Kv0vwkqPftw0i__2tfujzknwP8GwfP38Nl7AZye1yzU70ISVKfY
 rgy5NYtLKyG61jCClnFNoMu03JNkSg7Vld4azDk8G0Qukv9VF9mRcoFCGvT3YwCUImp1GD6Cl7PO
 fGusouAqypUxNq7IqEHhM9f6Dm5eTFSxEWkZ.1VR8rPPbs77QxTV_WHqehtrUnc3y7bVvQU6xL9B
 KlU9Ejx6IguXRdJC08fIKcqrCqsoG5kHDaOLjz6aVwFQA7DEOihZw.NQ6XzP057kwwHcf8KkxFFw
 tj65_AJ_qI1NCzaZdi5hVnO.zh8ILfKbZS2VeIhz3MOJoJnaqosZ3.X8SQuF5eJZ6UKquZGl3Liu
 bwc_NF_hXh5cQeZuKC_6buOzVSE5YHN7HhvmYL0v5gdknKCpGG9wQ8Z1vntyijcGU.PHleBhN5NI
 Xns4z1oY-
X-Sonic-MF: <maskachoska@yahoo.com>
X-Sonic-ID: 024d8cd3-e7d9-4b82-b00c-840ad026c20a
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-101 with HTTP;
 Tue, 25 Aug 2026 22:44:22 +0000
Received: from dip125.lsn.sg3.yahoo.com ([106.10.223.134])
 by hello (SMTP) with SMTP ID 692ceff9cbf31ebf3ce1df27c5387b11;
 Tue, 25 Aug 2026 22:44:17 +0000 (UTC)
From: AK Sharma <maskachoska@yahoo.com>
To: u-boot@lists.u-boot-project.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, AK Sharma <maskachoska@yahoo.com>
Subject: [PATCH v1 11/12] board: econet: add EN7528 board support
Date: Wed, 26 Aug 2026 04:12:06 +0530
Message-ID: <20260825224330.713151-12-maskachoska@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825224330.713151-1-maskachoska@yahoo.com>
References: <20260825224330.713151-1-maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Aug 2026 22:49:58 +0000
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

Add the EcoNet EN7528 board: board glue, the reference/RAM/tclinux and
JCOW414 R3-hook defconfigs, board header and default environment.

Signed-off-by: AK Sharma <maskachoska@yahoo.com>
---
 board/econet/en7528/MAINTAINERS         |  13 +++
 board/econet/en7528/Makefile            |   2 +
 board/econet/en7528/board.c             | 110 +++++++++++++++++++++++
 board/econet/en7528/mk_tclinux_uboot.py | 112 ++++++++++++++++++++++++
 board/econet/en7528/tclinux_stub.S      |  65 ++++++++++++++
 configs/en7528_jcow414_r3hook_defconfig |  76 ++++++++++++++++
 configs/en7528_ram_defconfig            |  62 +++++++++++++
 configs/en7528_reference_defconfig      |  40 +++++++++
 defenvs/en7528_jcow414_r3hook_env       |   5 ++
 include/configs/en7528.h                |   9 ++
 10 files changed, 494 insertions(+)
 create mode 100644 board/econet/en7528/MAINTAINERS
 create mode 100644 board/econet/en7528/Makefile
 create mode 100644 board/econet/en7528/board.c
 create mode 100644 board/econet/en7528/mk_tclinux_uboot.py
 create mode 100644 board/econet/en7528/tclinux_stub.S
 create mode 100644 configs/en7528_jcow414_r3hook_defconfig
 create mode 100644 configs/en7528_ram_defconfig
 create mode 100644 configs/en7528_reference_defconfig
 create mode 100644 defenvs/en7528_jcow414_r3hook_env
 create mode 100644 include/configs/en7528.h

diff --git a/board/econet/en7528/MAINTAINERS b/board/econet/en7528/MAINTAINERS
new file mode 100644
index 00000000..69cefe4a
--- /dev/null
+++ b/board/econet/en7528/MAINTAINERS
@@ -0,0 +1,13 @@
+ECONET/AIROHA EN75XX
+M:	AK Sharma <maskachoska@yahoo.com>
+S:	Maintained
+F:	arch/mips/mach-en75xx/
+F:	arch/mips/dts/econet,en7528*
+F:	board/econet/en7528/
+F:	configs/en7528_*_defconfig
+F:	defenvs/en7528_jcow414_r3hook_env
+F:	doc/board/econet/en7528.rst
+F:	doc/board/econet/index.rst
+F:	drivers/mtd/nand/spi/en75_bmt.*
+F:	drivers/serial/serial_en75xx.c
+F:	include/configs/en7528.h
diff --git a/board/econet/en7528/Makefile b/board/econet/en7528/Makefile
new file mode 100644
index 00000000..bcca1a9f
--- /dev/null
+++ b/board/econet/en7528/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0+
+obj-y += board.o
diff --git a/board/econet/en7528/board.c b/board/econet/en7528/board.c
new file mode 100644
index 00000000..5708781e
--- /dev/null
+++ b/board/econet/en7528/board.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <dm.h>
+#include <init.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <stdio.h>
+
+#if CONFIG_IS_ENABLED(AIROHA_ETH)
+extern U_BOOT_DRIVER(airoha_eth);
+#endif
+
+#if defined(CONFIG_USB_XHCI_MTK)
+/*
+ * Release the USB host + T-PHY reset domains. The SCU reset controller is not
+ * modelled as a DM reset provider in this port (the ethernet driver pokes it
+ * directly too), so pulse the reset bits by hand. Banks/bits verified against
+ * the kernel clk-en7523 en751221 reset table: USB_HOST_P0 = RST_CTRL1(0x834)
+ * bit22; USB_PHY_P0/P1 = RST_USB(0x0ec) bits 6/7. set = assert/hold in reset,
+ * clear = release.
+ */
+#define EN7528_SCU_RST_CTRL1	0xbfb00834
+#define EN7528_SCU_RST_USB	0xbfb000ec
+#define EN7528_RST_USB_HOST_P0	BIT(22)		/* in RST_CTRL1 */
+#define EN7528_RST_USB_PHY_P0	BIT(6)		/* in RST_USB */
+#define EN7528_RST_USB_PHY_P1	BIT(7)		/* in RST_USB */
+
+/*
+ * USB2 T-PHY port enable. The nop-phy placeholder does nothing, so bring the
+ * two USB2 PHY ports up by hand the way the kernel en7528 USB PHY driver's
+ * .init does: write ACR3_ENABLE to each U2 port block. PHY MMIO base
+ * 0x1fa80000; U2 port bases 0x300 / 0x1300; ACR3 at +0x1c.
+ */
+#define EN7528_USB_PHY_BASE	0xbfa80000
+#define EN7528_USB_PHY_U2_P0	0x300
+#define EN7528_USB_PHY_U2_P1	0x1300
+#define EN7528_USB_PHY_ACR3	0x1c
+#define EN7528_USB_PHY_ACR3_ENABLE	0xc0240000
+
+#define SCU_R(off)	__raw_readl((void __iomem *)(0xbfb00000 + (off)))
+#define SCU_W(off, v)	__raw_writel((v), (void __iomem *)(0xbfb00000 + (off)))
+
+static void en7528_usb_init(void)
+{
+	u32 v;
+
+	/*
+	 * SoC-level USB clock/PLL + XSI mux + reset, reverse-engineered from the
+	 * stock JCOW407 vendor kernel (MU3H driver, routine at 0x56f170). This is
+	 * what the mainline OpenWrt kernel relies on the bootloader to have done,
+	 * and which the bootbase does NOT do in our ramboot path — so the xHCI MAC
+	 * (0x1fb90000) comes up unclocked without it.
+	 */
+	v = SCU_R(0x90);			/* USB clock/PLL enable: bits[30:29]=11 */
+	SCU_W(0x90, (v & 0x9fffffff) | 0x60000000);
+	mdelay(10);				/* PLL settle */
+	v = SCU_R(0xa8); SCU_W(0xa8, v | 0x600);
+	v = SCU_R(0xac); SCU_W(0xac, v & ~0x30000000);
+	v = SCU_R(0xa8); SCU_W(0xa8, v | 0x6000);
+	v = SCU_R(0xa8); SCU_W(0xa8, v & ~0x1800);
+	v = SCU_R(0xac); SCU_W(0xac, v & ~0x08000000);
+	v = SCU_R(0xec); SCU_W(0xec, v & ~0x80000000);	/* RST_USB assert */
+	mdelay(1);
+	v = SCU_R(0xec); SCU_W(0xec, v | 0x80000000);	/* RST_USB deassert */
+	mdelay(6);
+
+	/* legacy per-domain reset release (harmless, kept) */
+	v = SCU_R(0x834); SCU_W(0x834, v & ~EN7528_RST_USB_HOST_P0);
+	v = SCU_R(0xec);  SCU_W(0xec, v & ~(EN7528_RST_USB_PHY_P0 | EN7528_RST_USB_PHY_P1));
+	mdelay(1);
+
+	/* enable both USB2 T-PHY ports (kernel en7528 phy .init) */
+	__raw_writel(EN7528_USB_PHY_ACR3_ENABLE,
+		     (void __iomem *)(EN7528_USB_PHY_BASE +
+				      EN7528_USB_PHY_U2_P0 + EN7528_USB_PHY_ACR3));
+	__raw_writel(EN7528_USB_PHY_ACR3_ENABLE,
+		     (void __iomem *)(EN7528_USB_PHY_BASE +
+				      EN7528_USB_PHY_U2_P1 + EN7528_USB_PHY_ACR3));
+	mdelay(1);
+}
+#endif
+
+int board_init(void)
+{
+	return 0;
+}
+
+int board_late_init(void)
+{
+#if defined(CONFIG_USB_XHCI_MTK)
+	en7528_usb_init();
+#endif
+#if CONFIG_IS_ENABLED(AIROHA_ETH)
+	struct udevice *dev;
+	int ret;
+
+	/*
+	 * Probe the EN751221-family Ethernet parent after the console is up and
+	 * just before initr_net() enumerates UCLASS_ETH devices (mirrors the
+	 * EN7512 reference board).
+	 */
+	ret = uclass_get_device_by_driver(UCLASS_MISC,
+					  DM_DRIVER_GET(airoha_eth), &dev);
+	if (ret && ret != -ENODEV)
+		printf("EN7528 Ethernet probe failed: %d\n", ret);
+#endif
+	return 0;
+}
diff --git a/board/econet/en7528/mk_tclinux_uboot.py b/board/econet/en7528/mk_tclinux_uboot.py
new file mode 100644
index 00000000..d63f46a3
--- /dev/null
+++ b/board/econet/en7528/mk_tclinux_uboot.py
@@ -0,0 +1,112 @@
+#!/usr/bin/env python3
+"""
+Package U-Boot as an EcoNet/TrendChip "tclinux" HDR2 image, so the stock
+bootbase will load and run it exactly the way it loads the stock kernel.
+
+The bootbase decompresses a slot's LZMA payload to a fixed 0x80002000 and jumps
+there. U-Boot cannot be linked at that address (MIPS relocation needs the
+relocation delta 64 KiB aligned, and reserve_uboot() force-aligns relocaddr to
+64 KiB, so a TEXT_BASE of 0x80002000 always panics "Mis-aligned relocation").
+So the payload is a small relocator stub followed by a U-Boot linked at
+0x81000000; the stub copies it up and jumps.
+
+  payload = [stub @0x80002000][pad to 0x100][u-boot.bin linked @0x81000000]
+  image   = [HDR2 header 0x100][LZMA(payload)]
+
+Header layout, confirmed against the stock image on a live board
+(0x100 + kernel_len + rootfs_len == total, exactly):
+
+  0x00  "HDR2"
+  0x08  u32 LE  total size, including the 0x100 header
+  0x0c  u32 LE  JAMCRC of everything after the header
+  0x10  version string
+  0x50  u32 LE  kernel length
+  0x54  u32 LE  rootfs length
+  0x100         LZMA kernel, then the rootfs
+
+Usage: mk_tclinux_uboot.py <stub.bin> <u-boot.bin> <out.trx> [version]
+"""
+import struct
+import subprocess
+import sys
+import tempfile
+import zlib
+
+PAYLOAD_OFF = 0x100
+HDR_SIZE = 0x100
+DEFAULT_VERSION = 'UBOOT_EN7528'
+
+
+def lzma_alone(data):
+    """LZMA 'alone' stream, the format the bootbase decompressor expects.
+
+    xz streams and therefore stamps the uncompressed-size field as unknown; the
+    vendor encoder records the real size and some decoders rely on it, so the
+    field is filled in afterwards. Both are valid LZMA-alone.
+    """
+    out = subprocess.run(
+        ['xz', '--format=lzma', '--stdout', '-9', '--lzma1=preset=9,lc=1,lp=2,pb=2'],
+        input=data, check=True, capture_output=True).stdout
+
+    # xz streams, so it stamps the size field "unknown" (all 0xff). The vendor
+    # encoder (lzma_alone) records the real size and some decoders rely on it,
+    # so fill it in. Header is props(1) + dictsize(4) + uncompressed size(8).
+    out = bytearray(out)
+    struct.pack_into('<Q', out, 5, len(data))
+    return bytes(out)
+
+
+def main():
+    if len(sys.argv) < 4:
+        sys.exit(__doc__)
+
+    stub = open(sys.argv[1], 'rb').read()
+    uboot = open(sys.argv[2], 'rb').read()
+    outpath = sys.argv[3]
+    version = sys.argv[4] if len(sys.argv) > 4 else DEFAULT_VERSION
+
+    if len(stub) > PAYLOAD_OFF:
+        sys.exit('stub is %d bytes, must fit in %#x' % (len(stub), PAYLOAD_OFF))
+
+    payload = stub + b'\x00' * (PAYLOAD_OFF - len(stub)) + uboot
+    comp = lzma_alone(payload)
+
+    kernel_len = len(comp)
+    rootfs_len = 0
+    total = HDR_SIZE + kernel_len + rootfs_len
+
+    hdr = bytearray(b'\xff' * HDR_SIZE)
+    hdr[0x00:0x04] = b'HDR2'
+    hdr[0x04:0x08] = bytes([0x00, 0x01, 0x00, 0x00])   # as seen in stock images
+    struct.pack_into('<I', hdr, 0x08, total)
+    # 0x0c filled in below
+    ver = version.encode()[:0x1f] + b'\n'
+    hdr[0x10:0x10 + len(ver)] = ver
+    hdr[0x10 + len(ver):0x30] = b'\x00' * (0x30 - 0x10 - len(ver))
+    hdr[0x30] = 0x0a                                    # as seen in stock images
+    hdr[0x31:0x50] = b'\x00' * (0x50 - 0x31)
+    struct.pack_into('<I', hdr, 0x50, kernel_len)
+    struct.pack_into('<I', hdr, 0x54, rootfs_len)
+    hdr[0x58:0x100] = b'\x00' * (0x100 - 0x58)
+
+    body = comp
+    jamcrc = (zlib.crc32(body) ^ 0xFFFFFFFF) & 0xFFFFFFFF
+    struct.pack_into('<I', hdr, 0x0c, jamcrc)
+
+    image = bytes(hdr) + body
+    open(outpath, 'wb').write(image)
+
+    print('stub        : %d B' % len(stub))
+    print('u-boot      : %d B (linked 0x81000000)' % len(uboot))
+    print('payload     : %d B (entry 0x80002000)' % len(payload))
+    print('lzma        : %d B' % kernel_len)
+    print('version     : %s' % version)
+    print('JAMCRC      : 0x%08x' % jamcrc)
+    print('total       : %d B (0x%x)  [header 0x100 + kernel + rootfs]' % (total, total))
+    print('image       : %s  %d B' % (outpath, len(image)))
+    assert len(image) == total, (len(image), total)
+    print('consistency : 0x100 + %d + %d == %d  OK' % (kernel_len, rootfs_len, total))
+
+
+if __name__ == '__main__':
+    main()
diff --git a/board/econet/en7528/tclinux_stub.S b/board/econet/en7528/tclinux_stub.S
new file mode 100644
index 00000000..4bd032d4
--- /dev/null
+++ b/board/econet/en7528/tclinux_stub.S
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Relocator stub for booting U-Boot as an EcoNet "tclinux" image.
+ *
+ * The vendor bootbase decompresses a firmware image to a fixed 0x80002000 and
+ * jumps there. U-Boot cannot be linked at that address: MIPS relocation
+ * requires (relocaddr - TEXT_BASE) to be 64 KiB aligned, and reserve_uboot()
+ * force-aligns relocaddr to 64 KiB, so a TEXT_BASE of 0x80002000 always
+ * panics with "Mis-aligned relocation".
+ *
+ * So this stub takes the entry instead: it copies the U-Boot image that
+ * follows it up to a 64 KiB aligned address and jumps there.
+ *
+ * The source is read through the cached KSEG0 alias, because the loader wrote
+ * it that way and the bytes may still only exist in cache. The destination is
+ * written through the uncached KSEG1 alias so it is guaranteed to reach DRAM
+ * without depending on this SoC's unreliable cache maintenance (see
+ * airoha_eth / en75_bmt), and nothing has cached that region before.
+ *
+ * Layout of the payload this stub heads:
+ *   +0x0000  this stub
+ *   +0x0100  u-boot.bin, linked at 0x81000000
+ */
+
+#define STUB_ENTRY	0x80002000
+#define PAYLOAD_OFF	0x100
+#define DEST		0x81000000
+/* Fixed generous span; U-Boot is ~0.5 MiB and trailing junk is harmless. */
+#define COPY_LEN	0x00100000
+
+	.set	noreorder
+	.set	noat
+	.globl	_start
+	.text
+_start:
+	/*
+	 * t0 = CACHED source = KSEG0(STUB_ENTRY + PAYLOAD_OFF).
+	 * Whoever loaded us (the bootbase decompressor, or tftpboot when
+	 * testing) wrote this image through the cache, so it must be read back
+	 * the same way - reading the uncached alias returns stale DRAM.
+	 */
+	lui	$t0, 0x8000
+	ori	$t0, $t0, (PAYLOAD_OFF + 0x2000)
+
+	/* t1 = uncached destination = KSEG1(DEST) */
+	lui	$t1, 0xa100
+
+	/* t2 = byte count */
+	lui	$t2, (COPY_LEN >> 16)
+	ori	$t2, $t2, (COPY_LEN & 0xffff)
+
+1:
+	lw	$t3, 0($t0)
+	sw	$t3, 0($t1)
+	addiu	$t0, $t0, 4
+	addiu	$t1, $t1, 4
+	addiu	$t2, $t2, -4
+	bgtz	$t2, 1b
+	nop
+
+	/* Enter U-Boot at its link address (cached KSEG0). */
+	lui	$t9, (DEST >> 16)
+	ori	$t9, $t9, (DEST & 0xffff)
+	jr	$t9
+	nop
diff --git a/configs/en7528_jcow414_r3hook_defconfig b/configs/en7528_jcow414_r3hook_defconfig
new file mode 100644
index 00000000..f847dc42
--- /dev/null
+++ b/configs/en7528_jcow414_r3hook_defconfig
@@ -0,0 +1,76 @@
+CONFIG_MIPS=y
+CONFIG_SYS_LITTLE_ENDIAN=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_MALLOC_LEN=0x400000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x20000
+CONFIG_ENV_OFFSET=0xc0000
+CONFIG_ENV_OFFSET_REDUND=0xe0000
+CONFIG_DEFAULT_DEVICE_TREE="econet,en7528-ram"
+CONFIG_SYS_LOAD_ADDR=0x82000000
+CONFIG_ARCH_EN75XX=y
+CONFIG_BUILD_TARGET="u-boot.bin"
+CONFIG_BOARD_EN7528_R3HOOK=y
+CONFIG_TEXT_BASE=0x81E00000
+CONFIG_SYS_MIPS_TIMER_FREQ=200000000
+# CONFIG_MIPS_CACHE_SETUP is not set
+# CONFIG_MIPS_CACHE_DISABLE is not set
+# CONFIG_RESTORE_EXCEPTION_VECTOR_BASE is not set
+CONFIG_MIPS_BOOT_FDT=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SYS_BOOTM_LEN=0x2000000
+CONFIG_BOOTDELAY=2
+CONFIG_DISPLAY_CPUINFO=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="EN7528> "
+CONFIG_SYS_MAXARGS=16
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_BOOTM=y
+CONFIG_CMD_SAVEENV=y
+CONFIG_CMD_MTD=y
+# CONFIG_CMD_SETEXPR is not set
+# CONFIG_ENV_IS_NOWHERE is not set
+CONFIG_ENV_IS_IN_MTD=y
+CONFIG_ENV_MTD_DEV="spi-nand0"
+CONFIG_ENV_REDUNDANT=y
+CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE=y
+CONFIG_ENV_DEFAULT_ENV_TEXT_FILE="defenvs/en7528_jcow414_r3hook_env"
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_NET=y
+CONFIG_NETDEVICES=y
+CONFIG_CMD_NET=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_MII=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_DM_MDIO=y
+CONFIG_PHY=y
+CONFIG_NOP_PHY=y
+CONFIG_CLK=y
+CONFIG_DMA=y
+CONFIG_AIROHA_ETH=y
+CONFIG_USB=y
+CONFIG_DM_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_MTK=y
+CONFIG_USB_STORAGE=y
+CONFIG_CMD_USB=y
+CONFIG_BLK=y
+CONFIG_PARTITIONS=y
+CONFIG_DOS_PARTITION=y
+CONFIG_EFI_PARTITION=y
+CONFIG_FS_FAT=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_AIROHA_SNFI_SPI=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_CMD_DM=y
+CONFIG_MTD_EN75_BMT=y
+CONFIG_LZMA=y
diff --git a/configs/en7528_ram_defconfig b/configs/en7528_ram_defconfig
new file mode 100644
index 00000000..55ec279c
--- /dev/null
+++ b/configs/en7528_ram_defconfig
@@ -0,0 +1,62 @@
+CONFIG_MIPS=y
+CONFIG_SYS_LITTLE_ENDIAN=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_MALLOC_LEN=0x100000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x1000
+CONFIG_DEFAULT_DEVICE_TREE="econet,en7528-ram"
+CONFIG_SYS_LOAD_ADDR=0x81800000
+CONFIG_ARCH_EN75XX=y
+CONFIG_BUILD_TARGET="u-boot.bin"
+CONFIG_BOARD_EN7528_RAM=y
+CONFIG_SYS_MIPS_TIMER_FREQ=200000000
+# CONFIG_MIPS_CACHE_SETUP is not set
+# CONFIG_MIPS_CACHE_DISABLE is not set
+# CONFIG_RESTORE_EXCEPTION_VECTOR_BASE is not set
+CONFIG_BOOTDELAY=3
+CONFIG_DISPLAY_CPUINFO=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="EN7528> "
+CONFIG_SYS_MAXARGS=16
+CONFIG_CMD_MEMINFO=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_NET=y
+CONFIG_NETDEVICES=y
+CONFIG_CMD_NET=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_MII=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_DM_MDIO=y
+CONFIG_PHY=y
+CONFIG_NOP_PHY=y
+CONFIG_CLK=y
+CONFIG_DMA=y
+CONFIG_AIROHA_ETH=y
+CONFIG_USB=y
+CONFIG_DM_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_MTK=y
+CONFIG_USB_STORAGE=y
+CONFIG_CMD_USB=y
+CONFIG_BLK=y
+CONFIG_PARTITIONS=y
+CONFIG_DOS_PARTITION=y
+CONFIG_EFI_PARTITION=y
+CONFIG_FS_FAT=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_AIROHA_SNFI_SPI=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_DM=y
+CONFIG_MTD_EN75_BMT=y
+CONFIG_LZMA=y
diff --git a/configs/en7528_reference_defconfig b/configs/en7528_reference_defconfig
new file mode 100644
index 00000000..6811c7e3
--- /dev/null
+++ b/configs/en7528_reference_defconfig
@@ -0,0 +1,40 @@
+CONFIG_MIPS=y
+CONFIG_SYS_LITTLE_ENDIAN=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_MALLOC_LEN=0x100000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x1000
+CONFIG_DEFAULT_DEVICE_TREE="econet,en7528-reference"
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_SERIAL=y
+CONFIG_TPL_SYS_MALLOC_F_LEN=0x1000
+CONFIG_SPL_BSS_START_ADDR=0x80080000
+CONFIG_SPL_BSS_MAX_SIZE=0x10000
+CONFIG_SYS_LOAD_ADDR=0x81800000
+CONFIG_SPL=y
+CONFIG_ARCH_EN75XX=y
+CONFIG_BUILD_TARGET="u-boot.bin"
+CONFIG_BOARD_EN7528_REFERENCE=y
+CONFIG_SYS_MIPS_TIMER_FREQ=150000000
+CONFIG_MIPS_CACHE_SETUP=y
+CONFIG_MIPS_CACHE_DISABLE=y
+CONFIG_RESTORE_EXCEPTION_VECTOR_BASE=y
+CONFIG_MIPS_BOOT_FDT=y
+CONFIG_FIT=y
+CONFIG_BOOTDELAY=3
+CONFIG_DISPLAY_CPUINFO=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_SPL_MAX_SIZE=0x30000
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_TPL=y
+# CONFIG_TPL_FRAMEWORK is not set
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="EN7528> "
+CONFIG_SYS_MAXARGS=8
+CONFIG_CMD_MEMINFO=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_SPL_DM=y
diff --git a/defenvs/en7528_jcow414_r3hook_env b/defenvs/en7528_jcow414_r3hook_env
new file mode 100644
index 00000000..4bc9e278
--- /dev/null
+++ b/defenvs/en7528_jcow414_r3hook_env
@@ -0,0 +1,5 @@
+ipaddr=192.168.1.111
+serverip=192.168.1.166
+loadaddr=0x82000000
+bootdelay=2
+bootcmd=mtd read spi-nand0 ${loadaddr} 0x100000 0x1000000; bootm ${loadaddr}
diff --git a/include/configs/en7528.h b/include/configs/en7528.h
new file mode 100644
index 00000000..b8dc2410
--- /dev/null
+++ b/include/configs/en7528.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef __CONFIG_EN7528_H
+#define __CONFIG_EN7528_H
+
+#define CFG_SYS_SDRAM_BASE	0x80000000
+/* Above FIT scratch (0x82000000) and kernel load (0x80020000, up to ~32 MiB). */
+#define CFG_SYS_INIT_SP_OFFSET	0x04000000
+
+#endif
-- 
2.53.0

