Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC0A606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=n/tp1o8Z;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=ogX8b8Yu
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E510406CB;
	Sat, 21 Nov 2026 12:35:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FALRB4zDS7ad; Sat, 21 Nov 2026 12:35:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 72F1140810
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264504;
	b=H63YUzR8/R3D19nPw+e5Vb9A+eqQenWXa7yJBhgTiRx/jOKeMA7ZiXYeRHyB/jSVOvL3
	 3kCvHBaULfz0Hhg4/brAEVnfLSqQFZ7IsudTW/yD9uRwIlwFwlQ8mgrnuIKc1ieZsqtLB
	 /WTx4s2ruJbI+F+BkNmOyH031n9z4m5/wotPgZUiMyKaPDCSDYEq0Apd04Aw6d06xXo+e
	 9V77lgXxq0cE3mOxngizpNbwLlbaIzQ2azh/Mle/5H3W2zLYL9T+fLYdYInexP/QXdtMM
	 CKqm8GwPK0xpImLIs1r2pO4nGWkTjwBv9jx69oVj/8PeWzM8drZSk1uNDKUdosejT1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264504;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zzNACd1ZP7NpsAS6XASEq4oQEa7xTpswgLZd6vipclc=;
	b=C4OQpeRg3OcIhrhZLxcDhQZzWw598VFoZlqaXQocww1bpAoxvehEU1cbf06FvcodbhSL
	 ZLzxqmt7105CoaxQUhwIdsJFCLUyupQCUnTtAvEzoeMqlbLjR6rVM1Gt4TIVpwCDS52le
	 HNHfaKqh3dwv47+Vs5j1o8azJI6u3HIgmjrUxFAgRLHhoVfAoZG0dPriPy/YL9/fQiVIB
	 kbzbs+9RyPw5tRw4JO96vmsWGWv6y7KMQzDsRK+19m63oNQDjuzn1lf9Po3VgPxYZlV3d
	 JxR4vg9sm1UnE3xWXnZe60X5GmfxrbGC79MvUsQzRXQ0R2kqJmDQ5j+EMdXWyc4qDtQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264504;
	bh=zzNACd1ZP7NpsAS6XASEq4oQEa7xTpswgLZd6vipclc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n/tp1o8ZZVsv3KdfSkf1yqrjhYypV9I5kuiT/HGLqBD4LuFH7lKTpLcquap4POWT0
	 9QahBhI0/+Qdw6uvYnF4jFIr2/B5nL+5xyEY4abZOAHXQWtPSflfyZlWt/1hmOpQzK
	 Oyp732Sa8uGrjgHe/x5nr4+irdB3gt0KRzfiFUGTbEwlFcfFP0K3C4jCv72uTq3XUp
	 TYQe2NS8EbErxKheQv2ZqWcm2hQCbD/5sufQDQSv1Lc3FwHFkciODvIdYVH/9L1crT
	 /La56akXuSl/BmCbbp7dUL4G/gHiWOOrQgIscsVtGi8LfpMjFFInCw55PMqIfjBfCm
	 t+BhmsNHy6fZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72F1140810;
	Sat, 21 Nov 2026 12:35:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FF5F465
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6DC48605DA
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hrIbaopn7wED for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5C4F4605B7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=ogX8b8Yu
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5C4F4605B7
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:34:59 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-491f34b4e0fso818288f8f.2
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264498; x=1795869298;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zzNACd1ZP7NpsAS6XASEq4oQEa7xTpswgLZd6vipclc=;
 b=ogX8b8YuK9jHf9z4uf3EIzEk7iROikWdwnhQ7S2P5WTWOj91/A2ypTHpOSAXh2ghz0
 lrLOkkaPepBdVPcMxBAcBBYX7cJxg0WYAkIuruHcuWeawfIZMpW4L4WuAlZHx007gxZj
 6W4bGJuLYDktwxKZyuA7khL73OFsxY3rQdByc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264498; x=1795869298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zzNACd1ZP7NpsAS6XASEq4oQEa7xTpswgLZd6vipclc=;
 b=K+AUxb/2dNRW0gPg7Wfc3NyqM10nM1gt4kD0FU84xTYyqRdOCDOw0P1OzJyxO9HPPI
 pA8UI27gvNPK6bU4UNu3TR2PwSSMZA/zArw5Qwhg7/kalxcnouUUIIdSlVHevYNbgps4
 7Is+tAUPSBsXAymTVgaKM/zS6vaFly2VahWbVhht2XjGlsplbVItIDk9ZD4Q3TJQW88C
 zSEfCO+uoytchnBsTQqKCzUITTp1tUILxORn/0iHZuYaV3JYiCvs1PB+21xprh7aUxm+
 0DXWjYtt4ttS9eRsFnKukLmcIs7FBkAsaqAWDAIb+dWoY8kDYq9g7HJrLeqlN0Oqd8EU
 crEw==
X-Gm-Message-State: APuU4Z9gVVjAJzFZNndrqyV4fnr2rf9AmbnrLiA13sc4DA5M5avtHUqy
 6AgqCS/JWQpGoujlAHDLYI7TkpoKOYRkZlflafcdFs2HAqYANteXlXosW9RBv64AfJiF+wlomSO
 14aAv
