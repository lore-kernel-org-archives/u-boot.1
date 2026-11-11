Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E23606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yJ1RkmrX;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GJViAysF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24A8B60E07;
	Wed, 11 Nov 2026 20:11:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pz1-kPtUn-gz; Wed, 11 Nov 2026 20:11:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BD4C060DDC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794427896;
	b=IO3oqz5ZTEmHCSUsqj3+hwreMONrt1cJlXcw9rULOxabzEL7yhf+ftSZXKOmNjHK21fo
	 e2icRVgDuDY6Mix6pG5m9JcV9Jwz6CMVzJoXIaJGYA/SUaTcSDAfzhDFlCOLfcZ8wofdI
	 7FkTfI3MRj8iZ1moTgmWe5PT35WUBMArV2A789xJWmxaqlWDqDNozyLJwUM3O2GgWXXXm
	 pujzmmFlKh1yy5MQZdF+M03Lk89mPf7G3WOKjG0ztOO8l0Lj1yTjeyoOfdKvNKAEh1EXD
	 8EPVmiYqy4HI/EXOETh0owUQfKHcADNTjo4mbpB7F4/FoCkHU7KaP+WqycBVplMDrdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794427896;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BjcgxP4iWcoIacvSSfA94+8ctzeQTJ6toHOjw2FyQXo=;
	b=VwI/ltsQBi9IxJt1VJoNh5NGjuz9ze62JwPuYtDS3AlmpigbUkIDqjR92COlCJh7i/+2
	 5W90thxoYY0BBXc8g8hVlVckHGQ1NNfyeOscTxATdisBB1zePF0ySr/mBPL3kLMJuMW7G
	 x7XGL/zhsrXPDEJvufQ/x2PxID1JN8z/o6nEU62WZAeBmZJ/I1K1/g3S6FFkYoO35GEmp
	 PRLCsr9EMq36CnSZui+RXmW03hqAi4OKxmNRmIZ8DWfMDOzNvY8WQWbatorDawxpgIcQf
	 IcRsnn69MNuBKtA9dZ6dMZAv5AX1OYtjUdh3l9q1asd/3GdzKZoDqcjBL7xdQ4Ojy1w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794427895;
	bh=BjcgxP4iWcoIacvSSfA94+8ctzeQTJ6toHOjw2FyQXo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yJ1RkmrXD34Jv9EdbwCFofS+GbqVkQ9pk25cuLhAjOsMIC6HZiWM0JQV95sMdJbIf
	 pDepFST5rgI2+tq/pebrttSRTfbJ7ZQtCJoI8LVG9rNFsFPklKiBQZEjMxrWGZo7IZ
	 ArBHHRfaozQ4xZ9anTHG7zlZukQvv+JAeaAQKBGJYI/34Wb/vICFkg250EreH63U7N
	 pgJzDqEx4W0qRJROWJh0Ses21SIfUJ5RRw3EMYiaK0q+cJZIYUbqC2l7lQzC7IEIrq
	 hwgiE/IG16rA8mXAJVmYv5ysp79DiNkr3kTXhzF6ifgDdY7PfyZWRv+npFEic9ttrN
	 rR7IauipCvPhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD4C060DDC;
	Wed, 11 Nov 2026 20:11:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 853BC2FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A9BD81E1E
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A9XQfKfy8_RN for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 20:11:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 79D6081EE8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=GJViAysF
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 79D6081EE8
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:27 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-84a248254f4so1939877a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794427886; x=1795032686;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BjcgxP4iWcoIacvSSfA94+8ctzeQTJ6toHOjw2FyQXo=;
 b=GJViAysFPlQlNcL635lOw9JQO0mxTml/Z+aMoKHkxSD4m+WMMgPotiuM2CJwNUVD7m
 TVRN+zQhRtR4sLFTLp2a85XF1Yw/rScF87uNUm6a7Ddq/vNGGZStb6DjR27XW4cbkVOC
 w80Us9Jffag8XiOMuR6VQMbtxD7ZBxy/7L22yV4x1lJhC8d+cCYH22qh2dAsq4SYYBSq
 UiohMXvp3nlE0JXw/AyMfmAQnjgG1yS5Qx4d0Tz1FP6ZPUwbznrs+ttEh7MOoIOzN3ff
 Qc5SWtaQNwTff6rSYFv2v4mgwfOeCX4TESn8j+G/5GrNgbPXuNPcRsFpM30vT7fH80KN
 i++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794427886; x=1795032686;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BjcgxP4iWcoIacvSSfA94+8ctzeQTJ6toHOjw2FyQXo=;
 b=oSNrxWvCXZcEtwimr61D+ifW8B7zgpV8fQ63ikZsSs7xoac88kkixwDD5VPPhkNnV1
 fhlLa+WiZXWyRRFklP2o+vpVauJuMbJx4SyYdaiILJmDPNJR/dmcaIG7VPwZd91Z9Tvn
 mvXIZsvXeOCMiK7KwNR/DKr79loXN4mhwysAKUldX+nYVysSoRd6uiU4SywkdYqVW+DB
 g1AO8T/H9q7Kbp/pGabtQkIKm4gupdlZVijnkE/ELsLV73Sk8Ld4HsxdFhq33xvnRbDV
 wiWyEl5jlZv7SpYlUXQAwIB3+svEXHl1kpvbFeEl9kU3sQGf4kShtkpH+SP1gFQbFtkF
 lQZw==
