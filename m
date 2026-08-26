Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9C8C61DC2
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 05:30:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB98280C4E;
	Wed, 26 Aug 2026 05:30:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XvpgHPit3nZq; Wed, 26 Aug 2026 05:30:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787722248;
	bh=cpMG8M5uoTx++nkuSC4drGlS1eOEyVJcM8PJEpY4tJw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ErDB4lc+T53hlyrtzlUa5do/6B556u9dzMBWN6XR9eBSb+XIq4A+CnJjLc8uaaho1
	 +0N2Tw0BYXWVaqKaj9sbDDqDXdyqoFcBNGoej42pUzZoT5k62sMJ2vLNiy1KjqOQB6
	 1TuyvC6HRJN/2JYuCsCM9nwD5JmFCRhC/ZtLA3dI24tp1P6ipTi/IvmLcL7LOM2AQ9
	 cRJDT+BYQsniwi2T057k6BKf5qxLMkzQmIP/SS5KHbuI2Vk65TGOOGat4XezH85J7A
	 8jS3jkhg2s8TigcI9Zc1P2PL9XNIKfVtZxRj3naoAW07dg42VvuUM1Dpe0Ogdc7he8
	 00igkyfhCwEgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF02E80BE9;
	Wed, 26 Aug 2026 05:30:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D7AE2396
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C54C980BB8
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id inpkFNeI_8Fb for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 05:30:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::32; helo=mail-oa1-x32.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=IaG5r6GT
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4800380BC4
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:32 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-45e2fd33133so552542fac.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787722232; x=1788327032;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cpMG8M5uoTx++nkuSC4drGlS1eOEyVJcM8PJEpY4tJw=;
 b=IaG5r6GTG7nJnX1/BNimnOkWspF06y9wx01AJswX1s6uAFtGzTRwoDPJQm1zlYX8td
 cLy63EDCOK2fb3iPXXsmuhNBXszJqkU9dr1fkWcVfPSN0uDpPbWc7cviCNUaRGaAUGuX
 G/6CTNDiy+EN0LzrzKZBLmir+hWUP4lFo6j8+T/VNrnRcYQeYKqEBeEwBX5gqkeqwT00
 iBU7z9p4CBaZUXPLW3zy86Ir51bsp+pCrwE/CQ+ynBI1UDe99QLgD7Tz5+N6mpvS23WC
 QyrBDJqtTE0FaQ5c2QDEyv6/itTG+3B6BW6IVzjg92gV5ND1tPTsCkEGmAsR+4oHl/mX
 m3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787722232; x=1788327032;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cpMG8M5uoTx++nkuSC4drGlS1eOEyVJcM8PJEpY4tJw=;
 b=RlXYasOR7cXUFYidbOHuA8ylkj0h3OM2I3aiVcYZMH1jtWkp59+XP52zYw+dmCiLoq
 wEEe2F5BqnvyZxQfmxbs8ej69MPpxYgSxVsHE0J3VjuLTCJY8/46KyYs8xHGqVDJRNxo
 WxKH5UlQ23VJc/kuGuppm4IpBHKqU8to78cPUD0N6iTrRYW5D0wII1d8++jy/5G93Q4V
 rJEkAY3T84yEaXZkDIeBNpdVfwA084cyzXyOso5fI/7F9aVS6gp9tRa0pUEGN7Icn1Ry
 AiL08jdk/iWYmhFQJpSTeWYw9Qofe74SV6VMl3Kw3sE3bJV9RZnsEPqzW6lCErxJiTna
 voJA==
X-Gm-Message-State: AFuF++m7ieb3c8vQ8Q5V86ttGPi8jsxzvHarjeiGAohDOF4vg67dq9tr
 eBPNBy0S3GphwFVdfjRIAx+raIQ7x1xZs5qwszxKJDrqTZ085x2e2h9ELYAHuvUL
