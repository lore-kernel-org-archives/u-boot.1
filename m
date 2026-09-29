Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1BECA5FAB
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9181960732;
	Tue, 29 Sep 2026 00:22:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QptLLsuHEz2q; Tue, 29 Sep 2026 00:22:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B3EEA60712
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790641326;
	b=fLaKl+/Jfk/1aCpzaGdEbdURCQuG4iMc5upf3iRJx/UozdzQDPdkum3CT/0o1BfL8bN9
	 /YEbRY+ht/YTXyErseFG29vk75xs0hXJwpxM4HT0JPo4lR7KdNP7WAfr3Vy2ZPHvCTbiz
	 N+u5uwnubZdjXWdzRrrRiYAJpnWG8uESxe+SCXVk36gbKbXHpSE6BYMi9+W2EQn902Bia
	 h8sFkV+1IhnQ9WSY3oPz2xvRSuFC8B5jHeK1Kd4iRbwgD9OU/HRegWvzdvJ6duRan5gLn
	 DXX44VIOqreeZZl8DLRYbyYn25jxzZqFrIn2aXnqFlu7OM4KW3himU4VQkGLJAFyFqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790641326;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ZDMBZDfiI79K3tkhJ6zTbAfX/M2+byG2aE+HNlJoqkY=;
	b=MiSqVKAJbTdF0KL1YnQPpeFqQZtLVzxOcDBJO9rA8CWvXQWxBvKsKaJXUWCC3riVVOqM
	 wPEsH32+Ka/HE2KbolvnbMTqcpgHPH/Nd85UVU4Z1LU4XipP8OKfNzEpBAue5JQn43dsB
	 kQe4J3j2NMnP0qUDBf0H1buoN4eyg8dodytZgicnOZOlix5GBM39XkglHfX/R20YK2/VI
	 ZfPawdKlN5QQkB314Q+X6wQa9m2u9pLwcZSmBDT2zAI/9N6hr1lfLZnxQyAUkG/FEB/Un
	 W7bnh1FKAD+n/zJkGBZ7/5k5TSQv4zxMheQCoGCREhY2wP2iT+gvhj8dCJIaIRJs7eg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LnGDNWlY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790641326;
	bh=ZDMBZDfiI79K3tkhJ6zTbAfX/M2+byG2aE+HNlJoqkY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WkBfltVu+hVk3alKTGtZ5f9znOdjHRmZ7FKWHgbCzRy2cD3vvjoKGkOhRDLyFxxTJ
	 LU8R9aXuLbF0ZW6yXpuP27BDiTMScL83UBENDYVJWs2iTZmU3kEjZ9hTXNKBzkQQXz
	 P+0fM0wBk+u7ccv3v7Lg6UVmTd62LoVdhF/sDaOMk6LRGFEcJcrZjszVHUCSTDxjSx
	 mxclfEl0rYnvFitzXsIb9Az/7KMD0P9tqpLu/KeCylsr9lJnde8f7BlEhs2wnR1KHt
	 m8a7Aj0nZ74fD69Ldsr5a8XMrV1sVMIVC8XfvDCFwCTYu27qFOOt82qWMd2JmE7TF2
	 iwhywdsoC8Rpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3EEA60712;
	Tue, 29 Sep 2026 00:22:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A09A061
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8EDDD60724
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xoY5Kw6AnbDN for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:22:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 98B2D6071E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790641320;
 b=p5mIu5L9bcC4qoP77HUjhFuc0rlHBMY3jeyGlyW057tnlER/PQJTZmnYBeIL2lyZzvTj
 DDruR536huvaj4oqA5/JSzEeN5sffwXHv/rCM0xo5nUcGndl0m/8SxvmCibkavWSfTnsr
 E1aXvdKkdc2ayykbdgRhvGgVve+TzsIZvuIM15rw2Nypi2NoiJqBSx0yFpXmidKwm1dG8
 FdIYNHgxuj3Wmmwafr3Fhn3uqJ+UpnLVlmxYhFa6M7zPEj9Y+Ke0pBZR1bJ0hceZGf0KK
 QosOKm4ETsTtlRPLEIQU5dwLSeiMqxz1wrRtUWUYHd0FacwzbtmGMXW9VqcFqxxW8Ww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790641320;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=ZDMBZDfiI79K3tkhJ6zTbAfX/M2+byG2aE+HNlJoqkY=;
 b=PpIUdyO40mlUXc2AQI8ec+4BAnQ1fmPc1Vbz2h/sibnNNEZrd7BenCeYIcB6oYX96vhE
 qlgWrt5zDSPgpwpBUgHc6XOJVQQ5Bc/x83WBW5Gkztcxpp/Zm8z1HindKTUA4hChbp9cT
 OHUuZCoKlSVUrfGucuElsjp3G2imANjENnX8tbiAE2kqPXoDtdN9BBAqGmPTtIesjRigs
 eQU5EfJG0KJo5qmRwy/c1Y/lg+8wfRt9cVaQeu2rremA/OLWJEQRLrnzezGtoaWHGiNZH
 IkYDlSZRfkfU77PyQvY/b8MmAwzEAnqLBNIwomYkNdfBGqNmCHhhex4H0qqgKV/kRkA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LnGDNWlY; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::11; helo=mail-oa2-x11.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=LnGDNWlY
