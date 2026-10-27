Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4652606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jFDREAxs;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=ipmWqei5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D99974062B;
	Tue, 27 Oct 2026 09:40:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yHdMhJlcGUgq; Tue, 27 Oct 2026 09:40:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B580C406CD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793094023;
	b=DJ46ZsWgKSu89iYvQE56xsMet2pzL62h85WWbx8E9RDArv4/9i5nlxJAqk5jeHYtCvDk
	 NbG6ZEJPkgre1zVwu0PjJniuXW2rXlvSuyaJyIWfmhrZP2cWLjHIgbSsJ9Cv1JTQBDp+Z
	 2EKG60+b8UjZn22nsqDNQi+x5jgPtAm6zdregIetyzy7YagMuPQqYs7ZLw9jQvm/OGMoN
	 9TgcBT10Aetndf1IR7BtGcUEOFkpPSydP5uJ/B0WDqj46GbWobu+5gON0eYgQLbRASOJW
	 4nHLvkPdAXKHwpHgZcw9y21GJpToAvowqyQTGVjU9K4aPkOZd/za03YQbI51bJmJ4/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793094023;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=m1+XB1/cuEk46/2EzQ6nWIhei2cYNk+U8pUAwClWsvg=;
	b=MUV5h3nljDi4FPTzh9cKOa1fg8nom1b09DTIevKQNuiXE3d+oczEgkYh3zIpxDusgr0Y
	 p0WHjhfylbw8IJGC0doDdmYTma03fgce1MIj7ZgxVEYnqfCoAM267Hgy6iXCmiTzVxubd
	 T2OV7bPC2NeETuOepw4/zvqx2Kcm1B4qWz0UWvpmDVGLS44fJgLYmFcDLw8OFSbfAqK6r
	 xEePgtt1dPmB1vLO16/Ml4qApZFaksCCwDscfEaMP0x70yt/5KKOTzm2CmZsGBqEIUXns
	 jJ4gk7LDhqfFZuxsyhaojsXD/qzZWCsm8VH6yvNlY2KJ5dCh4ZaqpPR3XY7/gz7Y7tg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793094023;
	bh=m1+XB1/cuEk46/2EzQ6nWIhei2cYNk+U8pUAwClWsvg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jFDREAxstcUea70L5zLsl9faEGdGSDOp2grYdagsv5PcEqIXJnI/viwUqi1KXvhB2
	 NLwbkn0z6bRHyl1p/YuySwjF268Ph9NfLrgHdnTnc1w3IJ+HakFKhJbyB0sOta5+mX
	 RYHHE3RaXtq1xY+bWVK6CgdDj+fZCcYP+DBO4HSC9OhpnGjF07Nj9sDeBcvpD2++ud
	 pu+DwPcmQ3poQWvdWVdVlIn5MdJcahzBD9JEvUtZYEau5O5DMlZFmxenJ2j9Ihgzda
	 dFh9dHh2c2tfnpOWNWY60nFo515rnhKBr2njapSK+ce5DucI2iPkBBLZlLoDBIEire
	 Wws3ReFDTzakw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B580C406CD;
	Tue, 27 Oct 2026 09:40:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2514B380
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 22D4060755
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 18dCURsS_4XV for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 09:40:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C338E60687
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793094018;
 b=HAgu9LyhxLiFkKI/FOEm5dq+yGyzD32uYfCLq5NcPMV2KQuWrL4S0thtQBXEatInJ2ho
 /+qccg7Dp39UycOvEaaiQmmw0dtYBFo3R4Dkc5a3PRpLCQLOfCG+8RXR0G2fJL+Pkdrn2
 B/MDaaej4/d7hTQPi2VaQJ3lDcXGp4RuiDOIb2VcUEeiSvCliMcjUMUNp1HilgNwxoe+T
 rSoTWMo5RecbeJIn27qPMYlskJ4ffZYKHHAN55ZcEXdADiczuaSDbePohFPbSz1vBZJww
 HY4w5ZdpQpWSQrY1f0iSP9LVvn+fcnxqA0ryvp9gatUtJ6JViyWcCBRumAleQKyTHnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793094018;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Virus-Scanned;
 bh=m1+XB1/cuEk46/2EzQ6nWIhei2cYNk+U8pUAwClWsvg=;
 b=EBIMO6RfWqiTCdr+MLhpcQ0Lx2PuXbyKUPqphRGGkD/tOOQXogzp92iPqAUgnbGEvfCQ
 awdMEak+8szZMFc/lSjeTLSXvNn2dG/Izz85/RKCXWFKnQYnFv3NScHiUslv/Ne8OIStj
 dgm3lCXxP10RXXPisHyl2MlAVqw+ioJxUgqBNCS3hb5M4/RxNvsU5wVUVLNviMGJxsRUp
 77LHzQl1Sv3ROlaFpbKPSZcsquqUFdHTF5H340VtISqjwxGpTQnC7GF3L3PYesySD2JDL
 7+ltMcUXSma6RR7MSRxOpOf7fAh1Y8sAbAW+qixUVWmmyWCbI52wcZV0SvYwhVf2pvA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=ipmWqei5; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=ipmWqei5
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C338E60687
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=m1+XB1/cuEk46/2EzQ6nWIhei2cYNk+U8pUAwClWsvg=; b=ipmWqei5GHYCqRcBOGso315ijh
 dazIbXP9bwzwOFQJEhCh/KeACEX3rYyNYzzXL27A8HCJfXuwOkdrPdmQR4qt1uH8vgbuMnK3lS4i4
 0L4C7k/gUq91PMXbztjsRlqGBWWxBjz5CXus8XQpbTn7KQUa6etN5VCCa6snBTpShgCYUg3UNOnHB
 IRuBWGPR+dLOX8d7/PS0HyUDCKWPrpXpvCBPTtJcEFOum+KgYVu5Qw0Rzt8kIeTQXquFFCI8EmFnn
 PN4VPu9cQhaTvz6u+a26kPG/VH+Hfyq4x51O/nKQUdKaT1n3dU6ZU3qF5mgeoWMILTDBXoICLe8n7
 0URGGfTg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfC-0007Tp-1z; Tue, 27 Oct 2026 10:40:14 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfC-00022y-28; Tue, 27 Oct 2026 10:40:14 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH 00/16] i.MX7D USB improvements, HSIC support
