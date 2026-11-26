Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CBB606A32C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mkA29XVy;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dalNN0Fc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0ACA88118F;
	Thu, 26 Nov 2026 13:33:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QTJoHBD30E8g; Thu, 26 Nov 2026 13:33:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C7AFD8118D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700013;
	b=ch7m455iqr2Og3YKur2MFfhy+XvZJxc6A16gdDuE9a8qFOkkY1nZn4R+2zKeGhJxGpf9
	 iQaD6oAElPplSHd8L4lDCnZ4tSy1qI89TFbhrJUk1OeLAZZ9qYAxL0hh/oP4KuXy9UR5a
	 EJ5lv8DypWwW73z5T6Swu3yDUMssLrlW7/a1R+3hDanfKHxjZh2agFeVlvqq5zC69IMLQ
	 3aSZKJERGkMvYe1u34xrNGKkjkHEnb7rFeVDrJ5IVDlj6R1HAF2cYLggcYSg8dCEKO2N/
	 Uq7b5XFh2ixkCMfGJYKG4Gza+SG5D2406d5Ru7Tqw7qhjfCYPHBRfn3xSlQDNhI2b5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700013;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zxgVZO78Q6s4PJWoPaAXQCvtj7Cc5P2gp6yBLZcpNew=;
	b=JOocm3rhzh9u+CfWpZdsARXCfzBL7ZMHKBlcamSrpk7YhMeu78Xu/cjQmi4piVPF3oMh
	 S51AHPRCocaDfJCiH+yYWJTkTFvftONCgHm0cePlGjGHDV0hT3sbM5hSidZpLgNNm3hVY
	 OycAU1FJ4dkM8DpKp8sj79Y4GHzV9tHGTQ8Gav+jk7pwQFiU/hWe+5km3Wt1FY52rQIC1
	 dfxiNRJpoDfT61JGeIBIJYpijquzyQ+yETcBEtmGRuGoFa6aZOEemvqTU/wuNpTVcVXJK
	 25hHpQGaVzN6IlagTlPLYCBs54Srg1c88w7vXT5RMu5Ir+tbdba8q5Xy+PLKZKpBOQg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700012;
	bh=zxgVZO78Q6s4PJWoPaAXQCvtj7Cc5P2gp6yBLZcpNew=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mkA29XVy0gh4HHVgmqi0sG9YRo1X70Xo06c5R3BulDr2DN/xgRcFsvRQnwBmvsgVz
	 QoE8ukIeEX7qwv8Nbxtp8bStVGBTRk0jPHw0drhXfCL8TRnbbQ8d/ISNQH29uHKQOO
	 VI1hbVHs25Ya8iiT9MpqGAulbue12ZMwf6HaofpsZ1JbzI0mazHvXk8OODh4h/Ipve
	 WViglxvrEgg0duIKU1jH1PwZ0sDzsIRy0tM+Y4w/g0p2S8c9PyJYfDHO69+CvTECRv
	 7tyzlgX155O4cvAQoW1swl6PJgRrzvlup9P5tF4zFtx3qlw8VVRmZbD3RBCrNp4xtt
	 /6AEb3vvwByrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7AFD8118D;
	Thu, 26 Nov 2026 13:33:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 35F94371
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1BEA640492
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jb0uHU7JMan5 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 06:53:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 067B440490
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=dalNN0Fc
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 067B440490
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:22 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-833e671ee9fso5892652a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795676001; x=1796280801;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zxgVZO78Q6s4PJWoPaAXQCvtj7Cc5P2gp6yBLZcpNew=;
 b=dalNN0FcqpJtPj6z510o7CazNyffirOSB2idvluafygToQTfJ/eR4Oq7+GjurFPl7p
 Lro+zuZiyQiMvKVody0zBiwZiUsd9C+KIRWnXLS1FEQOgKwhUxHklbGamjM+5aL674LG
 yzN7LMfwnoBp/iwIZJU4mxL6s9PM/NURVGXkcxbByDDAVBB89XWzFMiSYkMspxHP5OWV
 IZNc+f0pAKTMIoJJFjVPpsIP42hsKG9TR+Xo3XfDnKr9mTeaOqPezQ0CwqKgvv0aLShg
 J83HnzLAnhnOUlFDwrXgkFyIo30xhAdDH9NUBbLp5YN/vZSFzdwQGNGu+LwwByB/U4mi
 LJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795676001; x=1796280801;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zxgVZO78Q6s4PJWoPaAXQCvtj7Cc5P2gp6yBLZcpNew=;
 b=fUmrixS62++musE6LU5YZbVIHrV3ot0mymrg6a08e+n+ORLWDU9fgiP4eS7j4aPwe9
 IWOAKKXfgpEl3OWhGYIQoQzWIo4t/VhHDkd8t8qR/smgyfeBQ0f93OMu9Z1N7s7gvA6V
 ce0szvXXs0PtzMsblIgWMGv1P9C5wv6j1MF98IPuCXt/8gagbc9ZyrOPvXnDE6r/nJ2R
 XXjzxIT/fF1YrpO/hE/jKz1HB+RvJ9qDRptl20PwCGeEgUpD8nezji5PesBHTPsuBMZK
 TWe3SneMwNEaVz9Ue+biUkyMnv3L4gFuDFuD/YmneIi9sn1nwjUAHyK5rev/Ma3E9WiX
 AJGQ==
