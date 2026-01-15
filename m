Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F67D3CCAE
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 04:47:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C17383623;
	Thu, 15 Jan 2026 05:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jkdHYUM6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54C73803F5; Thu, 15 Jan 2026 04:12:55 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F7FF80077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 04:12:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chiffathefoxx@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-64ba9a00b5aso591102a12.2
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 19:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768446773; x=1769051573; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OlSLpxW0qgY002hZetq90Tzq5xKi3B/YpfA6+fll6MM=;
 b=jkdHYUM6ket6QZt7IvwdTRCmG0946a3Z7Cd/gdY8j68+eRY9BFSszi7rbQ9gX76VrJ
 CNlt2shxmuOUI5JBRhWYF5cjf28HQintKRMUtuwWL4tN+/l6UJRVFBWjeZDOhxvnRf9O
 FylLZjuF28W04Q4xo5CQqO1zSeGGqLJHMpPDCEc3RjQ3/ioE4mv9FzcdpNM89Ushu8ou
 gq5kVILUWfhM6OoA0D+01znVkZEcIV7Tvb9ulXlfBIQ3FFVQoRLzuErMd8AWBg+Zit1c
 nHASo0Ovrm3tgRLvdC9xdN/dODYPpFW0GqYbGExIGFgLww3ps3LYKk4IEA0HyRhvpdRQ
 FMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768446773; x=1769051573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OlSLpxW0qgY002hZetq90Tzq5xKi3B/YpfA6+fll6MM=;
 b=V8+A7qVAmDEtRqDoDruoYiVIMOJjTx1b705hTWR8BvoumxGd6gI3E5HmVuUf+rFN9T
 0xXVAxRZbtc8O41D959GWMJnJRHTRA8q6nkUOn2mKrOWFejuP9/tR5JiBJJiWrkCl6fe
 lfCcGgUis5hCcGGSw4xim6cImaMQ7hlE2RCFhDuDz5AE9I4PkOZpcMmWIjSW5oGhzRw5
 KdBwKiJ/2v1psClPz/cZFAh3NUVt9bbc0y3YH5uDdftVEO+hCxPy8o2UfwiIqazX/vBa
 N+QZGJlgpBQKTOfdpWVXBkc4cRiHneGF0MY+/JJ9WBP5Mdi+UF39Qs5TOxwetZD/QYbp
 ACJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/NuR2fzTTRHIQjhWy0MuQ5/m+7kdBeDfWLsjDEbGlWmantVAK5Pq7jlzGcWdN7tCyPfK9B/A=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8ORm0YCsQlL7Wd8gbZBAWhCPR5Om6BlhGzFMsP5/scGPlKw1p
 if6qcVsnwwPnNtGlRzYWUvRweiiqiolPSEBZShkycVZzeV3adCBivj1N
X-Gm-Gg: AY/fxX5SBXK45R5kDRwt+ep3BkAWxD24d0U0lmLqb3Kz7CGPg5nDq4POQ451B8ozLy0
 9ddj+8TDmkBlDPgGxdckp2uNTWnTtx2rxhl2my9o+Bwx3wdEx7SbVgM6bpnjqM4OZjr39Ue+CCm
 hcVWe2al9aoxuvPlTmQpQAVkuhr0QWom4JyGkEDAz0WmW/GOBI9jFPjh0xPcwWDKyKrD1BtRKBf
 eNBjZPD79ecalt7chxGOBFPtk859ptaldx9UOlgqCHGX3o6WNyOOVgo2uN1h371A7nGLnm1r6q6
 ZnW3KOB40tKLtrRRn4T8KtoEnKF0XFZWvXuHibLKt5NOskxwf97ohnF5wxKU8ju7Z98j754xIWr
 ysduIxGrGUjJTh+wb/8BZa/DVEsG25Z4h2adIEOvGrzzcSu3fbbSf51EaMTFzWAWUFZDE59gNr4
 1Pc7dy3oo1Sw==
X-Received: by 2002:a17:907:94cb:b0:b80:751:ee62 with SMTP id
 a640c23a62f3a-b87610632dcmr382159666b.14.1768446772553; 
 Wed, 14 Jan 2026 19:12:52 -0800 (PST)
Received: from desktop.. ([176.100.0.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b86f9a9103bsm1341263266b.30.2026.01.14.19.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 19:12:51 -0800 (PST)
From: chiffathefox <chiffathefoxx@gmail.com>
To: Marek Vasut <marex@denx.de>
Cc: chiffathefox <chiffathefoxx@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Lukasz Majewski <lukma@denx.de>, Maksim Kiselev <bigunclemax@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, u-boot@lists.denx.de
Subject: [PATCH 1/2] clk: clk_resolve_parent_clk(): resolve external clocks by
 id
Date: Thu, 15 Jan 2026 05:11:13 +0200
Message-Id: <20260115031114.220888-2-chiffathefoxx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115031114.220888-1-chiffathefoxx@gmail.com>
References: <20260115031114.220888-1-chiffathefoxx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 15 Jan 2026 05:47:38 +0100
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

When referencing clocks in DTS registered by another driver,
clk_resolve_parent_clk() is supposed to return the name
of the child device that provides the requested clock.
However, in reality, it returns the name of the parent DTB
node (e.g. clock-controller@1a240000). Such devices, for
instance the exynos7870-cmu-peri driver, do not store any
clock information in their dev->uclass_priv_ because they
expect you to call dev->ops->get_rate with the appropriate
clk->id. So when you try to resolve a clock that depends on
an externally referenced clock, the resolution fails on the
parent clock because it doesn't have a  dev->uclass_priv_.
With this change clk_resolve_parent_clk() will take an
extra step to actually resolve the child device.

Signed-off-by: chiffathefox <chiffathefoxx@gmail.com>
---

 drivers/clk/clk-uclass.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 0584429bed6..bea45fc396f 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -430,6 +430,7 @@ clk_resolve_parent_clk(struct udevice *dev, const char *name)
 {
 	struct udevice *parent;
 	struct clk clk;
+	struct clk *c;
 	int ret;
 
 	ret = uclass_get_device_by_name(UCLASS_CLK, name, &parent);
@@ -440,7 +441,11 @@ clk_resolve_parent_clk(struct udevice *dev, const char *name)
 	if (!clk.dev)
 		return name;
 
-	return clk.dev->name;
+	ret = clk_get_by_id(clk.id, &c);
+	if (ret)
+		return name;
+
+	return c->dev->name;
 }
 
 int clk_release_all(struct clk *clk, unsigned int count)
-- 
2.34.1

