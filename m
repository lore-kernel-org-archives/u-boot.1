Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B614CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 12:26:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D28640D97;
	Fri,  2 Oct 2026 12:26:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TWeUSfkikx-2; Fri,  2 Oct 2026 12:26:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 36B4440D8F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790943981;
	b=CzrjgbpprAyOaMcDxIjos56DQ1snRx6kVsJJbSgoDa/KIUvAzQKpDcQADnsWa4+qdSj8
	 aivdMOp6JCm1unI8zYa8qlWAe+jKyZLP/9NtLGthrp+4SiWxx9phudqhFAHvcUO4FyStU
	 6B0sASdk2qoVvNA322tyI1J+uGyQjv+FpyUgfYVcMUjlNWK/8UtpgpCCEI3AJZPkEUhvl
	 eoncOGakM2ki41JIdcXXSvRVC045D5qKRn2iwH/cbgwfka1W9jbss4MzsmojSQUvNK8W0
	 M3XcxwvzC5qA1zxCW9R1Ry2jP0B10lxje5IxobfGmjiEpRlcGc7ecbfMzFcBTPQbtvw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790943981;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MRv2YFVT16RMxse9IR2Vpau9ju2dnIz9V3w1iBlod6k=;
	b=QnHhY7ZBnOO8rS3jCkjOrigAgn1s43Yx0OiZR2UdL1QBKGiUQ+6GJwjG5qZNu3PqIqb6
	 0rPH1Alt7UF5iFhWMxUhWvRRl/sYUabY87W0vVTo56pTOgr09QsxDeoUit3nAqFYYRfWb
	 9Ugk2o2gufXIbKKDPkMLGPQ7QXQ6PGgqjLqlKYXiTrO+JFKnLw+m7NwBoCSa+7sgq2j/V
	 YASJCjg/Qi6EvlBGWZec5LEI4FbVI0zsCTnh0GaoRiydJY1LTrC+JpMt92zehGnHMI78I
	 NTb09Iq7Keq/0CeqbXVM5+Z8byo6oPBp9vZTKp2bGhogEGcZroYTR0LQBYeuO7Y1BrA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790943981;
	bh=MRv2YFVT16RMxse9IR2Vpau9ju2dnIz9V3w1iBlod6k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=loFchubLO1zjNUmO5B2U7sM1f+NE92yVG4mK6eJTuexdasQlXLuhob11h6EnpsoqI
	 WdzCrRtsQdvgl5kZL8YdU2KEmJQhDugMLphucS4jxxxLF2+dyTdGTkMsbnpYqa/D5Q
	 FcMWONYg808RcNvd77xdai4tEjfF7kOGd/Ng1+MiMidqyiE2QxP4QvYZsgA65uADpv
	 vh2qYvnRQ887n1PWWebGO+6WsqKdLsoUHRx8ETP/KowS2O305f9GjU6Hw7MWoDgvdg
	 61qgFZsuM78t1JuPUx4OQFRzFpfrNBM5BkYgP2swiLJ14MSWuVkQuaWCBSk/BzNqhA
	 I10cfGK4FWl/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36B4440D8F;
	Fri,  2 Oct 2026 12:26:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7ECA422B
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:36:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 642BA81096
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:36:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sPnvYuRG3YVZ for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 03:36:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 918308113D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790912199;
 b=kcQNZrp5/ho3/TFa6CrW4Nx/xtLY1/9FeZcEquzHdFyPx8GxkqLIIL/FFct33Xm7aybf
 uqGYCw/7mY6L8zVbhUce5zTOw2cTUcQEvefdpJ1Q9JZcdyNSIlhfcajsOn7CoD3BEzLHD
 G9IVmrzzUvnn5L2faS0f7PkZxdVamkLJQV2ETqq3s6BKgO4+l3+s7kOmleRsbfsGSEvOu
 u85OTnhBbpQuuUVhshXKOxkEs3ydWdEfPiw8o7Ja73bsaLUaMx6Qc3DM2GExHN2lPj4wg
 PI0h+iJTjabdqTvQjHZ2PVdTYOKj43N05YpFaAOV5zp/4B3aR0pHSL/Bp3iw+NdsNig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790912199;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=MRv2YFVT16RMxse9IR2Vpau9ju2dnIz9V3w1iBlod6k=;
 b=SjN8LpQyNEdL/5/HwFEmSQGPWnuFF8Bz60OindJTeEhS6luUI21L15ekNYgItmoffgOZ
 EtrQh2hRV3BVVzujV0qTLOVerN8/8msuEkxvFjSfNFQ8dQrTa5VaMQ50D12EN1fjZvwHS
 qT5PE9wkjl5hkR3CqXe4hEiF/Nubv1PblgO+3Tlf3YMVIZkU8mfyyA3kJj2T41bvYUIZZ
 YnQQQtA1ULYBAaQWQfzQ+TcO5ZweB+dihJrqI+7xPtVWrj+5NBgw+NqX+pBtnHBuYQ509
 Ruy17Z+Y6stE+FSOdGiCCbDA1OBIcyz1PbWMLGAXjdRU/svTV4TcV/0DzTxH0HylQ1A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FME2v91o; 
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:3b::2a; helo=mail-pz2-x2a.google.com;
 envelope-from=sycamoremoon376@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FME2v91o
