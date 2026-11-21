Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E488606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vbG9WtFH;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=hZdukpiJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A286F40ABD;
	Sat, 21 Nov 2026 12:35:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZDPy1hFKTMEP; Sat, 21 Nov 2026 12:35:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0E0E240A71
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264518;
	b=PGgBTMS6pWOp1Tz+38lHXeDiGdiGkSnQ9AzCm0bUGtPiSEisTfyHS5r/teVDHPaqN4mH
	 6cSGucu1xz4twEI0I/bzjgf42BiIPfzd1ecBWXlqXwt1RKqgZi6tYmnc8/kHyAMzCiFpw
	 xsGlpU5DxyvSnx3PuBTJ/om16nGN3aUkZEUld5DWcwK+xfBJxzTfbZxCXuLnqiDHiMt38
	 rt2BPOEBEsatnwY5tT0z9hWTkfOYvWdbdRpz9wnSrPo3Ff5DaanGFSsbiZjia1CD3Soxn
	 vEklNYjTn0qJTEV+Ki7MU+Ndz4vUF/YD67B+AOMZ7DctLeBzuTfNANRK0wwPN6jSvZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264518;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=L/1Y9kVbEClH3Vdo/FlP2BHAiuTJcXfb2WkDN6/sxKk=;
	b=iCF14kC8HMk49oDoAYq2aQQusTOZbqpXzi5GbZ2EdOihCSBt0nsNdwZa4htHz7VB+jFG
	 /Nno8fHBRysiMv3U7aieeDN1QqJjwOE0D+Nei1Qhrpazcz30sdhWWWRLtvUiUBhtNPvqC
	 3WkRLKJXAtuDsFDNPNfac7ytJEgVv1h4Mq4jTTi1gOYVmIDps4GnuVrZ/p0MKVGUOc11m
	 uxCR3tWIb9mHfZGy7Q6rNanet+olIzOKXtB4KNDOHwH1M3/k83Z3GDUdpaiMDoB14fZxJ
	 jL0chlXrDgnwnOOgV/U3mBr5C8apMeZl/E/nwotNSEMKuuPEatdsE8XStSJw3ZTibjA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264518;
	bh=L/1Y9kVbEClH3Vdo/FlP2BHAiuTJcXfb2WkDN6/sxKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vbG9WtFHyf2UgjmamL3lBFPGD+FE/4NNodUxwvkKxReuYHpH1eP0etGdtp2G99p/E
	 PPFFzLkhBAePrdGUSKAF8yQjVO8d6RzMq3jREjU/V3B0dFz6tR8+wnqK7v6TcV8+0W
	 QVRkKe0Rr7lOkjq2+p8Gvk2FbJzghtJOb8Iz61Tj99sLXFXlg5hqFtmrxVvViHChFQ
	 1tboh1r7MsKpHWZNEbZfXr0G+Z7mZTgaXQ2ZteKOxjPa7uZoLGqa+xYcDwoUQD1999
	 wDDFtSFi6NcpGIE0/kmzx2LCPdNaY2G0IhPl6g838+h3ArQ5KFHaH/Jn2GNbJXqKtM
	 frixwShD4764A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E0E240A71;
	Sat, 21 Nov 2026 12:35:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 061AA3A8
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EC75960653
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PUjliieoXIZx for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 777F1605DA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=hZdukpiJ
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 777F1605DA
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:12 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-491846221ffso1424530f8f.3
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264510; x=1795869310;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L/1Y9kVbEClH3Vdo/FlP2BHAiuTJcXfb2WkDN6/sxKk=;
 b=hZdukpiJXjj80G9O2SYDPZkm/MX5sp4M42aqm7GUBvT/GnfLBt0QrOD1kOjkFRNWdR
 DkQ4eN7F0h13lGyCN/ElKJJ0pJ4FZB9Y6yYDKg0D5pyexKtM1a8dzOaXHos7VyTSRMdd
 5eGYLzV1pJ/aBbQMlVc/Ccn2yGRHz+nL447Bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264510; x=1795869310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L/1Y9kVbEClH3Vdo/FlP2BHAiuTJcXfb2WkDN6/sxKk=;
 b=R/ajcxE4wLJoXLYrtGK9NIckZJnLSKaqdl5FFtKuWseL9aOLvnvk7c9nxDK2DnzS1+
 AkYprY8y4gcO9fZzxzyYXdQawuCqGA3rVV010Ga60bG4It/WBz6BPTofQqqA51lUgXiL
 GwpLYHnk9EpHD5rRp7t5v6CusWrz7ZdFPymzbP1w0ZhlJ2KKzbvVqemdjv9if2bANAEB
 BitvMqV5BKzC0csdmEMkzPV8et8bMlLEdOoz+jokiVACGxbFy7AgskZuXrxKb3P+8I+1
 kTpRBlDHEqGZHtPoRVXyVMzoSBJyzOP/DBMLPX77UHkQmVIr3ScV9M18GFv8wN4sz2jr
 PuGQ==
