Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8890E1076382
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 14:35:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9AD08414B;
	Wed,  1 Apr 2026 16:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ewzWSPqS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60085840F1; Wed,  1 Apr 2026 16:34:25 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9BC18414B
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 16:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-486fb14227cso92522975e9.3
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 07:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775054061; x=1775658861; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UzL2sauUwr+llsDzghXaGJvUYu2Z/A1MC81/qWtrgGU=;
 b=ewzWSPqSR31WbUyT4S1vtjZyb3yvwLM3rxwhO6vtS1YrqNttJgxVtzzTYMvg7dUUw1
 8TSsjwA/OPIe1igUF+tscjrfcoNhsZikfqoAtQON5P6c+9wRbkriOkTkmIfYBsvJJbS3
 eGbuOx5OKJj6OYSL/5rvbd8ER0I2a6xR9pwTMRQqUT6qQTfsaoXPxUUlheStfladEepo
 x7bYRPY+o4nGFpLYVp7dO0vWPh8bt0+Zqim/owMz3IyfRNe7irl+O2M5HyfaNOzYPMAk
 GcK4hTZ2o/y/bg6X+1xb2h6wIZafjeUm6BHrOTW5IYnVTjqZJdfNInHNqx7QuSVzoAE8
 C7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775054061; x=1775658861;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UzL2sauUwr+llsDzghXaGJvUYu2Z/A1MC81/qWtrgGU=;
 b=p4mwI2Bal1qbFOtPPx40tnR4t90GQObKy5nf5cPEX4WGGenvKhl/b7Ei+p9+fPuDSG
 1NSNydD2wNlphkedtLgHnrRqHX77auvFAcmmlFyweQZQjopfkYnWJzsPEWfgDNAYIlgp
 RJU9Es8V7Q+NMNUV24dZfxiffxHkm95HG+PRltJZAOnMqflmdx61bBil7pmKFArsEx1m
 +4srnG6od0Z21+Qx6/J48uiVqCNQ1Z38qFstxc+iXVfp3Akl3h7XoKejytYvX/KsmZU2
 D+DfM4T77ecr+3boYfw8sXY7qO7shS2X0C3hypUa7mqVh2EZ7suGuWEBA+w7Yx7FhVff
 Fr7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPsgSpGTg8qx2t0KoFXiQe4IFQ+gzDkuxxmHiPKkyVGY9VO/pbeZ2XZmFsu6QO282uleWRDEE=@lists.denx.de
X-Gm-Message-State: AOJu0YyTxgZ01XtX5MMZcdv2HvAns4WwDxOCSs7XntAHjj4qIe8CLMVg
 nECZ9+CsVRdbRB/5Ubzvh9QJw8blF2GIQpVm/Qbff/vkJWggBZi8etFEeA8gQ5umlZo=
X-Gm-Gg: ATEYQzxaVXHp4qF54Y8ID00LQrSIVZE4X4D5e90PJxk2vAE31ejz6zRuYURTrcbcfXN
 trC48E0+Xhd6IXu63ogIJ8lHy4UN5Dr7BdE9I9wNo04PUpkB9qHz0+HzWyIuvyO44FRnzXp7joW
 oXhJMcfn50vr3M48ChKnOiUlcY946vz48yGUiyudTeBXb/YOcKt5WB0dGRUlRNM/bN6pM0vw937
 xOzJG79VD60DoDsvvn/f6erJzTrijQvcpksBzUxIwKHcHLJwjYFaxias0A4eAuKmy0HkWLJ5qJN
 11LAQzHwqzUHN16CnsxCb6eo+fnopsLWku+eNyDVmbZ2OO9HCJyYn1SQGdglG8FNGedZqV/CqpW
 yjpYKCA8I+xjjIIdV8Qw6KxJPLNgZh+eGzz+iNByLOaXP30nKglwmpsOOpbx9pR/qnz1UGQcy+6
 RBKvtFIUfLwoSOh1YIKHznNB6KdN6SngStq42KKo05v6kOD7st+4ycMujFO5lM6qRz4wej
X-Received: by 2002:a05:600c:1e02:b0:487:4eb:d125 with SMTP id
 5b1f17b1804b1-48883575cc9mr75812185e9.9.1775054061172; 
 Wed, 01 Apr 2026 07:34:21 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e80a63esm161821795e9.3.2026.04.01.07.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 07:34:20 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Wed, 01 Apr 2026 16:34:08 +0200
