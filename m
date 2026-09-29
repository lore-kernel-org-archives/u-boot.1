Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E067CA5FAD
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D20E40575;
	Tue, 29 Sep 2026 00:22:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6n6eUh5IkBzr; Tue, 29 Sep 2026 00:22:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C6D8840557
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790641323;
	b=nb1PaCyV0iGdSnJLGg31P1+xEHs0nzICmM1G6B/eef92oNlMtgvQTeiY6oaBdmm7DBXY
	 BsPWgDUeEt8R8nf7pQODqAf2CcQ17k+NcCNU76g0undsRZbWfpwkWmLfpZAqh9L/OO4jg
	 AWDAMX747PkifBkbGBNkVF6OWVrY9CJYrpCCc8yBrAn8j1QkSH30qFy6KcCZhQygf9XP2
	 GxNLxXWzJDtdCmwB8RmSX098ZB7CJi6D9FOr6auxZ2UgS5Bv32hEcdAtO9No0Mv2dzO/S
	 vix+dQPeAFuema/z3fu5NF/6Gxho6DK4zUy6Xdjc8zO1U5dQYq2YBxtInwZBxQHZpsw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790641323;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=PWs1iMqYkIskkWZl3P1WZ/rRcsQhJqr9DPHitxt6Zj4=;
	b=ljzNuRFxOqW+vj/q1Gqn+hQrYO+yQ7a8iELuFa6iX3XFqSmjJpZD7N5tpWKGuoNcimwC
	 Pka/8xzgG1AeFHrdXzZTD0nMzQyJE4QSJ8xwKnCa2q+gjnW9e0gs9gLYtLGhBqjxjfYei
	 moa5Rh1mk+nFTWRXMAAI8Fdd8TtbaQTPkTzDs9xDCrfnMl//8Q4qRyYvnZj1toqjeDlcl
	 IG/R5c+3NaYAkSjeC4/0eteL83F2AOmUnY0NfNfdB3v21mG++qvDKDEGJTqjcDlWZ1kvd
	 N7uXEuqkzLAe6sMR1x/9sXsg38vuiXmqpCmOUuvR2LYTfm9VHJzmyK4BaVsDAlBjZAw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790641323;
	bh=PWs1iMqYkIskkWZl3P1WZ/rRcsQhJqr9DPHitxt6Zj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AKmUhYAb2LlZihnj8OF0LI4mgJLs8JiQukO5WYXRvOdJSEiq/SwY3COt54WZhuaIZ
	 XeYTZqVZgslY5ix5y0fFdoaCkvdUOUAslyebHGlPcK+r7Fkg1vQOfotOrUQfZiglhx
	 jDxQ+t+Yw2V6wW023ZKyUTezX5OeWYrKxsXYPtSSu+dK49L0+XsZ/11eCzyguIhLpv
	 AY0CPBNkifFAzc8+yLqF3ISEoOe7xx4bCYnQ1vxBYeUIbfUB+srffkK/ZrDBcJi2iG
	 R10mqQzTniBtrQJX5B3jmSXfMkqrTnkai9uR0U9wE54t5dydng7GnJKcEx//7n4ixY
	 zvOWgsx2Xcl4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6D8840557;
	Tue, 29 Sep 2026 00:22:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 37E8361
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 27C6860722
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H5Mty3ORLYCK for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:21:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E2E4E606F4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790641319;
 b=GqEe/Z/W3MPUaWlSTtOnZQBwu/H8rcBdip+vBbrENwSOOrAfXqSRy3wJfQm16/TWj//c
 L3YfxuQe+Hy3Cd+X3ynSNN0LTMv2nnSuaUpbQWsPjZU928L3v+Fp9k7PaQUxFItW68oh5
 mdsbM3rNpzoNoqFVKFeqGK6nuoorPnQQwTLNMS60/mRtVnPZcOC3tqNClF27P+9wF4cNZ
 8ogUowYc7fPITQBxFFBQMJprhu3Q55MODaseydbjVc/BJAJXkbRwPc+VLRzqfibKqGdG6
 MLoPW3wKFR92253g5XnbdCu5CQUQD+tzycakfGsYUK05M5GuHzI6FTsx7bNQWvf1Cuw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790641319;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=PWs1iMqYkIskkWZl3P1WZ/rRcsQhJqr9DPHitxt6Zj4=;
 b=PT/dMrFJ9vJR5RzgMAKr5IME/fawovrNaX5FX/MrH3r8Ldase/Skpuj7zMXq5NthH2+o
 1RGBe4VNr3Op9mtS1Zd5glcqMwduRpwvRCsYmcjICqoQKL2yCiuyUpl+0/KTxbVeMJ9cT
 KR/EOAhsbtJK55A13Umtvw4m4XkrlplODXgy7nOqcQWe2UD/akllSLIWP2PxPxctvO2Rs
 4+5HB1cLG+IV21UIOrNpzaTqVLSuqnlhB2ORLmyornEPejW11qeMBE40CYe6T6ZdCZfL1
 dOg03SANwYUnNt+XKRPZKpMNa6JiGnbxK3W4U4TzNEzm2GLInq0pKwPbHujLUI6WXiQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HyxVArtl; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=HyxVArtl
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E2E4E606F4
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:21:58 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6d821901872so503476eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790641317; x=1791246117;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PWs1iMqYkIskkWZl3P1WZ/rRcsQhJqr9DPHitxt6Zj4=;
 b=HyxVArtlWNQFLZao9jFanVKTf8L4MlJaXzEPJeQUWBgCQolUavqtjDG8ItFDR2SBYP
 AuezndY8vZIJjtiAkTPCdTnmkefDLwWCySOy3ZTC6A9xRVIhhWRVBsDsQ9jbzhJDXVkZ
 6kiPHj5oIbTFs+1fpWBwdekkE/9wwG97A5wBhI9No0BQ1dLDmWuFCZTMEapcEDjHcqEe
 okkaOW0dzAssgB4jUK29sYBnosERaYhV27rWm/nPRjJmpcykfBiuIMemarbyRwGU2rge
 L9AKwFos+5vEw+yDF316voyd3C3v0s+vHIc6IFBbhvYVfcHAagBqvmKRUAt6owxYrhSF
 E8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641317; x=1791246117;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PWs1iMqYkIskkWZl3P1WZ/rRcsQhJqr9DPHitxt6Zj4=;
 b=PokEZALf1K0UgfabR0NL5/gwxLGmKzNjF5WwCImvzTlfJ18R+eP3xuQyarAE+CUhUn
 G4Vl05X7Q092fNoo0oG7aezbor3H5/V4+8xfKHmkrnImOiYFJtZpKn/Rm3NRa+k/c3tf
 pnGCAUFYJuULRBbXIlmJRkvn6hPUf8DUntdItRAsyBDV+QuWlCCoVBXbnRsVHycUVXmC
 HhVJ9clYt/IwW0skcwrhmbWdc4IuAqMRTkl3T76aCtx7fc6iH9ovMWwiaElkxhM2mXHx
 C4SHFhRfnfewASO1BLJqpVpWzH/QXGOY02olaCcAFOj7VUtd9PnQV4XmnNXXGQ6yFdw8
 rDQA==
