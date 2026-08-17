Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D4FC5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 18:17:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4465181105;
	Mon, 17 Aug 2026 18:17:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q1vsbc7k_sHT; Mon, 17 Aug 2026 18:17:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8FA898113B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786990660;
	bh=AUghKkS0pC6hSWB+DdCUpP+oMfD81gFBEmYpmO3NR9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PLxDzeqQxtp1GLum4iYwv5ZbkJ058qjj8C9kpcMVIUrbPYSZu6LgYaCGHZK/KaUvP
	 hGCesCyW/CFJdIayb/wtS2In/d9IJ0DDIPYYHviKIvcsn4S1Rg+SLiGWQZpgCSyz41
	 Ahc4LkYfvtnJJVSu/kMS+qer3FtEJfCF0+TX3YZOSHDgRf2JYHNMFjIZNM/kLe4o0u
	 hXQXv0SdY9U4b8vxP0kUV3w3Uoief3nlSQ8yF7fpydA0/QfCBpb5ZReKXRwyqJkOKa
	 atT6bNfLc21+Sc87RCqr+EAYyZphVAs4VdP+1sV2Hv0+QiP67BP/ODmabhzLB7JxVO
	 dBJ4dFpxQpcJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FA898113B;
	Mon, 17 Aug 2026 18:17:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B0EF42EF
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:16:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9770140204
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:16:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tyU75sjWHhFX for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 17:16:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::833; helo=mail-qt1-x833.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8AD9B401E5
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8AD9B401E5
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=brivo.com header.i=@brivo.com
 header.a=rsa-sha256 header.s=google header.b=BWKYjRBA
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8AD9B401E5
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:16:30 +0000 (UTC)
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-52d7ef16f91so18812501cf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 10:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1786986989; x=1787591789;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AUghKkS0pC6hSWB+DdCUpP+oMfD81gFBEmYpmO3NR9o=;
 b=BWKYjRBAo6l0vMCOUw1/WFham8YHqrGhMeOyuq5AkdFMo9RdBppIA3zn1nrTCa2FEa
 Nr08W3gvU9pQ6C+CBw9PISI65nLEt5/n/0LQl6ujQCx/zdN5JLMETtNY4WKzu9QJdWLW
 K1r5uc42x7fSgcPEnQ0lHy5LpIf0uWv4BV2cnN4fpJuhMNXcgW76J3vqd+mbuq2zN69H
 mAJt+YpYNRDcsSbowY3ANfo7t8nIDTx7f2XEgVw4JA+3pU+BOvt7x6L9ILy6hGk1MiJ3
 83ymewniA4G+l/FcZSDk2yVlgPsxtP1PnzPclJd3c+H16JbBvxuraFxMzPdhzqaEfWLa
 kydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786986989; x=1787591789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AUghKkS0pC6hSWB+DdCUpP+oMfD81gFBEmYpmO3NR9o=;
 b=RtG6/wT8aFGerD3nDVXiF0AVwVaywxUDNdJFfiCof4apE8FwMUcCYIzCMM1WDN21YK
 h4sZ097VBMfX4zyb7YHurx1cZ3YALpYxqTwfFRmdn+3jIDhKFLvybmdZUCKGUjI6zphJ
 gCNtn5zDLLdo7xc3wn9fYViwmu04RUdka4Wx1Qiv1NKnUVF0/mykeazaTotVNxjgbg2G
 IrY7fup0LpCFdZfYuqfPSFXnfKYaF+JmPL9YpztQvLuw4yHMCpU1tF+gRWBx2NsIsuLD
 zW6WsFhsVLNLPG7h+ocdYDlMRYkrMf9PodqcNEWbSqKZhsRfV4pAoegvw4+4ndeo5neC
 BLDw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8fywS3gqbF1+9ZrQrHE7SnsK0GjhI7w7n4kJc710OIlIINv540cvJ7xYAMk1AmVDdrtmOY0g=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw2YyLiAwWjceTdGxif5Unz+g4rqGy7IOwXPO1JppQSD0NGLZTj
 M6M/Wn1cYIcdPoVP9N+XhSY5yJVAGXt89kwly6hHNikdQHLgiEfDeVN2LDPtWfjdB1OLxvUde0g
 XRy06hkZ7ft04YylA9mZjOMade2Z0iqWonCIP2NOPUXJ9UyL7drVqpkfNKHEueTY=
