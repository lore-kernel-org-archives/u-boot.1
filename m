Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78872E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 10:54:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0320801CF;
	Tue, 17 Dec 2024 11:54:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W/YuByxL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D90CB801F9; Tue, 17 Dec 2024 11:54:41 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 403F5801CE
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:54:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7265c18d79bso5472899b3a.3
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 02:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734432877; x=1735037677; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LkkwoMi/QTYgXuw25C6M5By2xtNcmpymBrHRvKaRK/I=;
 b=W/YuByxL9X90gP+EE1P1t1gvnmoTNtyUnggwMpgKVt1JaIpe6ajrrnrUhYxo8mJW38
 /l1RgNT8RqZDvDkE6TV9xgoQaNacCa0xJCIMouPzKBgdWKhGuA1gEbh+n4rw8wgtclCH
 0o3M5+gfpxcFkDL2xVHzu3pfww0zq5F+PN9nCZm1IkdB2KGRmGEbVmKdLzxFhd9ZGhUn
 oHtSPrQBb29TTNSqJuWPOVfaDi/pEJX25laENGf2M35GQRxV1YkMqd+SZ/fu1lgmO2sH
 rmZb9/Qj+O9irLBU5fgn1DStZjl+Jjox7cpOXDmGTJPxv5bVeC8Iq0/WeqcW+U3MB6kg
 KnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734432877; x=1735037677;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LkkwoMi/QTYgXuw25C6M5By2xtNcmpymBrHRvKaRK/I=;
 b=cr2wF8Fmt1JBRcyNYV4eSFnXBvGGyss//l/DmFCbhYEgOC/WhFXPien6cfTvTJlPfX
 2ye6GYuMdz1WQilxDT01tzKJAz1G/pZOPphC08ae8xmsfzWRaKsPLORVKXxNvFLzMC/0
 zsAIu1ww+MMD6OFf/CUQBkeAFoVbo24D5wrzxbpemhRkJjBgye7wTmtgjzRZMac+U8Up
 PEIzJ5Gua8K83zvUVxZQa7gtEuW6XMbXNeKXvrOqrJ2IyIxK+7yEDZo+i5/I3IBuaM9K
 fQ529RmklNkQMYsDJM6XoQQxBjq2dI/xulAGZ8HIbdPUc4pUooUuS43K2pgzJsDuIQMf
 FUkw==
X-Gm-Message-State: AOJu0YwvPiNWiv3HWvLNrLgopPSewIjHghqfKPQSKSdD8hIU3LPuKyLg
 rQj7gdFywEuxSNuTzJzjhMQKPQr/gkzx2ppLSsQ98R+pkOYvSx81
X-Gm-Gg: ASbGnctDqUXRGg1Q1Q3tQ/EDNkl59o9sHa4zzKaJnBshGuy2EsZk+Kv11bCgBXDqmU8
 W5CBHsiFuwquxpGVnefVkqsdpa5NPDbh01gwSE9ErlHtT2sxAUmU9wDEc7rcoUmNBOEGdhDZ6P6
 9h9xjwDrrsfXMCmFFZCje1nyhwffdzQTcxUhrW0DRtr6DDFxb56smuvqN08adOrdyfqei2f/UKY
 6XB5zhR5xhaS246M0H5QE3FrpHJiScaYiofGB6vTiKpaVzcPFTsVc1JZQv1Uwzsp0GJLQ==
X-Google-Smtp-Source: AGHT+IHWJC+2/3CDSPBviMlVzzABTRv3q1WECSgHzNkmCuPKWm8BqELLSzb7d5hdJe7YsctuQ1NMYw==
X-Received: by 2002:a05:6a21:3a93:b0:1e1:dbfd:1fde with SMTP id
 adf61e73a8af0-1e1dfda98bfmr23186968637.27.1734432877553; 
 Tue, 17 Dec 2024 02:54:37 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:2d08:94b1:8dd:a583])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5a93567sm5504288a12.4.2024.12.17.02.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 02:54:37 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20241217
Date: Tue, 17 Dec 2024 07:54:33 -0300
Message-Id: <20241217105433.1419146-1-festevam@gmail.com>
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

Hi Tom,

Please pull from u-boot-imx/next, thanks.

The following changes since commit 8aab7730c1c26192b0e4218fbf2f6009f955cb88:

  Merge patch series "Hyperflash Boot fixes for J7200/J721E" (2024-12-14 09:34:27 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20241217

for you to fetch changes up to 7cf57825eb4366a474ee0a13ef690d460f8c4775:

  imx: hab: fix srktool -c usage by removing spaces (2024-12-16 14:35:58 -0300)

u-boot-imx-next-20241217
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/23877

- Add support for Apalis iMX8 1300MHz version.
- Don't advertise Gbit on (R)MII on the FEC controller.
- Fix srktool -c usage by removing spaces.
----------------------------------------------------------------
Alexander Sverdlin (1):
      net: fec: phy: Don't advertise Gbit on (R)MII

Christoph Fritz (1):
      imx: hab: fix srktool -c usage by removing spaces

Stefan Eichenberger (5):
      toradex: tdx-cfg-block: set apalis imx8dxp to always disabled
      toradex: tdx-cfg-block: increase indentation for longer defines
      toradex: tdx-cfg-block: add new apalis imx8 pids
      toradex: apalis-imx8: simplify module version handling
      imx: mach: imx8: fdt: set correct frequencies for the industrial SoC

 arch/arm/mach-imx/imx8/fdt.c            | 132 +++++++++++++++++++++++
 board/toradex/apalis-imx8/apalis-imx8.c |  19 ++--
 board/toradex/common/tdx-cfg-block.c    | 183 ++++++++++++++++----------------
 board/toradex/common/tdx-cfg-block.h    |   5 +
 doc/imx/habv4/introduction_habv4.txt    |   8 +-
 drivers/net/fec_mxc.c                   |  12 +++
 6 files changed, 254 insertions(+), 105 deletions(-)
