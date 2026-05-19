Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1DACD4F57
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 11:56:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 177F0846D0;
	Tue, 19 May 2026 13:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=superkali.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=superkali.me header.i=@superkali.me header.b="gg+FIp/v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B1E8846CA; Tue, 19 May 2026 13:55:55 +0200 (CEST)
Received: from fr5000-r.dnsiaas.com (fr5000-r.dnsiaas.com [92.42.104.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54838846B0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 13:55:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=superkali.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hello@superkali.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=superkali.me; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MjXQdTPHl5CxSeqtSZMeuRCz25uPgMm2L25hT45vgOU=; b=gg+FIp/vHSiFSGF65hw6Q6GCxA
 ajx4YbFSriUgIBx0f8cu75AC9eRJG3BtWoL8V9nwIJ94JyAhi4PUCwSkBEkr+7O2vrRs3OmbA+7R3
 B3jGdFR8DN38wRShFTJI9w7hqkQ0ZxpG1YKQrUupkEdNyRlVE/2Obj6DR507Y9usukG5MXD0lIatn
 3hdmttekdjjI6yW5PMeNfpGiaQTVFvLvFWBrRRxhDQj/VABEvDTIx0SOvDqmjK0AfKNJyBdFHS387
 fbViQuVOTApHlQ2MgFdC0wd7mFihTPfiIgzOCSewGX0Lj/2QkJmSTADXVQ0hAPl98L7Pa/b/OSHXr
 Y45svq3A==;
Received: from [81.57.40.39] (port=48348 helo=vscode.iliadbox.lan)
 by fr5000-r.dnsiaas.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.2) (envelope-from <hello@superkali.me>)
 id 1wPJ3B-0000000EKHd-1CAe; Tue, 19 May 2026 13:55:51 +0200
From: Daniele Briguglio <hello@superkali.me>
Date: Tue, 19 May 2026 13:55:50 +0200
Subject: [PATCH v2 2/2] configs: rock-5-itx-rk3588: enable CLK_GATED_FIXED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-rock-5-itx-pcie-refclk-dtsi-v2-2-738b67857cac@superkali.me>
References: <20260519-rock-5-itx-pcie-refclk-dtsi-v2-0-738b67857cac@superkali.me>
In-Reply-To: <20260519-rock-5-itx-pcie-refclk-dtsi-v2-0-738b67857cac@superkali.me>
To: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 Peter Korsgaard <peter@korsgaard.com>, Heiko Stuebner <heiko@sntech.de>, 
 Daniele Briguglio <hello@superkali.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779191749; l=1117;
 i=hello@superkali.me; h=from:subject:message-id;
 bh=VBhHWzSQzQ8fz+uYbicHGY/dDvHGoTgSs3/rPNAYOnM=;
 b=zrmislP1CR4uImSs6cI6Vki93IPvJXe/owPb7615sNEj4hKVnZWt1v/N3d3LAVa+EmtKZiMk+
 sB0G6v9eWthAUkt18gsSjLOjFWn7hA4Nnz6XOxBqxUQJEn1sgmp9J/J
X-Developer-Key: i=hello@superkali.me; a=ed25519;
 pk=5tynRWQdL93CDcapJ73FkcCRY2PeBOJOIAoIhRig53U=
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - fr5000-r.dnsiaas.com
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - superkali.me
X-Get-Message-Sender-Via: fr5000-r.dnsiaas.com: authenticated_id:
 hello@superkali.me
X-Authenticated-Sender: fr5000-r.dnsiaas.com: hello@superkali.me
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

The rk3588-rock-5-itx DT models the M.2 M-key NVMe and SATA PCIe
reference clocks (pcie30_port0_refclk, pcie30_port1_refclk) with
the "gated-fixed-clock" compatible, and references them from the
pcie3x4 and pcie3x2 clocks lists.  Without a driver for that
compatible, clk_get_by_index() returns -ENODEV and
pcie_dw_rockchip aborts probing both controllers, breaking NVMe
and SATA boot on this board since v2026.04:

  pcie_dw_rockchip pcie@fe150000: Can't get clock: -19
  pcie_dw_rockchip pcie@fe160000: Can't get clock: -19

Signed-off-by: Daniele Briguglio <hello@superkali.me>
---
 configs/rock-5-itx-rk3588_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/rock-5-itx-rk3588_defconfig b/configs/rock-5-itx-rk3588_defconfig
index cb014de41..def626878 100644
--- a/configs/rock-5-itx-rk3588_defconfig
+++ b/configs/rock-5-itx-rk3588_defconfig
@@ -52,6 +52,7 @@ CONFIG_AHCI=y
 CONFIG_AHCI_PCI=y
 CONFIG_DWC_AHCI=y
 CONFIG_SPL_CLK=y
+CONFIG_CLK_GATED_FIXED=y
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y

-- 
2.47.3

