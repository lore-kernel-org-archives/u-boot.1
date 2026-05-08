Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D419DCD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4F5784CBF;
	Fri,  8 May 2026 14:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OCfzKRp6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="M/LiNiQ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3B578488B; Fri,  8 May 2026 14:23:14 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1A1984CBC
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gBpDc42Wvz9tG4;
 Fri,  8 May 2026 14:23:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J0td69P5vf4tQLtQMOn55upDpb79SFCNJ4eEsUvO8Bg=;
 b=OCfzKRp6tD+HZk9bCctEvsJmtEPo7z7wSpT04NagzerNFxAIEqsQtEQopp1r5lCNH4bOmn
 NoKcJOUfEdhdUEJ1pwBkRq24E9a2sC1sEHDt9+K7XHjmVfdaLQw3RagYxMkXDwoXQPu49O
 KXUT4yJE4FxjbqvI9ct6mikS9XbY2dRQR7wApKahiot/UeJ5jtUOtH8LqYKRa77GT6vnVs
 GA1pyT7eyIjJoDhTrKx2I23xd5ZZcIiBCJ19KrPNzMV7jMVS4dPcCp47E8KwQ0XM6d+5LS
 BPq3FVKxdcm9MPPJFxolpmEyiM1kML5eGe2lR586BjPk3y5go4p8zSHihs3UbQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J0td69P5vf4tQLtQMOn55upDpb79SFCNJ4eEsUvO8Bg=;
 b=M/LiNiQ21I7lsoBP4h2nKKRgC3OQe4kgybqXVi9akkRMDDTeHB8s4E/euloJRTdoHByiN7
 /jJikv8ou/zoTgT7+nV6Kd+yazwH1f0zNSquDc5UlIavbCf6LZECSQCkrT17b/1y/NhkVE
 bwyzsmYbQmm4uR1O6sxD55D9sw1QSfFONDkdfQZj2xR9IkiczXBxrSBvi3piCPgkSZh50S
 jJIZDpNcbCTfVb88LTUJR56NQeWUWVm1IGBreQZkC53ub7bDAVnBFtfZhtl/oRRJXHdEk6
 5t94MILRbIABAHfGAAcrS12ltXZ6f5A2bMJIK5Bs27Meg7ntScY7lhVUt4VxWQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io
Subject: [PATCH 08/14] power: domain: meson-gx-pwrc: Staticize and constify
 driver ops
Date: Fri,  8 May 2026 14:22:08 +0200
Message-ID: <20260508122247.512862-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9zptgttpk1hytua7hah7ybmgyerfj7sq
X-MBO-RS-ID: 396a6804abc27540241
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
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
---
 drivers/power/domain/meson-gx-pwrc-vpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/domain/meson-gx-pwrc-vpu.c b/drivers/power/domain/meson-gx-pwrc-vpu.c
index 1c56e8508c3..325296b0dd7 100644
--- a/drivers/power/domain/meson-gx-pwrc-vpu.c
+++ b/drivers/power/domain/meson-gx-pwrc-vpu.c
@@ -262,7 +262,7 @@ static int meson_pwrc_vpu_of_xlate(struct power_domain *power_domain,
 	return 0;
 }
 
-struct power_domain_ops meson_gx_pwrc_vpu_ops = {
+static const struct power_domain_ops meson_gx_pwrc_vpu_ops = {
 	.off = meson_pwrc_vpu_off,
 	.on = meson_pwrc_vpu_on,
 	.of_xlate = meson_pwrc_vpu_of_xlate,
-- 
2.53.0

