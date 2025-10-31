Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B025ECCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 15:24:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44BE58398C;
	Fri, 31 Oct 2025 16:24:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="EmPK6+WM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 740F783980; Fri, 31 Oct 2025 16:24:12 +0100 (CET)
Received: from outbound.pv.icloud.com
 (p-west1-cluster2-host1-snip4-10.eps.apple.com [57.103.64.181])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6133D83677
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-2 (Postfix) with ESMTPS id
 0A2EC18001D1; Fri, 31 Oct 2025 15:24:05 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=4qu7SH66bQeQKQrBMXeAytuDNzf20sF7rfK0HFpX2Ic=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=EmPK6+WMKmD3jdlGdYKCNA05OqHHlQwuSLXcbAzTxVdXu8vSieuxIbdjcno4hlSJ5ELMyv6VlGUzPuhUCxbAerdmpp6lDQrclFsKbuUc4rHUhJjuUEPTqJPUbAYLQVAQmiP/R0LtCJE/G4H4KTc4cfWIRIFYkgQOSZgQLOICdgdVulEW3of9zmHJ6T3zCZN+nXmPH1RgkYivuXEnQ1PD1yWbhuEVmE+WtmOCXNchBaSVpy5xRuNwogLrtDvV5dal52Dd6d3kLW/d0aXSSh/Z+VOZ9PjeMJ97UAvut4XAt/W6dgJdiWTkpjXJW3lGUXo8AKRWnZgc5uXC5b8/FkcmrA==
mail-alias-created-date: 1549370554000
Received: from debian.. (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-2 (Postfix) with ESMTPSA id
 E46B118003CC; Fri, 31 Oct 2025 15:24:02 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Yao Zi <ziyao@disroot.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Beiyan Yun <root@infi.wang>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v4 0/5] net: phy: aquantia: Switch to generic firmware loader
Date: Fri, 31 Oct 2025 23:21:02 +0800
Message-ID: <20251031152348.60571-1-root@infi.wang>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: v3a9aQK2gAXknKq24YI6rWCQaOkThOJv
X-Proofpoint-ORIG-GUID: v3a9aQK2gAXknKq24YI6rWCQaOkThOJv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzOCBTYWx0ZWRfX5TW3YFWO+94Y
 P08vx0P95Yx+hJsRSLFUxdCxOCrADt5YsaCPPPcT0JAghSSDnbpBd4NZGa55IkuBGMiDSpE12WL
 g1y4lUs4LU5ybqqXa6Rk40zgHXFedDMyoW4gU8AQBpvVWAtSGteEUczh+hrAbwOps86R0NY7svA
 43PWCAvaov5j/MydoP14HX5Dgx1L2BSmDbpxlFnjJ7gMKxwExE59VMBUnzkS37WemmRbcNfEm2Z
 Hl9hHkJSdN5dieidv5DmiNBN4H/6HtHvfCZFwO3vq7QsD0WjqGnLJMRbUdmpMzfbKhoVshuQk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=846 malwarescore=0
 clxscore=1030 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510310138
X-JNJ: AAAAAAAB04Cq/wEvlnh0xO27qQalzEJlXE3D/d8JGYoJumTgFfKsfTpW47J/wSxwUtlFIOoipYd2j571JKQIzXLDYyXwv6L1j/zZw7l7SSgr03gOm1/cd4Xowym1QmyBD+zhHdhPWjkXYnJyubTgYcZzKHeD4IWzq+sYMARbgSFykj9JSgSMcxy/SqqeanT/vldSf129bI4IZ/0z0yFRwwPEe79D+YvQvibq4NuubkLaZCjuBxsL4AhWWpk1EGDkk1yn44STFQPJAZFcw3KK2+aESom5EKr7A6bnjp0QenPTCIohEAIOWlwT5OPbiXi8G18d3HjQtXioi7ZoraM+AD9HxgLmSKIvZQ3GkSOci/eCHy/S9kCOxXpdGlf/n38qZwNaIzf4DBrDA68E4syWRVc/UO/nbZaG+HSI/HJB4ou/xXhbKkuOnMoEMwZ7ldWEdHrRzV3ghCHNiAUITe3MF6EfsQG3ZzGAUt5mtH8AhIL20txTmyUa7x7wf7C63HOoQ+QX5oq1E4VloNUUUoi9hnQmscJJ+YWfYD7/rNNA+6JuI6VEeBwoDHblxjzmABWGZFpmQVw6wobFcYaiQnZPUVRtvCIRZjKlHFikRJ3yCtvWwfRIOyafFR03Ls4eD6iV1p+YI0y5TYWipA0/LipU9l9Kh8x9PZBjS3moQk6O6hdntIK2SgibdPvbTRQQzzmrKMZzWJ0NgYDXSso4St64WSwibvEA9cty8v3tabbyjR1dgXz1v1D2haskyrTou1fimzScEOyep1gGLgGiHp0Z8jBaMdYy9FLN
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

Hi,

This patch series refactors the Aquantia PHY firmware loader to use
the generic fsloader framework.

The existing loader is limited to loading firmware from an MMC device,
which restricts its use on many devices (e.g., routers) that may use
other storage like USB or have a UBIFS root filesystem. Migrating to the
generic firmware loader allows firmware to be sourced from any backend
supported by the fwloader and fsloader framework.

The series is structured as follows:
- The first patch is formatting.
- The second patch aligns binding document with upstream and prepares
  for the migration.
- The third patch aligns binding for MDI with upstream.
- The fourth patch prepares current loading code for fsloader.
- The final and main patch replaces the custom loader with generic one.

Kept smb-addr intact as NXP is the only consumer.

This change has been tested on a Buffalo WXR18000BE10P router, loading
firmware from a UBIFS volume for Marvell CUX3410.

Changes in v4:
- net: phy: aquantia: refresh format
- net: phy: aquantia: refactor firmware upload helpers
- Split firmware upload helpers change
- Reorder `aquantia_read_fw`
- Make `aquantia_read_fw` weak to allow overide
- Rename exit label in `aquantia_read_fw`
- Kconfig polish

Changes in v3:
- Select FW_LOADER with PHY_AQUANTIA_UPLOAD_FW

Changes in v2:
- doc: bindings: use upstream bindings for aquantia phy
- net: phy: aquantia: replace the "mdi-reversal" node with "marvell,mdi-cfg-order"
- Add support for script based loader

Beiyan Yun (5):
  net: phy: aquantia: refresh format
  doc: bindings: use upstream bindings for aquantia phy
  net: phy: aquantia: replace the "mdi-reversal" node with
    "marvell,mdi-cfg-order"
  net: phy: aquantia: refactor firmware upload helpers
  net: phy: aquantia: use generic firmware loader

 arch/arm/dts/fsl-sch-30841.dtsi               |   8 +-
 arch/arm/dts/fsl-sch-30842.dtsi               |   2 +-
 doc/device-tree-bindings/net/aquantia-phy.txt |  15 +-
 drivers/net/phy/Kconfig                       |  28 +-
 drivers/net/phy/aquantia.c                    | 299 ++++++++++--------
 5 files changed, 188 insertions(+), 164 deletions(-)

-- 
2.47.3

base-commit: 08bf42e1faa4411cd347c2e370da790a0116e318
branch: aquantia-fsloader-v4
