Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960A7CEBF66
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 01:19:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B46389027;
	Fri, 27 Sep 2024 03:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BGqUq9Qz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9FB788E39; Fri, 27 Sep 2024 03:18:40 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A56CC8902A
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 03:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7179802b8fcso1247972b3a.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 18:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727399917; x=1728004717; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEKAbvLwwAHLEGgjh5Vm4hldFbW5wk6hBdIxEZSq/MI=;
 b=BGqUq9QzeTDC6l2bRI5zT2f0GrtH9KRDdqfSopESjfgPh3Z6mkoufPFblTnyHPhkL4
 ztYQuOuy3TBJCSsv6431CYw+9fI4L3Ego5WmGl4pAWyHpzomP0o0ITFdZ2VrbwJqRjGe
 ce7POgWpae6vBLefGF9lWHvm8VpTMcPVt1sPdn+WBq3aYc0IQfnvtFu4dp92Fub5FKUv
 r6dvIFvFKrxGdsjbNBbRzD2YHv0Qofc+g5ePUWnYJ1wMVhsCgk0OT3ouxEm9hm/Kz6Et
 ybugcm2LexUtA1dowdJ1lLUewuWk6qDtIBgGdvfJpO6NsaGwtGz2FX+rxnhhr/asG+5L
 skOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727399917; x=1728004717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dEKAbvLwwAHLEGgjh5Vm4hldFbW5wk6hBdIxEZSq/MI=;
 b=VnboXeQuzTz1c88BfGRFFNyVlApaUHqTRLZnDVLoKKgDaUAtrOV9BjLe1qd8A3etgu
 +m4UrVTJT8Xm90DKsEywdFlizs4VZKxmx11SIb0Et9/YkJSlo40cHCkz/HoCL3skDFlq
 y4VtbEbwMGe9jLbdRr0iU1W8qjElKUhDHmudugT8lF1sMeyD9uia7+lfT75VF5epc872
 6girt19ofKXVkUj5j90ECj7nTp61zNtXj5WjMfgYSy47aaLamlivkw9JhpPfMK3qbZHC
 fqXWsY4VhZ3CXdBCG50A2dxAZ1IUaQ5P3X+ilmdJ4phaA+htEJ68tRWqgQ3T2K7GRrUQ
 o8MA==
X-Gm-Message-State: AOJu0YyxCvUxnDcpjyy2ydNJkMKZXRYKQo07zhmnhJAG/CROv/iXZiiR
 cRvaPv8a79JZz+1+ameC3JbsAu4KwdakY3HpJY8wUENrqRGkKbv/Qvwv0Q==
X-Google-Smtp-Source: AGHT+IFl7nt8Jkq+YSCVe+Y+m2V5wDA7ZtUBXKy9iU6n3ENrFjJLHiBOIqDdx01LiBc0DBSLfa87fw==
X-Received: by 2002:aa7:8887:0:b0:70a:f65e:b13d with SMTP id
 d2e1a72fcca58-71b26066827mr2431892b3a.27.1727399916969; 
 Thu, 26 Sep 2024 18:18:36 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b2652a622sm509908b3a.164.2024.09.26.18.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 18:18:36 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [2nd RESEND PATCH v2 6/6] mtd: spi-nor: Set ECC unit size to MTD
 writesize in Infineon SEMPER flashes
Date: Fri, 27 Sep 2024 10:18:11 +0900
Message-Id: <789a303fb1254dabfff4c7e08ee7744d08e66a49.1727399650.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727399650.git.Takahiro.Kuwano@infineon.com>
References: <cover.1727399650.git.Takahiro.Kuwano@infineon.com>
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

The Infineon SEMPER NOR flash family uses 2-bit ECC by default with each
ECC block being 16 bytes. Under this scheme multi-pass programming to an
ECC block is not allowed. Set the writesize to make sure multi-pass
programming is not attempted on the flash.

Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index a8f3edc9f69..23e71243927 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3520,6 +3520,13 @@ static void s25_late_init(struct spi_nor *nor,
 			  struct spi_nor_flash_parameter *params)
 {
 	nor->setup = s25_s28_setup;
+
+	/*
+	 * Programming is supported only in 16-byte ECC data unit granularity.
+	 * Byte-programming, bit-walking, or multiple program operations to the
+	 * same ECC data unit without an erase are not allowed.
+	 */
+	params->writesize = 16;
 }
 
 static int s25_s28_post_bfpt_fixup(struct spi_nor *nor,
@@ -3684,6 +3691,13 @@ static void s28hx_t_late_init(struct spi_nor *nor,
 {
 	nor->octal_dtr_enable = spi_nor_cypress_octal_dtr_enable;
 	nor->setup = s25_s28_setup;
+
+	/*
+	 * Programming is supported only in 16-byte ECC data unit granularity.
+	 * Byte-programming, bit-walking, or multiple program operations to the
+	 * same ECC data unit without an erase are not allowed.
+	 */
+	params->writesize = 16;
 }
 
 static void s28hx_t_post_sfdp_fixup(struct spi_nor *nor,
-- 
2.34.1

