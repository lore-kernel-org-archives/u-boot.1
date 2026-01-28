Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40E4D3F06A
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 14:12:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7321F83F00;
	Wed, 28 Jan 2026 15:12:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JjxwzT9Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC9AA83EC9; Wed, 28 Jan 2026 15:12:27 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1DAD83E63
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 15:12:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a07f8dd9cdso50150755ad.1
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 06:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769609544; x=1770214344; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XU89oFDgOIjbHRsy3X0rrOTyZIgewOlfgkifjdTLZ0I=;
 b=JjxwzT9Y2ZuVx8XUC/J1aOpPNPBf21mn32uHLIw0J6EEW/SuyrZ/ifI+8nJUvNvN2r
 1if9JcZC067dfQJYh2UH+7r7vA1a4zg9SiUTblxO2CU2xO722csh6V7a6fSOKbwAymt1
 SmxVFz7c+kHJpXomGv/vEWZYx5E9GKdVvI9hA+p+ROK7mAmnEAx7N34gxbeTk85T+Y0v
 94oU+V5FpZUmXY8kzJUAEOy5xtwJEvy6P3CI/kSATax5HvRgf5w3246XB3Ry2e5Jdqfa
 T7VBezEhK6TnGF5RRwK27HSyKzPBW6pqrVEXWISZ2LfpI0T/uSQyPZdQ70YUrRc5XJzn
 Rj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769609544; x=1770214344;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XU89oFDgOIjbHRsy3X0rrOTyZIgewOlfgkifjdTLZ0I=;
 b=uJBpKoccN7LLgG2TGdRmHr3lMbUiorpko5f5nF2BpJCZOY6bw19w/62Mzggx5t4jDQ
 8rJ5DMtz4Px2t3Rvu2QyTcLNGmYL/5H/OrdLkLZqVmYqhnRa6PkBoYu36HBZmfZnsKnZ
 uWjswPbXnUdYroB9Hgf3CtDzZafrUyDxgTiBtba87rulpjcEtfDeHbLqKCgijXU973e7
 BIyTgz/bvixOMXcHXmYy78f2nHvsOMFbzEeybUubFT/NdT/9si0cexCN1RvZY10PEoN5
 JcuruSFXT/nanmjRpgghg9DVge1JrWw1vm5XUmaBy4HLAWLtRAKXmuATbSQrhbtlJFJq
 Q9lA==
X-Gm-Message-State: AOJu0Yzbj0V9vi8MjT//vaXCzoma1WQinYXqWdEJvuu2oc0OyBKBjld4
 nun0bdbk3H6I8eqLSGabnGiw7ocRGtufJ4Jmqt8AszbRw2DC/uNc/G8pZQF4oqWeytw=
X-Gm-Gg: AZuq6aLEyl1jtHJ7Ks9pGdXecf57Ox7kZvFdQibJvE5ks4AShfwkfWH+Z0bOUPR5N7T
 tDVDgYDC9dp8hSq2oW7u8L7uDhVATIEhtZfaJ+0ibby+FeyPQuL2pxzdSmGM+q1+QR8/Xgkd2mr
 fuf4hz9+EzZQz0qeckSA70LhwmtphahmG7UggJPKynIbzRJpoOjlaScxXd/xn2MsEDC/1ggYDz0
 UIj8q/1vpTYkulzGZPatuNYqVa4ThSVk5pXJx3OX0wI8VpGyfNHZiza3zYsFqrEItI+aUbTSjHE
 cZkAyaXkFyqYu3LScbFAF25p0za1zI9D0BUmktQF4W5MU7VfNOUd0L/o9qUHT+yffPk+UFniKdq
 nGul1vZqZzd/OXPQnnYXrn6aX1MS96iVr3o7tKuQ5L6Kf0y+ZlRlM+YG86hhkdg274izpSviV0A
 zPz6TDtc5wvw8kuOP+9hoxtzLSYEj+1qG0OA==
