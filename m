Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC7FC61DBC
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 17:31:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83C966070C;
	Tue, 25 Aug 2026 17:31:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ryErH1JmDFh9; Tue, 25 Aug 2026 17:31:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787679088;
	bh=hKlABPjRGIhxlB43b9S7ABwCrw6ECgxKqBjISDnNRdI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BBAdqaW/bwT5wFh7eZ6jLcwZP/24xtK41pJPReiRrSevxUlwUvlkjF30UNStFOWju
	 Npm4l4mVBBQaJtSwq5x+Uj6ezCeRPhYAXfjcPwVn63FMCEsTZawTHg5GyL+Cf+kSzK
	 Ayb1+1jx4JY9F9r1GOE2V0k2djo8/ACcEOMdt5Rmu8Fc56Sy83PkKvytjeaQsbuifN
	 GHQnSIEVm+v/92iYyLvPN/nckd5+eG2poTyMCj8Aofk2DQtkHJyIy+txQ3rNOg2L1E
	 a2sIXZwks4Cni8xqbBGb44fFQafJsx8pSwL4pV4wiXhIgzHI5sES4flJCiogrrQ8IJ
	 A+U+yGhFvQUqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F93860656;
	Tue, 25 Aug 2026 17:31:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D97463DA
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:31:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB10960656
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:31:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ecKrG0o6b5x for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 17:31:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=qouUFYsB
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1761460604
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:31:26 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7f3b2c92428so33766a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 10:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787679085; x=1788283885;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hKlABPjRGIhxlB43b9S7ABwCrw6ECgxKqBjISDnNRdI=;
 b=qouUFYsB5yrO9/QUa3xJcfQVx/pL+GYsHhQMVkDobdhJyU4RuLQHfrKBKKCGzRZXrb
 j1sHO4ubBZ5zNdtlRzjqoA0TumVPQd0HlXBPF7+4o65youQ+a3oUyWWYtRDaLG7HeyqE
 WVfonU4gUcPvlCl6doLQ1E8bCg1BI7MUimmtdo4lh9lhcdFQTwDyBYJ1s8b8LuvxVF5i
 Y4SszkejPBOJPXPBhjSttGiAaQNfyWlZ0zjEYFJz+KWDQVftL+yR3uxxBHYIn2H2FuKs
 Imk+BZwWNXcvWB15yaFfvrPsd0t/JX07aW7g8jqmwz+5FJkjAtUf3OijYttQKy2JICf9
 y5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787679085; x=1788283885;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hKlABPjRGIhxlB43b9S7ABwCrw6ECgxKqBjISDnNRdI=;
 b=BucIiSPLnUFgWx6ZtxsKO9zkYH45v/JGH7CcPRfhPfdE9CMH7MFoJDt0E7+I5hvikS
 yxUHdj4+cqIYY5THXoM+err907nUubgkOKxBE/dTdvT4/fhCrmTCoiuSTnz4SOJjE26T
 yEEklOvVoR2aHyA+TIyuYBLssI8cSnGSCgVKRA+tBa34kNFFVrrEZYxcTHjWIpERawOz
 8XfDdOzPva/SdUOdh7fmoMlIrXOFcg+1yuZ8n2DirlYgld/w6nfYbRj3BBNcyylZm03w
 rLVuHb1sjPMGB7/x7Vb1i7D/w/wqoUoIleDg3NwkAc8Og3GCDrMJx/f/i5Wrn8JCFr2j
 htdg==
X-Gm-Message-State: AFuF++kBjJ/SoVIiWZByQa//rcF1zRf/FF5y3gkE6IfipmqkjeX5cb6N
 ZP6fgHRcJmHB4Nnh0Uc6BGmpgLoPIjzr5G8S+R7HdM+ETKY324GjUpW90SxInnI+
X-Gm-Gg: AR+sD11p2e/GID97rg9I+cG7uo65kqiN4DltkbI0QFVb+jTqL4k3Ae/xQk7O8oBwwxH
 WLMgIVeiQLUf0sI0A0EeA2cslVsBlV2XnBecsHNaBNwYwLDrADQX2DIz5vlusHWlYET3YioUeVf
 4jXcaSDSePJl727IjbAc1G48ONx8iPJiDEEimItpeVzT6SQkQB1pyXvngMYi+Np87T/7+RzZFPr
 v2Gl64/kq4pf04QXOnOIga8o7bP0frzBV6L9WkEKvBsjWcHhGSs7U/xmGrY3F+5tBLH+E3JlY+M
 qoIKOLaftftZ+9ij2R7F6PR2gWgZsVodygrbDZPSkNZfgAXw72SYx69bsW7fIilD/uMchoO3ow1
 3g0nkQatO0cbJoBuflHwmanrM4Z8jq3CpfTWpA3eikXYJwUBIKrj9B4QFSSZYIIZ7fBoacKK4JN
 Gn/lD5Lj/H28v4pEFHM5/q1xJPeInIM6x+CL3pxTpEocXQ4Fo/TBiXq04WTfPtq0im2hW5rK0sP
 hyUKLTI1aIIS2V1fwAuMI+JVkp1rfdt82omVnApoyN5NZC1s+Y/0k8JlmtEn7fxpKt49YdwDYoS
 t0ClEhcZQMUg+uV/WzkGvU1rgaHf3wIhcQmZaXqJtMKNn2diLjA5zCTWL6z/CVc6Ry0EYdbWkk4
 Q1sBW4imWAzes
