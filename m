Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F38E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 10:53:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE1D88021A;
	Thu, 19 Dec 2024 11:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EXwzoWDt";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SsRpfkIh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC1FF8021D; Thu, 19 Dec 2024 11:53:21 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B58B801F5
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 11:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YDS7y169Qz9t27;
 Thu, 19 Dec 2024 11:53:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734605598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UBXiJMSC8esk/OP2AXTfL9f4JTE0zo5UVIOQdwMSB8c=;
 b=EXwzoWDtP/D81XofxozT7wt9iPt3Uz5WW7ATPNF9uImcL7wW5nvOI6eBzGmCjGOWTEQXL5
 fPy2wLyRjN7fu7pgKDHrnuFi/CctdVv/kjicbbohsizri+gUlvit0lZR8Zj7gbRlpkk6Lj
 bg/eBnQv0axsWnF5RJqLWnTVNqhWAOGWD+ekPp2EtyGQGzxmp3bfULQVA26POmzCPEj69z
 K+D0f47FbrPSvuI1COcP4BL1zEqKe1mtcLt3XyNJJanKowGHjP/5MWlCZV54cZeTlnHlgm
 7AzsXdC7VcD/M5RQUiG/WsYxeQBTBXKgx9RtZDp2oY6xRFcw/3jhPO7IzGfF3A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734605596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UBXiJMSC8esk/OP2AXTfL9f4JTE0zo5UVIOQdwMSB8c=;
 b=SsRpfkIhhe7o2UQB4FafEci/VpbyaS16I/5usDI/pu7JyIBtySHuV7fj0hMzUqWI3+r8LL
 34auUMI9IRlzT/5VdeJ4owtnrTEC3gNVo4oCUnW/v3I1Y5JaBFKXY3aCqFUbjXswOF4gAD
 dLkJFm+OBtIW41WodsqzFpAdZMfhLyuO2xYOe/s8IORIbRKSfR9OCoAbb34CsO3n0vB3/M
 MCwo/IHWWU4j5KyoMZoN1JV58KKpDPQG3fsFrZox6JLlqJlMVMALYMXhu/HacThrXsAjzK
 7GmIMyfjng++wplpgSiz1Qy82zh2ULQlhISA+XtXdL7fOslI2RjXoSjkZU+Gow==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: rswitch: Add missing cache invalidate of TX descriptor
Date: Thu, 19 Dec 2024 11:52:46 +0100
Message-ID: <20241219105303.6938-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9hjr6y57fsndanpy4hbt83sru8gf4i8g
X-MBO-RS-ID: 6d7554730600fb8a1c5
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

TFTP transfers of large files, for example 128 MiB, can sporadically
get stuck and the transfer slows down considerably.

This happens because the TX DMA descriptor in DRAM becomes out of sync
with the view of the TX DMA descriptor content from the CPU side, which
is viewed through the CPU caches. In order to guarantee these two views
are consistent, the cache over TX DMA descriptor that has possibly been
written by the rswitch hardware must first be invalidated, only then can
the descriptor be cleared and updated by the CPU, and finally the cache
over that area must be flushed back into DRAM to make sure the rswitch
hardware has consistent view of the updated descriptor content.

The very first invalidation operation was missing, which led to sporadic
corruption of the TX DMA descriptor. Fix it, add the missing invalidation
operation.

Reported-by: Enric Balletbo i Serra <eballetb@redhat.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/rswitch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index 91e2c7b7845..259d584ac98 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -836,6 +836,7 @@ static int rswitch_send(struct udevice *dev, void *packet, int len)
 
 	/* Update TX descriptor */
 	rswitch_flush_dcache((uintptr_t)packet, len);
+	rswitch_invalidate_dcache((uintptr_t)desc, sizeof(*desc));
 	memset(desc, 0x0, sizeof(*desc));
 	desc->die_dt = DT_FSINGLE;
 	desc->info_ds = len;
-- 
2.45.2

