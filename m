Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7494606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kIq2mTvR;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A5iFe3Dy
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4933409E5;
	Thu, 26 Nov 2026 13:33:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u7or_EoVq4Vc; Thu, 26 Nov 2026 13:33:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 88FA8409E0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700004;
	b=OBE55V4II8WF9x4F9bz0MoC3ST6/sT31WUnV6b7erpp309XpUHyPXZQAj1zHCDLpKftJ
	 mOSAkkqc9OADgTzWnyIWLjc8/LgLuuaELLaLinH5zdShjIBK9QJurkfQh0qDhSNLqPlvU
	 jA7qWnTynuDdmC0Do76xQpq1PtHBGKzp6C6WBXWqmGuV9F9BEoSrSL9keNygdIaL8nuGy
	 ZbpQqOLZA/WsWvHhdU65OqO8Ir0W5UeCNTtuV3kpXGzaHMn1XsRCd0dAcvGnf7rMZU+m+
	 Bc840vNboPS/vo3zjrYzw5Y9r3I5OuS0GF8MqbyInu7xJY/Itbeoeb6fBdXhfA2K4YQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700004;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Us2nvpsWRUzU6kGZJdDDKkWzcd3AVRnXsjkStoPj5mM=;
	b=HczAq67d7wIkIDpxIaNP7CeMrx2mn/wW5K+HrC2pQ7Iu5f6xESm8zgJqP2kHRUpOwace
	 mT2O0cl5Nuw8yJ7UFOAIzJd3dri7rRlBwnqYddyXpOgtO2UDgLUszI5XetdzuBBiTAihT
	 qkc2blJ68wAvzC4ACn0kTj6ebhbpTh/bKVJUUskMO/59M4CuFXdv5iOsZ3Cj02OYKIW5X
	 AZtVazLk/jHQs7RTiAjXlbi8vUFsWg2wEFdSrD+R92zgpIgzhsJ47jfqYZgympKHKQjAy
	 Cg8rQc3f6HxydSjkq8Qj/Lkg0fXc31SUFt49ArNMAv+09qA49o9PuyUl3FX74GUU11Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A5iFe3Dy;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700004;
	bh=Us2nvpsWRUzU6kGZJdDDKkWzcd3AVRnXsjkStoPj5mM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kIq2mTvR/BUnMQ4JATO4xqZF8iGwQmjFJ/WJSoz9VL3E3gY+sJjh0x9bTGFyjXNxe
	 MKGbdi7Qvo9ysC4duJ13pL7uFP8RPuCzhX5cFllMeYhVahUml+zXHxiVekxgHs7r60
	 rg4AKh5Wy8IB6u6kmasmK6Tza/ZQ+3FIleLCk5vKE7w4RLn5eko9RpHUKWcg3aOolv
	 zLxCBTyNR/d4vdaeyLPBaEW4OdUUvkGplvZAfc+3rGotFtJoBS+vWJ6FmuYmLPMmwu
	 V0ftvFFtyY2/derGXWuV1BrltNCe/rjlTjl2gfF3fDhXfAADtIypcfZoMmhzuG3+wY
	 vqo5OMfjB4g1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88FA8409E0;
	Thu, 26 Nov 2026 13:33:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FF2732D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 561214079A
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HJkSbnXCsBli for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 06:53:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 69F24405C8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=A5iFe3Dy
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 69F24405C8
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:12 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-71ac9e15640so4221028eaf.3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795675992; x=1796280792;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Us2nvpsWRUzU6kGZJdDDKkWzcd3AVRnXsjkStoPj5mM=;
 b=A5iFe3DypsBjySkjIoa42YO0mieMwwd3g+1zQfgBq/+dIrkdYAyoWF8R0xF4SYFv58
 i6oyQjghV9exVQMj0BtALLcAuST7DmXp/+OMYgSNKNhOgWd98OwKin1Gj3hlHOlAlwBv
 OStNoxbOyGv8FWHjxtvOrGkVinpITh+JCW7DGbip6cqSTj0oF3h1meUW8BaL6GRvuzgH
 qmXk6Hl6LnbbHOPvAjg+B+aJheBohNjM34LGZITgOPx7F1qMQJOm+Jy7gcqqi6Bvf/7w
 BzHOZcNE4YuI4ajNkQtsFKXdfdtCxlKi5X3WdrjJxhAiDp5LdT2umkuid8YaT/I2TAkR
 +AEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795675992; x=1796280792;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Us2nvpsWRUzU6kGZJdDDKkWzcd3AVRnXsjkStoPj5mM=;
 b=V+B9ZJrhxxCvRDZCybM+xQTviZBs3c2GVzt7hVjME9FJ9mGnodEAEwIfdKQI9jm61p
 BLyrXDR8bQMnKkUhRqsQmN92QgtrTktUvsSy+Cr9l0bQ9kgXwC1DQkOO1+nLAU2E0pnV
 XkbHqthZ2lqtDWopAjUJe8uBHQPK+/Fo42DD52UZ75V+ppzgMilaRaeHoyzNzfSgD28c
 wkQZFQo58H/z+G9dw1lvnlIfmy9EBZ5ABtdlMiy/a8cNb23+S5U/WjF5Er9IWjtJqR6e
 j/R8yitwEsSunfgnTjjVQErO7VAvwmXns6EzbpuubGJRlnPw7D6T82QO4qBcg8Mct3Ve
 Hamg==
