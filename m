Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117AFD111B3
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 22:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56B2283A71;
	Wed, 26 Nov 2025 23:16:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="Clg47Ec1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0C3C83A7A; Wed, 26 Nov 2025 23:16:41 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7B6C83A64
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 23:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1764195379;
 bh=zy3+ETuaPfzfgwFM19C/ULHvy1KVTiou6fTPH826xUw=;
 h=From:To:Cc:Subject:Date:From;
 b=Clg47Ec1Zxv9mbVdoxKM1Dy/UGuowDR/v3f6fBwKf/7NtZC70VqByl9kzbs5d57wc
 DR+R5Fvapy59vN8jADIIv02orGdx/fHZUGopCGP7JBLMmaRsj/vecjSy+QyNM3VQUS
 72sdEmJu+CVI+Y0RROgzOzGVKvyVBekykOFu9eQAQob2VQpl+zFin3hOIpACWMEWV0
 NclfAL3wHGSVit/iyYDkp8l/1IThiox+7j5HCyT+IqtroJFPGjPQ+bsQ+zO+FSxyvC
 +aqBrl57W32kq+4YsSuVsjflt+A/jCWzGmWTUxauq05SUq4bDr/4y6l7lfzmH5tKJD
 Rwkik+q1Tz9GQ==
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 4180EB220199;
 Wed, 26 Nov 2025 23:16:17 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, E Shattow <e@freeshell.de>,
 Icenowy Zheng <uwu@icenowy.me>
Subject: [RFC PATCH v1 0/4] Add upstream board Xunlong Orange Pi RV
Date: Wed, 26 Nov 2025 14:15:25 -0800
Message-ID: <20251126221552.87574-1-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
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

Xunlong Orange Pi RV patches are now queued up for the next merge window
to Linux v6.19, so let's introduce support for this board.

Note: The content of EEPROM is not known to be unique on this board, and
in this RFC there is a placeholder value of "XOPIRV".

E Shattow (4):
  riscv: dts: starfive: Add Orange Pi RV from upstream Linux for-next
  board: starfive: visionfive2: Add Orange Pi RV selection by product_id
  riscv: dts: Add placeholder files for pending upstream Orange Pi RV
  configs: starfive: Add Orange Pi RV to visionfive2

 arch/riscv/dts/jh7110-orangepi-rv-u-boot.dtsi | 76 +++++++++++++++++++
 board/starfive/visionfive2/spl.c              |  3 +
 .../visionfive2/starfive_visionfive2.c        |  2 +
 configs/starfive_visionfive2_defconfig        |  2 +-
 .../src/riscv/starfive/jh7110-orangepi-rv.dts |  0
 5 files changed, 82 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/dts/jh7110-orangepi-rv-u-boot.dtsi
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110-orangepi-rv.dts


base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
-- 
2.50.0

