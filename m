Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C40606A339
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=alG0HijI;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TFwfEUTL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D03D1409DD;
	Thu, 26 Nov 2026 13:33:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FQLN7aOlCms7; Thu, 26 Nov 2026 13:33:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7B2EA409EB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700019;
	b=TtVXxsxE1o0kG9T9kLWm99LI2CXi7jdS4/DfgOS1cOROnabTvic19OoRtK+OQvBsd9ie
	 qjClgSa5ooWehdzWuE3+qnAH7bATkNnVc98//xeNvDMxNIVbzhfPXLxoSMIIj6g1PdBrS
	 4PCp1YNUkGjAjBXUlBpO3z8IU/+fY+1GVqqtjeCHPofuPR3dhBDOsBNaybOnDqcBU5hqF
	 xIso/kefw3PgdDgCi8b2gW4jTcT6JLNrAQKshYq2XMVXk9ESPHzdWc3RlPwk0Eu1kvz4f
	 Y7gk2KDuYSgHVKP0Fwd6mrg1E0ENFs9+RNpzdk9rX5eoSOvvhoIhQePCNfkRiHTCt9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700019;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dq7BEor7pMLog3XwWBzQyGtfZMEhrKxMlKeDkyhHH7o=;
	b=GuK+y2V3lbXbWYYNsg3ta6KwVsMNcfNIeVJiCVeqC10OoXhc2N8TiSPFRuIrT1FuZqnk
	 1vBcm5DGy8Bqqv/bIf8nu2OFfM7/KbUVK0pibzbGlvb1lFuXudcDRs3DpkmALJPB8Zh2W
	 33Xxly5rRNZEAucJAcwjCJUXMLBDT+/Gw5bjXRs+Wgy6RYuXU+Fv0TI+ZMheDu2kdGsmG
	 F5H6LDXxx0lRKDf2QsiBRfqXlx7ZDF5Zm7nj8xJDnFawo/HrwMasSBhjK0a9p8gY55Ld2
	 oryQPuEqnm3gRbl8irSwfYSd8R0gKfTR5pLJYA/9l2h5ESZZ5VgE5i/pQ2aD143E5zQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700019;
	bh=dq7BEor7pMLog3XwWBzQyGtfZMEhrKxMlKeDkyhHH7o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=alG0HijIMC+T+DrubEgAWOX/m5xGjgkxwM+o6zq0byFlf0NOqexhpcDszHly6NlYb
	 xBzsU2GU/K9Hstrmwy3aj/6VDki3mSQj0fH8jAkau82soms/2pAqER/12Qghkvri7n
	 zpXxSC70Rp90bf2h/N2LfTvpFySJ+QyVhO81VXLnW6h/II0Qj+5vbmie5jQqZnwX7D
	 dK2FDuOBvicVVQctRVGqbzv6rYTx17/nDmr3LFE1k5MlZdd9Eg5eXoESsjklhwgsW5
	 pD7gl1P5FtwEZeSaCzoRIOCIIT4oWNfDYZXpe8OUzLFXt0PODOv9fxqdK8bw8SHraA
	 r0KYmtkv4RJuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B2EA409EB;
	Thu, 26 Nov 2026 13:33:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E8CC0371
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E6D8A40492
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b586DYZ4QtFM for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 06:53:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C3AE540490
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=TFwfEUTL
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C3AE540490
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:30 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-847ac7ccd85so3813872a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795676009; x=1796280809;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dq7BEor7pMLog3XwWBzQyGtfZMEhrKxMlKeDkyhHH7o=;
 b=TFwfEUTLM3Z01JdVPpBQgY1oCmngr0JNQKzliqlD6cN8DsyKWhMveP6axzaTDdehPF
 833kzDIacS0qVitpXq1wFvuarz8l7/c5xo+D1d//y5BULdjVYjgtzH4PB6IUcXKX1/Z5
 RyOYKvQc0G7nqH/a3POZMhXDZdSAb6MlWYx138rCxN9eciIi1VACTSDSP8NpZ01nb6/r
 trXOt8QvIR29GO+hvexGEJu0RQKvdLVxtK34mtW/WNNrojHNtrsqNSBYBl723Tn7/lK2
 XEsP09y0rqO/8R7KklXp1X8xDlYUx4msxHFYlpI4jarRKTpCGoRYS1Drk7hXD58R3VMp
 J07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795676009; x=1796280809;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dq7BEor7pMLog3XwWBzQyGtfZMEhrKxMlKeDkyhHH7o=;
 b=TQxQJN/jmbbYXVnHgZVe6ajopSrAVyzobBOlOYBI2CYI/ePQ8EMOLdakZxGX6agCA/
 WoH0ZA8e5Ow5kEtWG1TLjv6FN1rr55016RjbNjWvWppO3NQCLp6q1/5SpPKIOETzEmyT
 V5SUVkkM1wugGZCGX90rVHhIuKYWRpz6mVCQlXlhnUFaDRHI++NLtcVir52PTW+0ZXOq
 4KDazIyIHrjtgF4kYTJNsgsxj7tb3lgpV8GRB/0hbuKsQK3AAuVuwxkJF1zh9fXKUO2T
 Mu+HNdDnRao4UMt3v4klBN84Q22aRGirj8X1bbhZKk+ABptiYI3SZOuLI/eV3q/GsEuk
 JhdQ==
