Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D9FD3CCAE
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 04:47:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CDB180325;
	Thu, 15 Jan 2026 05:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VyBYclpb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5438C803F5; Thu, 15 Jan 2026 04:12:48 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20C4B80077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 04:12:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chiffathefoxx@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-64b9b0b4d5dso975125a12.1
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 19:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768446765; x=1769051565; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5YN3IvwG0slHF5rWZsgLCd56+wAXUCZO+4l7UK93eWk=;
 b=VyBYclpbjcRERUYhkghUhVFlnpcqmDYvcesI3Q2o9x3dZVUqdDUhQL8s7OptY9pXCd
 B9vMTd68mzZVLfLADp4LsfJCIEFb6gAtsH80DbRKbnwELgQh6fPFuoyUTI3twekIobd3
 g7h0s4OD7A/gI8+UYCptNghXvTGMN47rl96ohJ3CESKUFiutn28WdqD0Bkv/lxf48Bbs
 RIKVaLZciL139h1BTs4/Md/1Iuq3Rxu3/N6iVKpju1wYjij2G7X9Y+YRZPxcLtLCeURG
 ZxhTfyFnX5fSY+l6bo1TJI7x2wxSLXf4ShYWRzUWAKbOJTI39UvVdYl4OnILwpst4jF7
 UaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768446765; x=1769051565;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5YN3IvwG0slHF5rWZsgLCd56+wAXUCZO+4l7UK93eWk=;
 b=jkDR6mGd+MffUdiRBeXfSVc2ZbL0iRAja8Ozs+EDdn0bv1vzz0yFdb3UqtGgVAHxJ8
 myioE47e20OR4ONDbU4jQEDStYJLwMc4dzVeDShUUleNCP6n8wVKRv249D944BU5wGSl
 FLbewU26gDDhjlCn8GpYnK/7hmXX7UQguSl8DdVfWo0CpjH1S86QHvKccSNOX05BM6Jb
 Yy+5soWB4HerR4wmCIQw/vqR8MQoJquVk4vwdVB61bswV3U8OWucEerMcQV76aLdDx7C
 EJBpQtU4ATNjJI+MTQF7QjYQ7uesb02tn3gJGmQzw3kcO4abuxQD3Sr8nRwf7s5EEdWr
 fpmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB7rp6kj+zhjoklrm5p9rBNDhBWTOGA1OiBi956/TrbEzJV4CDBirq45+n+jix54P5WrtP3FY=@lists.denx.de
X-Gm-Message-State: AOJu0YykXhUf4KMh0c2CueY0VSdquqivL3BlfH5PcfCM5NqfbCdoff4R
 UI9YQAGgQYMaJCjF2gdGjM/pDBtOh5dhadcC2Pn/jWh1Jf5T98NBuCgW
X-Gm-Gg: AY/fxX6EHVHPQ+zwltPSQ6JvcqMi5bqCm4WfrsCDRfTMMX7iXQUvm0njylZAkN2Qtgq
 579HMWQ640ty6p3/PUaBOB2IZjRXzNcdhKDQ+BcwN+d+vucS/e7sV+5M+YWCbtGx5Dmq1zqz3wG
 Z0eK+MvQZLkqxEO5AT4mow81XVHbE3UvV5D77aOHIMcplrcZ+f5dh7u8kVg3Xc1KOJWNVG1Ch4A
 aktSNi50jY2hg7RfenyqofeOEtDnDOxJTIysqEnbq4aOeFiAF3fxam7BWecE/W72K6h5OBI4mjk
 WCcYtVZoA16Jl2jQ0qKesgQeF0zZtLa4EKkEvy7cvvuCRe6qt7SDgWmJ/VBIPCrZMWVX1FLqChJ
 0na53fUjKlXehsxG8i4CdWuyv2ICne3YNYnzaFt7Ib4qzIcezHnG+R9LHWO0qw9CNVM0cVgOVD7
 Y=
X-Received: by 2002:a17:907:6d07:b0:b87:1ffc:2fba with SMTP id
 a640c23a62f3a-b876126d6f0mr455693166b.43.1768446765332; 
 Wed, 14 Jan 2026 19:12:45 -0800 (PST)
Received: from desktop.. ([176.100.0.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b86f9a9103bsm1341263266b.30.2026.01.14.19.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 19:12:44 -0800 (PST)
From: chiffathefox <chiffathefoxx@gmail.com>
To: Marek Vasut <marex@denx.de>
Cc: chiffathefox <chiffathefoxx@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Lukasz Majewski <lukma@denx.de>, Maksim Kiselev <bigunclemax@gmail.com>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>, u-boot@lists.denx.de
Subject: [PATCH 0/2] Improvements to the recent clock rework by marex.
Date: Thu, 15 Jan 2026 05:11:12 +0200
Message-Id: <20260115031114.220888-1-chiffathefoxx@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Symptoms:
I ran into an issue with the generic ccf_clk_divider clock driver. ccf_clk_divider assumes that the pointer passed to clk_divider_recalc_rate() (https://github.com/u-boot/u-boot/blob/master/drivers/clk/clk-divider.c#L80) is the same that was kzalloc()'d during clock registration. This assumption was breaking when calling clk_get_rate() on a clock retrieved via clk_get_by_index(), since clk_get_by_index() returns a copy of `struct clk` rather than the original pointer. For example, in https://github.com/u-boot/u-boot/blob/master/drivers/serial/serial_s5p.c#L131 the serial driver retrieves a clock using clk_get_by_index(), and then indirectly passes a pointer to stack-allocated `struct clk` to clk_divider_recalc_rate(), which breaks the ccf_clk_divider driver.

Description:
The Clock API relies on the fact that you call it's functions with a pointer to the
kzalloc()'d `struct clk`, and not a copy of it. To ensure this, existing
clock drivers use ccf_clk_get_rate() and clk_get_by_id().
The clock rework path missed this fact, and instead was returning names
and pointers for the root device.

Testing:
I tested this on Samsung S10 (exynos9820 SoC) with a custom clock driver
and a device tree. Unfortunately, I don't own any other exynos devices
supported by u-boot.


chiffathefox (2):
  clk: clk_resolve_parent_clk(): resolve external clocks by id
  clk: exynos: do not reparent requested clock

 drivers/clk/clk-uclass.c | 7 ++++++-
 drivers/clk/exynos/clk.c | 1 -
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.34.1

base-commit: d503633a36767d756c7de28305cf0de79440cbc0
branch: clk-rework-improvements