X-Gm-Gg: AR+sD11H9GNncm5oKMTLYaYHTXMelgZr4KxnH3oIOJ8nP8PAxTQ1mGvgSw18sqCr+IP
 GUE/OJ1LtlNZZpBbLbIAZ+yN2xzZy832UD2OBwComw9z6ZbFcsZGHT+5UgxDh8zxR5/8wEkkb0g
 Iq1/2vODc90y7HQqM0BMjxWarcMHmV60N6XI/BFuJeyp8pzF0ZntwfAKx1HJfyberfAVYfde1bw
 vVfeka1NMbQ0JkaiUrLiInL8S9qlWcqJSia1iqB+vKDbTZQbmvfzO0AClTse69PI4cXrG5dLJMc
 dgPhcZtZR4VSDNsQR2OJUWNPJURte5ECgOQCmtnhN0x/nwmWEf/BDLM5FdwwHPW4xyQyXGgTSjI
 uDLP9u9ldq0tl3UWAQTbgFfdhXYQCtBa4j+8MjGVHtoAGYnt802eHGxO3Ey/dWlV3EzrqtqoLGA
 L8s3cOKz0mnQ8fRlj1Hwh9Rg54HzGPvEkgG45m7L69zUz/7u3NSN79htKtG5l0hcStafzpnfx4h
 xN1WM1AnCf9CWIhtlC0XVNoz9NNepl3b72DueNcfuXkghwn7YfuVXi42q26eF3LwFFrqUj93uOK
 40IdSULhZjvm+8mOQSpVE8ZK83Gk2vCDXlQ/C4WsndSpGTIERcT3gyiMWJGM/5VcDPn8FhrhZfP
 eJ/Xc+rdzLJTmuA==
X-Received: by 2002:a05:6870:c6a4:b0:45e:e061:1669 with SMTP id
 586e51a60fabf-46599a0d707mr5034200fac.13.1787722231592; 
 Tue, 25 Aug 2026 22:30:31 -0700 (PDT)
Received: from [127.0.1.1] (71-218-10-81.hlrn.qwest.net. [71.218.10.81])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-465b0243574sm1346401fac.15.2026.08.25.22.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 22:30:30 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 25 Aug 2026 23:29:48 -0600
Subject: [PATCH 09/10] test: dm: cover the shared lwIP runtime
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-submit-lwip-runtime-netconsole-v1-v1-9-0892966aa758@gmail.com>
References: <20260825-submit-lwip-runtime-netconsole-v1-v1-0-0892966aa758@gmail.com>
In-Reply-To: <20260825-submit-lwip-runtime-netconsole-v1-v1-0-0892966aa758@gmail.com>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 Luca Jones <ljones@t0.technology>, Weijie Gao <weijie.gao@mediatek.com>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>, Simon Glass <sjg@chromium.org>, 
 Vincent Jardin <vjardin@free.fr>, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>
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

Exercise two clients and UDP PCBs on one netif, address ownership and
refresh, reentrant polling, per-client detach and final Ethernet
shutdown. Also cover DHCP shutdown, DNS callback cancellation and
immediate abort of an established HTTP connection when the corresponding
protocols are enabled.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 test/dm/Makefile |   3 +
 test/dm/lwip.c   | 353 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 356 insertions(+)

diff --git a/test/dm/Makefile b/test/dm/Makefile
index fb3e6a7008f..a3e8bb4bc7e 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -49,6 +49,9 @@ obj-$(CONFIG_ECDSA_VERIFY) += ecdsa.o
 obj-$(CONFIG_DM_HASH) += hash.o
 obj-$(CONFIG_EFI_MEDIA_SANDBOX) += efi_media.o
 obj-$(CONFIG_DM_ETH) += eth.o
+ifeq ($(CONFIG_NET_LWIP)$(CONFIG_PROT_UDP_LWIP),yy)
+obj-y += lwip.o
+endif
 obj-$(CONFIG_EXTCON) += extcon.o
 ifneq ($(CONFIG_EFI_PARTITION),)
 obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fastboot.o
