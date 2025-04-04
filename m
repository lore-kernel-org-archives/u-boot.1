Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2380C36014
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 14:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D4EA829A0;
	Fri,  4 Apr 2025 16:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OTHCm0cK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 636E9829CF; Fri,  4 Apr 2025 16:49:35 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 102E5828AB
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 16:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-224191d92e4so20903135ad.3
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 07:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1743778169; x=1744382969; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f37tlB3YEAt529oVz8GVBkDz91BXNuBooksOAYuuksw=;
 b=OTHCm0cKYKlOa4HmCRGFRA3zJhlqLmfeCUWInLHVb8poUwI3vrGuGwTG0BozJsnkIA
 P5xp1h3dBetH517IawZkMsNApz8QaZuLEXKfXStY2YvHNui6Zcy7rrPWcNi/JbJ7us4c
 JXqFFBdB3FZcC/5s45wdI5U/iHzVDloCmrg8B+OYAqYHeW/vmdg2Q6hxTAx0tCQuGmFg
 vVZIQlyjKqe+YzKZgii6bP8QbruDZW6E4dhOkb8eI19vn7GLlVe90hCItzccZCL/XnFD
 AnukEjWX5BRfH3EoMp+V3Z8YTKZSiHaFu6NDOaP1jhnk54PX3gb3GDocFOLqXIqfqkQf
 uaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743778169; x=1744382969;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f37tlB3YEAt529oVz8GVBkDz91BXNuBooksOAYuuksw=;
 b=LzweZw/9N6Sq0y13nKahGyQ8ov6DBcKVCYdgAJTUi2+IrMDlwCjP0AAZ58feyLuLYL
 OGbRUQrMnz9T6Bnp169dS3TLmN/8Op4Ki/ZHglN/49iH+zMXEL6u7Q7lb5pjLDcu5P5o
 Z+iO+1FsVFDiBgn6CBI05Vgz0tuFBq+Rl0gkAjVDI0YThESw49NMUngdV0rDJcwZyNKW
 0dwA0yu/NfZ2PbJWPdkEgWnJ/+jPBdD8+Q1+Jyd7CGfunb7xHMZoofQ+UKOkQ50/NWa3
 KL5okPUkZOcKOr6O/wnPt/vpUFhnulIwzL1Up3j5vI6C2LZ5L4cMkG5BmzG6gzWdWuRp
 7G8A==
X-Gm-Message-State: AOJu0Yxjx8rUSkXqtlFas+21B9vCsd0sfZ5V7ZDW+qn0O+TRiYTVyffZ
 hkTUDvQhfHTPoYVlXOdGAA8FHxkDsAm+MJS3jLP+liU+i9cze1qqm9BaBIdQlZ6K0Ppp5ic3wrP
 0bbI=
X-Gm-Gg: ASbGncvM+C//Aq7zC+5ilo9I4YpX4AaVDkqk/h8uhvgcoygdqUMn8P0jVomqQ15BH2k
 LyZEV1hQWNi/yIHiXFCPJ+cd8GRJlIcCtlQRQZ3+ALo+qB/TENCwds0ITxZ7OVkVSPdZhMLSTo7
 L3DnY+ySNDGoodzhOA3nX/colUxMLg00UiFOJedozlv9bCiIGwqFPvLXxd756UATjEMEzNx+6lb
 gUwWJ+I7qlI7CW1TOTPjTb353z4WSixm2yRIRCWb2gjT1xy+YrJW9K+yAT68VxKeF6Y7VejsoIJ
 9J9lfc+yBNkOjWQl0KPVd5A87ske6lDyDb6fnugeCvQ+/hcUSQD4aZbsfnGoAX2jVg==
X-Google-Smtp-Source: AGHT+IEB/rZaZNxXMMBSeHNMoJy2UeeLGTC/ph2uPLbysfuxQzJ2IYvIYyhYBQedBrBMNvfDqtAIxA==
X-Received: by 2002:a17:902:e950:b0:21f:45d:21fb with SMTP id
 d9443c01a7336-22a8a046021mr46268305ad.3.1743778169218; 
 Fri, 04 Apr 2025 07:49:29 -0700 (PDT)
Received: from localhost.localdomain ([103.97.166.196])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2297866dccbsm32950705ad.176.2025.04.04.07.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 07:49:28 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Tom Rini <trini@konsulko.com>, Maxim Moskalets <maximmosk4@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Julien Masson <jmasson@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v2 0/3] Risc-V 32 bit/64 bit images
Date: Fri,  4 Apr 2025 14:48:54 +0000
Message-ID: <20250404144859.112313-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
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

This series adds support for building different images for 32-bit vs
64-bit Risc-V CPUs and also for verifying the target arch of an image
before booting it.

Change in v2:
- Rebase to latest master branch
- Improve comment in image.h
- Set arch type in booti for all modes

Changes from RFC:
- Rebase on latest master branch
- Improve commit message for patch 3

Mayuresh Chitale (3):
  riscv: image: Add new image type for RV64
  riscv: Select appropriate image type
  booti/bootm: riscv: Verify image arch type

 arch/riscv/dts/binman.dtsi      | 14 ++++++++++----
 arch/riscv/include/asm/u-boot.h |  4 ++++
 arch/riscv/lib/bootm.c          |  4 ++++
 boot/image.c                    |  3 ++-
 cmd/booti.c                     |  7 +++++--
 include/image.h                 |  3 ++-
 6 files changed, 27 insertions(+), 8 deletions(-)

-- 
2.43.0

