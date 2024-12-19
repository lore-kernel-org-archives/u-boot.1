Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C67CE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 10:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A51F78021A;
	Thu, 19 Dec 2024 11:54:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R3dn30O8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C918B8021D; Thu, 19 Dec 2024 11:54:14 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62BFA801F5
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 11:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43635796b48so4069315e9.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 02:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734605652; x=1735210452;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lAlrffGXeXzIUwzNmxzRU43RoW0r3Hx42v2kZ2hOnRE=;
 b=R3dn30O8Z2mV4z3ylSIl40IBA7t7JnhwT+MWioi+QVgsrMR7bM5d8RMKVjir+r4CPE
 xk76C0OCJIul/Tquuubr5yXhOzbFIXFFZufCpharmE+Te0PRlBZanNTI3OANg+KuVYnM
 2twc+jtp3j8WdPXwOxchz8dLOS+/OYoRcLzakoxmYE1MhQ9dn008ATrod2AVhynBFi7U
 vAUl1FaaTet4rpmAEOpZquJUCu1gHS1oBQcefJXI+zYiSn0kXXQO5S9u8OAm+e2fXmhU
 4ysMwGTWM3cukx8LZw6A7A1Pu6HdFpez0cavJrGAhW8nEb7tHQePTiNsQUII1/khN+Ui
 kU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734605652; x=1735210452;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lAlrffGXeXzIUwzNmxzRU43RoW0r3Hx42v2kZ2hOnRE=;
 b=Gyz9hXo8BTWPmSRS21arDprHfnnBVg26zRrD5S9fLYExxO0WoCfygYXQxywDeEPw0P
 s8G2bIDrIp1jwcD93kJnoGXppLsO5UDu0zn6N9O386hUp+5AqI3VH50YLBbPCwZfWV7f
 YiLmWrxzgUjVtd40UKhWrzqWqHcqcCjxx7quRoDQ1DDAd8zkfk5bxyGsg46/A3sEe4Xp
 QmcqdQUw9f/XlrDENYzb4bS6mO7zBZaWehTtnTbIDqRoUPaaB8wMdzoEqIVH8v4gOETJ
 mE+3qi9j2M6y9/NzDAmsokiSmkUMRNXr8ZKSPmBnbEJoQR5r/b+TDTjDzzwqnNz4/1d3
 0uTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIFRjp749KK+BnbgjycAqeJylNp/tyipKM++NYblk2nbTXQ+vTDKUnanAgzQiJzU7f/6O2uCM=@lists.denx.de
X-Gm-Message-State: AOJu0YyUKMho2l6rWMG+VmsipDyqhDnM0Jp427799ErKHejBP9BGJCC/
 ml1d1jY3Br/FxqJQjIg7M3aQWEWGjcHtxK+W8AFtWAytGAA0uR9yykCr8tCK0R4=
X-Gm-Gg: ASbGnctnBaQrQUTQuqKY+f9qSlaTI3ZKh8qMQ3iKUE/eQHLPm+foGcXL9sl8xw2zDok
 7Nxirf0OXWRlkDh3/1FeDIL1fGh9yAWT+j5BOvoDrYA9VzcxBeSF/0d0hmeNzo/xpJcxqLwfkmO
 /DFJelNmTUTRhaAf9QFvJlhrLexK9Diftd1DxwkWswZpGwWNSWn7LCAXGoEHeL1LWUPaP+aHtbK
 znsJGN2vKt4SO8Fu9wdUe1iTQWHJRrfSTlCKYZVNr5icO/vz9gIMOsWY/pA
X-Google-Smtp-Source: AGHT+IHF3YjhltFH8djoa108NFQ/M/vFs92TgDB3/T66P+8jwSsvlhfyWVkJ+Lo0x1XB/t3cgy+6eQ==
X-Received: by 2002:a05:600c:1912:b0:436:1b86:f05 with SMTP id
 5b1f17b1804b1-4365c77d96bmr22888915e9.11.1734605651806; 
 Thu, 19 Dec 2024 02:54:11 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366128a62asm14258095e9.44.2024.12.19.02.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 02:54:11 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Nicolas Belin <nbelin@baylibre.com>
Subject: [GIT PULL] Please pull u-boot-dfu-20241219
Date: Thu, 19 Dec 2024 11:54:08 +0100
Message-ID: <87ldwc3pv3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Tom,

Please find some fixes for master:

Android:
- Fix kcmdline_extra support when parsing boot image
- Fix memory leak when after bootargs concatenation
- Fix length calculation when merging bootargs, cmdline and kcmdline

CI Job:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/23951

Thanks,
Mattijs

The following changes since commit 25fb58e88aba0c4af0af554d7b141be3f2e5e0b5:

  ARM: stm32mp: Fix dram_bank_mmu_setup() for LMB located above ram_top (2024-12-17 09:14:01 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20241219

for you to fetch changes up to 9e5fad0f792539ae4258bc116bf408bb6faf7e82:

  boot: android: rework bootargs concatenation (2024-12-18 14:04:23 +0100)

----------------------------------------------------------------
u-boot-dfu-20241219

Android:
- Fix kcmdline_extra support when parsing boot image
- Fix memory leak when after bootargs concatenation
- Fix length calculation when merging bootargs, cmdline and kcmdline

----------------------------------------------------------------
Nicolas Belin (3):
      boot: android: fix extra command line support
      boot: android: free newbootargs when done
      boot: android: rework bootargs concatenation

 boot/image-android.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

