Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEFDFA3738
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6DAF88D4A;
	Fri, 13 Sep 2024 11:57:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iSg7Dg9g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8107288D47; Fri, 13 Sep 2024 11:57:17 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E1F788BBF
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:57:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a8d2daa2262so73651266b.1
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726221430; x=1726826230;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5x3GP+YKQVY12npakM9KZwdv485eryAZdD/Wk+gMeNY=;
 b=iSg7Dg9g0TYj77Cx20/oO7aTiAqZnN0wwDqo/889d7n1edR4GQCX5qBHX7A1Qodxpk
 tU+2lireJnrQ4ueDS2u/VHT7h2NkC0yCwQKPrS7PdoVNEVrcUNVcqFC27S5ZDscJNRTD
 2Xhxd55LGNncDr8vQHLWucyz8g2TY8h7hp4yY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221430; x=1726826230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5x3GP+YKQVY12npakM9KZwdv485eryAZdD/Wk+gMeNY=;
 b=cae9WKljedvV8I4AwQiDLq3JWDLiMHTiIc5GGw43+Pd/4PC43uaZ0VtkpG894XbCbd
 VCQYfInOxtmLzPE2GMkzh/Viki4zDMjAvKPYny73QVdwethMlZj/SHJNGZcZtArlWpDX
 7QpcvuetZ1a4IFV9+bWOCsl45CXbId7uHeCvWw3fYTujts9jWKPOIj9Ap/I2RLpCIAYz
 OW4JCCmKtzb9y4MFn+d4rCrAMVMOxlJqJHOMqNfnHr9ysxXuJIzWxOSfDslxeeMyg0Ja
 SWFK2sNnOSICz0OUPov4Aj0ok0cIt8pwljt+CG9MRFyn62M2aZtkWOQk+C9GN6GLsjzy
 82Cg==
X-Gm-Message-State: AOJu0Yyav9Vfwg7Gb2GKogooyVXVFXUyWhSq/d989m6weXIc/QNUm67d
 ol3QxcRtSVEX4LfMcUCUw7UXcp8UOaRP58CoiIEzAeHrWjdY4SZTYp9IfLofOFno9DVzW1DV/TW
 Hg/s=
X-Google-Smtp-Source: AGHT+IE/Yh20i9ObmiieZybUQVjbPQ2pcUE3EeTxScup1Rwn45cGhVE+J6McMTGEvdWpTk4H1x3EbA==
X-Received: by 2002:a17:907:d1a:b0:a8d:3338:a48c with SMTP id
 a640c23a62f3a-a9047b459c1mr164962666b.7.1726221430315; 
 Fri, 13 Sep 2024 02:57:10 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:57:09 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Ye Li <ye.li@nxp.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>,
 Anton Bambura <jenneron@protonmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/26] video: Add video link framework
Date: Fri, 13 Sep 2024 11:55:51 +0200
Message-ID: <20240913095622.72377-10-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Michael Trimarchi <michael@amarulasolutions.com>

The video link framework bases a port-endpoint gragh in DTB to
connect the video components in uclass like: video, display, bridge,
and panel.

Using the port-endpoint gragh, we manage multiple video link and
user can select one of them for splash screen.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 common/stdio.c             |   4 +
 drivers/video/Kconfig      |   6 +
 drivers/video/Makefile     |   1 +
 drivers/video/video_link.c | 529 +++++++++++++++++++++++++++++++++++++
 include/video_link.h       |  19 ++
 5 files changed, 559 insertions(+)
 create mode 100644 drivers/video/video_link.c
 create mode 100644 include/video_link.h

diff --git a/common/stdio.c b/common/stdio.c
index a61220ce4b9c..66360c97ed12 100644
--- a/common/stdio.c
+++ b/common/stdio.c
@@ -17,6 +17,7 @@
 #include <stdio_dev.h>
 #include <serial.h>
 #include <splash.h>
+#include <video_link.h>
 #include <i2c.h>
 #include <asm/global_data.h>
 #include <dm/device-internal.h>