X-Forwarded-Encrypted: i=1;
 AL+hErHT6D+5o+gMw1lomqHgEt3aKsGhGfn9oEo9hDF19ftYaUhr3GrnEC6anwIoOdHVGdZURyGEqss=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z88xTLnrJ8Lug1bG0hnyNE4l0FEoETHgoOTAM8NdIc7roQPTjcy
 9QrUajfHAlIUIZv/S8EMQUS0/rshjtL7wAlNBZ7U4HLCVtJJhOYY+X5Z
X-Gm-Gg: AYBFou3F/SqqsV1gtrjCER1IrbkQla1mnw5eOlOsAzTwKVmIzh7c6eKbv63fNQ1q2Rr
 OGIelKAl/+mLKALNACD3ILhzM/p0YvDUCU20LHQwFB4hnOYyCz6zEIDeQxARIfvrBie+b7VdLtg
 IK8NP21IJtKiBpuAF1soNnBvPG0rj9qi4fZUaWtsuVHkD1+uavOK0lWf3sX1ax3nX2rMCz0o/DE
 /Ti1HXLZmHWBkwmMdSleyUqw0NlFRgI56FIkrGHnsl/3dYw6fOnWPAa/dNArH3VjYEBWHfKH/3j
 8kCTzpmBV1Nfwt53mbseEKxd5mv4xWqJq9ti/ec2VZa2jFpXcMMVTAH8AVc3KrpmWX3VLgWXZWQ
 /1n1eJ4QLUTu/gySlPi9hoMVUYQKpideJKfWm3jE5Huhesik9xa7+AhC8mZzbya+1wmspJ+OKzI
 8wBDM/Xl+JiDiIrT4qIMDqZe8561cOf55pDj49AVEtKEo2ew9fIHxvuf3IKmRVuAMcOVyZXg9Sq
 7Epk2RsK+YrSWBozRKbYZtRSlsg+yknPlHf+oYKVQH6IhuW+amqI9D/3JfIpu1bK2VUvR8DzBel
 LqD+wizmyYxaBFDRxHZA3WbbLTkIyB+LuP8K+RhfOJOrVsVmabmwf77qC04jrGrSLVHWF1+qe13
 pNxKAu8f3GT+Ux2BMPoZFjIeOhYNLKZfUoKBzroA9fa5FYpp8ZQ6hp8tb7L8OH1xzFN8iJIp3ar
 hyRKglgitfzyH5bQBh01l3ZgiPMiztMvIRyJRejfu8nSzlOkBfKKQ=
X-Received: by 2002:a05:6808:c12e:b0:4e8:2150:2a1 with SMTP id
 5614622812f47-56b97715413mr3111985b6e.68.1794427885932; 
 Wed, 11 Nov 2026 12:11:25 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905d3bab2sm5863446b6e.12.2026.11.11.12.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 12:11:25 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 13:11:14 -0700