X-Gm-Message-State: APuU4Z8iHJm1QI9RdmHZE1DQhgmr7NFvKvlFni2OAijGlafUPRz5+67m
 myxRR4NUQCZAyHDi7k8xEa1sOTviA7KduOvZVgnVD0PX94Vve5zRYXH1SdSTOeRc+rrLw2dkPpS
 1LYpE
X-Gm-Gg: AZFdTZet0fx27g5oOeSQpNAf8umAl06Ff7tz4PLo8jlyVYJ36c8VbYQr/YdisZlmON+
 F/eFe3cHhmlyQ5IECggDnYqZ2XtyX4uW4gC5HjHhSLmIGTtQj1L/l0PSJ/rOSsxxbSK8w7R6wFl
 pjfSSterNaai9h6+FvJ4YxYMflfSKlnrMNBGwqd1QrS8L/kjLcjjia6aYxHZO0GocLoh7mbg8mA
 lgb6E4Yhcd1pBA5BF5ILvdR46nhb8FOd3CN9Qf0u5l4/oc5qEsPe+3xrazYic8fF42P8slkF/yu
 rSAxgE1iS54U1vCy6yKgulTngSMIRBJI9fLHTUbNQMIia+pWlYaNaqIoVeHXUIdSdQTQlPcLT4T
 MBxuLD5jc8Cjr9k3ezJs5LIKzA3kYVm9uEAr6+4XoiK7YmDqNe2Tj9hV2KmfjjhYuN0ubUiFoZg
 Cjb9r3n/HLIQix4K8JzGR10qHmudOnZZ1TE386WnuMb+5qBnIQzkoBJAdym47PZYVslqxcVPtuV
 INwmSOENkEfJ0l/RfnpEMu3it/YPouVBiXbD5PH5HPLoAd+XVn39XqJoxg2goYmZ9nSKwyhRHyo
 mlxqVmvxRekSF2fSNueRQbaiW23h9VKtLiASZbBr9FZ5959OUCJ1QPKUXIqBOznASA7VMQ7czDJ
 3YvQ8y2qaNHC+sEPzp/GibOgqwE0dolSUBmhxn+9tudu9ShY3207RXCwIe/JomYeHbI2hA4sbmC
 pyTBphVxmTWjEvfw6HKxakJs5zpQ==
X-Received: by 2002:a05:6000:4a15:b0:4ab:97ca:c110 with SMTP id
 ffacd0b85a97d-4abb2ecfb9dmr10973829f8f.27.1795264510322; 
 Sat, 21 Nov 2026 04:35:10 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:35:09 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 David Lechner <dlechner@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 07/25] video: Add video link framework
Date: Sat, 21 Nov 2026 13:33:57 +0100
Message-ID: <20261121123451.2471185-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
References: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
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

From: Michael Trimarchi <michael@amarulasolutions.com>

The video link framework uses the port-endpoint graph of the device
tree to connect the video components (video, display, bridge and panel
uclasses).

Several video links can be described this way, and the user can select
one of them for the splash screen.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