X-Gm-Message-State: AFuF++nRxaodHwJ3CchSi1F1hqUKuLASTAinAsHAiCKZotgsBmI8BLQy
 gynJ46no98MojPcc4MVn+B2rvFKiq44DBXjAtTXomygZOCFZ/NoKuz6+
X-Gm-Gg: AYBFou1rYfGWjhV087IP5SRnngtSPSlZz96mvAC0tcgGLPDZcM6tmgmKulHBTuXLxo3
 jIey/B/RWPAO6arS3FgCz54pYBaMgpU8qDvk5CdTFm5jE1dp+uSUG+5a+Ul4WZBY0rFIePsPYBh
 NfDEIf5vbslSM+rJZMlboMH+PmCT9T8Lg9SaM9q4RKQMhZzKHnCXcod1+pyg9Icep6OHoyBcPNY
 oBPb/WzRra1pDYwwZVyfSgkjL8ZbApoX5MzMMP75YOdWYiSiWKzKIja+tNLdPxvsOaSeydo1z0u
 ZfV12bb+p8OIMLTiUZklORK4DgXcMMJPGjdM3mfbLXMN5g4mLrdO+2KWHRPcWbsSiGFgu7Yt5EK
 PPs15HbFvpoZtNIgon5aR6DglQNj2H198d949A63WFteX5YihERp3deARDqt4SGm4nATFWOcAXe
 e6/41Hhj0MJwP7pwjgNDWY3Yz8NwSGyVckkNLnKRlgYblXWo6CcA/gfcy5St35Lsft3crrpBQt9
 7isunNJkDGr9CkGZHrgjjK7K8lxhhiBW9zsJId1KmsQEwc2M/2cclUI3lH1PVfizjGuQII/shx7
 NW44usoMDH2WbXXXp4ira3y8XHpUpg7+rTZ0jThVT/9CVADpxOQ3pdGZDdK1WBwdAe1prGrrKf8
 R7LKrdDlgtwfNx5iugcQDABwOCkS6rqA=
