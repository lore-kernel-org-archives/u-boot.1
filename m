Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340BD606A32C
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TTV70V3R;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=sVh3VdSS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B46FA606F7;
	Sat, 21 Nov 2026 17:01:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3abLpbE2Fq23; Sat, 21 Nov 2026 17:01:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 965F1606ED
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795280499;
	b=V96oKaSmXc+3f7usi6kTlwhOnM1RcLvLDM/65mIb1qqu7kxWtM4Yv6JDKhc+rQIK5nQZ
	 7MXysw5veKKZdaqMtkKhLw8aUAp6X3CFJOmz+/3SAA7b0frKJ5+Cco0G1uZRXQuQs7UOu
	 csfgZgvrFUcyK5Y+0zllOB/DL0+RIj0FpoLgCZTd1kaci3/pI9Ec0F7OQ+2SjysOqB3tS
	 22yxapWhHGWFwu6+7c8W5TDRbFPwGv+g3ePYr2J7qHD5JLFNVm3uYcEhZVwTLIoMioOaT
	 pBq8jZYNi6sdZWMOab3LtHv5L0fy9FMwDIau0MAz9KoMJHnY14i9FT75JH8CTZj862Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795280499;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dU5bVCo1XUHDgiNBx6QXLweAWgQU/FX4YObVBGPpAmU=;
	b=nNOL8Fr5jxp75D45cORBBqsW6fx1mJXcBi5ld7C/Awydmqipiq720Phoa6aMf9Y4Jj98
	 SWHh1a0GS7dcjlqELQ4/yrGbRCj1fIwr9yAi6Ve5OR23wGeNMfBSXLy/HZ/S3iImhfS1y
	 PJfaolgYbbAienZyaftOwHOTafYpcybbzEX+2d8MB4searq5NuhuNW3dQoXk5851cq465
	 72AJEjTWgEEQdGrxgOUfllrXJv83DzE4QuwpVRlSq3FIJEgpD+Qw6pNScqWd+vtDi2KdA
	 mJMK/cUvR1zkDv5jOOz8Xv1a89ROdifgsAyzOIOZJADUfg6og56TKS0MHJ2fngRLifQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=sVh3VdSS;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795280499;
	bh=dU5bVCo1XUHDgiNBx6QXLweAWgQU/FX4YObVBGPpAmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TTV70V3RIgXs7YKssS0hBvNHO7JnGwEo99s7saWd6HF8cO6/seV5YP/ecPH5XZT+F
	 zYBsmP79Ppb0BNhJ92lCpn6u56UcWU8HStU+JxlUSlBI7+XhD0BhzmzPb0MIg5voCK
	 06pbKnTeOKM29BV5KxQ0Ub0PKE/i3EK7geC2pvvVEir5XEV2d+X6lUoUQR/a0ip/ul
	 vALDWLIY0WGuinieAUD/7rgu+zCiABAkDsfotgRfypKhshKKv7trAJyLu1IpCaNlC/
	 TGX1jZDhC4IhdUe2g33jJra8HIA7UawjGq54z/+XUUCoSTHfuYT134AsuyrbgmCwqD
	 X8rKJuJm2CxNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 965F1606ED;
	Sat, 21 Nov 2026 17:01:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 41BA0759
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 17:01:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 339756065A
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 17:01:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M1g_ZQvYEkqp for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 17:01:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ECAA66063E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=sVh3VdSS
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ECAA66063E
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 17:01:34 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jWz4q1k5jzMlGd;
 Sat, 21 Nov 2026 18:01:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1795280491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dU5bVCo1XUHDgiNBx6QXLweAWgQU/FX4YObVBGPpAmU=;
 b=sVh3VdSSYVgE/rE5OkNoy+3otOB06gt18N1BrlHlhz6wZcx78sUBzNZjmIKeKu+x1VRmu+
 DEag8k26kwy+K6cdiSxoCe7iEa9C+Bajs1EOQHrwgzVcMX16/l07fsljErHvfnEvoTOVN0
 R8kJpC9Ha46m7kwj7DkiowrqjNR+OM7zL7seyqgbK99NEBydWOc3ezJO0Bfpz2b7Po0i3r
 L5EWA/AXf/mUCwZu9tXOP7z+mOh+DqLebKGcFwF+7cGL5eY0sEpK+V56OKA5Cnd04VBg7I
 9z6aEJOwU9cM3LmJpaIJCF6yoR1MLIcuypVZTzU9/uqkkkK8GoP3fEFsyQsVrA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] net: nfs: Introduce NFSv3 over TCP with LwIP
