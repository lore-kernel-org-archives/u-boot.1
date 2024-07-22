Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED88C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 23:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7F2688602;
	Tue, 23 Jul 2024 01:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iuWs4gcR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="P/Z5RGr0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 376C788739; Tue, 23 Jul 2024 01:30:08 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7027288496
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 01:29:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WSc2F29kxz9sWt;
 Tue, 23 Jul 2024 01:29:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GwQGV6/4ttUzagm5bue0uRJJc7MqUz/j62dvB7qn+XY=;
 b=iuWs4gcRUoMYqacpwRf+Fl75Gq1MhvPPgsKE1ZpEo0kKwcsaxC6hLxAKX5kBecJ3DYERwQ
 odCWKoGisN7KXMt2P2mXUrf1iKx9wpQnQi5B2BmBP45t/pFvxR0zxm9M9SOP4U9rqaic4V
 TW5uwLFy952+/GT8ZyyFcpR+rbVAWpVbeoAeQnpL8RQWNILHf9Oy0hcsEhd0SevhItOedK
 rI00F6QR/lxOgnVkbjvBTtttrVfIVmOB+AC63kS6zgyxkWHFLgibst0thofjrZaQdaiu7g
 CXkdnIhaR6VlcNEuOxif0yUIn5MYadqn7wsoNgGYQJOyrfnqTMBwQCzibKqsCQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GwQGV6/4ttUzagm5bue0uRJJc7MqUz/j62dvB7qn+XY=;
 b=P/Z5RGr0CWjAQq22j/0wnpItiMQqI3VK/19bfwa3dVxjj79+3mywaJ+cO8okzVqlR4au5d
 1hzc8Z7JPYoh9lWpEorFXJl8DkjMg/V/OSMaJhy11Th647mo3mFRdliXgtaKD7qrhWVegW
 rwMYdBAW0+yE+1toMqgqmoy3uZJn/BikB5wcPdzboEN9Zg/hg0SNQsY1RcKndKg233waiW
 zhaxdLvm3CCHFpbcStOyv+wrYvTstXkaKfsK/r2W7SImLfa9Fu/4RwTnuN13PnY+nwKGI4
 f3/yi55rqhM4wNmWhM2R/Yllo+5tEch3dNIq6Wx2cjmhEJhtu8DRyQY3wHhG/A==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 10/15] include: power: Remove duplicate newlines
Date: Tue, 23 Jul 2024 01:28:29 +0200
Message-ID: <20240722232910.91249-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
References: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 35b66630e956202f1ac
X-MBO-RS-META: 7sckkqiopjpg1kwdmtntws37gsrdo5yq
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 include/power/max17042_fg.h | 1 -
 include/power/tps65910.h    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/power/max17042_fg.h b/include/power/max17042_fg.h
index ec8377d3707..e417012459d 100644
--- a/include/power/max17042_fg.h
+++ b/include/power/max17042_fg.h
@@ -43,7 +43,6 @@ enum {
 #define RCOMP0			0x0060
 #define TempCo			0x1015
 
-
 #define MAX17042_POR (1 << 1)
 
 #define MODEL_UNLOCK1		0x0059
diff --git a/include/power/tps65910.h b/include/power/tps65910.h
index ccc759acf66..645eabc2c4b 100644
--- a/include/power/tps65910.h
+++ b/include/power/tps65910.h
@@ -51,7 +51,6 @@ enum {
 #define TPS65910_REG_ST_OFF_1				(0x2)
 #define TPS65910_REG_ST_ON_LOW_POW			(0x3)
 
-
 /* VDD2 & VDD1 voltage selection register. (VDD2_OP_REG & VDD1_OP_REG) */
 #define TPS65910_OP_REG_SEL				(0x7F)
 
-- 
2.43.0

