Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB22C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:49:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6914588CC2;
	Sat, 20 Jul 2024 14:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nKI68l6N";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="o9ZYiAea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F34488CCA; Sat, 20 Jul 2024 14:44:08 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A08188CB0
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WR5ny01xtz9snN;
 Sat, 20 Jul 2024 14:44:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SBPscsorAN17ls95izuyaxExj9oqgx3D9kL0GVSVnN0=;
 b=nKI68l6Nyt4OIf7zN/4T/MfEAb55S/kpOpxatry4fA6BELz63/CVy0J6LFwgoYoAZhkcK9
 lVr+JZm/sxHXBaeFQi88mkXRY9iSKzA9DANtOubOsFPed4AdsOwWX+yGW200AWl0VegkSD
 i2z78BWBZPRrMiss9fS55HyWoiuHezYc/wOCUbreWeNQ9nam6sJfJnHqjqkJpuKYvLnZoY
 GrWLj59E0ceEHeBgZnxNj8C1ZIWfLCMdg3DWZXAO3iGpNNGCSBdxz1oh/m2deFF/PDd4nb
 +bep3heT9tvy8vrLk5Jb5zWIJHPAQ1O5NTn+Cs238bKevjPcpU3lSPYH7aoPWA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SBPscsorAN17ls95izuyaxExj9oqgx3D9kL0GVSVnN0=;
 b=o9ZYiAeaTAw8cUK85ZJxnKQHJcna+0Nv1E4CGXPSZ6FhGiH1shTrGK3T5A0siUURpBB+Du
 QzZG3cJG5YNZWWzcsITIZ2BwIXyyRURvQpb+rgIAZK+W75aXI6+NwqeVcAoptG8mPv8nFj
 kGVhNvsRAq30b1VbWgP+PIwHUoceQqTDP+UESB70qZHKjVUhwTvZXK1fRsCRX1JrdMvvQB
 q8Oq53olcMwxmyRSJNkIS5+i3X4qYlntAWs3uL6my72tnpsaImccXVUTCSubmEMdHex5sO
 B3cCydu6p/1pbkiCdOhIaj6JrAV8Z5vMm1gP7ZgAnZGR67SlfPPu+i6Vr5BeHg==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 36/40] drivers: timer: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:41:01 +0200
Message-ID: <20240720124239.7553-36-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 545df9cf679ac1207e2
X-MBO-RS-META: fzufn4yoanpt1aop6h1t1esc3wp4ku3p
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
 drivers/timer/arc_timer.c   | 1 -
 drivers/timer/sp804_timer.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/timer/arc_timer.c b/drivers/timer/arc_timer.c
index 413bcc32f01..6ad520c10aa 100644
--- a/drivers/timer/arc_timer.c
+++ b/drivers/timer/arc_timer.c
@@ -89,7 +89,6 @@ static int arc_timer_probe(struct udevice *dev)
 	return 0;
 }
 
-
 static const struct timer_ops arc_timer_ops = {
 	.get_count = arc_timer_get_count,
 };
diff --git a/drivers/timer/sp804_timer.c b/drivers/timer/sp804_timer.c
index a254e295cbf..3e57f4b98ba 100644
--- a/drivers/timer/sp804_timer.c
+++ b/drivers/timer/sp804_timer.c
@@ -29,7 +29,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #define SP804_CTRL_TIMER_32BIT		(1U << 1)
 #define SP804_CTRL_ONESHOT		(1U << 0)
 
-
 struct sp804_timer_plat {
 	uintptr_t base;
 };
-- 
2.43.0

