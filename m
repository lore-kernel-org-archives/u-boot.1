Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B72CD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 15:14:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0CB984D31;
	Sat,  9 May 2026 17:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ciYz/Eyp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vgWjThZy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4276E84D9C; Sat,  9 May 2026 17:13:30 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B58784CEC
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 17:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gCTyb6cJFz9stw;
 Sat,  9 May 2026 17:13:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lKU9WJtH2id3PpiedchymElcUo8DR/DPDbvQmnQVs9U=;
 b=ciYz/EypAcqAgKLZzXNEomx2si8cegs4IybwOA6DLAuzTDfwh7F1tbW2Td8pfet8uR/lim
 LniUc/qBpVx8DUYPLQYggLXcBV5HIUoUzbhOl8PyBiaoOU6pT/jmcyYiyhfa4PtcsAdsH7
 US8pOvUJzfaZI0x+jssrv2h3lyES7XozPPm6rSv4VqAgymxFsOAPQVkOOdZqamRPEiCUIB
 /SXEgHC4NA7zKHUnzB6O4IMeit9rMcKDtCRkWqK45NfktMneJ+FisZeY0ECkcTM8GtSGJN
 2AKtVPjGSyu15n7rlw7NOgmYhdVdvRntPEZq56xorOzZDTX+9/BkX9lRhd67OA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=vgWjThZy;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lKU9WJtH2id3PpiedchymElcUo8DR/DPDbvQmnQVs9U=;
 b=vgWjThZyfPUFKKcWBImwhU2Pf9wYuuQy+FS3S0m1PP1x7CPDd41IKrBWm4QBvHjnenB7ju
 7dRQItGxJYUX79knN65UM8OKgNQI37UR+WuUKxAD9E7A7eZe1Yds8NpWGv4TK7+lPiBgXI
 G2iCmUF4U5a6K7kvYiAx583E7/CfAwRtvMYOfh5d6+qm39pRvT+HhZ6zhYPIEmnVwaGnEN
 kBiZAmEUZcZ6dowo9R03AcpMy2S0a40nWwVK3waVk+nOQKaw3oSVjM0f0H+znVzjAJxbWR
 LbFTU2TJMuEc9jhTzRYT6ZWYVFYB48rArdFBGI76GjOMKQ0ZrRy09Sux6bSwKg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/14] reset: sandbox: Staticize and constify driver ops
Date: Sat,  9 May 2026 17:12:34 +0200
Message-ID: <20260509151308.23067-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
References: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: u4qa3sfg6g6zugj3d6z9zc4tie5obpg5
X-MBO-RS-ID: bfc694075fbe3ce0d1b
X-Rspamd-Queue-Id: 4gCTyb6cJFz9stw
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
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/reset/sandbox-reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/sandbox-reset.c b/drivers/reset/sandbox-reset.c
index adf9eedcba6..1c0ea7390df 100644
--- a/drivers/reset/sandbox-reset.c
+++ b/drivers/reset/sandbox-reset.c
@@ -85,7 +85,7 @@ static const struct udevice_id sandbox_reset_ids[] = {
 	{ }
 };
 
-struct reset_ops sandbox_reset_reset_ops = {
+static const struct reset_ops sandbox_reset_reset_ops = {
 	.request = sandbox_reset_request,
 	.rfree = sandbox_reset_free,
 	.rst_assert = sandbox_reset_assert,
-- 
2.53.0

