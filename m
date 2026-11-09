Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD35606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Tn+uKcQv;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YRc6Ey3a
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 686436073C;
	Mon,  9 Nov 2026 08:14:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bMagPqjCNY7f; Mon,  9 Nov 2026 08:14:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E94A360621
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794212062;
	b=hNKG2iwLdwj03+n5LpHURg6aYTkzIa67eH72LcPHiSaV5t7bsVYwhu/nIuXJKtxIHYSY
	 EeIuc/hWMUtlKLNabM690K6GyAYf57FsDWz8Q6jfdep84p/nHka8q3a+7T1XfKTkmrMiI
	 PwijiQF5P8WZVGg9569fYFGVVy4Zkv9p3U8NnCtnJvtCLHWtcIgBPd5PqVgnRbtbPiQGx
	 wCntebmTAjkXb6WyprHqVXpleukk1Jx2qUpEqaQPqTafBUbPDDFeO2tHdKyanJ38Fk6Lq
	 rpivg06TueAxraOap7bRLidqY4HoFOWDb8vgeDd3EHOi4HygHf0OGAl5hKLz0YWxy8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794212062;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=VNUYnyuexfFkg+zrF3FcW/bkcNHhiucdRBDMo6cI3iw=;
	b=ZWykUwEB2OPTgEjopR0kBjEh+zvFBiq0bEfY0+ia50VIO7bnTxnZzqMFfnuBIY0ZD30g
	 5R4ljNg7ROnRo+yKJHCKrdJ4bvgosApL0V5yW2kYZ8JHnJReiKPv4QIuTg8WALDlfvjkY
	 52eWKxs3tS7F6jBE0OpwhYgwQhRh7vhBTNpPNbw7tGXLASbz86dzOrTWxI4r3IfQqqnEK
	 ZnD4ZoSuXwA/kekxs5lhj05P6PEtrkvu/gCypG5jVSNpb481RIT2JTIBOjk9/66qJ/tOb
	 CfriNyinhf6pvl3KPJA5lqnUYwMsPYKTZxKev1MLVCtGaxMv6KVfqDurTkO3rBni5tg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YRc6Ey3a;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794212062;
	bh=VNUYnyuexfFkg+zrF3FcW/bkcNHhiucdRBDMo6cI3iw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tn+uKcQvWuTFoaEzArcRX35sk1N5/YJYmw8LpLCw96+vQSgnDL416BNeBYMKrsmi1
	 NgGGmn6Zw5xtDzw7R0xUWnlfY2e8wkSljR61RjidPBgnsoRiNsuBel+ZO2JFyZiZ3d
	 A7UI67L9tfLD5bsSrr+6siKoxekvUaqOGByjvvOpIeD1f34MttWmeickQwZvFdIuYf
	 GlLxs/cLHSnDfdv+IZFImmKwKWYtI3cQhwPBkOTzvnLB8zoxCOR+K1MCa0TfqGIv0B
	 bSP5npeDZeosLn+lyX57BdOtaajObYGUsCeed6UA0J8E+24/BIX6JTfoWKIxh1hjUu
	 I5DeKU4JZixRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E94A360621;
	Mon,  9 Nov 2026 08:14:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 35DD5111
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:14:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 26E5360621
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:14:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A9v7kjpQ6Nb8 for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 08:14:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E4895605E3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=YRc6Ey3a
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E4895605E3
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:14:16 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6df7f544919so279621eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 00:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794212055; x=1794816855;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VNUYnyuexfFkg+zrF3FcW/bkcNHhiucdRBDMo6cI3iw=;
 b=YRc6Ey3a9AMdEjQntiYzvF0CKTxQjQ3/X1Xd+ZKpgH2StGc7D1KhMfK3+b9TBavJvj
 /glJC/ebl0ElE2mX1Q77jdFVIH59t0pKoZp09FyOtoQENnpyz2hBj8wCAhWwZMOy2kYv
 xoNwldLlK1pNZtSlgeUr4GRrskpiubGsCYQwXpXoKiu63ngm/FdK5WfJIL9ZZCYGcMW6
 35wdkf8/gMzUyjP2mDxMWQNIuoNKyJOgPbojOLJN+Iwf8GAWQWnFHLa2tKUmRVP1QQ+x
 LpW7WdRdWMUCkVb/VN7/FERz33H657fSwe/LIKNOA0JE48lcASBMkVUalhv2Yyod3T3m
 GDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794212055; x=1794816855;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VNUYnyuexfFkg+zrF3FcW/bkcNHhiucdRBDMo6cI3iw=;
 b=hVsgj8GvC1k2bejPFgR0iWOtZu0EzG2HxK374ce1uR5lQcaoYwibOkmwuE6v/VL3Yk
 tf7MaIyhkRSW7Q3DYGna2EFNd+emT4yExHThnNcmgcuM4ZrDsjoXt2DnKxnDenxCOwcd
 X+y+cGztCr6BJiMglv5WR6KnQALbyjsSLegr+rJ7+8EpRFijyyQ1W5CJSzUpNJTn9qpJ
 PG2VYQnYW61IvuARcJZk+XcMZntAIQLCnIHavo0u3UpTdphxa/XkHxKhlD97K02BiyJ8
 9bCN5Nq6aUystgY9k7dJ0Q9rlMm7JxSVHf5uEiMeJHgWBqRTnt12Mg3b6JIDEuFRcXt7
 tDcQ==
