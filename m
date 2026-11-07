Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF94E606A335
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=a32JrB+v;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=A82fYL/2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE84A60A8F;
	Sat,  7 Nov 2026 14:34:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nqDwy_mEbAT7; Sat,  7 Nov 2026 14:34:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 89BA2607BA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062066;
	b=tNvacbD+DWGXJsnnztgYR0nApfs/edqCnO0P0HBPJchze3Td5e/T4KWlehLHGm70/s+6
	 AhDSpWX9pjLfb4BAMAiiAGTpvp0FoUzAUV4xfTulk4GRpIHTaa9UvBohMQYw8/AHK8jzi
	 SXn4OiMFNOZTC40Kr7P1NGCONh7g37/3ie4XslWm/9A9uxHPQNFiyjUNuk0pBp/yMeZeb
	 63mpxjaF8EOw/NZfmBSXbGnr2J1khBH2faXXnwrs40gp0V7t+AdySMHdy2ksBMJ6OT/WQ
	 Xe/5C1SuuZXgj5eIPIgMRaxl/G25m66j7zPDsr/7wFLzn6f8S35wCBzYf12YZgLSfzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062066;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lEbFPIc68YGj1pejKCqAz7sdpi7KJ566xCXvLE9jwmg=;
	b=I1YjyM9tPaeU+9VpktxK9j8WgPQgGhRgK9aDdAfh+Snrh4jys3XS0ELWuX2XiujJbPyn
	 4+2P3NB5mYJU0iJT1KghqbPcbozysdliWf1IDel6lGJrgz58gnxG7lD3snaqQgDL3NP6L
	 2OXUkf3eIXFji+xNIB2PdqtwIVLlN3YiMPr42hMBMTsTgHEhE/fTTvKbLJD4XCbfIu+ua
	 cozB2X7RVv/ZiHwmVCaR4oHjBUGVxgARAt+oztVca+FNoEG7VQPaPGjnOhUbqfeadCqv2
	 GwOPjEeZ9UYO0Yk55qq44qjdlNJMclOSnwrFUzlaVSpYXSiGmx6TOeEWK7+ttnxp8Sg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b="A82fYL/2";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062066;
	bh=lEbFPIc68YGj1pejKCqAz7sdpi7KJ566xCXvLE9jwmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a32JrB+v7Ps7Z4cVqWHTUU9gzaNjJ5z2aOeEi/6m191uP4VvkGsMxiWCgPwQw2zzX
	 nDokA9Mi6BYdsEUq9z2xOmnvB+jVKNGs8CNlxzhGBqIqqsjzvr63SlySZAyY+awbbL
	 509MS133XKQC2o0JBDibRRtn4aVBcFiISLhRHhjt2950UQdUV6WKv7FwYRnXNhMfKv
	 Cc/o0nJjYJbiYNgShkG8vEKLQDqbGIIHbTqL7SeHzukT5lg/U/Xj2oWJgx2/nOaArx
	 esiTCgNUdz0SQfpwVSzP+3CMBGcgep+wid8iDzrEc6LaVT1iUAgj4CW5uibhXBbX1f
	 JA/ttCzV9SGyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89BA2607BA;
	Sat,  7 Nov 2026 14:34:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 600911E3
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F7BB60767
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fzN202pVbo0E for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2692C60A70
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=A82fYL/2
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2692C60A70
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:53 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48e4831c028so1581061f8f.0
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794062032; x=1794666832;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lEbFPIc68YGj1pejKCqAz7sdpi7KJ566xCXvLE9jwmg=;
 b=A82fYL/2VVmALJtBY9P0Pdl4VjnCKVi9iLbEuzflipST+odOXqvvMPecVFFTnbsoYo
 wZ8OircrngFwFvGF1/GgxrrPOrv2ERtqb7GOY2tNxttRS9JYPe7KZSOLyqp6z8BsGJjX
 QX/ataiVtp/ksnxr8A/8coEaHRj4rOH3Dci3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794062032; x=1794666832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lEbFPIc68YGj1pejKCqAz7sdpi7KJ566xCXvLE9jwmg=;
 b=a1ILV1kBtUZRIIKHWJNATb7Xwbf/tC7J6Yk9Rkx4ViPc4hbg5beIx60m0BsEAhUl4A
 e5gARmz1DsjJFhoSIBjtBDviYfRvlDEasA2RqLAn/l9KPmaiZbHtlaqKovTaxgTf28dR
 77CluwUBK/ApvdtL5t6dFIWxiweCVagCg0bFG9ql4/p5vg4EwO6M3atJATOPrP2MGPYc
 l7ft3ueh97SVzhjviW6BXAPjE//2YrHm6dDYUoGnDPdoAVkkwL0THC+otlsgwmwvdW1g
 XQL6dbDT3cGWGNTAV7JFzBvyhGF+rU9wihCULfq08k21nYgHOldNkPdb8Wo+7GH36AuF
 NQvw==
