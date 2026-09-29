Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F30CA5FAD
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 20:32:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C09304043C;
	Tue, 29 Sep 2026 20:32:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bhcLKKAwlhip; Tue, 29 Sep 2026 20:32:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F2D7D407C0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790713967;
	b=O4+ri9De+0zKtj4O1lXlz3lVjVYgfazn0C7g1LNDCacv2Iqu7qdubio+oQOEHR8VPsg5
	 +zQwBfvhTC2VLsjGELHA4h4OztG8Qc9yl/JC6wdLRZtsTaniiIv+1yw+Ck5oW04Hk4loe
	 Dyrpqr7xU75ZJnqypXmwkkKWguNg/g+Oy+Lh+Yl1MDqGcqTZzsr0kNi6jts3+7vgtLDVV
	 y2p7CABJU8t4oWSqH7igmovacfTJfu3ZqaVGFcNIMVzqWQ4Kho4kTLJ4+1JO6GB+WGLXf
	 pk3j6mfB6u5+Y702A94raErbl2Uhho1zOf0+5KA8tzAoEWUnjL+oLF8kPy6ojPaurPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790713967;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Agk4v8Ymn5xu6SZ/Z7yfgUVeDaKOdMQxGo5LD/IibCY=;
	b=NdGuP7Og5HOk36WmWOirR4DAFq7Z3XBs44aeAZRVmxhMX/NhFOPkFN7h69O3vu1bkbej
	 Du6jr04xDGGq1AtgB8ke31l+MomC+xvrHr6XlJeIjvNfsCNhLLU4MGUxWuyqFjcxUoT5t
	 +eq7Vq7TN/imuvb1SN6vOl/sSO1JU8Alo+1jw+GalQ3Q1X0rxtoY8CmFnPHIO661AK9HV
	 vRosvx8dXsu7UeQBwS49yWzzcNDjdT0GgT0P+SyK1BROVXQKQnHaw15WIkL/V92RKSPS2
	 zcJG1nmGeyyAPemDR8YWAMtv6CmZR0yVe9hz0/3P6Q6UCkhYmDBfV2iePKdM+abuh3g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=brivo.com;
	dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256 header.s=google header.b=SGMLePcP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790713967;
	bh=Agk4v8Ymn5xu6SZ/Z7yfgUVeDaKOdMQxGo5LD/IibCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q/7z0rvDwygzt8MHIm8FIa5kFFPRFtZEibvvrpl9x3YO+Mn8KGNgQf1Zzd8mqM17S
	 tuZupy81Y8YC4QCMXVp2cb6OCqFz318Ai6jF/GtU3U2UWIy2UbsUEep9IaYhkg80ib
	 BqdXPjHUw3AOyHngR0GViCvTRhoT4VfL1HkKOVqL9lt81/RGM7sUL1qXYBj4+s+0Qd
	 +EduYqx0MAmAtO7RPZqfKkz1pNfVrUZ0UAV1JbGYy9KQE+Vy04RVIq7puMnOGt9Rrq
	 +XCw0+0y2OpM5e7wOLQpWxWuGRevNK+kVEZhR7FFIMI2eJ9g6uPpXhxp+r18IgYpuL
	 O7DYAxhyWCuYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2D7D407C0;
	Tue, 29 Sep 2026 20:32:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 54D6124E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 17:59:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3B2B6407B8
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 17:59:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 63_SWXyEJzCo for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 17:59:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4A559407B2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:34::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790704784;
 b=TUtmN/qTxCnugNQ3Ynrx1BhosYB0TYJ8Q8NtJZ6Kp135jjt26uV+/xZL+BQlH3qqnVjx
 zFBzVy16OWwIpg/3OGBTA10J7xiFIjkafiFYlHs9t1xQFfJ1KGN3gNKZte9aDcMkWc0Af
 DZnFNxA3HjVudXQRUdRBYsyZqGHzMZ4O9HZPRLJTD6gZpLCjIY5r/n3Ukteur8Rpn2Iwq
 T65zE8Zg1S94EV0f8uKyGpTDY0V3+ZXQNFLyDUgFrBNKHY/Q4fpPdAxf9JkNTjOD3RWmR
 w+iDRyRzfWZ5Cme8N3c7XZLRKW/7Pc5OOqxz6PC0LuDMM6YJQfEV4BFx1LQ3I4FGZeA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790704784;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=Agk4v8Ymn5xu6SZ/Z7yfgUVeDaKOdMQxGo5LD/IibCY=;
 b=nCuJH9N3K3YIHu2dj6ZAbp7fWseo/5xWOa9KSHu2tcRMiEywscFH7q9qsVWAiK9HI/sN
 F+pYA5m5ilyJsP8N7o++MPh/gKZsJxOJZYPLlqrrWwUz0m8ze4wAZyM1rcJyogin/kYK9
 2LbyaVs+xzCJnQnddiVBmNQsfY9USaNM6u7w7SSJF25ojpVjjzjSBsCeZnjsAp426MqSE
 g0PC+30WfJ/rfEpJxIuOVD3jlZVkF6qb5jT9Wq+cSVr0ZHYnn3CoTQUND0Nup3MqMUgKM
 L/14IWLTT0V9saHtlEIsO/4eIjv2BN9Iw1ZS+TjZq3SBvpoRYwRHBgpOTkDO01t5eWw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=brivo.com; 
 dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=SGMLePcP; 
 arc=none smtp.remote-ip="2607:f8b0:4864:34::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:34::c;
 helo=mail-qk2-x0c.google.com; envelope-from=sanderson@brivo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=SGMLePcP