Received: from mail-pz2-x2a.google.com (mail-pz2-x2a.google.com
 [IPv6:2607:f8b0:4864:3b::2a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 918308113D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:36:39 +0000 (UTC)
Received: by mail-pz2-x2a.google.com with SMTP id
 41be03b00d2f7-cc7a15ba46fso2271462a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 20:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790912198; x=1791516998;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MRv2YFVT16RMxse9IR2Vpau9ju2dnIz9V3w1iBlod6k=;
 b=FME2v91oOzH/4FMBIfsAWAB7Rstd6vPfn5+uPWAF4hLe3rsjNU8oe+NyZLfX2hUbBH
 k+7ERn6M3gTP+bww/Uz6VcFfS6n7Gy3rJ6gkgtpaFmn5YIiY89Eu8MArOUbH5Uj+JbAC
 HJJPat+azRnpkAU+4ueAqgE6mEwAx4pVYVEd5XI+ypE5XxmRwKUVSGJWSeFQR3nQBc52
 l65Lx7jLBCJTXE/K3ehIIFtK+xFb/ZRNoxIbSagNzb0WSnooMCVAXq+Z/99AgXU5yb8u
 nf9699R3/OcJKHOrnTZVXkGYnPKY1sveXO8hFLxBMwlUFH3Oym1ny0+v3rqWdBLtV66Z
 1o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790912198; x=1791516998;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MRv2YFVT16RMxse9IR2Vpau9ju2dnIz9V3w1iBlod6k=;
 b=lHZEj7fofIXPZ8lj+KWosdxXiPN98VM/xWxGeVDokrHPGyu0Kv/V9FCZCCvoO9K/2e
 ELapO44zprT9b5HHM/boYsj5+1zVHPwIKwPhvRx2FzigVBbeojwuzO/vg2Vwe6BCFUjw
 odYjvA0XftA8R4cWIvL416VjZfV/ibTZPYdB8RxiPelDcvvvhaTrBbaEsLOg8apXGVJm
 Fbuww3FZqARld7U/8dN5w8dLGyGubiHT9qNIGCPWQ2f3U3XIYfG1Qnxt4NPwgCL8w2nt
 hK9+5DcBGEcgE2O8n6Y3q8fvkyavLm9N2K6Y05t8l05xSwBUpJgvFXobM2lpMOp5P9EQ
 bjRA==
X-Gm-Message-State: AFq9FYKwHs6KA+nGmykGC+gzCifFK8cwXQ3yWC+wjkxyt4wap6JgceGM
 EmdFaMqTr/opNeys2o/Y5MXrDJ3/pnPrLMCnZGewMAi//3YmeGYIvPC9
X-Gm-Gg: AYBFou2cGdC85AnxmohhgJ0xjoONBlzhWgFonjyx0kg0v1CfZ7ue4spCtemgFayZYfc
 qT1Vd5EHr3+6ok9uKWUV1Xtk6f0WzAF55g1cr1uDS4RrLoB/yRjqiuixwMWPY3+TT/lODlnQtAA
 yBtWW1JM7+MsczOkQYlEdC+WBgI7kg2BtoFTUeGKcRjLSjb17pHpBwTjbhFSIlXkgj9ETjMMGI5
 z+5ghLDNPTlX1WzEX3DQY1dOLZKh5xch1M9uFUNyEkLAhJ2xLIAgkeGT3n9SXeXH1k7HLnvL03O
 Z3xY5lqZzojsGJ9osZiQ8u7YmOakgY57tz42KvG+FWPU5Sehv7GilJwq9uttWU40LQ1mH9q9kgw
 bBHXQ8stGofaqlYuT98J2mL8/0GGIMnrgLNU9SA7TYNz/GkwCfrFsU/mdbwOL9RzGH5XOmdhRh2
 cTvn+OdOmUheac3GmLvvENggGR1hhQKNT9k4LNErdWTTyBDaLzMRITA/gBzHOCQ2M0jQXNe+e6l
 DY+vpSD/VTD
X-Received: by 2002:a17:90b:3ec2:b0:3a4:c11d:b78b with SMTP id
 98e67ed59e1d1-3a6ce8209d0mr1293707a91.22.1790912198131; 
 Thu, 01 Oct 2026 20:36:38 -0700 (PDT)
Received: from [10.27.250.254] ([58.194.169.253])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6cd634734sm2083232a91.17.2026.10.01.20.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 20:36:37 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Fri, 02 Oct 2026 11:35:25 +0800
Subject: [PATCH 1/3] net: k1: add Ethernet MAC driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-b4-k1-emac-v1-1-e1b6806b018a@gmail.com>
References: <20261002-b4-k1-emac-v1-0-e1b6806b018a@gmail.com>
In-Reply-To: <20261002-b4-k1-emac-v1-0-e1b6806b018a@gmail.com>
To: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong.xu@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Eric Chung <eric.chung@riscstar.com>, Yixun Lan <dlan@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790912185; l=31270;
 i=sycamoremoon376@gmail.com; s=20260926; h=from:subject:message-id;
 bh=JCc+6H6QtS8Pdr6D18YWmPeGVE7DP1PqmAvztV/8HIk=;
 b=ilgttpn8kBN8t+I+BpcYjwpXqAJPip/wqxmOCbasBdXStkSEvV/DvwW/J+QtE3KFbBfwhFdyZ
 fXsC/TT06AHD0sOyYTfalZTpOASIgsMDGtxw7QgjiY3RbdZBN/py+1/
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=xO+BwE3DuX3uCUVEo06fonjJtjMp0vUdCPuPP450qO4=
X-Mailman-Approved-At: Fri, 02 Oct 2026 12:26:15 +0000
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

Add Ethernet MAC driver support for the SpacemiT K1 SoC. The driver
supports RGMII and RMII interfaces, synchronous transmission, and exposes
the integrated MDIO controller through the MDIO uclass.

The register definitions, descriptor layout, MDIO protocol, RGMII delay
line handling and hardware initialisation sequences are derived from the
mainline Linux commit bfec6d7f2001 (net: spacemit: Add K1 Ethernet MAC).

Link: https://lore.kernel.org/all/20250914-net-k1-emac-v12-0-65b31b398f44@iscas.ac.cn/
Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 drivers/net/Kconfig            |   1 +
 drivers/net/Makefile           |   1 +
 drivers/net/spacemit/Kconfig   |  15 +
 drivers/net/spacemit/Makefile  |   3 +
 drivers/net/spacemit/k1_emac.c | 952 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 972 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index c057504cf66..7e800742fcc 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1123,6 +1123,7 @@ config MDIO_MUX_MESON_GXL
 source "drivers/net/phy/Kconfig"
 source "drivers/net/pfe_eth/Kconfig"
 source "drivers/net/fsl-mc/Kconfig"
+source "drivers/net/spacemit/Kconfig"
 
 endif # NETDEVICES
 
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 96ec6fb187a..935e4dda394 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -105,6 +105,7 @@ obj-$(CONFIG_SJA1105) += sja1105.o
 obj-$(CONFIG_SMC911X) += smc911x.o
 obj-$(CONFIG_SNI_AVE) += sni_ave.o
 obj-$(CONFIG_SNI_NETSEC) += sni_netsec.o
+obj-$(CONFIG_SPACEMIT_K1_EMAC) += spacemit/
 obj-$(CONFIG_SUN4I_EMAC) += sunxi_emac.o
 obj-$(CONFIG_SUN8I_EMAC) += sun8i_emac.o
 obj-$(CONFIG_TSEC_ENET) += tsec.o fsl_mdio.o
diff --git a/drivers/net/spacemit/Kconfig b/drivers/net/spacemit/Kconfig
new file mode 100644
index 00000000000..c3955556853
--- /dev/null
+++ b/drivers/net/spacemit/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+config SPACEMIT_K1_EMAC
+	bool "SpacemiT K1 Ethernet MAC support"
+	depends on TARGET_SPACEMIT_K1
+	select DM_DMA
+	select DM_ETH_PHY
+	select DM_MDIO
+	select PHYLIB
+	select PHY_GIGE
+	help
+	  Enable support for the Ethernet MAC integrated in the SpacemiT K1.
+	  The controller supports 10/100/1000 Mbps links through RGMII and
+	  10/100 Mbps links through RMII. Its internal MDIO controller is
+	  exposed through the driver-model MDIO uclass.
diff --git a/drivers/net/spacemit/Makefile b/drivers/net/spacemit/Makefile
new file mode 100644
index 00000000000..ca595ddfc9a
--- /dev/null
+++ b/drivers/net/spacemit/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-$(CONFIG_SPACEMIT_K1_EMAC) += k1_emac.o
diff --git a/drivers/net/spacemit/k1_emac.c b/drivers/net/spacemit/k1_emac.c
new file mode 100644
index 00000000000..ba6167eede3
--- /dev/null
+++ b/drivers/net/spacemit/k1_emac.c
@@ -0,0 +1,952 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SpacemiT K1 Ethernet MAC driver
+ *
+ * Copyright (C) 2023-2025 SpacemiT (Hangzhou) Technology Co. Ltd
+ * Copyright (C) 2025 Vivian Wang <wangruikang@iscas.ac.cn>
+ * Copyright (C) 2026 Zixian Zeng <sycamoremoon376@gmail.com>
+ */
+
+#include <clk.h>
+#include <cpu_func.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/lists.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <malloc.h>
+#include <miiphy.h>
+#include <net.h>
+#include <phys2bus.h>
+#include <regmap.h>
+#include <reset.h>
+#include <wait_bit.h>
+#include <asm/barrier.h>
+#include <asm/cache.h>
+#include <asm/io.h>
+
+/* APMU syscon registers */
+#define K1_APMU_EMAC_CTRL			0x0
+#define  K1_APMU_PHY_INTF_RGMII			BIT(2)
+#define  K1_APMU_REF_CLK_SEL			BIT(3)
+#define  K1_APMU_RGMII_TX_CLK_SEL		BIT(8)
+#define  K1_APMU_AXI_SINGLE_ID			BIT(13)
+#define K1_APMU_EMAC_DLINE			0x4
+#define  K1_APMU_RX_DLINE_EN			BIT(0)
+#define  K1_APMU_RX_DLINE_STEP			GENMASK(5, 4)
+#define  K1_APMU_RX_DLINE_CODE			GENMASK(15, 8)
+#define  K1_APMU_TX_DLINE_EN			BIT(16)
+#define  K1_APMU_TX_DLINE_STEP			GENMASK(21, 20)
+#define  K1_APMU_TX_DLINE_CODE			GENMASK(31, 24)
+
+/* DMA registers */
+#define K1_DMA_CONFIG				0x000
+#define  K1_DMA_CONFIG_SW_RESET			BIT(0)
+#define  K1_DMA_CONFIG_BURST_16			BIT(5)
+#define  K1_DMA_CONFIG_STRICT_BURST		BIT(17)
+#define  K1_DMA_CONFIG_64BIT_MODE		BIT(18)
+#define K1_DMA_CONTROL				0x004
+#define  K1_DMA_CONTROL_TX_START		BIT(0)
+#define  K1_DMA_CONTROL_RX_START		BIT(1)
+#define K1_DMA_STATUS				0x008
+#define  K1_DMA_STATUS_TX_DESC_UNAVAILABLE	BIT(1)
+#define K1_DMA_INTERRUPT_ENABLE			0x00c
+#define K1_DMA_TX_AUTO_POLL			0x010
+#define K1_DMA_TX_POLL_DEMAND			0x014
+#define K1_DMA_RX_POLL_DEMAND			0x018
+#define K1_DMA_TX_DESC_BASE			0x01c
+#define K1_DMA_RX_DESC_BASE			0x020
+
+/* MAC registers */
+#define K1_MAC_GLOBAL_CONTROL			0x100
+#define  K1_MAC_SPEED				GENMASK(1, 0)
+#define  K1_MAC_SPEED_10			0
+#define  K1_MAC_SPEED_100			BIT(0)
+#define  K1_MAC_SPEED_1000			BIT(1)
+#define  K1_MAC_FULL_DUPLEX			BIT(2)
+#define K1_MAC_TX_CONTROL			0x104
+#define  K1_MAC_TX_ENABLE			BIT(0)
+#define  K1_MAC_TX_AUTO_RETRY			BIT(3)
+#define  K1_MAC_TX_IFG				GENMASK(6, 4)
+#define K1_MAC_RX_CONTROL			0x108
+#define  K1_MAC_RX_ENABLE			BIT(0)
+#define  K1_MAC_RX_STORE_FORWARD		BIT(3)
+#define K1_MAC_MAX_FRAME_SIZE			0x10c
+#define K1_MAC_TX_JABBER_SIZE			0x110
+#define K1_MAC_RX_JABBER_SIZE			0x114
+#define K1_MAC_ADDRESS_CONTROL			0x118
+#define  K1_MAC_ADDRESS1_ENABLE			BIT(0)
+#define K1_MAC_ADDRESS1_HIGH			0x120
+#define K1_MAC_ADDRESS1_MED			0x124
+#define K1_MAC_ADDRESS1_LOW			0x128
+#define K1_MAC_MULTICAST_HASH1			0x150
+#define K1_MAC_MULTICAST_HASH2			0x154
+#define K1_MAC_MULTICAST_HASH3			0x158
+#define K1_MAC_MULTICAST_HASH4			0x15c
+#define K1_MAC_MDIO_CONTROL			0x1a0
+#define  K1_MAC_MDIO_PHY_ADDR			GENMASK(4, 0)
+#define  K1_MAC_MDIO_REG_ADDR			GENMASK(9, 5)
+#define  K1_MAC_MDIO_READ			BIT(10)
+#define  K1_MAC_MDIO_START			BIT(15)
+#define K1_MAC_MDIO_DATA			0x1a4
+#define K1_MAC_TX_FIFO_ALMOST_FULL		0x1c0
+#define K1_MAC_TX_PACKET_THRESHOLD		0x1c4
+#define K1_MAC_RX_PACKET_THRESHOLD		0x1c8
+#define K1_MAC_INTERRUPT_ENABLE			0x1e4
+
+/* Receive DMA descriptor */
+#define K1_RX_DESC_FRAME_LEN			GENMASK(13, 0)
+#define K1_RX_DESC_ALIGN_ERR			BIT(14)
+#define K1_RX_DESC_RUNT				BIT(15)
+#define K1_RX_DESC_CRC_ERR			BIT(20)
+#define K1_RX_DESC_MAX_LEN_ERR			BIT(21)
+#define K1_RX_DESC_JABBER_ERR			BIT(22)
+#define K1_RX_DESC_LENGTH_ERR			BIT(23)
+#define K1_RX_DESC_LAST				BIT(29)
+#define K1_RX_DESC_FIRST			BIT(30)
+#define K1_RX_DESC_OWN				BIT(31)
+#define K1_RX_DESC_BUFFER_SIZE			GENMASK(11, 0)
+#define K1_RX_DESC_END_RING			BIT(26)
+
+/* Transmit DMA descriptor */
+#define K1_TX_DESC_OWN				BIT(31)
+#define K1_TX_DESC_BUFFER_SIZE			GENMASK(11, 0)
+#define K1_TX_DESC_END_RING			BIT(26)
+#define K1_TX_DESC_FIRST			BIT(29)
+#define K1_TX_DESC_LAST				BIT(30)
+
+#define K1_TX_DESC_COUNT			4
+#define K1_RX_DESC_COUNT			16
+#define K1_DESC_SIZE				16
+#define K1_DESCS_PER_CACHELINE			(ARCH_DMA_MINALIGN / K1_DESC_SIZE)
+#define K1_TX_DESC_ALLOC_SIZE			ALIGN(K1_TX_DESC_COUNT * \
+							K1_DESC_SIZE, \
+							ARCH_DMA_MINALIGN)
+#define K1_RX_DESC_ALLOC_SIZE			ALIGN(K1_RX_DESC_COUNT * \
+							K1_DESC_SIZE, \
+							ARCH_DMA_MINALIGN)
+#define K1_DMA_BUF_SIZE				ALIGN(PKTSIZE_ALIGN, ARCH_DMA_MINALIGN)
+#define K1_MDIO_TIMEOUT_MS			10
+#define K1_TX_TIMEOUT_MS			1000
+
+/* The delay line is programmed in 15.6 ps steps. */
+#define K1_DLINE_STEP_PS_X10			156
+#define K1_DLINE_MAX_CODE			(FIELD_MAX(K1_APMU_TX_DLINE_CODE) - 1)
+
+/* Tuning values recommended by SpacemiT. */
+#define K1_TX_FIFO_ALMOST_FULL_DEFAULT		0x1f8
+#define K1_TX_PACKET_THRESHOLD_DEFAULT		1518
+#define K1_RX_PACKET_THRESHOLD_DEFAULT		12
+
+#define K1_RX_DESC_ERRORS			(K1_RX_DESC_ALIGN_ERR | \
+							K1_RX_DESC_RUNT | K1_RX_DESC_CRC_ERR | \
+							K1_RX_DESC_MAX_LEN_ERR | \
+							K1_RX_DESC_JABBER_ERR | \
+							K1_RX_DESC_LENGTH_ERR)
+
+struct k1_emac_desc {
+	u32 status;
+	u32 control;
+	u32 buffer_addr1;
+	u32 buffer_addr2;
+};
+
+struct k1_emac_priv {
+	void __iomem *base;
+	struct regmap *apmu;
+	u32 apmu_offset;
+	phy_interface_t interface;
+	u32 max_speed;
+	u32 tx_delay_code;
+	u32 rx_delay_code;
+	struct clk clk;
+	struct reset_ctl reset;
+	struct phy_device *phy;
+	struct k1_emac_desc *tx_desc;
+	struct k1_emac_desc *rx_desc;
+	u8 *tx_buf;
+	u8 *rx_buf;
+	u32 tx_desc_dma;
+	u32 rx_desc_dma;
+	u32 tx_buf_dma[K1_TX_DESC_COUNT];
+	u32 rx_buf_dma[K1_RX_DESC_COUNT];
+	u32 tx_index;
+	u32 rx_index;
+	char mdio_name[MDIO_NAME_LEN];
+	bool rx_pending;
+	bool clk_enabled;
+	bool reset_deasserted;
+};
+
+static inline struct k1_emac_desc *k1_desc_at(struct k1_emac_desc *ring,
+					      unsigned int index)
+{
+	return &ring[index];
+}
+
+static inline u8 *k1_rx_buf_at(struct k1_emac_priv *priv, unsigned int index)
+{
+	return priv->rx_buf + index * K1_DMA_BUF_SIZE;
+}
+
+static inline u8 *k1_tx_buf_at(struct k1_emac_priv *priv, unsigned int index)
+{
+	return priv->tx_buf + index * K1_DMA_BUF_SIZE;
+}
+
+static void k1_desc_flush(struct k1_emac_desc *desc)
+{
+	ulong start = ALIGN_DOWN((ulong)desc, ARCH_DMA_MINALIGN);
+
+	flush_dcache_range(start, start + ARCH_DMA_MINALIGN);
+	/* Complete the clean before notifying the DMA engine. */
+	mb();
+}
+
+static void k1_desc_invalidate(struct k1_emac_desc *desc)
+{
+	ulong start = ALIGN_DOWN((ulong)desc, ARCH_DMA_MINALIGN);
+
+	invalidate_dcache_range(start, start + ARCH_DMA_MINALIGN);
+	/* Complete the invalidation before inspecting DMA-written fields. */
+	mb();
+}
+
+static void k1_buffer_flush(void *buffer)
+{
+	flush_dcache_range((ulong)buffer, (ulong)buffer + K1_DMA_BUF_SIZE);
+}
+
+static void k1_buffer_invalidate(void *buffer)
+{
+	invalidate_dcache_range((ulong)buffer, (ulong)buffer + K1_DMA_BUF_SIZE);
+}
+
+static bool k1_interface_is_rgmii(phy_interface_t interface)
+{
+	return interface == PHY_INTERFACE_MODE_RGMII ||
+	       interface == PHY_INTERFACE_MODE_RGMII_ID ||
+	       interface == PHY_INTERFACE_MODE_RGMII_RXID ||
+	       interface == PHY_INTERFACE_MODE_RGMII_TXID;
+}
+
+static u32 k1_emac_delay_ps_to_code(u32 delay_ps)
+{
+	return DIV_ROUND_CLOSEST(delay_ps * 10, K1_DLINE_STEP_PS_X10);
+}
+
+static u32 k1_emac_delay_code_to_ps(u32 delay_code)
+{
+	return DIV_ROUND_CLOSEST(delay_code * K1_DLINE_STEP_PS_X10, 10);
+}
+
+static int k1_emac_read_delay(struct udevice *dev, const char *property,
+			      u32 *delay_code)
+{
+	u32 max_delay_ps = k1_emac_delay_code_to_ps(K1_DLINE_MAX_CODE);
+	u32 delay_ps = dev_read_u32_default(dev, property, 0);
+
+	if (delay_ps > max_delay_ps) {
+		dev_err(dev, "%s exceeds the maximum of %u ps: %u ps\n",
+			property, max_delay_ps, delay_ps);
+		return -EINVAL;
+	}
+
+	*delay_code = k1_emac_delay_ps_to_code(delay_ps);
+	return 0;
+}
+
+static int k1_emac_dma32(struct udevice *dev, void *ptr, u32 *address)
+{
+	dma_addr_t dma = dev_phys_to_bus(dev, virt_to_phys(ptr));
+
+	if (upper_32_bits(dma)) {
+		dev_err(dev, "DMA address %llx is outside the 32-bit window\n",
+			(unsigned long long)dma);
+		return -ERANGE;
+	}
+
+	*address = lower_32_bits(dma);
+	return 0;
+}
+
+static int k1_emac_config_interface(struct k1_emac_priv *priv)
+{
+	u32 ctrl_mask = K1_APMU_REF_CLK_SEL | K1_APMU_RGMII_TX_CLK_SEL |
+			K1_APMU_PHY_INTF_RGMII;
+	u32 dline_mask = K1_APMU_RX_DLINE_EN | K1_APMU_RX_DLINE_STEP |
+			 K1_APMU_RX_DLINE_CODE | K1_APMU_TX_DLINE_EN |
+			 K1_APMU_TX_DLINE_STEP | K1_APMU_TX_DLINE_CODE;
+	u32 ctrl = 0, dline = 0;
+	int ret;
+
+	if (k1_interface_is_rgmii(priv->interface)) {
+		ctrl = K1_APMU_PHY_INTF_RGMII;
+		dline = K1_APMU_RX_DLINE_EN |
+			 FIELD_PREP(K1_APMU_RX_DLINE_CODE,
+				    priv->rx_delay_code) |
+			 K1_APMU_TX_DLINE_EN |
+			 FIELD_PREP(K1_APMU_TX_DLINE_CODE,
+				    priv->tx_delay_code);
+	}
+
+	ret = regmap_update_bits(priv->apmu, priv->apmu_offset + K1_APMU_EMAC_CTRL,
+				 ctrl_mask, ctrl);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(priv->apmu,
+				  priv->apmu_offset + K1_APMU_EMAC_DLINE,
+				  dline_mask, dline);
+}
+
+static int k1_emac_write_hwaddr(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct k1_emac_priv *priv = dev_get_priv(dev);
+	const u8 *addr = pdata->enetaddr;
+
+	writel(addr[1] << 8 | addr[0], priv->base + K1_MAC_ADDRESS1_HIGH);
+	writel(addr[3] << 8 | addr[2], priv->base + K1_MAC_ADDRESS1_MED);
+	writel(addr[5] << 8 | addr[4], priv->base + K1_MAC_ADDRESS1_LOW);
+
+	return 0;
+}
+
+static int k1_emac_hw_init(struct k1_emac_priv *priv)
+{
+	u32 config;
+	int ret;
+
+	writel(0, priv->base + K1_MAC_INTERRUPT_ENABLE);
+	writel(0, priv->base + K1_DMA_INTERRUPT_ENABLE);
+	writel(0, priv->base + K1_MAC_RX_CONTROL);
+	writel(0, priv->base + K1_MAC_TX_CONTROL);
+	writel(0, priv->base + K1_DMA_CONTROL);
+
+	ret = regmap_update_bits(priv->apmu,
+				 priv->apmu_offset + K1_APMU_EMAC_CTRL,
+				 K1_APMU_AXI_SINGLE_ID, K1_APMU_AXI_SINGLE_ID);
+	if (ret)
+		return ret;
+
+	writel(K1_MAC_ADDRESS1_ENABLE, priv->base + K1_MAC_ADDRESS_CONTROL);
+	writel(0, priv->base + K1_MAC_MULTICAST_HASH1);
+	writel(0, priv->base + K1_MAC_MULTICAST_HASH2);
+	writel(0, priv->base + K1_MAC_MULTICAST_HASH3);
+	writel(0, priv->base + K1_MAC_MULTICAST_HASH4);
+	writel(K1_TX_FIFO_ALMOST_FULL_DEFAULT,
+	       priv->base + K1_MAC_TX_FIFO_ALMOST_FULL);
+	writel(K1_TX_PACKET_THRESHOLD_DEFAULT,
+	       priv->base + K1_MAC_TX_PACKET_THRESHOLD);
+	writel(K1_RX_PACKET_THRESHOLD_DEFAULT,
+	       priv->base + K1_MAC_RX_PACKET_THRESHOLD);
+	writel(K1_DMA_BUF_SIZE, priv->base + K1_MAC_MAX_FRAME_SIZE);
+	writel(K1_DMA_BUF_SIZE, priv->base + K1_MAC_TX_JABBER_SIZE);
+	writel(K1_DMA_BUF_SIZE, priv->base + K1_MAC_RX_JABBER_SIZE);
+
+	writel(K1_DMA_CONFIG_SW_RESET, priv->base + K1_DMA_CONFIG);
+	mdelay(10);
+	writel(0, priv->base + K1_DMA_CONFIG);
+	mdelay(10);
+
+	config = K1_DMA_CONFIG_STRICT_BURST | K1_DMA_CONFIG_64BIT_MODE |
+		 K1_DMA_CONFIG_BURST_16;
+	writel(config, priv->base + K1_DMA_CONFIG);
+
+	return 0;
+}
+
+static int k1_emac_adjust_link(struct udevice *dev)
+{
+	struct k1_emac_priv *priv = dev_get_priv(dev);
+	u32 value = readl(priv->base + K1_MAC_GLOBAL_CONTROL);
+
+	value &= ~(K1_MAC_SPEED | K1_MAC_FULL_DUPLEX);
+	if (priv->phy->duplex == DUPLEX_FULL)
+		value |= K1_MAC_FULL_DUPLEX;
+
+	switch (priv->phy->speed) {
+	case SPEED_1000:
+		value |= K1_MAC_SPEED_1000;
+		break;
+	case SPEED_100:
+		value |= K1_MAC_SPEED_100;
+		break;
+	case SPEED_10:
+		value |= K1_MAC_SPEED_10;
+		break;
+	default:
+		dev_err(dev, "unsupported link speed %d\n", priv->phy->speed);
+		return -EINVAL;
+	}
+
+	writel(value, priv->base + K1_MAC_GLOBAL_CONTROL);
+	return 0;
+}
+
+static void k1_emac_prepare_rx(struct k1_emac_priv *priv, unsigned int index)
+{
+	struct k1_emac_desc *desc = k1_desc_at(priv->rx_desc, index);
+	u8 *buffer = k1_rx_buf_at(priv, index);
+
+	k1_buffer_flush(buffer);
+	desc->control = FIELD_PREP(K1_RX_DESC_BUFFER_SIZE, K1_DMA_BUF_SIZE);
+	if (index == K1_RX_DESC_COUNT - 1)
+		desc->control |= K1_RX_DESC_END_RING;
+	desc->buffer_addr1 = priv->rx_buf_dma[index];
+	desc->buffer_addr2 = 0;
+	desc->status = K1_RX_DESC_OWN;
+}
+
+static void k1_emac_advance_rx(struct k1_emac_priv *priv)
+{
+	unsigned int index = priv->rx_index;
+	unsigned int first;
+
+	/*
+	 * Multiple 16-byte descriptors share a cache line. Do not clean that
+	 * line while DMA may still be updating another descriptor in it. Return
+	 * descriptors to DMA only after the complete cache-line-sized group has
+	 * been consumed.
+	 */
+	if (!((index + 1) % K1_DESCS_PER_CACHELINE)) {
+		first = index + 1 - K1_DESCS_PER_CACHELINE;
+		for (; first <= index; first++)
+			k1_emac_prepare_rx(priv, first);
+
+		/* Complete descriptor stores before cleaning the cache line. */
+		mb();
+		k1_desc_flush(k1_desc_at(priv->rx_desc, index));
+		writel(1, priv->base + K1_DMA_RX_POLL_DEMAND);
+	}
+
+	priv->rx_index = (index + 1) % K1_RX_DESC_COUNT;
+}
+
+static void k1_emac_init_rings(struct k1_emac_priv *priv)
+{
+	struct k1_emac_desc *desc;
+	unsigned int i;
+
+	memset(priv->tx_desc, 0, K1_TX_DESC_ALLOC_SIZE);
+	memset(priv->rx_desc, 0, K1_RX_DESC_ALLOC_SIZE);
+	memset(priv->tx_buf, 0, K1_TX_DESC_COUNT * K1_DMA_BUF_SIZE);
+	memset(priv->rx_buf, 0, K1_RX_DESC_COUNT * K1_DMA_BUF_SIZE);
+	flush_dcache_range((ulong)priv->tx_buf,
+			   (ulong)priv->tx_buf +
+			   K1_TX_DESC_COUNT * K1_DMA_BUF_SIZE);
+	flush_dcache_range((ulong)priv->rx_buf,
+			   (ulong)priv->rx_buf + K1_RX_DESC_COUNT * K1_DMA_BUF_SIZE);
+
+	for (i = 0; i < K1_TX_DESC_COUNT; i++) {
+		desc = k1_desc_at(priv->tx_desc, i);
+		if (i == K1_TX_DESC_COUNT - 1)
+			desc->control = K1_TX_DESC_END_RING;
+		desc->buffer_addr1 = priv->tx_buf_dma[i];
+	}
+	flush_dcache_range((ulong)priv->tx_desc,
+			   (ulong)priv->tx_desc + K1_TX_DESC_ALLOC_SIZE);
+
+	for (i = 0; i < K1_RX_DESC_COUNT; i++)
+		k1_emac_prepare_rx(priv, i);
+	/* Complete all descriptor stores before handing the ring to DMA. */
+	mb();
+	flush_dcache_range((ulong)priv->rx_desc,
+			   (ulong)priv->rx_desc + K1_RX_DESC_ALLOC_SIZE);
+	/* Complete the clean before programming the DMA descriptor base. */
+	mb();
+
+	priv->tx_index = 0;
+	priv->rx_index = 0;
+	priv->rx_pending = false;
+}
+
+static int k1_emac_start(struct udevice *dev)
+{
+	struct k1_emac_priv *priv = dev_get_priv(dev);
+	u32 value;
+	int ret;
+
+	ret = phy_startup(priv->phy);
+	if (ret)
+		return ret;
+
+	if (!priv->phy->link) {
+		dev_err(dev, "no link\n");
+		phy_shutdown(priv->phy);
+		return -EAGAIN;
+	}
+
+	ret = k1_emac_hw_init(priv);
+	if (ret)
+		goto err_phy;
+
+	ret = k1_emac_write_hwaddr(dev);
+	if (ret)
+		goto err_phy;
+
+	k1_emac_init_rings(priv);
+	writel(priv->tx_desc_dma, priv->base + K1_DMA_TX_DESC_BASE);
+	writel(priv->rx_desc_dma, priv->base + K1_DMA_RX_DESC_BASE);
+
+	ret = k1_emac_adjust_link(dev);
+	if (ret)
+		goto err_stop;
+
+	value = readl(priv->base + K1_MAC_TX_CONTROL);
+	value &= ~K1_MAC_TX_IFG;
+	value |= K1_MAC_TX_ENABLE | K1_MAC_TX_AUTO_RETRY;
+	writel(value, priv->base + K1_MAC_TX_CONTROL);
+	writel(0, priv->base + K1_DMA_TX_AUTO_POLL);
+	writel(K1_MAC_RX_ENABLE | K1_MAC_RX_STORE_FORWARD,
+	       priv->base + K1_MAC_RX_CONTROL);
+	writel(K1_DMA_CONTROL_TX_START | K1_DMA_CONTROL_RX_START,
+	       priv->base + K1_DMA_CONTROL);
+	writel(1, priv->base + K1_DMA_RX_POLL_DEMAND);
+
+	printf("%s: %d Mbps %s-duplex link up\n", dev->name, priv->phy->speed,
+	       priv->phy->duplex == DUPLEX_FULL ? "full" : "half");
+	return 0;
+
+err_stop:
+	writel(0, priv->base + K1_DMA_CONTROL);
+	writel(0, priv->base + K1_MAC_RX_CONTROL);
+	writel(0, priv->base + K1_MAC_TX_CONTROL);
+err_phy:
+	phy_shutdown(priv->phy);
+	return ret;
+}
+
+static int k1_emac_send(struct udevice *dev, void *packet, int length)
+{
+	struct k1_emac_priv *priv = dev_get_priv(dev);
+	unsigned int index = priv->tx_index;
+	struct k1_emac_desc *desc = k1_desc_at(priv->tx_desc, index);
+	u8 *buffer = k1_tx_buf_at(priv, index);
+	ulong start;
+
+	if (length <= 0 || length > K1_DMA_BUF_SIZE)
+		return -EMSGSIZE;
+
+	k1_desc_invalidate(desc);
+	if (desc->status & K1_TX_DESC_OWN)
+		return -EBUSY;
+
+	memcpy(buffer, packet, length);
+	flush_dcache_range((ulong)buffer,
+			   ALIGN((ulong)buffer + length, ARCH_DMA_MINALIGN));
+
+	/* Clear stale state before handing the descriptor to DMA. */
+	writel(K1_DMA_STATUS_TX_DESC_UNAVAILABLE, priv->base + K1_DMA_STATUS);
+	/* Complete the W1C write before asking the DMA engine to resume. */
+	readl(priv->base + K1_DMA_STATUS);
+
+	desc->buffer_addr1 = priv->tx_buf_dma[index];
+	desc->buffer_addr2 = 0;
+	desc->control = FIELD_PREP(K1_TX_DESC_BUFFER_SIZE, length) |
+			K1_TX_DESC_FIRST | K1_TX_DESC_LAST;
+	if (index == K1_TX_DESC_COUNT - 1)
+		desc->control |= K1_TX_DESC_END_RING;
+	desc->status = K1_TX_DESC_OWN;
+	/* Complete descriptor stores before cleaning its cache line. */
+	mb();
+	k1_desc_flush(desc);
+	writel(1, priv->base + K1_DMA_TX_POLL_DEMAND);
+
+	start = get_timer(0);
+	do {
+		k1_desc_invalidate(desc);
+		/*
+		 * OWN is cleared before transmission finishes. Descriptor
+		 * unavailable is raised after DMA completes the packet and moves
+		 * to the next CPU-owned descriptor.
+		 */
+		if (!(desc->status & K1_TX_DESC_OWN) &&
+		    (readl(priv->base + K1_DMA_STATUS) &
+		     K1_DMA_STATUS_TX_DESC_UNAVAILABLE)) {
+			priv->tx_index = (index + 1) % K1_TX_DESC_COUNT;
+			return 0;
+		}
+		udelay(10);
+	} while (get_timer(start) <= K1_TX_TIMEOUT_MS);
+
+	dev_err(dev, "transmit timed out (DMA status %#x)\n",
+		readl(priv->base + K1_DMA_STATUS));
+	return -ETIMEDOUT;
+}
+
+static int k1_emac_recv(struct udevice *dev, int flags, uchar **packetp)
+{
+	struct k1_emac_priv *priv = dev_get_priv(dev);
+	struct k1_emac_desc *desc;
+	u32 status, length;
+	u8 *buffer;
+	unsigned int checked = 0;
+
+	if (priv->rx_pending)
+		return -EBUSY;
+
+	while (checked++ < K1_RX_DESC_COUNT) {
+		desc = k1_desc_at(priv->rx_desc, priv->rx_index);
+		k1_desc_invalidate(desc);
+		status = desc->status;
+		if (status & K1_RX_DESC_OWN)
+			return -EAGAIN;
+
+		length = FIELD_GET(K1_RX_DESC_FRAME_LEN, status);
+		if ((status & (K1_RX_DESC_FIRST | K1_RX_DESC_LAST)) ==
+		    (K1_RX_DESC_FIRST | K1_RX_DESC_LAST) &&
+		    !(status & K1_RX_DESC_ERRORS) && length > ETH_FCS_LEN &&
+		    length <= K1_DMA_BUF_SIZE) {
+			buffer = k1_rx_buf_at(priv, priv->rx_index);
+			k1_buffer_invalidate(buffer);
+			/* Complete invalidation before exposing the received frame. */
+			mb();
+			*packetp = buffer;
+			priv->rx_pending = true;
+			return length - ETH_FCS_LEN;
+		}
+
+		dev_dbg(dev, "discarding RX descriptor %#x, length %u\n",
+			status, length);
+		k1_emac_advance_rx(priv);
+	}
+
+	return -EAGAIN;
+}
+
+static int k1_emac_free_pkt(struct udevice *dev, uchar *packet, int length)
+{
+	struct k1_emac_priv *priv = dev_get_priv(dev);
+
+	if (!priv->rx_pending || packet != k1_rx_buf_at(priv, priv->rx_index))
+		return -EINVAL;
+
+	k1_emac_advance_rx(priv);
+	priv->rx_pending = false;
+
+	return 0;
+}
+
+static void k1_emac_stop(struct udevice *dev)
+{
+	struct k1_emac_priv *priv = dev_get_priv(dev);
+
+	writel(0, priv->base + K1_MAC_INTERRUPT_ENABLE);
+	writel(0, priv->base + K1_DMA_INTERRUPT_ENABLE);
+	writel(0, priv->base + K1_DMA_CONTROL);
+	writel(0, priv->base + K1_MAC_RX_CONTROL);
+	writel(0, priv->base + K1_MAC_TX_CONTROL);
+	priv->rx_pending = false;
+	phy_shutdown(priv->phy);
+}
+
+static int k1_emac_mdio_wait(struct k1_emac_priv *priv)
+{
+	return wait_for_bit_le32(priv->base + K1_MAC_MDIO_CONTROL,
+				 K1_MAC_MDIO_START, false, K1_MDIO_TIMEOUT_MS,
+				 false);
+}
+
+static int k1_emac_mdio_read(struct udevice *mdio_dev, int addr, int devad,
+			     int reg)
+{
+	struct k1_emac_priv *priv = dev_get_priv(mdio_dev->parent);
+	u32 command;
+	int ret;
+
+	if (devad != MDIO_DEVAD_NONE)
+		return -EOPNOTSUPP;
+
+	command = FIELD_PREP(K1_MAC_MDIO_PHY_ADDR, addr) |
+		  FIELD_PREP(K1_MAC_MDIO_REG_ADDR, reg) |
+		  K1_MAC_MDIO_READ | K1_MAC_MDIO_START;
+	writel(0, priv->base + K1_MAC_MDIO_DATA);
+	writel(command, priv->base + K1_MAC_MDIO_CONTROL);
+
+	ret = k1_emac_mdio_wait(priv);
+	if (ret)
+		return ret;
+
+	return readl(priv->base + K1_MAC_MDIO_DATA) & 0xffff;
+}
+
+static int k1_emac_mdio_write(struct udevice *mdio_dev, int addr, int devad,
+			      int reg, u16 value)
+{
+	struct k1_emac_priv *priv = dev_get_priv(mdio_dev->parent);
+	u32 command;
+
+	if (devad != MDIO_DEVAD_NONE)
+		return -EOPNOTSUPP;
+
+	writel(value, priv->base + K1_MAC_MDIO_DATA);
+	command = FIELD_PREP(K1_MAC_MDIO_PHY_ADDR, addr) |
+		  FIELD_PREP(K1_MAC_MDIO_REG_ADDR, reg) |
+		  K1_MAC_MDIO_START;
+	writel(command, priv->base + K1_MAC_MDIO_CONTROL);
+
+	return k1_emac_mdio_wait(priv);
+}
+
+static const struct mdio_ops k1_emac_mdio_ops = {
+	.read = k1_emac_mdio_read,
+	.write = k1_emac_mdio_write,
+};
+
+U_BOOT_DRIVER(k1_emac_mdio) = {
+	.name = "spacemit_k1_emac_mdio",
+	.id = UCLASS_MDIO,
+	.ops = &k1_emac_mdio_ops,
+};
+
+static int k1_emac_alloc_dma(struct udevice *dev)
+{
+	struct k1_emac_priv *priv = dev_get_priv(dev);
+	unsigned int i;
+	int ret;
+
+	priv->tx_desc = memalign(ARCH_DMA_MINALIGN, K1_TX_DESC_ALLOC_SIZE);
+	priv->rx_desc = memalign(ARCH_DMA_MINALIGN, K1_RX_DESC_ALLOC_SIZE);
+	priv->tx_buf = memalign(ARCH_DMA_MINALIGN,
+				K1_TX_DESC_COUNT * K1_DMA_BUF_SIZE);
+	priv->rx_buf = memalign(ARCH_DMA_MINALIGN,
+				K1_RX_DESC_COUNT * K1_DMA_BUF_SIZE);
+	if (!priv->tx_desc || !priv->rx_desc || !priv->tx_buf || !priv->rx_buf)
+		return -ENOMEM;
+
+	ret = k1_emac_dma32(dev, priv->tx_desc, &priv->tx_desc_dma);
+	if (ret)
+		return ret;
+	ret = k1_emac_dma32(dev, priv->rx_desc, &priv->rx_desc_dma);
+	if (ret)
+		return ret;
+	for (i = 0; i < K1_TX_DESC_COUNT; i++) {
+		ret = k1_emac_dma32(dev, k1_tx_buf_at(priv, i),
+				    &priv->tx_buf_dma[i]);
+		if (ret)
+			return ret;
+	}
+	for (i = 0; i < K1_RX_DESC_COUNT; i++) {
+		ret = k1_emac_dma32(dev, k1_rx_buf_at(priv, i),
+				    &priv->rx_buf_dma[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void k1_emac_free_dma(struct k1_emac_priv *priv)
+{
+	free(priv->rx_buf);
+	free(priv->tx_buf);
+	free(priv->rx_desc);
+	free(priv->tx_desc);
+	priv->rx_buf = NULL;
+	priv->tx_buf = NULL;
+	priv->rx_desc = NULL;
+	priv->tx_desc = NULL;
+}
+
+static int k1_emac_probe(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct k1_emac_priv *priv = dev_get_priv(dev);
+	struct ofnode_phandle_args args;
+	int ret;
+
+	BUILD_BUG_ON(sizeof(struct k1_emac_desc) != K1_DESC_SIZE);
+	BUILD_BUG_ON(ARCH_DMA_MINALIGN % K1_DESC_SIZE);
+	BUILD_BUG_ON(K1_TX_DESC_COUNT % K1_DESCS_PER_CACHELINE);
+	BUILD_BUG_ON(K1_RX_DESC_COUNT % K1_DESCS_PER_CACHELINE);
+	BUILD_BUG_ON(FIELD_MAX(K1_RX_DESC_BUFFER_SIZE) < K1_DMA_BUF_SIZE);
+	BUILD_BUG_ON(FIELD_MAX(K1_TX_DESC_BUFFER_SIZE) < K1_DMA_BUF_SIZE);
+
+	priv->base = (void __iomem *)pdata->iobase;
+	priv->interface = pdata->phy_interface;
+	priv->max_speed = pdata->max_speed;
+
+	ret = dev_read_phandle_with_args(dev, "spacemit,apmu", NULL, 1, 0,
+					 &args);
+	if (ret) {
+		dev_err(dev, "failed to get APMU syscon: %d\n", ret);
+		return ret;
+	}
+	ret = regmap_init_mem(args.node, &priv->apmu);
+	if (ret) {
+		dev_err(dev, "failed to map APMU registers: %d\n", ret);
+		return ret;
+	}
+	priv->apmu_offset = args.args[0];
+
+	ret = clk_get_by_index(dev, 0, &priv->clk);
+	if (ret) {
+		dev_err(dev, "failed to get clock: %d\n", ret);
+		goto err_apmu;
+	}
+	ret = clk_enable(&priv->clk);
+	if (ret)
+		goto err_clk_release;
+	priv->clk_enabled = true;
+
+	ret = reset_get_by_index(dev, 0, &priv->reset);
+	if (ret)
+		goto err_clk;
+	ret = reset_deassert(&priv->reset);
+	if (ret)
+		goto err_reset_release;
+	priv->reset_deasserted = true;
+
+	ret = k1_emac_config_interface(priv);
+	if (ret)
+		goto err_reset;
+
+	ret = k1_emac_alloc_dma(dev);
+	if (ret)
+		goto err_dma;
+
+	priv->phy = dm_eth_phy_connect(dev);
+	if (!priv->phy) {
+		ret = -ENODEV;
+		goto err_dma;
+	}
+	priv->phy->supported &= PHY_GBIT_FEATURES;
+	if (priv->interface == PHY_INTERFACE_MODE_RMII)
+		priv->phy->supported &= ~PHY_1000BT_FEATURES;
+	if (priv->max_speed) {
+		ret = phy_set_supported(priv->phy, priv->max_speed);
+		if (ret)
+			goto err_dma;
+	}
+	priv->phy->advertising = priv->phy->supported;
+	ret = phy_config(priv->phy);
+	if (ret)
+		goto err_dma;
+
+	return 0;
+
+err_dma:
+	k1_emac_free_dma(priv);
+err_reset:
+	if (priv->reset_deasserted) {
+		reset_assert(&priv->reset);
+		priv->reset_deasserted = false;
+	}
+err_reset_release:
+	reset_free(&priv->reset);
+err_clk:
+	if (priv->clk_enabled) {
+		clk_disable(&priv->clk);
+		priv->clk_enabled = false;
+	}
+err_clk_release:
+	clk_release_all(&priv->clk, 1);
+err_apmu:
+	regmap_uninit(priv->apmu);
+	dev_err(dev, "probe failed: %d\n", ret);
+	return ret;
+}
+
+static int k1_emac_remove(struct udevice *dev)
+{
+	struct k1_emac_priv *priv = dev_get_priv(dev);
+
+	writel(0, priv->base + K1_DMA_CONTROL);
+	writel(0, priv->base + K1_MAC_RX_CONTROL);
+	writel(0, priv->base + K1_MAC_TX_CONTROL);
+	k1_emac_free_dma(priv);
+	if (priv->reset_deasserted)
+		reset_assert(&priv->reset);
+	reset_free(&priv->reset);
+	if (priv->clk_enabled)
+		clk_disable(&priv->clk);
+	clk_release_all(&priv->clk, 1);
+	regmap_uninit(priv->apmu);
+
+	return 0;
+}
+
+static int k1_emac_of_to_plat(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct k1_emac_priv *priv = dev_get_priv(dev);
+	ofnode node;
+	bool mdio_bound = false;
+	int ret;
+
+	pdata->iobase = dev_read_addr(dev);
+	if (pdata->iobase == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	pdata->phy_interface = dev_read_phy_mode(dev);
+	switch (pdata->phy_interface) {
+	case PHY_INTERFACE_MODE_RMII:
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		break;
+	default:
+		return -EINVAL;
+	}
+	pdata->max_speed = dev_read_u32_default(dev, "max-speed", 0);
+
+	ret = k1_emac_read_delay(dev, "tx-internal-delay-ps",
+				 &priv->tx_delay_code);
+	if (ret)
+		return ret;
+	ret = k1_emac_read_delay(dev, "rx-internal-delay-ps",
+				 &priv->rx_delay_code);
+	if (ret)
+		return ret;
+
+	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
+		if (!ofnode_name_eq(node, "mdio") &&
+		    !ofnode_name_eq(node, "mdio-bus"))
+			continue;
+
+		snprintf(priv->mdio_name, sizeof(priv->mdio_name), "%s.mdio",
+			 dev->name);
+		ret = device_bind_driver_to_node(dev, "spacemit_k1_emac_mdio",
+						 priv->mdio_name, node, NULL);
+		if (ret)
+			return ret;
+		mdio_bound = true;
+		break;
+	}
+
+	if (!mdio_bound) {
+		dev_err(dev, "MDIO child node is missing\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static const struct eth_ops k1_emac_ops = {
+	.start = k1_emac_start,
+	.send = k1_emac_send,
+	.recv = k1_emac_recv,
+	.free_pkt = k1_emac_free_pkt,
+	.stop = k1_emac_stop,
+	.write_hwaddr = k1_emac_write_hwaddr,
+};
+
+static const struct udevice_id k1_emac_ids[] = {
+	{ .compatible = "spacemit,k1-emac" },
+	{ }
+};
+
+U_BOOT_DRIVER(k1_emac) = {
+	.name = "spacemit_k1_emac",
+	.id = UCLASS_ETH,
+	.of_match = k1_emac_ids,
+	.of_to_plat = k1_emac_of_to_plat,
+	.probe = k1_emac_probe,
+	.remove = k1_emac_remove,
+	.ops = &k1_emac_ops,
+	.priv_auto = sizeof(struct k1_emac_priv),
+	.plat_auto = sizeof(struct eth_pdata),
+};

-- 
2.56.0

