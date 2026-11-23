Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311E4606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H8YIlOmF;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lAyR04a3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6AC5840662;
	Mon, 23 Nov 2026 23:03:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zwZFimfHmd6I; Mon, 23 Nov 2026 23:03:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C3FF740653
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795474986;
	b=XtI8KGHju1INwRyvIKJlJfpfnxaRj21b9o4PY04XmXZUkNSzjTevb3pE+NzNibh/yK0W
	 T4vuqcj3k54WuOUsAizjHLWtjDtmg0GQZYgLcQ1SiKrpPr0oJ6ivjleK2TlV+ADIngXFP
	 f7vT2GubhdXPwt8l8UNOTeCa1LVRycu6gkAtQgDXtUhlI4x9yxrJe2dj7bUWCvKTbP8+u
	 I2FM41f7ub5uauK8XmazVLwEnfFNBlWnURe28bbSN+rfmENfk6wb5waH/+5ZEROgD8DRx
	 VamwUbu3Y0+xSA8MdaQ0d2lWBL8uwmxnygaxg+Xicq17PHUwNb+lCNaJHq4cy9sAcPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795474986;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=CHBgCqj6KTLeFiwQ1yVJB/sxKQW1FXl5Zov99okYfoM=;
	b=R+s9nsaNa/DFjZCD2lh1mZteYCnzWCnvEl1bhr2SGt4fVNbVDnupAaHZS/Pn5VPI/wrM
	 83BGWxBah9Dy/vHTlhtdsct6c6+MWiO+o85Mq/hQnSMw4qIrKMN5xA3xB3qjo+/pfhWag
	 zC2tpaJXGKs+qNhU26YIl/Nc1AOanXIOiOVB6dJGhCB1UcJMv2q5sQDDeahhZnfr2B4kK
	 ZdxW+OeI/Tdo8fz75XR32Hrzpk3jYMatF3DYBKep5dUY67MFpzqBEOnUvkaif3VQ3rOmo
	 AbD8Z/hzinkw35VNHrkUpwHgAEff34IaaPQHpk8di9j99kuGvQ7edveiIQDbG+8JwjQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795474986;
	bh=CHBgCqj6KTLeFiwQ1yVJB/sxKQW1FXl5Zov99okYfoM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H8YIlOmFdIAg4pTVrB0EU7RJrUl/dYS43T/d5hzVFdGq1QQW8Ckcn2Ee1gxXp91ng
	 cLcOWTcxdpnvLbCI7g3ChzJ1HfDu+7KP+8EsT/bLfYIBJCT9l7e67yn1VCWJCC8sXz
	 XBZOa3KY+k0kvWjq3bUycSXjp/WZ8seoP5vaSnlWfYz+P2LzHY59AXztxlssqjUX/+
	 SMYAkwCU7bM3WeesfP4NT/CsIA2hP7SfDLP6XP9D+ilC8Vq2+bt1ksBwroycOdTAtN
	 Ck927xKTee9mcwxhC/wM3mwzWXiIoTcxp8s5jMpnJ083RZxiXPYo9uPdR8yQHYb1bk
	 kWKzIVAQr8koQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3FF740653;
	Mon, 23 Nov 2026 23:03:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CC4583A8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:03:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BE29B401D1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:03:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bdeX6KR0Y3sy for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 23:03:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2E167400E0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=lAyR04a3
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2E167400E0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:03:02 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-716c0217635so4704655eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795474981; x=1796079781;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CHBgCqj6KTLeFiwQ1yVJB/sxKQW1FXl5Zov99okYfoM=;
 b=lAyR04a3we1NPmv8dJq8bFQN9q/O2WNECo62iygGDOyLk/wuMaNDxScKzv4lWoPxYS
 urtBqVEILE88D8H4Jm88QzNY5h/jZneSjfIRIHHpZznu8hcnhPp6zLRwAz1J6PWLn1b3
 uVqkSYaUkK6KoggxZXL96B0GqDGs2XbFKF6RzoD/Ruf51CLsFd21k9mnCmejoZ8gpWvj
 AP9qqlED67BLkENhOubmlfzkU3OYgwg9ImqrXRN5J3kB/cL5uqTqh7xgh5cu91Pj+PBS
 m89m2QTgW8fheU4XiJEXa004jOZxYi9H8JN8hXS8JEeISawBpfslOmqGyajIxFhs0akr
 +aVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795474981; x=1796079781;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CHBgCqj6KTLeFiwQ1yVJB/sxKQW1FXl5Zov99okYfoM=;
 b=nwxcu7X2GCeoYRBjxMCkLZipuJ5K7xFchkJ0Zf8DGfcUlanBugpBa3KxD04F0V7oOs
 9skRmQngxA3ikU0A+YjB2Lxnss88CoV23sUf7jyPQBSYMLqnt+9usDANYPFRhfeNQRV3
 r/JBGC/uGGN9UDReOe3V3O9QITs8F2Vy0ajHiCvBzFB14aIjw9eykUxW7S5146tBy3ZP
 V+HU038xnrWAVp3Ys7fshKA7x8qZWz4XU2StK/y6ffwfwo7Mll2nWzfhYulviZCTYjSG
 23kyzsMWl+v6qRKkzIG7rI9pKSPfCy7lPwjN9zd5b9BKDtPMo2AXDHsGdCj4ynh3Ixcm
 U97A==
