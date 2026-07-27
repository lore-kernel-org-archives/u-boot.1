Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BE9C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 17:00:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15B8580E93;
	Mon, 27 Jul 2026 17:00:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YounSMDxpVWJ; Mon, 27 Jul 2026 17:00:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 73EAE80E85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785171634;
	bh=d7SWb6myWpMg2+Ry3CazB2nbpQGxC7OnlQmNvGeAjmw=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=bDZQlTqyOUxwN/3mwFYoaJ1T57WbRU4fLTcPsDP56hrEYfL7EDtDDmQORg9jkV/Yx
	 3n2u6hqNFTsd24cNVsjsG8aELB95k0Fckj+MW8efngFoEPgIfksvBW4+Qxlr1Lf5Rv
	 r48RJ/MJx1T4MZMakv6BU3i7Ar2GYD/GFuehUcbbfCk0Gx/GBjzBzPZXkLiltga3zW
	 mX1O9m1WXouDa9Q8Lm+k8OvvAEK9cJAks8zSWV4hQIqrjETc16eT8jHmmo5FTVEwDh
	 b4P9f7Pr4Q3iE5lvGVzeax4+B03DJhxwQ0G2VnQnA806eefHoHKpaS8DNp0thYnZmz
	 D2lwyyA6OxmhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73EAE80E85;
	Mon, 27 Jul 2026 17:00:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 335112E5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:00:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1162D80E82
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:00:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RfnFR2rqgDz2 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 17:00:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.121;
 helo=smtp-relay-canonical-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B2FA280E59
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B2FA280E59
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B2FA280E59
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:00:30 +0000 (UTC)
Received: from LT2ubnt (dynamic-176-006-021-161.176.6.pool.telefonica.de
 [176.6.21.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 13EBD40373; 
 Mon, 27 Jul 2026 17:00:28 +0000 (UTC)
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Denis Mukhin <dmukhin@ford.com>,
 u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] sandbox: fix enum host_platform_flags description
Date: Mon, 27 Jul 2026 19:00:22 +0200
Message-ID: <20260727170022.13258-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1785171628;
 bh=d7SWb6myWpMg2+Ry3CazB2nbpQGxC7OnlQmNvGeAjmw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=hE1yhO/w2GJBAmCFWOEIYvag+ksl1iV8EtIUofEDHh9+AVkxLN/+6xgAiE0JLPfzW
 e/RoLX+hIp1h1DiQ6Vl0mai1ZK31VkFfaAxmNWL3FFrLj0irqMXnJhE6OogGbZlAR6
 N3U9D+bcj43jTwkXsHR5VJnNGTGLywOON4VlHEITzFIA/XYByaiflRCYfVu2LTcEF4
 jDlnw0aQ27fmixUjuqOuXRlzvblfEVkYx69kEBWVvZgY8/kBWcRPdSmgWx69DUd3y9
 o+w/zZRIlcxJlRH02wSsUed6IOrZC2qqExjXMC0rJfo+RLHtEDMACAETMYVbB+1vIA
 uy0Xv8ARWfbBPrPnJDctnE/lZpQpvcRbBtdXlY0cBHG6N91ICquX75rQhGArMIFn2D
 HO32PMRXc85isiYyVpUWSZXzh+4JXxHavBowuxeNmyxd8N2UD94twjjQMNOioBSOWx
 Y9hj1gx5v1n96ou+kJFH1gF+UkdvviYTOJ5GveVbT8Pfe3/S+K0efIEoXrVPyMquis
 3V3liZlgcCeOjqKqeGd7KLmTFdUQCp8db0piTJl8cs7GA5Der8zFE1wdKXDF8eRn2g
 KU3/pE9DNPk7nIU8RCw1CK+q9Bk8BcCTe5f5ymjuPZ30hpgHnxDJbJTO/THvG7ObSr
 irfXzHdKGIoU6wScmFbCkMsE=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=hE1yhO/w
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
From: Heinrich Schuchardt via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

`make htmldocs` reports

    ./include/sandbox_host.h:14: warning:
    cannot understand function prototype: 'enum host_platform_flags '

Align the description with Sphinx style.

Fixes: 93e9af685fef ("test: bootdev: scan with a broken high-priority device")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/sandbox_host.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/sandbox_host.h b/include/sandbox_host.h
index 1330358ef7a..8329cbba537 100644
--- a/include/sandbox_host.h
+++ b/include/sandbox_host.h
@@ -9,10 +9,12 @@
 #define __SANDBOX_HOST__
 
 /**
- * Device flags.
+ * enum host_platform_flags - device flags
+ *
  */
 enum host_platform_flags {
-	HOST_FLAG_BROKEN		= BIT(0), /** Simulate broken device */
+	/** @HOST_FLAG_BROKEN:	simulate boken device */
+	HOST_FLAG_BROKEN		= BIT(0),
 };
 
 /**
-- 
2.53.0