X-Gm-Message-State: APuU4Z86svNEd88qyUrx0LzO3AVTBNGDi8BUxbSUU6UplpiRh4G2EKxZ
 yeDgsKMinqSIGtLIfoK3z6mvnGIOEGAmyQEa2sRTqRQl43w8ymiSxfwZ
X-Gm-Gg: AZFdTZdSOaQHSTDle/kSxCX67lgMJMn8V3hWanXyGKWpXnQXtgoF3ikKHCWm413Z9TB
 82yQymQWCy2cgPXZX8fTUbVmJL8HT6qySOsfm/8o5CAyyyxE4eSNZBqkwtZbxwx+c/kqmCXzLKT
 3lsVSU55cHUwCkIl7327K3buBjSc9aK9cWDBML0wJ8Rj7NuzVmkDp3nP42cdsa9hRGBYVuYoMxp
 kGn5q4r7MVqjmaW/PbrVtxXRnYiddIfYawKGOeJP3EPZ7QCbKx0G+do6YAdt+CcnN4wbNBEB7gI
 DIoSn+LrVifk4PqAN7IcXwYstvE6tOH0wpZiB7XSSQpKPW8mkoCCXRaWS901VDURYxtfDNzoOGO
 R5U/KcNyCMPiZ1/JaJw3P13fRdnKavQ8JRppRD0xlHufEI3SzpcvPKIEiJOlkm9kzRU4yx1Ed1E
 jW/C58Q3BRQQbMHUiG00Soj4zT1jwVBjnDHxe9kVYWe2rjbwxyzL4KVGgndpabqEtCRKexVLm7k
 SIFjrhi83UNJluNOCwe+gnRNMxXwQDWPSZPcoKjtt1o9VwAC1n0mVSv1PTvKlxB3Mi7qjxaqcgZ
 DtwBj54IciO7zvWYedd6CQr4Brimot6pDY/Q3QYYrEf9azJEx+AhdR3EJ/nCMh+KSSACtVLfDcD
 b0DH16viGSthubGp1bWy+xEhLxs6uB4FAFE3IJkggohfaCVpJtRRiF97wL5muXBoJ328SrfnKM4
 soqw7WwpwPbSSDNVp33cVEW6Q2fFNouMsKI3/0j31lEwDvoJw0sfs=
X-Received: by 2002:a05:6820:1614:b0:71b:8345:c243 with SMTP id
 006d021491bc7-71b8345e15bmr2931748eaf.41.1795676001486; 
 Wed, 25 Nov 2026 22:53:21 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86385358ca2sm31041a34.21.2026.11.25.22.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:53:20 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 25 Nov 2026 23:52:56 -0700
Subject: [PATCH 07/19] net: lwip: discover VLAN settings with CDP
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-submit-lwip-network-boot-v1-v1-7-63df291d9392@gmail.com>
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

A switch can advertise the VLAN to use for network boot through CDP.
Send the discovery trigger untagged and listen on the CDP multicast
address before applying the advertised VLAN settings. On timeout, use
the common interface retry policy.

When an advertisement specifies no VLAN, delete the corresponding vlan
or nvlan variable. Both variables take decimal values, and leaving the
old value in place would reuse a VLAN the switch no longer advertises.