X-Gm-Message-State: APuU4Z90vq9rPKOVL1EaeSZEMH54HgJtzFD0RN+WXcA5CcwRi8FRZFmq
 Z5+Q7ro3a+Jqllij5JbRjxZXl7tyn/vB/DRXumIUOx4noeM2+5P2F1Ne
X-Gm-Gg: AZFdTZctWVOxeKf1V8mxRvIVbmF0AB08vxoY7aEy2PR36KxAEgLjQFTAdtni8pcV451
 O/TG6LgZo4tFhOC9/1IK1E8vQWt5Q697CHpYKKH1JKV469GK94hCb/QFeG9DnTShBQZ+6C4k+TR
 IonOFRxf2Mwp8mqBSFPTVGC63Lz4scLx4uSakn25tET7qrtjvJccAxsTOE79xWsuJ0aRzG1vo+W
 bZzKp5eskjVEd+3IrYG5Yf7X9mADkhTGcU7EG7P/Tfa0wLXyfekZ9s5JuHRGOwZ/Rf8OlF6sdxe
 ph7Eu0Druj97Y1ELFh0d8rNt7ismpdekNlDhaICDWTGuheLvbLWCojqFqCaae4lcGfAbiToct3V
 DwF/Cy8Y91xqaqGaMuRQrYcktMTINj4ddxACg3t7mAG2E89TE/uW/U5X/sKo+VcPhCTHg0MApFd
 LCIsKKDGsOMIklyHV6jn+HMMFnWWy438aksn6OgLb6b+6PYFJthmRNbnOVOnRjQlDKpcrpycYVU
 CyKdJBaVZIll6w4VuGwW4550KmMzoFXCVJvMZuOUYNmWPyCuGo7hIm9bQoUVEVRs1G9dcf3Ce8F
 bk7xQMeS01IYawHYNNDKj6Hq5dVpw7Bxqn+4VpmymgjHxPPQjKgooa3KO7XMQjgr8u4QKxJnOaW
 yV+euA8cANyghTOxRAczGR0l5gSTiDUZVxf3xNiOmvyC6lqYr3ngUKZ2jVZh7eF3MZskzqj3//G
 PLXt/U1mQHK4ijPB9d5HSNXYLr9FZ/EDzCR1hmD5oq+WWLrXa+9KHUHaPHj84WTcIjcSQty/rL
X-Received: by 2002:a05:6830:82f6:b0:862:bc33:da95 with SMTP id
 46e09a7af769-86315995c28mr22539715a34.20.1795676009389; 
 Wed, 25 Nov 2026 22:53:29 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86385358ca2sm31041a34.21.2026.11.25.22.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:53:28 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 25 Nov 2026 23:53:00 -0700
Subject: [PATCH 11/19] net: lwip: support network boot with reverse ARP
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-submit-lwip-network-boot-v1-v1-11-63df291d9392@gmail.com>
References: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
In-Reply-To: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Piyush Paliwal <piyushthepal@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, Peng Fan <peng.fan@nxp.com>, 
 Carlo Caione <ccaione@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alessandro Rubini <rubini@gnudd.com>, 
 Mingtian Li <limingtian@email.szu.edu.cn>, 
 Romain Gantois <romain.gantois@bootlin.com>, kongchen <3305708832@qq.com>, 
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Heiko Schocher <hs@nabladev.com>, 
 Francesco Valla <francesco@valla.it>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:33:17 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Acquire an IPv4 address for the current Ethernet interface from