Subject: [PATCH 07/19] net: lwip: add the ping6 command
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-submit-lwip-ipv6-v1-v1-7-eb0ee8f8da1a@gmail.com>
References: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
In-Reply-To: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Igor Velkov <iav@iav.lv>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Murtaza Munaim <murtaza@saramena.us>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Drew Kluemke <ankluemk@microsoft.com>
X-Mailer: b4 0.15.2
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

Share the raw-packet ping implementation between IPv4 and IPv6,
selecting the ICMP protocol and checksum for the destination address
family. Scope link-local destinations to the selected Ethernet interface
and finish IPv6 address preparation before sending echo requests.

Validate the echo reply type, code, identifier, sequence and checksum.
Raw receive callbacks run before ICMP validation, so matching only the
identifier and sequence can accept a corrupt or non-reply packet.

Keep command registration independent so ping6 can be built without the
IPv4 ping command.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/Kconfig       |   5 +-
 cmd/lwip/Makefile |   4 +-
 cmd/lwip/ping.c   | 133 ++++++++++++++++++++++++++++++++++++------------------
 3 files changed, 95 insertions(+), 47 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index b48c2bbdd02..31ddca5fec6 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2176,15 +2176,16 @@ config SYS_DISABLE_AUTOLOAD
 	  is complete.  Enable this option to disable this behavior and instead
 	  require files to be loaded over the network by subsequent commands.
 
-if NET_LEGACY
-
 config CMD_PING6
 	bool "ping6"
 	depends on IPV6
 	default y if (CMD_PING && IPV6)
+	select PROT_RAW_LWIP if NET_LWIP
 	help
 	  Send ICMPv6 ECHO_REQUEST to network host
 
+if NET_LEGACY
+
 config CMD_CDP
 	bool "cdp"
 	help
diff --git a/cmd/lwip/Makefile b/cmd/lwip/Makefile
index 1050ee4742b..606c3693d2b 100644
--- a/cmd/lwip/Makefile
+++ b/cmd/lwip/Makefile
@@ -2,7 +2,9 @@ obj-$(CONFIG_CMD_BOOTP) += bootp.o
 obj-$(CONFIG_CMD_DHCP) += dhcp.o
 obj-$(CONFIG_CMD_DNS) += dns.o
 obj-$(CONFIG_CMD_NFS) += nfs.o
-obj-$(CONFIG_CMD_PING) += ping.o
+ifneq ($(filter y,$(CONFIG_CMD_PING) $(CONFIG_CMD_PING6)),)
+obj-y += ping.o
+endif
 obj-$(CONFIG_CMD_SNTP) += sntp.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
 obj-$(CONFIG_CMD_TFTPPUT) += tftpput.o
diff --git a/cmd/lwip/ping.c b/cmd/lwip/ping.c
index 1498a86a15a..aaa2204688b 100644
--- a/cmd/lwip/ping.c
+++ b/cmd/lwip/ping.c
@@ -8,14 +8,13 @@
 #include <linux/errno.h>
 #include <lwip/icmp.h>
 #include <lwip/inet_chksum.h>
+#include <lwip/prot/icmp6.h>
+#include <lwip/prot/ip6.h>
 #include <lwip/raw.h>
 #include <lwip/timeouts.h>
 #include <net.h>
 #include <time.h>
 
-U_BOOT_CMD(ping, 2, 1, do_ping, "send ICMP ECHO_REQUEST to network host",
-	   "pingAddressOrHostName");
-
 #define PING_DELAY_MS 1000
 #define PING_COUNT 5
 /* Ping identifier - must fit on a u16_t */
