Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39C1CD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 15:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F9D784CFE;
	Sat,  9 May 2026 17:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="VUpkwDUy";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lXUgP+uC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B25484D26; Sat,  9 May 2026 17:13:22 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE03E84CFE
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 17:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gCTyQ3Xj3z9stw;
 Sat,  9 May 2026 17:13:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eLzuG71St2ZTnQ/QWCTkkWPIuM+mJ7nOS7RsKnipzJA=;
 b=VUpkwDUy9siFBQjp0t9gDPgueP/NGLbfvwlK+VGZdthRSt9ZkwVuLhx4cI4PeGKnVv8bmA
 OdPDRHPoTfjp9SXY8PJELr+LcQK6bzCWqycPcyvk66TIFsYyvIpUTMceipg6IIflvthb/d
 KXpjvDPHyqYedTN9Q7re7swrmkijysyrmnvywfuVKSps3SZsMvRjB+X82ke4emRIKGa+Uo
 jeir3BX1ZkkvJyzcmeAgnEfg+ytc0kdLQeBuhT3aGZsokHbJOU7p7w1q5x6ENGeMVr8HYs
 UR8Nb9ZtfdHQyf6qN7LTRjZFurtCF8Af/S44KXFTMWSmPm3Tb/givgG/tXIkBg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eLzuG71St2ZTnQ/QWCTkkWPIuM+mJ7nOS7RsKnipzJA=;
 b=lXUgP+uCfyVbXIYDgabyFM1V3a7cB2prq4Mg+9f5ivaup8VOBGobeo8/CjRJ7N/3/Ox6wz
 mvS6S0d1GhVVjJ8wBCrWM74nW6gQgh7UassVh/KnQ1j4wS3XF/DSyxoQB3ehSDez60ZDHI
 oDy1sAp62X/JQGlVLCkB/+b0LggiCqKcNBNOkg7dj9L0AEGucAHRP8f5gqJeGHC5cG4l2G
 y1/TQbsXHqFXrSizsX4dGkcWt8gtmVuzfliGihZyY57I1PaSxjkk2Sl0BcjO2Bl5DDf+iW
 uSJz0+8g+ysFsgUL/aa+j2KcpWhboXc2ZM+WlnM+igFlnazT1o/ZzGViUbTktA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/14] reset: at91: Staticize and constify driver ops
Date: Sat,  9 May 2026 17:12:26 +0200
Message-ID: <20260509151308.23067-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
References: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: rr463nsk46e4yi9ch3zj4sjw8htx16jq
X-MBO-RS-ID: cc3ae386357ab8ff439
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
 drivers/reset/reset-at91.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-at91.c b/drivers/reset/reset-at91.c
index 165c87acdc4..ebbfae1469b 100644
--- a/drivers/reset/reset-at91.c
+++ b/drivers/reset/reset-at91.c
@@ -79,7 +79,7 @@ static int at91_rst_deassert(struct reset_ctl *reset_ctl)
 	return at91_rst_update(reset, reset_ctl->id, false);
 }
 
-struct reset_ops at91_reset_ops = {
+static const struct reset_ops at91_reset_ops = {
 	.of_xlate = at91_reset_of_xlate,
 	.rst_assert = at91_rst_assert,
 	.rst_deassert = at91_rst_deassert,
-- 
2.53.0

