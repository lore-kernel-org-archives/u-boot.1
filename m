Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FB9606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RCW1DOi/;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=niWVcrq0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AEAA580EB3;
	Sat, 28 Nov 2026 13:12:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N8XtFzqB4ZKz; Sat, 28 Nov 2026 13:12:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B6286810BB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871557;
	b=Lbve1gevS5d0G2x0Vba9Ai1fqAEypIP6onp7XRDA5YETBWDa8m2EPAS6vfExH0hk7I0W
	 +5zkwXr+D/VUmED0SzDhxgFm/Pn2SgSDZOX5XayumNfu+ataZOk4J3aixy+fjv2HRWJ8v
	 Dc6/B3JEKFppPiTWvEyeU+cs4HeaQv3jSZ/AH83eYHnelWZ+81wHiVy6Zt1vfXnC8rsjQ
	 nmsFlrVQAtT2Rk7lfvQ7fmQNIhji7k2Nedvv/hc36jUwYtKtCuTMLQTpn6HarFd4r/L+9
	 heXLzkyTDC/nB0YuYi5uOJTf1AyBD8iZWna/DadtlERgXl+PCcB/ZP64rgWuKCQ9O4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871557;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JezFkjdqhjnmqC0qyUaWCRx0ozRcLFp9Lm+dWklxBpk=;
	b=sTMZBy3VLm9jfd1/rWgXubbNu2zGvR+/plXDIYp+6Z3yf2t8wiaeODQBBDV5dSGqkD08
	 f7Cu7wAJ5zFqkhJDLmBMH0ZFSWWq96H3ktxc1dWAe/Wubqkmu1tBChJWD67kbEeIHH8B7
	 g+A4HZ+/e4zCU5uY2Yx45K9BsPA414PXoTBR1L24lGh2VTR+w79i+VJYbsyHswifm2iAB
	 M+ZapD7E6MOSpUhCHbpAS1S04S9BByMP2QqwDKpy4fxHTzEn1c9voJZVrvnO557tcbAId
	 Xa5DEOvWO48OwVHHEwSjX4DsWyKten7TbCryUL5vOTorBJSeEvrbUzlZWHYAxnxy5IQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871557;
	bh=JezFkjdqhjnmqC0qyUaWCRx0ozRcLFp9Lm+dWklxBpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RCW1DOi/aBBV88LLBIJwsD1+tPi4D/tybqx4jPbzElzjsQ06Pi1ZFSWlx+q5htrzH
	 PUcnksh7wsC+l+8cNwHmsMFxiE8HIouf2MNVs9bEse6jYwNsiGFNnLZ1vJxbxN/CE2
	 L2+IZz1M/cKzHzZ2B0qZKanIT2Z4vvRqa108XvoHelFe/qlaLDfhFb+hcTzZ5Lx12T
	 je4lWzBe34HnCWNj0+BA2MmrE6VfHYqQbVbOidtRWPPj0rMuG0CQdXTEN6ZaQjY2h2
	 +WWvK5b+KradXX8zdzImcOQMxgg1sCb1uXfSbxM4NGL/PjUb+oQfI4uGW/d6Sv/GsR
	 X/V8wVI99PVGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6286810BB;
	Sat, 28 Nov 2026 13:12:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E10F93D9
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D2917606ED
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1bgntaCYSQ4Y for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:12:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8F5D960623
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=niWVcrq0
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8F5D960623
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:22 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso86386485e9.0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871540; x=1796476340;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JezFkjdqhjnmqC0qyUaWCRx0ozRcLFp9Lm+dWklxBpk=;
 b=niWVcrq07YKCg8oHk8FgZKSVAXBkAx02WgcjL9CfSCR/yXVmYydA4z+SAbGbMAFRWk
 TYjqk1c2hj0UYDzwg8aUfl0jv0oLKMgmTGQP3DD+Ej7W/JUTuFiQQdLo5jTdeZw+GtDI
 qfNE/je6SpLdQaQWXYQYLaobo7CJE/G6Vi7M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871540; x=1796476340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JezFkjdqhjnmqC0qyUaWCRx0ozRcLFp9Lm+dWklxBpk=;
 b=o3WScW1aoOnlAZIdYtAWFUPA7uKXsiCdb9i75c7NnpigK7FAj/uKUNw8Uud/+5XK90
 bOLRf3BSj/Z8Q5BVq2/1E64jHNXbiZCe3oBTYIHaLjROb5Ffc3UQLKmNmXeTOVB2xw6i
 r9Pcr7Vg4YP/VmTZLbOk3xNqx0kCyYmOvYxNoFzpYy5WGydxW//VLeZKt/ZN6oOsSd3h
 w6nwUgiY8wiVS8hef/TLXoaSlu4JdYZibZWNEqhTIo++RomlsTmdFTFv/E+o7IpEjTZ5
 DBlBk7FDjZ/JpmNTnRAgGJcU9uaKtclWP42vuWHvArKlHibxQ3aYZLeIz4owk6K3hXOh
 dLGA==
