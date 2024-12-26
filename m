Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACFBE77188
	for <u-boot@archiver.kernel.org>; Thu, 26 Dec 2024 09:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF4268036D;
	Thu, 26 Dec 2024 10:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ekf5OiRv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8928D8036D; Thu, 26 Dec 2024 10:20:59 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 495D580352
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 10:20:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so86115755ad.0
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 01:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735204855; x=1735809655; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jTGCHurffdvuN9kJdI3fUeZO0sn2eS3OgYC0qqhseQw=;
 b=ekf5OiRv+eqie3D+IvFyhDLXUyv+hfKw3XJxRMsNJ1V7TmJIG3x02gt0jYq+BV6AYc
 bddnhx86cBpuPDX5M2LM5RINIRoZTq4iYRobFgmZQJQBwZr3yxU6SNypTJBnx/xfvDq1
 juyYN+9m7FAdhTd9pL0nmJZeK2ixULEcLLRaOHbszrSYRdy0m4nNfIReFL6FOOfc8p2W
 SfHzgESnXhJgFHp3GEJLUIVMMBaG32hBie/e6VLmta/xZAx7kiJ48VA6GwubP2gP/fCg
 pPXFAyFk+N1b8KiNBu4LAgOlgfl807P4NdIl3GGHpcneOWvOIt7kJ/xMHwhp34Z1oukS
 Ll/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735204855; x=1735809655;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jTGCHurffdvuN9kJdI3fUeZO0sn2eS3OgYC0qqhseQw=;
 b=kFQTX+YIxPsnyXC7WAh6SVWGX26FxqMB1hEjmrkgCYeITz7+i7lCsxE7PRvHIy7hdt
 OGJ9du8XZ+4DqpZlWmycEJXEdvWnER8kUQm/OX5LORXmWgGVUvyWSeoomhYOmWlHwque
 j9wwG0snW8IlOajlUFiL2CrAz2JCjTDYrM20jGwj75y7KjVnf6VNDnRZqD5XGiMEOvxF
 UxUGbkYwGItjh6qD+PAF/1hRfFMcrrfmUk4nmAtuu+6N8vN37fjS2uCcfpfZqc1yjMaS
 Ki2acCwuRNZlQ/lO8cOWedWTrvuus2JE7wkpC5oFMZ2maT6WSnGdYKCJ1g/wDhz3xSHm
 aoQg==
X-Gm-Message-State: AOJu0YxDkt9HaG4J4X/RcicvFZTpzHK76CAmmCDRQgXlm3Tm4bK8/wGT
 UU5Gi6vyWzh4CGezUBONeP3pC/GHfzdgUzauWfjXKggidT0FA/T6
X-Gm-Gg: ASbGncsmiwqToO4W/9nb9art3ViX6/McJfmxLTEdjVxaQ2Somq7nxAgxbqfENTyM6Z/
 SGuRTKUliQevPVbZMfNa2BQJWO09meILHu10LKGL8fDIwGIkVvDFZ+xwzm1AOIEvClwlaYCPl+C
 xheEwW7racdBPN+6+zYjL1r1xzcmGW3L2N85a7mBRzgjQBIHtaTLsq6kn+yVnsAuMQe6+ow9deE
 Uiz0YsaVVKWVSmIG9y3V8mNIPiMd7tDk55B7XZiddc5jWekHLZsJRAeTrI=
X-Google-Smtp-Source: AGHT+IEE8KNpqfmW3tvyDx4JIns7dIaFVpkhZr0+sWuwsynUv76qm6OmwuA1WuPteSDnyyOqdouBFQ==
X-Received: by 2002:a17:903:2b10:b0:216:3e87:c9fc with SMTP id
 d9443c01a7336-219e6e89b91mr357678995ad.5.1735204855179; 
 Thu, 26 Dec 2024 01:20:55 -0800 (PST)
Received: from CNSZTL-DEB.lan ([2408:8362:245d:5fa2:bc4b:53ff:fead:2725])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9d948fsm116347985ad.150.2024.12.26.01.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Dec 2024 01:20:54 -0800 (PST)
From: Tianling Shen <cnsztl@gmail.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tianling Shen <cnsztl@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 0/7] board: rockchip: add FriendlyElec NanoPi R3S
Date: Thu, 26 Dec 2024 17:20:36 +0800
Message-ID: <20241226092043.419511-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.47.0
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

The NanoPi R3S(as "R3S") is an open source platform with dual-Gbps
Ethernet ports designed and developed by FriendlyElec for IoT
applications.

Tianling Shen (7):
  arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board
  arm64: dts: rockchip: fix model name for FriendlyElec NanoPi R3S
  arm64: dts: rockchip: replace deprecated snps,reset props for NanoPi
    R3S
  arm64: dts: rockchip: sort props in pmu_io_domains node for NanoPi R3S
  arm64: dts: rockchip: enable eMMC HS200 mode for NanoPi R3S
  arm64: dts: rockchip: reorder mmc aliases for NanoPi R3S
  board: rockchip: add FriendlyElec NanoPi R3S

 arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi    |   8 +
 board/rockchip/evb_rk3568/MAINTAINERS         |   7 +
 configs/nanopi-r3s-rk3566_defconfig           |  74 +++
 doc/board/rockchip/rockchip.rst               |   1 +
 .../src/arm64/rockchip/rk3566-nanopi-r3s.dts  | 554 ++++++++++++++++++
 5 files changed, 644 insertions(+)
 create mode 100644 arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi
 create mode 100644 configs/nanopi-r3s-rk3566_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts

-- 
2.47.0

