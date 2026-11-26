Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AD3606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SzdEtszT;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CcU/0Cl9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6BF28117C;
	Thu, 26 Nov 2026 13:33:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z_nEhuLbeeOj; Thu, 26 Nov 2026 13:33:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E77328117D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700008;
	b=cqO+75hET7j7erh1lgQ5PPmJsrsZEd4+LfoiXaZ7XnFwzzcJK8OFrJXMYRhBcWzZOH1T
	 a3FUU8+M4LIMvVAPRQqqyDmyTxgGbn05rJ+tv2+InE/OCeUbsCDQwPVpAmd2gol9ETRMb
	 Nh8p+fFGJext446Y8oBdZO4bTzHaRTXDAAOJc5U7xVsKGUZLfjny1iVtFkvHpIdS7ROFW
	 AQG76xg8920BfZn4WrMn1Yek8kNH1wbMN/Bv6r8SWO23BuqOIFCbB96bmvE3w11wv6NvZ
	 PDBdm0ZHwT0K9YgNyUuSKLybE0OoU7xVs3wQBxoMrjTLN2UQsZn0TNixdEUhTPP1KcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700008;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2S4gqg374e4mUvlXFuC26dn7I+k9Sz1nAzwvdkSJsjg=;
	b=MKI9e5Eu8nQe2Nue3fuvh14wk1iHvTwW0i+xCULzdpMt4IH2rdsRbntBdeDTGPXTJqFu
	 89O87RybLyI6E4h/wbYt7KDjoCZFSqwguE0UmprmHhr8iPGpeTtH1hOIy2um4jlbc6P5w
	 G8eJXltcgZfCcTf09ME/gu9zX0n1OdQHvPnQN4zhDJKnnjQjdu+qSwcjM3qejtGaPOWMp
	 CBCgOUV1cptL13bobYqaJWhhYU84TH2tjqmYdP5IqMOi20SpjxYbZ1+FYx0Ilrk5oTOiW
	 kLsZ2uO1w39332hg7JwBwMka5QTbwdow0+JvPm/HO9KbjmEhe3rkHQglcmzbvtr3Gvg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700008;
	bh=2S4gqg374e4mUvlXFuC26dn7I+k9Sz1nAzwvdkSJsjg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SzdEtszTbqf7qh582dFmTKNT7geeMSugemuUdEvt6Y2t4x/8+YI7F73UjCIkMczeT
	 EiAHPyo1e1D4U64gfbKO0QwfbM5KbGYd9dKrdRpYkFzSkbG03MsPS2ZbbWdmlz2y8b
	 dMo0Q2GeqQSgwRf5n3n9NBUk9956o5SkPPKhAJZkvL/fMX0J4gzV1Om103IXYHIi0o
	 L/+zVFicsenPTz8ra9B8s8Rv1/R5bpTEwlZzaVpUUZImvtQhDRGa+IdL8Kivz5XrGZ
	 1j2MeLbm4sEsIVw04sHU3FsOzMPvePig6X0nQqY4wAXGdxQD67V2FJhAPbacCJbOFq
	 1SLWY8IlaCAtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E77328117D;
	Thu, 26 Nov 2026 13:33:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C87F371
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E6D8440492
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rStWjsBsV2ch for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 06:53:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E711C40490
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=CcU/0Cl9
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E711C40490
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:16 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-8253bc5a613so4207059a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795675995; x=1796280795;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2S4gqg374e4mUvlXFuC26dn7I+k9Sz1nAzwvdkSJsjg=;
 b=CcU/0Cl9PMdHlcjHnyBNKRJoY9/M71ZI9ppefvUyLJV01czvQW1+B6Paq0ypFSJRMu
 K6HZuUia5EZw7maNYygvoP1KuUg9sJZ4VWxx0pTYqSi783sqNI0Y0Jklme0dkDTHmGE/
 ZZffRXLjN5x5h9RUpL133WwE/n2CdWmUu8wom6h5ifszwyMFBHCTy1E0kufmLMjIPEFq
 4iQEeUJGmQSsVIUVUWB10H+hG9q7mEoInQczthKhKeYA5zzf5/tJLHwNSsm1ALCIA1lE
 Nz8tedQ+a1KKMf595XJwCxibXpIV7N4qiYgmR0QoOyldbB7O0V0hIFzyU3hdtdk5zCie
 NYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795675995; x=1796280795;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2S4gqg374e4mUvlXFuC26dn7I+k9Sz1nAzwvdkSJsjg=;
 b=PhkszGlEE7BtFWQ/oRxbZcA1H4Vlb61xTnOoIUCVBTZjPr0/eemsLn5rmNqdaBzt27
 qxVNbtjAQYyxn1Igj1EsEiapU7EC32Cg8I8CrlIB2DstmhzxCiFqomH6vTWbK5Oc5Fsi
 eddFfmoCzUwRuttm1Xv3KOt3o+D/NW4/HnK7bsB0on4hFHhEc5GE4sDoP3BDXtBzbWnG
 ZWvg8P3klYSp2VOYnsG7njRshOrEANHuMM8ZdVHg8EWQn4xYdfaLCr3tp4zN9lAlRV1K
 egLOFf+3685Th1C44JgY+EPZU1sHyoIOofXm8OQoAKp96Y4d/d9P4CN5wUlfYbO0gRPV
 InyA==