X-Received: by 2002:a05:6820:1988:b0:6d9:500:19f4 with SMTP id
 006d021491bc7-6db15e68eecmr536718eaf.50.1790641317150; 
 Mon, 28 Sep 2026 17:21:57 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-494877590e5sm8175688fac.13.2026.09.28.17.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:21:56 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 28 Sep 2026 18:21:41 -0600
Subject: [PATCH 04/20] test: net: cover lwIP DHCP autoload handoff
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-lwip-dhcp-v1-v1-4-2060c7365b0c@gmail.com>
References: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
In-Reply-To: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, Johan Jonker <jbx6244@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Peter Robinson <pbrobinson@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Heiko Schocher <hs@nabladev.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, 
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

Exchange DHCP packets in the sandbox Ethernet driver, then exercise the
real DHCP and TFTP commands. Verify filename precedence, lease-only
calls, exact autoload restoration, timeout and transfer failures, and
cleanup before the next protocol attaches. Check NFS dispatch when
enabled and explicit rejection when it is unavailable.

Check the NFS destination when the DHCP and boot servers differ,
including explicit NFS/filename overrides, configured boot-server
policy and cleanup after a failed transfer.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 test/dm/Makefile    |   3 +
 test/dm/lwip_dhcp.c | 349 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 352 insertions(+)

diff --git a/test/dm/Makefile b/test/dm/Makefile
index 32eba8b5e20..a15f8333d07 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -52,6 +52,9 @@ obj-$(CONFIG_DM_ETH) += eth.o
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_PROT_UDP_LWIP),yy)
 obj-y += lwip.o
 endif
+ifeq ($(CONFIG_NET_LWIP)$(CONFIG_CMD_DHCP),yy)
+obj-y += lwip_dhcp.o
+endif
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_NETCONSOLE),yy)
 obj-y += netconsole.o
 endif