X-Gm-Message-State: APuU4Z9SpWmoloil95YV9n0buAVd5WFU7TyUSObUe3psNx/1Lr1TbW37
 5bzOLFsaqXpDuKzdRczrMT4S8iPk4tqL5Tb9+CKfLcUlJw0OvFxEdYYP
X-Gm-Gg: AZFdTZczzfHTzy4rymEd4vtSWnDRUDLK1Od11Z0HaqG2rPcUaiiP3wh1a475jVOBhE5
 lA9w2pGuRGWEGtGatpuju+cRQSj9a44KuW9ZttgH30gStTi08FZj6vPreDrO5JVlLK1PSb67hXy
 7z3FYiUHS2+7uyTHaAi26ciN7nOxylqZqdy6bJ8NUvdJ8u3N0lS9Nm4cVFkI8yXQxwjo4PSbagx
 W3WFclvKCmWG/4KFFkyQnu5u16CcJkgxwc+v5GZkzAEGjRU0IP5qWYXVBkI79dZ2ckepEMC29ya
 Uvq1ClxzS7PZKdymz+D8+IGGCFJRCVZIR31NG8ajwrTPJiC8bN2zTa0DoJ0jqHkE3o9jYjaI7U+
 o+kw3FqLBQMXzA8fHSpK3/JBlcBYxcse7rXRwyR7VMk3iy7qO/pIS1hw/Bhx0FEKvSMEPN14bpp
 bJDgC5IUr2O690/boQm+xJG8NJ26Uh6MV5KZ2OIrncc+Tn+DFNyRF78VjSb8wyT77DSIvNaV4Js
 HR/+7Z5oO2v1SuQDtRddXdD7LfRDRxzOMCckQMJYPgMRVWE4rUF9//XP4n0TLOVyn1yMBUZThfa
 C4HhJamTpxBjtH/9iwaYR19OczX87oIYg7WnIgukV3blXTjkM+p8YxvRj08EN4rCnG0t1RvIwa3
 6vumnjGS9t0HXfR8UVn4HxugSRk9t3BKkk1dJlPrU6ovYhmVt5JFWibJKxHf0xMbiYKZOLqW4Vf
 l8xWwnjSYLZi3zGox+MuM0jWKxx2I9lw9dS/QURBJJr9HF012Ik84=
X-Received: by 2002:a05:6820:a504:20b0:719:d9b:d750 with SMTP id
 006d021491bc7-71b395e5a5bmr5347720eaf.38.1795474981470; 
 Mon, 23 Nov 2026 15:03:01 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b6b680b66sm701616eaf.9.2026.11.23.15.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 15:03:00 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 23 Nov 2026 16:02:56 -0700
Subject: [PATCH 1/2] net: lwip: serve Fastboot over UDP
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-submit-lwip-fastboot-v1-v1-1-34c1eff8b1f0@gmail.com>
References: <20261123-submit-lwip-fastboot-v1-v1-0-34c1eff8b1f0@gmail.com>
In-Reply-To: <20261123-submit-lwip-fastboot-v1-v1-0-34c1eff8b1f0@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Sam Day <me@samcday.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Simon Glass <sjg@chromium.org>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allow the fastboot command to listen on the selected lwIP interface.
Use the same UDP protocol engine for both network stacks. Restart the
command state on Init, negotiate the packet size and cache each
sequenced response for retransmission. A Query must not overwrite it.