Date: Sat, 21 Nov 2026 18:01:16 +0100
Message-ID: <20261121170127.942522-3-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121170127.942522-1-marek.vasut+renesas@mailbox.org>
References: <20261121170127.942522-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tbxgs5jyp5tg8pp9ntcwt1na1m87w11y
X-MBO-RS-ID: cc3d0d8343d3965b8aa
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for NFS over TCP in addition to NFS over UDP which is
long being disabled on most distributions. Introduce "nfsservertcp"
environment variable which must be set to 1 to select NFS over TCP
instead of NFS over UDP to avoid breaking existing users.

The implementation adds parallel set of functions for handling the
TCP streams that are established with the server -- portmap at port
111, NFS and data connection as determined from the portmap. Unlike
the UDP, each TCP stream has its own struct nfs_conn_ctx associated
with it to track its state.

The UDP functions are retained with minimum changes. Due to the
nature of the two protocols, it is not easily possible to merge the
two sets of functions into a common one, although where viable, the
common code is factored out. The TCP variant of the send and receive
handlers adds and removes a fragment header respectively.

The network handling loop in nfs_loop() is slightly adjusted to
cater for the TCP, which has to perform nfs_send() in this loop
once a response was received, else the NFS state machine falls
apart. The UDP does nfs_send() in its .recv callback instead and
only invokes nfs_send() in nfs_loop() once to get the state machine
going the first time.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>
Cc: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 net/lwip/nfs.c   | 218 +++++++++++++++++++++++++++++++++++++++++++----
 net/nfs-common.c |   3 +-
 2 files changed, 205 insertions(+), 16 deletions(-)

diff --git a/net/lwip/nfs.c b/net/lwip/nfs.c
index b435403169a..7756c7852ec 100644
--- a/net/lwip/nfs.c
+++ b/net/lwip/nfs.c
@@ -10,22 +10,100 @@
 #include <time.h>
 #include <dm/device.h>
 #include <linux/kconfig.h>
+#include <lwip/altcp.h>
+#include <lwip/priv/tcp_priv.h>
 #include <lwip/timeouts.h>
 #include <lwip/udp.h>
 #include "../nfs-common.h"
 
 static ulong timer_start;
 
+struct rpc_frag_t {
+	u32		frag;
+	struct rpc_t	pkt;
+};
+
+struct nfs_conn_ctx {
+	struct altcp_pcb	*pcb;
+	struct pbuf		*pb;
+	bool			connected;
+};
+
 static struct nfs_ctx {
-	ip_addr_t nfs_server;
-	struct udp_pcb *pcb;
+	struct nfs_conn_ctx	conn_rpc;
+	struct nfs_conn_ctx	conn_nfs;
+	struct nfs_conn_ctx	conn_dat;
+	struct udp_pcb		*udp_pcb;
+	ip_addr_t		nfs_server;
+	bool			send_ok;
+	bool			transport_tcp;
 } sess_ctx;
 
 /**************************************************************************
  * RPC_LOOKUP - Lookup RPC Port numbers
  **************************************************************************
  */
-void rpc_req(int rpc_prog, int rpc_proc, uint32_t *data, int datalen)
+static err_t nfs_tcp_connected(void *arg, struct altcp_pcb *pcb, err_t err)
+{
+	struct nfs_conn_ctx *cctx = arg;
+	int ret;
+
+	cctx->connected = true;
+	ret = altcp_write(cctx->pcb, cctx->pb->payload, cctx->pb->len, TCP_WRITE_FLAG_COPY);
+	tcp_output(cctx->pcb);
+	pbuf_free(cctx->pb);
+	cctx->pb = NULL;
+
+	return ret;
+}
+
+void rpc_req_tcp(int rpc_prog, int rpc_proc, uint32_t *data, int datalen)
+{
+	struct nfs_conn_ctx *cctx;
+	struct rpc_frag_t *fb;
+	struct pbuf *pb;
+	int pktlen;
+	int sport;
+	err_t err;
+
+	pb = pbuf_alloc(PBUF_TRANSPORT, sizeof(struct rpc_frag_t), PBUF_RAM);
+	if (!pb) {
+		debug("Failed to allocate pbuf to build RPC packet\n");
+		return;
+	}
+
+	fb = (struct rpc_frag_t *)(pb->payload);
+
+	rpc_req_common(rpc_prog, rpc_proc, data, datalen,
+		       (uchar *)&fb->pkt, &pktlen, &sport);
+
+	/* Add fragment header */
+	fb->frag = htonl(0x80000000 | pktlen);
+	pktlen += 4;
+
+	pbuf_realloc(pb, (u16_t)pktlen);
+
+	if (rpc_prog == PROG_PORTMAP)
+		cctx = &sess_ctx.conn_rpc;
+	else if (rpc_prog == PROG_MOUNT)
+		cctx = &sess_ctx.conn_nfs;
+	else
+		cctx = &sess_ctx.conn_dat;
+
+	if (cctx->connected) {
+		err = altcp_write(cctx->pcb, pb->payload, pb->len, TCP_WRITE_FLAG_COPY);
+		tcp_output(cctx->pcb);
+		pbuf_free(pb);
+	} else {
+		err = altcp_connect(cctx->pcb, &sess_ctx.nfs_server, sport, nfs_tcp_connected);
+		if (err == ERR_OK)
+			cctx->pb = pb;
+	}
+
+	debug_cond((err != ERR_OK), "Failed to send TCP packet err = %d\n", err);
+}
+
+void rpc_req_udp(int rpc_prog, int rpc_proc, uint32_t *data, int datalen)
 {
 	struct pbuf *pb;
 	int pktlen;
@@ -43,18 +121,53 @@ void rpc_req(int rpc_prog, int rpc_proc, uint32_t *data, int datalen)
 
 	pbuf_realloc(pb, (u16_t)pktlen);
 
-	err = udp_sendto(sess_ctx.pcb, pb, &sess_ctx.nfs_server, sport);
+	err = udp_sendto(sess_ctx.udp_pcb, pb, &sess_ctx.nfs_server, sport);
 	debug_cond((err != ERR_OK), "Failed to send UDP packet err = %d\n", err);
 	pbuf_free(pb);
 }
 
