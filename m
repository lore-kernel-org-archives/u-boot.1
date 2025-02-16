Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B731C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34F9980C7E;
	Sun, 16 Feb 2025 21:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aL6yDaEt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1995080FDA; Sun, 16 Feb 2025 21:45:49 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28A0580FF0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:45:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-8558a6ce0acso13356039f.3
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738744; x=1740343544; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QdmyxuszRG4R6HxIioHWptM/F08Gq3fK5eHb0GzKn4k=;
 b=aL6yDaEtitsR9aLxD9WIL7Y+rNHHFyUhI+zwF2xGxi8OiYspw4Xm+ntRMFFOxc1m7J
 Jce59iWgXI14pJrXCyD+0NuW/F30ckS26Ytoy0q2hrZ54V0OrC+6ndGw2ZWEeMyHGkcW
 jhjXzUoBzdybVDnl+WEtaJJtET2uxcIAWmSXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738744; x=1740343544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QdmyxuszRG4R6HxIioHWptM/F08Gq3fK5eHb0GzKn4k=;
 b=aaaFirkVuPk3MKbLfNPlZ6acLE1PBqn6zxj47R9tieItuRiGp0iJXKSfk+O1D6srVF
 9U2gNlyGodJINOys5X4uUTObmysyXhGrFP7pwpVp9lu1lGilpID4rdQzqOnZXmaLeXJT
 /JR/xyYEO+ioNJTxbWpl59oyouzyr406oNe5UrkG6fASnj2Beze939bDXmnXEIriOZlt
 KQwKudJJti+tmgJPG1E2UH9MC/zS8GqZlLNIkTg5+8qlEpKEYSlRQZSU0s6Lm7pplDJL
 BiAua+KLdq0V2H50RsVluW93Z88z0aMtER2eKsVSQOZIRZ9tAcQSjXGWe6X1bVc48+xm
 5+CQ==
X-Gm-Message-State: AOJu0YwYj3L6y7a5KWEumaGaOhkBuHHQr0wllZ7CaP+kXc5PJs8JjXtj
 vG12E+RayS0/tkfdfhOKu7w59EssLrh1WdV3RuaH9hbUluPm5HDrZIWphi7d59scPlnH81mrEvo
 =
X-Gm-Gg: ASbGncuRnSHzsuGFDBO7rgpjQaldxAeLWVuRjCR9wxQyptbw855ZIc9DeF+TBC5/dT8
 0JxyDs1Lo3cxZ6HKOBaplDeqmRYrWZqrK0POzTlf5ZjqVgylMh62vlLAT+w3Ah554maPCj34hSY
 v0qATDiQXvHnl68A/i1FJ27kgJhHO9nuz3Q/OhU9YCgLmiQTwu1CYN7VXLswTuBhaiXQTC+TR8W
 E20+9n0hwkP07ElQ9zQqFMgsPrJK4Bl9ezactDYmPZsmePILOQzL0qrBsaeAA3wDcE3MdVNocs+
 jk6mrTAFJEb0yTsJkZqLhg8/+JS1QTAJd2xs5mL3k93p51450e9h
X-Google-Smtp-Source: AGHT+IH2hmKbxzTUOMtfrWihx3nbrWIh6rnu+ywyanzoBiW1dRi7a7qDQ9wJl4LE0xL3IVJV13T6qA==
X-Received: by 2002:a05:6602:6b0a:b0:855:5eba:4076 with SMTP id
 ca18e2360f4ac-8557a0a33edmr432601339f.2.1739738743990; 
 Sun, 16 Feb 2025 12:45:43 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:45:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 22/28] x86: Support MTRRs of 4GB on 32-bit machines
Date: Sun, 16 Feb 2025 13:44:07 -0700
Message-ID: <20250216204421.3560012-23-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
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

Use the 64-bit function to detect a power-of-two. This allows use of
a full 4GB MTRR on 32-bit machines.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/cpu/mtrr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/cpu/mtrr.c b/arch/x86/cpu/mtrr.c
index d05263c8eab..5eab3cc1953 100644
--- a/arch/x86/cpu/mtrr.c
+++ b/arch/x86/cpu/mtrr.c
@@ -195,7 +195,7 @@ int mtrr_add_request(int type, uint64_t start, uint64_t size)
 	if (!gd->arch.has_mtrr)
 		return -ENOSYS;
 
-	if (!is_power_of_2(size))
+	if (!is_power_of_2_u64(size))
 		return -EINVAL;
 
 	if (gd->arch.mtrr_req_count == MAX_MTRR_REQUESTS)
-- 
2.43.0