X-Forwarded-Encrypted: i=1;
 AL+hErFoB03/6JoZXzFkkJhH5cR17KoMHzPiQbMgawUK2451t9pWUijuPz/sajVrQ5+1nNdUT9j/3ZM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/BL+jjllL9EVaPbzDBaVxVph9MUYTsVxosd2MaUqsywlU2rZfR
 QdWcRstLinyltIntCAqNmTmYOMt4UwGeiy0ha/lnmeGbLOe7OOeTY51FLwtIPWjEh1E=
X-Gm-Gg: AYBFou30WLDD9WXaOblFMOO46lou+CLxzTaBYhdUSXI/uKsDzqnR+hAmDYhYP5BmYsN
 IOj+cPnAv1qyU6Y65BjB019vOp2JQ6hJducoqWULb9pp4GgyiFGNeZY604U1Ybh+s6M0PVhn+gL
 4ZXZcvZkv/xJpHpGzgmVylAa0NmqpcqU5AshEoK7HB97KfPeRinYL+iUkhBqK3g1P1zPG9d1W3C
 /MwyJMbYOjUZk3EhJkeL81OB7zK9b1KjHwURX0TGWKkcy7/abw4gTM2BGIHcN5GsbgFE7+1l629
 Onp0sjaPz1F8eLwXJ6zAGqoyHDohtCrKUqciG6cttpVn0eWGmsMCohxdwnG5KCt0xumnQAxAJIL
 3ir1qYvMmOxY98FxLsM7D49KvVrXGlLKTlUOZU8xR3kXPBEJCiScFTR2AqOLEVvFzTBUUN5iN0w
 qh0uW3fdUssymVqtWeCwMK3+GP9wGarQVq+89ELxbjcxyULPT/gniyJ6bA+5XTZ1YYHSJRHc5q1
 0QaSRGSxL5Euk9NwoajT3Vic9uXfsUgse/Oa9cDR5BveBmaxKVPOE9mkhB+UQdDRBYqJNF9AYvd
 mumSQp8FW8g3DvrDCsz1fSvwFv7v8UodUqZX/jA37RRAN1H41miCMvBiBwxJ05exWKNx6KLKYIG
 CgPaWV9hGrIrNY2W8cJ0KQOsuaKXN3YGECWAikQvfAMSFD9bN/bSfb1MjNqnZZYnRJ8LHrqrT1Y
 QeN4E3wFI8lHEUH7yjb8efWsX9bg==
X-Received: by 2002:a05:6000:161f:b0:48e:8882:6d91 with SMTP id
 ffacd0b85a97d-49272d1c6d5mr7273546f8f.1.1794062031775; 
 Sat, 07 Nov 2026 06:33:51 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:50 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 33/35] board: engicam: stm32mp2: add splash screen
Date: Sat,  7 Nov 2026 15:32:23 +0100
Message-ID: <20261107143241.2236511-34-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The U-Boot devicetree includes the overlays of all the supported
displays. Enable only the one selected by the "display" environment
variable.

The customer splash image is loaded from its partition, falling back to
the built-in logo.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Apply the upstream display overlays to the U-Boot devicetree instead
  of describing the displays in the -u-boot.dtsi file
- Do not leave the LTDC RGB pins configured with the LVDS display

 ...m32mp257d-engicam-microgea-rmm-u-boot.dtsi |   5 +
 board/engicam/stm32mp2/microgea-stm32mp2.env  |   4 +
 board/engicam/stm32mp2/stm32mp2.c             | 179 ++++++++++++++++++
 configs/stm32mp25-microgea-rmm_defconfig      |  16 ++
 4 files changed, 204 insertions(+)

diff --git a/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi b/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
index 4cc0d47e999d..8a3723baa116 100644
--- a/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
@@ -12,6 +12,11 @@
 	};
 };
 
+&ltdc {
+	clocks = <&rcc CK_KER_LTDC>, <&rcc CK_BUS_LTDC>, <&syscfg>, <&lvds>;
+	bootph-all;
+};
+
 &usart2 {
 	bootph-all;
 };
diff --git a/board/engicam/stm32mp2/microgea-stm32mp2.env b/board/engicam/stm32mp2/microgea-stm32mp2.env
index 1f50f68d4972..cbc0a73f5081 100644
--- a/board/engicam/stm32mp2/microgea-stm32mp2.env
+++ b/board/engicam/stm32mp2/microgea-stm32mp2.env
@@ -7,3 +7,7 @@
 /* Default display of the carrier board */
 display=rk050hr345-ct106a
 extension_overlay_addr=0x90300000
