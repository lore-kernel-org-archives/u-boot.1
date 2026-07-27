Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705EAC53209
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 18:27:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B3354078F;
	Mon, 27 Jul 2026 18:26:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k5VXGFHPCSds; Mon, 27 Jul 2026 18:26:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 926AA406D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785176817;
	bh=8NS77gKIo9mme++2UFdh+l0S9T1os1rJlNoTk7IE9Tw=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=nwJ/zWl084px7V/tEm/VQ85QIdfHomnYemSfRzaeQ85cxcD9YQ4ed+qPJDGqsChce
	 0O/7EhUVzNNOHdGi/0WKkwIkfTHLKQbzKvENUVzf91knPo4/9qnRzIwXT+IKGUkooh
	 2FEDtdSG31IAENnIdD6I/m/xGqDkqe3GhCTsLn1NqM9HsuSut3xqo9Dn7cp7lNXJSs
	 1wj4FQRpGs1L2jrRXEm6pTNSs84piOBQuJiGGOSiTkuhOH5zWPiBB9DPKsdRG6rYEx
	 UrVChpPXqGoLE4aXAsD9KMewoMksc3kLKiXzSCxphNjMc9zjL6/eZndk2GyOM6oDrk
	 ePDRYKOENzEEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 926AA406D2;
	Mon, 27 Jul 2026 18:26:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EA3764C4
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 18:26:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D061460736
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 18:26:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lIA1smRKgX4I for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 18:26:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.121;
 helo=smtp-relay-canonical-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8FBDA605B5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8FBDA605B5
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8FBDA605B5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 18:26:53 +0000 (UTC)
Received: from LT2ubnt (dynamic-176-006-021-161.176.6.pool.telefonica.de
 [176.6.21.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 18ABC3F94B; 
 Mon, 27 Jul 2026 18:26:51 +0000 (UTC)
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Denis Mukhin <dmukhin@ford.com>,
 u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] sandbox: fix enum host_platform_flags description
Date: Mon, 27 Jul 2026 20:26:49 +0200
Message-ID: <20260727182649.7766-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1785176811;
 bh=8NS77gKIo9mme++2UFdh+l0S9T1os1rJlNoTk7IE9Tw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=YmaxtR/Q9pjNcoDdCGOh4fJekZTmEWU+BuHy11sl3ZXu1yQpzx1my7Q6rwM1BHd0B
 cmxjaGmi+7JSi0gvtVaCJKt5ARiu8JBUKX9Rg6CdMvIFEC/XOBT74kL8eet2id7Xd8
 oq1Xid95hz3BgZdOfNvWHaa/g40yg7cVZHUgJ1tMT9yNaJL9UekS5WOau66b0CikAl
 rmTyx5f8drDGanDJzxoQV/WZCWuUOjOUtECyi1O9aWoUu7y04Pi0l3AY/X3CTjX+le
 QA5Ix+EJLKyvjkSIN4TTv5FjeGbyqQTiJDKMOLi+QKSVI/uZKtBxj3fenFctUhdbTs
 tv5MoSXSfJoZAMpYTxxmIA81xT2VR8tpuYWpY9s2g7tiWFcZ2xZzA/0Y1YbalAmlLr
 T8n0dvgXR6r8J9/JdM+iePa3EVZ7PbGxWKeDwo0zQq+kDiN7IKKdajej9qrWI+VH10
 0Ts73IqZi47Oqx1XC2resMgadZsk8AfcWUy/hNeN9LLeKSx3s98rxYNFEn7T6URDb/
 nGFvccWdoLlBWgNURL7XvshMxhM+Mo918FkngKnmBA+rnJDAjVMwCujw75NzMvuQjK
 1y0ecQSVn0SbVEkrrP+ktknxJCkxrb8LPvLHJILXJ2I2GsTOBEd5ajti3pjF/NTHjU
 lMH+WP2wrwqd5jzI1QwKt6iw=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=YmaxtR/Q
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
Reviewed-by: Denis Mukhin <dmukhin@ford.com>
---
v2:
	fix typo: %s/boken/broken/
---
 include/sandbox_host.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/sandbox_host.h b/include/sandbox_host.h
index 1330358ef7a..815b32487e7 100644
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
+	/** @HOST_FLAG_BROKEN:	simulate broken device */
+	HOST_FLAG_BROKEN		= BIT(0),
 };
 
 /**
-- 
2.53.0

