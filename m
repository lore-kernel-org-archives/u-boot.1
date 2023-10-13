Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D09CDB474
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 03:12:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25FFE86B35;
	Fri, 13 Oct 2023 05:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="baphGBSb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3009F86D0F; Fri, 13 Oct 2023 05:03:48 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BD2C8653E
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 05:03:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-690d8c05784so1367794b3a.2
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 20:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697166028; x=1697770828; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pbU6nMq0DJQfxozc2wHNcRIEoaItXybKbZY58G17w4c=;
 b=baphGBSbJ74vEm2m2l+mFk8dGCa9jj+KwS1GIYOmy6oj4zPY8NtGtxfXPfWgY+9w8/
 34sPXINxR6j0nZa1u1c4iZle/ITCD1TQtuVbpYF2NKRVXUtEao+jwg1c/KIfreFo6fsE
 FiQmHf2ZNmF0qblj8OsAJp5xCj1EQEKOMml9H7WHrf0p7M+iH1RwD6yZXsWqp7YSZYz6
 YyLO6Kram+UfYGtvyPORWg4bLl9Gm1FyHa9IjQqet/0Mxpko4VFZhNnwsU4B6PMfCGse
 9UC6bNqoiuLZR4ORUP30tlodj7ZYuZyaufwOmuBerYJg3PuDRWqiqmYUQzmZ/JPrrHLa
 Cb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697166028; x=1697770828;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pbU6nMq0DJQfxozc2wHNcRIEoaItXybKbZY58G17w4c=;
 b=cDMkZpi6drU99TA7DFibhHH0JYZUW632zoR8Gc3cb6tdhKVNGu4T1rSKcgVVHdk0gI
 2c1n/LQMO3eGOPqx3e0ElAzd+7hXLDI8/vreqPA5pp3cyx5pq3decwGIu51Me1Qa8+jU
 iAXvKMf0o0tLeUeddWnU/Z9uBOWziP4hcZpi5kVITqOHUQu/GjXme53OU+xcHvDGQemI
 BlXuRjwnNBKRPv6YMZn2MOTEaqvYnlAxZln4kg6NGmuNpg/rP+H3Mt/hy1j+MaP4IZHG
 Hg83oO0TSa5vwjUXAJNA3ucWJ6s2GzsKzVPjmYCZ0XhKVnIF8blSIs71tjfWgcmOI6uC
 oWvA==
X-Gm-Message-State: AOJu0Yx/8OGWg/ryUYyL78jM8K+g9PLEcxEMYFdsbe0aV4Zx9SE0KGmk
 dGUif2yUfNBU7r33cXnbBpeBnhTp5Hl45g==
X-Google-Smtp-Source: AGHT+IFeFrW5jwIuQsiIAPiEqIUwOWsOWD5cFveF0L6lzBU/HJTqfPgj0mnAACLIbka/dl0K9CmcOQ==
X-Received: by 2002:a05:6a00:1a0e:b0:68e:43ed:d30b with SMTP id
 g14-20020a056a001a0e00b0068e43edd30bmr25240491pfv.21.1697166027732; 
 Thu, 12 Oct 2023 20:00:27 -0700 (PDT)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:b1c3:cd38:628c:82ea])
 by smtp.gmail.com with ESMTPSA id
 n26-20020aa7905a000000b0068fc48fcaa8sm12505653pfo.155.2023.10.12.20.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 20:00:27 -0700 (PDT)
From: Chris Packham <judge.packham@gmail.com>
To: u-boot@lists.denx.de
Cc: Chris Packham <judge.packham@gmail.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: mvebu: AC5/AC5X: Disable SMBIOS
Date: Fri, 13 Oct 2023 16:00:11 +1300
Message-ID: <20231013030016.3307423-1-judge.packham@gmail.com>
X-Mailer: git-send-email 2.42.0
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

The RD-AC5X doesn't make use of EFI or SMBIOS. Recently we started seeing
boot failures such as

    WARNING: SMBIOS table_address overflow 27f60f020
    Failed to write SMBIOS table
    initcall failed at event 10/(unknown) (err=-22)
    ### ERROR ### Please RESET the board ###

The error is because the physical address of the RAM on the AC5X SoC is
above the 32GiB boundary. As we don't need SMBIOS or EFI this can be
safely disabled.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
This probably should have been part of the series I sent as
https://lore.kernel.org/u-boot/20231003035800.2626121-1-judge.packham@gmail.com/
but I didn't have the RD-AC5X board at the time. There is another issue
that's stopping the RD-AC5X board from booting with current master but
with the suspect commit reverted you can see the same SMBIOS issue I was
seeing on the x240.

 configs/mvebu_ac5_rd_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/mvebu_ac5_rd_defconfig b/configs/mvebu_ac5_rd_defconfig
index dbf1e3136cdf..e8fa22b648be 100644
--- a/configs/mvebu_ac5_rd_defconfig
+++ b/configs/mvebu_ac5_rd_defconfig
@@ -85,3 +85,4 @@ CONFIG_USB_ETHER_ASIX88179=y
 CONFIG_USB_ETHER_MCS7830=y
 CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_ETHER_SMSC95XX=y
+# CONFIG_SMBIOS is not set
-- 
2.42.0

