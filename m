Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173AEC369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 12:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF1BF82F5A;
	Thu, 17 Apr 2025 14:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a+RslwIN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F30B82F5A; Thu, 17 Apr 2025 14:32:07 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06DDE82D18
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 14:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2279915e06eso7632525ad.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 05:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744893123; x=1745497923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D74wRYmfWB0bHx3XbyXpy6+1p/LRNvauJXI6QAKlMmU=;
 b=a+RslwINLJtFqC6sZkSpu1+j7H1x+x7lBDJ50wxFKSmCB3fMNSlzupumH/HSBsVWeE
 cR6UTJslGx+FTu4Tdtfr2WeZK2KTqo4X61Ke4TVOqzTfPTJjnxk9sSBSeLXLwKJU+aII
 KutQM8pck7b2vF1iemJalKd+h+mKbfx1spJhcjJ8Y5jst8zqr1EGSn4eldORu9s08uTh
 Fal6gha1yIXPWQ+p/X4a5RzMUZNRawICm4U8CBfFEylfWZF9J/ZqSnjQbKy0IbwF8TaA
 Uz/0fM2eXx66KP8/dtW8eGM0fwfN7D7lKQcc0B63a5ajKFiB1Z8cXw9M0rBZ8hX4DzhU
 m8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744893123; x=1745497923;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D74wRYmfWB0bHx3XbyXpy6+1p/LRNvauJXI6QAKlMmU=;
 b=VgZsBgwI7Rkq/FH64gt9mCns6ddOuZPYsgAZ8GeDFwxKc9npJ7olVq/kdVVxUTfB00
 wmarm8uTHd64j93ByZO5cd/a26oZ/pqGqExYcJ3rlapkZz7VwE9omiEZKQy47BQjOUzj
 XlzxH/+fOj9tZKVxlUaJk/yVXnyrAIIr1mB154xG8E72Jx/PeeH8CWzgs3ZURgHiLtq4
 gd/LPqAtS84bLC3ArfSV7+OgVJGwcwfEd/I21FesrYvxYWwiCdw7d6LGZkww5sp+tQgT
 yQcVBVpKjgv+vczqpabLltrxyiKC0bBnn3WZwyDyWPcYP3DENv2hBT8zHVt5nCMf6IpE
 Vclg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjZ3FVjf//lv3sPYbkR3jB5uu+0H8dUycZtDeDsk000XxxoZeDnY+zWwUkzFCGvDl+YY5bncE=@lists.denx.de
X-Gm-Message-State: AOJu0YwMRWmgr1+WT7aRJLh5LLxlK+7W0mp+BnYwYLocUZG+wfGzqvZz
 k0AoENeLltZIQoK20B0rkiMnyhjmPS7LZY3HYttb3+bJiAUwuxFGRoj/QQ==
X-Gm-Gg: ASbGncuP/oKw5rHca50QEj5FYMPkXNW5c3wyjwzgxBCuZGPRdJqqTG4v+Kofknqsm64
 9NI+vqPDURlN7+pgFWmKo9v0P5oczZxEw9BdquSSu3+An7uxJB0/KCVddev8+b76WclGjFp1Z+T
 KcrEE6M+YU2qBdsbDHXfAc4siK1On+inzqegYPgqZThXZtZCNIxadrwuAWl9fFWkWue3kqYcxb9
 DUCj7A7EX5nQGc+OYGEOxqk2qFWtV+gClk8ajSVJfhzf2QOVaTdw/GQHLRs5tQpJWlYMMzcOsNP
 HtW7hXasXBOXNj/s7Jb6eNdjJoROk3yq4PUyiOzWDgdeYIRSu+6Reis=
X-Google-Smtp-Source: AGHT+IFXgcSru8rwIrxIlTHvUJgtAPqqMk/4+PmIuTaYFkqXRKxqPqRsOh4Eslpjp2qReUjqEtx0tw==
X-Received: by 2002:a17:903:1a0d:b0:215:b1a3:4701 with SMTP id
 d9443c01a7336-22c358dadfdmr86395255ad.13.1744893123383; 
 Thu, 17 Apr 2025 05:32:03 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:579d:5312:b7a3:7e17])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33ef10d1sm32002485ad.12.2025.04.17.05.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 05:32:02 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 francesco.dolcini@toradex.com, aford173@gmail.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH] clk: fixed-rate: Use "clock-output-names" to name fixed clocks
Date: Thu, 17 Apr 2025 09:31:56 -0300
Message-Id: <20250417123156.2526548-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

Currently, fixed-rate clocks in U-Boot are named based on their devicetree
node names. For example, given the following node:

osc_24m: clock-osc-24m {
	compatible = "fixed-clock";
	#clock-cells = <0>;
	clock-frequency = <24000000>;
	clock-output-names = "osc_24m";
};

U-Boot registers the clock as "clock-osc-24m", derived from the node name,
ignoring the clock-output-names property.

This differs from Linux, which uses the clock-output-names property when
assigning clock names. As a result, clock consumers expecting names
like "osc_24m" (as defined in the property) may fail to resolve clocks
correctly in U-Boot.

Update the fixed-rate clock driver to check for the clock-output-names
property and use it as the clock name if present. If not, the fallback
remains the node name. This makes U-Boot behavior consistent with Linux.

One concrete impact is on i.MX8MP, where USB clock lookup failed following
commit b4734c9c333b ("clk: imx: Convert clock-osc-* back to osc_*").

With this change applied, fixed-clocks are correctly registered with their
expected names:

u-boot=> clk dump
 Rate               Usecnt      Name
------------------------------------------
 32768                0        |-- osc_32k
 24000000             5        |-- osc_24m

This change restores i.MX8MP USB functionality by ensuring the proper clock
names are used.

Fixes: b4734c9c333b ("clk: imx: Convert clock-osc-* back to osc_*")
Reported-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/clk/clk_fixed_rate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/clk_fixed_rate.c b/drivers/clk/clk_fixed_rate.c
index d1da05cc18a5..7b89f9c80e95 100644
--- a/drivers/clk/clk_fixed_rate.c
+++ b/drivers/clk/clk_fixed_rate.c
@@ -35,6 +35,8 @@ void clk_fixed_rate_ofdata_to_plat_(struct udevice *dev,
 				    struct clk_fixed_rate *plat)
 {
 	struct clk *clk = &plat->clk;
+	const char *clk_name;
+
 	if (CONFIG_IS_ENABLED(OF_REAL))
 		plat->fixed_rate = dev_read_u32_default(dev, "clock-frequency",
 							0);
@@ -45,6 +47,16 @@ void clk_fixed_rate_ofdata_to_plat_(struct udevice *dev,
 
 	clk->dev = dev;
 	clk->enable_count = 0;
+
+	/*
+	 * If the "clock-output-names" property is present, use it
+	 * as the clock name, like it is done in Linux.
+	 * Otherwise, the original behavior will be preserved: the fixed clock
+	 * name will be its node name.
+	 *
+	 */
+	if (!(dev_read_string_index(dev, "clock-output-names", 0, &clk_name)))
+		dev->name = clk_name;
 }
 
 static ulong clk_fixed_rate_raw_get_rate(struct clk *clk)
-- 
2.34.1