Date: Tue, 27 Oct 2026 10:38:57 +0100
Message-ID: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28166/Tue Oct 27 07:24:12 2026)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series makes significant improvements to i.MX7D USB support, including:

- Power domain support
- CONFIG_PHY support (NOP_PHY, used to hook up the power domain)
- power-active-high DT property
- A HSIC-specific workaround for an i.MX7D hardware bug

PHY and power domain support allows the HSIC interface as found on the TQMa7 to
work. Without this series, running a command like `usb start` would attempt to
put the USB controller into HSIC mode without enabling the prerequisite power
domains first, resulting in a hang of the system.

For tqma7_mba7_mmc_defconfig, u-boot-with-spl.imx grows from 729K to 736K.
Configurations that don't enable the newly supported regulator and power domain
drivers should be largely unchanged.


Nora Schiffer (16):
  phy: introduce generic_phy_get_by_phandle_args()
  regulator: anatop: fix probe without vin-supply
  regulator: anatop: add support for anatop-enable-bit
  power: domain: rename imx8m-power-domain to imx-gpcv2-power-domain
  power: domain: imx-gpcv2: do not unconditionally select CONFIG_CLK
  power: domain: imx-gpcv2: set CPU domain mapping on probe
  power: domain: imx-gpcv2: add support for power-supply regulator
  power: domain: imx-gpcv2: add support for i.MX7D
  usb: ehci-mx6: set up i.MX7D misc registers regardless of CONFIG_PHY
    setting
  usb: ehci-mx6: unconditionally run usb_oc_config()
  usb: ehci-mx6: add support for power-active-high property
  usb: ehci-mx6: handle fsl,usbphy with CONFIG_PHY
  usb: ehci: allow overriding port enable operation
  usb: ehci-mx6: force HSIC ports to HS mode during port enable
  configs: tqma6ul: drop obsolete CONFIG_MXC_USB_OTG_HACTIVE symbol
  configs: tqma7: enable PHY and power domain support for USB HSIC

 configs/imx8m_data_modul.config               |   2 +-
 configs/imx8mm-cl-iot-gate-optee_defconfig    |   2 +-
 configs/imx8mm-cl-iot-gate_defconfig          |   2 +-
 configs/imx8mm-mx8menlo_defconfig             |   2 +-
 configs/imx8mm-phygate-tauri-l_defconfig      |   2 +-
 configs/imx8mm_evk_defconfig                  |   2 +-
 configs/imx8mm_phg_defconfig                  |   2 +-
 configs/imx8mm_venice_defconfig               |   2 +-
 configs/imx8mn_venice_defconfig               |   2 +-
 configs/imx8mp-libra-fpsc_defconfig           |   2 +-
 configs/imx8mp_dhsom.config                   |   2 +-
 configs/imx8mp_evk_defconfig                  |   2 +-
 configs/imx8mp_venice_defconfig               |   2 +-
 configs/imx8mq_evk_defconfig                  |   2 +-
 configs/imx8mq_phanbell_defconfig             |   2 +-
 configs/imx8mq_reform2_defconfig              |   2 +-
 configs/kontron-osm-s-mx8mp.config            |   2 +-
 configs/kontron-sl-mx8mm_defconfig            |   2 +-
 configs/kontron_pitx_imx8m_defconfig          |   2 +-
 configs/librem5-devkit_defconfig              |   2 +-
 configs/librem5_defconfig                     |   2 +-
 configs/phycore-imx8mm_defconfig              |   2 +-
 configs/phycore-imx8mp_defconfig              |   2 +-
 configs/pico-imx8mq_defconfig                 |   2 +-
 configs/toradex-smarc-imx8mp_defconfig        |   2 +-
 configs/tqma6ul_common.config                 |   1 -
 configs/tqma7_common.config                   |   6 +-
 configs/verdin-imx8mm_defconfig               |   2 +-
 configs/verdin-imx8mp_defconfig               |   2 +-
 drivers/phy/phy-uclass.c                      |  35 ++--
 drivers/power/domain/Kconfig                  |  14 +-
 drivers/power/domain/Makefile                 |   2 +-
 ...ower-domain.c => imx-gpcv2-power-domain.c} | 151 ++++++++++++++---
 drivers/power/regulator/anatop_regulator.c    |  42 ++++-
 drivers/usb/host/ehci-hcd.c                   |  15 +-
 drivers/usb/host/ehci-mx6.c                   | 159 ++++++++++++------
 drivers/usb/host/ehci.h                       |   2 +
 include/generic-phy.h                         |  29 ++++
 include/usb/ehci-ci.h                         |   1 +
 39 files changed, 377 insertions(+), 134 deletions(-)
 rename drivers/power/domain/{imx8m-power-domain.c => imx-gpcv2-power-domain.c} (76%)

-- 
2.55.0
