Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB339606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VqLWRGh6;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mJd58A/W
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9694960A97;
	Thu, 26 Nov 2026 13:33:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CRx2hJ_GRgvK; Thu, 26 Nov 2026 13:33:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2EE3E60A92
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700006;
	b=e6PszRmycI471Ln6Nwf7sFL++iXQ+v+JK6SAiFrtONW+v3rwlEzAQtgaT5RfKV2aMFa4
	 wXwogXklDwYTqHgXG7Hm6Lac2/qL+dV8LNbZ7GDSGhpp2n7izdiV7txI09p5iXAr4T94H
	 8DcIgYwBkofgea2kvjWIbeeP7RYhHWGcHZ4t575yeHuBj9kUZT5oueFRsW85Bebl1r4rH
	 eNvlOAGHxYOPqm9MODr4U/UrhDGLciOnhv31dOfWbLQ2uijt7rCqmpOuilekBPomwB1JO
	 O5orBLNu4XfKYpDqpDN0Wp7fFbcihTiF9py3txXMlF1J3BnynTFH9PHpdyxMtzm42dg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700006;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OhIR9pwoLsmAPOf7sZpsdBPxF9N+/AUajBRRSQi7hhg=;
	b=FfLq+cnd5CuqnuI3n1TRgUgeX3vyMW+JQCZ9OZTcHpZiLZmfichTq5WRP3QZVGxTfvH/
	 ByGGV2tQNooLDewASLt3yXeTT7+eAVK8Q8U8H3eFD06WA5z9yj2UGNA4LuSq5SvHvX5FN
	 wfHPCu12WFw7PPeBqJ8PApRlbciireeJYvYa1tEhGU3FAWqgTWdRZyS3ykxOXtk6zQGNK
	 alV66RYn1bAJsg5ikx4Nx3I6tWLcHZdedDZTEY/Oc6nxv2jPZZBKDgQueNkU6KKvkgKRY
	 j+CGmSbRsTS+nMEwmjZj0VX97K6w1C8s92qFn89R/PTNC03RMzMgzzrdq6ilsDQ0SrA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700006;
	bh=OhIR9pwoLsmAPOf7sZpsdBPxF9N+/AUajBRRSQi7hhg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VqLWRGh6znzGeeclxrgE+5BxrVd1tI+4BMhJnUNOVITrWsHJwI9rZTAv+1PcUHjL/
	 1i5dqarEypI/40XVGxsmgw5Qx00y4C3Tlf4VHAP5JI2RYgOwIIXesv1vPlgabEjSuO
	 SeFMuktDVssAA1NTMU34Q2xNBUXP2vdlQVwdHnPUplY/1jyeIwf2ZLA4Uo0QQQmhTy
	 2e35XFF2OuKwiusX3bfb5gXPaarPifPRjpPTPKJYK+rpZibOCuOdZWUNlz7pDc8WAs
	 /IBUM7maS3M4crlQTpyAr+jqS0+kcuvv0qcoLB14SUb/snzfqAlq5ilb1P/+f8xr4t
	 EmN+pKO3gSdvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EE3E60A92;
	Thu, 26 Nov 2026 13:33:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D3D5260
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E4BC80A88
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RevpVpqOoPw2 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 06:53:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1B1D6809EE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=mJd58A/W
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1B1D6809EE
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:14 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-86288992de5so4940114a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795675994; x=1796280794;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OhIR9pwoLsmAPOf7sZpsdBPxF9N+/AUajBRRSQi7hhg=;
 b=mJd58A/WfZjS7b1H8Op5TeFXKlARa4ULtdBSfKbGJAUxeRfAlwyGT781tEKAGWC5wF
 rv292O8kQGj3H/EbKT4c7pzYK+bxgZ+NedzDw9/NUivvLDEr8f+1VvJlHd89Qn2qjDDM
 YlWGocpBJtO44OeQDiiHiNvypMeN9sz1JutkAsAjAGiIzqxXopjR8sSZv7xUrd3GibVe
 5cob3sktLr6acVTxx8GnBgUKUUzRqYBiw8N95ILW5hAq0iaaG9qHwnvoMFLQUyxv9tUI
 ts8yjswT1X4UdN8YUMwI0Z/Xuu00cG2/u/fz9XQTr9/cbX0GTWpNwIwtkVIG5TztwguT
 QjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795675994; x=1796280794;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OhIR9pwoLsmAPOf7sZpsdBPxF9N+/AUajBRRSQi7hhg=;
 b=mUOnpdk0Gyj19YmlHjxiHDbv/hA74JMWTzlQ43vq586URJtj/ZWv/eGuHZeyQmhv6X
 /IwvfauD3ZwjVSmCi2cT9Yl91OkRcKA15/sy5Liqzfh5sKai3RZmiAS+UyJDnT5qnFW1
 qaM5wo4iwu465w7ycK7iAqQqOv0d9CJRMpEvQpDnJgzzSJQR0q3DdGR4SvgDu7dYlP94
 Skg8DsVRRyEX1+7bOaCuQfCDJeja5vNEsHTq/JpHLPFAqrQPEOovGfcZ88qGkSIQ+ZYK
 AgHhA2jxgSh6kVXSWZPAZHy4CgonZZ+YCUcC2ak+zxrQTO5gXR1aWYfWYzfI8xvyBRBQ
 ZWZQ==
