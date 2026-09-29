Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA86CA5FAB
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6F5C403D8;
	Tue, 29 Sep 2026 00:22:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zN9-ok_DWqBu; Tue, 29 Sep 2026 00:22:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D277340587
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790641345;
	b=pOMogg3+pkbtvANsKh6Zwn/57zeB5BqFo2dtcpiDVONHMxdDux2gtLuynq60cGjhKnoa
	 KaA+c36EbQPn0ELxRDmqu+TinUsqdWSNsLEdOZo4VV+nAaZkWlkyADRpwMXYgBbYgrQ+2
	 Mn0pFeH24pyNaeRjwX04FteOnPqX76onIkH/ZxVD1jVjT1AUt03Mh719+Yd2fW57+kk9X
	 EgHSbyZO+sV9hbJSFda1e5t92yzAAm1v6khFvS0HlN1krkODynOMZp6Wlu7K9GPGLkOEh
	 I1SiNPolPJA8JhjxQ4f+0Dzdh/6fXIG+c9Bsocll338CziPr8BRj/9aOwspPVDS+LWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790641345;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/yBw8UEUDOHH6XbnV5wXoiFaTPB0NzZ/9fIqFVdseVQ=;
	b=Sjtr9Qs/WMrGEBfL+ZveMlaaXupY9ht5/KoBp/NOFUA2g41CSppyBcbHdd3rlH823ldJ
	 8o69UvYlIv4UnU1avXbyrZ5b15n4tvnjYA7Qzdy5EHoYhWyrH+/J9jejnfyqaOUFoJYjh
	 beXigqw+oUj8MddMJnIuoDlPaFOnWXPho9trnDG79+cWZes3WS8ATn3apuKB0+HmmOIrX
	 BSaPik+Ax+5uoYxEHJHCdKuzFKUlaEjkh60x/Ej1ZDj6aYWew5EVX1VVwt0uz1aSwD1C/
	 gKJ0Kj9dsol0tjo+usV4PhQcn5cNmPHqKZdit59x1aw3rryEkN/2r+l7KPiGQOQsUQA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790641344;
	bh=/yBw8UEUDOHH6XbnV5wXoiFaTPB0NzZ/9fIqFVdseVQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HPnavzKK7FA6yTG5dowJz+XCNlZ2UDYoUsOBkv2wDR3fdQhBVp8ZZRNVj1hqnpGdZ
	 nF5DULZKYOnW4R35YtRK6SmsFo98xlD2atcGRrVyEV5FbCc9ebCFn8j9hNxqHhYWGB
	 7aZckyBBYqj/+yM8uDqozTU84YauonFBXLBF3eHcbP3x4NEwSA2jEBWRMdSTQy2P20
	 AZQQ4vaDXO29fPeNd6k9SEpYJmVgvMwDTK/0tQW1Vqt5x2fZlLRPFXf3b0gQ0ccIsa
	 PKjc4a+J/qtXZFHuc1FsXuCdRqjFVCVzat6pBQwz4AsZB+P+UMdlBRUmVO9nflDFWT
	 xMTn2x5P+CEcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D277340587;
	Tue, 29 Sep 2026 00:22:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B8AB417
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5181A4024D
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UqNYz7NPYy1o for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:22:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8D2F140247
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790641336;
 b=BUMKlVs30cH6k1phF4ah/A4+HxmrxViUqF9a4Gg6Brw87MuaiS5wUsD4MMGCYmChNIK0
 4Ct3mth0bv8xDH/b5qwvTfDUiIg3arTd9SUcKzC5S+SQVSGzcakOhHkqWOHD4kxCJi/qm
 /iiMSb+2+gUtKWsYmhsIQHryalVmbGCjF4BdCH2fifYCaqVRYGbmVtsds59e5HXVr1xIW
 14YmckbSJP1vNgP4b/aZWb0gI0hsvA0nDKyNtFgc7O5yhiP3QkkJeWxgPuEX64QRtZN23
 JGvF7IheqKhekklD2bFq3tmOZxJ8/cKcEpOEUNcgp5AyI9A/EmDgrcYacH5qLe0z1XA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790641336;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=/yBw8UEUDOHH6XbnV5wXoiFaTPB0NzZ/9fIqFVdseVQ=;
 b=dlmZVmng1gd+6f6Bf3mTlK9N8TRTVD3aost/AGBQ5Ng+VDbQlPsmH2CJsmsZb6EA02JC
 XVctBvRMhZqHCi1BF2ea4EZiDQFabEdyPkAKjtGiHcgjWWCtZ8oKdy0gjYEqmd9xACp3X
 RS5l9f+XoQFVFHyDyaCEadH/rwc0/dxn6rRYCdyKEiShOhrfIvsrN/QbBTqsKMUhXLGgN
 rn2GSzKensV1XQ9unS4r7I9USt0UtmcTskdterujO9AtjxFYxjjnKMZ/fcDGOERPPLZco
 NHwQQ3KriGO++wWOXCjT8TlmxpEcWskSICHUhJ5DGihGc+UwdFL5uzf9Gos69UfX3lQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=M8O+bfbS; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::e;
 helo=mail-oi2-x0e.google.com; envelope-from=james.hilliard1@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=M8O+bfbS