@@ -24,7 +23,6 @@ U_BOOT_CMD(ping, 2, 1, do_ping, "send ICMP ECHO_REQUEST to network host",
 struct ping_ctx {
 	ip_addr_t target;
 	struct raw_pcb *pcb;
-	struct icmp_echo_hdr *iecho;
 	uint16_t seq_num;
 	bool alive;
 };
@@ -33,37 +31,51 @@ static u8_t ping_recv(void *arg, struct raw_pcb *pcb, struct pbuf *p,
 		      const ip_addr_t *addr)
 {
 	struct ping_ctx *ctx = arg;
-	struct icmp_echo_hdr *iecho = ctx->iecho;
+	struct icmp_echo_hdr iecho;
+	u16 hlen = ip_current_header_tot_len();
+	u16 checksum;
+	u8 type = IP_IS_V6(addr) ? ICMP6_TYPE_EREP : ICMP_ER;
 
 	if (!ip_addr_eq(addr, &ctx->target))
 		return 0;
 
-	if ((p->tot_len >= (IP_HLEN + sizeof(struct icmp_echo_hdr))) &&
-	    pbuf_remove_header(p, IP_HLEN) == 0) {
-		iecho = (struct icmp_echo_hdr *)p->payload;
+	if (pbuf_copy_partial(p, &iecho, sizeof(iecho), hlen) != sizeof(iecho) ||
+	    iecho.type != type || iecho.code || iecho.id != PING_ID ||
+	    iecho.seqno != lwip_htons(ctx->seq_num) || pbuf_remove_header(p, hlen))
+		return 0;
 
-		if (iecho->id == PING_ID &&
-		    iecho->seqno == lwip_htons(ctx->seq_num)) {
-			ctx->alive = true;
-			printf("host %s is alive\n", ipaddr_ntoa(addr));
-			pbuf_free(p);
-			return 1; /* eat the packet */
-		}
-		/* not eaten, restore original packet */
-		pbuf_add_header(p, IP_HLEN);
+	/* Raw callbacks run before the stack's ICMP checksum validation. */
+	if (IP_IS_V6(addr))
+		checksum = ip_chksum_pseudo(p, IP6_NEXTH_ICMP6, p->tot_len,
+					    ip_current_src_addr(), ip_current_dest_addr());
+	else
+		checksum = inet_chksum_pbuf(p);
+	if (checksum) {
+		pbuf_add_header(p, hlen);
+		return 0;
 	}
 
-	return 0; /* don't eat the packet */
+	ctx->alive = true;
+	printf("host %s is alive\n", ipaddr_ntoa(addr));
+	pbuf_free(p);
+	return 1;
 }
 
-static int ping_raw_init(struct ping_ctx *ctx)
+static int ping_raw_init(struct ping_ctx *ctx, struct netif *netif)
 {
-	ctx->pcb = raw_new(IP_PROTO_ICMP);
+	ctx->pcb = raw_new_ip_type(IP_GET_TYPE(&ctx->target),
+				   IP_IS_V6(&ctx->target) ? IP6_NEXTH_ICMP6 : IP_PROTO_ICMP);
 	if (!ctx->pcb)
 		return -ENOMEM;
 
 	raw_recv(ctx->pcb, ping_recv, ctx);
-	raw_bind(ctx->pcb, IP_ADDR_ANY);
+	raw_bind_netif(ctx->pcb, netif);
+#if CONFIG_IS_ENABLED(IPV6)
+	if (IP_IS_V6(&ctx->target)) {
+		ctx->pcb->chksum_reqd = 1;
+		ctx->pcb->chksum_offset = offsetof(struct icmp_echo_hdr, chksum);
+	}
+#endif
 
 	return 0;
 }
@@ -74,17 +86,16 @@ static void ping_raw_stop(struct ping_ctx *ctx)
 		raw_remove(ctx->pcb);
 }
 
-static void ping_prepare_echo(struct ping_ctx *ctx)
+static void ping_prepare_echo(struct ping_ctx *ctx, struct icmp_echo_hdr *iecho)
 {
-	struct icmp_echo_hdr *iecho = ctx->iecho;
-
-	ICMPH_TYPE_SET(iecho, ICMP_ECHO);
+	ICMPH_TYPE_SET(iecho, IP_IS_V6(&ctx->target) ? ICMP6_TYPE_EREQ : ICMP_ECHO);
 	ICMPH_CODE_SET(iecho, 0);
 	iecho->chksum = 0;
 	iecho->id = PING_ID;
 	iecho->seqno = lwip_htons(ctx->seq_num);
 
-	iecho->chksum = inet_chksum(iecho, sizeof(*iecho));
+	if (!IP_IS_V6(&ctx->target))
+		iecho->chksum = inet_chksum(iecho, sizeof(*iecho));
 }
 
 static void ping_send_icmp(struct ping_ctx *ctx)
@@ -97,8 +108,7 @@ static void ping_send_icmp(struct ping_ctx *ctx)
 		return;
 
 	if (p->len == p->tot_len && !p->next) {
-		ctx->iecho = (struct icmp_echo_hdr *)p->payload;
-		ping_prepare_echo(ctx);
+		ping_prepare_echo(ctx, p->payload);
 		raw_sendto(ctx->pcb, p, &ctx->target);
 	}
 
@@ -123,20 +133,29 @@ static int ping_loop(struct net_lwip_ctx *net, const ip_addr_t *addr)
 
 	printf("Using %s device\n", net->dev->name);
 
-	ret = ping_raw_init(&ctx);
+	ctx.target = *addr;
+#if CONFIG_IS_ENABLED(IPV6)
+	if (IP_IS_V6(&ctx.target)) {
+		ret = net_lwip_ip6_prepare(net, &ctx.target);
+		if (ret)
+			return ret;
+	}
+#endif
+	ret = ping_raw_init(&ctx, net->netif);
 	if (ret < 0)
 		return ret;
 
-	ctx.target = *addr;
-
 	ping_send(&ctx);
 
 	do {
-		net_lwip_poll();
+		ret = net_lwip_poll();
+		if (ret < 0)
+			break;
 		if (ctx.alive)
 			break;
 		if (ctrlc()) {
 			printf("\nAbort\n");
+			ret = -EINTR;
 			break;
 		}
 	} while (ctx.seq_num <= PING_COUNT);
@@ -148,25 +167,19 @@ static int ping_loop(struct net_lwip_ctx *net, const ip_addr_t *addr)
 		return 0;
 
 	printf("ping failed; host %s is not alive\n", ipaddr_ntoa(addr));
-	return -1;
+	return ret < 0 ? ret : -ETIMEDOUT;
 }
 
