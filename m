Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8443ACA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2FC1560788;
	Tue, 29 Sep 2026 00:22:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p5cKSmNToJz4; Tue, 29 Sep 2026 00:22:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 377E960774
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790641348;
	b=s5iooxjaiEO9TD6YJ6TrpmLyQxr6Du+t9Z7dJ1v9waGTHMsWLOWMCKZ4CdVzWpkmcp3J
	 fp5jyZkG3DcPg6BjE2oZMaOhSKAkhzUW4T4v6Cze1W8RE1UNJoArWU5bmg4b14HOqi6FC
	 FCR6i1dbiWgdM6oOCROkytOjcV/LFpgCyLIRMRBmaS2POWd1ud1Sd58Dlmg07FoNxJidz
	 SYusdTCg2OcKRLV7biKZ5IrYGmNDKIVvOjWSYxU04nL1HzSh10OkcDMZf44/Ux7Vv58pt
	 sQpJvf3qN+iwTtPe8GDPGdQrP5sQ+01itmaQTUZM+67wqS2TB8hJ2wMPMRkWS6MDswg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790641348;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=TH/DXz9gnW1xnRdSbC15vW1MrhLqit17A0RJrgp+gvw=;
	b=K0GO53HJa+9nStN6J2yu2zWUBFzf0lNBQhyUpogQzBxdbE4II5k9fGeXn9qOpPgvVK7l
	 dvcNUhnDhXRpDDIhp7g0E3pzxqocIf6XUwnGpLavbF47dI04icHno43NbZmO7AQSJDULV
	 QTond6/U+jNv1N73SYC02g0w8mKAUymmsWLVjH/6eXWad84y+qgsTIN9BY4A6D0p2JMSZ
	 KDCHhAmSbVIeVRJz9SIM/551Q8ZsoIa+oRBFSqU9bPvVkxppIuNRFi6RT22UKAR35Zx23
	 mQEEDCMYwpzuM3UoBcYjhwi58/tsKezRSvJPQYy9dWbDO/wttWTNzW/iTpQ6woV6W9Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790641348;
	bh=TH/DXz9gnW1xnRdSbC15vW1MrhLqit17A0RJrgp+gvw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zB1SpG9zBE/+Drq+smWlJZSxQSMQR4KJ+YacLfbyoS433yzJiof9rYivjgzx6AEA1
	 ZvqDDARTjfrh2jn22EOIP3OXNhFBxxju6bisvU91j9EHPs1h+RnMq6AC0NFydMYDpx
	 PiTDtnzc5/mse71UWHWojgXvaENLDFsRz0fy1Kn4Jqj5C6fpKAQx2bxZztc/e4kH1h
	 66wmWaRgmkzvmPeAxm2xFMOQUNV6T91b5F4n9Djz3aZi/t/t/yVzs+xFUkvGCZyC10
	 YKNkBbgfhd7/ViVRwqeQsSHJd1sdtzDEFSC+SoMs/F39PaP+jYgNEkuudak317HudT
	 oMvQrhflGw8cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 377E960774;
	Tue, 29 Sep 2026 00:22:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B92A932F
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9EEB74024D
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m-t3oNrYM0mA for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:22:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7F4DD40247
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790641340;
 b=YnhBpn0yl7bJhfykDZGQ1B4itja4bL9ThcF78gcvYf4veimH4kaN0Bumsoi//h8H4BZb
 4G5RXWa5IhNi/WOSISwpUEYsf7jIOZh52G//ClB3Z44AngVt41EHESo4PjcaVVuRHkJUm
 K7ivqctlajwODEToSVMT+znpAA0evJbHLxsD7rq+YwKxwbDPscd3iIc4TErVQD4o3mnRW
 qXAwSOBlOhoVF813XICCub+EsOrSg1LPdBx/3Ini3TyACUFCmDkERZ402SFZPrWvKcvt1
 /5QaFnLfLJXUpvchXSnnh6xGbQB7PPkUMwSZhvV2zV695dtM1xLL4X4YCysO71rt5xA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790641340;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=TH/DXz9gnW1xnRdSbC15vW1MrhLqit17A0RJrgp+gvw=;
 b=rUS58bmx5vNtFvgjx2+rxy8p64dunnVHflAJJaulLlMw2Pedxk5XEnPuWdhee/2JPEFs
 qcipa+/CPnHP3naAqsKNLjXjGrbAXK4sOEoLPhJyRdMMkqFSRx2lvLXvEYk2UMRrbXiXG
 YzZrdbQozPawJqzX294jzh1cSwmhPMWBSCHzbcuzMiTP5/wlOLbDV+X+ttDHljHt3KCkN
 Vkeeja9y41VTQxGQDO+4a2DBv9iK5DzQi4Q+bKbR9gQo7Ac8V/THSXUBRJhUAe+PjJCsM
 kuS8u9ZHSoSpqsSc3t76h36spl2YOZ9P3HpMzkFaT/8Gn4x8iVGo8pqRv193dMgoRIQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="N8u+/sFb"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::f;
 helo=mail-oa2-x0f.google.com; envelope-from=james.hilliard1@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=N8u+/sFb