+void rpc_req(int rpc_prog, int rpc_proc, uint32_t *data, int datalen)
+{
+	if (sess_ctx.transport_tcp)
+		rpc_req_tcp(rpc_prog, rpc_proc, data, datalen);
+	else
+		rpc_req_udp(rpc_prog, rpc_proc, data, datalen);
+}
+
 void nfs_refresh_timeout(void)
 {
 	timer_start = get_timer(0);
 }
 
-static void nfs_recv(void *arg, struct udp_pcb *pcb, struct pbuf *p,
-		     const ip_addr_t *addr, u16_t port)
+static err_t nfs_tcp_recv(void *arg, struct altcp_pcb *pcb, struct pbuf *p, err_t err)
+{
+	struct rpc_frag_t rpc_pkt_frag;
+	int plen, ret;
+
+	if (!p)
+		goto exit;
+
+	if (p->tot_len > sizeof(rpc_pkt_frag))
+		goto exit;
+
+	plen = pbuf_copy_partial(p, &rpc_pkt_frag, sizeof(rpc_pkt_frag), 0);
+
+	ret = nfs_pkt_recv_nosend((unsigned char *)&rpc_pkt_frag.pkt, plen);
+	altcp_recved(pcb, plen);
+	if (ret)
+		sess_ctx.send_ok = true;
+
+	/* ACK last transmission here */
+	tcp_ack_now(pcb);
+	tcp_output(pcb);
+
+exit:
+	pbuf_free(p);
+	return ERR_OK;
+}
+
+static void nfs_udp_recv(void *arg, struct udp_pcb *pcb, struct pbuf *p,
+			 const ip_addr_t *addr, u16_t port)
 {
 	struct nfs_ctx *ctx = arg;
 	int plen;
@@ -73,18 +186,88 @@ exitfree:
 	pbuf_free(p);
 }
 
+static int nfs_tcp_init(struct nfs_ctx *ctx)
+{
+	/* RPC / portmap connection */
+	ctx->conn_rpc.connected = false;
+	ctx->conn_rpc.pcb = altcp_new();
+	if (!ctx->conn_rpc.pcb)
+		return ERR_MEM;
+
+	altcp_arg(ctx->conn_rpc.pcb, &ctx->conn_rpc);
+	altcp_recv(ctx->conn_rpc.pcb, nfs_tcp_recv);
+
+	/* NFS connection */
+	ctx->conn_nfs.connected = false;
+	ctx->conn_nfs.pcb = altcp_new();
+	if (!ctx->conn_nfs.pcb)
+		return ERR_MEM;
+
+	altcp_arg(ctx->conn_nfs.pcb, &ctx->conn_nfs);
+	altcp_recv(ctx->conn_nfs.pcb, nfs_tcp_recv);
+
+	/* Data connection */
+	ctx->conn_dat.connected = false;
+	ctx->conn_dat.pcb = altcp_new();
+	if (!ctx->conn_dat.pcb)
+		return ERR_MEM;
+
+	altcp_arg(ctx->conn_dat.pcb, &ctx->conn_dat);
+	altcp_recv(ctx->conn_dat.pcb, nfs_tcp_recv);
+
+	return 0;
+}
+
 static int nfs_udp_init(struct nfs_ctx *ctx)
 {
-	ctx->pcb = udp_new();
-	if (!ctx->pcb)
+	ctx->udp_pcb = udp_new();
+	if (!ctx->udp_pcb)
 		return -ENOMEM;
 
-	ctx->pcb->local_port = nfs_our_port;
-	udp_recv(ctx->pcb, nfs_recv, ctx);
+	ctx->udp_pcb->local_port = nfs_our_port;
+	udp_recv(ctx->udp_pcb, nfs_udp_recv, ctx);
 
 	return 0;
 }
 