Subject: [PATCH v2 7/7] clk: compat: add clk (un)prepare and associated
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-casey-ccf-clk-prep-v2-7-16a78c8c62da@linaro.org>
References: <20260401-casey-ccf-clk-prep-v2-0-16a78c8c62da@linaro.org>
In-Reply-To: <20260401-casey-ccf-clk-prep-v2-0-16a78c8c62da@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marex@denx.de>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, u-boot-qcom@groups.io
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3067;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=IDjDTfUKfPC9O3Xt5VwKw5S4av9GhFWz+Ya5oltXAzA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyzOo9ZHsuuWPv1vMOe4KdrTQu1NAVezkic5cPxL9KnK
 XavsvWvjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRl+aMDM3+VaIGy17ZvNxg
 57ir2/ZhVWevn0mn6VXLVX6aqo27khj++ymtlTn4mD2ituSnwrT35qmmvbzFnGumnvR+Lvzf2zI
 nDwA=
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Introduce clk_prepare/prepare_enable as well as unprepare and bulk
associated functions. These are just stubs but will be used with
CCF_FULL.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/clk-uclass.c |  7 +++++
 include/clk.h            | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 095329e25f15..e960d2ad2383 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -837,8 +837,15 @@ struct clk *devm_clk_get(struct udevice *dev, const char *id)
 
 	return clk;
 }
 
+int clk_prepare(struct clk *clk)
+{
+	return 0;
+}
+
+void clk_unprepare(struct clk *clk) { }
+
 int clk_uclass_post_probe(struct udevice *dev)
 {
 	/*
 	 * when a clock provider is probed. Call clk_set_defaults()
diff --git a/include/clk.h b/include/clk.h
index 0520032f692c..6ae033259cb1 100644
--- a/include/clk.h
+++ b/include/clk.h
@@ -514,8 +514,35 @@ long clk_set_rate(struct clk *clk, ulong rate);
  * Return: new rate, or -ve error code.
  */
 int clk_set_parent(struct clk *clk, struct clk *parent);
 
+/**
+ * clk_prepare - prepare a clock source
+ * @clk: clock source
+ *
+ * This prepares the clock source for use.
+ *
+ * Must not be called from within atomic context.
+ *
+ * U-Boot: this is a no-op unless CCF_FULL is enabled.
+ */
+int clk_prepare(struct clk *clk);
+
+int clk_prepare_bulk(struct clk_bulk *clks);
+
+/**
+ * clk_unprepare - undo preparation of a clock source
+ * @clk: clock source
+ *
+ * This undoes a previously prepared clock.  The caller must balance
+ * the number of prepare and unprepare calls.
+ *
+ * Must not be called from within atomic context.
+ */
+void clk_unprepare(struct clk *clk);
+
+int clk_unprepare_bulk(struct clk_bulk *clks);
+
 /**
  * clk_enable() - Enable (turn on) a clock.
  * @clk:	A clock struct that was previously successfully requested by
  *		clk_request/get_by_*().
@@ -550,8 +577,49 @@ int clk_disable(struct clk *clk);
  * Return: zero on success, or -ve error code.
  */
 int clk_disable_bulk(struct clk_bulk *bulk);
 
+static inline int clk_prepare_enable(struct clk *clk)
+{
+	int ret;
+
+	ret = clk_prepare(clk);
+	if (!ret)
+		ret = clk_enable(clk);
+
+	return ret;
+}
+
+static inline int clk_disable_unprepare(struct clk *clk)
+{
+	int ret;
+
+	ret = clk_disable(clk);
+	if (!ret)
+		clk_unprepare(clk);
+	return ret;
+}
+
+static inline int clk_prepare_enable_bulk(struct clk_bulk *clks)
+{
+	int ret;
+
+	ret = clk_prepare_bulk(clks);
+	if (!ret)
+		ret = clk_enable_bulk(clks);
+	return ret;
+}
+
+static inline int clk_disable_unprepare_bulk(struct clk_bulk *clks)
+{
+	int ret;
+
+	ret = clk_disable_bulk(clks);
+	if (!ret)
+		ret = clk_unprepare_bulk(clks);
+	return ret;
+}
+
 /**
  * clk_is_match - check if two clk's point to the same hardware clock
  * @p: clk compared against q
  * @q: clk compared against p

-- 
2.51.0