Received: from mail-oa2-x0f.google.com (mail-oa2-x0f.google.com
 [IPv6:2607:f8b0:4864:30::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F4DD40247
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:19 +0000 (UTC)
Received: by mail-oa2-x0f.google.com with SMTP id
 586e51a60fabf-49172f18b40so2151556fac.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790641339; x=1791246139;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TH/DXz9gnW1xnRdSbC15vW1MrhLqit17A0RJrgp+gvw=;
 b=N8u+/sFbpeYObU/K+k+FnU4LYeEX6T5dLiqRB5E5DgNHlxK/oUQk9yX53p/2+5Kfmy
 dYZEp57YsEBz2ZY869Q3SmLq/VGMJzFwOtiya7o0MSGW2B6R86GJOm50c/LIXmWhL2Sf
 1it3MPxIKX7cxZgyxjFpe1E5L6xzk+LXv7C01MIFHrPT+uwI9PecyD0DFf8XDxr7pWUx
 rXfXMlWOYKiT6zmygo+YCVixTYESNzzBg/cVYGXzi0w7JUZk5h3YduNvjeSLCzduLpIO
 yNS1wUYnYVmMInGJAMF59mD7or7UKkt31EOUlektxrAmOg52nWQSMW4utAWQBKFMbPQr
 RYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641339; x=1791246139;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TH/DXz9gnW1xnRdSbC15vW1MrhLqit17A0RJrgp+gvw=;
 b=s4wJbtHr7b2yM4g7pk3z5WWmfn0Wgp9RNnIBJGSBVMDlgCRSAmkr5eO4RBBkMYWDvW
 vu8YVZppLDZdqAatydC2VTGbMbvnCUJ54a2164vIqnRysk3UHOXJUf9o9YYu5MpJJRgH
 l3/EPHhzBDDyzjOuUjGbULYSFxjOQsAic7sen44Cf1wd3Ai4o+RYPS3ICh7sjo53vFrC
 g1cfn96yt+9tRrSZkJ7MQGePvf5juXFhhuNv0W/xDsbXvyVgUh7gC4gUMvowIkK1vMnw
 P9R54TODXoZ0UhSIaTZ6N1//D4idM/tb1B46H158RP7bfi/5Yq310mwg3ukA32oHoedf
 T01g==
X-Gm-Message-State: AFq9FYIEyHXX2X+wTr+z6oNyqXhv2lY/9jJDb9+I0STrEtPH8dePBOae
 dx3WRofnBNEWT2G3LzXUlfoExmGblTRUjAmXtN8ZW6c4xdI1vTXESeAE
X-Gm-Gg: AYBFou2gA/bMS7laWViVMRJaTZ2d/fQUhJsBekDK6v1U43tVN/r9nG+c3w0F25AcnZI
 8yoVjyi8k6V+f+tzQBs1plfxsaPnl13JTCS86x/YDa7FDeLb/II6EjUE/m6Yj4t4uJi1EoZRNMV
 VVd0mhzd7eJ7IzFQd9+gKMmuA7vbSPswraB56pGMprvehE566VfEUnsHe8zqE8pKu+1CwE+Hr6L
 UHGdhIG17jbPrvM/Q0PaY6QI3vpPy+H9zm0VGtlVnKOcrttsFG8/iGbrCe/yR2mwTedNrDF99uW
 rizuMnqakeCmSGEcqc9IjiQUlY3RSK4AtorJFdrRFFnY5uhjNYX+oAkek/0yrycrSzO8XVmVON8
 GMBclf47zwtYsnMgXohReAMzavdd0yE5U9orMg4i6rYdz8178CmWu/uKhV4Bv95HCPqIgcjMlh/
 U/Ci4Ku9SRG88+8vXI/GmBUNUWaj8YfgrjaSUD8LTGBfjLPRMP2IDjoHALNfYSl8jAAod3XV1ua
 +gH2oPNQxtV0YVc0XfJKJZoPlNBbV2E8E4ezCFtdLqhoX4MASvbRqs2ZhuWHCtgCtil/tEcwXmq
 IbqcqE4IbEQvhrR0y/QF4LFD8m1WycmdDWIIFQTI2roMAthjBic3mL8b62HU+XrBvIZwr8MBDjG
 S7jYhCvYzAMd/uxpRfOlO
X-Received: by 2002:a05:6871:acd9:b0:494:396:1205 with SMTP id
 586e51a60fabf-49403a67d91mr7181220fac.14.1790641338944; 
 Mon, 28 Sep 2026 17:22:18 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-494877590e5sm8175688fac.13.2026.09.28.17.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:22:18 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 28 Sep 2026 18:21:52 -0600
Subject: [PATCH 15/20] net: lwip: retain boot metadata from the selected
 DHCP offer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-lwip-dhcp-v1-v1-15-2060c7365b0c@gmail.com>
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

Keep transaction-local defaults from the offer selected by the core,
and overlay the accepted ACK without publishing either candidate early.
Validate offers after the core parser and before selection; ignore
later offers. Require the ACK to carry its own message type and
selected server identifier.

Reset defaults on a new discovery, let explicit ACK values override
them, and discard an offered file size when the ACK replaces the
filename without a size. Keep the EFI cache as the unmodified wire ACK.
Cover missing options, rejected ACKs, late offers, replacement and
subsequent transactions.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 lib/lwip/lwip/src/core/ipv4/dhcp.c   |  6 ++++
 lib/lwip/lwip/src/include/lwip/opt.h | 21 +++++++++++
 lib/lwip/u-boot/lwip-dhcp.h          |  2 ++
 net/lwip/dhcp.c                      | 48 ++++++++++++++++++++++---
 test/dm/lwip_dhcp_options.c          | 68 ++++++++++++++++++++++++++++++++++--
 5 files changed, 138 insertions(+), 7 deletions(-)

diff --git a/lib/lwip/lwip/src/core/ipv4/dhcp.c b/lib/lwip/lwip/src/core/ipv4/dhcp.c
index 260c743f5db..c25bb3b4fc5 100644
--- a/lib/lwip/lwip/src/core/ipv4/dhcp.c
+++ b/lib/lwip/lwip/src/core/ipv4/dhcp.c
@@ -98,6 +98,9 @@
 #ifndef LWIP_HOOK_DHCP_RECV
 #define LWIP_HOOK_DHCP_RECV(netif, dhcp, pbuf) ERR_OK
 #endif
+#ifndef LWIP_HOOK_DHCP_HANDLE_OFFER
+#define LWIP_HOOK_DHCP_HANDLE_OFFER(netif, dhcp, pbuf) ERR_OK
+#endif
 
 /** DHCP_ADD_EXTRA_REQUEST_OPTIONS: Additional options added to the list of options
  * that the client requests from the servers (opt 55: DHCP_OPTION_PARAMETER_REQUEST_LIST)
@@ -1906,6 +1909,9 @@ dhcp_recv(void *arg, struct udp_pcb *pcb, struct pbuf *p, const ip_addr_t *addr,
   /* received a DHCP_OFFER in DHCP_STATE_SELECTING state? */
   else if ((msg_type == DHCP_OFFER) && (dhcp->state == DHCP_STATE_SELECTING)) {
     LWIP_DEBUGF(DHCP_DEBUG | LWIP_DBG_TRACE, ("DHCP_OFFER received in DHCP_STATE_SELECTING state\n"));
+    if (LWIP_HOOK_DHCP_HANDLE_OFFER(netif, dhcp, p) != ERR_OK) {
+      goto free_pbuf_and_return;
+    }
     /* remember offered lease */
     dhcp_handle_offer(netif, msg_in);
   }
diff --git a/lib/lwip/lwip/src/include/lwip/opt.h b/lib/lwip/lwip/src/include/lwip/opt.h
index 3645f78db14..013cd76355c 100644
--- a/lib/lwip/lwip/src/include/lwip/opt.h
+++ b/lib/lwip/lwip/src/include/lwip/opt.h
@@ -3215,6 +3215,27 @@
 #define LWIP_HOOK_DHCP_RECV(netif, dhcp, pbuf)
 #endif
 
+/**
+ * LWIP_HOOK_DHCP_HANDLE_OFFER(netif, dhcp, pbuf):
+ * Called after successfully parsing a matching DHCPOFFER while selecting,
+ * before accepting the offer and sending DHCPREQUEST.
+ * Signature:\code{.c}
+ *   err_t my_hook(struct netif *netif, struct dhcp *dhcp, struct pbuf *pbuf);
+ * \endcode
+ * Arguments:
+ * - netif: receiving interface
+ * - dhcp: DHCP client on that interface
+ * - pbuf: complete DHCP reply; the payload starts at the DHCP header
+ *
+ * Return ERR_OK to accept the offer, or another error to discard it. Do not
+ * modify or free the pbuf. Copy any metadata needed later, and do not publish
+ * it until an ACK is accepted and the client has bound the lease. Forget
+ * saved defaults when starting another discovery transaction.
+ */
+#ifdef __DOXYGEN__
+#define LWIP_HOOK_DHCP_HANDLE_OFFER(netif, dhcp, pbuf)
+#endif
+
 /**
  * LWIP_HOOK_DHCP_HANDLE_ACK(netif, dhcp, pbuf):
  * Called after parsing a matching DHCPACK in a state that accepts it, before
diff --git a/lib/lwip/u-boot/lwip-dhcp.h b/lib/lwip/u-boot/lwip-dhcp.h
index 03f8a6a2a14..16be8b6a09b 100644
--- a/lib/lwip/u-boot/lwip-dhcp.h
+++ b/lib/lwip/u-boot/lwip-dhcp.h
@@ -15,11 +15,13 @@ u32_t net_lwip_dhcp_timeout(u8_t tries);
 #define DHCP_REQUEST_BACKOFF_SEQUENCE net_lwip_dhcp_timeout
 
 err_t net_lwip_dhcp_ack(struct netif *netif, struct dhcp *dhcp, struct pbuf *p);
+err_t net_lwip_dhcp_offer(struct netif *netif, struct dhcp *dhcp, struct pbuf *p);
 err_t net_lwip_dhcp_recv(struct netif *netif, struct dhcp *dhcp, struct pbuf *p);
 void net_lwip_dhcp_append(struct netif *netif, struct dhcp *dhcp, u8_t state,
 			  struct dhcp_msg *msg, u8_t type, u16_t *len);
 
 #define LWIP_HOOK_DHCP_HANDLE_ACK net_lwip_dhcp_ack
+#define LWIP_HOOK_DHCP_HANDLE_OFFER net_lwip_dhcp_offer
 #define LWIP_HOOK_DHCP_RECV net_lwip_dhcp_recv
 #define LWIP_HOOK_DHCP_APPEND_OPTIONS net_lwip_dhcp_append
 
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index b223261ff23..98f6864144b 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -60,6 +60,8 @@ struct dhcp_options {
 	u16 discover_secs;
 	struct dhcp_boot_data reply;
 	struct dhcp_boot_data candidate;
+	struct dhcp_boot_data offer;
+	bool have_offer;
 	struct dhcp_boot_data proxy;
 	ip4_addr_t proxy_server;
 	u32 proxy_xid;
@@ -238,11 +240,15 @@ static err_t dhcp_parse_boot_data(struct pbuf *p, struct dhcp_boot_data *data,
 		{ 60, proxy, true, data->vendor, sizeof(data->vendor) - 1 },
 		{ 6, IS_ENABLED(CONFIG_BOOTP_DNS), false, data->dns, sizeof(data->dns) },
 	};
+	bool have_filename = false, have_file_size = false;
 	u8 overload = 0;
 	u32 cookie;
 	size_t i;
 	int ret;
 
+	/* A fallback offer cannot supply the ACK's type or server identity. */
+	data->type = 0;
+	ip4_addr_set_zero(&data->server);
 	if (pbuf_copy_partial(p, &cookie, sizeof(cookie), DHCP_MSG_LEN) != sizeof(cookie) ||
 	    ntohl(cookie) != DHCP_MAGIC_COOKIE)
 		return ERR_VAL;
@@ -262,6 +268,8 @@ static err_t dhcp_parse_boot_data(struct pbuf *p, struct dhcp_boot_data *data,
 
 		if (!opt->len)
 			continue;
+		if (opt->code == 67)
+			have_filename = true;
 		if (opt->string) {
 			/* RFC 2132 allows trailing NULs, not an embedded terminator. */
 			while (opt->len && !str[opt->len - 1])
@@ -280,19 +288,44 @@ static err_t dhcp_parse_boot_data(struct pbuf *p, struct dhcp_boot_data *data,
 		} else {
 			if (opt->len != opt->size)
 				return ERR_VAL;
-			if (opt->code == 13)
+			if (opt->code == 13) {
 				data->have_size = true;
-			else if (opt->code == 2)
+				have_file_size = true;
+			} else if (opt->code == 2) {
 				data->have_offset = true;
+			}
 		}
 	}
-	if (!(overload & DHCP_OVERLOAD_FILE) && !data->bootfile[0]) {
+	if (!(overload & DHCP_OVERLOAD_FILE) && !have_filename &&
+	    pbuf_get_at(p, DHCP_FILE_OFS)) {
 		size_t len = min_t(size_t, DHCP_FILE_LEN, sizeof(data->bootfile) - 1);
 
 		if (pbuf_copy_partial(p, data->bootfile, len, DHCP_FILE_OFS) != len)
 			return ERR_VAL;
 		data->bootfile[len] = 0;
+		have_filename = true;
 	}
+	/* An offered size must not describe a replacement filename in the ACK. */
+	if (!have_file_size && have_filename)
+		data->have_size = false;
+
+	return ERR_OK;
+}
+
+err_t net_lwip_dhcp_offer(struct netif *netif, struct dhcp *dhcp, struct pbuf *p)
+{
+	struct dhcp_options *options = active_options;
+	struct dhcp_boot_data *data;
+
+	if (!options || options->netif != netif)
+		return ERR_OK;
+	options->have_offer = false;
+	data = &options->offer;
+	memset(data, 0, sizeof(*data));
+	if (dhcp_parse_boot_data(p, data, false) || data->type != DHCP_OFFER ||
+	    ip4_addr_isany(&data->server))
+		return ERR_VAL;
+	options->have_offer = true;
 
 	return ERR_OK;
 }
@@ -373,7 +406,11 @@ err_t net_lwip_dhcp_ack(struct netif *netif, struct dhcp *dhcp, struct pbuf *p)
 		return ERR_OK;
 	/* A rejected renewal must leave the accepted lease metadata intact. */
 	data = &active_options->candidate;
-	memset(data, 0, sizeof(*data));
+	if (active_options->have_offer && dhcp->state == DHCP_STATE_REQUESTING &&
+	    ip4_addr_cmp(&active_options->offer.server, ip_2_ip4(&dhcp->server_ip_addr)))
+		*data = active_options->offer;
+	else
+		memset(data, 0, sizeof(*data));
 	ret = dhcp_parse_boot_data(p, data, false);
 	if (ret)
 		return ret;
@@ -421,8 +458,9 @@ void net_lwip_dhcp_append(struct netif *netif, struct dhcp *dhcp, u8_t state,
 	if (!active_options || active_options->netif != netif ||
 	    (type != DHCP_DISCOVER && type != DHCP_REQUEST))
 		return;
-	if (type == DHCP_DISCOVER && options->proxy_xid != dhcp->xid) {
+	if (type == DHCP_DISCOVER && (!dhcp->tries || options->proxy_xid != dhcp->xid)) {
 		options->have_proxy = false;
+		options->have_offer = false;
 		options->proxy_xid = dhcp->xid;
 	}
 	if (type == DHCP_DISCOVER)
diff --git a/test/dm/lwip_dhcp_options.c b/test/dm/lwip_dhcp_options.c
index 5fdeae6b2f0..ede51bc1116 100644
--- a/test/dm/lwip_dhcp_options.c
+++ b/test/dm/lwip_dhcp_options.c
@@ -35,6 +35,9 @@ enum dhcp_reply_kind {
 
 struct dhcp_options_test {
 	enum dhcp_reply_kind kind;
+	bool offer_metadata;
+	bool extra_offer;
+	unsigned int replacement;
 	unsigned int discover;
 	unsigned int request;
 	bool requested[256];
@@ -213,6 +216,16 @@ static int dhcp_options_reply(struct udevice *dev, struct dhcp_msg *request,
 			pos = dhcp_test_option(pos, 209, "x", 1);
 		}
 	}
+	if (type == DHCP_ACK && test->replacement) {
+		if (test->replacement <= 2)
+			pos = dhcp_test_option(pos, 67, "replacement.bin", 15);
+		else
+			strcpy((char *)reply->file, "replacement.bin");
+		if (test->replacement & 1)
+			pos = dhcp_test_option(pos, 13, size, sizeof(size));
+		else
+			pos = dhcp_test_option(pos, 2, offset, sizeof(offset));
+	}
 	/* Exercise custom options before the message-type option. */
 	pos = dhcp_test_option(pos, DHCP_OPTION_MESSAGE_TYPE, &type, 1);
 	if (kind == DHCP_REPLY_TRUNCATED) {
@@ -310,14 +323,20 @@ static int dhcp_options_tx(struct udevice *dev, void *packet, unsigned int len)
 		test->discover_secs = ntohs(msg->secs);
 		/* REQUEST must retain the DISCOVER value despite this delay. */
 		timer_test_add_offset(1200);
-		/* An offer must not publish its metadata when the ACK omits it. */
-		return dhcp_options_reply(dev, msg, DHCP_OFFER, DHCP_REPLY_BASIC);
+		return dhcp_options_reply(dev, msg, DHCP_OFFER,
+					  test->offer_metadata ? DHCP_REPLY_BASIC :
+					  DHCP_REPLY_EMPTY);
 	}
 	if (type != DHCP_REQUEST)
 		return 0;
 	test->request++;
 	memcpy(test->request_file, msg->file, sizeof(test->request_file));
 	test->request_secs = ntohs(msg->secs);
+	if (test->extra_offer) {
+		ret = dhcp_options_reply(dev, msg, DHCP_OFFER, DHCP_REPLY_BASIC);
+		if (ret)
+			return ret;
+	}
 	ret = dhcp_options_reply(dev, msg, DHCP_ACK, test->kind);
 	if (!ret && test->kind >= DHCP_REPLY_BAD_STRING &&
 	    test->kind != DHCP_REPLY_ZERO_OFFSET)
@@ -408,6 +427,23 @@ static int dhcp_options_check(struct unit_test_state *uts, struct dhcp_options_t
 	ut_assertok(env_set("bootp_arch", "1234"));
 	ut_assertok(env_set("pxeuuid", "00112233-4455-6677-8899-aabbccddeeff"));
 	ut_assertok(dhcp_server_check(uts, test));
+	/*
+	 * Size belongs to the replacement filename, independently of option 2.
+	 * Cover both option 67 and the fixed BOOTP file field in the ACK.
+	 */
+	for (kind = 1; kind <= 4; kind++) {
+		*test = (struct dhcp_options_test){
+			.kind = DHCP_REPLY_EMPTY,
+			.offer_metadata = true,
+			.replacement = kind,
+		};
+		ut_assertok(do_dhcp(NULL, 0, 1, argv));
+		ut_asserteq_str("replacement.bin", env_get("bootfile"));
+		ut_asserteq((kind & 1) && IS_ENABLED(CONFIG_BOOTP_BOOTFILESIZE) ? 42 : 0,
+			    net_boot_file_expected_size_in_blocks);
+		ut_assert(!test->chain_failed);
+		ut_assertok(dhcp_cache_check(uts, test));
+	}
 	for (kind = DHCP_REPLY_BASIC; kind <= DHCP_REPLY_BAD_DNS; kind++) {
 		bool supplied = kind == DHCP_REPLY_BASIC || kind == DHCP_REPLY_OVERLOAD;
 		bool have_ntp = IS_ENABLED(CONFIG_BOOTP_NTPSERVER) && supplied;
@@ -503,6 +539,34 @@ static int dhcp_options_check(struct unit_test_state *uts, struct dhcp_options_t
 		ut_asserteq(kind == DHCP_REPLY_BASIC && IS_ENABLED(CONFIG_BOOTP_BOOTFILESIZE) ?
 			   42 : 0, net_boot_file_expected_size_in_blocks);
 	}
+	/*
+	 * Only the selected offer supplies defaults; rejected ACKs cannot poison
+	 * them, and neither late offers nor a previous exchange are inherited.
+	 */
+	*test = (struct dhcp_options_test){ .kind = DHCP_REPLY_BAD_STRING,
+		.offer_metadata = true };
+	ut_assertok(do_dhcp(NULL, 0, 1, argv));
+	ut_assertok(dhcp_cache_check(uts, test));
+	ut_asserteq_str("option.bin", env_get("bootfile"));
+	if (IS_ENABLED(CONFIG_BOOTP_BOOTPATH))
+		ut_asserteq_str("/srv/root", env_get("rootpath"));
+	ut_asserteq(IS_ENABLED(CONFIG_BOOTP_BOOTFILESIZE) ? 42 : 0,
+		    net_boot_file_expected_size_in_blocks);
+	*test = (struct dhcp_options_test){ .kind = DHCP_REPLY_OVERLOAD,
+		.offer_metadata = true };
+	ut_assertok(do_dhcp(NULL, 0, 1, argv));
+	ut_asserteq_str("subdir/overloaded.bin", env_get("bootfile"));
+	if (IS_ENABLED(CONFIG_BOOTP_BOOTPATH))
+		ut_asserteq_str("/srv/root/fs", env_get("rootpath"));
+	ut_asserteq(0, net_boot_file_expected_size_in_blocks);
+	*test = (struct dhcp_options_test){ .kind = DHCP_REPLY_EMPTY, .extra_offer = true };
+	ut_assertok(env_set("bootfile", "default.bin"));
+	ut_assertok(env_set("rootpath", "/original"));
+	ut_assertok(do_dhcp(NULL, 0, 1, argv));
+	ut_asserteq_str("default.bin", env_get("bootfile"));
+	ut_asserteq_str("/original", env_get("rootpath"));
+	ut_asserteq(0, net_boot_file_expected_size_in_blocks);
+	ut_assertnull(pxelinux_configfile);
 	*test = (struct dhcp_options_test){ .kind = DHCP_REPLY_BASIC };
 	ut_assertok(do_dhcp(NULL, 0, 3, argv));
 	ut_asserteq_str("explicit.bin", env_get("bootfile"));

-- 
2.53.0

