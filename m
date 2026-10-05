Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0C8CA5FFC
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 14:01:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06D524069C;
	Mon,  5 Oct 2026 14:01:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ViDX4goiNaiP; Mon,  5 Oct 2026 14:01:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4D7B8406E7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791208884;
	b=Spbq1pn09/rUXlzDDIPOoj/JBY9hTpsRj/MFhMewMd6rE9q0Q4XpVNcBEbTOVyFNGCil
	 MFWUpJE98uq4fxdjT3kqyYq3qmiffSaU4rOTPjz5weGg1SX0s6rDYX8m8aF/esO88fw57
	 3w2ixVAlUJGlqm1m1aILm452blR5K3cFulsJ8hgKQxPW6S2srgHyYWh5ZeIrVQBKRn0Ky
	 bfHOFc1dwZS+eUXU3pM2fTc/J3gkEqx64mFwQGwqXWIkJi5+s3pFVL7BT0s3e+9mO9nC0
	 xrIfYJaYPIYT1KR47d4eblovMTRWDhnoV3NCSnKNhAlPXfXWzmLhHZG+bEnkUPlREZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791208884;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=W+efKMCjZtMiNtXEoe5SLa5dOJzkpSk38OFJdT6WyyA=;
	b=A2oIbfnu5uAhmiMQjPKsO1lVDgm3IJQ4+Z7XdepVxvTxo2QcvERnhr75zjTzMpGuf96C
	 e4UmPvkAZ97gAkS6yW5rlx/kLu9H3EaigU7CZb/TszAxnCDDIeFd1m/iOuPBGpNL1WZnA
	 RpNhTg6ON1VxJ4q1KOHiAtXVfRJjsTRtxjeBvYoN8XITsCaE0ROBpZ9SN34VlXp9s9tEh
	 K5X5LgsmymiEs6Mufz6dkITTQ2sTC0P6O/92I0UIlVRmLQ9sFKQWWTkswEEMvcx+c0GA5
	 pFaRrkY6hoJRmYYcDge9U3IcsmbakcNMEsvaYiY/LGlLr7CFG0bXEy4cXiYbhFJzT9A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=brivo.com;
	dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256 header.s=google header.b=T++d3MaC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791208884;
	bh=W+efKMCjZtMiNtXEoe5SLa5dOJzkpSk38OFJdT6WyyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w4X8JUF/UuVSmj/9BsNjJNx6E4OLWjTBxaKAbfC1ofP1imEr482JcGvba/DMneb3M
	 tCzbUwUbyMIuPXnMm45WdO/Kc0/g5OIxbBcaYxo/mP3H4iig9fz9wynjPngPIu8kpZ
	 6nevuKIWLbLNyVRXPDyjokUl47NwNA3fRW4ZsH7eDtlD3nV/RTIDzYrKB5CWl/F4UM
	 0QxgsvJ2pnX7wAYxA9NmtAHpZGB6KZUqlR7nYcfKfn7qg2J3U4N+DEQYAvQA9KiRdZ
	 Ks2O0kiSeKib46T+zEsXauTdgJF8QJFTXq57pyZN1vVyli+T2WN6jFH/fEomy7KStP
	 K95sxSkx+mm2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D7B8406E7;
	Mon,  5 Oct 2026 14:01:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 01EF9338
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 13:56:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DBE0E40670
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 13:55:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8OabARVjStKD for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 13:55:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BBA784066E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791208559;
 b=R9bCcrtI+AhFrc3t+u/QvmKL4aUerOPZ7sAQsEvz4LinBcCEssuTKPGacVcpCXx4oFyg
 cyBlthAFhUwr/8XAl7FqcsV6ahPEa9I6rIKnMga61AYZ18IgYT3zSZGpAl//SKDw7HRi/
 Lj5SxHiY89CWSe6J2FXe2NGmxOqI//DNSVK7BlnwPYh/dNG2BE2yxdV4vyM00v3UJFtRC
 B8z4lKv+wrZuSEw3IHFEzmt8iRHk/YbIAV8Rh69eIK+GgtuavpIVxv4cD44vjdRjvhkiX
 8Onak+7HQ3/74nXzRmj435pgfqi/foUuxePor4MoToH/A9KlDPvlVYbB4vRva0VEtuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791208559;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=W+efKMCjZtMiNtXEoe5SLa5dOJzkpSk38OFJdT6WyyA=;
 b=TzfOz1DXlMflM6JxuQ0/BknjL54JJmv1psuL0aJXZQmjj02efyIuhKr9r5SkCXHkE0YW
 Y68S0Uam6l17sG5E5mr8HOwUH+tuXhNpABsUA0y/eQ3yG+rW0J1JDo6oDGMLp6iKyX9F2
 fJ1KEtR6ellFEJae/ytsWFuVHZoshgnAk4S2Si81oQT8bqBbWrFBz/OVUHmcv0kaIj/6U
 ZbinZLpfWWF1/Vm+Zi/wHZ1t/fmvsnHyMjAklBCKTK+ajXDdjwzb3iHgAyTiyjeUOipYy
 UW9s8pUcOcaolhmDABmMk9JQ4clQSZb5zSNtuTkEuBlJnFwYjE08jTh6Q2u4w1TzVrg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=brivo.com; 
 dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=T++d3MaC; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::2a; helo=mail-yx2-x2a.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=T++d3MaC
