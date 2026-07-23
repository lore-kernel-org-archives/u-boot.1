Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4FEC531F7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 15:14:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38EAE60A7B;
	Thu, 23 Jul 2026 15:14:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yoTdr0zUTB-V; Thu, 23 Jul 2026 15:14:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 586B560A68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784819643;
	bh=Q84Nxz42OPtJGAGmD2LwAoo0F4khKt2jRXdULOEocQw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XCzTqjszFolgS82r4oCzGmT2V5N28H7xZXL6ye9tfxja7wxIPSpSbF2YVdRSwp9sB
	 vEF72rtSZNOgh5onuBOjMTmg00iyyDqdAdClhb/md0fsEjwJWEh6NAo3q8U0FuBtIP
	 0Si77oBf6pbTsug7HG1PeBbKytR8PTxbMqrvomRCap9IpQhl9S44jJvFA0Gv3lC60S
	 7zNFKYJT41r5M97r7nSlmt24AtoOVlNYuqIse2tNlCPriJNZmDB49yCqtdMvFdOUsn
	 RceUAAqaxm2P47iVOg+wscc2OZYSPweNK4lTu57aNmPzvKhPmHiKs/slqk7ZEYP4/+
	 s5F0BtNl8Fn4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 586B560A68;
	Thu, 23 Jul 2026 15:14:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DB8B73B0
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B67FC409B2
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1mOWClLwUILc for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 13:30:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:31::9;
 helo=mail-wm2-x09.google.com; envelope-from=tan.siewert@9elements.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A8FE8409A8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A8FE8409A8