Check tagged and untagged replies, no-VLAN handling, link padding and
unaligned VLAN TLVs in sandbox.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/Kconfig         |   4 --
 net/Makefile        |   2 +-
 net/cdp.h           |   2 +
 net/lwip/Makefile   |   1 +
 net/lwip/cdp.c      |  98 +++++++++++++++++++++++++++++++++++++++++++
 net/lwip/net-lwip.c |   3 ++
 test/dm/Makefile    |   3 ++
 test/dm/lwip_cdp.c  | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 225 insertions(+), 5 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 5c31fb00013..0fde969ad98 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2191,8 +2191,6 @@ config CMD_PING6
 	help
 	  Send ICMPv6 ECHO_REQUEST to network host
 
-if NET_LEGACY
-
 config CMD_CDP
 	bool "cdp"
 	help
@@ -2200,8 +2198,6 @@ config CMD_CDP
 	  and to retrieve configuration data including the VLAN id using the
 	  proprietary Cisco Discovery Protocol (CDP).
 
-endif  # if NET_LEGACY
-
 config CMD_LINK_LOCAL
 	bool "linklocal"
 	depends on (LIB_RAND || LIB_HW_RAND)
diff --git a/net/Makefile b/net/Makefile
index 5a04852a4de..fb06ccdb38d 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -9,7 +9,6 @@ ifeq ($(CONFIG_NET_LEGACY),y)
 
 obj-$(CONFIG_NET_LEGACY)      += arp.o
 obj-$(CONFIG_CMD_BOOTP) += bootp.o
-obj-$(CONFIG_CMD_CDP)  += cdp.o
 obj-$(CONFIG_DNS)  += dns.o
 obj-$(CONFIG_CMD_LINK_LOCAL) += link_local.o
 obj-$(CONFIG_IPV6)     += ndisc.o
@@ -38,6 +37,7 @@ CFLAGS_eth_common.o += -Wno-format-extra-args
 endif
 
 ifeq ($(CONFIG_NET),y)
+obj-$(CONFIG_CMD_CDP) += cdp.o
 obj-$(CONFIG_DM_DSA)   += dsa-uclass.o
 obj-$(CONFIG_$(PHASE_)DM_ETH) += eth-uclass.o
 obj-$(CONFIG_$(PHASE_)BOOTDEV_ETH) += eth_bootdev.o