X-Gm-Message-State: APuU4Z/JqX+PK5EOgEujbbvl3f+M7A3vmAzkrK9tYgWfjo6MnGI/O3gy
 CRsTjrij5dWPtRK46pq6KCiZreKyuzohiND9dVnftUUgCNo5XmN8G052
X-Gm-Gg: AZFdTZcySd/oUNZnRMxRBV4F47naXHb76Zs8QBA/OVaak24zLBrbBZi31Vcmg2eJ1at
 yrcLU15HrCYMno5VbO/FoTyLTHxA9NuaDGTF/Aoba/lx3Gb2eP4jg2ncHhB4KpcSrI/t4IDOYYY
 ptrEqajAT64AFZKgGjzSHfjomLsCv8M8nOULnA4mTeOA+fQ4DVmVSXGiJTt4pZ74gqAvBtEoxJI
 WljPX7Eas0LipmE1gpfekRIlpto/476C/tzrAOpZ7T3OmDaHSkd9Qr7Nw2O0cCs1jRCK4peH+7n
 vw6zxyM+CjrFJqLrS4IjF77m9rlAKTpMk/dFmXmUpkZrkLWFnpRe2uMooWVQuKZ8KmKVJDQBhQ5
 cVSkx3rJ8YK6QNijTrHvVaDq5NSjt05W8OCbCS2IUJfpSwpMK9uQGgu/ow/KMgp/k6sAROkq8Ha
 Fl4OO1roI9ht174hBtu9X+o6UT1Qv9c2I6VkYJJ6J7sa9aAmlRvyNNV7WCVVe4IQaXUOLYhCg4G
 yjfQ2W7Jj3I3orFxc+8DyyRVZxiby270uiWge24oYBF2NDtEqXDQBGli9oHHxmtc5CqGpWmOFQi
 GZyFGUnwCz/EVlRoPfV5T+m5ia7axFGaJIg5+gUclTl32eaYQEJAADihGCiCGByAZhMZe/DKgeI
 C5t4gKW4Dm9luKyXiN0Tkj4PC9kt1mgpxqtFJFcGbM0I1gRGTQDXe36C/MmPQuaZybemryWBXNU
 QXi94Pd0qaNEKmmr+TjuhNkR17zv5tV8MQ5m94kXbf3oJvYjIdJJ4=
X-Received: by 2002:a05:6830:44a2:b0:862:bda5:b88b with SMTP id
 46e09a7af769-86315a0c16cmr22321211a34.21.1795675995515; 
 Wed, 25 Nov 2026 22:53:15 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86385358ca2sm31041a34.21.2026.11.25.22.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:53:15 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 25 Nov 2026 23:52:53 -0700
Subject: [PATCH 04/19] net: lwip: export the Ethernet address used to reach
 serverip
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-submit-lwip-network-boot-v1-v1-4-63df291d9392@gmail.com>
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

Network boot scripts can pass serveraddr to Linux, for instance
when configuring netconsole. Populate it from the first successful
unicast IPv4 transmission to the configured server. This records
the next-hop MAC that lwIP actually resolved and avoids recording
unrelated ARP replies on a busy network.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 net/Kconfig         |  8 +++-----
 net/lwip/net-lwip.c | 40 ++++++++++++++++++++++++++++++++++++++++
 test/dm/lwip.c      | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/net/Kconfig b/net/Kconfig
index 6d6672b9662..9b191118060 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -138,16 +138,14 @@ config SERVERIP_FROM_PROXYDHCP_DELAY_MS
 	  does not fail an otherwise successful lease.
 	  The legacy client waits after receiving the DHCP offer.
 
-if NET_LEGACY
-
 config KEEP_SERVERADDR
 	bool "Write the server's MAC address to 'serveraddr'"
 	default y if SANDBOX
 	help
 	  Keeps the server's MAC address, in the env 'serveraddr'
