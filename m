Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C179CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A97184BBD;
	Thu,  7 May 2026 18:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Vd0eayzU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BxlZcJW8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F281184BB3; Thu,  7 May 2026 18:42:54 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37DFA84BB7
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gBJ2j0ZcVz9t1y;
 Thu,  7 May 2026 18:42:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778172173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PSgCg4kNq1Cx99Hz9cgQDK4pbmCBupbboOz0zhyvI3k=;
 b=Vd0eayzUEzjkGa29thfOBja4wyavCzLlFXs+WdkITQ4TdlK43q46HScncGLmsKEPSAoDj8
 4WFEysowfZMKVJpj+1NNt1bX5BsJRRHO/J+MmplscaSqlb+Wsl/Ak7BIXjiOoDLQlHQ/yD
 biIMd2+sBfMMXPFwGC+pRdD0GBPgcqi++WIH83iONLvyE0oHOo19YhGqp89OqJc88Sztfv
 zTc+PbXcNl/34U+Lifx/CQ3z95J01KKmekXjopg802KhGY47kUAk5PpcpuRtPKG4Op2YU3
 nc2iQo1GBQk/7bHzoxWoRcaXgIpYDJIw94zHbCFknYuuMLlka8/zrXqJzuD4KA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778172171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PSgCg4kNq1Cx99Hz9cgQDK4pbmCBupbboOz0zhyvI3k=;
 b=BxlZcJW8YF9FzgZ7ws4LzfXUP86Z7BilJLZ0b1TApvZava8y5C6BdGhBy8C+/4CGcMXMIp
 ipNP5iUh45Y+Md2QjwDA5EhGGs5g3BViJKgktFtFmq4z6M9K6GWCUoH5WfRKkFmOHiF4og
 wg4/m7o4ZCo9FbWmDv/HQvmRspnLJ5rPe1IG7KYEdy9XcdMjQWWG4f3aerNmMnOSX3659E
 ZLQiORRZ1slhRdt0o6L1kb2jvkOeEG2iSbQZzdfTgdEuHeoe2HVt42dwVDGl9Arufn9vgk
 RLp6SBhdwEfSKNimYZnTMkpxsIBnh0kqlLrqEKu8bUT2Mw+SA93M8My6Y53Z5w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] block: rockchip: Staticize and constify driver ops
Date: Thu,  7 May 2026 18:42:40 +0200
Message-ID: <20260507164248.59353-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507164248.59353-1-marek.vasut+renesas@mailbox.org>
References: <20260507164248.59353-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: wwz1d7k6nunzeoswicacetj5pd8p6j3k
X-MBO-RS-ID: a09b4bb89e07254545b
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/block/rkmtd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rkmtd.c b/drivers/block/rkmtd.c
index f84cacd7ead..9334ab24a61 100644
--- a/drivers/block/rkmtd.c
+++ b/drivers/block/rkmtd.c
@@ -935,7 +935,7 @@ int rkmtd_detach_mtd(struct udevice *dev)
 	return 0;
 }
 
-struct rkmtd_ops rkmtd_ops = {
+static const struct rkmtd_ops rkmtd_ops = {
 	.attach_mtd	= rkmtd_attach_mtd,
 	.detach_mtd	= rkmtd_detach_mtd,
 };
-- 
2.53.0