-int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+static int ping_execute(const ip_addr_t *addr)
 {
 	struct net_lwip_ctx net = {};
-	ip_addr_t addr;
 	int ret;
 
-	if (argc < 2)
-		return CMD_RET_USAGE;
-
-	if (net_lwip_dns_resolve(argv[1], &addr))
-		return CMD_RET_USAGE;
-
 	net_try_count = 1;
 
 	do {
-		ret = net_lwip_start(&net, NET_LWIP_ADDR_ENV_STRICT);
+		ret = net_lwip_start(&net, IP_IS_V6(addr) ? NET_LWIP_ADDR_ENV_FLEXIBLE :
+				    NET_LWIP_ADDR_ENV_STRICT);
 		if (!ret)
 			break;
 	} while (!net_start_again());
@@ -174,8 +187,9 @@ int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return CMD_RET_FAILURE;
 
 	do {
-		ret = ping_loop(&net, &addr);
-		if (!ret)
+		ret = ping_loop(&net, addr);
+		if (!ret || ret == -EINTR || ret == -EINVAL || ret == -EADDRINUSE ||
+		    ret == -EBUSY)
 			break;
 	} while (!net_lwip_restart(&net));
 
@@ -185,3 +199,34 @@ int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	return CMD_RET_FAILURE;
 }
+
+#if CONFIG_IS_ENABLED(CMD_PING)
+int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	ip_addr_t addr;
+
+	if (argc != 2 || net_lwip_dns_resolve(argv[1], &addr) || !IP_IS_V4(&addr))
+		return CMD_RET_USAGE;
+
+	return ping_execute(&addr);
+}
+
+U_BOOT_CMD(ping, 2, 1, do_ping, "send ICMP ECHO_REQUEST to network host",
+	   "pingAddressOrHostName");
+#endif
+
+#if CONFIG_IS_ENABLED(CMD_PING6)
+static int do_ping6(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	ip_addr_t addr;
+
+	if (argc != 2 || net_lwip_ip6_aton(argv[1], ip_2_ip6(&addr)))
+		return CMD_RET_USAGE;
+	IP_SET_TYPE_VAL(addr, IPADDR_TYPE_V6);
+
+	return ping_execute(&addr);
+}
+
+U_BOOT_CMD(ping6, 2, 1, do_ping6, "send ICMPv6 ECHO_REQUEST to network host",
+	   "IPv6address");
+#endif

-- 
2.53.0