Received: from mail-yx2-x2a.google.com (mail-yx2-x2a.google.com
 [IPv6:2607:f8b0:4864:41::2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BBA784066E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 13:55:58 +0000 (UTC)
Received: by mail-yx2-x2a.google.com with SMTP id
 956f58d0204a3-675617094f5so1266815d50.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 06:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1791208557; x=1791813357;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W+efKMCjZtMiNtXEoe5SLa5dOJzkpSk38OFJdT6WyyA=;
 b=T++d3MaCbENHeDu8dsgDM1OphyC3UzVdiaLbT8NDSbPBRzAocQH1GP4tIJGdCiXwqc
 YA0G1YBm8cGYl7SP+coD4RweSPH9b7RrFLAnf7GLUwpRo2ZABiN9Jz8841bDhpooDmi0
 6uXzSic603smRRoOnBfqpUa1zLwEEvWeW8OWW+Dhwexnh0/2yGBKQLR85dplR/3TFOfv
 0ydgBFlf1egi0nSN0ydqzQRA2Lu2xq069QphYu59mSwxiZOP9EWDNayUeQKEB2+ZT1fm
 erpttzygC7141ekGyRNze/y/GZMHizcbJ7+rYLKZmqedmLAmvB+JyE3T6PVNj9HTf0Av
 +mFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791208557; x=1791813357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=W+efKMCjZtMiNtXEoe5SLa5dOJzkpSk38OFJdT6WyyA=;
 b=DSGQvgv+azHGk4rcJJkEl3K9w9rAlfdIiGmc1RCBT5VHF8dxaSChQcbnxaDbB04eBR
 uv+b3rHtRmtfKFxyUJqpOR1Et9RC3gbsQlqk4emsYekCn3LcZCvt1o8SXAwF+tlJFEAW
 apO3lGSkdPPSml2oHiyPPQEbEQFvnVIw8R3tAWT6xZ+DDl3inO3rhhdX0vXEy6i79TgM
 piAQAv57m/fTZoGcQF/4G5n9vd8INckh8t7BfmgLLu17ZFuw8dmZwm4ih0hgT3tPSDh4
 qQr87oCZ7ryJKkkHXYKFCwjTtVyn2lEIbFnYhVW3R8tO1QDeVckC6S8y1yzZjRijQaAK
 uwVw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOJ9WVpeuP/9ViHuoXxQLcqiO4sF9Tb0928lwGr7Im/KRWiV9ffzF/E2sfU6x51wfyycja8Yw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIA9zcj3tFoPhx2KZQkklB2EWn3dpALtom4IMXT9XTlw4HG81RJ
 IFw+gOyYWuUnE596d8kf6sHEm/4BZ81S5wgB/qNRGKJM+xH4dTg/7JU6GcIvtrZUqi1WbZ7v05m
 V2zBkwLlpb+xbpyoTGBu+huJMHFYzJ3swyZCaPaOAymSFKfbTta+CfNT5Ug/9aSQ1o4L9dsXy0F
 WNGoU=
X-Gm-Gg: AYBFou2DfYe4tZu5ZijUEpU/xbfp6O6m6YlwL0+ziJPkZ10nbSct2GeSLRghBW0g+RZ
 OUFtEhut/8jlvKco6/iG2wmhpL9m4uvKUhminbsMP4fEto7emDmwCBB3rxWUtmK/qfLor29Cyij
 Wt7TnNi9w5wyiRmqxY/WL4jB/Qcp1E+MZOLlz/q5+Rzn5p1y95vtXVxZlbPa/AEBBUCmh7cEsnH
 en5l74q5OLcq/8tO123eDCa4nWi0oxsXd04M98QIMwcGi/HfhuZMAAiAoOxRHH0ZhasbXL32U+6
 iqgr5AiBPSl94DV6GvpzQ+iv/YVHu+h77mCI7CFk8AKIUxu991vOHnRrGqAqY4+5Yrd9gO39PC3
 eCfsVuabrUSsvE/t8aGbm787l5Fg2De+tq+W1eZIXAScwXvGWi4/Yp5RBr1HO3uP/QCOo0iVH1F
 lyOxNuZlEaOdEAWbCFgTI74M6NWuQEmkCqWFRuBu1Ze4HTSRDB+F0afzB3yDkxHdFHqQi21WKUF
 Q==
X-Received: by 2002:a05:690e:118b:b0:677:d439:2fe7 with SMTP id
 956f58d0204a3-677d43930d4mr1444362d50.25.1791208556825; 
 Mon, 05 Oct 2026 06:55:56 -0700 (PDT)
Received: from strozzi ([66.193.28.125]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8ae328ee37asm39074437b3.10.2026.10.05.06.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 06:55:55 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Jerome Forissier <jerome.forissier@arm.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Sean Anderson <sanderson@brivo.com>
Subject: [PATCH v2 2/2] net: mdio-mux: Remove ourselves when our parent is
 removed
Date: Mon,  5 Oct 2026 09:55:48 -0400
Message-ID: <20261005135551.510145-3-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005135551.510145-1-sanderson@brivo.com>
References: <20261005135551.510145-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Normally, all child devices are removed before their parent is removed.
However, mdio muxes are not direct children of their parents, so they
can stick around even when their parent has been removed. This can cause
crashes when the mux tries to access the parent bus.

Fix this by listening for device removals. When an MDIO bus is removed,
we remove any child that has that bus as a parent. It's possible we may
fail to remove a child if there are multiple children of a bus and the
first child fails to remove. However, there are no such configurations
in-tree so I went with a simpler approach.

Fixes: 8880edba06d5 ("net: add MDIO_MUX DM class")
Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

Changes in v2:
- Don't try to get the parent unless the mux is active

 drivers/net/Kconfig   |  1 +
 net/mdio-mux-uclass.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index c057504cf66..5124c4a644e 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -30,6 +30,7 @@ config DM_MDIO
 
 config DM_MDIO_MUX
 	bool "Enable Driver Model for MDIO MUX devices"
+	select DM_EVENT
 	depends on DM_MDIO
 	help
 	  Enable driver model for MDIO MUX devices
diff --git a/net/mdio-mux-uclass.c b/net/mdio-mux-uclass.c
index 14143ca0ab6..382f92d4fbe 100644
--- a/net/mdio-mux-uclass.c
+++ b/net/mdio-mux-uclass.c
@@ -7,6 +7,7 @@
 #include <dm.h>
 #include <log.h>
 #include <miiphy.h>
+#include <dm/device_compat.h>
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
 #include <dm/lists.h>
@@ -231,3 +232,32 @@ UCLASS_DRIVER(mdio_mux) = {
 	.per_device_auto	= sizeof(struct mdio_mux_perdev_priv),
 	.per_child_plat_auto	= sizeof(struct mdio_mux_ch_data),
 };
+
+static int dm_mdio_mux_parent_pre_remove(void *ctx, struct event *event)
+{
+	struct udevice *mdio_parent = event->data.dm.dev;
+	struct udevice *mux, *mux_next;
+	struct uclass *uc;
+	int ret;
+
+	if (device_get_uclass_id(mdio_parent) != UCLASS_MDIO)
+		return 0;
+
+	if (uclass_get(UCLASS_MDIO_MUX, &uc))
+		return 0;
+
+	uclass_foreach_dev_safe(mux, mux_next, uc) {
+		if (!device_active(mux) ||
+		    mmux_get_parent_mdio(mux) != mdio_parent)
+			continue;
+
+		dev_dbg(mdio_parent, "removing %s %s\n", mux->driver->name,
+			mux->name);
+		ret = device_remove(mux, DM_REMOVE_NORMAL);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EVENT_SPY_FULL(EVT_DM_PRE_REMOVE, dm_mdio_mux_parent_pre_remove);
-- 
2.53.0