X-Gm-Message-State: APuU4Z8JpYRSvMpux0ZRjbnSncuuK0LmN+5bQzAJSlygTVmoQH3nC4SP
 TEv951m0DmOpZTJFyjGGyqrz4tG/xwRQp6eMU6RrjAOl3KqdP3HlOwbs
X-Gm-Gg: AZFdTZcyAUU2pKhcsoQyxZzMsfnJrnJ6LizAuKV8wnbTEIkViGweTkVwm9l6syp2mxo
 PGgYf6MnxIBHiO3ecyU/VXWOndF4JFCoJ6HDpfu9qSEi15vTzyhKKIF4VXA3xRStqM3XvDfX5xc
 ShpOfHntn7z/x3QWtCO/hs+XmqM4FjDoC8FTvDqiuLLldXAgkwBsLtBIitokwp2WdA/OpZpVoTb
 BZL3tfaN94/g8IuQ+PwxkQyGGS38XtxJiC/Vx7dJLNfFRvkIjTpDvgrpWJ1+vJi9i7wZ9KyhpM7
 3z0fF1yUvKhdlx8ua0nRnfSMc9Bevo7uconTV0CyvvG39MXWouw+TONEmJSoNlh9WASgaGzYpKm
 abYFqkhQN0vQQnmp3ISoHA+ah6glN2sS5Zs4Tmtc4H4yr7XABgdUBcJJ57aUUjZI/tHJE/wsiww
 WJVxM12JBoIHKS9zsgN1kmcrMLYy81cYT0qyoHb/yOSmq9h6eURq2wSEVpw40odKckIJDcOxALg
 iyPvANd/+wTp+f1tl4pDgkwFBDhYgs7jy2jvW47Pm5q/cm12SK3SgoIj0OIKVUOiNFdxNGtmG1K
 NS+nU/r3luSPZYnOk8fk3hwMoiDoZM76t5JPi0Bdt4ny98ZgW+vPTR+WiYv7E5bacD5Pw5GTnMj
 iLmZgVCoU70w7Emaa0yYxR4VHFF/9nYQ0iJNjM/wCloKdLoFitpb1NzArMT0wVAzIVoPCsGgvou
 aHC5O5+5RT0VixYCTlW82qdQiYyiBfcnZMowToG0xrI5S8owMutw0=
X-Received: by 2002:a05:6830:4424:b0:863:3a1a:91f8 with SMTP id
 46e09a7af769-8633a1aa07cmr10110755a34.10.1795675993607; 
 Wed, 25 Nov 2026 22:53:13 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86385358ca2sm31041a34.21.2026.11.25.22.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:53:13 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 25 Nov 2026 23:52:52 -0700
Subject: [PATCH 03/19] net: lwip: apply the configured Ethernet VLAN
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-submit-lwip-network-boot-v1-v1-3-63df291d9392@gmail.com>
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

Tag outgoing frames with vlan, and accept untagged frames on an
active VLAN only when nvlan identifies it as the native VLAN. Apply
the receive policy before handing packets to either lwIP or the raw
WoL listener, while leaving packet capture on the wire side of the
filter.

Keep the VLAN policy fixed while clients share an interface. A VLAN
change could otherwise reuse neighbor entries learned on the previous
link. Reject attachment or refresh until the last client detaches and
a new interface is created.

