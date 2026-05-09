Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A37CD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 15:15:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB33C84D24;
	Sat,  9 May 2026 17:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yh34CO2a";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LeEni/+c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A30C84DC8; Sat,  9 May 2026 17:13:35 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C672884D9C
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 17:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gCTyh3Ktrz9tnT;
 Sat,  9 May 2026 17:13:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0spjUz3kbnBcEyTEeQWOUjEygkTJbR2DCuSsj13IYVg=;
 b=yh34CO2aI7sxus4U734uMuo/rMsoWIIG0StLfFH3ujP9s+uYMHoW9kHKbJiWrl7d8oJCQZ
 tqQbn5ZMmUp1ZZEacRbKSRW8r95i63LH7LR8kYGKU0SrKf8GuNEVIClABDHMxiwPZpAQl2
 ShKm1+Vw4DjfZ/0/yAT6ehe7ELJR/0xhy+GJtEUrCrhtaEANmCgTRqrcXRMBbrwJ7j5Gm3
 H+kvloaVqSsouXjD+RpL6+IgJXKslfMShcRUZA1yiX5JeEMZobKboQNnZu+N0XIp4us7fK
 JXsgF28970W9m+xOEdOC4rb8rAhC3gFiu/5Vfe8WZuhRp/EyczdtGHAqHq8oLg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0spjUz3kbnBcEyTEeQWOUjEygkTJbR2DCuSsj13IYVg=;
 b=LeEni/+cqop/aj6fvTq0kfA9SQcsmsGRRV6/4MC406ICApt7WGePXOzYLC6FVRGOlsxNfq
 mCjkW5V3jfQbSKd5Lznu9HjgIsun9arCuZ/WKgIHhaMaBDegvZU7DUdhyDlR7DOpSxx1V8
 Gea7XszEYK4NREaAO7lE2ZFgoiAfRRywMRkcWTdfTLCxCG4p2D+jaNOh86YEkYjyqunmKo
 Xa5Ee+1OJTnx3jSih5JyIOQFV2+Ffrixm48ZYvD52Pp8vnFKqR25all9aF/MkVTcRyd/Rd
 W4BnvlKZYVTQ2+qcLqG48KRtUCPMlIHoLrPIWdvpf5Ur/4W8M0UM9EjsoA0xTg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/14] reset: tegra186: Staticize and constify driver ops
Date: Sat,  9 May 2026 17:12:37 +0200
Message-ID: <20260509151308.23067-14-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
References: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 17e0b8bb1b2a82a3666
X-MBO-RS-META: 1medcmr51qcayt7wed8n9q7hpjxujggn
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
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/reset/tegra186-reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/tegra186-reset.c b/drivers/reset/tegra186-reset.c
index 89624227c29..1d8f40acaef 100644
--- a/drivers/reset/tegra186-reset.c
+++ b/drivers/reset/tegra186-reset.c
@@ -43,7 +43,7 @@ static int tegra186_reset_deassert(struct reset_ctl *reset_ctl)
 	return tegra186_reset_common(reset_ctl, CMD_RESET_DEASSERT);
 }
 
-struct reset_ops tegra186_reset_ops = {
+static const struct reset_ops tegra186_reset_ops = {
 	.rst_assert = tegra186_reset_assert,
 	.rst_deassert = tegra186_reset_deassert,
 };
-- 
2.53.0

