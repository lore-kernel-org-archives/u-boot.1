Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D528C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 06:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E07888644;
	Mon,  8 Jul 2024 08:07:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="oYihJ4fQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2DD88858B; Mon,  8 Jul 2024 08:07:52 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E999C884C6
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 08:07:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1720418870; x=1723010870;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2H4tyr0DlbxaHG28lbq9x790tBkBUXVWbDlHAWahRLA=;
 b=oYihJ4fQBaFV++9tdoxFAJ/lWKgevv8OS+cQAyHLduVMTT5ZMXUaAblzabQiKf4i
 ktowqttFkQN3/oxdgiJsxjgk4onKhRFSKIRTO2/Mnl45kTCOlyjPAQCRb+0oyz9U
 U66YaI1t12Qn3cAunw5I7K/IDrv8J0wuXAV9DovFfBE=;
X-AuditID: ac14000a-03e52700000021bc-3f-668b8236ac35
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 1A.11.08636.6328B866;
 Mon,  8 Jul 2024 08:07:50 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 8 Jul 2024
 08:07:46 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <joe.hershberger@ni.com>,
 <w.egorov@phytec.de>
CC: <d-gole@ti.com>, <nm@ti.com>, <mkorpershoek@baylibre.com>,
 <upstream@lists.phytec.de>, <t.remmet@phytec.de>, <y.moog@phytec.de>,
 <m-chawdhry@ti.com>, <kamlesh@ti.com>, <jm@ti.com>, <B.Hahn@phytec.de>,
 Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 0/6] Extend SOM detection
Date: Sun, 7 Jul 2024 23:07:28 -0700
Message-ID: <20240708060734.4029040-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsWyRpKBR9esqTvNYMojIYuWtR4Wnz5kWnza
 +ZjV4mj/GmaLSw9SLV4cm8tu8ebHWSaLqZM2s1u83dvJbtH9Tt2By+P9jVZ2j1cHVrF7nL2z
 g9Gjv7uF1eP6me1MHsdvbGcKYIvisklJzcksSy3St0vgyjh+4QNTwS+OitknjjM3MC5j72Lk
 5JAQMJH42/SZrYuRi0NIYAmTRGvzX1aQhJDAPUaJ4y15IDabgJbEnS1zmUFsEYEkiWUXO1lB
 GpgFvjNKvPj4C8jh4BAW0JQ4970MxGQRUJG41WQEUs4rYCUx5fYxJohd8hIzL31nh4gLSpyc
 +YQFxGYGijdvnc0MYUtIHHzxghniBAWJ2dsmM8L0Tjv3mhnCDpU4smk10wRGgVlIRs1CMmoW
 klELGJlXMQrlZiZnpxZlZusVZFSWpCbrpaRuYgSFvwgD1w7GvjkehxiZOBgPMUpwMCuJ8J5+
 3J4mxJuSWFmVWpQfX1Sak1p8iFGag0VJnHd1R3CqkEB6YklqdmpqQWoRTJaJg1OqgdGh4e3H
 wBUZSv8u8xq9mh4s9uTLSsf8b1P2MU58WC5Ut3u2yGTeHXUZuyUvPn3I2CuvMPFhxSUOkTuL
 hD78sPx3JSTU5E1T8d2dR+uffput7GYcY8KxuaCa6WJy2n9j/ZL3W10dFG0lDkg1Tr+e//fI
 0nMLpy6e4i8r9Iqjeu2fpze4sr/PdMpSYinOSDTUYi4qTgQA5pFqzW0CAAA=
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

This patchset extends PHYTEC's SOM detection for the
K3 platforms.

It adds generic support to apply overlays via the
extension framework inside the overlays.env file. Additionally,
the K3 mmc boot environment applies these overlays now.

It also adds the 'extension_board_scan' hook to the K3 board
code and adds all missing configs in the phyCORE-AM62x and
-AM64x A53 defconfigs.

Daniel Schultz (6):
  include: env: phytec: overlays: Add extension command
  include: env: phytec: k3_mmc: Apply extension overlays
  board: phytec: common: k3: Add SOM detection overlays
  board: phytec: common: Kconfig: Enable SUPPORT_EXTENSION_SCAN
  configs: phytec_am62x_a53_defconfig: Set CONFIG_CMD_EXTENSION
  configs: phycore_am64x_a53_defconfig: Enable SOM detection

 board/phytec/common/Kconfig         |  2 ++
 board/phytec/common/k3/board.c      | 45 +++++++++++++++++++++++++++++
 configs/phycore_am62x_a53_defconfig |  1 +
 configs/phycore_am64x_a53_defconfig |  2 ++
 include/env/phytec/k3_mmc.env       |  1 +
 include/env/phytec/overlays.env     | 20 +++++++++++++
 6 files changed, 71 insertions(+)

-- 
2.25.1

