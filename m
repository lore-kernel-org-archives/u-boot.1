Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F51C3ABCB
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 21:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72D2488F2A;
	Mon, 16 Sep 2024 23:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OBRL6SwQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CDF788F24; Mon, 16 Sep 2024 23:04:03 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A9D788A4C
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 23:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5e1b55346c0so1262396eaf.3
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 14:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726520640; x=1727125440; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SPFI33/oG0pBpzy+Y6UBoLnUw1kjo54BxfGZHXmYATQ=;
 b=OBRL6SwQdhdr7Jgz+4arquo6A9B4zF6AkRRNiqaHbuNDffWFLJWhTSzSh2B20JPehU
 ZPprfHdntPCsyiEeBPtThX2tnIkaCyPiWGX7HnFthlkRvYaHIMZ8O+9Lohp5y8T/jeBE
 GY3Pam4f3P/y+j1HITB3t3XgDm1Jn7jLqBW+GgAUzw7KOVjIKwT9/+IpkqH4SvaCSmOs
 PMVZuk8k4oSkzn1G1Y5gZahxvxqS8p3iEjKWTbTIH6NrVw86FmrKlOGVkS59K2eDmwqW
 w4IDHQQnNjs2ta3RmQbQ4FAqJLMt9un+ma/LH0RuSyFgE5OEXDzNjzOBMPS1OkLHDRBN
 u8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726520640; x=1727125440;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SPFI33/oG0pBpzy+Y6UBoLnUw1kjo54BxfGZHXmYATQ=;
 b=JH2B4iWsmRXwL4DA7vJn0FTwaEGktmowQ+OxWvAuaYgE6yW6cisGV8yNN6GJWYpWwz
 9cseE7vMKxTR/3yVi2vACgygvjWGNFKn/j1Nz3D5kIk0+gOj3qp0f5zr/dIZHR3Ea4l8
 2fF49PulZHJR/eusS3sSHjKbLFY4lLJdRopkDGGRs0P92AyYJcDeLTnJ51n6xZEjtAZw
 JHDO+QgALe59Yup/BPcE9HuBR0gKrYdKUy2aJ5DKNB69JK9IXELL3d4wfEkgVZWRETe0
 OPnukXyfz1UuuIdEj1I4ZNAK2fJnJkfVpyJot5VWr+XAgSYdSPRs+QYoNQo4Ljw29W47
 c87w==
X-Gm-Message-State: AOJu0Yzkq7RXMHTBak/ZzeMLqyxwR4P+zzH2QHOCakYS5gOeT4fHW7Wa
 FU8ogn3WTosQuGYS2Q5U9r7RB5uErHMybciUn4ypQwTpTnbSZ2MibyvcHFQC
X-Google-Smtp-Source: AGHT+IGC97n9Do4FO3IHO0QbueqXWGjBm8P7uY1WJq/m41Uy+h8LpO2fQe+czWIW5N4z9BGNl2FVWg==
X-Received: by 2002:a05:6870:89a4:b0:277:fdce:6759 with SMTP id
 586e51a60fabf-27c68bdd3cfmr6775172fac.31.1726520639706; 
 Mon, 16 Sep 2024 14:03:59 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:a919:5ae5:ea0e:c71])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-27c95990905sm1745300fac.58.2024.09.16.14.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 14:03:59 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, dsimic@manjaro.org,
 quentin.schulz@cherry.de, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/3] Anbernic RGxx3 Bootloader Fixes
Date: Mon, 16 Sep 2024 16:01:34 -0500
Message-Id: <20240916210137.182493-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Update the Anbernic RGxx3 "device" to use upstream device-trees,
add logic to detect a different vdd_cpu regulator, and implement a
fix to allow the panel auto-detection to run when using mainline
A-TF.

Note that *Linux* still cannot use mainline A-TF because of the missing
SCMI clock and reset functionality, but this patch series at least
ensures that this board can once Linux is ready.

Chris Morgan (3):
  board: rockchip: Convert Anbernic RGxx3 to OF_UPSTREAM
  board: rockchip: Add vdd_cpu reg fixup for RGXX3 Series
  board: rockchip: Fix panel detection for mainline A-TF

 .../dts/rk3566-anbernic-rg353p-u-boot.dtsi    |  34 ++
 .../arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi |  52 ---
 arch/arm/dts/rk3566-anbernic-rgxx3.dts        |  28 --
 board/anbernic/rgxx3_rk3566/MAINTAINERS       |   4 +-
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c    | 372 +++++++++++++++---
 configs/anbernic-rgxx3-rk3566_defconfig       |  12 +-
 6 files changed, 354 insertions(+), 148 deletions(-)
 create mode 100644 arch/arm/dts/rk3566-anbernic-rg353p-u-boot.dtsi
 delete mode 100644 arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
 delete mode 100644 arch/arm/dts/rk3566-anbernic-rgxx3.dts

-- 
2.34.1