Return one getvar:all or console response per host read so retrying that
read does not skip an INFO line. Run command handlers outside the lwIP
receive callback and release the interface before a boot or reboot.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 MAINTAINERS                |   2 +
 cmd/fastboot.c             |   7 ++
 drivers/fastboot/Kconfig   |   3 +-
 include/fastboot.h         |  16 +++
 include/net/fastboot_udp.h |   7 ++
 net/Makefile               |   1 +
 net/fastboot-udp-common.c  | 176 ++++++++++++++++++++++++++++
 net/fastboot_udp.c         | 284 ++-------------------------------------------
 net/lwip/Makefile          |   1 +
 net/lwip/fastboot_udp.c    |  96 +++++++++++++++
 10 files changed, 319 insertions(+), 274 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e8350b26c20..2400daab7bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1048,8 +1048,10 @@ F:	include/net/fastboot_tcp.h
 F:	include/net/fastboot_udp.h
 F:	drivers/fastboot/
 F:	drivers/usb/gadget/f_fastboot.c
+F:	net/fastboot-udp-common.c
 F:	net/fastboot_tcp.c
 F:	net/fastboot_udp.c
+F:	net/lwip/fastboot_udp.c
 F:	test/dm/fastboot.c
 
 FPGA
diff --git a/cmd/fastboot.c b/cmd/fastboot.c
index ace877b6e28..f8ec1374dcc 100644
--- a/cmd/fastboot.c
+++ b/cmd/fastboot.c
@@ -8,6 +8,7 @@
  */
 #include <command.h>
 #include <fastboot.h>
+#include <net/fastboot_udp.h>
 #include <net.h>
 #include <vsprintf.h>
 #include <linux/printk.h>
@@ -126,6 +127,12 @@ NXTARG:
 		return CMD_RET_USAGE;
 	}
 
+	if (IS_ENABLED(CONFIG_NET_LWIP) && IS_ENABLED(CONFIG_UDP_FUNCTION_FASTBOOT) &&
+	    !strcmp(argv[1], "udp")) {
+		fastboot_init((void *)buf_addr, buf_size);
+		return fastboot_udp_run() ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
+	}
+
 #if CONFIG_IS_ENABLED(NET_LEGACY)
 	if (!strcmp(argv[1], "udp"))
 		return do_fastboot_udp(argc, argv, buf_addr, buf_size);
diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 9a5251d4b60..07973ba0e53 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -28,7 +28,8 @@ config USB_FUNCTION_FASTBOOT
 	  This enables the USB part of the fastboot gadget.
 
 config UDP_FUNCTION_FASTBOOT
-	depends on NET_LEGACY
+	depends on NET
+	select PROT_UDP_LWIP if NET_LWIP
 	select FASTBOOT
 	bool "Enable fastboot protocol over UDP"
 	help
diff --git a/include/fastboot.h b/include/fastboot.h
index f3aa6fcc229..52801930d5d 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -170,6 +170,22 @@ void fastboot_boot(void);
  */
 void fastboot_handle_boot(int command, bool success);
 