X-Gm-Message-State: APuU4Z/e1BYm+R7jQtEq97sDsfUT/u3+B0nfvP9+3JE3F8SfJ1FcF7Nc
 Ai8DWiK9yPNf/0Q8DS6PGKcGpYWveMfHieuKsWHU8aTtonAq0w9+EwbKsqseALwT
X-Gm-Gg: AYBFou2/66KGxTOGtmeA+Mo1S9sROwPdJoCMY/VPqXV4kZ0nEx2bbrE88pyQd9WeBJf
 akguQkjTlEpgR415Xbq+w0ba0RLBQfy1YPnTPZYazjd/pVPEd0H5mnEafYZu52VQLWGQ9SC2a9b
 5XAefqAFA2+m2+c+JMzvu4z52jJ1JPqEYlqWN4l9o4Bsrr5e6bH4cA2RGB0PEDUiloHXJLBvbZT
 00tq3APamnKpKTvo2+ZNPuTD/8B6glFqd9Hxw1BTBjn4XMRLxjFUEbWkQOGTsJ3ZKXsG8biSibj
 546AsbC/S3UW52yGe6ni62FmwlLE8lq9KkB6bh2D3S70dVk77R2XFMuDhuRtKgHJWSK9pdZToQJ
 HSWzEymcDP9+qRmeHJ/zCJB6rQ8dbqM3hQinUUmm2PRsxAbnHXuGqwCpSRlOIyhs+828zYu1Opc
 qAxB4qneivePjpd8htHptaAS/uMI2CgjxyoIOl2rbwwxPywkuVXVuDLqWwGKa207fw/vXHJeW6h
 zQjYc1sJrTo3OcB9QY/6Eg9R7AsxEgcNrImBqgsjJdaEVX4GQ+GlLjjW80UR2lN4NMMd0zsWZkl
 M2+jEECV338BEI8sT4F1HRdbUf/CNiDA8qOvwh6t5Drlm0ZuRK440bQiHQYLFubenmUk1yLh2X3
 DoNJ4KoLX5kyncRquKmDoexCH2y7ZyZdVdW9m8awBxQ9HlXBclS8UcDiIbm1rq+DzHOehLEl+M3
 vrKojpK6W6UkKuv9iaw+gvPuRHoi8DvLMqL4z629U0eBrr0kcUEXg=
X-Received: by 2002:a05:6820:a64b:10b0:716:dafc:5600 with SMTP id
 006d021491bc7-7170f359c3dmr1141434eaf.84.1794212055401; 
 Mon, 09 Nov 2026 00:14:15 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-7170f8cbcb9sm2816766eaf.6.2026.11.09.00.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 00:14:14 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 01:14:10 -0700
Subject: [PATCH 3/3] test: net: exercise lwIP wake-on-LAN reception
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-submit-lwip-wol-v1-v1-3-d11961f7666f@gmail.com>
References: <20261109-submit-lwip-wol-v1-v1-0-d11961f7666f@gmail.com>
In-Reply-To: <20261109-submit-lwip-wol-v1-v1-0-d11961f7666f@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Mingtian Li <limingtian@email.szu.edu.cn>, 
 James Hilliard <james.hilliard1@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Check the shared magic-packet parser and password export, invalid command
arguments, Ethernet and UDP reception, malformed packet rejection,
timeouts and console cancellation. Exercise reception without an IP
address and on a nondefault interface, as well as listener cleanup while
another lwIP client keeps the interface active.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 test/dm/Makefile   |   4 +
 test/dm/lwip_wol.c | 301 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 test/dm/wol.c      |  91 ++++++++++++++++
 3 files changed, 396 insertions(+)