@@ -340,6 +341,9 @@ int stdio_add_devices(void)
 		struct udevice *vdev;
 		int ret;
 
+		if (IS_ENABLED(CONFIG_VIDEO_LINK))
+			video_link_init();
+
 		if (!IS_ENABLED(CONFIG_SYS_CONSOLE_IS_IN_ENV)) {
 			for (ret = uclass_first_device_check(UCLASS_VIDEO,
 							     &vdev);
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 6e79694fd192..cafdc15f9fe2 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -833,6 +833,12 @@ config VIDEO_SEPS525
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
index f3f70cd04a17..9fd3645994f1 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_$(SPL_TPL_)SIMPLE_PANEL) += simple_panel.o
 obj-$(CONFIG_VIDEO_LOGO) += u_boot_logo.o
 obj-$(CONFIG_$(SPL_TPL_)BMP) += bmp.o
 
+obj-$(CONFIG_VIDEO_LINK) += video_link.o
 endif
 
 obj-$(CONFIG_BACKLIGHT_LM3533) += lm3533_backlight.o
diff --git a/drivers/video/video_link.c b/drivers/video/video_link.c
new file mode 100644
index 000000000000..001a759faab9
--- /dev/null
+++ b/drivers/video/video_link.c
@@ -0,0 +1,529 @@
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
+int ofnode_graph_get_endpoint_count(ofnode node)
+{
+	ofnode endpoint;
+	int num = 0;
+
+	for_each_endpoint_of_node(node, endpoint)
+		num++;
+
+	return num;
+}
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
+ofnode ofnode_graph_get_endpoint_by_regs(const ofnode parent,
+					 int port_reg, int reg)
+{
+	struct of_endpoint endpoint;
+	ofnode node;
+
+	for_each_endpoint_of_node(parent, node) {
+		ofnode_graph_parse_endpoint(node, &endpoint);
+		if (((port_reg == -1) || endpoint.port == port_reg) &&
+		    ((reg == -1) || endpoint.id == reg)) {
+			debug("get node %s\n", ofnode_get_name(node));
+
+			return node;
+		}
+	}
+
+	return ofnode_null();
+}
+
+ofnode ofnode_graph_get_remote_endpoint(ofnode node)
+{
+	ofnode remote;
+	u32 phandle;
+	int ret;
+
+	ret = ofnode_read_u32(node, "remote-endpoint", &phandle);
+	if (ret) {
+		printf("required remote-endpoint property isn't provided\n");
+		return ofnode_null();
+	}
+
+	remote = ofnode_get_by_phandle(phandle);
+	if (!ofnode_valid(remote)) {
+		printf("failed to find remote-endpoint\n");
+		return ofnode_null();
+	}
+
+	return remote;
+}
+
+ofnode ofnode_graph_get_port_parent(ofnode node)
+{
+	unsigned int depth;
+
+	if (!ofnode_valid(node))
+		return ofnode_null();
+
+	/*
+	 * Preserve usecount for passed in node as of_get_next_parent()
+	 * will do of_node_put() on it.
+	 */
+
+	/* Walk 3 levels up only if there is 'ports' node. */
+	for (depth = 3; depth && ofnode_valid(node); depth--) {
+		node = ofnode_get_parent(node);
+		const char *name = ofnode_get_name(node);
+
+		if (depth == 2 && strcmp(name, "ports"))
+			break;
+	}
+	return node;
+}
+
+ofnode ofnode_graph_get_remote_port_parent(ofnode node)
+{
+	ofnode np, pp;
+
+	/* Get remote endpoint node. */
+	np = ofnode_graph_get_remote_endpoint(node);
+
+	pp = ofnode_graph_get_port_parent(np);
+
+	return pp;
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
+	ret = uclass_find_device_by_ofnode(UCLASS_DSI_HOST, node, pdev);
+	if (!ret)
+		return 0;
+
+	ret = uclass_find_device_by_ofnode(UCLASS_VIDEO_BRIDGE, node, pdev);
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