Received: from mail-oa2-x11.google.com (mail-oa2-x11.google.com
 [IPv6:2607:f8b0:4864:30::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 98B2D6071E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:00 +0000 (UTC)
Received: by mail-oa2-x11.google.com with SMTP id
 586e51a60fabf-466ccdd7695so1451587fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790641319; x=1791246119;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZDMBZDfiI79K3tkhJ6zTbAfX/M2+byG2aE+HNlJoqkY=;
 b=LnGDNWlYXunxBEIvP3WDqWJCR5RDpdTSR1kwfa/axJuLNS6CFhwyNQhHRpbCyH7zSU
 fzN1xeUe0kyF8eWmzG8Iw7RqNF68LaJQmipL2l9TH0EiF56caGqvNbd0vsqpjt6mf3G1
 WNy5dSFGvqMWaDrBV83smac+6wBZJnHmUms3l/1Bhai1UjzgRzlOUvEh5Y4y8H/t3okS
 ZXcsr1CkQoOBt4AX6ItsXmeI+kY34UaEZCRW/V1kJbzh1lphx8Q6jaGPg8cN3Gcx4u8w
 Hu4Ln3k72oNiIdbwB4PXwIl6sKuX67s5wsI71bD3FC3Zpsylami2Wixat8tFvCw3pyJr
 tHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641319; x=1791246119;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZDMBZDfiI79K3tkhJ6zTbAfX/M2+byG2aE+HNlJoqkY=;
 b=qK6TRMn0czvAZOTK9ZGWD8Bu09c8OuhE16d93I5v0bw2jAob/valRfnmdK9d9E5al+
 o9G9hSQpASXMRnoR9F4SqM9UOu7buZAVUBWRcQ/O8Wscv8c+fMXCmY53xnzz9HNvcA/E
 LxghS4Zlzn9Cn64mvNqQgBmBHllcRxVCTZ4Nk8fy0SfYsouDkRTkeYeTglHlS2BLXcZE
 pAMbyviXWd9SEwJCeV+4CWoE9qUJ1PETye3S+ypwFPDqaJS31dYlkpgcB27AE3KhhZhd
 fT5NUbBflTCLwHq/IdjogJ+2B3sjsUSS7oIO9vafb4zfilkRoA86HibRZQXfcJoeNL3L
 L7qA==
X-Gm-Message-State: AFuF++l4GT5ibZhFpxjuQ0eqQ9nXmgOKQUWJDrEXfRYvjTpSLinNXQIV
 TO6a6Cg3eB2vH9tRQiIYyCv5q11/bOv1pJhZzU5Zq2zSWLm4V4HPZuyv
X-Gm-Gg: AYBFou1FbZFEx0uPyh3YWxXY0XiKZvNRZvGJLciYWA1dElpriHw/nzZlg9XdvdYa4Bc
 aVdQfn9O48Ww/ILiHmWn7x1THJBy/JfQMOH0cyL8wwu0ua1OZmLnDco58x46CL2JLSx3whHEPSw
 HjdEk9NeGtdshbbgwFmL7kK6Qhy5RexgLJJ7EiTjvVCXfFU3FWyyQAErSOmi7IU7dwd6RP5twDo
 8HLw+r9vi+tiF9A9tlyK5+P1Z6GvXoe7BTDvKZ1RFkMR6v0ugsVCn+JTf0uGLtDqDODSIKruq+m
 6Qw3xO4/7ZWL/hCHb/rYiu6vidd9oZ8Zw9TvUwEYQMtJVe1OJwa2bC8Q7X1TYajCHWG6RVhUs3w
 ucyeUbWSP9sJYHQidcPMFh5s3xBuSahiqy1hHl6IiBKqsnTrwRNdy9tJA7faMXtu9KqXwx977F/
 MUcAo+kfrEiDz1YnOJkrRI8cz9INzbFXMG8fFt2iGLFZKaNW1/xJmK18H/BgFJzJ1XB0faHgek4
 n3sRaGR4HsUak8AAqKL57KJKqGLB4Kb09RFhBYTd8i2qzkaGTWBO7k3flgdYNasRWrgQtRdZF90
 DEsNDpl8mOr/8NfUgis5ou7yYISlcwkNnC8QSJxZ1tov4s2gX6voWDXW1w9A2yVYCOAyYxqId4I
 OJ4UheTCzShUDnlo24YSd
X-Received: by 2002:a05:6870:d610:b0:48f:e21c:cd72 with SMTP id
 586e51a60fabf-491e7c87135mr13006131fac.57.1790641319206; 
 Mon, 28 Sep 2026 17:21:59 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-494877590e5sm8175688fac.13.2026.09.28.17.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:21:58 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 28 Sep 2026 18:21:42 -0600
Subject: [PATCH 05/20] net: lwip: add a hook before accepting DHCP
 acknowledgements
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-lwip-dhcp-v1-v1-5-2060c7365b0c@gmail.com>
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

The per-option hook runs before the rest of a reply has been validated
and cannot reject malformed application options. Add a hook after
parsing a matching ACK in a state which accepts it, before applying the
lease. This lets a client validate and stage additional boot metadata
without publishing options from an incomplete or rejected packet.

Document pbuf ownership and the need to wait for a bound lease before
publishing the saved configuration. The default hook leaves existing
users unchanged.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 lib/lwip/lwip/src/core/ipv4/dhcp.c   |  9 +++++++++
 lib/lwip/lwip/src/include/lwip/opt.h | 24 ++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/lib/lwip/lwip/src/core/ipv4/dhcp.c b/lib/lwip/lwip/src/core/ipv4/dhcp.c
index bfc6cfe488e..d416286c957 100644
--- a/lib/lwip/lwip/src/core/ipv4/dhcp.c
+++ b/lib/lwip/lwip/src/core/ipv4/dhcp.c
@@ -92,6 +92,9 @@
 #ifndef LWIP_HOOK_DHCP_PARSE_OPTION
 #define LWIP_HOOK_DHCP_PARSE_OPTION(netif, dhcp, state, msg, msg_type, option, len, pbuf, offset) do { LWIP_UNUSED_ARG(msg); } while(0)
 #endif
+#ifndef LWIP_HOOK_DHCP_HANDLE_ACK
+#define LWIP_HOOK_DHCP_HANDLE_ACK(netif, dhcp, pbuf) ERR_OK
+#endif
 
 /** DHCP_ADD_EXTRA_REQUEST_OPTIONS: Additional options added to the list of options
  * that the client requests from the servers (opt 55: DHCP_OPTION_PARAMETER_REQUEST_LIST)
@@ -1852,6 +1855,9 @@ dhcp_recv(void *arg, struct udp_pcb *pcb, struct pbuf *p, const ip_addr_t *addr,
     /* in requesting state or just reconnected to the network? */
     if ((dhcp->state == DHCP_STATE_REQUESTING) ||
         (dhcp->state == DHCP_STATE_REBOOTING)) {
+      if (LWIP_HOOK_DHCP_HANDLE_ACK(netif, dhcp, p) != ERR_OK) {
+        goto free_pbuf_and_return;
+      }
       dhcp_handle_ack(netif, msg_in);
 #if LWIP_DHCP_DOES_ACD_CHECK
       if ((netif->flags & NETIF_FLAG_ETHARP) != 0) {
@@ -1869,6 +1875,9 @@ dhcp_recv(void *arg, struct udp_pcb *pcb, struct pbuf *p, const ip_addr_t *addr,
     /* already bound to the given lease address and using it? */
     else if ((dhcp->state == DHCP_STATE_REBINDING) ||
              (dhcp->state == DHCP_STATE_RENEWING)) {
+      if (LWIP_HOOK_DHCP_HANDLE_ACK(netif, dhcp, p) != ERR_OK) {
+        goto free_pbuf_and_return;
+      }
       dhcp_handle_ack(netif, msg_in);
       dhcp_bind(netif);
     }
diff --git a/lib/lwip/lwip/src/include/lwip/opt.h b/lib/lwip/lwip/src/include/lwip/opt.h
index c27dd0349d3..ca315bbdf0f 100644
--- a/lib/lwip/lwip/src/include/lwip/opt.h
+++ b/lib/lwip/lwip/src/include/lwip/opt.h
@@ -3193,6 +3193,30 @@
 #define LWIP_HOOK_DHCP_PARSE_OPTION(netif, dhcp, state, msg, msg_type, option, len, pbuf, offset)
 #endif
 
+/**
+ * LWIP_HOOK_DHCP_HANDLE_ACK(netif, dhcp, pbuf):
+ * Called after parsing a matching DHCPACK in a state that accepts it, before
+ * applying the lease. Unlike LWIP_HOOK_DHCP_PARSE_OPTION, this hook sees the
+ * complete reply after the built-in option parser has succeeded. Applications
+ * can validate and save additional options without retaining partial results
+ * from a rejected packet.
+ * Signature:\code{.c}
+ *   err_t my_hook(struct netif *netif, struct dhcp *dhcp, struct pbuf *pbuf);
+ * \endcode
+ * Arguments:
+ * - netif: receiving interface
+ * - dhcp: DHCP client on that interface
+ * - pbuf: complete DHCP reply; the payload starts at the DHCP header
+ *
+ * Return ERR_OK to accept the ACK, or another error to discard it. The hook
+ * must not modify or free the pbuf and must copy any data it needs later.
+ * Address-conflict detection, if enabled, can still reject the offered address;
+ * do not publish saved configuration until the client has bound the lease.
+ */
+#ifdef __DOXYGEN__
+#define LWIP_HOOK_DHCP_HANDLE_ACK(netif, dhcp, pbuf)
+#endif
+
 /**
  * LWIP_HOOK_DHCP6_APPEND_OPTIONS(netif, dhcp6, state, msg, msg_type, options_len_ptr, max_len):
  * Called from various dhcp6 functions when sending a DHCP6 message.

-- 
2.53.0