+
+splashfile=splash.bmp
+splashimage=CONFIG_SYS_LOAD_ADDR
+splashpos=m,m
diff --git a/board/engicam/stm32mp2/stm32mp2.c b/board/engicam/stm32mp2/stm32mp2.c
index 5f3afd877a11..64317f271ed7 100644
--- a/board/engicam/stm32mp2/stm32mp2.c
+++ b/board/engicam/stm32mp2/stm32mp2.c
@@ -8,12 +8,23 @@
 
 #include <alist.h>
 #include <config.h>
+#include <dm.h>
 #include <env.h>
+#include <event.h>
 #include <extension_board.h>
 #include <log.h>
+#include <splash.h>
+#include <asm/arch/stm32.h>
+#include <asm/arch/sys_proto.h>
+#include <dm/device-internal.h>
 #include <dm/ofnode.h>
+#include <dm/ofnode_graph.h>
+#include <dm/uclass-internal.h>
 #include <linux/string.h>
 
+#define MICROGEA_RK050HR345 "rk050hr345-ct106a"
+#define MICROGEA_AM1280800W8TZQW "am-1280800w8tzqw-t00h"
+
 int checkboard(void)
 {
 	const char *fdt_compat;
@@ -38,6 +49,174 @@ static const char *microgea_get_display(void)
 	return display;
 }
 