diff --git a/net/cdp.h b/net/cdp.h
index e53d1f81e4a..1e274390422 100644
--- a/net/cdp.h
+++ b/net/cdp.h
@@ -20,6 +20,8 @@ struct cdp_vlans {
 extern const u8 net_cdp_ethaddr[6];
 int cdp_build_trigger(uchar *frame, const u8 *src);
 bool cdp_parse_frame(const u8 *frame, unsigned int len, struct cdp_vlans *result);
+struct netif;
+void net_lwip_cdp_receive(struct netif *netif, const u8 *frame, unsigned int len);
 void cdp_start(void);
 void cdp_receive(const uchar *frame, unsigned int len);
 
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index d72c5237410..946abac8afd 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -5,6 +5,7 @@ ifneq ($(filter y,$(CONFIG_CMD_BOOTP) $(CONFIG_CMD_DHCP)),)
 obj-y += dhcp.o
 endif
 obj-$(CONFIG_DNS) += dns.o
+obj-$(CONFIG_$(PHASE_)CMD_CDP) += cdp.o
 obj-$(CONFIG_CMD_DHCP6) += dhcp6.o
 obj-$(CONFIG_PROT_ICMP_LWIP) += icmp_unreach.o
 obj-$(CONFIG_CMD_NFS) += nfs.o
diff --git a/net/lwip/cdp.c b/net/lwip/cdp.c
new file mode 100644
index 00000000000..0b28b70a52c
--- /dev/null
+++ b/net/lwip/cdp.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <command.h>
+#include <console.h>
+#include <env.h>
+#include <memalign.h>
+#include <net.h>
+#include <time.h>
+#include <dm/device.h>
+#include "../cdp.h"
+
+static struct netif *listening;
+static struct cdp_vlans vlans;
+static bool received;
+
+void net_lwip_cdp_receive(struct netif *netif, const u8 *frame, unsigned int len)
+{
+	if (listening == netif && cdp_parse_frame(frame, len, &vlans))
+		received = true;
+}
+
+static int cdp_listen(struct net_lwip_ctx *net)
+{
+	ALLOC_CACHE_ALIGN_BUFFER(uchar, frame, PKTSIZE_ALIGN);
+	const struct eth_ops *ops = eth_get_ops(net->dev);
+	int ret, len;
+
+	if (ops->mcast) {
+		ret = ops->mcast(net->dev, net_cdp_ethaddr, true);
+		if (ret)
+			return ret;
+	}
+	listening = net->netif;
+	received = false;
+	len = cdp_build_trigger(frame, net->netif->hwaddr);
+	for (int i = 0; i < 3; i++) {
+		unsigned long start = get_timer(0);
+
+		/* CDP must discover VLANs before ordinary traffic is tagged. */
+		ret = eth_send(frame, len);
+		if (ret < 0)
+			break;
+		while (get_timer(start) < CDP_TIMEOUT) {
+			if (ctrlc()) {
+				ret = -EINTR;
+				goto done;
+			}
+			ret = net_lwip_poll();
+			if (ret < 0)
+				goto done;
+			if (received) {
+				ret = 0;
+				goto done;
+			}
+		}
+		ret = -ETIMEDOUT;
+	}
+done:
+	listening = NULL;
+	if (ops->mcast) {
+		int leave = ops->mcast(net->dev, net_cdp_ethaddr, false);
+
+		if (!ret)
+			ret = leave;
+	}
+	return ret;
+}
+
+static int cdp_set_vlan(const char *name, const char *kind, int id)
+{
+	if (id < 0)
+		return 0;
+	printf("CDP offered %s VLAN %d\n", kind, id);
+	return id == VLAN_VID_MASK ? env_set(name, NULL) : env_set_ulong(name, id);
+}
+
+static int do_cdp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	struct net_lwip_ctx net = {};
+	int ret;
+
+	if (listening || net_lwip_start(&net, NET_LWIP_ADDR_ENV_FLEXIBLE))
+		return CMD_RET_FAILURE;
+	net_try_count = 1;
+	net_restart_wrap = 0;
+	while ((ret = cdp_listen(&net)) == -ETIMEDOUT) {
+		ret = net_lwip_restart(&net);
+		if (ret)
+			break;
+	}
+	net_lwip_stop(&net);
+	if (ret || cdp_set_vlan("vlan", "appliance", vlans.appliance) ||
+	    cdp_set_vlan("nvlan", "native", vlans.native))
+		return CMD_RET_FAILURE;
+	return CMD_RET_SUCCESS;
+}
+
+U_BOOT_CMD(cdp, 1, 1, do_cdp, "Perform CDP network configuration", "");
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 8b55c9646ef..3a9a5a42716 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -32,6 +32,7 @@
 #include <timer.h>
 #include <time.h>
 #include <u-boot/schedule.h>
+#include "../cdp.h"
 
 /* xx:xx:xx:xx:xx:xx\0 */
 #define MAC_ADDR_STRLEN 18
@@ -1110,6 +1111,8 @@ static int net_lwip_rx(struct udevice *udev, struct netif *netif)
 		flags = 0;
 
 		if (len > 0) {
+			if (CONFIG_IS_ENABLED(CMD_CDP))
+				net_lwip_cdp_receive(netif, packet, len);
 			if (CONFIG_IS_ENABLED(CMD_PCAP))
 				pcap_post(packet, len, false);
 
diff --git a/test/dm/Makefile b/test/dm/Makefile
index cba32cc3dd3..6289a873a4e 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -64,6 +64,9 @@ obj-y += lwip_dhcp_options.o
 obj-y += lwip_dhcp_proxy.o
 obj-y += lwip_dhcp_policy.o
 endif
+ifeq ($(CONFIG_NET_LWIP)$(CONFIG_CMD_CDP),yy)
+obj-y += lwip_cdp.o
+endif
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_CMD_BOOTP),yy)
 obj-y += lwip_bootp.o
 endif