X-Gm-Message-State: APuU4Z8ceOh+F7IBVXbzvH59AROr7hkASlgRMCoK5AX3PRX4c4ZNA58v
 vAhrN67kCA0EzF5wy9UBs2huoKdERRsZCjBvCmlKRV4jtbIcGnQ/BAdQ
X-Gm-Gg: AZFdTZdA0KhC4Yxmm+sIQi4YU1fGZzscC6iib/Kq7lzUoq5ZQORwBcE4O0IviZLpQQQ
 eIxQ4Z2zfZdmrj/mpVrvhPgxtsiDv+lHwBaGuvl9BnyuTvue6zcUxCTyOd3gi0ZOol+A3d98/7C
 Unbv0lLmFAdJ7v3cimgYK6UgtK7UmkrvbRi/YvgNTI3sPZ90VOgPjD8k77kOVRFzuPhwVROo4KO
 dqBmhZk2jM0SBWg32sM5xT+7Ton9OJuBlPOyItSgo60ftZi4MbabAR6+8BXmS2IXcXvaRLDPoHa
 +Sz73diChb5Em/asjycm0Ll3X9lo1t9usTnPLePd9fCaPJ1PoM0XCjrJplj0ndYTTHLHVXQ/p7S
 QRbf/Fyh0SprfsGNV9BAj6TE4bA3LhbkicwO2mgydY6O+jHoJNl6R3VkTvidLi1bcGAxZveGw5K
 XyUcUtv7DvViSPf+0OA/LhjreaRca1stFJP+rDiGJsc9vGzg+8kR7OinEPETECRyqhzFtmw2QZB
 GLJNPmGEJMuZ3xgRTAs5eQPyROO+pRHZ7RgCYfjAi+7vcqh6OJ/SfCoAlHRkdUKqczTA4GTmX/Y
 LhHUCkAXnJ3A9njAYrPBpYC5lZyk75fUQIqqRiR+B/4pnjtvjqYpV8gnfITq3KRoKvqKW/2H4hG
 1H1/k+TCSrbgHAi6HmlfeqayvhlnnIiIzG0GIvZw7d9NMX/beu4m2vhW0sTqRF0GimBOffYoDSG
 D93REwwobzfEHglNdefGmUJSfHmCfXTEZ/o2B0KnEvANn13cr96GA=
X-Received: by 2002:a05:6820:83c5:10b0:6f8:2346:cd8e with SMTP id
 006d021491bc7-71b395b82d5mr11648832eaf.80.1795675991833; 
 Wed, 25 Nov 2026 22:53:11 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86385358ca2sm31041a34.21.2026.11.25.22.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:53:11 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 25 Nov 2026 23:52:51 -0700
Subject: [PATCH 02/19] net: lwip: support the IPv4 linklocal command
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-submit-lwip-network-boot-v1-v1-2-63df291d9392@gmail.com>
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

Allow boards without a DHCP server to acquire an IPv4 link-local address.
Use the lwIP AutoIP client to probe the saved address and choose another
one if a peer already owns it. Export the resulting address and subnet
on the selected interface, and detach the client before releasing the
shared runtime.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/Kconfig                |  4 +--
 cmd/lwip/Makefile          |  1 +
 cmd/lwip/linklocal.c       | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/lwip/u-boot/lwipopts.h |  2 +-
 test/dm/lwip.c             | 48 +++++++++++++++++++++++++++++++
 test/dm/lwip_test.h        | 42 +++++++++++++++++++++++++++
 6 files changed, 165 insertions(+), 3 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index b44ec644b87..5c31fb00013 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2200,6 +2200,8 @@ config CMD_CDP
 	  and to retrieve configuration data including the VLAN id using the
 	  proprietary Cisco Discovery Protocol (CDP).
 