+/* Disable a node and unbind its device, if any */
+static int microgea_disable_node(ofnode node)
+{
+	struct udevice *dev;
+	int ret;
+
+	if (!ofnode_valid(node))
+		return 0;
+
+	if (!device_find_global_by_ofnode(node, &dev)) {
+		ret = device_unbind(dev);
+		if (ret)
+			return ret;
+	}
+
+	return ofnode_set_enabled(node, false);
+}
+
+static int microgea_ltdc_connect(ofnode ltdc, ofnode ep)
+{
+	u32 ltdc_phandle, phandle;
+	ofnode ltdc_ep;
+	int ret;
+
+	ltdc_ep = ofnode_graph_get_endpoint_by_regs(ltdc, -1, -1);
+	if (!ofnode_valid(ltdc_ep) || !ofnode_valid(ep) ||
+	    ofnode_read_u32(ltdc_ep, "phandle", &ltdc_phandle) ||
+	    ofnode_read_u32(ep, "phandle", &phandle))
+		return -EINVAL;
+
+	ret = ofnode_write_u32(ltdc_ep, "remote-endpoint", phandle);
+	if (ret)
+		return ret;
+
+	return ofnode_write_u32(ep, "remote-endpoint", ltdc_phandle);
+}
+
+static int microgea_disable_compatible(const char *compat)
+{
+	return microgea_disable_node(ofnode_by_compatible(ofnode_null(),
+							  compat));
+}
+
+static const struct microgea_display {
+	const char *name;	/* value of the "display" env variable */
+	const char *compatible;	/* compatible of its panel */
+	const char *bridge;	/* compatible of its bridge, if any */
+} microgea_displays[] = {
+	{
+		.name = MICROGEA_RK050HR345,
+		.compatible = "rocktech," MICROGEA_RK050HR345,
+	},
+	{
+		.name = MICROGEA_AM1280800W8TZQW,
+		.compatible = "ampire," MICROGEA_AM1280800W8TZQW,
+		.bridge = "st,stm32mp25-lvds",
+	},
+};
+
+static bool microgea_uses_bridge(const struct microgea_display *d,
+				 const char *bridge)
+{
+	return d && d->bridge && !strcmp(d->bridge, bridge);
+}
+
+/*
+ * The U-Boot devicetree includes the overlays of all the displays. Keep
+ * only the one in use, or disable the LTDC if it is not supported.
+ */
+static int microgea_settings_r(void)
+{
+	const char *display = microgea_get_display();
+	const struct microgea_display *sel = NULL, *d;
+	struct udevice *video;
+	ofnode ltdc, node, ep;
+	int i, ret;
+
+	if (uclass_find_first_device(UCLASS_VIDEO, &video) || !video)
+		return 0;
+
+	ltdc = dev_ofnode(video);
+
+	for (i = 0; i < ARRAY_SIZE(microgea_displays); i++) {
+		if (display && !strcmp(display, microgea_displays[i].name)) {
+			sel = &microgea_displays[i];
+			break;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(microgea_displays); i++) {
+		d = &microgea_displays[i];
+		if (d == sel)
+			continue;
+
+		ret = microgea_disable_compatible(d->compatible);
+		if (ret)
+			return ret;
+
+		if (d->bridge && !microgea_uses_bridge(sel, d->bridge)) {
+			ret = microgea_disable_compatible(d->bridge);
+			if (ret)
+				return ret;
+		}
+	}
+
+	if (!sel)
+		return microgea_disable_node(ltdc);
+
+	node = ofnode_by_compatible(ofnode_null(), sel->compatible);
+	if (!ofnode_valid(node))
+		return microgea_disable_node(ltdc);
+
+	/* Connect the RGB panel to the LTDC */
+	if (!sel->bridge) {
+		ep = ofnode_graph_get_endpoint_by_regs(node, -1, -1);
+		return microgea_ltdc_connect(ltdc, ep);
+	}
+
+	/* The bridge does not use the LTDC pins */
+	ret = ofnode_delete_prop(ltdc, "pinctrl-names");
+	if (!ret)
+		ret = ofnode_delete_prop(ltdc, "pinctrl-0");
+	if (!ret)
+		ret = ofnode_delete_prop(ltdc, "pinctrl-1");
+	if (ret)
+		return ret;
+
+	node = ofnode_by_compatible(ofnode_null(), sel->bridge);
+	if (!ofnode_valid(node))
+		return -ENODEV;
+
+	/* Connect the bridge to the LTDC */
+	ep = ofnode_graph_get_endpoint_by_regs(node, 0, -1);
+	return microgea_ltdc_connect(ltdc, ep);
+}
+EVENT_SPY_SIMPLE(EVT_SETTINGS_R, microgea_settings_r);
+
+#if CONFIG_IS_ENABLED(SPLASH_SOURCE)
+static struct splash_location microgea_splash_locations[] = {
+	{
+		.name = "mmc",
+		.storage = SPLASH_STORAGE_MMC,
+		.flags = SPLASH_STORAGE_FS,
+	},
+};
+
+/* Load the customer splash image from its partition, else the built-in logo */
+int splash_screen_prepare(void)
+{
+	static char devpart[8];
+	u32 bootmode = get_bootmode();
+	unsigned int instance = (bootmode & TAMP_BOOT_INSTANCE_MASK) - 1;
+
+	switch (bootmode & TAMP_BOOT_DEVICE_MASK) {
+	case BOOT_FLASH_SD:
+	case BOOT_FLASH_EMMC:
+		snprintf(devpart, sizeof(devpart), "%u:a", instance);
+		microgea_splash_locations[0].devpart = devpart;
+		if (!splash_source_load(microgea_splash_locations,
+					ARRAY_SIZE(microgea_splash_locations)))
+			return 0;
+		break;
+	}
+
+	return splash_video_logo_load();
+}
+#endif
+
 int board_late_init(void)
 {
 	const char *fdt_compat;
diff --git a/configs/stm32mp25-microgea-rmm_defconfig b/configs/stm32mp25-microgea-rmm_defconfig
index 34933f1e7e41..0f1b7db7abc8 100644
--- a/configs/stm32mp25-microgea-rmm_defconfig
+++ b/configs/stm32mp25-microgea-rmm_defconfig
@@ -38,6 +38,7 @@ CONFIG_CMD_PWM=y
 # CONFIG_CMD_LOADB is not set
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
+CONFIG_CMD_BMP=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_RNG=y
@@ -48,6 +49,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
 CONFIG_OF_UPSTREAM_VENDOR="st"
+CONFIG_OF_UPSTREAM_CONTROL_DT_OVERLAYS="st/stm32mp257d-engicam-microgea-rmm-overlay-rk050hr345-ct106a st/stm32mp257d-engicam-microgea-rmm-overlay-am-1280800w8tzqw-t00h"
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
@@ -98,6 +100,20 @@ CONFIG_DM_SPI=y
 CONFIG_STM32_OSPI=y
 CONFIG_STM32_SPI=y
 # CONFIG_OPTEE_TA_AVB is not set
+CONFIG_VIDEO=y
+CONFIG_VIDEO_LOGO=y
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_VIDEO_LCD_ILITEK_ILI9806E=y
+CONFIG_VIDEO_STM32=y
+CONFIG_VIDEO_STM32_LVDS=y
+CONFIG_VIDEO_STM32_MAX_XRES=1280
+CONFIG_VIDEO_STM32_MAX_YRES=854
+CONFIG_SPLASH_SCREEN=y
+CONFIG_SPLASH_SCREEN_ALIGN=y
+CONFIG_SPLASH_SOURCE=y
+CONFIG_BMP_16BPP=y
+CONFIG_BMP_24BPP=y
+CONFIG_BMP_32BPP=y
 CONFIG_WDT=y
 CONFIG_WDT_STM32MP=y
 CONFIG_WDT_ARM_SMC=y
-- 
2.43.0