Use lwIP Ethernet encapsulation for both IPv4 and IPv6 and reserve
headroom for the larger header. Exercise VLAN transmission and receive
policy changes in sandbox.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 lib/lwip/u-boot/lwip-hooks.h |   3 +
 lib/lwip/u-boot/lwipopts.h   |   3 +-
 net/lwip/net-lwip.c          |  75 ++++++++++++++++++++-
 net/lwip/wol.c               |   7 ++
 test/dm/lwip.c               | 152 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 237 insertions(+), 3 deletions(-)

diff --git a/lib/lwip/u-boot/lwip-hooks.h b/lib/lwip/u-boot/lwip-hooks.h
index c4bf364ba3c..f665e80e869 100644
--- a/lib/lwip/u-boot/lwip-hooks.h
+++ b/lib/lwip/u-boot/lwip-hooks.h
@@ -4,6 +4,9 @@
 #ifndef __UBOOT_LWIP_HOOKS_H
 #define __UBOOT_LWIP_HOOKS_H
 
+int net_lwip_vlan_id(void);
+#define LWIP_HOOK_VLAN_SET(...) net_lwip_vlan_id()
+
 #ifdef CONFIG_CMD_DHCP
 #include "lwip-dhcp.h"
 #endif
diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
index b1f9d9cdb62..ab3b39a198f 100644
--- a/lib/lwip/u-boot/lwipopts.h
+++ b/lib/lwip/u-boot/lwipopts.h
@@ -244,7 +244,8 @@
 
 #define LWIP_LISTEN_BACKLOG             0
 
-#define PBUF_LINK_HLEN                  14
+#define ETHARP_SUPPORT_VLAN             1
+#define PBUF_LINK_HLEN                  18
 #define PBUF_POOL_BUFSIZE               LWIP_MEM_ALIGN_SIZE(TCP_MSS + 40 + PBUF_LINK_HLEN)
 
 #define LWIP_HAVE_LOOPIF                0
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 726731bc2fa..d7a38b9f72f 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -3,6 +3,7 @@
 /* Copyright (C) 2024 Linaro Ltd. */
 
 #include <command.h>
+#include <asm/unaligned.h>
 #include <console.h>
 #include <env.h>
 #include <image.h>