diff --git a/test/dm/lwip.c b/test/dm/lwip.c
new file mode 100644
index 00000000000..0d7ff22e644
--- /dev/null
+++ b/test/dm/lwip.c
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright 2026 James Hilliard <james.hilliard1@gmail.com> */
+
+#include <dm.h>
+#include <env.h>
+#include <lwip/pbuf.h>
+#include <lwip/udp.h>
+#include <net.h>
+#include <asm/eth.h>
+#include <dm/test.h>
+#include <linux/kconfig.h>
+#include <test/ut.h>
+
+#if CONFIG_IS_ENABLED(PROT_DNS_LWIP)
+#include <lwip/dns.h>
+#endif
+#if CONFIG_IS_ENABLED(PROT_DHCP_LWIP)
+#include <lwip/dhcp.h>
+#include <lwip/prot/dhcp.h>
+#endif
+#if CONFIG_IS_ENABLED(WGET)
+#include <lwip/apps/http_client.h>
+#include <lwip/priv/tcp_priv.h>
+#endif
+
+struct lwip_test_eth_hdr {
+	u8 dst[ARP_HLEN];
+	u8 src[ARP_HLEN];
+	__be16 type;
+} __packed;
+
+struct lwip_test_recv_ctx {
+	unsigned int packets;
+	int nested_poll_ret;
+};
+
+#if CONFIG_IS_ENABLED(PROT_DNS_LWIP)
+struct lwip_test_dns_ctx {
+	unsigned int callbacks;
+	bool address_missing;
+};
+
+static void lwip_test_dns_found(const char *name, const ip_addr_t *ipaddr,
+				void *arg)
+{
+	struct lwip_test_dns_ctx *ctx = arg;
+
+	ctx->callbacks++;
+	ctx->address_missing = !ipaddr;
+}
+#endif
+
+#if CONFIG_IS_ENABLED(WGET)
+struct lwip_test_http_ctx {
+	unsigned int callbacks;
+	httpc_result_t result;
+};
+
+static void lwip_test_http_result(void *arg, httpc_result_t result,
+				  u32_t rx_content_len, u32_t server_response,
+				  err_t err)
+{
+	struct lwip_test_http_ctx *ctx = arg;
+
+	ctx->callbacks++;
+	ctx->result = result;
+}
+
+static err_t lwip_test_http_recv(void *arg, struct altcp_pcb *conn,
+				 struct pbuf *p, err_t err)
+{
+	if (p)
+		pbuf_free(p);
+
+	return ERR_OK;
+}
+#endif
+
+static void lwip_test_udp_recv(void *arg, struct udp_pcb *pcb,
+			       struct pbuf *p, const ip_addr_t *addr,
+			       u16_t port)
+{
+	struct lwip_test_recv_ctx *recv_ctx = arg;
+
+	recv_ctx->packets++;
+	recv_ctx->nested_poll_ret = net_lwip_poll();
+	pbuf_free(p);
+}
+
+#if CONFIG_IS_ENABLED(PROT_DHCP_LWIP)
+static int lwip_test_dhcp_stop(struct unit_test_state *uts,
+			       struct netif *netif)
+{
+	struct dhcp *dhcp;
+	ip4_addr_t address;
+	int i;
+
+	ip4addr_aton("1.1.2.5", &address);
+	for (i = 0; i < 2; i++) {
+		ut_asserteq(ERR_OK, dhcp_start(netif));
+		dhcp = netif_dhcp_data(netif);
+		ut_assertnonnull(dhcp);
+		dhcp->state = DHCP_STATE_BOUND;
+		netif_set_ipaddr(netif, &address);
+		ut_assert(dhcp_supplied_address(netif));
+		dhcp_stop_without_release(netif);
+		ut_assert(ip4_addr_cmp(netif_ip4_addr(netif), &address));
+		ut_asserteq(0, dhcp->pcb_allocated);
+		dhcp_cleanup(netif);
+		ut_assertnull(netif_dhcp_data(netif));
+		ut_assertok(net_lwip_poll());
+	}
+
+	return 0;
+}
+#endif
+
+static int lwip_test_inject_udp(struct udevice *dev, const char *payload,
+				struct in_addr src_ip, u16 src_port,
+				u16 dest_port)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct lwip_test_eth_hdr *eth;
+	unsigned int payload_len = strlen(payload);
+	unsigned int packet_len;
+	struct ip_udp_hdr *ip;
+
+	packet_len = sizeof(*eth) + IP_UDP_HDR_SIZE + payload_len;
+	if (priv->recv_packets >= PKTBUFSRX || packet_len > PKTSIZE_ALIGN)
+		return -ENOSPC;
+
+	eth = (void *)priv->recv_packet_buffer[priv->recv_packets];
+	memcpy(eth->dst, pdata->enetaddr, ARP_HLEN);
+	memcpy(eth->src, priv->fake_host_hwaddr, ARP_HLEN);
+	eth->type = htons(PROT_IP);
+
+	ip = (void *)(eth + 1);
+	memset(ip, 0, IP_UDP_HDR_SIZE);
+	ip->ip_hl_v = 0x45;
+	ip->ip_len = htons(IP_UDP_HDR_SIZE + payload_len);
+	ip->ip_off = htons(IP_FLAGS_DFRAG);
+	ip->ip_ttl = 64;
+	ip->ip_p = IPPROTO_UDP;
+	ip->ip_src = src_ip;
+	ip->ip_dst = string_to_ip(env_get("ipaddr"));
+	ip->udp_src = htons(src_port);
+	ip->udp_dst = htons(dest_port);
+	ip->udp_len = htons(UDP_HDR_SIZE + payload_len);
+	ip->ip_sum = compute_ip_checksum(ip, IP_HDR_SIZE);
+	memcpy(ip + 1, payload, payload_len);
+
+	priv->recv_packet_length[priv->recv_packets] = packet_len;
+	priv->recv_packets++;
+
+	return 0;
+}
+
+#if CONFIG_IS_ENABLED(PROT_DNS_LWIP)
+static int lwip_test_dns_cancel(struct unit_test_state *uts)
+{
+	struct lwip_test_dns_ctx cancelled = {};
+	struct lwip_test_dns_ctx active = {};
+	ip_addr_t dns_server;
+	ip_addr_t result;
+	int ret;
+	int i;
+
+	ipaddr_aton("1.1.2.2", &dns_server);
+	dns_setserver(0, &dns_server);
+
+	ret = dns_gethostbyname("cancel.test", &result,
+				lwip_test_dns_found, &cancelled);
+	ut_asserteq(ERR_INPROGRESS, ret);
+
+	/* Start the query so a second request can share it. */
+	dns_tmr();
+	ut_assertok(net_lwip_poll());
+	dns_cancel(lwip_test_dns_found, &cancelled);
+
+	ret = dns_gethostbyname("cancel.test", &result,
+				lwip_test_dns_found, &active);
+	ut_asserteq(ERR_INPROGRESS, ret);
+
+	for (i = 0; i < 16; i++)
+		dns_tmr();
+
+	ut_asserteq(0, cancelled.callbacks);
+	ut_asserteq(1, active.callbacks);
+	ut_assert(active.address_missing);
+
+	return 0;
+}
+#endif
+
+#if CONFIG_IS_ENABLED(WGET)
+static int lwip_test_http_abort(struct unit_test_state *uts)
+{
+	struct lwip_test_http_ctx ctx = {};
+	httpc_connection_t settings = {
+		.result_fn = lwip_test_http_result,
+	};
+	httpc_state_t *state = NULL;
+	ip_addr_t server;
+	err_t err;
+#if CONFIG_IS_ENABLED(PROT_DNS_LWIP)
+	int i;
+
+	err = httpc_get_file_dns("abort-http.test", HTTP_DEFAULT_PORT, "/",
+				 &settings, lwip_test_http_recv, &ctx, &state);
+	ut_asserteq(ERR_OK, err);
+	ut_assertnonnull(state);
+	ut_asserteq(ERR_OK, httpc_abort(state));
+	ut_asserteq(1, ctx.callbacks);
+	ut_asserteq(HTTPC_RESULT_LOCAL_ABORT, ctx.result);
+
+	/* A later DNS timeout must not call into the freed HTTP state. */
+	for (i = 0; i < 16; i++)
+		dns_tmr();
+	ut_asserteq(1, ctx.callbacks);
+
+	ctx = (struct lwip_test_http_ctx){};
+	state = NULL;
+#endif
+	ipaddr_aton("1.1.2.2", &server);
+	err = httpc_get_file(&server, HTTP_DEFAULT_PORT, "/", &settings,
+			     lwip_test_http_recv, &ctx, &state);
+	ut_asserteq(ERR_OK, err);
+	ut_assertnonnull(state);
+	ut_assertnonnull(tcp_active_pcbs);
+	ut_asserteq(SYN_SENT, tcp_active_pcbs->state);
+	ut_assertnull(tcp_active_pcbs->next);
+
+	/* An established connection must be removed, not left closing. */
+	tcp_active_pcbs->state = ESTABLISHED;
+	ut_asserteq(ERR_OK, httpc_abort(state));
+	ut_asserteq(1, ctx.callbacks);
+	ut_asserteq(HTTPC_RESULT_LOCAL_ABORT, ctx.result);
+	ut_assertnull(tcp_active_pcbs);
+
+	return 0;
+}
+#endif
+
+static int _dm_test_lwip_runtime(struct unit_test_state *uts,
+				 struct net_lwip_ctx *client_a,
+				 struct net_lwip_ctx *client_b,
+				 struct net_lwip_ctx *no_addr_client,
+				 struct udp_pcb **pcb_a,
+				 struct udp_pcb **pcb_b)
+{
+	struct lwip_test_recv_ctx recv_a = {};
+	struct lwip_test_recv_ctx recv_b = {};
+	struct in_addr host = string_to_ip("1.1.2.2");
+	ip4_addr_t expected;
+
+	ut_assertok(env_set("ethact", "eth@10002000"));
+	ut_assertok(env_set("ipaddr", "1.1.2.1"));
+	ut_assertok(env_set("netmask", "255.255.255.0"));
+	ut_assertok(env_set("gatewayip", "1.1.2.254"));
+
+	ut_assertok(net_lwip_start(client_a, NET_LWIP_ADDR_ENV));
+	ut_assertnonnull(client_a->dev);
+	ut_assertnonnull(client_a->netif);
+	ut_assert(eth_is_active(client_a->dev));
+	ip4addr_aton("1.1.2.1", &expected);
+	ut_assert(ip4_addr_cmp(netif_ip4_addr(client_a->netif), &expected));
+
+	ut_assertok(net_lwip_start(client_b, NET_LWIP_ADDR_ENV));
+	ut_asserteq_ptr(client_a->dev, client_b->dev);
+	ut_asserteq_ptr(client_a->netif, client_b->netif);
+
+	ut_assertok(env_set("ipaddr", "1.1.2.3"));
+	ut_assertok(net_lwip_refresh(client_a));
+	ip4addr_aton("1.1.2.3", &expected);
+	ut_assert(ip4_addr_cmp(netif_ip4_addr(client_a->netif), &expected));
+
+	ut_assertok(net_lwip_start(no_addr_client, NET_LWIP_ADDR_NONE));
+	ut_assert(ip4_addr_isany_val(*netif_ip4_addr(client_a->netif)));
+	ut_assertok(env_set("ipaddr", "1.1.2.4"));
+	ut_assertok(net_lwip_refresh(client_a));
+	ut_assert(ip4_addr_isany_val(*netif_ip4_addr(client_a->netif)));
+#if CONFIG_IS_ENABLED(PROT_DHCP_LWIP)
+	ut_assertok(lwip_test_dhcp_stop(uts, no_addr_client->netif));
+#endif
+	net_lwip_stop(no_addr_client);
+	ip4addr_aton("1.1.2.4", &expected);
+	ut_assert(ip4_addr_cmp(netif_ip4_addr(client_a->netif), &expected));
+#if CONFIG_IS_ENABLED(PROT_DNS_LWIP)
+	ut_assertok(lwip_test_dns_cancel(uts));
+#endif
+#if CONFIG_IS_ENABLED(WGET)
+	ut_assertok(lwip_test_http_abort(uts));
+#endif
+
+	*pcb_a = udp_new();
+	ut_assertnonnull(*pcb_a);
+	ut_asserteq(ERR_OK, udp_bind(*pcb_a, IP_ADDR_ANY, 10000));
+	udp_recv(*pcb_a, lwip_test_udp_recv, &recv_a);
+	*pcb_b = udp_new();
+	ut_assertnonnull(*pcb_b);
+	ut_asserteq(ERR_OK, udp_bind(*pcb_b, IP_ADDR_ANY, 10001));
+	udp_recv(*pcb_b, lwip_test_udp_recv, &recv_b);
+
+	ut_assertok(lwip_test_inject_udp(client_a->dev, "one", host,
+					 20000, 10000));
+	ut_assertok(net_lwip_poll());
+	ut_assertok(lwip_test_inject_udp(client_a->dev, "two", host,
+					 20001, 10001));
+	ut_assertok(net_lwip_poll());
+	ut_asserteq(1, recv_a.packets);
+	ut_asserteq(1, recv_b.packets);
+	ut_asserteq(-EBUSY, recv_a.nested_poll_ret);
+	ut_asserteq(-EBUSY, recv_b.nested_poll_ret);
+
+	net_lwip_stop(client_a);
+	ut_assertnonnull(client_b->netif);
+	ut_assert(eth_is_active(client_b->dev));
+
+	return 0;
+}
+
+static int dm_test_lwip_runtime(struct unit_test_state *uts)
+{
+	struct net_lwip_ctx no_addr_client = {};
+	struct net_lwip_ctx client_a = {};
+	struct net_lwip_ctx client_b = {};
+	struct udp_pcb *pcb_a = NULL;
+	struct udp_pcb *pcb_b = NULL;
+	struct udevice *dev;
+	int ret;
+
+	ret = _dm_test_lwip_runtime(uts, &client_a, &client_b,
+				    &no_addr_client, &pcb_a, &pcb_b);
+
+	if (pcb_b)
+		udp_remove(pcb_b);
+	if (pcb_a)
+		udp_remove(pcb_a);
+	net_lwip_stop(&no_addr_client);
+	net_lwip_stop(&client_a);
+	dev = client_b.dev;
+	net_lwip_stop(&client_b);
+
+	if (!ret) {
+		ut_assert(!eth_is_active(dev));
+		ut_asserteq(-ENODEV, net_lwip_poll());
+	}
+
+	return ret;
+}
+
+DM_TEST(dm_test_lwip_runtime, UTF_SCAN_FDT);

-- 
2.53.0