-	  for passing to bootargs (like Linux's netconsole option). If this is
-	  enabled, when an ARP reply is received, the server's IP address is
-	  written there.
+	  for passing to bootargs (like Linux's netconsole option).
+
+if NET_LEGACY
 
 config UDP_CHECKSUM
 	bool "Check the UDP checksum"
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index d7a38b9f72f..8b55c9646ef 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -36,6 +36,44 @@
 /* xx:xx:xx:xx:xx:xx\0 */
 #define MAC_ADDR_STRLEN 18
 
+static void net_lwip_keep_serveraddr(const u8 *frame, unsigned int len)
+{
+	static u8 saved[ETH_ALEN];
+	static struct in_addr server;
+	static int last_id = -1;
+	unsigned int hlen = ETHER_HDR_SIZE;
+	char addr[MAC_ADDR_STRLEN];
+	u16 type;
+	int id = env_get_id();
+
+	if (len < hlen || !is_valid_ethaddr(frame))
+		return;
+	if (last_id != id) {
+		server = string_to_ip(env_get("serverip"));
+		eth_env_get_enetaddr("serveraddr", saved);
+		last_id = id;
+	}
+	if (!server.s_addr || !memcmp(frame, saved, ETH_ALEN))
+		return;
+
+	type = get_unaligned_be16(frame + hlen - 2);
+	if (type == PROT_VLAN) {
+		hlen += VLAN_HLEN;
+		if (len < hlen)
+			return;
+		type = get_unaligned_be16(frame + hlen - 2);
+	}
+	if (type != PROT_IP || len < hlen + IP_HLEN ||
+	    memcmp(frame + hlen + offsetof(struct ip_hdr, dest),
+		   &server.s_addr, sizeof(server.s_addr)))
+		return;
+
+	/* This is the link address selected by ARP, including via a gateway. */
+	sprintf(addr, "%pM", frame);
+	if (!env_set("serveraddr", addr))
+		memcpy(saved, frame, sizeof(saved));
+}
+
 #if defined(CONFIG_API) || defined(CONFIG_EFI_LOADER)
 void (*push_packet)(void *, int len) = 0;
 #endif
@@ -150,6 +188,8 @@ static err_t net_lwip_tx(struct netif *netif, struct pbuf *p)
 	}
 
 	err = eth_get_ops(udev)->send(udev, pp, plen);
+	if (err >= 0 && CONFIG_IS_ENABLED(KEEP_SERVERADDR))
+		net_lwip_keep_serveraddr(pp, plen);
 	if (err >= 0 && CONFIG_IS_ENABLED(CMD_PCAP))
 		pcap_post(pp, plen, true);
 
diff --git a/test/dm/lwip.c b/test/dm/lwip.c
index ba5e6ff1b96..a350e80ab67 100644
--- a/test/dm/lwip.c
+++ b/test/dm/lwip.c
@@ -118,6 +118,39 @@ static int dm_test_lwip_decimal(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_lwip_decimal, 0);
 
+#if CONFIG_IS_ENABLED(KEEP_SERVERADDR) && CONFIG_IS_ENABLED(CMD_PING)
+static int lwip_serveraddr_check(struct unit_test_state *uts)
+{
+	struct eth_sandbox_priv *priv;
+	struct udevice *dev;
+	u8 mac[ETH_ALEN];
+
+	ut_assertok(env_set("ethact", "eth@10002000"));
+	ut_assertok(env_set("ipaddr", "1.1.2.1"));
+	ut_assertok(env_set("netmask", "255.255.255.0"));
+	ut_assertok(env_set("serverip", "1.1.2.2"));
+	ut_assertok(env_set("serveraddr", "02:00:00:00:00:33"));
+	ut_assertok(run_command("ping 1.1.2.7", 0));
+	ut_asserteq_str("02:00:00:00:00:33", env_get("serveraddr"));
+	ut_assertok(run_command("ping 1.1.2.2", 0));
+	ut_assertok(uclass_get_device_by_seq(UCLASS_ETH, 0, &dev));
+	priv = dev_get_priv(dev);
+	ut_assert(eth_env_get_enetaddr("serveraddr", mac));
+	ut_asserteq_mem(priv->fake_host_hwaddr, mac, ETH_ALEN);
+	return 0;
+}
+
+static int dm_test_lwip_serveraddr(struct unit_test_state *uts)
+{
+	const char *const vars[] = { "ethact", "ipaddr", "netmask", "serverip",
+				     "serveraddr" };
+
+	return lwip_test_with_env(uts, vars, ARRAY_SIZE(vars), lwip_serveraddr_check);
+}
+
+DM_TEST(dm_test_lwip_serveraddr, UTF_SCAN_FDT);
+#endif
+
 #if CONFIG_IS_ENABLED(PROT_DNS_LWIP)
 struct lwip_test_dns_ctx {
 	unsigned int callbacks;

-- 
2.53.0