X-Received: by 2002:a05:6830:7316:b0:7e9:d3aa:e391 with SMTP id
 46e09a7af769-7f4c4c8368cmr230249a34.6.1787679085071; 
 Tue, 25 Aug 2026 10:31:25 -0700 (PDT)
Received: from [127.0.1.1] (71-218-10-81.hlrn.qwest.net. [71.218.10.81])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4c426cb7csm143442a34.11.2026.08.25.10.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 10:31:24 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 25 Aug 2026 11:31:17 -0600
Subject: [PATCH] net: pcap: support lwIP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-submit-lwip-pcap-v1-v1-1-d31cd4ed6923@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMyw7CIBBFf6WZtRMpFWP8FdMFj6kdI0iAVpOm/
 y7o8tzcczbIlJgyXLsNEq2c+RUq9IcO7KzDnZBdZZBCnsVFKsyL8Vzw+eaI0eqIa4+TE6o/OTJ
 qGKCaMdHEn1/1Nv65ag+ypaXaw+hMaJIOdm7TEnNJpP3Raw6w718zcPGSlwAAAA==
X-Change-ID: 20260825-submit-lwip-pcap-v1-fd0514deb533
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
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

The packet capture command is restricted to NET_LEGACY even though the
recorder only consumes Ethernet frames. The lwIP adapter sends and receives
directly through Ethernet drivers, bypassing the legacy capture hooks.

Build the recorder for either network stack and add capture hooks to the
lwIP transmit and receive paths. Print the capture summary when the
outermost lwIP network operation stops, matching the legacy net_loop()
behavior.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/Kconfig         | 14 +++++++-------
 net/Makefile        |  2 +-
 net/lwip/net-lwip.c |  8 ++++++++
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index ff90a87024c..7025aab4714 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2078,13 +2078,6 @@ config BOOTP_TIMEOFFSET
 	bool "Request & store 'timeoffset' from BOOTP/DHCP server"
 	depends on CMD_BOOTP && CMD_SNTP
 
-config CMD_PCAP
-	bool "pcap capture"
-	help
-	  Selecting this will allow capturing all Ethernet packets and store
-	  them in physical memory in a PCAP formated file,
-	  later to be analyzed by PCAP reader application (IE. WireShark).
-
 config BOOTP_PXE
 	bool "Send PXE client arch to BOOTP/DHCP server"
 	default y
@@ -2210,6 +2203,13 @@ config CMD_WOL
 
 endif  # if NET_LEGACY
 
+config CMD_PCAP
+	bool "pcap capture"
+	help
+	  Selecting this will allow capturing all Ethernet packets and store
+	  them in physical memory in a PCAP formated file,
+	  later to be analyzed by PCAP reader application (IE. WireShark).
+
 config CMD_DHCP
 	bool "dhcp"
 	select PROT_DHCP_LWIP if NET_LWIP
diff --git a/net/Makefile b/net/Makefile
index ceac6de6377..6666db519a1 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -19,7 +19,6 @@ obj-$(CONFIG_CMD_NFS)  += nfs.o
 obj-$(CONFIG_CMD_PING) += ping.o
 obj-$(CONFIG_CMD_PING6) += ping6.o
 obj-$(CONFIG_CMD_DHCP6) += dhcpv6.o
-obj-$(CONFIG_CMD_PCAP) += pcap.o
 obj-$(CONFIG_CMD_RARP) += rarp.o
 obj-$(CONFIG_CMD_SNTP) += sntp.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
@@ -44,6 +43,7 @@ obj-$(CONFIG_$(PHASE_)BOOTDEV_ETH) += eth_bootdev.o
 obj-$(CONFIG_DM_MDIO)  += mdio-uclass.o
 obj-$(CONFIG_DM_MDIO_MUX) += mdio-mux-uclass.o
 obj-$(CONFIG_CMD_NFS)  += nfs-common.o
+obj-$(CONFIG_CMD_PCAP) += pcap.o
 obj-$(CONFIG_$(PHASE_)DM_ETH) += eth_common.o
 obj-y += net-common.o
 endif
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 8f8f9d69020..e114d98c1c8 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -19,6 +19,7 @@
 #include <lwip/prot/etharp.h>
 #include <lwip/timeouts.h>
 #include <net.h>
+#include <net/pcap.h>
 #include <timer.h>
 #include <u-boot/schedule.h>
 
@@ -77,6 +78,8 @@ static err_t net_lwip_tx(struct netif *netif, struct pbuf *p)
 	}
 
 	err = eth_get_ops(udev)->send(udev, pp, plen);
+	if (err >= 0 && CONFIG_IS_ENABLED(CMD_PCAP))
+		pcap_post(pp, plen, true);
 
 	if (pp_allocated)
 		free(pp);
@@ -225,6 +228,8 @@ void net_lwip_eth_stop(void)
 		return;
 
 	eth_halt();
+	if (CONFIG_IS_ENABLED(CMD_PCAP) && pcap_active())
+		pcap_print_status();
 }
 
 static struct netif *new_netif(struct udevice *udev, bool with_ip)
@@ -365,6 +370,9 @@ int net_lwip_rx(struct udevice *udev, struct netif *netif)
 		flags = 0;
 
 		if (len > 0) {
+			if (CONFIG_IS_ENABLED(CMD_PCAP))
+				pcap_post(packet, len, false);
+
 			if (CONFIG_IS_ENABLED(LWIP_DEBUG_RXTX)) {
 				printf("net_lwip_tx: %u bytes, udev %s \n", len,
 				       udev->name);

---
base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
change-id: 20260825-submit-lwip-pcap-v1-fd0514deb533

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