+/* Commands whose successful response ends a network Fastboot session. */
+static inline bool fastboot_is_boot_command(int command)
+{
+	switch (command) {
+	case FASTBOOT_COMMAND_BOOT:
+	case FASTBOOT_COMMAND_CONTINUE:
+	case FASTBOOT_COMMAND_REBOOT:
+	case FASTBOOT_COMMAND_REBOOT_BOOTLOADER:
+	case FASTBOOT_COMMAND_REBOOT_FASTBOOTD:
+	case FASTBOOT_COMMAND_REBOOT_RECOVERY:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /**
  * fastboot_handle_command() - Handle fastboot command
  *
diff --git a/include/net/fastboot_udp.h b/include/net/fastboot_udp.h
index d4382c0a0e0..121b770411d 100644
--- a/include/net/fastboot_udp.h
+++ b/include/net/fastboot_udp.h
@@ -11,4 +11,11 @@
  */
 void fastboot_udp_start_server(void);
 
+#define FASTBOOT_UDP_PACKET_SIZE	1024
+
+void fastboot_udp_init(void);
+int fastboot_udp_input(const u8 *packet, unsigned int len);
+bool fastboot_udp_output(const u8 *packet, unsigned int len);
+int fastboot_udp_run(void);
+
 #endif /* __NET_FASTBOOT_H__ */
diff --git a/net/Makefile b/net/Makefile
index 5a04852a4de..9c845f45b2b 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_$(PHASE_)BOOTDEV_ETH) += eth_bootdev.o
 obj-$(CONFIG_DM_MDIO)  += mdio-uclass.o
 obj-$(CONFIG_DM_MDIO_MUX) += mdio-mux-uclass.o
 obj-$(CONFIG_CMD_NFS)  += nfs-common.o
+obj-$(CONFIG_$(PHASE_)UDP_FUNCTION_FASTBOOT) += fastboot-udp-common.o
 obj-$(CONFIG_$(PHASE_)DM_ETH) += eth_common.o
 obj-$(CONFIG_CMD_WOL) += wol-common.o
 obj-y += net-common.o
diff --git a/net/fastboot-udp-common.c b/net/fastboot-udp-common.c
new file mode 100644
index 00000000000..07eb7433ba5
--- /dev/null
+++ b/net/fastboot-udp-common.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: BSD-2-Clause
+/*
+ * Copyright (C) 2016 The Android Open Source Project
+ */
+
+#include <fastboot.h>
+#include <time.h>
+#include <asm/unaligned.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <net/fastboot_udp.h>
+
+enum {
+	FASTBOOT_ERROR,
+	FASTBOOT_QUERY,
+	FASTBOOT_INIT,
+	FASTBOOT_FASTBOOT,
+};
+
+struct fastboot_header {
+	u8 id;
+	u8 flags;
+	__be16 seq;
+} __packed;
+
+struct fastboot_reply {
+	struct fastboot_header header;
+	char data[FASTBOOT_RESPONSE_LEN];
+};
+
+static u16 sequence_number;
+static struct fastboot_reply last_reply;
+static unsigned int last_len;
+static int last_action;
+static unsigned int max_packet_size;
+static char command[FASTBOOT_COMMAND_LEN];
+static int cmd;
+static bool pending_command;
+static bool multiresponse;
+static ulong progress_start;
+
+static int send_reply(u8 id, const void *data, unsigned int len, int action)
+{
+	last_reply.header.id = id;
+	last_reply.header.seq = cpu_to_be16(sequence_number++);
+	memcpy(last_reply.data, data, len);
+	last_len = sizeof(last_reply.header) + len;
+	last_action = action;
+	return fastboot_udp_output((u8 *)&last_reply, last_len) ? action : -1;
+}
+
+/* Keep a client waiting for a synchronous flash or erase alive. */
+static void fastboot_timed_send_info(const char *msg)
+{
+	char response[FASTBOOT_RESPONSE_LEN];
+
+	if (get_timer(progress_start) < 30000)
+		return;
+
+	progress_start = get_timer(0);
+	fastboot_response("INFO", response, "%s", msg);
+	send_reply(FASTBOOT_FASTBOOT, response, strlen(response), -1);
+}
+
+static void reset_session(void)
+{
+	pending_command = false;
+	multiresponse = false;
+	cmd = -1;
+}
+
+static int protocol_error(const char *msg)
+{
+	return send_reply(FASTBOOT_ERROR, msg, strlen(msg), -1);
+}
+
+static int fastboot_packet(const u8 *data, unsigned int len)
+{
+	char response[FASTBOOT_RESPONSE_LEN] = {};
+	int action = -1;
+
+	if (len + sizeof(struct fastboot_header) > max_packet_size)
+		return protocol_error("Packet too large");
+	if (cmd == FASTBOOT_COMMAND_DOWNLOAD) {
+		if (len)
+			fastboot_data_download(data, len, response);
+		else if (!fastboot_data_remaining())
+			fastboot_data_complete(response);
+		else
+			fastboot_fail("Incomplete download", response);
+	} else if (multiresponse) {
+		if (len)
+			return protocol_error("Expected a read");
+		fastboot_multiresponse(cmd, response);
+	} else if (pending_command) {
+		if (len)
+			return protocol_error("Expected a read");
+		pending_command = false;
+		progress_start = get_timer(0);
+		cmd = fastboot_handle_command(command, response);
+		if (!strncmp(response, FASTBOOT_MULTIRESPONSE_START, 4)) {
+			multiresponse = true;
+			fastboot_multiresponse(cmd, response);
+		}
+	} else {
+		if (!len || len >= sizeof(command))
+			return protocol_error("Invalid command length");
+		memcpy(command, data, len);
+		command[len] = '\0';
+		pending_command = true;
+	}
+
+	if (!strncmp(response, "OKAY", 4) && fastboot_is_boot_command(cmd))
+		action = cmd;
+	if (!strncmp(response, "OKAY", 4) || !strncmp(response, "FAIL", 4))
+		reset_session();
+	return send_reply(FASTBOOT_FASTBOOT, response, strlen(response), action);
+}
+
+/* Return a boot action after handing its reply to the transport. */
+int fastboot_udp_input(const u8 *packet, unsigned int len)
+{
+	struct fastboot_header header;
+	u16 seq;
+
+	if (len < sizeof(header) || len > FASTBOOT_UDP_PACKET_SIZE)
+		return -1;
+	memcpy(&header, packet, sizeof(header));
+	seq = be16_to_cpu(header.seq);
+	packet += sizeof(header);
+	len -= sizeof(header);
+
+	/* A query may arrive between a request and its retransmission. */
+	if (header.id == FASTBOOT_QUERY) {
+		struct fastboot_reply query = { .header = header };
+
+		query.header.flags = 0;
+		put_unaligned_be16(sequence_number, query.data);
+		fastboot_udp_output((u8 *)&query, sizeof(header) + sizeof(u16));
+		return -1;
+	}
+	if (seq != sequence_number) {
+		if (last_len && seq == (u16)(sequence_number - 1) &&
+		    fastboot_udp_output((u8 *)&last_reply, last_len))
+			return last_action;
+		return -1;
+	}
+
+	switch (header.id) {
+	case FASTBOOT_INIT: {
+		__be16 params[] = { cpu_to_be16(1), cpu_to_be16(FASTBOOT_UDP_PACKET_SIZE) };
+
+		if (len < sizeof(params) || !get_unaligned_be16(packet) ||
+		    get_unaligned_be16(packet + 2) < 512)
+			return protocol_error("Invalid initialization");
+		reset_session();
+		max_packet_size = min_t(unsigned int, FASTBOOT_UDP_PACKET_SIZE,
+					get_unaligned_be16(packet + 2));
+		return send_reply(FASTBOOT_INIT, params, sizeof(params), -1);
+	}
+	case FASTBOOT_FASTBOOT:
+		return fastboot_packet(packet, len);
+	default:
+		return protocol_error("Unknown packet ID");
+	}
+}
+
+void fastboot_udp_init(void)
+{
+	sequence_number = 1;
+	last_len = 0;
+	max_packet_size = FASTBOOT_UDP_PACKET_SIZE;
+	reset_session();
+	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH))
+		fastboot_set_progress_callback(fastboot_timed_send_info);
+}
diff --git a/net/fastboot_udp.c b/net/fastboot_udp.c
index d1479510d61..ded579c63f9 100644
--- a/net/fastboot_udp.c
+++ b/net/fastboot_udp.c
@@ -3,303 +3,41 @@
  * Copyright (C) 2016 The Android Open Source Project
  */
 