@@ -43,10 +44,12 @@ int net_restart_wrap;
 static struct {
 	struct udevice *dev;
 	struct netif *netif;
+	int vlan;
 	unsigned int users;
 	unsigned int env_users;
 	unsigned int strict_env_users;
 	unsigned int no_addr_users;
+	bool accept_untagged;
 	bool polling;
 #if CONFIG_IS_ENABLED(IPV6)
 	bool ip6_configured;
@@ -61,6 +64,52 @@ static uchar net_pkt_buf[(PKTBUFSRX) * PKTSIZE_ALIGN + PKTALIGN]
 const u8 net_bcast_ethaddr[6] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 char *pxelinux_configfile;
 
+static int env_vlan_id(const char *name)
+{
+	const char *value = env_get(name);
+	unsigned int id;
+
+	if (!value || net_lwip_parse_decimal(value, strlen(value),
+					     VLAN_VID_MASK - 1, &id))
+		return -1;
+
+	return id;
+}
+
+static int net_lwip_configure_vlan(void)
+{
+	int vlan = env_vlan_id("vlan");
+	bool untagged = vlan < 0 || vlan == env_vlan_id("nvlan");
+
+	/* ARP and IPv6 neighbor entries belong to the lifetime of the netif. */
+	if (net_lwip_runtime.users &&
+	    (vlan != net_lwip_runtime.vlan ||
+	     untagged != net_lwip_runtime.accept_untagged))
+		return -EBUSY;
+
+	net_lwip_runtime.vlan = vlan;
+	net_lwip_runtime.accept_untagged = untagged;
+	return 0;
+}
+
+int net_lwip_vlan_id(void)
+{
+	return net_lwip_runtime.vlan;
+}
+
+static bool net_lwip_accept_vlan(const uchar *packet, int len)
+{
+	int id = net_lwip_vlan_id();
+
+	if (len < ETHER_HDR_SIZE)
+		return false;
+	if (get_unaligned_be16(packet + 2 * ETH_ALEN) != PROT_VLAN)
+		return net_lwip_runtime.accept_untagged;
+
+	return len >= VLAN_ETH_HLEN && id >= 0 &&
+		(get_unaligned_be16(packet + ETHER_HDR_SIZE) & VLAN_VID_MASK) == id;
+}
+
 static err_t net_lwip_tx(struct netif *netif, struct pbuf *p)
 {
 	struct udevice *udev = netif->state;
@@ -205,12 +254,20 @@ int net_set_ether(uchar *xet, const uchar *dest_ethaddr, uint prot)
 {
 	struct ethernet_hdr *et = (struct ethernet_hdr *)xet;
 	const uchar *src = eth_get_ethaddr();
+	int vlan_id = net_lwip_runtime.users ? net_lwip_vlan_id() :
+		env_vlan_id("vlan");
 
 	memcpy(et->et_dest, dest_ethaddr, ARP_HLEN);
 	if (src)
 		memcpy(et->et_src, src, ARP_HLEN);
 	else
 		memset(et->et_src, 0, ARP_HLEN);
+	if (vlan_id >= 0) {
+		et->et_protlen = htons(PROT_VLAN);
+		put_unaligned_be16(vlan_id, xet + ETHER_HDR_SIZE);
+		put_unaligned_be16(prot, xet + ETHER_HDR_SIZE + 2);
+		return VLAN_ETH_HLEN;
+	}
 	et->et_protlen = htons(prot);
 
 	return ETHER_HDR_SIZE;
@@ -754,6 +811,10 @@ static int net_lwip_start_ctx(struct net_lwip_ctx *ctx,
 	     net_lwip_runtime.no_addr_users))
 		return -EBUSY;
 
+	ret = net_lwip_configure_vlan();
+	if (ret)
+		return ret;
+
 	if (!net_lwip_runtime.users) {
 		/* net_start_again() already selected and started the next NIC. */
 		if (!eth_started) {
@@ -857,8 +918,8 @@ void net_lwip_stop(struct net_lwip_ctx *ctx)
 		return;
 	}
 
-	if (!net_lwip_runtime.no_addr_users &&
-	    net_lwip_runtime.env_users &&
+	if (!net_lwip_runtime.no_addr_users && net_lwip_runtime.env_users &&
+	    !net_lwip_configure_vlan() &&
 	    net_lwip_configure(NET_LWIP_ADDR_ENV_FLEXIBLE))
 		log_err("Failed to restore lwIP interface addressing\n");
 }
@@ -931,10 +992,16 @@ int net_lwip_restart(struct net_lwip_ctx *ctx)
  */
 int net_lwip_refresh(struct net_lwip_ctx *ctx)
 {
+	int ret;
+
 	if (!ctx || ctx->netif != net_lwip_runtime.netif ||
 	    ctx->dev != net_lwip_runtime.dev || !net_lwip_runtime.users)
 		return -EINVAL;
 
+	ret = net_lwip_configure_vlan();
+	if (ret)
+		return ret;
+
 	if (net_lwip_runtime.no_addr_users && ctx->addr_mode != NET_LWIP_ADDR_NONE)
 		return 0;
 
@@ -1013,6 +1080,9 @@ static int net_lwip_rx(struct udevice *udev, struct netif *netif)
 					       packet, len, true);
 			}
 
+			if (!net_lwip_accept_vlan(packet, len))
+				goto release;
+
 			if (IS_ENABLED(CONFIG_CMD_WOL))
 				net_lwip_wol_receive(netif, packet, len);
 
@@ -1020,6 +1090,7 @@ static int net_lwip_rx(struct udevice *udev, struct netif *netif)
 			if (pbuf)
 				netif->input(pbuf, netif);
 		}
+release:
 		if (len >= 0 && eth_get_ops(udev)->free_pkt)
 			eth_get_ops(udev)->free_pkt(udev, packet, len);
 		if (len <= 0)
diff --git a/net/lwip/wol.c b/net/lwip/wol.c
index 579f9752d50..0b0885ce4a2 100644
--- a/net/lwip/wol.c
+++ b/net/lwip/wol.c
@@ -71,6 +71,13 @@ void net_lwip_wol_receive(struct netif *netif, const u8 *packet, int len)
 	protocol = get_unaligned_be16(packet + 2 * ARP_HLEN);
 	packet += ETHER_HDR_SIZE;
 	len -= ETHER_HDR_SIZE;
+	if (protocol == PROT_VLAN) {
+		if (len < VLAN_HLEN)
+			return;
+		protocol = get_unaligned_be16(packet + 2);
+		packet += VLAN_HLEN;
+		len -= VLAN_HLEN;
+	}
 
 	switch (protocol) {
 	case PROT_WOL:
diff --git a/test/dm/lwip.c b/test/dm/lwip.c
index 78c074a7723..ba5e6ff1b96 100644
--- a/test/dm/lwip.c
+++ b/test/dm/lwip.c
@@ -12,6 +12,8 @@
 #include <net.h>
 #include <time.h>
 #include <asm/eth.h>
+#include <asm/unaligned.h>
+#include <lwip/etharp.h>
 #include <dm/test.h>
 #include <linux/kconfig.h>
 #include <test/ut.h>
@@ -324,6 +326,156 @@ static int lwip_test_http_abort(struct unit_test_state *uts)
 }
 #endif
 
+struct vlan_wire {
+	int vid;
+};
+
+static int lwip_vlan_tx(struct udevice *dev, void *packet, unsigned int len)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct vlan_wire *wire = priv->priv;
+	const u8 *frame = packet;
+
+	if (len >= ETHER_HDR_SIZE &&
+	    get_unaligned_be16(frame + 12) == PROT_ARP) {
+		wire->vid = -1;
+	} else if (len >= VLAN_ETH_HLEN &&
+		   get_unaligned_be16(frame + 12) == PROT_VLAN &&
+		   get_unaligned_be16(frame + 16) == PROT_ARP)
+		wire->vid = get_unaligned_be16(frame + 14) & VLAN_VID_MASK;
+	return 0;
+}
+
+static int lwip_vlan_check(struct unit_test_state *uts, struct net_lwip_ctx *net,
+			   struct net_lwip_ctx *other, struct udp_pcb **pcb)
+{
+	const int tags[] = { 17, 16, -1 };
+	char *const reset_vars[] = { "vlan" };
+	struct in_addr host = string_to_ip("1.1.2.2");
+	struct eth_sandbox_priv *priv = dev_get_priv(net->dev);
+	struct lwip_test_recv_ctx rx = {};
+	struct vlan_wire wire = { .vid = -1 };
+	ip4_addr_t server;
+
+	sandbox_eth_set_priv(0, &wire);
+	sandbox_eth_set_tx_handler(0, lwip_vlan_tx);
+	ip4_addr_set_u32(&server, host.s_addr);
+	ut_asserteq(ERR_OK, etharp_request(net->netif, &server));
+	ut_asserteq(17, wire.vid);
+
+	*pcb = udp_new();
+	ut_assertnonnull(*pcb);
+	ut_asserteq(ERR_OK, udp_bind(*pcb, IP_ADDR_ANY, 10000));
+	udp_recv(*pcb, lwip_test_udp_recv, &rx);
+	for (int i = 0; i < ARRAY_SIZE(tags); i++) {
+		int idx = priv->recv_packets;
+		u8 *frame;
+
+		ut_assertok(lwip_test_inject_udp(net->dev, "test", host, 10001, 10000));
+		frame = priv->recv_packet_buffer[idx];
+		if (tags[i] >= 0) {
+			memmove(frame + 16, frame + 12, priv->recv_packet_length[idx] - 12);
+			put_unaligned_be16(PROT_VLAN, frame + 12);
+			put_unaligned_be16(tags[i] | (5 << VLAN_PRIO_SHIFT), frame + 14);
+			priv->recv_packet_length[idx] += VLAN_HLEN;
+		}
+		ut_assertok(net_lwip_poll());
+		ut_asserteq(1, rx.packets);
+	}
+
+	/* A VLAN change cannot reuse state from the attached netif. */
+	ut_assertok(env_set("vlan", "31"));
+	ut_asserteq(-EBUSY, net_lwip_refresh(net));
+	ut_asserteq(-EBUSY, net_lwip_start(other, NET_LWIP_ADDR_ENV_FLEXIBLE));
+	wire.vid = -2;
+	ut_asserteq(ERR_OK, etharp_request(net->netif, &server));
+	ut_asserteq(17, wire.vid);
+	{
+		int idx = priv->recv_packets;
+		u8 *frame;
+
+		ut_assertok(lwip_test_inject_udp(net->dev, "test", host, 10001, 10000));
+		frame = priv->recv_packet_buffer[idx];
+		memmove(frame + 16, frame + 12,
+			priv->recv_packet_length[idx] - 12);
+		put_unaligned_be16(PROT_VLAN, frame + 12);
+		put_unaligned_be16(17 | (5 << VLAN_PRIO_SHIFT), frame + 14);
+		priv->recv_packet_length[idx] += VLAN_HLEN;
+		ut_assertok(net_lwip_poll());
+		ut_asserteq(2, rx.packets);
+	}
+
+	/* A changed native VLAN is not used until the interface is reopened. */
+	ut_assertok(env_set("vlan", "17"));
+	ut_assertok(env_set("nvlan", "17"));
+	ut_asserteq(-EBUSY, net_lwip_refresh(net));
+
+	/* Untagged traffic remains filtered until the interface is reopened. */
+	{
+		ut_assertok(lwip_test_inject_udp(net->dev, "test", host, 10001, 10000));
+		ut_assertok(net_lwip_poll());
+		ut_asserteq(2, rx.packets);
+	}
+
+	udp_remove(*pcb);
+	*pcb = NULL;
+	net_lwip_stop(net);
+	ut_assertok(net_lwip_start(net, NET_LWIP_ADDR_ENV_STRICT));
+	rx = (struct lwip_test_recv_ctx){};
+	*pcb = udp_new();
+	ut_assertnonnull(*pcb);
+	ut_asserteq(ERR_OK, udp_bind(*pcb, IP_ADDR_ANY, 10000));
+	udp_recv(*pcb, lwip_test_udp_recv, &rx);
+	ut_assertok(lwip_test_inject_udp(net->dev, "test", host, 10001, 10000));
+	ut_assertok(net_lwip_poll());
+	ut_asserteq(1, rx.packets);
+
+	ut_asserteq(1, env_set_default_vars(ARRAY_SIZE(reset_vars),
+					    reset_vars, 0));
+	ut_asserteq(-EBUSY, net_lwip_refresh(net));
+	wire.vid = -2;
+	ut_asserteq(ERR_OK, etharp_request(net->netif, &server));
+	ut_asserteq(17, wire.vid);
+	udp_remove(*pcb);
+	*pcb = NULL;
+	net_lwip_stop(net);
+	ut_assertok(net_lwip_start(net, NET_LWIP_ADDR_ENV_STRICT));
+	wire.vid = -2;
+	ut_asserteq(ERR_OK, etharp_request(net->netif, &server));
+	ut_asserteq(-1, wire.vid);
+	return 0;
+}
+
+static int lwip_vlan_run(struct unit_test_state *uts)
+{
+	struct net_lwip_ctx net = {}, other = {};
+	struct udp_pcb *pcb = NULL;
+	int ret;
+
+	ut_assertok(env_set("ethact", "eth@10002000"));
+	ut_assertok(env_set("ipaddr", "1.1.2.1"));
+	ut_assertok(env_set("vlan", "17"));
+	ut_assertok(env_set("nvlan", "16"));
+	ut_assertok(net_lwip_start(&net, NET_LWIP_ADDR_ENV_STRICT));
+	ret = lwip_vlan_check(uts, &net, &other, &pcb);
+	if (pcb)
+		udp_remove(pcb);
+	sandbox_eth_set_tx_handler(0, NULL);
+	sandbox_eth_set_priv(0, NULL);
+	net_lwip_stop(&other);
+	net_lwip_stop(&net);
+	return ret;
+}
+
+static int dm_test_lwip_vlan(struct unit_test_state *uts)
+{
+	const char *const vars[] = { "ethact", "ipaddr", "vlan", "nvlan" };
+
+	return lwip_test_with_env(uts, vars, ARRAY_SIZE(vars), lwip_vlan_run);
+}
+
+DM_TEST(dm_test_lwip_vlan, UTF_SCAN_FDT);
+
 static int _dm_test_lwip_runtime(struct unit_test_state *uts,
 				 struct net_lwip_ctx *client_a,
 				 struct net_lwip_ctx *client_b,

-- 
2.53.0

