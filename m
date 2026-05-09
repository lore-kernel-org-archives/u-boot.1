Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66483CD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 15:15:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CF4484DBE;
	Sat,  9 May 2026 17:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lgMp8ykW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="udIeyzxY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC97D84CC7; Sat,  9 May 2026 17:13:33 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BF3784D93
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 17:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gCTyg5TvLz9tRV;
 Sat,  9 May 2026 17:13:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X1KzgXochcZFGC6mU9toZnT5TXnytWBUpPzfoy3ye0g=;
 b=lgMp8ykWhbWUq2Tj18LQj2f0K1hhwXgV9F/kiHaplAsdZ1mopHsAVMWgKG6L5Ox/xmeJgM
 GLtGetfcwbza0YGRCRr7BdDeDnmGyhkF5L97w5Cg7ctoAbodktGzDhqnT+1lgLZGPVjizO
 PVL5EKgpnmhJ334ZvngzbCbzVslqnuYCCg5SVXJTVgCdXIg2cqXH3oc2sH3iPVVWkN+gNp
 jQFjn8Wu7ihUc2qqwtM7po/XdziMVaxTYT+M0aBdjHR0hvWXIsaaoEo/d7yDuy9Wbk85k3
 L4K5UIbZddypL676JQzPnSfqHrW+mLWhniL4i/kQCx4IlyJwhfyaXSrgp6QhsA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=udIeyzxY;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X1KzgXochcZFGC6mU9toZnT5TXnytWBUpPzfoy3ye0g=;
 b=udIeyzxYQ3OLt8rvByPV3i69mhmfcEw601Urt+BBUH0phLzmmd+uai/eVztuv6utIKuPY3
 BK3d9K3jTjeTxvoCpFz9ql+OyF/Ss0U5PQmak0dnRlDI6acT3h668jmrKUXbmnCD/QCNBs
 68HQSy9t5debbGE/5QXfVABmlokJGyu5hMMNc3Ay/KxWSOBnrBKDt8S36hUtxeeary8MDw
 q0TaC4tciAXIxrHvrt0Q7nchmgTGprWVOiSIKM/vJ0BN5E/PHJ63afxCf7vGC1oRsqgCXW
 O12tHjdn7rsYDj7Yymp/dGWbvDj99RpDsu8Sba1h23RxT/3pBwLlnmZy2Q5naA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/14] reset: tegra-car: Staticize and constify driver ops
Date: Sat,  9 May 2026 17:12:36 +0200
Message-ID: <20260509151308.23067-13-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
References: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 14e929f907aec6be199
X-MBO-RS-META: ucent6g68xakzd1bdopu1rmjzbm1iix5
X-Rspamd-Queue-Id: 4gCTyg5TvLz9tRV
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
 drivers/reset/tegra-car-reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/tegra-car-reset.c b/drivers/reset/tegra-car-reset.c
index e3ecc8d3735..63f148cf3d9 100644
--- a/drivers/reset/tegra-car-reset.c
+++ b/drivers/reset/tegra-car-reset.c
@@ -42,7 +42,7 @@ static int tegra_car_reset_deassert(struct reset_ctl *reset_ctl)
 	return 0;
 }
 
-struct reset_ops tegra_car_reset_ops = {
+static const struct reset_ops tegra_car_reset_ops = {
 	.request = tegra_car_reset_request,
 	.rst_assert = tegra_car_reset_assert,
 	.rst_deassert = tegra_car_reset_deassert,
-- 
2.53.0