Received: from mail-wm2-x09.google.com (mail-wm2-x09.google.com
 [IPv6:2a00:1450:4864:31::9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A8FE8409A8
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:33 +0000 (UTC)
Received: by mail-wm2-x09.google.com with SMTP id
 5b1f17b1804b1-49553b57612so1273975e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784813431; x=1785418231;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Q84Nxz42OPtJGAGmD2LwAoo0F4khKt2jRXdULOEocQw=;
 b=lh8gdTQwJ64heS7PyB25r+uF+UeU38EORH2noOIrOZ+wNpPaxh7/fCjBhQIi3zJKR6
 obBEpfLIvpf47IAlUozle25K2ZjUGLo0y7yPOGcH+0tEJBtQUCztRsC3jFJC2xpCbX4e
 7AQSWEziRNPF+AGYMJ4+lr7c1TbaXcjF/5GHnhmHch8J4uV+K2o4/4XRclSvLe5Qsk7e
 cGy2tFrHGzRwDVbSN2Mt8Im+flm8fdUCV1OkSN5YqdS2pFt45UU0LdUdCG7rdwepMxgS
 EKM51FtgqWaz2/DQuwWTbyOehqPmXCFvxz7wiMXwdk5N7+xpUpuiz7qcuoSJMJ9IoAia
 jTWA==
X-Forwarded-Encrypted: i=1;
 AHgh+RotEDH1yT2oQ+sobuIztGh0Y4BCFOy6lwN3yrzrswR2cWJpcykCuQmrgxNvs0ci9le5FRQJnGU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyZFIQ4EdaZvAU4CZM9QXXj4a5sP4tHzsVbVfHuOkj7JRQBT6iM
 J168Owjhn1KgnTPIRdet44aKUbzHrvLiKnaKsg6WT8FG5PEkEU/1aagVgkYzzTFJA/U=
X-Gm-Gg: AR+sD11OzRo815CDnVjb7/i+NfPQrgV7TGCGlGqL9LK3Mto2k6gFlgzUm65nb6pgIiU
 Fuuj8zkqPNcPrd6WGZUTXORDvCmdRHPvDsSZ2g7KohRLZ5KUUFZUExXNX0dPO7kCp+fFYX1S2ft
 mqUAN8DMv0NbnUcj7efLk0afTZJdMKRuA1MFWzhPDL4t1akU7E2rrpdFNHBeU/hPU4F4qaaKjrE
 USu/rR2KXs16jyzlfH9HNpUu9K7f4PNm5DqcSyjrygcg2SzUhF80aTAJjFjQdeRJuMBZQGkvCiR
 PVK4slr0d6/nazYYR5KevnTCbtE5o6V5/VOK46v2rEkhId1HSbZ8n+p6mbjsyMUgWN2ga1nOmeK
 rkYGjAYn4dg+XJirlJHj0P9EMhFjYv7zxX4Sft6XtJY7oCHyQrQKdnnT3vDyV37mtKuAGOQW8dL
 9598zEYANpd9wkgw==
X-Received: by 2002:a05:600c:1f82:b0:495:7426:c392 with SMTP id
 5b1f17b1804b1-4957426c545mr31790265e9.1.1784813430791; 
 Thu, 23 Jul 2026 06:30:30 -0700 (PDT)
Received: from [10.12.249.172] ([2a01:599:841:3b94:b6c8:2fa:40db:8ecf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b043727sm97075405e9.4.2026.07.23.06.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 06:30:30 -0700 (PDT)
From: Tan Siewert <tan.siewert@9elements.com>
Subject: [PATCH 0/8] HPE GXP: board information and dynamic DTB configuration
Date: Thu, 23 Jul 2026 15:30:01 +0200
Message-Id: <20260723-9e-gxp-v1-0-f86e5cea239f@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0MjXctU3fSKAl1jE9NkkzQLoyQjCwMloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0AIH4+WGoAAAA=
X-Change-ID: 20260612-9e-gxp-345c4f82b280
To: u-boot@lists.denx.de, Jean-Marie Verdun <verdun@hpe.com>, 
 Nick Hawkins <nick.hawkins@hpe.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>, 
 Tan Siewert <tan.siewert@9elements.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784813429; l=1820;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=pyROtYzoTYGQANu9icesLVmBJBymZKNdqGB9Su8IoY4=;
 b=bUkhhTwFo8ecn83TmMxZh87TAfuggHh3WKrWCxiHuQy++I/BWy0c0o6I7Y7zVYVT1Co1a/K0X
 ei6p19cq7chBlAvlf3muQELiM9Ob9tAolRd4mohQ+Fa0PwzYO/2wrZj
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=
X-Mailman-Approved-At: Thu, 23 Jul 2026 15:13:57 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1784813431; x=1785418231;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Q84Nxz42OPtJGAGmD2LwAoo0F4khKt2jRXdULOEocQw=;
 b=ONarDr2R2otXKv1OUDILXudnDj//ZV6kc4VMYm+q1xfCKAxIMRWCkILrbTJTf99jvw
 7DHOp2dYxf9sy1DT7D8YFXUJuAH38tj/UuWj3D2H/vcKVo2LzUuSIDlCTQi3O4BYmSiP
 eL1DgkmdYE/32wSHQxJ3RNB6LoP4rP//Njjhsc3ZFtVXrWtfDyxeBO5KKtAIfLmwQ406
 G+CtmDpnl5/Fffx+q85FCPjCDQdQDsHe4CDYhm44bfxQ/8ZN5wZkEBUg2i/f9q5K1rJn
 yDxauL6bP9KOChq2r57lIgnUMJJHF1y3AK1YHF3lF92DVQzAiaZJ29NbKUIwN0fyKQkP
 UVUg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=9elements.com header.i=@9elements.com
 header.a=rsa-sha256 header.s=google header.b=ONarDr2R
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

We have teamed up with HPE to extend and maintain the upstream code for
the HPE GXP, a BMC-specific SoC found on HPE ProLiant systems, via an
OpenBMC distribution called Canopy [0].

This series adds support to dynamically add the matching runtime FIT
configuration based on the server ID, and also to display the board
information on an HPE GXP SoC. For querying the data it also requires a
GXP-specific EEPROM driver.

The code is based on an implementation written by HPE in a hard-fork
downstream that is available as tarball.

[0] https://github.com/canopybmc/canopybmc

Signed-off-by: Tan Siewert <tan.siewert@9elements.com>
---
Marcello Sylvester Bauer (7):
      misc: add HPE GXP EEPROM driver
      arm: dts: hpe-gxp: enable GXP EEPROM
      sysinfo: add HPE GXP sysinfo driver
      board: hpe: gxp: dynamic dtb configuration based on server id
      board: hpe: gxp: add boardinfo support
      board: hpe: gxp: display product name
      board: hpe: gxp: configure PCIe device ID in board_init

Tan Siewert (1):
      MAINTAINERS: GXP: Add Marcello and Tan

 MAINTAINERS               |   5 ++
 arch/arm/dts/hpe-gxp.dtsi |  41 +++++++++++++++
 board/hpe/gxp/gxp_board.c | 130 ++++++++++++++++++++++++++++++++++++++++++++--
 configs/gxp_defconfig     |   4 ++
 drivers/misc/Kconfig      |   9 ++++
 drivers/misc/Makefile     |   1 +
 drivers/misc/gxp_eeprom.c | 107 ++++++++++++++++++++++++++++++++++++++
 drivers/sysinfo/Kconfig   |   8 +++
 drivers/sysinfo/Makefile  |   1 +
 drivers/sysinfo/gxp.c     | 115 ++++++++++++++++++++++++++++++++++++++++
 10 files changed, 417 insertions(+), 4 deletions(-)
---
base-commit: de02bc0eccb76aec8272abed651c35ab120f4844
change-id: 20260612-9e-gxp-345c4f82b280

Best regards,
--  
Tan Siewert <tan.siewert@9elements.com>