a RARP reply addressed to its MAC. Publish the address and boot
server, then hand the same interface to TFTP. Preserve a configured
server, honor autoload and autostart, and use the shared runtime
retry policy.

Use the Ethernet output and unknown-protocol input paths for RARP
so normal IP traffic continues to reach other clients. Update the
primary IPv4 address used by PXE and EFI as well as ipaddr. Exercise
acquisition and a TFTP download to the configured server in sandbox.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/Kconfig                  |   4 +-
 lib/lwip/u-boot/lwip-hooks.h |   7 ++
 net/lwip/Makefile            |   1 +
 net/lwip/rarp.c              | 181 +++++++++++++++++++++++++++++++++++++++++++
 test/dm/Makefile             |   3 +
 test/dm/lwip_rarp.c          | 139 +++++++++++++++++++++++++++++++++
 6 files changed, 333 insertions(+), 2 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 0fde969ad98..4fb866f3cf6 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2167,13 +2167,13 @@ config BOOTP_RANDOM_XID
 	  Selecting this will allow for a random transaction ID to get
 	  selected for each BOOTP/DHCPv4 exchange.
 
+endif
+
 config CMD_RARP
 	bool "rarpboot"
 	help
 	  Boot image via network using RARP/TFTP protocol
 
-endif
-
 config SYS_DISABLE_AUTOLOAD
 	bool "Disable automatically loading files over the network"
 	depends on CMD_BOOTP || CMD_DHCP || CMD_NFS || CMD_RARP
diff --git a/lib/lwip/u-boot/lwip-hooks.h b/lib/lwip/u-boot/lwip-hooks.h
index f665e80e869..396a0606b44 100644
--- a/lib/lwip/u-boot/lwip-hooks.h
+++ b/lib/lwip/u-boot/lwip-hooks.h
@@ -11,6 +11,13 @@ int net_lwip_vlan_id(void);
 #include "lwip-dhcp.h"
 #endif
 
+#if CONFIG_IS_ENABLED(CMD_RARP)
+struct netif;
+struct pbuf;
+int net_lwip_rarp_receive(struct pbuf *p, struct netif *netif);
+#define LWIP_HOOK_UNKNOWN_ETH_PROTOCOL net_lwip_rarp_receive
+#endif
+
 #if LWIP_IPV6
 #include <lwip/ip6_addr.h>
 
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index 946abac8afd..ac17ebe87f2 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_$(PHASE_)CMD_CDP) += cdp.o
 obj-$(CONFIG_CMD_DHCP6) += dhcp6.o
 obj-$(CONFIG_PROT_ICMP_LWIP) += icmp_unreach.o
 obj-$(CONFIG_CMD_NFS) += nfs.o
+obj-$(CONFIG_$(PHASE_)CMD_RARP) += rarp.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
 obj-$(CONFIG_WGET) += wget.o
 obj-$(CONFIG_CMD_WOL) += wol.o