X-Received: by 2002:a17:903:94b:b0:2a0:c884:7f09 with SMTP id
 d9443c01a7336-2a870db7639mr55437585ad.38.1769609543788; 
 Wed, 28 Jan 2026 06:12:23 -0800 (PST)
Received: from intel-VirtualBox.. ([94.156.205.238])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b4c3b29sm24005065ad.54.2026.01.28.06.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 06:12:23 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Brian Sune <briansune@gmail.com>
Subject: [PATCH v6 0/2] Add-CoreCourse-socfpga-Boards
Date: Wed, 28 Jan 2026 22:12:13 +0800
Message-Id: <20260128141215.329235-1-briansune@gmail.com>
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

Introduce CoreCourse boards to mainstream.

Altera SoCFPGA GEN5 boards:
AC501 - small formfactor
AC550 - complex development board

Brian Sune (2):
  Add CoreCourse socfpga Board - AC501
  Add CoreCourse socfpga Board - AC550

 arch/arm/dts/Makefile                         |   1 +
 .../dts/socfpga_cyclone5_ac501soc-u-boot.dtsi |  44 ++
 arch/arm/dts/socfpga_cyclone5_ac501soc.dts    |  72 ++
 .../dts/socfpga_cyclone5_ac550soc-u-boot.dtsi |  44 ++
 arch/arm/dts/socfpga_cyclone5_ac550soc.dts    | 118 ++++
 arch/arm/mach-socfpga/Kconfig                 |   7 +
 board/corecourse/ac501soc/MAINTAINERS         |   6 +
 board/corecourse/ac501soc/qts/iocsr_config.h  | 664 ++++++++++++++++++
 board/corecourse/ac501soc/qts/pinmux_config.h | 222 ++++++
 board/corecourse/ac501soc/qts/pll_config.h    |  86 +++
 board/corecourse/ac501soc/qts/sdram_config.h  | 349 +++++++++
 board/corecourse/ac550soc/MAINTAINERS         |   6 +
 board/corecourse/ac550soc/qts/iocsr_config.h  | 664 ++++++++++++++++++
 board/corecourse/ac550soc/qts/pinmux_config.h | 222 ++++++
 board/corecourse/ac550soc/qts/pll_config.h    |  86 +++
 board/corecourse/ac550soc/qts/sdram_config.h  | 349 +++++++++
 configs/socfpga_ac501soc_defconfig            |  85 +++
 configs/socfpga_ac550soc_defconfig            |  85 +++
 include/configs/socfpga_ac501soc.h            |  13 +
 include/configs/socfpga_ac550soc.h            |  13 +
 20 files changed, 3136 insertions(+)
 create mode 100644 arch/arm/dts/socfpga_cyclone5_ac501soc-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_cyclone5_ac501soc.dts
 create mode 100644 arch/arm/dts/socfpga_cyclone5_ac550soc-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_cyclone5_ac550soc.dts
 create mode 100644 board/corecourse/ac501soc/MAINTAINERS
 create mode 100644 board/corecourse/ac501soc/qts/iocsr_config.h
 create mode 100644 board/corecourse/ac501soc/qts/pinmux_config.h
 create mode 100644 board/corecourse/ac501soc/qts/pll_config.h
 create mode 100644 board/corecourse/ac501soc/qts/sdram_config.h
 create mode 100644 board/corecourse/ac550soc/MAINTAINERS
 create mode 100644 board/corecourse/ac550soc/qts/iocsr_config.h
 create mode 100644 board/corecourse/ac550soc/qts/pinmux_config.h
 create mode 100644 board/corecourse/ac550soc/qts/pll_config.h
 create mode 100644 board/corecourse/ac550soc/qts/sdram_config.h
 create mode 100644 configs/socfpga_ac501soc_defconfig
 create mode 100644 configs/socfpga_ac550soc_defconfig
 create mode 100644 include/configs/socfpga_ac501soc.h
 create mode 100644 include/configs/socfpga_ac550soc.h

-- 
2.34.1