+endif  # if NET_LEGACY
+
 config CMD_LINK_LOCAL
 	bool "linklocal"
 	depends on (LIB_RAND || LIB_HW_RAND)
@@ -2214,8 +2216,6 @@ config CMD_NCSI
 	  Normally this happens automatically before other network
 	  operations.
 
-endif  # if NET_LEGACY
-
 config IPV6_ROUTER_DISCOVERY
 	bool "Do IPv6 router discovery"
 	depends on IPV6
diff --git a/cmd/lwip/Makefile b/cmd/lwip/Makefile
index 606c3693d2b..90ad4d21e6f 100644
--- a/cmd/lwip/Makefile
+++ b/cmd/lwip/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_CMD_BOOTP) += bootp.o
 obj-$(CONFIG_CMD_DHCP) += dhcp.o
 obj-$(CONFIG_CMD_DNS) += dns.o
+obj-$(CONFIG_CMD_LINK_LOCAL) += linklocal.o
 obj-$(CONFIG_CMD_NFS) += nfs.o
 ifneq ($(filter y,$(CONFIG_CMD_PING) $(CONFIG_CMD_PING6)),)
 obj-y += ping.o
diff --git a/cmd/lwip/linklocal.c b/cmd/lwip/linklocal.c
new file mode 100644
index 00000000000..a2df1379276
--- /dev/null
+++ b/cmd/lwip/linklocal.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <command.h>
+#include <console.h>
+#include <dm/device.h>
+#include <env.h>
+#include <net.h>
+#include <lwip/autoip.h>
+#include <lwip/prot/autoip.h>
+
+static int set_addr_env(const char *name, int seq, const ip4_addr_t *addr)
+{
+	char key[sizeof("gatewayip99")];
+
+	if (seq) {
+		snprintf(key, sizeof(key), "%s%d", name, seq);
+		name = key;
+	}
+
+	return env_set(name, ip4addr_ntoa(addr));
+}
+
+static int do_linklocal(struct cmd_tbl *cmdtp, int flag, int argc,
+			char *const argv[])
+{
+	struct net_lwip_ctx net = {};
+	struct autoip client;
+	const char *saved;
+	ip4_addr_t addr;
+	int seq, ret = CMD_RET_FAILURE;
+
+	if (net_lwip_start(&net, NET_LWIP_ADDR_NONE))
+		return CMD_RET_FAILURE;
+	seq = dev_seq(net.dev);
+	if (seq < 0 || seq > 99)
+		goto out;
+
+	autoip_set_struct(net.netif, &client);
+	saved = env_get("llipaddr");
+	if (saved && ip4addr_aton(saved, &addr) &&
+	    ntohl(addr.addr) >= AUTOIP_RANGE_START &&
+	    ntohl(addr.addr) <= AUTOIP_RANGE_END)
+		client.llipaddr = addr;
+	if (autoip_start(net.netif) != ERR_OK)
+		goto detach;
+
+	while (!autoip_supplied_address(net.netif)) {
+		if (ctrlc() || net_lwip_poll() < 0)
+			goto stop;
+	}
+
+	if (set_addr_env("netmask", seq, netif_ip4_netmask(net.netif)) ||
+	    set_addr_env("gatewayip", seq, netif_ip4_gw(net.netif)) ||
+	    set_addr_env("ipaddr", seq, &client.llipaddr) ||
+	    env_set("llipaddr", ip4addr_ntoa(&client.llipaddr)))
+		goto stop;
+	if (!seq)
+		net_ip.s_addr = client.llipaddr.addr;
+	ret = CMD_RET_SUCCESS;
+stop:
+	autoip_stop(net.netif);
+	acd_remove(net.netif, &client.acd);
+detach:
+	autoip_remove_struct(net.netif);
+out:
+	net_lwip_stop(&net);
+	return ret;
+}
+
+U_BOOT_CMD(linklocal, 1, 1, do_linklocal,
+	   "acquire a network IP address using the link-local protocol", "");
diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
index 2c07bdd545c..b1f9d9cdb62 100644
--- a/lib/lwip/u-boot/lwipopts.h
+++ b/lib/lwip/u-boot/lwipopts.h
@@ -205,7 +205,7 @@
 	UBOOT_DHCP_TIMEOFFSET UBOOT_DHCP_PXE_CONFIG 67
 #endif /* defined(CONFIG_CMD_BOOTP) || defined(CONFIG_CMD_DHCP) */
 
