Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20120EE49AA
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 22:30:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C5EA871DC;
	Tue, 22 Aug 2023 00:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="oz46ocDi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5010D871DB; Tue, 22 Aug 2023 00:30:28 +0200 (CEST)
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net
 (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84325871BA
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 00:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:in-reply-to:references:mime-version:to:cc:
 content-transfer-encoding:content-type:cc:content-type:from:subject:to;
 s=s1; bh=ML2SSdiIe0AABaA1JYw0ERuYJUiztmtHMYBBHvoE9Vs=;
 b=oz46ocDimW1/QbZ9TjHZzBeyEuSYjsQuHT1gnec9Pj/gRQGenKjvYc8ZtVTDppLw8KVB
 hooP06VA4a6ks7dHpOgH5fLtoE/k2f8Y5DrLfpRAL+qaBjqxkrJSJ+/wHtqi1H+Bc5KGEu
 nZdgX/mxuVyh5ncPYzspEiVnnnZA/PCkok4mFUIf36hygB/ggEg1CnPtBmwUH64NBhmX+x
 FwW1G8G1p1hZAKHtQj/5uXjSSASXCaAVofGOo7eksPDEbWaZnezf5q2VwPG6LRj5u1NKoU
 fEF/ig4I5hlMZ7YmrvzQzThNDS0hVwCYhDj7v3XP2GtbduBQ1mGcHBjyZeKMWtbA==
Received: by filterdrecv-65f68489c8-knmdt with SMTP id
 filterdrecv-65f68489c8-knmdt-1-64E3E57F-4B
 2023-08-21 22:30:23.818256013 +0000 UTC m=+8895265.754192256
Received: from bionic.localdomain (unknown) by geopod-ismtpd-7 (SG) with ESMTP
 id 9RgmB5ovRs6IR0jK352Djw Mon, 21 Aug 2023 22:30:23.524 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 1/5] power: regulator: Only run autoset once for each
 regulator
Date: Mon, 21 Aug 2023 22:30:24 +0000 (UTC)
Message-ID: <20230821223020.3918620-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821223020.3918620-1-jonas@kwiboo.se>
References: <20230821223020.3918620-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h+an1LGJ5Y4syCliu?=
 =?us-ascii?Q?5UulLfa84OEDKVEJYbt22=2F2KS4pDKsOeufVmaeM?=
 =?us-ascii?Q?OfgCgsZMAYT6bMrHyEXAvmCbnvMtdIO6wqiLymZ?=
 =?us-ascii?Q?80XBa1LqsXs7N4M9Tz0gGhuPkZKvouHwo0gUyw=2F?=
 =?us-ascii?Q?Hw051+FvjmGYM+UiIdO3tB5SSmuNpC+dZBy36Z?=
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jaehoon Chung
 <jh80.chung@samsung.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>, Svyatoslav Ryhel
 <clamor95@gmail.com>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
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

With the commit 4fcba5d556b4 ("regulator: implement basic reference
counter"), keeping regulator enablement in balance become more important.
Calling regulator_autoset multiple times on a fixed regulator increase
the enable count for each call, resulting in an unbalanced enable count.

Introduce a AUTOSET_DONE flag and use it to mark that autoset has run
for the regulator. Return -EALREADY on any subsequent call to autoset.

This fixes so that the enable count is only ever increased by one per
regulator for autoset.

Fixes: 4fcba5d556b4 ("regulator: implement basic reference counter")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
---
v2:
- No change

 drivers/power/regulator/regulator-uclass.c | 18 ++++++++++++++----
 include/power/regulator.h                  |  1 +
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 3a6ba69f6d5f..77d101f262e2 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -293,6 +293,9 @@ int regulator_autoset(struct udevice *dev)
 
 	uc_pdata = dev_get_uclass_plat(dev);
 
+	if (uc_pdata->flags & REGULATOR_FLAG_AUTOSET_DONE)
+		return -EALREADY;
+
 	ret = regulator_set_suspend_enable(dev, uc_pdata->suspend_on);
 	if (ret == -ENOSYS)
 		ret = 0;
@@ -306,11 +309,15 @@ int regulator_autoset(struct udevice *dev)
 			return ret;
 	}
 
-	if (!uc_pdata->always_on && !uc_pdata->boot_on)
-		return -EMEDIUMTYPE;
+	if (!uc_pdata->always_on && !uc_pdata->boot_on) {
+		ret = -EMEDIUMTYPE;
+		goto out;
+	}
 
-	if (uc_pdata->type == REGULATOR_TYPE_FIXED)
-		return regulator_set_enable(dev, true);
+	if (uc_pdata->type == REGULATOR_TYPE_FIXED) {
+		ret = regulator_set_enable(dev, true);
+		goto out;
+	}
 
 	if (uc_pdata->flags & REGULATOR_FLAG_AUTOSET_UV)
 		ret = regulator_set_value(dev, uc_pdata->min_uV);
@@ -322,6 +329,9 @@ int regulator_autoset(struct udevice *dev)
 	if (!ret)
 		ret = regulator_set_enable(dev, true);
 
+out:
+	uc_pdata->flags |= REGULATOR_FLAG_AUTOSET_DONE;
+
 	return ret;
 }
 
diff --git a/include/power/regulator.h b/include/power/regulator.h
index ff1bfc2435ae..200652cb3d7a 100644
--- a/include/power/regulator.h
+++ b/include/power/regulator.h
@@ -134,6 +134,7 @@ struct dm_regulator_mode {
 enum regulator_flag {
 	REGULATOR_FLAG_AUTOSET_UV	= 1 << 0,
 	REGULATOR_FLAG_AUTOSET_UA	= 1 << 1,
+	REGULATOR_FLAG_AUTOSET_DONE	= 1 << 2,
 };
 
 /**
-- 
2.41.0