Changes in v2:
- Look up a device as a bridge before looking it up as a DSI host
- Reword commit message

 common/stdio.c             |   4 +
 drivers/video/Kconfig      |   6 +
 drivers/video/Makefile     |   1 +
 drivers/video/video_link.c | 448 +++++++++++++++++++++++++++++++++++++
 include/video_link.h       |  19 ++
 5 files changed, 478 insertions(+)
 create mode 100644 drivers/video/video_link.c
 create mode 100644 include/video_link.h

diff --git a/common/stdio.c b/common/stdio.c
index 271a37e959ca..b441710388c3 100644
--- a/common/stdio.c
+++ b/common/stdio.c
@@ -17,6 +17,7 @@
 #include <stdio_dev.h>
 #include <serial.h>
 #include <splash.h>
+#include <video_link.h>
 #include <i2c.h>
 #include <dm/device-internal.h>
 
@@ -321,6 +322,9 @@ int stdio_add_devices(void)
 		struct udevice *vdev;
 		int ret;
 
+		if (IS_ENABLED(CONFIG_VIDEO_LINK))
+			video_link_init();
+
 		if (!IS_ENABLED(CONFIG_SYS_CONSOLE_IS_IN_ENV)) {
 			for (ret = uclass_first_device_check(UCLASS_VIDEO,
 							     &vdev);
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index de0197b21cdb..cc21afbe8ff5 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -973,6 +973,12 @@ config VIDEO_SEPS525
 source "drivers/video/zynqmp/Kconfig"
 source "drivers/video/nexell/Kconfig"
 
+config VIDEO_LINK
+	bool "Enable video link framework support"
+	help
+	   This option enables a video link framework basing on port-endpoint graph
+	   to connect video components.
+
 config CONSOLE_SCROLL_LINES
 	int "Number of lines to scroll the console by"
 	default 1
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 7a7b54e6b53b..6e6d1ba29cdb 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_$(PHASE_)SIMPLE_PANEL) += simple_panel.o
 obj-$(CONFIG_VIDEO_LOGO) += u_boot_logo.bmp.o
 obj-$(CONFIG_$(PHASE_)BMP) += bmp.o
 
+obj-$(CONFIG_VIDEO_LINK) += video_link.o
 endif
 
 obj-$(CONFIG_BACKLIGHT_AAT2870) += aat2870_backlight.o
diff --git a/drivers/video/video_link.c b/drivers/video/video_link.c
new file mode 100644
index 000000000000..aab4b2a9ed99
--- /dev/null
+++ b/drivers/video/video_link.c
@@ -0,0 +1,448 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2020 NXP
+ *
+ */
+
+#include <command.h>
+#include <linux/errno.h>
+
+#include <dm.h>
+#include <dm/uclass-internal.h>
+#include <dm/device-internal.h>
+#include <dm/ofnode.h>
+#include <dm/ofnode_graph.h>
+#include <dm/read.h>
+#include <video.h>
+#include <panel.h>
+#include <env.h>
+
+struct of_endpoint {
+	unsigned int port;
+	unsigned int id;
+	ofnode local_node;
+};
+
+#define MAX_LINKS 3
+#define MAX_LINK_DEVICES 5
+
+struct video_link {
+	struct udevice *link_devs[MAX_LINK_DEVICES];
+	int dev_num;
+};
+
+struct video_link video_links[MAX_LINKS];
+struct video_link temp_stack;
+ulong video_links_num;
+ulong curr_video_link;
+bool video_off;
+
+ofnode ofnode_get_child_by_name(ofnode parent, const char *name)
+{
+	ofnode child;
+	const char *child_name;
+
+	for (child = ofnode_first_subnode(parent);
+	     ofnode_valid(child);
+	     child = ofnode_next_subnode(child)) {
+		child_name = ofnode_get_name(child);
+
+		if (!strncmp(child_name, name, strlen(name)))
+			break;
+	}
+	return child;
+}
+
+ofnode ofnode_graph_get_next_endpoint(ofnode parent,
+				      ofnode prev)
+{
+	ofnode endpoint;
+	ofnode port;
+	const char *name;
+
+	if (!ofnode_valid(prev)) {
+		ofnode node;
+
+		node = ofnode_find_subnode(parent, "ports");
+		if (ofnode_valid(node))
+			parent = node;
+
+		port = ofnode_get_child_by_name(parent, "port");
+		if (!ofnode_valid(port)) {
+			debug("no port node found in 0x%lx\n", parent.of_offset);
+			return ofnode_null();
+		}
+
+		endpoint = ofnode_first_subnode(port);
+		if (ofnode_valid(endpoint)) {
+			debug("get next endpoint %s\n", ofnode_get_name(endpoint));
+			return endpoint;
+		}
+	} else {
+		port = ofnode_get_parent(prev);
+		endpoint = ofnode_next_subnode(prev);
+		if (ofnode_valid(endpoint)) {
+			debug("get next endpoint %s\n", ofnode_get_name(endpoint));
+			return endpoint;
+		}
+	}
+
+	debug("port %s\n", ofnode_get_name(port));
+
+	while (1) {
+		do {
+			port = ofnode_next_subnode(port);
+			if (!ofnode_valid(port))
+				return ofnode_null();
+
+			name = ofnode_get_name(port);
+		} while (strncmp(name, "port", 4));
+
+		/*
+		 * Now that we have a port node, get the next endpoint by
+		 * getting the next child. If the previous endpoint is NULL this
+		 * will return the first child.
+		 */
+		endpoint = ofnode_first_subnode(port);
+		if (ofnode_valid(endpoint)) {
+			debug("get next endpoint %s\n", ofnode_get_name(endpoint));
+			return endpoint;
+		}
+	}
+
+	return ofnode_null();
+}
+
+#define for_each_endpoint_of_node(parent, child) \
+	for (child = ofnode_graph_get_next_endpoint(parent, ofnode_null()); ofnode_valid(child); \
+	     child = ofnode_graph_get_next_endpoint(parent, child))
+
+int ofnode_graph_parse_endpoint(ofnode node,
+				struct of_endpoint *endpoint)
+{
+	ofnode port_node = ofnode_get_parent(node);
+
+	memset(endpoint, 0, sizeof(*endpoint));
+
+	endpoint->local_node = node;
+	/*
+	 * It doesn't matter whether the two calls below succeed.
+	 * If they don't then the default value 0 is used.
+	 */
+	ofnode_read_u32(port_node, "reg", &endpoint->port);
+	ofnode_read_u32(node, "reg", &endpoint->id);
+
+	return 0;
+}
+
+int find_device_by_ofnode(ofnode node, struct udevice **pdev)
+{
+	int ret;
+
+	if (!ofnode_is_enabled(node))
+		return -2;
+
+	ret = uclass_find_device_by_ofnode(UCLASS_DISPLAY, node, pdev);
+	if (!ret)
+		return 0;
+
+	/*
+	 * A bridge may bind its DSI host to its own node: in that case the
+	 * bridge, not the host, is the device in the video link.
+	 */
+	ret = uclass_find_device_by_ofnode(UCLASS_VIDEO_BRIDGE, node, pdev);
+	if (!ret)
+		return 0;
+
+	ret = uclass_find_device_by_ofnode(UCLASS_DSI_HOST, node, pdev);
+	if (!ret)
+		return 0;
+
+	ret = uclass_find_device_by_ofnode(UCLASS_PANEL, node, pdev);
+	if (!ret)
+		return 0;
+
+	return -1;
+}
+
+static void video_link_stack_push(struct udevice *dev)
+{
+	if (temp_stack.dev_num < MAX_LINK_DEVICES) {
+		temp_stack.link_devs[temp_stack.dev_num] = dev;
+		temp_stack.dev_num++;
+	}
+}
+
+static void video_link_stack_pop(void)
+{
+	if (temp_stack.dev_num > 0) {
+		temp_stack.link_devs[temp_stack.dev_num] = NULL;
+		temp_stack.dev_num--;
+	}
+}
+
+static int duplicate_video_link(void)
+{
+	if (video_links_num < MAX_LINKS) {
+		video_links[video_links_num] = temp_stack;
+		video_links_num++;
+
+		debug("duplicate links num %lu,  temp_stack num %d\n",
+		      video_links_num, temp_stack.dev_num);
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
+static void video_link_add_node(struct udevice *peer_dev, struct udevice *dev, ofnode dev_node)
+{
+	int ret = 0;
+	ofnode remote, endpoint_node;
+	struct udevice *remote_dev;
+	bool find = false;
+
+	debug("endpoint cnt %d\n", ofnode_graph_get_endpoint_count(dev_node));
+
+	video_link_stack_push(dev);
+
+	for_each_endpoint_of_node(dev_node, endpoint_node) {
+		remote = ofnode_graph_get_remote_port_parent(endpoint_node);
+		if (!ofnode_valid(remote))
+			continue;
+
+		debug("remote %s\n", ofnode_get_name(remote));
+		ret = find_device_by_ofnode(remote, &remote_dev);
+		if (!ret) {
+			debug("remote dev %s\n", remote_dev->name);
+
+			if (peer_dev && peer_dev == remote_dev)
+				continue;
+
+			/* it is possible that ofnode of remote_dev is not equal to remote */
+			video_link_add_node(dev, remote_dev, remote);
+
+			find = true;
+		}
+	}
+
+	/* leaf node or no valid new endpoint, now copy the entire stack to a new video link */
+	if (!find) {
+		ret = duplicate_video_link();
+		if (ret)
+			printf("video link is full\n");
+	}
+
+	video_link_stack_pop();
+}
+
+struct udevice *video_link_get_next_device(struct udevice *curr_dev)
+{
+	int i, ret;
+
+	if (video_off)
+		return NULL;
+
+	if (curr_video_link >= video_links_num) {
+		printf("current video link is not correct\n");
+		return NULL;
+	}
+
+	for (i = 0; i < video_links[curr_video_link].dev_num; i++) {
+		if (video_links[curr_video_link].link_devs[i] == curr_dev) {
+			if ((i + 1) < video_links[curr_video_link].dev_num) {
+				ret = device_probe(video_links[curr_video_link].link_devs[i + 1]);
+				if (ret) {
+					printf("probe device is failed, ret %d\n", ret);
+					return NULL;
+				}
+
+				return video_links[curr_video_link].link_devs[i + 1];
+			}
+
+			debug("fail to find next device, already last one\n");
+			return NULL;
+		}
+	}
+
+	return NULL;
+}
+
+struct udevice *video_link_get_video_device(void)
+{
+	int ret;
+
+	if (video_off)
+		return NULL;
+
+	if (curr_video_link >= video_links_num)
+		return NULL;
+
+	if (video_links[curr_video_link].dev_num == 0)
+		return NULL;
+
+	ret = device_probe(video_links[curr_video_link].link_devs[0]);
+	if (ret) {
+		printf("probe video device failed, ret %d\n", ret);
+		return NULL;
+	}
+
+	return video_links[curr_video_link].link_devs[0];
+}
+
+int video_link_get_display_timings(struct display_timing *timings)
+{
+	int i = 0;
+	int ret;
+	struct udevice *dev;
+
+	if (video_off)
+		return -EPERM;
+
+	if (curr_video_link >= video_links_num)
+		return -ENODEV;
+
+	if (video_links[curr_video_link].dev_num == 0)
+		return -ENODEV;
+
+	for (i = video_links[curr_video_link].dev_num - 1; i >= 0 ; i--) {
+		dev = video_links[curr_video_link].link_devs[i];
+		if (device_get_uclass_id(dev) == UCLASS_PANEL) {
+			ret = device_probe(video_links[curr_video_link].link_devs[i]);
+			if (ret) {
+				printf("fail to probe panel device %s\n", dev->name);
+				return ret;
+			}
+
+			ret = panel_get_display_timing(dev, timings);
+			if (ret) {
+				ret = ofnode_decode_display_timing(dev_ofnode(dev), 0, timings);
+				if (ret) {
+					printf("fail to get panel timing %s\n", dev->name);
+					return ret;
+				}
+			}
+
+			return 0;
+		} else if (device_get_uclass_id(dev) == UCLASS_DISPLAY ||
+			   device_get_uclass_id(dev) == UCLASS_VIDEO) {
+			ret = ofnode_decode_display_timing(dev_ofnode(dev), 0, timings);
+			if (!ret)
+				return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static void list_videolink(bool current_only)
+{
+	ulong index = 0;
+	int j;
+	bool match;
+
+	/* dump the link */
+	debug("video link number: %lu\n", video_links_num);
+
+	for (index = 0; index < video_links_num; index++) {
+		match = false;
+		if (curr_video_link == index)
+			match = true;
+		else if (current_only)
+			continue;
+
+		printf("[%c]-Video Link %lu", (match) ? '*' : ' ', index);
+
+		if (match) {
+			struct udevice *video_dev = video_link_get_video_device();
+
+			if (video_dev) {
+				printf(" (%u x %u)", video_get_xsize(video_dev),
+				       video_get_ysize(video_dev));
+			}
+		}
+
+		printf("\n");
+
+		for (j = 0; j < video_links[index].dev_num; j++) {
+			printf("\t[%d] %s, %s\n", j, video_links[index].link_devs[j]->name,
+			       dev_get_uclass_name(video_links[index].link_devs[j]));
+		}
+	}
+}
+
+static int do_videolink(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
+{
+	char cmd = 'l';
+	int ret = 0;
+
+	if (argc > 1)
+		cmd = argv[1][0];
+
+	switch (cmd) {
+	case 'l':		/* list */
+		list_videolink(false);
+		break;
+	default:
+		ret = CMD_RET_USAGE;
+		break;
+	}
+
+	return ret;
+}
+
+int video_link_init(void)
+{
+	struct udevice *dev;
+	ulong env_id;
+	int off;
+
+	memset(&video_links, 0, sizeof(video_links));
+	memset(&temp_stack, 0, sizeof(temp_stack));
+
+	for (uclass_find_first_device(UCLASS_VIDEO, &dev);
+	     dev;
+	     uclass_find_next_device(&dev)) {
+		video_link_add_node(NULL, dev, dev_ofnode(dev));
+	}
+
+	if (video_links_num == 0) {
+		printf("Fail to setup video link\n");
+		return -ENODEV;
+	}
+
+	/* Read the env variable for default video link */
+	off = env_get_yesno("video_off");
+	if (off == 1) {
+		video_off = true;
+		return 0;
+	}
+
+	env_id = env_get_ulong("video_link", 10, 0);
+	if (env_id < video_links_num)
+		curr_video_link = env_id;
+
+	list_videolink(true);
+
+	return 0;
+}
+
+int video_link_shut_down(void)
+{
+	struct udevice *video_dev = video_link_get_video_device();
+
+	if (video_dev)
+		device_remove(video_dev, DM_REMOVE_NORMAL);
+
+	return 0;
+}
+
+#if CONFIG_IS_ENABLED(SYS_LONGHELP)
+static char video_link_help_text[] =
+	"list\n"
+	"    -  show video link info, set video_link variable to select link";
+#endif
+
+U_BOOT_CMD(videolink,	5,	1,	do_videolink,
+	   "list and select video link", video_link_help_text
+);
diff --git a/include/video_link.h b/include/video_link.h
new file mode 100644
index 000000000000..5350bfa9e9d1
--- /dev/null
+++ b/include/video_link.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2020 NXP
+ */
+
+#ifndef __VIDEO_LINK
+#define __VIDEO_LINK
+
+int video_link_init(void);
+
+int video_link_shut_down(void);
+
+struct udevice *video_link_get_next_device(struct udevice *curr_dev);
+
+struct udevice *video_link_get_video_device(void);
+
+int video_link_get_display_timings(struct display_timing *timings);
+
+#endif
-- 
2.43.0