+static int nfs_init(struct nfs_ctx *ctx)
+{
+	sess_ctx.transport_tcp = (env_get_yesno("nfsservertcp") == 1);
+
+	if (sess_ctx.transport_tcp)
+		return nfs_tcp_init(ctx);
+	else
+		return nfs_udp_init(ctx);
+}
+
+static void nfs_tcp_deinit(struct nfs_conn_ctx *cctx)
+{
+	err_t ret;
+
+	if (!cctx->connected)
+		return;
+
+	cctx->connected = false;
+	ret = altcp_close(cctx->pcb);
+	if (ret != ERR_OK)
+		altcp_abort(cctx->pcb);
+	if (cctx->pb)
+		pbuf_free(cctx->pb);
+	cctx->pcb = false;
+}
+
+static void nfs_deinit(struct nfs_ctx *ctx)
+{
+	if (sess_ctx.transport_tcp) {
+		nfs_tcp_deinit(&ctx->conn_dat);
+		nfs_tcp_deinit(&ctx->conn_nfs);
+		nfs_tcp_deinit(&ctx->conn_rpc);
+	} else {
+		udp_remove(ctx->udp_pcb);
+		ctx->udp_pcb = NULL;
+	}
+}
+
 static int nfs_timeout_check(void)
 {
 	if (get_timer(timer_start) < nfs_timeout)
@@ -92,7 +275,8 @@ static int nfs_timeout_check(void)
 	if (++nfs_timeout_count < NFS_RETRY_COUNT) {
 		puts("T ");
 		timer_start = get_timer(0);
-		nfs_send();
+		if (!sess_ctx.transport_tcp)
+			nfs_send();
 		return 0;
 	}
 
@@ -133,7 +317,7 @@ static int nfs_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
 	nfs_timeout_count = 0;
 	nfs_state = STATE_PRCLOOKUP_PROG_MOUNT_REQ;
 
-	ret = nfs_udp_init(&sess_ctx);
+	ret = nfs_init(&sess_ctx);
 	if (ret < 0) {
 		debug("Failed to init network interface, aborting for error = %d\n", ret);
 		return ret;
@@ -143,11 +327,16 @@ static int nfs_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
 
 	ip_addr_set(&sess_ctx.nfs_server, &srvip);
 
-	nfs_send();
+	sess_ctx.send_ok = true;
 
 	timer_start = get_timer(0);
 	do {
+		if (sess_ctx.send_ok) {
+			sess_ctx.send_ok = false;
+			nfs_send();
+		}
 		net_lwip_poll();
+
 		if (net_state != NETLOOP_CONTINUE)
 			break;
 		if (ctrlc()) {
@@ -160,8 +349,7 @@ static int nfs_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
 	} while (true);
 	debug("%s: Loop exit at %lu\n", __func__, get_timer(0));
 
-	udp_remove(sess_ctx.pcb);
-	sess_ctx.pcb = NULL;
+	nfs_deinit(&sess_ctx);
 
 	if (net_state == NETLOOP_SUCCESS) {
 		ret = 0;
diff --git a/net/nfs-common.c b/net/nfs-common.c
index 4b66536a3fd..5cfd2a58edd 100644
--- a/net/nfs-common.c
+++ b/net/nfs-common.c
@@ -36,6 +36,7 @@
  * does not support NFSv3, we fall back to versions 2 or 1.
  */
 
+#include <env.h>
 #ifdef CONFIG_SYS_DIRECT_FLASH_NFS
 #include <flash.h>
 #endif
@@ -244,7 +245,7 @@ static void rpc_lookup_req(int prog, int ver)
 	data[2] = 0; data[3] = 0;	/* auth verifier */
 	data[4] = htonl(prog);
 	data[5] = htonl(ver);
-	data[6] = htonl(17);	/* IP_UDP */
+	data[6] = htonl((env_get_yesno("nfsservertcp") == 1) ? 6 : 17); /* 6:IP_TCP 17:IP_UDP */
 	data[7] = 0;
 	rpc_req(PROG_PORTMAP, PORTMAP_GETPORT, data, 8);
 }
-- 
2.53.0