Received: from mail-oi2-x0e.google.com (mail-oi2-x0e.google.com
 [IPv6:2607:f8b0:4864:32::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8D2F140247
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:16 +0000 (UTC)
Received: by mail-oi2-x0e.google.com with SMTP id
 5614622812f47-4e8e5c8d0ffso926485b6e.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790641335; x=1791246135;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/yBw8UEUDOHH6XbnV5wXoiFaTPB0NzZ/9fIqFVdseVQ=;
 b=M8O+bfbSKLxbh0UU+dfpxeBsuDfUPBV4yRzCI8LGpSrXUGA5phAqmIndrYSTctuBSi
 SDDkqvLnfb4nwiwxv8bEjiSzy6cxCUNEHY53yTOwMvvT26nkpJMRV2eplpEhWDUyaoB5
 8o1zxRQiKHFeyBCuucv2O0VbEF39TYzoun3sQVv+g/Th7o3mTgIHup2JyZlqUUG37p/i
 wQCyR7us4CRSyrF2DXnG6nmGO7HUkWplGFqJY4Ry7IEZbEXqrns2YKjLUwOaWi3FACTu
 WaWLYQ/aidlO4rAVgoTMi37NObG1qWmrC3P09ALWiXn5qhS6kOqp0QMKiH6RaEIu31KK
 shUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641335; x=1791246135;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/yBw8UEUDOHH6XbnV5wXoiFaTPB0NzZ/9fIqFVdseVQ=;
 b=wHzQjPefv24HTJhwuYxZBt6TkIgYqJgtO6wYxlbuAtLy1vpFwQTcgLQ+E4/jv2VzjQ
 dVVj5pJDY7tg7dP0moiTrj8GZWgIu1cK59tGyDP59AbgcgkOqoET7RSb/pw5NJsL19NQ
 PIdx2ClVxxovhXXGntuMT+Zst6BUxQxDC+Ux/Mq1fKIWCIHNai6gm3ZCKJWQZv1Xn8ij
 PUKziYtrTYcson/zYYm1J0ml0aFPAvTnGJ/0pOkF+w+anPp7iKSC5f4zyYKu1FRYJwPm
 qbqc9OAyumhHpiMnVnxw0Pi71withQKnmYBxBaB4jm7ODb/xUJivqhiNPOYuuYfzyRVt
 TMRw==
X-Gm-Message-State: AFuF++nfxOjMgWEZC9MHlpaHaG1czz5QvmxR4yJi/eduk43b6qF7BKfg
 LP3AHF5HcYa3lmhj6eC56GLvHfNtaMIwfqy63ny8bHsYeSGmkWhlNouR
X-Gm-Gg: AYBFou24+PJI7Qmdm1nEEDt+CnZvZXF04BYtFXWBBxH1Bl0hm7rFslyIGhSrPPVb80i
 Tjtmw5stN6l1nGyh858yUhUh5ytE2dr5dUvQdEMxYXbrpi29CR2I8tYC/bcrcVvN9oWu6g4aR2w
 c9ELud+aw4au51PsbKfyieSfASc/mklhedfK/ugSMcQMmc6gOo9mzfFbS0C1BCwU86QFnQzIuWd
 ijf9OW2gax59pPS5ZBSwm99A6O4REfO4m4Bk2KiGTpmslOeRu/3ssZnsk5ozi2zNLcxAIlzX/Nb
 aiJlTfkVdR+Bc4cqMFlQHBC6x3gxXIToWrZw/kWRDpRkaQUnQ//JvATekJCvWgTjQKRv8/Vy7Si
 +mfM9Nvf1L3xN64vg9JmzM4prnlDn0QWpMqzojQHgTqL6ZWGlm/7Rfl+tTfcEMJ/1ehGhNziyE1
 ydgzVGCAEFQN/JnQyazPUjlHLZEzsC6SD4ik4LFnBwGJPrIOR2m9yZIxidceJyKlYLsTKGVD7pe
 fRUI8EJjJS0EG9jWbYh73A4WpN1PCkgySD+58JJ6caaOSWtJN5P9H8Pf8gKcAR1mExN9A0Guc9t
 hhHGyrgZLCL9WAHb/AEESkTxKQdWT7dvkj7BOldE20KLx07wa9/l9zJ3niadH9lKw82hYO4OzP6
 /L7Q/NpXTslOHj1I1JGH5
X-Received: by 2002:a05:6808:4f11:b0:4e9:69e9:59c3 with SMTP id
 5614622812f47-4e969e95b04mr5664955b6e.67.1790641335022; 
 Mon, 28 Sep 2026 17:22:15 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-494877590e5sm8175688fac.13.2026.09.28.17.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:22:14 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 28 Sep 2026 18:21:50 -0600
Subject: [PATCH 13/20] net: lwip: add a hook before parsing DHCP replies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-lwip-dhcp-v1-v1-13-2060c7365b0c@gmail.com>
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

Provide an optional receive hook after the hardware address and
transaction ID have matched, but before parsing updates option state
and the boot filename. A client can then consume a ProxyDHCP reply
without selecting its zero yiaddr as a lease or disturbing an already
bound lease.

Leave the pbuf lifetime with the core and preserve the default behavior
when no hook is installed. Document that the hook must validate any
options it consumes.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 lib/lwip/lwip/src/core/ipv4/dhcp.c   |  8 ++++++++
 lib/lwip/lwip/src/include/lwip/opt.h | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/lib/lwip/lwip/src/core/ipv4/dhcp.c b/lib/lwip/lwip/src/core/ipv4/dhcp.c
index 387f8f8660f..260c743f5db 100644
--- a/lib/lwip/lwip/src/core/ipv4/dhcp.c
+++ b/lib/lwip/lwip/src/core/ipv4/dhcp.c
@@ -95,6 +95,9 @@
 #ifndef LWIP_HOOK_DHCP_HANDLE_ACK
 #define LWIP_HOOK_DHCP_HANDLE_ACK(netif, dhcp, pbuf) ERR_OK
 #endif
+#ifndef LWIP_HOOK_DHCP_RECV
+#define LWIP_HOOK_DHCP_RECV(netif, dhcp, pbuf) ERR_OK
+#endif
 
 /** DHCP_ADD_EXTRA_REQUEST_OPTIONS: Additional options added to the list of options
  * that the client requests from the servers (opt 55: DHCP_OPTION_PARAMETER_REQUEST_LIST)
@@ -1838,6 +1841,11 @@ dhcp_recv(void *arg, struct udp_pcb *pcb, struct pbuf *p, const ip_addr_t *addr,
                 ("transaction id mismatch reply_msg->xid(%"X32_F")!=dhcp->xid(%"X32_F")\n", lwip_ntohl(reply_msg->xid), dhcp->xid));
     goto free_pbuf_and_return;
   }
+  /* Let applications consume replies which do not supply a lease, before
+     parsing can replace the current DHCP boot filename or option state. */
+  if (LWIP_HOOK_DHCP_RECV(netif, dhcp, p) != ERR_OK) {
+    goto free_pbuf_and_return;
+  }
   /* option fields could be unfold? */
   if (dhcp_parse_reply(p, dhcp) != ERR_OK) {
     LWIP_DEBUGF(DHCP_DEBUG | LWIP_DBG_TRACE | LWIP_DBG_LEVEL_SERIOUS,
diff --git a/lib/lwip/lwip/src/include/lwip/opt.h b/lib/lwip/lwip/src/include/lwip/opt.h
index ca315bbdf0f..3645f78db14 100644
--- a/lib/lwip/lwip/src/include/lwip/opt.h
+++ b/lib/lwip/lwip/src/include/lwip/opt.h
@@ -3193,6 +3193,28 @@
 #define LWIP_HOOK_DHCP_PARSE_OPTION(netif, dhcp, state, msg, msg_type, option, len, pbuf, offset)
 #endif
 
+/**
+ * LWIP_HOOK_DHCP_RECV(netif, dhcp, pbuf):
+ * Called for a reply matching this client's hardware address and transaction
+ * ID, before parsing DHCP options or changing the client's lease state. This
+ * permits applications to consume ProxyDHCP replies without treating them as
+ * offers of a zero address. The hook must validate any options it consumes.
+ * Signature:\code{.c}
+ *   err_t my_hook(struct netif *netif, struct dhcp *dhcp, struct pbuf *pbuf);
+ * \endcode
+ * Arguments:
+ * - netif: receiving interface
+ * - dhcp: DHCP client on that interface
+ * - pbuf: complete DHCP reply, starting at the DHCP header
+ *
+ * Return ERR_OK to continue normal DHCP processing, or any other value to
+ * consume/discard the reply. Do not modify or free the pbuf. Copy any data
+ * needed after returning. The default hook leaves all replies to DHCP.
+ */
+#ifdef __DOXYGEN__
+#define LWIP_HOOK_DHCP_RECV(netif, dhcp, pbuf)
+#endif
+
 /**
  * LWIP_HOOK_DHCP_HANDLE_ACK(netif, dhcp, pbuf):
  * Called after parsing a matching DHCPACK in a state that accepts it, before

-- 
2.53.0