X-Gm-Gg: AR+sD12MWCY4aQyMdIRaegXWeJc9GYDLBMn/Sd0QdhaIem1idDCeUTjTjx6wEgT63Jh
 so5bUNBTE9ClszmsYcRdIdMo5/8vnKxhpqUvWk5nANhDaJ+IU4Vx3Bwy/wEQh0H3+dxQg5M/PXg
 tO+VnHeGPlc+R4cFvFFbZua0bgkuBG4371u60TYPKZcs6cuFFJjk5n4LqaQxwPRCn/02Jot5uY3
 GANwvzIYDlLtTD/R9JFEjYSpQfLrzk6xu23pNxR4AH36VkE/dSaJNWLzj426GvRCoWdYJk8TUBW
 JRM0pqcZ/m9/SnPH0T4CbDmLzpocbGqElaSwGsluUc+d/NxrpyoSClUTi4Q4KEqUZJpX0PDEmCt
 2Bv9On9wbmNAmOOR6v5jN62Iyd6Qy5hnRwN3PmayI0dnYPofmevKSbis9wjyRv/H6Vx1LLcIxn0
 p9t7cBWTg7kA9ow7LV8wl13pytT1Oxz+ccvLrOSQxUlDlimBhJyuVq1Wqu2PU3JFEMmPV1OXXKE
 IpBGRol3bDxr2WHyMBqoZ9jWKQ=
X-Received: by 2002:ac8:59c8:0:b0:51b:f25c:2896 with SMTP id
 d75a77b69052e-52d8535e37bmr271776471cf.11.1786986989038; 
 Mon, 17 Aug 2026 10:16:29 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com.
 [54.236.161.35]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c459783a9sm13637976d6.43.2026.08.17.10.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 10:16:28 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sanderson@brivo.com>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 4/9] clk: meson: Use soc-specific naming for common functions
Date: Mon, 17 Aug 2026 13:15:15 -0400
Message-ID: <20260817171623.1943847-5-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817171623.1943847-1-sanderson@brivo.com>
References: <20260817171623.1943847-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Aug 2026 18:17:15 +0000
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

In preparation for moving a1 versions of several common functions into a
shared file, rename all the conflicting functions to have a soc-specific
component.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/clk/meson/axg-ao.c  |  8 ++++----
 drivers/clk/meson/axg.c     | 12 ++++++------
 drivers/clk/meson/g12a-ao.c |  8 ++++----
 drivers/clk/meson/g12a.c    | 20 ++++++++++----------
 drivers/clk/meson/gxbb.c    | 20 ++++++++++----------
 5 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/clk/meson/axg-ao.c b/drivers/clk/meson/axg-ao.c
index 6ccf52127b0..3215391006e 100644
--- a/drivers/clk/meson/axg-ao.c
+++ b/drivers/clk/meson/axg-ao.c
@@ -35,12 +35,12 @@ static int meson_set_gate(struct clk *clk, bool on)
 	return 0;
 }
 
-static int meson_clk_enable(struct clk *clk)
+static int meson_axg_ao_clk_enable(struct clk *clk)
 {
 	return meson_set_gate(clk, true);
 }
 
-static int meson_clk_disable(struct clk *clk)
+static int meson_axg_ao_clk_disable(struct clk *clk)
 {
 	return meson_set_gate(clk, false);
 }
@@ -65,8 +65,8 @@ static int meson_clk_request(struct clk *clk)
 }
 
 static struct clk_ops meson_clk_ops = {
-	.disable	= meson_clk_disable,
-	.enable		= meson_clk_enable,
+	.disable	= meson_axg_ao_clk_disable,
+	.enable		= meson_axg_ao_clk_enable,
 	.request	= meson_clk_request,
 };
 
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index c421a622a58..e20d3feaade 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -69,12 +69,12 @@ static int meson_set_gate(struct clk *clk, bool on)
 	return 0;
 }
 
-static int meson_clk_enable(struct clk *clk)
+static int meson_axg_clk_enable(struct clk *clk)
 {
 	return meson_set_gate(clk, true);
 }
 
-static int meson_clk_disable(struct clk *clk)
+static int meson_axg_clk_disable(struct clk *clk)
 {
 	return meson_set_gate(clk, false);
 }
@@ -279,7 +279,7 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
 	return rate;
 }
 
-static ulong meson_clk_get_rate(struct clk *clk)
+static ulong meson_axg_clk_get_rate(struct clk *clk)
 {
 	return meson_clk_get_rate_by_id(clk, clk->id);
 }
@@ -305,9 +305,9 @@ static int meson_clk_probe(struct udevice *dev)
 }
 
 static struct clk_ops meson_clk_ops = {
-	.disable	= meson_clk_disable,
-	.enable		= meson_clk_enable,
-	.get_rate	= meson_clk_get_rate,
+	.disable	= meson_axg_clk_disable,
+	.enable		= meson_axg_clk_enable,
+	.get_rate	= meson_axg_clk_get_rate,
 };
 
 static const struct udevice_id meson_clk_ids[] = {
diff --git a/drivers/clk/meson/g12a-ao.c b/drivers/clk/meson/g12a-ao.c
index 61d489c6e1c..e89638d65b5 100644
--- a/drivers/clk/meson/g12a-ao.c
+++ b/drivers/clk/meson/g12a-ao.c
@@ -35,12 +35,12 @@ static int meson_set_gate(struct clk *clk, bool on)
 	return 0;
 }
 
-static int meson_clk_enable(struct clk *clk)
+static int meson_g12a_ao_clk_enable(struct clk *clk)
 {
 	return meson_set_gate(clk, true);
 }
 