-#include <command.h>
 #include <fastboot.h>
 #include <net.h>
 #include <net/fastboot_udp.h>
-#include <linux/printk.h>
-
-enum {
-	FASTBOOT_ERROR = 0,
-	FASTBOOT_QUERY = 1,
-	FASTBOOT_INIT = 2,
-	FASTBOOT_FASTBOOT = 3,
-};
-
-struct __packed fastboot_header {
-	uchar id;
-	uchar flags;
-	unsigned short seq;
-};
-
-#define PACKET_SIZE 1024
-#define DATA_SIZE (PACKET_SIZE - sizeof(struct fastboot_header))
-
-/* Sequence number sent for every packet */
-static unsigned short sequence_number = 1;
-static const unsigned short packet_size = PACKET_SIZE;
-static const unsigned short udp_version = 1;
-
-/* Keep track of last packet for resubmission */
-static uchar last_packet[PACKET_SIZE];
-static unsigned int last_packet_len;
 
 static struct in_addr fastboot_remote_ip;
-/* The UDP port at their end */
 static int fastboot_remote_port;
-/* The UDP port at our end */
-static int fastboot_our_port;
 
-/**
- * fastboot_udp_send_response() - Send an response into UDP
- *
- * @response: Response to send
- */
-static void fastboot_udp_send_response(const char *response)
+bool fastboot_udp_output(const u8 *packet, unsigned int len)
 {
-	uchar *packet;
-	uchar *packet_base;
-	int len = 0;
-
-	struct fastboot_header response_header = {
-		.id = FASTBOOT_FASTBOOT,
-		.flags = 0,
-		.seq = htons(sequence_number)
-	};
-	++sequence_number;
-	packet = net_tx_packet + net_eth_hdr_size() + IP_UDP_HDR_SIZE;
-	packet_base = packet;
-
-	/* Write headers */
-	memcpy(packet, &response_header, sizeof(response_header));
-	packet += sizeof(response_header);
-	/* Write response */
-	memcpy(packet, response, strlen(response));
-	packet += strlen(response);
-
-	len = packet - packet_base;
-
-	/* Save packet for retransmitting */
-	last_packet_len = len;
-	memcpy(last_packet, packet_base, last_packet_len);
-
-	net_send_udp_packet(net_server_ethaddr, fastboot_remote_ip,
-			    fastboot_remote_port, fastboot_our_port, len);
-}
-
-/**
- * fastboot_timed_send_info() - Send INFO packet every 30 seconds
- *
- * @msg: String describing the reason for waiting
- *
- * Send an INFO packet during long commands based on timer. An INFO packet
- * is sent if the time is 30 seconds after start. Else, noop.
- */
-static void fastboot_timed_send_info(const char *msg)
-{
-	static ulong start;
-	char response[FASTBOOT_RESPONSE_LEN] = {0};
-
-	/* Initialize timer */
-	if (start == 0)
-		start = get_timer(0);
-	ulong time = get_timer(start);
-	/* Send INFO packet to host every 30 seconds */
-	if (time >= 30000) {
-		start = get_timer(0);
-		fastboot_response("INFO", response, "%s", msg);
-		fastboot_udp_send_response(response);
-	}
-}
-
-/**
- * fastboot_send() - Sends a packet in response to received fastboot packet
- *
- * @header: Header for response packet
- * @fastboot_data: Pointer to received fastboot data
- * @fastboot_data_len: Length of received fastboot data
- * @retransmit: Nonzero if sending last sent packet
- */
-static void fastboot_send(struct fastboot_header header, char *fastboot_data,
-			  unsigned int fastboot_data_len, uchar retransmit)
-{
-	uchar *packet;
-	uchar *packet_base;
-	int len = 0;
-	const char *error_msg = "An error occurred.";
-	short tmp;
-	struct fastboot_header response_header = header;
-	static char command[FASTBOOT_COMMAND_LEN];
-	static int cmd = -1;
-	static bool pending_command;
-	char response[FASTBOOT_RESPONSE_LEN] = {0};
-
-	/*
-	 * We will always be sending some sort of packet, so
-	 * cobble together the packet headers now.
-	 */
-	packet = net_tx_packet + net_eth_hdr_size() + IP_UDP_HDR_SIZE;
-	packet_base = packet;
-
-	/* Resend last packet */
-	if (retransmit) {
-		memcpy(packet, last_packet, last_packet_len);
-		net_send_udp_packet(net_server_ethaddr, fastboot_remote_ip,
-				    fastboot_remote_port, fastboot_our_port,
-				    last_packet_len);
-		return;
-	}
-
-	response_header.seq = htons(response_header.seq);
-	memcpy(packet, &response_header, sizeof(response_header));
-	packet += sizeof(response_header);
-
-	switch (header.id) {
-	case FASTBOOT_QUERY:
-		tmp = htons(sequence_number);
-		memcpy(packet, &tmp, sizeof(tmp));
-		packet += sizeof(tmp);
-		break;
-	case FASTBOOT_INIT:
-		tmp = htons(udp_version);
-		memcpy(packet, &tmp, sizeof(tmp));
-		packet += sizeof(tmp);
-		tmp = htons(packet_size);
-		memcpy(packet, &tmp, sizeof(tmp));
-		packet += sizeof(tmp);
-		break;
-	case FASTBOOT_ERROR:
-		memcpy(packet, error_msg, strlen(error_msg));
-		packet += strlen(error_msg);
-		break;
-	case FASTBOOT_FASTBOOT:
-		if (cmd == FASTBOOT_COMMAND_DOWNLOAD) {
-			if (!fastboot_data_len && !fastboot_data_remaining()) {
-				fastboot_data_complete(response);
-			} else {
-				fastboot_data_download(fastboot_data,
-						       fastboot_data_len,
-						       response);
-			}
-		} else if (!pending_command) {
-			strlcpy(command, fastboot_data,
-				min((size_t)fastboot_data_len + 1,
-				    sizeof(command)));
-			pending_command = true;
-		} else {
-			cmd = fastboot_handle_command(command, response);
-			pending_command = false;
-
-			if (!strncmp(FASTBOOT_MULTIRESPONSE_START, response, 4)) {
-				while (1) {
-					/* Call handler to obtain next response */
-					fastboot_multiresponse(cmd, response);
-
-					/*
-					 * Send more responses or break to send
-					 * final OKAY/FAIL response
-					 */
-					if (strncmp("OKAY", response, 4) &&
-					    strncmp("FAIL", response, 4))
-						fastboot_udp_send_response(response);
-					else
-						break;
-				}
-			}
-		}
-		/*
-		 * Sent some INFO packets, need to update sequence number in
-		 * header
-		 */
-		if (header.seq != sequence_number) {
-			response_header.seq = htons(sequence_number);
-			memcpy(packet_base, &response_header,
-			       sizeof(response_header));
-		}
-		/* Write response to packet */
-		memcpy(packet, response, strlen(response));
-		packet += strlen(response);
-		break;
-	default:
-		pr_err("ID %d not implemented.\n", header.id);
-		return;
-	}
-
-	len = packet - packet_base;
-
-	/* Save packet for retransmitting */
-	last_packet_len = len;
-	memcpy(last_packet, packet_base, last_packet_len);
-
-	net_send_udp_packet(net_server_ethaddr, fastboot_remote_ip,
-			    fastboot_remote_port, fastboot_our_port, len);
-
-	fastboot_handle_boot(cmd, strncmp("OKAY", response, 4) == 0);
-
-	if (!strncmp("OKAY", response, 4) || !strncmp("FAIL", response, 4))
-		cmd = -1;
+	memcpy(net_tx_packet + net_eth_hdr_size() + IP_UDP_HDR_SIZE, packet, len);
+	return net_send_udp_packet(net_server_ethaddr, fastboot_remote_ip,
+				   fastboot_remote_port, CONFIG_UDP_FUNCTION_FASTBOOT_PORT,
+				   len) >= 0;
 }
 
