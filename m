Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39561CA5FAB
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03784405A7;
	Tue, 29 Sep 2026 00:22:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QeWii717qS5X; Tue, 29 Sep 2026 00:22:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3C91740400
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790641360;
	b=sFwUAtCge69F2pprWlGcDUvVHcp2AGEB1316bPVWJ8nGjDKWFmaLfD/9uLzsKXlxb6e5
	 kmB6c4MA0sPd94G9BjZU0WyqRXte9HQjUZfymGE6FC0PF9TmS11NIKhrbnkI+TAEloPoN
	 2FxgZn7hxHhemU0if8oEJovxy6WOWc1sQF9Qf0Hv5NmnUpCqv04PImc9+unk9Aryp0J56
	 APhJ4uHZnsJonTr6ZiHlqX8iK5hARih9P/wqTuAgZNM+jXfa8CYE3QlAZBqZvIuVAladM
	 DeREuoEbkzk/h4HrjaZ2saG8lmIZhG3h5rmv2V9j/fpT1uSPdH7MOGGLXe7pDKhmShA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790641360;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Ofhxjziuy2v9jQyZwnSxZTErBbl0B4ArQoDC+JnTA9Q=;
	b=MKlM0CRhaCu94HOkvewnCtBp81AsoIKz5W8+RZ/jREuoZ099JHRbhb0dIFr7PyO2enFA
	 b1icEtP19IMKFzqWKCj3/44Rbdj5jYm/XrsLs4hn9UymKaXPWCZj+QXot6KAgVTjESApQ
	 UEif/QmqSrRnMImclWV0tRDFnoYtPbFTUflEyB3KFu+QDBjDuu79wa+aIc7+3ocJlVRgJ
	 nhPk5jlzri54FKTlK/78H5V5BbGIFZx+CNfXX7uODYtdIP5U0aZRjHnvz96lDd2zPIgbH
	 Biqw7mXLz/hWr3umx0GUNKcXYjZkUvtdk94Rl4wkEODxAYzzPs1x5iG/gIjKmiIP8mg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gfeBLnX7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790641360;
	bh=Ofhxjziuy2v9jQyZwnSxZTErBbl0B4ArQoDC+JnTA9Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DwZ4CBPuHKZqrR5A8Vi4dU1pWN0/JVp+/K9x83jU3VRBZIJfy73cvAA2LeHkHTC8e
	 05X0laPAUlZ3Odi40gj/BR/MAMzRxr7o2222M747F4WICgtwMs0SBpV+BVfVYcZqTX
	 E/lUO4izd/r+FNLjBiNncPPM8RR4Ub99xXdQyhlg/fw/ZYO7QQ/TurPzLSeZWIaKJ7
	 JDgEyVfHR0xPPMftocB1RaBh6TCseMUJemjA0s1zzhS5I4GxUpfhlYk55+vvhJ5uN0
	 DceYMyrt0Xb0iUR8M/55lkwP0JjBX2JeMvRehZIliAovN23kqPCy3XdeAuHLVcE8w/
	 9djxM9Gqm1PSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C91740400;
	Tue, 29 Sep 2026 00:22:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8EB86417
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 802B5403AA
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DsW30EKyQP5B for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:22:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1DB90403A1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790641351;
 b=gxptRgPkJ/6aEsDW+r0v7/Y+SB02qDwPi9I9ntEOeEfXzBTYMFqnZlcpHnFXbsUxF9OX
 MdR2KgT+RMCUeXypzSnmWhGquZBBsRBjNVD3FApvFmqqEXmRNCB3SDAgld1v9ZgPD8O0E
 BF8aaMNzyIDIN8GZgYRC3kPdLbt7riyrZcp19emr6wAvWWRA+KBHjGwuqbpwnAffKrLp1
 kyAMAMUSnep8/+JweESlGLDtCrAQtFLGbMtBkiNpadtlJeLCnHkHWL2jpKTeAOB4QXq0t
 zjXTJu8AXdu/cP5lFJUeTpGCARiMBof0Ts8QQG6sOz/QzZWNFdftmK82BBlqv7vYjzQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790641351;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=Ofhxjziuy2v9jQyZwnSxZTErBbl0B4ArQoDC+JnTA9Q=;
 b=PQVxz+r87cv49JTSIqlHP7JokFzCyEf5QgmM2fDY283YdfzlAY6TPPj5jMZ8Kcd3vSxM
 s7IvqTlWRGFBHmsKm/mUBeI4YwhbiE8PhzNkIhYYLc+sHi3P8gRQHpjqHswilgaMEcyoY
 wdIZEjHFaKVSaElv8kwKLuU7U2d7Tjqj26AzjG7bhbwiOTfWWpL0J52/Emh46sUJxuZ5i
 M2LRewIeuQO9NY3CKQbSxCJH1Knjj/k3V0LAFYahJz0uzodUn4ajhbu0z7kdcNNT5Yqhg
 +1JS266I2xfSehspMXLUqn8x+ER8JijX9Kil0+aCpZgsVBsjbIOI8RRkzU7Hi2yBXQw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gfeBLnX7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::f;
 helo=mail-oo2-x0f.google.com; envelope-from=james.hilliard1@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=gfeBLnX7
