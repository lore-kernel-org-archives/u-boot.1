Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D88CD3445
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 15:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42A8084DB3;
	Sat,  9 May 2026 17:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pYDIyR0K";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AHxJQYue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5BAF84CC7; Sat,  9 May 2026 17:13:33 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F081284D24
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 17:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gCTyd5Lmwz9tYh;
 Sat,  9 May 2026 17:13:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xmS5Q5IOR0SiWvR4Fgnl2tBdlAyFgRh6DTkIDjwF1G0=;
 b=pYDIyR0KqMkWNAb9IlBbvhl3YN0SEV3DAHntKhLGMTtkBSK/rQBBgs+VDfpI/otAUiE7Qr
 4lZTgMfCYV+TVLT9SzUKK+GRJcHMXGWc1wUHpCWRGU9E1GieN1AP8ekTE6ULbkvyefUFzr
 hI7ykPP7SHTRF8/fvSyGMd4BqdNbMXlMhTY7t6mMA7yg+s6fA/UKkgrlFFK+9733GlSrIc
 VQXs9tb1VV4I7FZC7Dr+oL2BVRsmB1Q86cAN0AupkwFSzcqf10k1qNFfntjlnT+Daaa3Wz
 yyxLHp7VZjCdvW4OR803PO4Oac9pAjsFISKuJPB5W7J5zzmr1vsiZlGnMu0Y7g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xmS5Q5IOR0SiWvR4Fgnl2tBdlAyFgRh6DTkIDjwF1G0=;
 b=AHxJQYue6GWai0gyrpvpAvJLzqUBITGD8eWTSeV3uMmIFMCfp5g26+RbR6/oXLY4PxSJN3
 AqUq/jFK8h8JwqxIt4/xMSjc3DadI2BaDum3xMSuqW/lj9XDTQSKDwXP3HAOCgKbAMNELN
 dhZrbs47CTVjBhh1svgr6HADtN9FfLKVTa8RDlH5X7/ppVMtOuU/RjJ7Qtnj4PM1sd3Kd9
 p9WDF2L5kW4qp+RXOMfLL6AhkDyyrbBmCp4Bu+sE5+tPkcXPuFEuidGPrNCM/1KuYBMe8I
 Ma6PRBnxYz/AphKztEw9pKfzwMfPGdagrM07PYA6UpORX5Nf/TQXRIrWkBUU6w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/14] reset: sti: Staticize and constify driver ops
Date: Sat,  9 May 2026 17:12:35 +0200
Message-ID: <20260509151308.23067-12-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
References: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 43ocf1kd5qtbfzodxcgpjsxpyatjofto
X-MBO-RS-ID: 90862d36073e709d816
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
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/reset/sti-reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/sti-reset.c b/drivers/reset/sti-reset.c
index 412a0c5b452..37a37a72fd3 100644
--- a/drivers/reset/sti-reset.c
+++ b/drivers/reset/sti-reset.c
@@ -290,7 +290,7 @@ static int sti_reset_deassert(struct reset_ctl *reset_ctl)
 	return sti_reset_program_hw(reset_ctl, false);
 }
 
-struct reset_ops sti_reset_ops = {
+static const struct reset_ops sti_reset_ops = {
 	.rst_assert = sti_reset_assert,
 	.rst_deassert = sti_reset_deassert,
 };
-- 
2.53.0