-/**
- * fastboot_handler() - Incoming UDP packet handler.
- *
- * @packet: Pointer to incoming UDP packet
- * @dport: Destination UDP port
- * @sip: Source IP address
- * @sport: Source UDP port
- * @len: Packet length
- */
 static void fastboot_handler(uchar *packet, unsigned int dport,
 			     struct in_addr sip, unsigned int sport,
 			     unsigned int len)
 {
-	struct fastboot_header header;
-	char fastboot_data[DATA_SIZE] = {0};
-	unsigned int fastboot_data_len = 0;
+	int action;
 
-	if (dport != fastboot_our_port)
+	if (dport != CONFIG_UDP_FUNCTION_FASTBOOT_PORT)
 		return;
-
 	fastboot_remote_ip = sip;
 	fastboot_remote_port = sport;
-
-	if (len < sizeof(struct fastboot_header) || len > PACKET_SIZE)
-		return;
-	memcpy(&header, packet, sizeof(header));
-	header.flags = 0;
-	header.seq = ntohs(header.seq);
-	packet += sizeof(header);
-	len -= sizeof(header);
-
-	switch (header.id) {
-	case FASTBOOT_QUERY:
-		fastboot_send(header, fastboot_data, 0, 0);
-		break;
-	case FASTBOOT_INIT:
-	case FASTBOOT_FASTBOOT:
-		fastboot_data_len = len;
-		if (len > 0)
-			memcpy(fastboot_data, packet, len);
-		if (header.seq == sequence_number) {
-			fastboot_send(header, fastboot_data,
-				      fastboot_data_len, 0);
-			sequence_number++;
-		} else if (header.seq == sequence_number - 1) {
-			/* Retransmit last sent packet */
-			fastboot_send(header, fastboot_data,
-				      fastboot_data_len, 1);
-		}
-		break;
-	default:
-		pr_err("ID %d not implemented.\n", header.id);
-		header.id = FASTBOOT_ERROR;
-		fastboot_send(header, fastboot_data, 0, 0);
-		break;
-	}
+	action = fastboot_udp_input(packet, len);
+	if (action >= 0)
+		fastboot_handle_boot(action, true);
 }
 
 void fastboot_udp_start_server(void)
 {
 	printf("Using %s device\n", eth_get_name());
 	printf("Listening for fastboot command on %pI4\n", &net_ip);
-
-	fastboot_our_port = CONFIG_UDP_FUNCTION_FASTBOOT_PORT;
-
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH))
-		fastboot_set_progress_callback(fastboot_timed_send_info);
-
+	fastboot_udp_init();
 	net_set_udp_handler(fastboot_handler);