Received: from mail-qk2-x0c.google.com (mail-qk2-x0c.google.com
 [IPv6:2607:f8b0:4864:34::c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4A559407B2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 17:59:43 +0000 (UTC)
Received: by mail-qk2-x0c.google.com with SMTP id
 af79cd13be357-93c5d67aa05so393964285a.0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1790704783; x=1791309583;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Agk4v8Ymn5xu6SZ/Z7yfgUVeDaKOdMQxGo5LD/IibCY=;
 b=SGMLePcP5j8uJlQI0dktScPnRZntfdMXR8+zUPFCMHogL0aIXtFXtFrAXciW5IXgBt
 QZnM5joCgJ9krREhE5MGjKkan6x1q+4PeSv9pVvT8c9/xijlxraDod0fHe3JU07gWyCJ
 O8VzUfsQIr9Lc7bTtuV7SLCaFLx4gmU+OJ28JIiZ9ekyRcuoVJHPplXBjU9XKU45t6nQ
 rFelyV4rbKDhUERaRz9o8ddzRVag5QNm06ca4bWoeDfeIfD0ENERGhrNvThHLR1nk9Yn
 2o7xL8683mCZfb70z1afWy0DMLDkbe8uYvMzrrFLOTeVpFtylSGpIKzMDCZp5OsYS/3y
 kqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790704783; x=1791309583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Agk4v8Ymn5xu6SZ/Z7yfgUVeDaKOdMQxGo5LD/IibCY=;
 b=0K97R8BU9wH+3e1ss3SUk1sG5p5hdX4+xlmmjfiPr2UyKOUNy09a0KfE28Pg2wivAY
 ouqPf8MKk9mXlMXsfnlvRYRT90cEUMXLUa7tuJAzCVgUASh+LO+RseqcZCwiyHU1hKCg
 6UjyQMsgGOjGMNEGNXCxqeiwDBoeDt9/O3AP5pWTIJoYtrccMY44t2cf/4LGzdUtKJ/3
 asiNOWXQ+dql7kxrFmbfoy2TCEiZopIKek6P0+ik2sC4hm93LP9gO3AKcKH2VhxZgQTb
 +Jyoa+jrpKZN9jJHVRSMAAF0A/idkYp15DuD8rAh7yEXhy6k/A/tOArS/4XPYoIZPHXW
 5qnA==
X-Forwarded-Encrypted: i=1;
 AKwUvByizLyQcvM16X2hncOLTzwWlQS4kP1q/DCVawOcAuEFiNK9GF0jSTWdMMHwjhLDxFvskThcjuU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nUjrtvEa+UVSUd2LV38irpLJAmzzGAWc0nU6gPxZnFriqOxjPH
 IfPnSiCvqW+uxEKiSw1xyefa71e8NZimugE1KAMm3K9zFiuL/UlIMn88eOuJeCuGsiNwUxwYyiC
 p5XO5beybfYtj2NGmZyiKQ8eawrt+L4wq1JbcLcWMDLvjnIMvwZnjhx+WaYumco4=
X-Gm-Gg: AYBFou0HBbzRXa9l82MIFNehIoNhsIpZMDj8+RdGkg4FElW3UI/Y4kBW4cN+0N2a/k7
 EDxxeSykZDCdi9wJWq71nn/hIwgbxcMHHcmMUbpz2fVs0fGZMjoTawr0Axkzifz3PjFIs26iWzy
 8n/6YwAafq8tpUA7F62GbZkD+JNkoB8MxvA5xcBBNd826pahLPN+L6S6aouz1nZLzZQTK3PhAcF
 TG1CAe7vh/WcN3teYtQq4+9sSVg3xesNxkxKDdsU/dlczHTuxvArtZldOPMzmtls7SXfW8H90PG
 ACP7NKqJqI6sLrdAH6y7ZFQBow9Fj6onkxrcJe/v39A7ba00EEPuYQXUOo5c3e8kW5sliJJBHdK
 0iWPM4yKbwnZf4kj6rW66LaSAITI/bqTyoif6Ayxh0D2y4JxSq4uWqkzw/JN2WDKWyGjYaoQieI
 y/XPNbEQvAmgJY2OdsI9VnKG+ODoqecuQzam0u9nNTJbqfMNat5drMgFDwjkCl7eQZ
X-Received: by 2002:a05:620a:2847:b0:932:ddff:1241 with SMTP id
 af79cd13be357-93c9f991684mr68310985a.26.1790704781846; 
 Tue, 29 Sep 2026 10:59:41 -0700 (PDT)
Received: from strozzi ([66.193.28.125]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c9f2dd65bsm29923685a.2.2026.09.29.10.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 10:59:41 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Jerome Forissier <jerome.forissier@arm.com>,
 u-boot@lists.u-boot-project.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Sean Anderson <sanderson@brivo.com>
Subject: [PATCH 2/2] net: mdio-mux: Remove ourselves when our parent is removed
Date: Tue, 29 Sep 2026 13:59:32 -0400
Message-ID: <20260929175936.3374213-3-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929175936.3374213-1-sanderson@brivo.com>
References: <20260929175936.3374213-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 20:32:39 +0000
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

 drivers/net/Kconfig   |  1 +
 net/mdio-mux-uclass.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

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
index 14143ca0ab6..a45575f526c 100644
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
@@ -231,3 +232,31 @@ UCLASS_DRIVER(mdio_mux) = {
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
+		if (mmux_get_parent_mdio(mux) != mdio_parent)
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

