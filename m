Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AF0FA373A
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:57:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0B8E88C37;
	Fri, 13 Sep 2024 11:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mYkWdXtg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36A1E88BC0; Fri, 13 Sep 2024 11:57:09 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 371E588C59
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c241feb80dso5836538a12.0
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726221424; x=1726826224;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o+wxQULqTeVZWboi9dNaAJm4xPm5Im/JzcL1kgm415c=;
 b=mYkWdXtg+mjslVVuFUwGUDQW5oP2CJ/piLLFbVxfr+H52YoL3y1eJhiLBLTL9OlJgn
 4w7IfVi1hUKqi0mK0heAvS1m9RM6/tJgmHH3LrO7zWZNP7ZcAX0ulpkbxB2Eo2CWu1i3
 7ib7SIDqwx6BwAF2Aj20kU+/oK26eJPegL4e0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221424; x=1726826224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o+wxQULqTeVZWboi9dNaAJm4xPm5Im/JzcL1kgm415c=;
 b=CXfl5O2wrgDDCpqnwTlQtwSVyAcbbvrHLVTDQoQR9Q5OoBeMj1pxNQ5D4JLz/jvOfo
 /hvcV7rbxzPcZJJSLnD7bdd6m0ZouphRWi96cNaJhiV00J8wxLdufOsgWuZSKLmhu5Nr
 9IsHiJXVX70tYQU5y1wE3kGqiKWOStpJTMWUqM3wrzgY7pApxGavBpUhXr0CL8XmKbOP
 a85kat/IX+gEHqer8iK4jWcSlY7f53G6Y2iwF9PaCNcA7kK2KlN/qz70l0ifUG543u38
 VDCv0B0E5ADlJbknwgIAMOi2IW521ea+HEtNsVmhgDgZ5WB2giY6kWUII5RIxc5Yh+D8
 8Cww==
X-Gm-Message-State: AOJu0YxLBdE7g0P8FTcbmBqh6NtHS2R5L3Y5tl8sr1ehvK2+Loy5kNI+
 fy7PVxfyL2G8+bUNxKHODxs9aLYoo2GkvmT6yrO5ylrTll95u/nC4JG3n3EZDub8aVpXCdDvn4N
 CJpw=
X-Google-Smtp-Source: AGHT+IH3+YuzeG6jwlrgdPU2vP17jIezHu3xUvue/ahkwFNpwa4sboJmwN9DbNFz7ViuyzrYIvmPcw==
X-Received: by 2002:a17:907:1c1b:b0:a8d:4e69:4030 with SMTP id
 a640c23a62f3a-a8ffabc2359mr1172142966b.19.1726221424382; 
 Fri, 13 Sep 2024 02:57:04 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:57:04 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Julien Masson <jmasson@baylibre.com>, Lukasz Majewski <lukma@denx.de>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/26] clk: clk-uclass: Implement CLK_OPS_PARENT_ENABLE
Date: Fri, 13 Sep 2024 11:55:46 +0200
Message-ID: <20240913095622.72377-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Michael Trimarchi <michael@amarulasolutions.com>

There are scenario that we need to enable the new parent clock
before reparent, or we need to do the same with clk_set_rate. The
patch cover those scenario

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/clk/clk-uclass.c | 47 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index e8db9b0ff2fd..b571a3620222 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -582,7 +582,9 @@ static void clk_clean_rate_cache(struct clk *clk)
 ulong clk_set_rate(struct clk *clk, ulong rate)
 {
 	const struct clk_ops *ops;
+	struct clk *pclk;
 	struct clk *clkp;
+	ulong ret;
 
 	debug("%s(clk=%p, rate=%lu)\n", __func__, clk, rate);
 	if (!clk_valid(clk))
@@ -597,11 +599,37 @@ ulong clk_set_rate(struct clk *clk, ulong rate)
 	/* Clean up cached rates for us and all child clocks */
 	clk_clean_rate_cache(clkp);
 
-	return ops->set_rate(clk, rate);
+	if (clk->flags & CLK_SET_RATE_UNGATE) {
+		ret = clk_enable(clk);
+		if (ret)
+			return ret;
+	}
+
+	pclk = clk_get_parent(clk);
+	if (pclk) {
+		if (clk->flags & CLK_OPS_PARENT_ENABLE) {
+			ret = clk_enable(pclk);
+			if (ret)
+				goto out;
+		}
+	}
+
+	ret = ops->set_rate(clk, rate);
+
+	if (pclk && clk->flags & CLK_OPS_PARENT_ENABLE)
+		clk_disable(pclk);
+
+out:
+	if (clk->flags & CLK_SET_RATE_UNGATE)
+		clk_disable(clk);
+
+	return ret;
 }
 
 int clk_set_parent(struct clk *clk, struct clk *parent)
 {
+	struct clk *old_parent;
+
 	const struct clk_ops *ops;
 	int ret;
 
@@ -613,6 +641,15 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	if (!ops->set_parent)
 		return -ENOSYS;
 
+	if (clk->enable_count)
+		clk_enable(parent);
+
+	old_parent = clk_get_parent(clk);
+	if (clk->flags & CLK_OPS_PARENT_ENABLE) {
+		clk_enable(old_parent);
+		clk_enable(parent);
+	}
+
 	ret = ops->set_parent(clk, parent);
 	if (ret)
 		return ret;
@@ -620,6 +657,14 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	if (CONFIG_IS_ENABLED(CLK_CCF))
 		ret = device_reparent(clk->dev, parent->dev);
 
+	if (clk->flags & CLK_OPS_PARENT_ENABLE) {
+		clk_disable(parent);
+		clk_disable(old_parent);
+	}
+
+	if (clk->enable_count)
+		clk_disable(old_parent);
+
 	return ret;
 }
 
-- 
2.43.0

