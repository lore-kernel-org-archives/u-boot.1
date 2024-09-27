Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9E3CEBF66
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 01:18:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50A7088F9B;
	Fri, 27 Sep 2024 03:18:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Znt4+b53";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4C8988F89; Fri, 27 Sep 2024 03:18:21 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FA0D88FC8
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 03:18:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7db4c1a54easo978341a12.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 18:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727399898; x=1728004698; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nxpTGr9UaKaTuM4jpRJ+VnqgtuShAUJ9hhEXAKHxwqQ=;
 b=Znt4+b53vOLnZ2GSeXCwQAJOVcvmI2Qr2AA5M/dp+uZPu0eGwhkN7AOxYfmPSJzPRt
 NoR/jX2xSl6hapzkh5QWw+CXifBHbCKjd0Wh679l57EChRcteM2zVYsFgmB0PZxzDL7c
 rwl9aIRwPxqeJ/7v3ROh+artzz4K8bZ3r1r1YjwnClkK+6rxd7emacGyIQGZcGITqY8v
 tb/M2XoLg2z4QiEeG7yqddd60uHvemmmYQciKRxbWqNJI4Xe0hTvqKbOvpAE/8yuaThF
 9a+mZ04E4LxVKq7EQvvpuQ/1YqQ1RZziSo09+SSd0DWpqB9HXrw6rg+PYhxatwOeOphQ
 Fl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727399898; x=1728004698;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nxpTGr9UaKaTuM4jpRJ+VnqgtuShAUJ9hhEXAKHxwqQ=;
 b=FnZ/fI/9iPhQ+7u4H+/Wz6zMdCoYb/YhJA16AHlsGvwqrJTIuAV+64R4t/SZu+3rIy
 fUvSCoIqh+m1Op2i8hv8HvxY/+0C8mhjs86FI4KozG6gq3HNjSgdjVZ5my904dH5Zs3/
 crcZSwvJrskx14VY3zHSMOZnwzErqkOk4gG5t38dY71E7QNVlnVzMwF4zGd89nwbgsVn
 Fs1XwpWEHKXaU09u1s4/oGzEubz22HryxmVeKL+QPby+F1eovrmlC7gqNwk/7rt5jsCD
 s79RtB8iZtSFZBwJJQgW+ypB345d3XTdZm+hYtlCQH9qeZ95sFkvRpMMKri9MUAqvSbs
 tbsw==
X-Gm-Message-State: AOJu0YxjfNbVtOaJe+K1TIicO7rvlKuHBVjbn/1RYBxkuQCf7yDvNZAh
 pnBd6tVLVK3ir8XPhAip/ZGkoYG8vxuDYTk4JBva0WqmtJtMSiJFOi8C2A==
X-Google-Smtp-Source: AGHT+IEqPhovLL1wjd/kqES764pYFH6ZyS6xpu2GnrJtqy0hr20IWW1vvRbITQVz4w7j57+E6a7WLA==
X-Received: by 2002:a05:6a21:58b:b0:1cf:5170:21b2 with SMTP id
 adf61e73a8af0-1d4fa7c5b8dmr1925646637.41.1727399897792; 
 Thu, 26 Sep 2024 18:18:17 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b2652a622sm509908b3a.164.2024.09.26.18.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 18:18:17 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [2nd RESEND PATCH v2 0/6] mtd: Make sure UBIFS does not do multi-pass
 page programming on flashes that don't support it
Date: Fri, 27 Sep 2024 10:18:05 +0900
Message-Id: <cover.1727399650.git.Takahiro.Kuwano@infineon.com>
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Resent after modifying commit message in #5 (mention Linux commit first)
and collecting A-b tags.

This series is equivalent to the one for Linux MTD submitted by
Pratyush Yadav.

https://patchwork.ozlabs.org/project/linux-mtd/list/?series=217759&state=*

Changes in v2:
  - Fix an issue in setting macronix_octal_fixups
  - Rework fixup hooks

Takahiro Kuwano (6):
  mtd: ubi: Do not zero out EC and VID on ECC-ed NOR flashes
  mtd: spi-nor: Allow flashes to specify MTD writesize
  mtd: spi-nor: Check nor->info before setting macronix_octal_fixups
  mtd: spi-nor: Replace default_init() hook with late_init()
  mtd: spi-nor: Call spi_nor_post_sfdp_fixups() only after
    spi_nor_parse_sfdp()
  mtd: spi-nor: Set ECC unit size to MTD writesize in Infineon SEMPER
    flashes

 drivers/mtd/spi/spi-nor-core.c | 88 +++++++++++++++++++++-------------
 drivers/mtd/ubi/build.c        |  4 +-
 drivers/mtd/ubi/io.c           |  9 +++-
 include/linux/mtd/spi-nor.h    |  1 +
 4 files changed, 65 insertions(+), 37 deletions(-)

-- 
2.34.1