Received: from mail-oo2-x0f.google.com (mail-oo2-x0f.google.com
 [IPv6:2607:f8b0:4864:31::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1DB90403A1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:30 +0000 (UTC)
Received: by mail-oo2-x0f.google.com with SMTP id
 006d021491bc7-6d817a94799so831241eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790641349; x=1791246149;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ofhxjziuy2v9jQyZwnSxZTErBbl0B4ArQoDC+JnTA9Q=;
 b=gfeBLnX7vl6Rj/HM3vlEAkvLnFNvnSbl61QGG2MpWhffh1Qf4+RWUQLB8Bd6qOcBDP
 VeknrVoUYAvBkpbF+TOeJql4TdNra/CPvO2PuY5ZX1MrLUc6WH3pDTxdQwAlkQxykce0
 rRyD8v0fNqc58Z7YG/1vhlVW8041BOnzywu7M2/Fv0kWiGTbXRZgLXxjXGsdUPm4pZ3P
 4BcrEcwR/5InYOBxoy2vRqXaix8WCze/7piItLhZCubmj+AJ7tldqGvZ88NQXIlDdM7q
 dWxe9N/gSU6KmMl0WUq9+jFV1SrTQ+3JKwLqxr52WFJqODDQ9ZERXPJSr9DMQ8Gcqo46
 QC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641349; x=1791246149;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ofhxjziuy2v9jQyZwnSxZTErBbl0B4ArQoDC+JnTA9Q=;
 b=C8VoZzPCotBuaicEu9N06JLDX7mT6NB7AH1Tfptpbolzr7lw8ExPiocyXv/KJ0yi0S
 yIWYljzmNBNjl+v3vJVmc43ugsQNC8eJDJQQKvdgIGLWvvqdotOEeVgn66b/Td7NA4R6
 IRpQtrkrclgoCbNY2Zs+z8V23LYUH/DH/IRzVpFC+cTY6uH3Zo3l9zmzUg+f7Is4SQS3
 hT2hVp1oCpDGG0sG3/Vi8jY0BQGSrH3/U718C1AshkDH7/gVtNuU//nKm8tM59Bhj0qc
 XXyyW9lZr2FOyuX7vBYlXmbNPLuydtDuonm9HzL8EsNsDSacWKAyhRSIb8UqdaQABp+G
 P/iw==
X-Gm-Message-State: AFuF++mBwLt4hOKqe0G8sQsmSQTpY72+qP1vtOH4yVXDQdHtyjSWaXJ0
 mL00UTdFT6S4AzhhOy14NGDxZ7FLLJJFgvIIJSOzh1A+qeCPzNPjeDyA
X-Gm-Gg: AYBFou352dqa5tuP/S5qoPXtRjw0LeQgpvMzoI8Je5VKTilRMXRlK2H76F6k+3ogBrW
 W8WjrOwovF2e80LOV3i2cOXzwJXfKFy/1J2kABTwCKOdJaRdCRH4uYU7UCPbXay+kyGy81yxRUC
 BigGhaMEdsMkxAkySCQruPfeVfY/0nhkGKsW0hGNVeJEEeYGGI8hfHxdbi961zG7M8H4iJDGQVG
 wmJkxQ7QN3xDNBcmvhQAtie03mrJeUScEf8DPP0FlQTgVnoNjsLMK+2LcIFNyCgkyU8CQxL3oQz
 oUlf4AzUievX0TCb3O9FbJkNnI+IgGOaO8KwMcRKrawZLvGVuyqdUndIAQjIZ11yYsskMZJuofr
 YvUYNZnlfzf3aDCPrnOGyoumWcPt239guuOqCgC3WGb7RLBdMhBkI8b1ySIfaPJem02fy0Y8cev
 4xA0PhaAO0mWuJLxtpHFvt9oNJjknDMSVd3g3eNxHI2ffH4vUlEWKstWmixAGuzxCpzj+cpxCZ4
 9hf3uDom059tiGixoXTtAjoCGDXN26uBjFKf2jJGHncKdHQKWE6H3KAXb31amuojPxh9GKbUGQ4
 /z631KwaaH3hDsxgEmgCVbgjqERUo2DtRb9qhn5IaaZ8RoSlEjRgUQjxzG8BcvWQiUecrR+KAMV
 g6WniaBfNu3cwyd4F9u8G
X-Received: by 2002:a05:6820:813:b0:6d9:5232:177c with SMTP id
 006d021491bc7-6d9523217d8mr4068505eaf.33.1790641349469; 
 Mon, 28 Sep 2026 17:22:29 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-494877590e5sm8175688fac.13.2026.09.28.17.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:22:28 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 28 Sep 2026 18:21:57 -0600
Subject: [PATCH 20/20] test: net: exercise lwIP standalone BOOTP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-lwip-dhcp-v1-v1-20-2060c7365b0c@gmail.com>
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

Exercise the real UDP receive path with sandbox replies, including
chained pbufs, missing boot servers, malformed replies, retransmission,
interface rotation, cancellation, an occupied client port and TFTP
handoff.

Drain the runtime test's queued ARP replies explicitly so the
BOOTP-only configuration also works without optional DHCP, DNS and HTTP
checks.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 test/dm/Makefile     |   3 +
 test/dm/lwip.c       |   2 +
 test/dm/lwip_bootp.c | 573 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 578 insertions(+)

diff --git a/test/dm/Makefile b/test/dm/Makefile
index c4f87c1d6da..26c6b732ff2 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -58,6 +58,9 @@ obj-y += lwip_dhcp_options.o
 obj-y += lwip_dhcp_proxy.o
 obj-y += lwip_dhcp_policy.o
 endif
+ifeq ($(CONFIG_NET_LWIP)$(CONFIG_CMD_BOOTP),yy)
+obj-y += lwip_bootp.o
+endif
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_NETCONSOLE),yy)
 obj-y += netconsole.o
 endif