diff --git a/net/lwip/rarp.c b/net/lwip/rarp.c
new file mode 100644
index 00000000000..7303f30d8b7
--- /dev/null
+++ b/net/lwip/rarp.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <command.h>
+#include <console.h>
+#include <env.h>
+#include <image.h>
+#include <net.h>
+#include <time.h>
+#include <asm/unaligned.h>
+#include <dm/device.h>
+#include <lwip/prot/etharp.h>
+#include <lwip/prot/iana.h>
+#include <lwip-hooks.h>
+#include <netif/ethernet.h>
+
+#define RARP_REQUEST	3
+#define RARP_REPLY	4
+#define RARP_TIMEOUT	5000
+
+struct rarp_result {
+	struct netif *netif;
+	ip4_addr_t ip;
+	ip4_addr_t server;
+};
+
+static struct rarp_result *waiting;
+
+int net_lwip_rarp_receive(struct pbuf *p, struct netif *netif)
+{
+	unsigned int hlen = SIZEOF_ETH_HDR;
+	u8 hdr[VLAN_ETH_HLEN];
+	struct etharp_hdr arp;
+	ip4_addr_t ip, server;
+	u16 type;
+
+	if (!waiting || waiting->netif != netif || !ip4_addr_isany_val(waiting->ip) ||
+	    pbuf_copy_partial(p, hdr, sizeof(hdr), 0) != sizeof(hdr))
+		return ERR_VAL;
+	type = get_unaligned_be16(hdr + hlen - 2);
+	if (type == PROT_VLAN) {
+		hlen += VLAN_HLEN;
+		type = get_unaligned_be16(hdr + hlen - 2);
+	}
+	if (type != PROT_RARP ||
+	    pbuf_copy_partial(p, &arp, sizeof(arp), hlen) != sizeof(arp) ||
+	    arp.hwtype != htons(LWIP_IANA_HWTYPE_ETHERNET) ||
+	    arp.proto != htons(PROT_IP) || arp.hwlen != ETH_ALEN ||
+	    arp.protolen != sizeof(ip4_addr_t) || arp.opcode != htons(RARP_REPLY) ||
+	    memcmp(arp.dhwaddr.addr, netif->hwaddr, ETH_ALEN))
+		return ERR_VAL;
+
+	IPADDR_WORDALIGNED_COPY_TO_IP4_ADDR_T(&ip, &arp.dipaddr);
+	IPADDR_WORDALIGNED_COPY_TO_IP4_ADDR_T(&server, &arp.sipaddr);
+	if (ip4_addr_isany_val(ip) || ip4_addr_ismulticast(&ip) ||
+	    ip.addr == IPADDR_BROADCAST || ip4_addr_isany_val(server) ||
+	    ip4_addr_ismulticast(&server) || server.addr == IPADDR_BROADCAST)
+		return ERR_VAL;
+	waiting->ip = ip;
+	waiting->server = server;
+	pbuf_free(p);
+	return ERR_OK;
+}
+
+static int rarp_request(struct netif *netif)
+{
+	struct etharp_hdr *arp;
+	struct pbuf *p;
+	err_t ret;
+
+	p = pbuf_alloc(PBUF_LINK, sizeof(*arp), PBUF_RAM);
+	if (!p)
+		return -ENOMEM;
+	arp = p->payload;
+	memset(arp, 0, sizeof(*arp));
+	arp->hwtype = htons(LWIP_IANA_HWTYPE_ETHERNET);
+	arp->proto = htons(PROT_IP);
+	arp->hwlen = ETH_ALEN;
+	arp->protolen = sizeof(ip4_addr_t);
+	arp->opcode = htons(RARP_REQUEST);
+	memcpy(arp->shwaddr.addr, netif->hwaddr, ETH_ALEN);
+	arp->dhwaddr = arp->shwaddr;
+	memset(&arp->dipaddr, 0xff, sizeof(arp->dipaddr));
+	ret = ethernet_output(netif, p, &arp->shwaddr, &ethbroadcast, PROT_RARP);
+	pbuf_free(p);
+	return ret == ERR_OK ? 0 : -EIO;
+}
+
+static int rarp_acquire(struct net_lwip_ctx *net, bool keep_server)
+{
+	struct rarp_result result = { .netif = net->netif };
+	char name[sizeof("ipaddr99")] = "ipaddr";
+	int idx = dev_seq(net->dev);
+	int ret = -ETIMEDOUT;
+
+	if (idx < 0 || idx > 99)
+		return -EINVAL;
+	waiting = &result;
+	for (int i = 0; i < max(1, CONFIG_NET_RETRY_COUNT); i++) {
+		unsigned long start = get_timer(0);
+
+		ret = rarp_request(net->netif);
+		if (ret)
+			break;
+		while (get_timer(start) < RARP_TIMEOUT) {
+			if (ctrlc()) {
+				ret = -EINTR;
+				goto out;
+			}
+			ret = net_lwip_poll();
+			if (ret < 0)
+				goto out;
+			if (!ip4_addr_isany_val(result.ip)) {
+				if (idx)
+					sprintf(name, "ipaddr%d", idx);
+				ret = env_set(name, ip4addr_ntoa(&result.ip));
+				if (!ret && !idx)
+					net_ip.s_addr = ip4_addr_get_u32(&result.ip);
+				if (!ret && !keep_server)
+					ret = env_set("serverip", ip4addr_ntoa(&result.server));
+				goto out;
+			}
+		}
+		ret = -ETIMEDOUT;
+	}
+out:
+	waiting = NULL;
+	return ret;
+}
+
+static int do_rarpboot(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	struct net_lwip_ctx net = {};
+	const char *autoload;
+	bool nfs = false, downloaded = false;
+	bool keep_server = string_to_ip(env_get("serverip")).s_addr;
+	int ret;
+
+	if (waiting || net_lwip_start(&net, NET_LWIP_ADDR_NONE))
+		return CMD_RET_FAILURE;
+	net_try_count = 1;
+	net_restart_wrap = 0;
+	for (;;) {
+		ret = rarp_acquire(&net, keep_server);
+		if (!ret) {
+			autoload = env_get("autoload");
+			nfs = autoload && !strcmp(autoload, "NFS");
+			if (nfs || env_get_yesno("autoload") == 0)
+				break;
+			ret = net_lwip_refresh(&net);
+			if (ret)
+				break;
+			if (!IS_ENABLED(CONFIG_CMD_TFTPBOOT)) {
+				ret = -EOPNOTSUPP;
+				break;
+			}
+			ret = net_lwip_tftp_download(&net, argc, argv);
+			if (ret != -EAGAIN) {
+				downloaded = !ret;
+				break;
+			}
+		} else if (ret != -ETIMEDOUT) {
+			break;
+		}
+		ret = net_lwip_restart(&net);
+		if (ret)
+			break;
+	}
+	net_lwip_stop(&net);
+	if (ret)
+		return CMD_RET_FAILURE;
+	if (nfs)
+		return IS_ENABLED(CONFIG_CMD_NFS) ? do_nfs(cmdtp, flag, argc, argv) :
+		       CMD_RET_FAILURE;
+	if (downloaded && net_boot_file_size)
+		return bootm_maybe_autostart(cmdtp, argv[0]);
+	return CMD_RET_SUCCESS;
+}
+
+U_BOOT_CMD(rarpboot, 3, 1, do_rarpboot,
+	   "boot image via network using RARP/TFTP protocol",
+	   "[loadAddress] [[hostIPaddr:]bootfilename]");
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 6289a873a4e..5448be2267a 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -70,6 +70,9 @@ endif
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_CMD_BOOTP),yy)
 obj-y += lwip_bootp.o
 endif
