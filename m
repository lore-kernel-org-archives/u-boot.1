Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1910CCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 11:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A5EC82B20;
	Tue, 14 Oct 2025 13:56:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="dV5w6p/6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D283582991; Tue, 14 Oct 2025 13:56:23 +0200 (CEST)
Received: from outbound.mr.icloud.com
 (p-west2-cluster4-host9-snip4-10.eps.apple.com [57.103.69.181])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E38A802C1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 13:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-2 (Postfix) with ESMTPS id
 DF7CA18000AA; Tue, 14 Oct 2025 11:56:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=20Y7wv+iZda9O40G3BasnM+5MEpeQ7GmsorE8TrCfR8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=dV5w6p/6oSqGD+2Y2DErxmPoB+NY2+ehUabxZCd4yiIhb4A08H+5ulPsis9B7xfNlp4cSEkFyxpEem29lBADcK9j0Ih4IlvhbUv5tMz9ueH9MzS6z8cSJWG92JIli1GXclCx7yTuvBgJTf+4thRyXmbSJPiW7G33O5paqPttA6rXQcIHyvwUnGxv2gyObxdWni7AN2DvEirxLOWcYrFG3HGogTjCJoVGd5T4vr4yTDiFBmbFH1wYP/cmjodzBrZthMOIZ1auwDdnf0g+s9rM3/lohTIxcvQ5NLBXQx27qwETDe6IBhXVrTsxBXl08iOxESBXypUKld0mCwp2MP28ow==
mail-alias-created-date: 1549370554000
Received: from debian.. (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-2 (Postfix) with ESMTPSA id
 6FB7B1800096; Tue, 14 Oct 2025 11:56:15 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <ziyao@disroot.org>,
 Beiyan Yun <root@infi.wang>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v2 0/4] net: phy: aquantia: Switch to generic firmware loader
Date: Tue, 14 Oct 2025 19:53:56 +0800
Message-ID: <20251014115604.194150-1-root@infi.wang>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: eZ8fgTQw4FBO6LyNe7s9kbe9MdS89-rP
X-Proofpoint-GUID: eZ8fgTQw4FBO6LyNe7s9kbe9MdS89-rP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDA5MyBTYWx0ZWRfX0P390sgUrfF0
 ZvWGWtAXbMgaIHZEf5lwGerepN+WmpN3lovLpW5Cpgun+X7A0XrKijshPkvO56o4MGjbpOlAviL
 quglLu6e0yexzwdODB++KLwHe1GCpB0TKvOGsGT+C7ZmBx0YyQVXfQ3yEt9hg4Y70j1ptnI0X1v
 4Lz6lHkR/ZKjVwBELT+f40B/xNEPOMqf8dojOc9pMAX2tu0oB1GfZGnX7Vtrg8WUtLzOIqXk0Nc
 LQsAfAkEFtEA1uoFYsHx3VTquSswan+BC2YbdaWgsZUNdhEfiR/0/zhtIB5CfrIl6BMvulaQA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=734 bulkscore=0 clxscore=1030 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510140093
X-JNJ: AAAAAAABIK0fDSNov2NmjLeEzwda5Nnoo6eR01lOmuECDWfslNfI6qG0vTVQtStfYDmjCVpMm7S0eKEZP5qJwKkziXCMZO2mV7J847OK2wdqZIW5Etop5HMKI8r2NH/xrEkUOe/EWMoItceYDxxtc5GPzE60G/yNnyA2S/uJsGPT1L8cy28fjFpx7dpUBMdo1rtJDzseD2rqM1sPB6CLwZNhv2dhTyGEYPaghEqeEqcYW0v47gOLN6Zs1/PmHOv+4BBQdT8o/N1XiaT10q+iTjOzxOWZorHbgH515CxjZU7PW/3wKZAvXFeWI2rcSENr1OckJq4zRCFFKG+phyA4qN8h3KTN+tJ0Ao13tJPFaJIPDm3ZH4Gxl4ftf7/B4KO42tdgDdT4XLau/1knDims+VLpr+BkpCsOOccyy4S0Zzbpgd0Igp7s+NVV/ryJ2Xw+flQr5U9THSuQulvF8a3F/wLy8YVXAa0lQlGHky28tGrN/WlTnchjovzMZTMVEHWMxoWzQ9FmVC1ZKeMkZ6ggwRoI1daHnnyV3G0CaOJnbKE7ce+ufjGIhn9X1q7f5lvGtBDcfmNlMJ8GVfcKMVCCLWKrT/PSn3Gy0wSN6Zczh8rlG4Xq9cLDekt/+7ZiQxRkorOdLnm498g30HNLZMoyhzWO+UmwmD5A3VThogR7/1iE67dXxiShwahqbgqUK5Jumq4H/p9bzY7BR+15/S0bv4YiZ5hEbjmscVTs1QKldNH1ZHMhUC+qW4tnxmkVwrt9+f/l4+vPn+F6qF/EGUK2jF0kIcn+5bKEzMXRFeWx2rzb/5eZPiQ8/Q==
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
- The first patch is a minor cleanup, switching to the phy_get_ofnode()
  helper.
- The second patch aligns binding document with upstream and prepares
  for the migration.
- The third patch aligns binding for MDI with upstream.
- The final and main patch replaces the custom loader with generic one.

Kept smb-addr intact as NXP is the only consumer.

This change has been tested on a Buffalo WXR18000BE10P router, loading
firmware from a UBIFS volume for Marvell CUX3410.

Changes in v2:
- doc: bindings: use upstream bindings for aquantia phy
- net: phy: aquantia: replace the "mdi-reversal" node with "marvell,mdi-cfg-order"
- Add support for script based loader

Beiyan Yun (4):
  net: phy: aquantia: switch to use phy_get_ofnode()
  doc: bindings: use upstream bindings for aquantia phy
  net: phy: aquantia: replace the "mdi-reversal" node with
    "marvell,mdi-cfg-order"
  net: phy: aquantia: use generic firmware loader

 arch/arm/dts/fsl-sch-30841.dtsi               |   8 +-
 arch/arm/dts/fsl-sch-30842.dtsi               |   2 +-
 doc/device-tree-bindings/net/aquantia-phy.txt |  15 +-
 drivers/net/phy/Kconfig                       |  23 +--
 drivers/net/phy/aquantia.c                    | 139 ++++++++++--------
 5 files changed, 98 insertions(+), 89 deletions(-)

-- 
2.47.3

base-commit: 48f21e66e360552c75d70a50421d0e0ed1f59e90
branch: aquantia-fsloader-v2