diff --git a/test/dm/lwip.c b/test/dm/lwip.c
index 5df8ad138df..5e3d26eaccf 100644
--- a/test/dm/lwip.c
+++ b/test/dm/lwip.c
@@ -314,6 +314,8 @@ static int _dm_test_lwip_runtime(struct unit_test_state *uts,
 #if CONFIG_IS_ENABLED(WGET)
 	ut_assertok(lwip_test_http_abort(uts));
 #endif
+	/* Address changes above can queue gratuitous ARP replies in sandbox. */
+	ut_assertok(net_lwip_poll());
 
 	*pcb_a = udp_new();
 	ut_assertnonnull(*pcb_a);
diff --git a/test/dm/lwip_bootp.c b/test/dm/lwip_bootp.c
new file mode 100644
index 00000000000..3f29e2691d2
--- /dev/null
+++ b/test/dm/lwip_bootp.c
@@ -0,0 +1,573 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright 2026 James Hilliard <james.hilliard1@gmail.com> */
+
+#include <command.h>
+#include <console.h>
+#include <dm.h>
+#include <env.h>
+#include <image.h>
+#include <malloc.h>
+#include <net.h>
+#include <time.h>
+#include <asm/eth.h>
+#include <asm/unaligned.h>
+#include <dm/test.h>
+#include <lwip/apps/sntp.h>
+#include <lwip/dns.h>
+#include <lwip/prot/dhcp.h>
+#include <lwip/udp.h>
+#include <test/ut.h>
+
+enum bootp_reply_kind {
+	BOOTP_BASIC,
+	BOOTP_PLAIN,
+	BOOTP_EMPTY,
+	BOOTP_OVERLOAD,
+	BOOTP_BAD_XID,
+	BOOTP_BAD_MAC,
+	BOOTP_BAD_PORT,
+	BOOTP_BAD_OP,
+	BOOTP_BAD_HTYPE,
+	BOOTP_BAD_HLEN,
+	BOOTP_BAD_MASK,
+	BOOTP_BAD_GATEWAY,
+	BOOTP_BAD_OPTION,
+	BOOTP_BAD_STRING,
+	BOOTP_ZERO_IP,
+	BOOTP_MULTICAST_IP,
+	BOOTP_SHORT,
+	BOOTP_DHCP_OFFER,
+};
+
+struct bootp_test {
+	enum bootp_reply_kind kind;
+	unsigned int requests;
+	unsigned int bind_after;
+	unsigned int tftp;
+	u32 tftp_server;
+	u32 xid;
+	u16 secs;
+	bool unicast;
+	bool chain;
+	bool cancel;
+	bool fail_first;
+	bool bad_request;
+	bool port_busy;
+	bool transfer_fail;
+	bool no_server;
+	bool requested[256];
+	char filename[128];
+};
+
+static u8 *bootp_option(u8 *pos, u8 code, const void *value, u8 len)
+{
+	*pos++ = code;
+	*pos++ = len;
+	memcpy(pos, value, len);
+
+	return pos + len;
+}
+
+static int bootp_reply(struct udevice *dev, struct dhcp_msg *request)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct bootp_test *test = priv->priv;
+	static const u8 mask[] = { 255, 255, 255, 0 };
+	static const u8 gateways[] = { 1, 1, 2, 1, 1, 1, 2, 254 };
+	static const u8 dns[] = { 8, 8, 8, 8, 9, 9, 9, 9 };
+	static const u8 ntp[] = { 10, 0, 0, 1 };
+	static const u8 size[] = { 0, 42 };
+	struct ethernet_hdr *eth;
+	struct ip_udp_hdr *ip;
+	struct dhcp_msg *reply;
+	u8 *pos;
+	size_t len;
+
+	if (priv->recv_packets >= PKTBUFSRX)
+		return -ENOSPC;
+	eth = (void *)priv->recv_packet_buffer[priv->recv_packets];
+	memset(eth->et_dest, 0xff, ARP_HLEN);
+	if (test->unicast)
+		memcpy(eth->et_dest, request->chaddr, ARP_HLEN);
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
+	put_unaligned_be32(test->no_server ? 0 : 0x01010204, &reply->siaddr);
+	reply->cookie = htonl(DHCP_MAGIC_COOKIE);
+	strcpy((char *)reply->file, "header.bin");
+	pos = reply->options;
+	if (test->kind != BOOTP_EMPTY) {
+		pos = bootp_option(pos, 1, mask, sizeof(mask));
+		pos = bootp_option(pos, 3, gateways, sizeof(gateways));
+		pos = bootp_option(pos, 6, dns, sizeof(dns));
+		pos = bootp_option(pos, 42, ntp, sizeof(ntp));
+		pos = bootp_option(pos, 13, size, sizeof(size));
+		pos = bootp_option(pos, 12, "bootp-host", 10);
+		pos = bootp_option(pos, 17, "/srv/root", 9);
+		pos = bootp_option(pos, 67, "option.bin", 10);
+	} else {
+		reply->file[0] = 0;
+	}
+	switch (test->kind) {
+	case BOOTP_PLAIN:
+		reply->cookie = 0;
+		/* A proprietary vendor area is not parsed as RFC 1048 tags. */
+		memset(reply->options, 0xa5, 60);
+		break;
+	case BOOTP_OVERLOAD: {
+		u8 overload = DHCP_OVERLOAD_SNAME_FILE;
+		u8 *field;
+
+		pos = bootp_option(reply->options, 52, &overload, 1);
+		pos = bootp_option(pos, 17, "/srv", 4);
+		pos = bootp_option(pos, 3, gateways, 1);
+		field = bootp_option(reply->file, 17, "/root", 5);
+		field = bootp_option(field, 3, gateways + 1, 3);
+		field = bootp_option(field, 67, "overloaded.bin", 14);
+		*field = DHCP_OPTION_END;
+		field = bootp_option(reply->sname, 1, mask, sizeof(mask));
+		*field = DHCP_OPTION_END;
+		break;
+	}
+	case BOOTP_BAD_XID:
+		reply->xid ^= htonl(1);
+		break;
+	case BOOTP_BAD_MAC:
+		reply->chaddr[0] ^= 1;
+		break;
+	case BOOTP_BAD_OP:
+		reply->op = DHCP_BOOTREQUEST;
+		break;
+	case BOOTP_BAD_HTYPE:
+		reply->htype = 2;
+		break;
+	case BOOTP_BAD_HLEN:
+		reply->hlen = 0;
+		break;
+	case BOOTP_BAD_MASK:
+		pos = bootp_option(pos, 1, mask, 1);
+		break;
+	case BOOTP_BAD_GATEWAY:
+		pos = bootp_option(pos, 3, gateways, 1);
+		break;
+	case BOOTP_BAD_OPTION:
+		*pos++ = 17;
+		*pos++ = 255;
+		break;
+	case BOOTP_BAD_STRING:
+		pos = bootp_option(pos, 67, "bad\0file", 8);
+		break;
+	case BOOTP_ZERO_IP:
+		put_unaligned_be32(0, &reply->yiaddr);
+		break;
+	case BOOTP_MULTICAST_IP:
+		put_unaligned_be32(0xe0000001, &reply->yiaddr);
+		break;
+	case BOOTP_DHCP_OFFER: {
+		u8 type = DHCP_OFFER;
+
+		pos = bootp_option(pos, 53, &type, 1);
+		break;
+	}
+	default:
+		break;
+	}
+	*pos++ = DHCP_OPTION_END;
+	len = max_t(size_t, 300, pos - (u8 *)reply);
+	if (test->kind == BOOTP_SHORT)
+		len = 299;
+	ip->ip_hl_v = 0x45;
+	ip->ip_len = htons(IP_UDP_HDR_SIZE + len);
+	ip->ip_ttl = 64;
+	ip->ip_p = IPPROTO_UDP;
+	/* A relay's source must not replace the siaddr boot server. */
+	ip->ip_src.s_addr = htonl(0x01010202);
+	ip->ip_dst.s_addr = htonl(test->unicast ? 0x01010203 : 0xffffffff);
+	ip->udp_src = htons(test->kind == BOOTP_BAD_PORT ? 1234 : 67);
+	ip->udp_dst = htons(68);
+	ip->udp_len = htons(UDP_HDR_SIZE + len);
+	ip->ip_sum = compute_ip_checksum(ip, IP_HDR_SIZE);
+	len += ETHER_HDR_SIZE + IP_UDP_HDR_SIZE;
+	if (test->chain) {
+		unsigned int split = ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + DHCP_FILE_OFS + 4;
+		struct pbuf *head = pbuf_alloc(PBUF_RAW, split, PBUF_RAM);
+		struct pbuf *tail = pbuf_alloc(PBUF_RAW, len - split, PBUF_RAM);
+
+		if (!head || !tail) {
+			if (head)
+				pbuf_free(head);
+			if (tail)
+				pbuf_free(tail);
+			return -ENOMEM;
+		}
+		pbuf_take(head, eth, split);
+		pbuf_take(tail, (u8 *)eth + split, len - split);
+		pbuf_cat(head, tail);
+		return netif_default->input(head, netif_default);
+	}
+	priv->recv_packet_length[priv->recv_packets++] = len;
+
+	return 0;
+}
+
+static int bootp_tx(struct udevice *dev, void *packet, unsigned int len)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct bootp_test *test = priv->priv;
+	struct ethernet_hdr *eth = packet;
+	struct ip_udp_hdr *ip;
+	struct dhcp_msg *msg;
+	struct udp_pcb *pcb;
+	u8 *pos, *end;
+
+	if (!sandbox_eth_arp_req_to_reply(dev, packet, len))
+		return 0;
+	if (len < ETHER_HDR_SIZE + IP_UDP_HDR_SIZE || ntohs(eth->et_protlen) != PROT_IP)
+		return 0;
+	ip = (void *)(eth + 1);
+	if (ip->ip_p != IPPROTO_UDP)
+		return 0;
+	if (ntohs(ip->udp_dst) == 69) {
+		struct ethernet_hdr *reply_eth;
+		struct ip_udp_hdr *reply_ip;
+		u8 *data;
+
+		test->tftp++;
+		test->tftp_server = ntohl(ip->ip_dst.s_addr);
+		strlcpy(test->filename, (char *)(ip + 1) + 2, sizeof(test->filename));
+		for (pcb = udp_pcbs; pcb; pcb = pcb->next)
+			if (pcb->local_port == 68)
+				test->port_busy = true;
+		if (priv->recv_packets >= PKTBUFSRX)
+			return -ENOSPC;
+		reply_eth = (void *)priv->recv_packet_buffer[priv->recv_packets];
+		memcpy(reply_eth->et_dest, eth->et_src, ARP_HLEN);
+		memcpy(reply_eth->et_src, priv->fake_host_hwaddr, ARP_HLEN);
+		reply_eth->et_protlen = htons(PROT_IP);
+		reply_ip = (void *)(reply_eth + 1);
+		memset(reply_ip, 0, IP_UDP_HDR_SIZE);
+		reply_ip->ip_hl_v = 0x45;
+		reply_ip->ip_len = htons(IP_UDP_HDR_SIZE + 6);
+		reply_ip->ip_ttl = 64;
+		reply_ip->ip_p = IPPROTO_UDP;
+		reply_ip->ip_src = ip->ip_dst;
+		reply_ip->ip_dst = ip->ip_src;
+		reply_ip->udp_src = htons(1234);
+		reply_ip->udp_dst = ip->udp_src;
+		reply_ip->udp_len = htons(UDP_HDR_SIZE + 6);
+		reply_ip->ip_sum = compute_ip_checksum(reply_ip, IP_HDR_SIZE);
+		data = (void *)(reply_ip + 1);
+		put_unaligned_be16(test->transfer_fail ? 5 : 3, data);
+		put_unaligned_be16(1, data + 2);
+		data[4] = 'x';
+		data[5] = 0;
+		priv->recv_packet_length[priv->recv_packets++] =
+			ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + 6;
+		return 0;
+	}
+	if (ntohs(ip->udp_dst) != 67)
+		return 0;
+	if (len < ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + 300)
+		return -EINVAL;
+	msg = (void *)(ip + 1);
+	test->requests++;
+	if (test->requests == 1)
+		test->xid = msg->xid;
+	test->secs = ntohs(msg->secs);
+	test->bad_request |= msg->op != DHCP_BOOTREQUEST || msg->htype != 1 ||
+		msg->hlen != 6 || msg->hops || msg->flags || msg->ciaddr.addr ||
+		msg->yiaddr.addr || msg->siaddr.addr || msg->giaddr.addr ||
+		ntohs(ip->udp_src) != 68 || ip->ip_src.s_addr ||
+		ip->ip_dst.s_addr != htonl(0xffffffff) ||
+		ntohl(msg->cookie) != DHCP_MAGIC_COOKIE;
+	if (!test->fail_first)
+		test->bad_request |= test->xid != msg->xid;
+	pos = msg->options;
+	end = (u8 *)msg + ntohs(ip->udp_len) - UDP_HDR_SIZE;
+	while (pos < end && *pos != DHCP_OPTION_END) {
+		u8 code = *pos++;
+		u8 size;
+
+		if (!code)
+			continue;
+		if (pos == end || end - pos - 1 < *pos) {
+			test->bad_request = true;
+			break;
+		}
+		size = *pos++;
+		test->requested[code] = true;
+		test->bad_request |= code == 53 || code == 54 || code == 51 || code == 55;
+		pos += size;
+	}
+	if (test->cancel) {
+		console_in_puts("\x03");
+		return 0;
+	}
+	if ((test->fail_first && !dev_seq(dev)) || test->requests < test->bind_after) {
+		timer_test_add_offset(1000);
+		return 0;
+	}
+
+	return bootp_reply(dev, msg);
+}
+
+static int bootp_check(struct unit_test_state *uts, struct bootp_test *test)
+{
+	char * const argv[] = { "bootp", "2000000", "explicit.bin" };
+	struct net_lwip_ctx other = {};
+	struct udp_pcb *occupied;
+	char name[256];
+	int i, ret;
+
+	ut_assertnonnull(find_cmd("bootp"));
+	ut_assertok(env_set("ethact", "eth@10002000"));
+	ut_assertok(env_set("ethrotate", "no"));
+	ut_assertok(env_set("netretry", "no"));
+	ut_assertok(env_set("autoload", "no"));
+	ut_assertok(env_set("autostart", "no"));
+	ut_assertok(env_set("bootpretryperiod", "0"));
+	ut_assertok(env_set("bootpretransmitperiodinit", "250"));
+	ut_assertok(env_set("bootpretransmitperiodmax", "2000"));
+	ut_assertok(env_set("bootp_vci", "U-Boot"));
+	ut_assertok(env_set("tftpdstp", NULL));
+	ut_assertok(env_set("tftpsrcp", NULL));
+	for (i = BOOTP_BASIC; i <= BOOTP_OVERLOAD; i++) {
+		*test = (struct bootp_test){ .kind = i, .unicast = i & 1, .chain = i & 2 };
+		ut_assertok(env_set("bootfile", "default.bin"));
+		ut_assertok(env_set("netmask", "255.0.0.0"));
+		ut_assertok(env_set("gatewayip", "1.1.2.254"));
+		ut_assertok(env_set("serverip", NULL));
+		ut_assertok(do_bootp(NULL, 0, 1, argv));
+		ut_asserteq(1, test->requests);
+		ut_assert(!test->bad_request);
+		ut_asserteq_str("1.1.2.3", env_get("ipaddr"));
+		ut_asserteq_str(i == BOOTP_BASIC ? "option.bin" : i == BOOTP_PLAIN ?
+				"header.bin" : i == BOOTP_EMPTY ? "default.bin" :
+				"overloaded.bin", env_get("bootfile"));
+		ut_asserteq_str(i == BOOTP_PLAIN || i == BOOTP_EMPTY ? "255.0.0.0" :
+				"255.255.255.0", env_get("netmask"));
+		ut_asserteq_str(i == BOOTP_PLAIN || i == BOOTP_EMPTY ? "1.1.2.254" :
+				"1.1.2.1", env_get("gatewayip"));
+		if (!IS_ENABLED(CONFIG_BOOTP_SERVERIP))
+			ut_asserteq_str("1.1.2.4", env_get("serverip"));
+		ut_assertnull(netif_default);
+	}
+	*test = (struct bootp_test){};
+	ut_assertok(do_bootp(NULL, 0, 3, argv));
+	ut_asserteq_str("explicit.bin", env_get("bootfile"));
+	if (IS_ENABLED(CONFIG_BOOTP_BOOTPATH))
+		ut_asserteq_str("/srv/root", env_get("rootpath"));
+	if (IS_ENABLED(CONFIG_BOOTP_HOSTNAME))
+		ut_asserteq_str("bootp-host", env_get("hostname"));
+	if (IS_ENABLED(CONFIG_BOOTP_DNS))
+		ut_asserteq_str("8.8.8.8", env_get("dnsip"));
+	if (IS_ENABLED(CONFIG_BOOTP_DNS2))
+		ut_asserteq_str("9.9.9.9", env_get("dnsip2"));
+	if (IS_ENABLED(CONFIG_BOOTP_NTPSERVER))
+		ut_asserteq_str("10.0.0.1", env_get("ntpserverip"));
+	ut_asserteq(IS_ENABLED(CONFIG_BOOTP_BOOTFILESIZE) ? 42 : 0,
+		    net_boot_file_expected_size_in_blocks);
+	ut_asserteq(IS_ENABLED(CONFIG_BOOTP_BOOTPATH), test->requested[17]);
+	ut_asserteq(IS_ENABLED(CONFIG_BOOTP_SUBNETMASK), test->requested[1]);
+	ut_asserteq(IS_ENABLED(CONFIG_BOOTP_GATEWAY), test->requested[3]);
+	ut_asserteq(IS_ENABLED(CONFIG_BOOTP_DNS), test->requested[6]);
+
+	/* An omitted boot server must not create a zero-valued environment entry. */
+	for (i = BOOTP_BASIC; i <= BOOTP_PLAIN; i++) {
+		*test = (struct bootp_test){ .kind = i, .no_server = true };
+		ut_assertok(env_set("serverip", NULL));
+		ut_assertok(env_set("tftpserverip", "1.1.2.8"));
+		ut_assertok(do_bootp(NULL, 0, 1, argv));
+		ut_asserteq(1, test->requests);
+		ut_assertnull(env_get("serverip"));
+		ut_assertnull(env_get("tftpserverip"));
+		ut_assertnull(netif_default);
+	}
+
+	/* Wrong clients, malformed options and DHCP offers must publish nothing. */
+	for (i = BOOTP_BAD_XID; i <= BOOTP_DHCP_OFFER; i++) {
+		*test = (struct bootp_test){ .kind = i };
+		ut_assertok(env_set("bootfile", "kept.bin"));
+		ut_assertok(env_set("ipaddr", "10.0.0.9"));
+		ut_asserteq(CMD_RET_FAILURE, do_bootp(NULL, 0, 1, argv));
+		ut_asserteq_str("kept.bin", env_get("bootfile"));
+		ut_asserteq_str("10.0.0.9", env_get("ipaddr"));
+		ut_assertnull(netif_default);
+	}
+	/* The largest hostname and VCI must still leave room for request tags. */
+	memset(name, 'x', sizeof(name) - 1);
+	name[sizeof(name) - 1] = 0;
+	ut_assertok(env_set("bootp_vci", name));
+	ut_assertok(env_set("hostname", name));
+	*test = (struct bootp_test){};
+	ut_assertok(do_bootp(NULL, 0, 1, argv));
+	ut_assert(!test->bad_request);
+	ut_assertok(env_set("bootp_vci", "U-Boot"));
+
+	ut_assertok(env_set("bootpretryperiod", "4000"));
+	*test = (struct bootp_test){ .bind_after = 3 };
+	ut_assertok(do_bootp(NULL, 0, 1, argv));
+	ut_asserteq(3, test->requests);
+	ut_assert(test->secs >= 2);
+	ut_assert(!test->bad_request);
+	ut_assertok(env_set("bootpretryperiod", "1000"));
+	ut_assertok(env_set("netretry", "once"));
+	ut_assertok(env_set("ethrotate", NULL));
+	*test = (struct bootp_test){ .fail_first = true };
+	ut_assertok(do_bootp(NULL, 0, 1, argv));
+	ut_asserteq(2, test->requests);
+	ut_asserteq_str("eth@10003000", env_get("ethact"));
+	ut_asserteq_str("1.1.2.3", env_get("ipaddr5"));
+	ut_assertok(env_set("ethact", "eth@10002000"));
+	ut_assertok(env_set("ethrotate", "no"));
+	ut_assertok(env_set("netretry", "yes"));
+	*test = (struct bootp_test){ .cancel = true };
+	ut_asserteq(CMD_RET_FAILURE, do_bootp(NULL, 0, 1, argv));
+	clear_ctrlc();
+	ut_asserteq(1, test->requests);
+	ut_assertnull(netif_default);
+	ut_assertok(env_set("netretry", "no"));
+
+	/* An occupied port is not stolen, and a flexible runtime user survives. */
+	ut_assertok(net_lwip_start(&other, NET_LWIP_ADDR_ENV_FLEXIBLE));
+	occupied = udp_new();
+	ut_assertnonnull(occupied);
+	ret = udp_bind(occupied, IP4_ADDR_ANY, 68);
+	if (ret) {
+		udp_remove(occupied);
+		net_lwip_stop(&other);
+		return ret;
+	}
+	*test = (struct bootp_test){};
+	ret = do_bootp(NULL, 0, 1, argv);
+	i = other.netif == netif_default && occupied->local_port == 68;
+	udp_remove(occupied);
+	net_lwip_stop(&other);
+	ut_asserteq(CMD_RET_FAILURE, ret);
+	ut_assert(i);
+	ut_asserteq(0, test->requests);
+	ut_assertnull(netif_default);
+
+	ut_assertok(env_set("autoload", "yes"));
+	ut_assertok(env_set("serverip", "1.1.2.4"));
+	*test = (struct bootp_test){};
+	ut_asserteq(IS_ENABLED(CONFIG_CMD_TFTPBOOT) ? CMD_RET_SUCCESS : CMD_RET_FAILURE,
+		    do_bootp(NULL, 0, 3, argv));
+	ut_asserteq(IS_ENABLED(CONFIG_CMD_TFTPBOOT) ? 1 : 0, test->tftp);
+	ut_assert(!test->port_busy);
+	if (test->tftp)
+		ut_asserteq_str("explicit.bin", test->filename);
+	ut_assertnull(netif_default);
+	*test = (struct bootp_test){ .transfer_fail = true };
+	ut_asserteq(CMD_RET_FAILURE, do_bootp(NULL, 0, 3, argv));
+	ut_assert(!test->port_busy);
+	ut_assertnull(netif_default);
+	/*
+	 * Plain and RFC 1048 replies without siaddr retain the configured server,
+	 * but must clear stale TFTP overrides before the download handoff.
+	 */
+	for (i = BOOTP_BASIC; i <= BOOTP_PLAIN; i++) {
+		*test = (struct bootp_test){ .kind = i, .no_server = true };
+		ut_assertok(env_set("serverip", "1.1.2.9"));
+		ut_assertok(env_set("tftpserverip", "1.1.2.8"));
+		ut_asserteq(IS_ENABLED(CONFIG_CMD_TFTPBOOT) ? CMD_RET_SUCCESS : CMD_RET_FAILURE,
+			    do_bootp(NULL, 0, 3, argv));
+		ut_asserteq(1, test->requests);
+		ut_asserteq_str("1.1.2.9", env_get("serverip"));
+		ut_assertnull(env_get("tftpserverip"));
+		ut_asserteq(IS_ENABLED(CONFIG_CMD_TFTPBOOT) ? 1 : 0, test->tftp);
+		if (test->tftp) {
+			ut_asserteq(0x01010209, test->tftp_server);
+			ut_asserteq_str("explicit.bin", test->filename);
+		}
+		ut_assert(!test->port_busy);
+		ut_assertnull(netif_default);
+	}
+
+	return 0;
+}
+
+static int dm_test_lwip_bootp(struct unit_test_state *uts)
+{
+	static const char * const vars[] = {
+		"ethact", "ethrotate", "netretry", "autoload", "autostart", "bootfile",
+		"ipaddr", "netmask", "gatewayip", "ipaddr5", "netmask5", "gatewayip5",
+		"serverip", "tftpserverip", "dnsip", "dnsip2", "rootpath", "hostname",
+		"domain", "timeoffset", "ntpserverip", "bootp_vci", "tftpdstp", "tftpsrcp",
+		"fileaddr", "filesize",
+		"bootpretryperiod", "bootpretransmitperiodinit", "bootpretransmitperiodmax",
+	};
+	struct bootp_test test = {};
+	char *saved[ARRAY_SIZE(vars)] = {};
+	char file[sizeof(net_boot_file_name)];
+	char *config = pxelinux_configfile;
+	u32 size = net_boot_file_expected_size_in_blocks;
+	ip_addr_t ntp;
+	struct in_addr old_ip = net_ip;
+	ulong load_addr = image_load_addr;
+#if LWIP_DNS
+	ip_addr_t dns[DNS_MAX_SERVERS];
+#endif
+	int i, ret = -ENOMEM, ctrlc_state;
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
+	if (CONFIG_IS_ENABLED(CMD_SNTP))
+		ip_addr_copy(ntp, *sntp_getserver(0));
+#if LWIP_DNS
+	for (i = 0; i < ARRAY_SIZE(dns); i++)
+		ip_addr_copy(dns[i], *dns_getserver(i));
+#endif
+	memcpy(file, net_boot_file_name, sizeof(file));
+	pxelinux_configfile = NULL;
+	ctrlc_state = disable_ctrlc(0);
+	sandbox_eth_set_tx_handler(0, bootp_tx);
+	sandbox_eth_set_tx_handler(1, bootp_tx);
+	sandbox_eth_set_priv(0, &test);
+	sandbox_eth_set_priv(1, &test);
+	ret = bootp_check(uts, &test);
+	clear_ctrlc();
+	disable_ctrlc(ctrlc_state);
+	sandbox_eth_set_tx_handler(0, NULL);
+	sandbox_eth_set_tx_handler(1, NULL);
+	sandbox_eth_set_priv(0, NULL);
+	sandbox_eth_set_priv(1, NULL);
+	memcpy(net_boot_file_name, file, sizeof(file));
+	net_boot_file_expected_size_in_blocks = size;
+	net_ip = old_ip;
+	image_load_addr = load_addr;
+	free(pxelinux_configfile);
+	pxelinux_configfile = config;
+	if (CONFIG_IS_ENABLED(CMD_SNTP))
+		sntp_setserver(0, &ntp);
+#if LWIP_DNS
+	for (i = 0; i < ARRAY_SIZE(dns); i++)
+		dns_setserver(i, &dns[i]);
+#endif
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
+DM_TEST(dm_test_lwip_bootp, UTF_SCAN_FDT | UTF_CONSOLE);

-- 
2.53.0