X-Forwarded-Encrypted: i=1;
 AL+hErFZ+mfvKcG4YtYVc1uSGsSBer5DhwZQJDFrdIkwV6hBjbaqsVpam2MGCH+vbFAFPfnVtW1k0Jg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9108JGmj946mqBeJ+LL4z4r1pL6mqfbt0NzYv/mLcrAg2le95A
 r91Vfkbc6SxC6hJpu4Gvag5x7K90tFWLK+REFF2ueXby/tjMLiw+n59IIcASnkVZxJM=
X-Gm-Gg: AZFdTZcyTRLao6HPe1i8gDbSJH7e+IMDBnLesfb31GeGmsMjFxDJVYthzeLjnQFOsMu
 mCHHJ6iWo6Ym3YTNukS3PSyE7Gq53exlOjWbyhmU2iU8ja681IPeSsDSt8AP2lsP5Xuexw2x5S5
 7Yr2GX7ilDNz1fsCSgWTd/KCR2Jbit37s++1QpmBqaYLdHXJMlf23O3Eyj6ct00vWg77SKa/NB3
 dwDlw2FDFUWu4PlzDd01hh//P8F7l+i4B/rkM1NBqKQOv3+YtDZbSZKFpD92pElS5CvYu92BTn5
 M89VCexFP8kqKCLxCbWdE60d7FUEKRZZclJ+E2rM4VhSRXKpMvCQZccIkjOdZsn3H/LGTLw1Rhv
 jA+Gxa8bc7C3XI7FJSmOa1kN+RtqwnQHpIEkPKoJCtMxersZlpnha+GH/YO13SGjjfIjqpu3KvW
 fThb5bbAt+j8UlpSlbUvXCVE6ai3IM9Hka7e4PKPKXDwn/8RejsXf5CMv7g03R46Ts5wPKTOOJE
 umBfzsVcfTecM6JwZBXHQ0jZ/72rqApZwf8mGplXNDXth147uzjOWUKuODHE9mPeUNGvlNFW33M
 RfBAVWUi+8J7G/9L3VPObybADe4U+rbx7WoKLswb9UJ2k+RlHaGKePJMsPbJuXk4L0x3v0ZXBV8
 0dq5YdiVyc6Y9blKDQRLRXSnA52LYl8wIh86QCrpDhxh/7m7z/X8NmzTdoXOkWXBsj9HYCudHeS
 vHotyUl9LUum9HJnX+yaIAjN2Gqg==
X-Received: by 2002:a05:600c:b8a:b0:4a0:20b4:ba93 with SMTP id
 5b1f17b1804b1-4bb88818156mr554760895e9.16.1795871540492; 
 Sat, 28 Nov 2026 05:12:20 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:12:20 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org (open list)
Subject: [PATCH v3 27/29] board: engicam: stm32mp2: add splash screen
Date: Sat, 28 Nov 2026 14:10:44 +0100
Message-ID: <20261128131125.2141352-28-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
References: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The U-Boot devicetree includes the overlays of all the supported
displays. Enable only the one selected by the "display" environment
variable.

The customer splash image is loaded from its partition, falling back to
the built-in logo.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

Changes in v3:
- Add Reviewed-by tag

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