+ifeq ($(CONFIG_NET_LWIP)$(CONFIG_CMD_RARP),yy)
+obj-y += lwip_rarp.o
+endif
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_CMD_TFTPBOOT),yy)
 obj-y += lwip_tftp.o
 obj-y += lwip_net_loop.o
diff --git a/test/dm/lwip_rarp.c b/test/dm/lwip_rarp.c
new file mode 100644
index 00000000000..03d93819233
--- /dev/null
+++ b/test/dm/lwip_rarp.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <command.h>
+#include <dm.h>
+#include <env.h>
+#include <image.h>
+#include <mapmem.h>
+#include <net.h>
+#include <asm/eth.h>
+#include <asm/unaligned.h>
+#include <dm/test.h>
+#include <test/ut.h>
+#include "lwip_test.h"
+
+static int rarp_tftp_reply(struct udevice *dev, void *packet, unsigned int len)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct ethernet_hdr *eth = packet, *reply;
+	struct ip_udp_hdr *ip = (void *)(eth + 1), *rip;
+	const u8 data[] = { 0, 3, 0, 1, 'R' }; /* TFTP DATA, block 1 */
+	unsigned int ip_len = IP_UDP_HDR_SIZE + sizeof(data);
+
+	if (!sandbox_eth_arp_req_to_reply(dev, packet, len))
+		return 0;
+	if (len < ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + 2 ||
+	    eth->et_protlen != htons(PROT_IP) || ip->ip_p != IPPROTO_UDP ||
+	    ip->udp_dst != htons(69) || get_unaligned_be16(ip + 1) != 1)
+		return 0;
+	if (priv->recv_packets >= PKTBUFSRX)
+		return -ENOSPC;
+	/* This run uses an explicitly configured server, not the RARP server. */
+	if (ip->ip_dst.s_addr != string_to_ip("10.0.0.7").s_addr ||
+	    ip->ip_src.s_addr != string_to_ip("10.0.0.18").s_addr)
+		return -EINVAL;
+	reply = (void *)priv->recv_packet_buffer[priv->recv_packets];
+	memcpy(reply->et_dest, eth->et_src, ETH_ALEN);
+	memcpy(reply->et_src, priv->fake_host_hwaddr, ETH_ALEN);
+	reply->et_protlen = eth->et_protlen;
+	rip = (void *)(reply + 1);
+	*rip = *ip;
+	rip->ip_src = ip->ip_dst;
+	rip->ip_dst = ip->ip_src;
+	rip->ip_len = htons(ip_len);
+	rip->ip_sum = 0;
+	rip->ip_sum = compute_ip_checksum(rip, IP_HDR_SIZE);
+	rip->udp_src = htons(1234);
+	rip->udp_dst = ip->udp_src;
+	rip->udp_len = htons(UDP_HDR_SIZE + sizeof(data));
+	rip->udp_xsum = 0;
+	memcpy(rip + 1, data, sizeof(data));
+	priv->recv_packet_length[priv->recv_packets++] = ETHER_HDR_SIZE + ip_len;
+	return 0;
+}
+
+static int rarp_reply(struct udevice *dev, void *packet, unsigned int len)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	u8 *req = packet;
+	const unsigned int h = ETHER_HDR_SIZE;
+
+	if (len < h || get_unaligned_be16(req + 12) != PROT_RARP)
+		return rarp_tftp_reply(dev, packet, len);
+	if (len != h + 28 || get_unaligned_be16(req + h + 6) != 3 ||
+	    memcmp(req + h + 8, req + h + 18, ETH_ALEN))
+		return -EINVAL;
+	/* The first reply is addressed to another client on the segment. */
+	for (int i = 0; i < 2; i++) {
+		int idx = priv->recv_packets;
+		u8 *out;
+
+		if (idx >= PKTBUFSRX)
+			return -ENOSPC;
+		out = priv->recv_packet_buffer[idx];
+		memcpy(out, req, len);
+		memcpy(out, req + ETH_ALEN, ETH_ALEN);
+		memcpy(out + ETH_ALEN, priv->fake_host_hwaddr, ETH_ALEN);
+		put_unaligned_be16(4, out + h + 6);
+		memcpy(out + h + 8, priv->fake_host_hwaddr, ETH_ALEN);
+		put_unaligned_be32(0x0a000011, out + h + 14);
+		if (!i)
+			out[h + 18] ^= 2;
+		put_unaligned_be32(i ? 0x0a000012 : 0x0a000063, out + h + 24);
+		priv->recv_packet_length[idx] = len;
+		priv->recv_packets++;
+	}
+	return 0;
+}
+
+static int rarp_check(struct unit_test_state *uts)
+{
+	u8 *buf;
+
+	ut_assertok(env_set("ethact", "eth@10002000"));
+	ut_assertok(env_set("ethrotate", "no"));
+	ut_assertok(env_set("netretry", "no"));
+	ut_assertok(env_set("autoload", "no"));
+	ut_assertok(env_set("serverip", NULL));
+	net_ip.s_addr = 0;
+	ut_assertok(run_command("rarpboot", 0));
+	ut_asserteq_str("10.0.0.18", env_get("ipaddr"));
+	ut_asserteq(string_to_ip("10.0.0.18").s_addr, net_ip.s_addr);
+	ut_asserteq_str("10.0.0.17", env_get("serverip"));
+	if (IS_ENABLED(CONFIG_CMD_TFTPBOOT)) {
+		ut_assertok(env_set("serverip", "10.0.0.7"));
+		ut_assertok(env_set("netmask", "255.255.255.0"));
+		ut_assertok(env_set("autoload", "yes"));
+		ut_assertok(env_set("autostart", "no"));
+		ut_assertok(env_set("tftpserverip", NULL));
+		ut_assertok(env_set("tftpdstp", NULL));
+		ut_assertok(run_command("rarpboot 2100000 boot.img", 0));
+		ut_asserteq(1, net_boot_file_size);
+		ut_asserteq_str("10.0.0.7", env_get("serverip"));
+		buf = map_sysmem(0x2100000, 1);
+		ut_asserteq('R', *buf);
+		unmap_sysmem(buf);
+	}
+	return 0;
+}
+
+static int dm_test_lwip_rarp(struct unit_test_state *uts)
+{
+	const char *const vars[] = { "ethact", "ethrotate", "netretry", "autoload",
+		"serverip", "serveraddr", "ipaddr", "netmask", "autostart", "tftpserverip",
+		"tftpdstp", "filesize", "fileaddr" };
+	struct in_addr old_ip = net_ip;
+	ulong old_addr = image_load_addr;
+	u32 old_size = net_boot_file_size;
+	int ret;
+
+	sandbox_eth_set_tx_handler(0, rarp_reply);
+	ret = lwip_test_with_env(uts, vars, ARRAY_SIZE(vars), rarp_check);
+	sandbox_eth_set_tx_handler(0, NULL);
+	net_boot_file_size = old_size;
+	image_load_addr = old_addr;
+	net_ip = old_ip;
+	return ret;
+}
+
+DM_TEST(dm_test_lwip_rarp, UTF_SCAN_FDT);

-- 
2.53.0