diff --git a/test/dm/lwip_cdp.c b/test/dm/lwip_cdp.c
new file mode 100644
index 00000000000..a3404764748
--- /dev/null
+++ b/test/dm/lwip_cdp.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <command.h>
+#include <dm.h>
+#include <env.h>
+#include <net.h>
+#include <asm/eth.h>
+#include <asm/unaligned.h>
+#include <dm/test.h>
+#include <test/ut.h>
+#include "lwip_test.h"
+
+struct cdp_test_config {
+	bool tagged;
+	bool no_vlan;
+	bool seeded;
+};
+
+static int cdp_reply(struct udevice *dev, void *packet, unsigned int len)
+{
+	const u8 dst[] = { 1, 0, 0x0c, 0xcc, 0xcc, 0xcc };
+	u8 payload[] = {
+		0xaa, 0xaa, 3, 0, 0, 0x0c, 0x20, 0,
+		2, 180, 0, 0,
+		0, 1, 0, 6, 'a', 'b',
+		0, 10, 0, 6, 0, 17,
+		0, 14, 0, 7, 1, 0, 31,
+	};
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct cdp_test_config *config = priv->priv;
+	bool tagged = config->tagged;
+	size_t hlen = tagged ? VLAN_ETH_HLEN : ETHER_HDR_SIZE;
+	unsigned int end;
+	int idx = priv->recv_packets;
+	u8 *out;
+
+	if (len < ETHER_HDR_SIZE || memcmp(packet, dst, ETH_ALEN))
+		return 0;
+	if (config->no_vlan && !config->seeded) {
+		if (env_set("vlan", "23") || env_set("nvlan", "24"))
+			return -EINVAL;
+		config->seeded = true;
+	}
+	if (config->no_vlan) {
+		put_unaligned_be16(VLAN_VID_MASK, payload + 22);
+		put_unaligned_be16(VLAN_VID_MASK, payload + 29);
+	}
+	end = ETHER_HDR_SIZE + get_unaligned_be16(packet + 12);
+	if (len != max_t(unsigned int, end, ETH_ZLEN) ||
+	    memchr_inv(packet + end, 0, len - end) || idx >= PKTBUFSRX)
+		return -EINVAL;
+	out = priv->recv_packet_buffer[idx];
+	memset(out, 0, ETH_ZLEN);
+	memcpy(out, dst, ETH_ALEN);
+	memcpy(out + ETH_ALEN, priv->fake_host_hwaddr, ETH_ALEN);
+	if (hlen == VLAN_ETH_HLEN) {
+		put_unaligned_be16(PROT_VLAN, out + 12);
+		put_unaligned_be16(200, out + 14);
+	}
+	put_unaligned_be16(sizeof(payload), out + hlen - 2);
+	memcpy(out + hlen, payload, sizeof(payload));
+	/* Wire checksums for odd final octets 0x1f and 0x9f, respectively. */
+	if (tagged)
+		out[hlen + sizeof(payload) - 1] = 0x9f;
+	/* Checksums for the regular VLANs and the no-VLAN sentinel reply. */
+	put_unaligned_be16(config->no_vlan ? 0x8ab0 :
+			   tagged ? 0x9b0d : 0x9a8d, out + hlen + 10);
+	priv->recv_packet_length[idx] = ETH_ZLEN;
+	priv->recv_packets++;
+	return 0;
+}
+
+static int cdp_check(struct unit_test_state *uts)
+{
+	struct cdp_test_config config = {};
+	int ret;
+
+	ut_assertok(env_set("ethact", "eth@10002000"));
+	ut_assertok(env_set("netretry", "no"));
+	for (int i = 0; i < 2; i++) {
+		config.tagged = i;
+		env_set("vlan", NULL);
+		env_set("nvlan", NULL);
+		sandbox_eth_set_priv(0, &config);
+		sandbox_eth_set_tx_handler(0, cdp_reply);
+		ret = run_command("cdp", 0);
+		sandbox_eth_set_tx_handler(0, NULL);
+		sandbox_eth_set_priv(0, NULL);
+		ut_assertok(ret);
+		ut_asserteq_str(config.tagged ? "159" : "31", env_get("vlan"));
+		ut_asserteq_str("17", env_get("nvlan"));
+	}
+
+	config.tagged = false;
+	config.no_vlan = true;
+	env_set("vlan", NULL);
+	env_set("nvlan", NULL);
+	sandbox_eth_set_priv(0, &config);
+	sandbox_eth_set_tx_handler(0, cdp_reply);
+	ret = run_command("cdp", 0);
+	sandbox_eth_set_tx_handler(0, NULL);
+	sandbox_eth_set_priv(0, NULL);
+	ut_assertok(ret);
+	ut_assertnull(env_get("vlan"));
+	ut_assertnull(env_get("nvlan"));
+
+	return 0;
+}
+
+static int dm_test_lwip_cdp(struct unit_test_state *uts)
+{
+	const char *const vars[] = { "ethact", "netretry", "vlan", "nvlan" };
+
+	return lwip_test_with_env(uts, vars, ARRAY_SIZE(vars), cdp_check);
+}
+
+DM_TEST(dm_test_lwip_cdp, UTF_SCAN_FDT);

-- 
2.53.0