diff --git a/test/dm/Makefile b/test/dm/Makefile
index 112326c85bb..6ed84bae120 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -157,6 +157,10 @@ obj-$(CONFIG_TEE) += tee.o
 obj-$(CONFIG_TIMER) += timer.o
 obj-$(CONFIG_TPM_V2) += tpm.o
 obj-$(CONFIG_DM_USB) += usb.o
+obj-$(CONFIG_CMD_WOL) += wol.o
+ifeq ($(CONFIG_NET_LWIP)$(CONFIG_CMD_WOL),yy)
+obj-y += lwip_wol.o
+endif
 obj-$(CONFIG_VIDEO_SANDBOX_SDL) += video.o
 ifeq ($(CONFIG_VIRTIO_SANDBOX),y)
 obj-y += virtio.o
diff --git a/test/dm/lwip_wol.c b/test/dm/lwip_wol.c
new file mode 100644
index 00000000000..23ed00eadfb
--- /dev/null
+++ b/test/dm/lwip_wol.c
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <command.h>
+#include <console.h>
+#include <dm.h>
+#include <env.h>
+#include <net.h>
+#include <net/wol.h>
+#include <time.h>
+#include <asm/eth.h>
+#include <asm/unaligned.h>
+#include <dm/test.h>
+#include <lwip/inet_chksum.h>
+#include <lwip/timeouts.h>
+#include <test/ut.h>
+
+enum wol_test_kind {
+	WOL_ETH,
+	WOL_ETH_PASSWORD4,
+	WOL_ETH_PASSWORD6,
+	WOL_UDP0,
+	WOL_UDP7,
+	WOL_UDP9,
+	WOL_UDP_CHECKSUM,
+	WOL_UDP_PADDING,
+	WOL_UDP_UNICAST,
+	WOL_BAD_SYNC,
+	WOL_BAD_MAC,
+	WOL_SHORT_ETH,
+	WOL_SHORT_MAGIC,
+	WOL_BAD_PROTOCOL,
+	WOL_BAD_VERSION,
+	WOL_BAD_IHL,
+	WOL_BAD_IPLEN,
+	WOL_SHORT_IP,
+	WOL_BAD_IP_CHECKSUM,
+	WOL_BAD_UDP_CHECKSUM,
+	WOL_BAD_PORT,
+	WOL_SHORT_UDP,
+	WOL_LONG_UDP,
+	WOL_BAD_DEST,
+	WOL_FRAGMENT,
+	WOL_CANCEL,
+	WOL_TIMEOUT,
+};
+
+struct wol_test {
+	enum wol_test_kind kind;
+	bool injected;
+	int error;
+};
+
+static int wol_inject_packet(struct udevice *dev, enum wol_test_kind kind)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct ethernet_hdr *eth;
+	struct ip_udp_hdr *ip;
+	struct wol_hdr *wol;
+	unsigned int len = sizeof(*wol);
+	unsigned int wirelen;
+	ip4_addr_t src, dst;
+	struct pbuf p = {};
+	bool udp = kind >= WOL_UDP0;
+	int i;
+
+	if (priv->recv_packets >= PKTBUFSRX)
+		return -ENOSPC;
+	eth = (void *)priv->recv_packet_buffer[priv->recv_packets];
+	memset(eth, 0, PKTSIZE_ALIGN);
+	memset(eth->et_dest, 0xff, ARP_HLEN);
+	memcpy(eth->et_src, priv->fake_host_hwaddr, ARP_HLEN);
+	eth->et_protlen = htons(udp ? PROT_IP : PROT_WOL);
+	ip = (void *)(eth + 1);
+	wol = udp ? (void *)(ip + 1) : (void *)(eth + 1);
+	memset(wol->wol_sync, WOL_SYNC_BYTE, WOL_SYNC_COUNT);
+	for (i = 0; i < WOL_MAC_REPETITIONS; i++)
+		memcpy(wol->wol_dest + i * ARP_HLEN, pdata->enetaddr, ARP_HLEN);
+	for (i = 0; i < WOL_PASSWORD_6B; i++)
+		wol->wol_passwd[i] = i + 1;
+	if (kind == WOL_ETH_PASSWORD4)
+		len += WOL_PASSWORD_4B;
+	if (kind == WOL_ETH_PASSWORD6 || kind == WOL_UDP_CHECKSUM)
+		len += WOL_PASSWORD_6B;
+	if (kind == WOL_BAD_SYNC)
+		wol->wol_sync[WOL_SYNC_COUNT - 1] ^= 1;
+	if (kind == WOL_BAD_MAC)
+		wol->wol_dest[sizeof(wol->wol_dest) - 1] ^= 1;
+	if (kind == WOL_SHORT_MAGIC)
+		len--;
+	wirelen = ETHER_HDR_SIZE + len;
+	if (udp) {
+		ip->ip_hl_v = kind == WOL_BAD_VERSION ? 0x65 : 0x45;
+		if (kind == WOL_BAD_IHL)
+			ip->ip_hl_v = 0x4f;
+		ip->ip_len = htons(IP_UDP_HDR_SIZE + len);
+		if (kind == WOL_BAD_IPLEN)
+			ip->ip_len = htons(IP_UDP_HDR_SIZE + len + 1);
+		ip->ip_ttl = 64;
+		ip->ip_p = kind == WOL_BAD_PROTOCOL ? IPPROTO_TCP : IPPROTO_UDP;
+		ip->ip_src = string_to_ip("1.1.2.2");
+		ip->ip_dst.s_addr = htonl(0xffffffff);
+		if (kind == WOL_UDP_UNICAST)
+			ip->ip_dst = string_to_ip("1.1.2.3");
+		if (kind == WOL_BAD_DEST)
+			ip->ip_dst = string_to_ip("1.1.2.4");
+		if (kind == WOL_FRAGMENT)
+			ip->ip_off = htons(0x2000);
+		ip->udp_src = htons(12345);
+		ip->udp_dst = htons(kind == WOL_UDP0 ? 0 : 9);
+		if (kind == WOL_UDP7)
+			ip->udp_dst = htons(7);
+		if (kind == WOL_BAD_PORT)
+			ip->udp_dst = htons(8);
+		ip->udp_len = htons(UDP_HDR_SIZE + len);
+		if (kind == WOL_SHORT_UDP)
+			ip->udp_len = htons(UDP_HDR_SIZE - 1);
+		if (kind == WOL_LONG_UDP)
+			ip->udp_len = htons(UDP_HDR_SIZE + len + 1);
+		if (kind == WOL_UDP_CHECKSUM || kind == WOL_UDP_PADDING ||
+		    kind == WOL_BAD_UDP_CHECKSUM) {
+			src.addr = ip->ip_src.s_addr;
+			dst.addr = ip->ip_dst.s_addr;
+			p.payload = &ip->udp_src;
+			p.len = UDP_HDR_SIZE + len;
+			p.tot_len = p.len;
+			ip->udp_xsum = inet_chksum_pseudo(&p, IPPROTO_UDP, p.len, &src, &dst);
+			if (!ip->udp_xsum)
+				ip->udp_xsum = 0xffff;
+			if (kind == WOL_BAD_UDP_CHECKSUM)
+				ip->udp_xsum = ~ip->udp_xsum ?: 1;
+		}
+		ip->ip_sum = compute_ip_checksum(ip, IP_HDR_SIZE);
+		if (kind == WOL_BAD_IP_CHECKSUM)
+			ip->ip_sum ^= 1;
+		wirelen += IP_UDP_HDR_SIZE;
+	}
+	if (kind == WOL_SHORT_ETH)
+		wirelen = ETHER_HDR_SIZE - 1;
+	if (kind == WOL_SHORT_IP)
+		wirelen = ETHER_HDR_SIZE + IP_HDR_SIZE - 1;
+	if (kind == WOL_UDP_PADDING)
+		wirelen += 21;
+	priv->recv_packet_length[priv->recv_packets++] = wirelen;
+
+	return 0;
+}
+
+static void wol_test_inject(void *arg)
+{
+	struct wol_test *test = arg;
+
+	test->injected = true;
+	if (test->kind == WOL_CANCEL)
+		console_in_puts("\x03");
+	else if (test->kind != WOL_TIMEOUT)
+		test->error = wol_inject_packet(eth_get_dev(), test->kind);
+	/* Invalid packets finish with a timeout without waiting a real second. */
+	timer_test_add_offset(2000);
+}
+
+static int wol_test_cases(struct unit_test_state *uts, struct wol_test *test,
+			  bool address)
+{
+	int last = address ? WOL_TIMEOUT : WOL_UDP_UNICAST;
+	int kind;
+
+	for (kind = WOL_ETH; kind <= last; kind++) {
+		test->kind = kind;
+		test->injected = false;
+		test->error = 0;
+		ut_assertok(env_set("wolpassword", "keep"));
+		sys_timeout(1, wol_test_inject, test);
+		ut_asserteq(kind > WOL_UDP_UNICAST, run_command("wol 1", 0));
+		ut_assert(test->injected);
+		ut_assertok(test->error);
+		if (kind == WOL_CANCEL) {
+			ut_assert(had_ctrlc());
+			clear_ctrlc();
+		}
+		if (kind == WOL_ETH_PASSWORD4)
+			ut_asserteq_str("1.2.3.4", env_get("wolpassword"));
+		else if (kind == WOL_ETH_PASSWORD6)
+			ut_asserteq_str("01:02:03:04:05:06", env_get("wolpassword"));
+		else
+			ut_asserteq_str("keep", env_get("wolpassword"));
+	}
+
+	/* Zero means an unlimited wait, still interruptible from the console. */
+	test->kind = WOL_CANCEL;
+	sys_timeout(1, wol_test_inject, test);
+	ut_asserteq(1, run_command("wol 0", 0));
+	ut_assert(had_ctrlc());
+
+	return 0;
+}
+
+static int wol_test_run(struct unit_test_state *uts, bool shared, bool address,
+			bool alternate)
+{
+	const char * const names[] = {
+		"ethact", alternate ? "ipaddr6" : "ipaddr",
+		alternate ? "netmask6" : "netmask",
+		alternate ? "gatewayip6" : "gatewayip", "wolpassword",
+	};
+	const char * const values[] = {
+		alternate ? "eth@10004000" : "eth@10002000",
+		address ? "1.1.2.3" : NULL,
+		address ? "255.255.255.0" : NULL, NULL, NULL,
+	};
+	struct net_lwip_ctx net = {};
+	struct wol_test test = {};
+	char *saved[ARRAY_SIZE(names)] = {};
+	int old_ctrlc = disable_ctrlc(0);
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(names); i++) {
+		const char *value = env_get(names[i]);
+
+		if (value) {
+			saved[i] = strdup(value);
+			if (!saved[i]) {
+				ret = -ENOMEM;
+				goto free_saved;
+			}
+		}
+	}
+	for (i = 0; i < ARRAY_SIZE(names); i++) {
+		ret = env_set(names[i], values[i]);
+		if (ret)
+			goto restore;
+	}
+	ret = net_init();
+	if (ret)
+		goto restore;
+	if (shared) {
+		ret = net_lwip_start(&net, NET_LWIP_ADDR_ENV_STRICT);
+		if (ret)
+			goto restore;
+	}
+	ret = wol_test_cases(uts, &test, address);
+	sys_untimeout(wol_test_inject, &test);
+	if (shared) {
+		if (!ret && !eth_is_active(net.dev))
+			ret = -ENODEV;
+		if (!ret) {
+			/* A late packet must not be processed by a retired listener. */
+			ret = env_set("wolpassword", "after");
+			if (!ret)
+				ret = wol_inject_packet(net.dev, WOL_ETH_PASSWORD6);
+			if (!ret && net_lwip_poll() < 0)
+				ret = -EIO;
+			if (!ret && strcmp(env_get("wolpassword"), "after"))
+				ret = -EINVAL;
+		}
+		net_lwip_stop(&net);
+	}
+restore:
+	for (i = 0; i < ARRAY_SIZE(names); i++)
+		env_set(names[i], saved[i]);
+free_saved:
+	for (i = 0; i < ARRAY_SIZE(names); i++)
+		free(saved[i]);
+	clear_ctrlc();
+	disable_ctrlc(old_ctrlc);
+
+	return ret;
+}
+
+static int dm_test_lwip_wol(struct unit_test_state *uts)
+{
+	ut_assertok(wol_test_run(uts, false, true, false));
+	ut_asserteq(-ENODEV, net_lwip_poll());
+	ut_assertok(wol_test_run(uts, true, true, false));
+	ut_asserteq(-ENODEV, net_lwip_poll());
+
+	return 0;
+}
+
+DM_TEST(dm_test_lwip_wol, UTF_SCAN_FDT | UTF_CONSOLE);
+
+static int dm_test_lwip_wol_no_ip(struct unit_test_state *uts)
+{
+	ut_assertok(wol_test_run(uts, false, false, false));
+	ut_asserteq(-ENODEV, net_lwip_poll());
+
+	return 0;
+}
+
+DM_TEST(dm_test_lwip_wol_no_ip, UTF_SCAN_FDT | UTF_CONSOLE);
+
+static int dm_test_lwip_wol_interface(struct unit_test_state *uts)
+{
+	ut_assertok(wol_test_run(uts, false, true, true));
+	ut_asserteq(-ENODEV, net_lwip_poll());
+
+	return 0;
+}
+
+DM_TEST(dm_test_lwip_wol_interface, UTF_SCAN_FDT | UTF_CONSOLE);
diff --git a/test/dm/wol.c b/test/dm/wol.c
new file mode 100644
index 00000000000..20cf6cc5906
--- /dev/null
+++ b/test/dm/wol.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <command.h>
+#include <env.h>
+#include <net/wol.h>
+#include <dm/test.h>
+#include <test/ut.h>
+
+static int dm_test_wol_magic(struct unit_test_state *uts)
+{
+	static const u8 mac[] = { 2, 3, 4, 5, 6, 7 };
+	u8 packet[sizeof(struct wol_hdr) + WOL_PASSWORD_6B + 1];
+	struct wol_hdr *wol = (void *)(packet + 1);
+	int i;
+
+	memset(wol->wol_sync, WOL_SYNC_BYTE, WOL_SYNC_COUNT);
+	for (i = 0; i < WOL_MAC_REPETITIONS; i++)
+		memcpy(wol->wol_dest + i * ARP_HLEN, mac, ARP_HLEN);
+
+	ut_assert(wol_check_magic(wol, sizeof(*wol), mac));
+	for (i = 0; i < sizeof(*wol); i++)
+		ut_assert(!wol_check_magic(wol, i, mac));
+	for (i = 0; i < sizeof(*wol); i++) {
+		packet[i + 1] ^= 1;
+		ut_assert(!wol_check_magic(wol, sizeof(*wol), mac));
+		packet[i + 1] ^= 1;
+	}
+
+	return 0;
+}
+
+DM_TEST(dm_test_wol_magic, 0);
+
+static int wol_password_check(struct unit_test_state *uts)
+{
+	u8 packet[sizeof(struct wol_hdr) + WOL_PASSWORD_6B + 1] = {};
+	struct wol_hdr *wol = (void *)(packet + 1);
+	int i;
+
+	for (i = 0; i < WOL_PASSWORD_6B; i++)
+		wol->wol_passwd[i] = i + 1;
+	ut_assertok(env_set("wolpassword", "keep"));
+	wol_save_password(wol, sizeof(*wol));
+	ut_asserteq_str("keep", env_get("wolpassword"));
+	wol_save_password(wol, sizeof(*wol) + 3);
+	ut_asserteq_str("keep", env_get("wolpassword"));
+	wol_save_password(wol, sizeof(*wol) + WOL_PASSWORD_4B);
+	ut_asserteq_str("1.2.3.4", env_get("wolpassword"));
+	wol_save_password(wol, sizeof(*wol) + WOL_PASSWORD_6B);
+	ut_asserteq_str("01:02:03:04:05:06", env_get("wolpassword"));
+	/* Passwords are not MAC-address variables with write-once semantics. */
+	ut_assertok(env_set("wolpassword", "02:00:00:00:00:01"));
+	wol_save_password(wol, sizeof(*wol) + WOL_PASSWORD_6B);
+	ut_asserteq_str("01:02:03:04:05:06", env_get("wolpassword"));
+
+	return 0;
+}
+
+static int dm_test_wol_password(struct unit_test_state *uts)
+{
+	const char *value = env_get("wolpassword");
+	char *saved = value ? strdup(value) : NULL;
+	int ret;
+
+	if (value)
+		ut_assertnonnull(saved);
+	ret = wol_password_check(uts);
+	env_set("wolpassword", saved);
+	free(saved);
+
+	return ret;
+}
+
+DM_TEST(dm_test_wol_password, 0);
+
+static int dm_test_wol_args(struct unit_test_state *uts)
+{
+	const char * const commands[] = {
+		"wol", "wol ''", "wol -1", "wol abc", "wol 1x", "wol 0x10",
+		"wol 18446744073709551616", "wol 18446744073709552",
+		"wol 999999999999999999999999999999999", "wol 1 extra",
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(commands); i++)
+		ut_assert(run_command(commands[i], 0));
+
+	return 0;
+}
+
+DM_TEST(dm_test_wol_args, UTF_CONSOLE);

-- 
2.53.0