-
-	/* zero out server ether in case the server ip has changed */
 	memset(net_server_ethaddr, 0, 6);
 }
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index d72c5237410..8d4074b8b23 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_CMD_NFS) += nfs.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
 obj-$(CONFIG_WGET) += wget.o
 obj-$(CONFIG_CMD_WOL) += wol.o
+obj-$(CONFIG_UDP_FUNCTION_FASTBOOT) += fastboot_udp.o
 
 ifeq (y,$(CONFIG_WGET_BUILTIN_CACERT))
 $(obj)/builtin_cacert.c: $(CONFIG_WGET_BUILTIN_CACERT_PATH:"%"=%) FORCE
diff --git a/net/lwip/fastboot_udp.c b/net/lwip/fastboot_udp.c
new file mode 100644
index 00000000000..382dd5489ae
--- /dev/null
+++ b/net/lwip/fastboot_udp.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: BSD-2-Clause
+
+#include <console.h>
+#include <fastboot.h>
+#include <net.h>
+#include <net/fastboot_udp.h>
+#include <lwip/udp.h>
+
+static struct udp_pcb *server;
+static ip_addr_t peer;
+static u16_t peer_port;
+static struct pbuf *request;
+
+bool fastboot_udp_output(const u8 *packet, unsigned int len)
+{
+	struct pbuf *p = pbuf_alloc(PBUF_TRANSPORT, len, PBUF_RAM);
+	err_t err = ERR_MEM;
+
+	if (p) {
+		if (pbuf_take(p, packet, len) == ERR_OK)
+			err = udp_sendto(server, p, &peer, peer_port);
+		pbuf_free(p);
+	}
+	return err == ERR_OK;
+}
+
+static void receive(void *arg, struct udp_pcb *pcb, struct pbuf *p,
+		    const ip_addr_t *addr, u16_t port)
+{
+	if (!request && p->tot_len <= FASTBOOT_UDP_PACKET_SIZE) {
+		ip_addr_copy(peer, *addr);
+		peer_port = port;
+		request = p;
+		return;
+	}
+	pbuf_free(p);
+}
+
+int fastboot_udp_run(void)
+{
+	struct net_lwip_ctx net = {};
+	u8 packet[FASTBOOT_UDP_PACKET_SIZE];
+	int action = -1;
+	int ret;
+
+	if (server)
+		return -EBUSY;
+	ret = net_lwip_start(&net, NET_LWIP_ADDR_ENV_STRICT);
+	if (ret)
+		return ret;
+	server = udp_new_ip_type(IPADDR_TYPE_ANY);
+	if (!server) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	udp_bind_netif(server, net.netif);
+	if (udp_bind(server, IP_ANY_TYPE, CONFIG_UDP_FUNCTION_FASTBOOT_PORT) != ERR_OK) {
+		ret = -EADDRINUSE;
+		goto out;
+	}
+	fastboot_udp_init();
+	udp_recv(server, receive, NULL);
+	printf("Listening for fastboot on %s (UDP port %u)\n",
+	       ip4addr_ntoa(netif_ip4_addr(net.netif)), CONFIG_UDP_FUNCTION_FASTBOOT_PORT);
+	while (action < 0) {
+		if (ctrlc()) {
+			ret = -EINTR;
+			break;
+		}
+		ret = net_lwip_poll();
+		if (ret < 0)
+			break;
+		/* Command handlers can use the network, so run outside lwIP callbacks. */
+		if (request) {
+			int len = request->tot_len;
+
+			if (pbuf_copy_partial(request, packet, len, 0) == len)
+				action = fastboot_udp_input(packet, len);
+			pbuf_free(request);
+			request = NULL;
+		}
+	}
+out:
+	if (request) {
+		pbuf_free(request);
+		request = NULL;
+	}
+	if (server)
+		udp_remove(server);
+	server = NULL;
+	fastboot_set_progress_callback(NULL);
+	net_lwip_stop(&net);
+	if (action >= 0)
+		fastboot_handle_boot(action, true);
+	return min(ret, 0);
+}

-- 
2.53.0

