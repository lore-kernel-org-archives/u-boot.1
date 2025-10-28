Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428CCCCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 14:24:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1345D82A9E;
	Tue, 28 Oct 2025 15:23:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PrCfdNMU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="I9iPxlpt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15AC483700; Tue, 28 Oct 2025 15:23:53 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D80E480422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 15:23:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cwt0Q4H51z9sq3;
 Tue, 28 Oct 2025 15:23:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761661430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mPIhr3b2aMoIQR5Rqipa3fk+ffb7fby2Kn2OGa9G40k=;
 b=PrCfdNMURmWJ+FAUzNZmFW+jRSUcMa48ZpU+QdVhOb2+0AClRhcLuZxi/5al0/zgnVJFEL
 ZBhEur9xZt8kXmLiSoHp6EaG6u2QNzIe3N+9UuoLZdH8i3++1spayhqUuZJy6GmckCTZ76
 v7+n5KEmmhI+dr0hAApyP6OBEqyVl9D5JQPWfMfQ1DsN4Oq+d8oGFYfOvyM6r/FRtKxTLj
 a9cu2bb3zVUNMmMWkWDErF7Rv3al+K+pCoiteJwh39KFCJ0kWm8vshvS/x9Lis0F9MdM3T
 miw2HQp0oJZDS4gn9/nISGNJIyoUN3Qo43vW/jYJW852mob3ElWRaDLKtVsA/Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761661428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mPIhr3b2aMoIQR5Rqipa3fk+ffb7fby2Kn2OGa9G40k=;
 b=I9iPxlpt+ujJ3bq4jCwdoub9PAHqOi5X4UJ//4wNLeGJcdXiiCWhVR1hbYQH5d9ExD3NeN
 GxNYMW7N/Ha3arXWSojtAJve15iW+vREH36BxXKRGC6WNW+NDgMk5VCGBMGSII4/+LfA6M
 XmwYiHFhgot+pplFl4jJiBXA1p/HfqRo5vXWQ/MktRptKqqPvIBWHbLHPe8LHHYRzzjonR
 GF/GjGGzJnql7AKpqLpBuATmpdRIiIP3g/C8B6jGsATa/q7+nAlkaiTnuOT04iQtGmmv/B
 DP9vELq1y12nbgqdgTJIV4ymoFe+cjqq8zDQDuOg1//fqXqKtoZ/lcJ/9CTZeg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, u-boot-qcom@groups.io
Subject: [PATCH v2 3/7] ufs: core: Rename ufs.c to ufs-uclass.c
Date: Tue, 28 Oct 2025 15:22:23 +0100
Message-ID: <20251028142335.18125-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251028142335.18125-1-marek.vasut+renesas@mailbox.org>
References: <20251028142335.18125-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1d8x5wtq53k9uy33sn3yqjhzks74bu6u
X-MBO-RS-ID: a0b2a157801ab2220f6
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

Previous commit folded existing ufs-uclass.c into ufs.c ,
which produced a nice and reviewable change , but also broke
the UCLASS should be in *-uclass.c pattern. Fix it. Keep the
change separate from the previous one to make this reviewable.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: u-boot-qcom@groups.io
Cc: u-boot@lists.denx.de
---
V2: New patch
---
 drivers/ufs/Makefile                | 2 +-
 drivers/ufs/{ufs.c => ufs-uclass.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/ufs/{ufs.c => ufs-uclass.c} (100%)

diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index 2ac410cf7c3..17ca89e886f 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -3,7 +3,7 @@
 # Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
 #
 
-obj-$(CONFIG_UFS) += ufs.o
+obj-$(CONFIG_UFS) += ufs-uclass.o
 obj-$(CONFIG_CADENCE_UFS) += cdns-platform.o
 obj-$(CONFIG_QCOM_UFS) += ufs-qcom.o
 obj-$(CONFIG_TI_J721E_UFS) += ti-j721e-ufs.o
diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs-uclass.c
similarity index 100%
rename from drivers/ufs/ufs.c
rename to drivers/ufs/ufs-uclass.c
-- 
2.51.0