diff --git a/test/dm/lwip_dhcp.c b/test/dm/lwip_dhcp.c
new file mode 100644
index 00000000000..57bbda2fc00
--- /dev/null
+++ b/test/dm/lwip_dhcp.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright 2026 James Hilliard <james.hilliard1@gmail.com> */
+
+#include <command.h>
+#include <dm.h>
+#include <env.h>
+#include <image.h>
+#include <malloc.h>
+#include <net.h>
+#include <time.h>
+#include <asm/eth.h>
+#include <asm/unaligned.h>
+#include <dm/test.h>
+#include <lwip/dhcp.h>
+#include <lwip/prot/dhcp.h>
+#include <lwip/prot/etharp.h>
+#include <test/ut.h>
+
+struct dhcp_handoff_test {
+	const char *offer;
+	bool fail;
+	bool timeout;
+	bool dhcp_alive;
+	bool rx_burst;
+	unsigned int arp_replies;
+	unsigned int tftp;
+	unsigned int nfs;
+	u32 boot_server;
+	u32 nfs_server;
+	char filename[128];
+};
+
+static int dhcp_handoff_reply(struct udevice *dev, struct dhcp_msg *request)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct dhcp_handoff_test *test = priv->priv;
+	struct ethernet_hdr *eth;
+	struct ip_udp_hdr *ip;
+	struct dhcp_msg *reply;
+	u8 type = request->options[2];
+	u8 *pos;
+	size_t len;
+
+	if (type != DHCP_DISCOVER && type != DHCP_REQUEST)
+		return 0;
+	if (test->timeout) {
+		timer_test_add_offset(10001);
+		return 0;
+	}
+	if (priv->recv_packets >= PKTBUFSRX)
+		return -ENOSPC;
+	eth = (void *)priv->recv_packet_buffer[priv->recv_packets];
+	memset(eth->et_dest, 0xff, ARP_HLEN);
+	memcpy(eth->et_src, priv->fake_host_hwaddr, ARP_HLEN);
+	eth->et_protlen = htons(PROT_IP);
+	ip = (void *)(eth + 1);
+	memset(ip, 0, IP_UDP_HDR_SIZE);
+	reply = (void *)(ip + 1);
+	memset(reply, 0, sizeof(*reply));
+	reply->op = DHCP_BOOTREPLY;
+	reply->htype = 1;
+	reply->hlen = ARP_HLEN;
+	reply->xid = request->xid;
+	memcpy(reply->chaddr, request->chaddr, sizeof(reply->chaddr));
+	put_unaligned_be32(0x01010203, &reply->yiaddr);
+	put_unaligned_be32(test->boot_server, &reply->siaddr);
+	reply->cookie = htonl(DHCP_MAGIC_COOKIE);
+	strlcpy((char *)reply->file, test->offer, sizeof(reply->file));
+	pos = reply->options;
+	*pos++ = DHCP_OPTION_MESSAGE_TYPE;
+	*pos++ = 1;
+	*pos++ = type == DHCP_DISCOVER ? DHCP_OFFER : DHCP_ACK;
+	*pos++ = DHCP_OPTION_SERVER_ID;
+	*pos++ = 4;
+	put_unaligned_be32(0x01010202, pos);
+	pos += 4;
+	*pos++ = DHCP_OPTION_SUBNET_MASK;
+	*pos++ = 4;
+	put_unaligned_be32(0xffffff00, pos);
+	pos += 4;
+	*pos++ = DHCP_OPTION_LEASE_TIME;
+	*pos++ = 4;
+	put_unaligned_be32(3600, pos);
+	pos += 4;
+	*pos++ = DHCP_OPTION_END;
+	len = pos - (u8 *)reply;
+	ip->ip_hl_v = 0x45;
+	ip->ip_len = htons(IP_UDP_HDR_SIZE + len);
+	ip->ip_ttl = 64;
+	ip->ip_p = IPPROTO_UDP;
+	ip->ip_src.s_addr = htonl(0x01010202);
+	ip->ip_dst.s_addr = htonl(0xffffffff);
+	ip->udp_src = htons(67);
+	ip->udp_dst = htons(68);
+	ip->udp_len = htons(UDP_HDR_SIZE + len);
+	ip->ip_sum = compute_ip_checksum(ip, IP_HDR_SIZE);
+	priv->recv_packet_length[priv->recv_packets++] = ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + len;
+
+	return 0;
+}
+
+static int dhcp_handoff_tx(struct udevice *dev, void *packet, unsigned int len)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct dhcp_handoff_test *test = priv->priv;
+	struct ethernet_hdr *eth = packet, *reply_eth;
+	struct ip_udp_hdr *ip, *reply_ip;
+	u8 *data;
+
+	if (test->rx_burst && netif_dhcp_data(netif_default) &&
+	    ntohs(eth->et_protlen) == PROT_ARP) {
+		struct etharp_hdr *arp = (void *)(eth + 1);
+		int ret;
+
+		/*
+		 * Binding sends a gratuitous ARP. Keep the receive queue busy by
+		 * answering each subsequent ARP reply with another request, so a
+		 * poll exhausts its packet budget and returns a positive length.
+		 */
+		if (ntohs(arp->opcode) == ARP_REPLY)
+			test->arp_replies++;
+		if (test->arp_replies >= ETH_PACKETS_BATCH_RECV)
+			return 0;
+		priv->fake_host_ipaddr.s_addr = htonl(0x01010202);
+		ret = sandbox_eth_recv_arp_req(dev);
+		if (ret)
+			return ret;
+		arp = (void *)(priv->recv_packet_buffer[priv->recv_packets - 1] +
+			      ETHER_HDR_SIZE);
+		/* The lease has not been published to net_ip yet. */
+		memcpy(&arp->dipaddr, netif_ip4_addr(netif_default),
+		       sizeof(arp->dipaddr));
+		return 0;
+	}
+	if (!sandbox_eth_arp_req_to_reply(dev, packet, len))
+		return 0;
+	if (len < ETHER_HDR_SIZE + IP_UDP_HDR_SIZE ||
+	    ntohs(eth->et_protlen) != PROT_IP)
+		return 0;
+	ip = (void *)(eth + 1);
+	if (ip->ip_p != IPPROTO_UDP)
+		return 0;
+	if (ntohs(ip->udp_dst) == 67) {
+		if (len < ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + DHCP_OPTIONS_OFS + 3)
+			return -EINVAL;
+		return dhcp_handoff_reply(dev, (void *)(ip + 1));
+	}
+	if (ntohs(ip->udp_dst) == 111) {
+		test->nfs++;
+		test->nfs_server = ntohl(ip->ip_dst.s_addr);
+		test->dhcp_alive |= !!netif_dhcp_data(netif_default);
+		/* Terminate the RPC request: downloading NFS data is not this test. */
+		net_set_state(NETLOOP_FAIL);
+		return 0;
+	}
+	if (ntohs(ip->udp_dst) != 69 ||
+	    len < ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + 4 ||
+	    get_unaligned_be16(ip + 1) != 1)
+		return 0;
+	test->tftp++;
+	test->dhcp_alive |= !!netif_dhcp_data(netif_default);
+	strlcpy(test->filename, (char *)(ip + 1) + 2, sizeof(test->filename));
+	if (priv->recv_packets >= PKTBUFSRX)
+		return -ENOSPC;
+	reply_eth = (void *)priv->recv_packet_buffer[priv->recv_packets];
+	memcpy(reply_eth->et_dest, eth->et_src, ARP_HLEN);
+	memcpy(reply_eth->et_src, priv->fake_host_hwaddr, ARP_HLEN);
+	reply_eth->et_protlen = htons(PROT_IP);
+	reply_ip = (void *)(reply_eth + 1);
+	memset(reply_ip, 0, IP_UDP_HDR_SIZE);
+	reply_ip->ip_hl_v = 0x45;
+	reply_ip->ip_len = htons(IP_UDP_HDR_SIZE + 6);
+	reply_ip->ip_ttl = 64;
+	reply_ip->ip_p = IPPROTO_UDP;
+	reply_ip->ip_src = ip->ip_dst;
+	reply_ip->ip_dst = ip->ip_src;
+	reply_ip->udp_src = htons(1234);
+	reply_ip->udp_dst = ip->udp_src;
+	reply_ip->udp_len = htons(UDP_HDR_SIZE + 6);
+	reply_ip->ip_sum = compute_ip_checksum(reply_ip, IP_HDR_SIZE);
+	data = (void *)(reply_ip + 1);
+	put_unaligned_be16(test->fail ? 5 : 3, data);
+	put_unaligned_be16(1, data + 2);
+	data[4] = 'x';
+	data[5] = 0;
+	priv->recv_packet_length[priv->recv_packets++] =
+		ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + 6;
+
+	return 0;
+}
+
+static int dhcp_handoff_check(struct unit_test_state *uts,
+			      struct dhcp_handoff_test *test)
+{
+	const char * const autoload[] = { NULL, "yes-please", "no", "NFS" };
+	char * const argv[] = { "dhcp", "2000000", "explicit.bin" };
+	int i, ret;
+
+	ut_assertok(env_set("ethact", "eth@10002000"));
+	ut_assertok(env_set("loadaddr", "2000000"));
+	ut_assertok(env_set("autostart", "no"));
+	ut_assertok(env_set("nfsserverip", NULL));
+	ut_assertok(env_set("tftpdstp", NULL));
+	ut_assertok(env_set("tftpsrcp", NULL));
+	for (i = 0; i < 4; i++) {
+		*test = (struct dhcp_handoff_test){ .offer = "offered.bin" };
+		ut_assertok(env_set("autoload", i == 3 ? "no" : "yes"));
+		ut_assertok(env_set("bootfile", "default.bin"));
+		ut_assertok(env_set("tftpserverip", "9.9.9.9"));
+		if (i == 2)
+			test->offer = "";
+		ret = do_dhcp(NULL, 0, i == 1 || i == 3 ? 3 : 1, argv);
+		ut_asserteq(i != 3 && !IS_ENABLED(CONFIG_CMD_TFTPBOOT) ?
+			   CMD_RET_FAILURE : CMD_RET_SUCCESS, ret);
+		ut_asserteq(i != 3 && IS_ENABLED(CONFIG_CMD_TFTPBOOT), test->tftp);
+		ut_assert(!test->dhcp_alive);
+		ut_assertnull(env_get("tftpserverip"));
+		if (test->tftp)
+			ut_asserteq_str(i == 1 ? "explicit.bin" : i == 2 ?
+					"default.bin" : "offered.bin", test->filename);
+		ut_assertnull(netif_default);
+	}
+	/* A full receive batch is successful network activity, not an error. */
+	*test = (struct dhcp_handoff_test){
+		.offer = "offered.bin",
+		.rx_burst = true,
+	};
+	ut_assertok(env_set("autoload", "no"));
+	ut_assertok(do_dhcp(NULL, 0, 1, argv));
+	/*
+	 * OFFER and ACK occupy two slots; without a proxy wait DHCP can stop
+	 * after the first full batch, leaving the final ARP requests queued.
+	 */
+	ut_assert(test->arp_replies >= ETH_PACKETS_BATCH_RECV - 2);
+	ut_assert(test->arp_replies <= ETH_PACKETS_BATCH_RECV);
+	ut_asserteq_str("1.1.2.3", env_get("ipaddr"));
+	ut_asserteq(0, test->tftp);
+	ut_asserteq(0, test->nfs);
+	ut_assertnull(netif_default);
+	for (i = 0; i < ARRAY_SIZE(autoload); i++) {
+		*test = (struct dhcp_handoff_test){ .offer = "offered.bin" };
+		ut_assertok(env_set("autoload", autoload[i]));
+		ut_assertok(dhcp_run(0, NULL, false));
+		ut_asserteq(0, test->tftp);
+		ut_asserteq(0, test->nfs);
+		if (autoload[i])
+			ut_asserteq_str(autoload[i], env_get("autoload"));
+		else
+			ut_assertnull(env_get("autoload"));
+	}
+	*test = (struct dhcp_handoff_test){ .offer = "offered.bin", .fail = true };
+	ut_assertok(env_set("autoload", "NFS"));
+	ut_asserteq(-ENOENT, dhcp_run(0x2000000, "explicit.bin", true));
+	ut_asserteq_str("NFS", env_get("autoload"));
+	ut_assert(!test->dhcp_alive);
+	ut_assertnull(netif_default);
+	*test = (struct dhcp_handoff_test){ .offer = "", .timeout = true };
+	ut_asserteq(-ENOENT, dhcp_run(0x2000000, NULL, true));
+	ut_asserteq(0, test->tftp);
+	ut_asserteq_str("NFS", env_get("autoload"));
+	ut_assertnull(netif_default);
+	*test = (struct dhcp_handoff_test){ .offer = "offered.bin" };
+	ut_asserteq(CMD_RET_FAILURE, do_dhcp(NULL, 0, 1, argv));
+	ut_asserteq(IS_ENABLED(CONFIG_CMD_NFS) ? 1 : 0, test->nfs);
+	ut_asserteq(0, test->tftp);
+	ut_assert(!test->dhcp_alive);
+	ut_assertnull(netif_default);
+
+	/*
+	 * The boot server can differ from the address server. Explicit NFS
+	 * settings and BOOTP server policies still take precedence. Every
+	 * transfer fails at the RPC request, exercising override cleanup too.
+	 */
+	for (i = 0; i < 4; i++) {
+		const char *server = i == 1 || i == 2 ? "1.1.2.5" : NULL;
+		char * const args[] = { "dhcp", "2000000", "1.1.2.6:/explicit.bin" };
+		u32 expected;
+
+		*test = (struct dhcp_handoff_test){
+			.offer = "offered.bin",
+			.boot_server = i == 3 ? 0 : 0x01010204,
+		};
+		ut_assertok(env_set("serverip", "1.1.2.9"));
+		ut_assertok(env_set("nfsserverip", server));
+		ut_asserteq(CMD_RET_FAILURE, do_dhcp(NULL, 0, i == 2 ? 3 : 1, args));
+		ut_asserteq(IS_ENABLED(CONFIG_CMD_NFS) ? 1 : 0, test->nfs);
+		expected = IS_ENABLED(CONFIG_BOOTP_SERVERIP) ||
+			   IS_ENABLED(CONFIG_BOOTP_PREFER_SERVERIP) ? 0x01010209 :
+			   i == 3 ? 0x01010202 : 0x01010204;
+		if (i == 1)
+			expected = 0x01010205;
+		else if (i == 2)
+			expected = 0x01010206;
+		if (IS_ENABLED(CONFIG_CMD_NFS))
+			ut_asserteq(expected, test->nfs_server);
+		if (server)
+			ut_asserteq_str(server, env_get("nfsserverip"));
+		else
+			ut_assertnull(env_get("nfsserverip"));
+		ut_asserteq(0, test->tftp);
+		ut_assert(!test->dhcp_alive);
+		ut_assertnull(netif_default);
+	}
+
+	return 0;
+}
+
+static int dm_test_lwip_dhcp_handoff(struct unit_test_state *uts)
+{
+	static const char * const vars[] = {
+		"ethact", "ipaddr", "netmask", "gatewayip", "serverip",
+		"tftpserverip", "nfsserverip", "autoload", "autostart", "bootfile",
+		"loadaddr", "dnsip", "dnsip2", "ntpserverip", "filesize", "fileaddr",
+		"tftpdstp", "tftpsrcp",
+	};
+	struct dhcp_handoff_test test = {};
+	char bootfile[sizeof(net_boot_file_name)];
+	ulong load_addr = image_load_addr;
+	char *saved[ARRAY_SIZE(vars)] = {};
+	int i, ret = -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(vars); i++) {
+		const char *value = env_get(vars[i]);
+
+		if (value) {
+			saved[i] = strdup(value);
+			if (!saved[i])
+				goto out;
+		}
+	}
+	memcpy(bootfile, net_boot_file_name, sizeof(bootfile));
+	sandbox_eth_set_tx_handler(0, dhcp_handoff_tx);
+	sandbox_eth_set_priv(0, &test);
+	ret = dhcp_handoff_check(uts, &test);
+	sandbox_eth_set_tx_handler(0, NULL);
+	sandbox_eth_set_priv(0, NULL);
+	memcpy(net_boot_file_name, bootfile, sizeof(bootfile));
+	image_load_addr = load_addr;
+	for (i = 0; i < ARRAY_SIZE(vars); i++)
+		if (env_set(vars[i], saved[i]))
+			ret = -EINVAL;
+out:
+	for (i = 0; i < ARRAY_SIZE(vars); i++)
+		free(saved[i]);
+
+	return ret;
+}
+
+DM_TEST(dm_test_lwip_dhcp_handoff, UTF_SCAN_FDT);

-- 
2.53.0