-#define LWIP_AUTOIP                     0
+#define LWIP_AUTOIP                     CONFIG_IS_ENABLED(CMD_LINK_LOCAL)
 
 #define LWIP_SNMP                       0
 
diff --git a/test/dm/lwip.c b/test/dm/lwip.c
index f5932a0ef97..78c074a7723 100644
--- a/test/dm/lwip.c
+++ b/test/dm/lwip.c
@@ -15,6 +15,7 @@
 #include <dm/test.h>
 #include <linux/kconfig.h>
 #include <test/ut.h>
+#include "lwip_test.h"
 
 #if CONFIG_IS_ENABLED(PROT_DNS_LWIP)
 #include <lwip/dns.h>
@@ -42,6 +43,53 @@ struct lwip_test_recv_ctx {
 	int nested_poll_ret;
 };
 
+#if CONFIG_IS_ENABLED(CMD_LINK_LOCAL)
+static bool reject_lladdr;
+
+static int linklocal_tx(struct udevice *dev, void *packet, unsigned int len)
+{
+	if (reject_lladdr && !sandbox_eth_arp_req_to_reply(dev, packet, len))
+		reject_lladdr = false;
+
+	return 0;
+}
+
+static int linklocal_check(struct unit_test_state *uts)
+{
+	ut_assertok(env_set("ethact", "eth@10002000"));
+	ut_assertok(env_set("llipaddr", "169.254.7.8"));
+	ut_assertok(run_command("linklocal", 0));
+	ut_asserteq_str("169.254.7.8", env_get("ipaddr"));
+	ut_asserteq_str("255.255.0.0", env_get("netmask"));
+	ut_asserteq_str("0.0.0.0", env_get("gatewayip"));
+
+	reject_lladdr = true;
+	ut_assertok(run_command("linklocal", 0));
+	ut_assert(!reject_lladdr);
+	ut_assert(!strncmp(env_get("ipaddr"), "169.254.", 8));
+	ut_assert(strcmp(env_get("ipaddr"), "169.254.7.8"));
+	ut_asserteq_str(env_get("ipaddr"), env_get("llipaddr"));
+	return 0;
+}
+
+static int dm_test_lwip_linklocal(struct unit_test_state *uts)
+{
+	const char *const vars[] = { "ethact", "llipaddr", "ipaddr", "netmask",
+				     "gatewayip" };
+	struct in_addr old_ip = net_ip;
+	int ret;
+
+	sandbox_eth_set_tx_handler(0, linklocal_tx);
+	reject_lladdr = false;
+	ret = lwip_test_with_env(uts, vars, ARRAY_SIZE(vars), linklocal_check);
+	sandbox_eth_set_tx_handler(0, NULL);
+	net_ip = old_ip;
+	return ret;
+}
+
+DM_TEST(dm_test_lwip_linklocal, UTF_SCAN_FDT);
+#endif
+
 static int dm_test_lwip_decimal(struct unit_test_state *uts)
 {
 	static const char *const invalid[] = {
diff --git a/test/dm/lwip_test.h b/test/dm/lwip_test.h
new file mode 100644
index 00000000000..3f435b59421
--- /dev/null
+++ b/test/dm/lwip_test.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef __DM_LWIP_TEST_H
+#define __DM_LWIP_TEST_H
+
+#include <env.h>
+#include <malloc.h>
+
+#include <test/ut.h>
+
+/* Preserve the caller's network settings even when a test assertion fails. */
+static inline int lwip_test_with_env(struct unit_test_state *uts,
+				     const char *const *names, size_t count,
+				     int (*run)(struct unit_test_state *))
+{
+	char **saved;
+	size_t i;
+	int ret = -ENOMEM;
+
+	saved = calloc(count, sizeof(*saved));
+	ut_assertnonnull(saved);
+	for (i = 0; i < count; i++) {
+		const char *value = env_get(names[i]);
+
+		if (value) {
+			saved[i] = strdup(value);
+			if (!saved[i])
+				goto out;
+		}
+	}
+	ret = run(uts);
+	for (i = 0; i < count; i++)
+		if (env_set(names[i], saved[i]))
+			ret = -EINVAL;
+out:
+	while (i)
+		free(saved[--i]);
+	free(saved);
+	ut_assertok(ret);
+	return 0;
+}
+
+#endif

-- 
2.53.0

