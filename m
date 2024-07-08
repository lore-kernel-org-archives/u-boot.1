Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3CFC3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 09:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D58D288580;
	Mon,  8 Jul 2024 11:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="QXJPOHXG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92ECC88599; Mon,  8 Jul 2024 11:11:30 +0200 (CEST)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 844798848D
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 11:11:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 20240708091128e573ff968d7de1a058 for <u-boot@lists.denx.de>;
 Mon, 08 Jul 2024 11:11:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=1hk3PEWZA0CUOIar63Awtd/UgY8MfQ86pTHThQ5i1jA=;
 b=QXJPOHXGh3HgoSepE06wilfBQrnfvUi4h1xS3QPNo7qPCsBUmOnz4RBGSMJYE8b+X5jpgz
 28WDQHCjLYDfQoZB2+XMIP2sUlUviElXjOrMXAPw1OzySX4oTrlk3y6on9B73LH1V2cDsa5I
 z3kJBsM9TR1wYY3yY/X8Czus8mjj0=;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH] net: remove duplicate eth_env_set_enetaddr_by_index()
 declaration
Date: Mon,  8 Jul 2024 11:09:58 +0200
Message-ID: <20240708091002.2585902-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

eth_env_set_enetaddr_by_index() declaration is duplicated in eth_internal.h
and net.h, but all units including eth_internal.h already include net.h.
Remove the superfluous declaration.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 net/eth_internal.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/net/eth_internal.h b/net/eth_internal.h
index 0b829a8d388..cb302c157b5 100644
--- a/net/eth_internal.h
+++ b/net/eth_internal.h
@@ -11,22 +11,6 @@
 /* Do init that is common to driver model and legacy networking */
 void eth_common_init(void);
 
-/**
- * eth_env_set_enetaddr_by_index() - set the MAC address environment variable
- *
- * This sets up an environment variable with the given MAC address (@enetaddr).
- * The environment variable to be set is defined by <@base_name><@index>addr.
- * If @index is 0 it is omitted. For common Ethernet this means ethaddr,
- * eth1addr, etc.
- *
- * @base_name:	Base name for variable, typically "eth"
- * @index:	Index of interface being updated (>=0)
- * @enetaddr:	Pointer to MAC address to put into the variable
- * Return: 0 if OK, other value on error
- */
-int eth_env_set_enetaddr_by_index(const char *base_name, int index,
-				 uchar *enetaddr);
-
 int eth_mac_skip(int index);
 void eth_current_changed(void);
 void eth_set_dev(struct udevice *dev);
-- 
2.45.2

