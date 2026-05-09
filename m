Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4799CCD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 15:14:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0470B84D74;
	Sat,  9 May 2026 17:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kv3+z/em";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="f66lgyvF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09F2084D8D; Sat,  9 May 2026 17:13:27 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2468C84D23
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 17:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gCTyX4rtHz9stw;
 Sat,  9 May 2026 17:13:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sh8MdegUdLJI4Wl5aiPuhyFlO5wC8K+cY7ug8b3UeUk=;
 b=kv3+z/emCgqW9YNdNBCUIdW7qLV12KnvnIZgdB+PjZyxbHimrTNfNZX+TIqm4P2DTpPHbO
 1hgfcgqC2xthBf3+lhdAblnTvsrJGYUPvBn3T8EZPeXjO6mSCMdJ8+3pzC/EmW545V1nAR
 Z1m9GN8COff9DhTC0mg4WLyyZJpLOMFMEp9aKhimIr2uyBXSTgm+8hP/ftSk0rak1zGYwP
 LwfuTn0sXPi2emVTPR0jqe2xm0p+zeFCpq+sB26+q1JLIrsbn+7Z7byosdoMHQSOU68Oqe
 3ntwqf0XmtBj4dilTRDW2eN0z607qN8mfu7GI8GYspSPPfs7cov3TRg6X6p1mQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=f66lgyvF;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sh8MdegUdLJI4Wl5aiPuhyFlO5wC8K+cY7ug8b3UeUk=;
 b=f66lgyvFndDZGtr4A/fnSmDR9ZFJd7n5a2Iw4jQ5+W8r8aLWKxBsZSlsE1PTxMXsgnHgbD
 wRRELCstMTJCEN66n64btERGOAQ4FRDVRfr9jK4ZI6/3d7HwbRi1v9HaFK43ggsDKItknT
 a9ZYpEhyQFaIE1/XeNovMBfv/LFOQii96uXgvMa/0Tl1jRcUe2BcUlNvY6owe/m1JUAt/G
 PVKnDzhdQMvi9qaR9jIj3WpUXdbQRqBXUqREr0/yn4WbvATuf08pdeAag2aw+6eJW5zMoM
 ejX8tTAT0sPWyEjprb6W84cFfIcl5uqNpx95CLY/UzeaOKMZ/0fzVMrrNKraeQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io
Subject: [PATCH 07/14] reset: meson: Staticize and constify driver ops
Date: Sat,  9 May 2026 17:12:30 +0200
Message-ID: <20260509151308.23067-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
References: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mfcmcp3jtr7yi4gf58zka5eytcp85uan
X-MBO-RS-ID: 029d36f02eb3cee1daf
X-Rspamd-Queue-Id: 4gCTyX4rtHz9stw
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
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
---
 drivers/reset/reset-meson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 6337cdaaffa..8c27563ce23 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -66,7 +66,7 @@ static int meson_reset_deassert(struct reset_ctl *reset_ctl)
 	return meson_reset_level(reset_ctl, false);
 }
 
-struct reset_ops meson_reset_ops = {
+static const struct reset_ops meson_reset_ops = {
 	.request = meson_reset_request,
 	.rst_assert = meson_reset_assert,
 	.rst_deassert = meson_reset_deassert,
-- 
2.53.0

