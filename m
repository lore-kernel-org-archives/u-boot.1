Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822F3CD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 17:47:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D150F8394E;
	Mon,  4 May 2026 19:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="m8SHVuMX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PM8CfVhQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9224383FEC; Mon,  4 May 2026 19:47:14 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1CD280F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 19:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4g8TcF0nRqz9v0d;
 Mon,  4 May 2026 19:47:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777916829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KgIO9aHEF8cBZ5Ebh2VtyYFv7bSfwKuIXPEch5j3Zog=;
 b=m8SHVuMXwATkttd28S8nTokZbbGa0fDZxgSwLWli0IjRh8qNt09RjFlZdiaDgM+LLuKSiU
 D3yQGdO7/oB/ALNNC2JvI9lL9CuvXcd4WvtkL9zU98PN62ZNQxT+q8tT46wHRObvnL47ct
 mdvrj6Qr+0hUeEc2ppcmSCu7k66E1RhT9WheGiICcGauQxkpYQ/kvR0+6D01FJweIBeMOs
 aKdrtHAB/68wIdszxOLB7XmByGiOo3s9+ivzJ61reNUknVtMpqYI4/m3WMzCD7RvFjt0KC
 gpf3CyNlb2t5B3CTQ/8nCbR/JdH+k9I7010z0AvRIGVZmzga8K7Ej6Jj++6bRQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777916826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KgIO9aHEF8cBZ5Ebh2VtyYFv7bSfwKuIXPEch5j3Zog=;
 b=PM8CfVhQMhn/8hHFK3g6BW72NSVVIAewpM66RlqsKbh9pzHj+hUJ1m32PtQhTIAGWYnQ28
 UxT0lDGO6HOq70IQUD4FflTAccVa/bIBbrHLb6TzK6McAeOlhFkYjVK13mG3Msjm3FMLTj
 fZGflSvkhA0wkIKER38Mt/1qSwf9ASeS/9rMMRF5G4/0+/d+NmZ1ceoWEc7lQbxy9fpz9s
 5rui5NMNpuQ3fzJ3O0YWP0mwX5uhcUmFry4bTlzKaW/xGVJvhKZFfKfVXiS/siYVlYyoFx
 BxXV+aSE2U9CcLyJi5wRoOsYm3f/0GUd6NNAGOhpp7E+XBV/uDLDNBPVX7zTpg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: renesas: Switch all R-Car systems to LWIP based network
 stack
Date: Mon,  4 May 2026 19:46:28 +0200
Message-ID: <20260504174655.57530-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ijo891qmm4hnwhzkeeqqksqciz7ntn6b
X-MBO-RS-ID: f67b440a024afb8f71c
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

Switch all Renesas R-Car systems to LWIP based network stack. This
is the modern replacement for legacy U-Boot network stack, and is
now functionaly on par with U-Boot network stack, with additional
useful functionality like HTTPS support, and generally better
throughput.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
---
 configs/renesas_rcar.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/renesas_rcar.config b/configs/renesas_rcar.config
index a93cb2e9f13..fb9c2304656 100644
--- a/configs/renesas_rcar.config
+++ b/configs/renesas_rcar.config
@@ -24,6 +24,7 @@ CONFIG_HUSH_PARSER=y
 # CONFIG_HUSH_OLD_PARSER is not set
 CONFIG_HUSH_MODERN_PARSER=y
 CONFIG_MTD=y
+CONFIG_NET_LWIP=y
 CONFIG_OF_CONTROL=y
 CONFIG_PROT_TCP_SACK=y
 CONFIG_RCAR_GPIO=y
-- 
2.53.0