-static int meson_clk_disable(struct clk *clk)
+static int meson_g12a_ao_clk_disable(struct clk *clk)
 {
 	return meson_set_gate(clk, false);
 }
@@ -65,8 +65,8 @@ static int meson_clk_request(struct clk *clk)
 }
 
 static struct clk_ops meson_clk_ops = {
-	.disable	= meson_clk_disable,
-	.enable		= meson_clk_enable,
+	.disable	= meson_g12a_ao_clk_disable,
+	.enable		= meson_g12a_ao_clk_enable,
 	.request	= meson_clk_request,
 };
 
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index f33938e1419..cc7bfe9e2a2 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -194,12 +194,12 @@ static int meson_set_gate_by_id(struct clk *clk, unsigned long id, bool on)
 	return 0;
 }
 
-static int meson_clk_enable(struct clk *clk)
+static int meson_g12a_clk_enable(struct clk *clk)
 {
 	return meson_set_gate_by_id(clk, clk->id, true);
 }
 
-static int meson_clk_disable(struct clk *clk)
+static int meson_g12a_clk_disable(struct clk *clk)
 {
 	return meson_set_gate_by_id(clk, clk->id, false);
 }
@@ -858,7 +858,7 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
 	return rate;
 }
 
-static ulong meson_clk_get_rate(struct clk *clk)
+static ulong meson_g12a_clk_get_rate(struct clk *clk)
 {
 	return meson_clk_get_rate_by_id(clk, clk->id);
 }
@@ -888,7 +888,7 @@ static ulong meson_pcie_pll_set_rate(struct clk *clk, ulong rate)
 	return 100000000;
 }
 
-static int meson_clk_set_parent(struct clk *clk, struct clk *parent)
+static int meson_g12a_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	return meson_mux_set_parent(clk, clk->id, parent->id);
 }
@@ -958,7 +958,7 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
 	return -EINVAL;
 }
 
-static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
+static ulong meson_g12a_clk_set_rate(struct clk *clk, ulong rate)
 {
 	ulong current_rate = meson_clk_get_rate_by_id(clk, clk->id);
 	int ret;
@@ -1000,11 +1000,11 @@ static int meson_clk_probe(struct udevice *dev)
 }
 
 static struct clk_ops meson_clk_ops = {
-	.disable	= meson_clk_disable,
-	.enable		= meson_clk_enable,
-	.get_rate	= meson_clk_get_rate,
-	.set_parent	= meson_clk_set_parent,
-	.set_rate	= meson_clk_set_rate,
+	.disable	= meson_g12a_clk_disable,
+	.enable		= meson_g12a_clk_enable,
+	.get_rate	= meson_g12a_clk_get_rate,
+	.set_parent	= meson_g12a_clk_set_parent,
+	.set_rate	= meson_g12a_clk_set_rate,
 };
 
 static const struct udevice_id meson_clk_ids[] = {
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index bf46f4d50bc..24b5f9b5d40 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -236,12 +236,12 @@ static int meson_set_gate_by_id(struct clk *clk, unsigned long id, bool on)
 	return 0;
 }
 
-static int meson_clk_enable(struct clk *clk)
+static int meson_gxbb_clk_enable(struct clk *clk)
 {
 	return meson_set_gate_by_id(clk, clk->id, true);
 }
 
-static int meson_clk_disable(struct clk *clk)
+static int meson_gxbb_clk_disable(struct clk *clk)
 {
 	return meson_set_gate_by_id(clk, clk->id, false);
 }
@@ -840,12 +840,12 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
 	return rate;
 }
 
-static ulong meson_clk_get_rate(struct clk *clk)
+static ulong meson_gxbb_clk_get_rate(struct clk *clk)
 {
 	return meson_clk_get_rate_by_id(clk, clk->id);
 }
 
-static int meson_clk_set_parent(struct clk *clk, struct clk *parent)
+static int meson_gxbb_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	return meson_mux_set_parent(clk, clk->id, parent->id);
 }
@@ -912,7 +912,7 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
 	return -EINVAL;
 }
 
-static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
+static ulong meson_gxbb_clk_set_rate(struct clk *clk, ulong rate)
 {
 	ulong current_rate = meson_clk_get_rate_by_id(clk, clk->id);
 	int ret;
@@ -954,11 +954,11 @@ static int meson_clk_probe(struct udevice *dev)
 }
 
 static struct clk_ops meson_clk_ops = {
-	.disable	= meson_clk_disable,
-	.enable		= meson_clk_enable,
-	.get_rate	= meson_clk_get_rate,
-	.set_parent	= meson_clk_set_parent,
-	.set_rate	= meson_clk_set_rate,
+	.disable	= meson_gxbb_clk_disable,
+	.enable		= meson_gxbb_clk_enable,
+	.get_rate	= meson_gxbb_clk_get_rate,
+	.set_parent	= meson_gxbb_clk_set_parent,
+	.set_rate	= meson_gxbb_clk_set_rate,
 };
 
 static const struct udevice_id meson_clk_ids[] = {
-- 
2.53.0