X-Gm-Gg: AZFdTZfAq1FjZGpcUU/jGm49oBd4mI/+WAaDmJ9kv15IjS35fgESsg7YM+I2sktTmZM
 25Jzk3h0jUiRd2KSKi8bfBY7f0mh+hdV1fp6kVo7z12zo9Dz6jyR6iXL8TCUEtor3CEHoMCGqwe
 q11UTOR9XNzi05/2Fmolc1BVyfJvYxFhWsCXm7aHqGS9Rpvdt5cquR1CAhL/S7iCbXx9oxAAOhH
 FKcCatHSAVKnZ2Ep/U7IAChD5q1Fi978T8zoBLIX/ea7xSIbSVyXmsdNnAjxPS6UfzbMIEM7k5z
 Q/EZ59o2YmlTfHy0wNI08ti41QNZgYmRxLrmUNx6WvxaPkgzDAITlMPL0RQR1swQYG9xzidAdw5
 rzOYrhOtA2chwsiIkH+rLWrsVORTag9nzsDm8oJ/z3gtT0ksdiQXfOF264hm4TWZ+3CGsyxtSpC
 6YTtQ2jqiyLwsH4c4vWk9LSAMxN0vRF2wcyPz1JeZ8bnIX6uPt4dd+lCnKhfo1B1aqzQA526qmZ
 kQ9kT9bYiVLDbQ52FTLqrLOA0wTm8tVoWBi+xrP2ZYKXfZHDuF9Ls5wSD/BkjaV+tevIJMcHZFf
 tgEgVXvQtHNAGPtyE0EkgKc/2g+09pv25PSwTLlEf053FmPs4d7XvGoM2MIH/XfMAVeirydc3MK
 9ftT/Z4NwYEHL4Uib6MKcKvpNBLvRol0xyjuctrT4i2SnEgY5Q4ieteQxA8I03+3MojBPEU05/F
 vzNbaQdhlkmtM0QIJyO55YqhNPaw==
X-Received: by 2002:a5d:5f51:0:b0:4a5:a777:b5d5 with SMTP id
 ffacd0b85a97d-4abb4c7aad1mr11910003f8f.55.1795264498102; 
 Sat, 21 Nov 2026 04:34:58 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:34:57 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Brian Ruley <brian.ruley@gehealthcare.com>,
 Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 01/25] clk: ccf: enable the critical clocks when they are
 registered
Date: Sat, 21 Nov 2026 13:33:51 +0100
Message-ID: <20261121123451.2471185-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
References: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

CLK_IS_CRITICAL only prevents clk_disable() from gating a clock. Since
nobody enables a critical clock, its parents don't account for it, and
a parent shared with other clocks is disabled as soon as its last
non-critical user goes away, e.g. on reparenting. On the i.MX8MN this
turns SYS_PLL2 off while the display clocks are set up, and the system
hangs.

Enable the critical clocks as soon as they get an ID, as Linux does at
registration, so that their whole parent chain is accounted for.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

Changes in v2:
- Add patch, replacing "clk: imx8mn: Mark IMX8MN_SYS_PLL2 and
  IMX8MN_SYS_PLL3 as enabled" with a generic solution

 drivers/clk/clk.c            | 15 +++++++++++++++
 include/linux/clk-provider.h | 12 ++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b8c2e8d531b9..1e735c8fb2b4 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -13,6 +13,21 @@
 #include <dm/uclass.h>
 #include <dm/lists.h>
 #include <dm/device-internal.h>
+#include <linux/clk-provider.h>
+
+/* Let the parents of a critical clock account for it, as Linux does */
+void clk_enable_critical(struct clk *clk)
+{
+	int ret;
+
+	if (!(clk->flags & CLK_IS_CRITICAL))
+		return;
+
+	ret = clk_enable(clk);
+	if (ret)
+		log_warning("%s: failed to enable critical clock %s (%d)\n",
+			    __func__, clk->dev->name, ret);
+}
 
 int clk_register(struct clk *clk, const char *drv_name,
 		 const char *name, const char *parent_name)
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 366f2d968a33..c09f56b2b57d 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -15,17 +15,25 @@
 
 struct udevice;
 
+void clk_enable_critical(struct clk *clk);
+
 /* update clock ID for the dev = clock provider, compatible with CLK_AUTO_ID */
 static inline void dev_clk_dm(const struct udevice *dev, ulong id, struct clk *clk)
 {
-	if (!IS_ERR(clk))
+	if (!IS_ERR(clk)) {
 		clk->id = CLK_ID(dev, id);
+		if (CONFIG_IS_ENABLED(CLK_CCF))
+			clk_enable_critical(clk);
+	}
 }
 
 static inline void clk_dm(ulong id, struct clk *clk)
 {
-	if (!IS_ERR(clk))
+	if (!IS_ERR(clk)) {
 		clk->id = CLK_ID(clk->dev, id);
+		if (CONFIG_IS_ENABLED(CLK_CCF))
+			clk_enable_critical(clk);
+	}
 }
 
 /*
-- 
2.43.0

