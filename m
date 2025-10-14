Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E272FCCD18D
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 12:13:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 552B182B20;
	Tue, 14 Oct 2025 14:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="gL/upvyy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DDBA809A5; Tue, 14 Oct 2025 14:13:32 +0200 (CEST)
Received: from outbound.mr.icloud.com
 (p-west2-cluster5-host9-snip4-5.eps.apple.com [57.103.71.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 288DA809A5
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 14:13:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPS id
 16DB91803A6A; Tue, 14 Oct 2025 12:13:25 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=Wq2aVDB+uB1ir1wW9lEVxJhmsVSb+U5Zb385ugwBVWA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=gL/upvyyqjjCDM8V4Q4nafIE/Vo8P6G4lvbeCm9182QmT6L+mX2nc7TWMqjGKU7PpeniOBYEOD2+7xKVXNA+StEHpikZSeqrAWVWmKaCFu5uNAghahw56ATZgKUFUyV+qYSrL71o6s283Zn2A5pzwtj1Vfrv+35h0w4nFuySUsK1BOI7FOwvhpd84zC0ySIMXxvaI67v44KTtS4o/EDbgWKsEOd9/qi9r8sialfETj1GuPDoguYbU2JIusNra7+1PCzuM9Jlc5LyHWNoNciDAqdV5fJrgoj36RikgBSOV23Xlt1P/erjjF26v8zmFI2z1sjT2ReWIRjuh4DCWOmTFA==
mail-alias-created-date: 1549370554000
Received: from debian.. (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPSA id
 8B7511807508; Tue, 14 Oct 2025 12:13:22 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <ziyao@disroot.org>,
 Beiyan Yun <root@infi.wang>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v3 0/4] net: phy: aquantia: Switch to generic firmware loader
Date: Tue, 14 Oct 2025 20:12:45 +0800
Message-ID: <20251014121318.453701-1-root@infi.wang>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: d2LaSoTiZUJY9qtP2abU8pTarC1m4pLk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDA5NSBTYWx0ZWRfX7+56aHtYvYk2
 TIxORLNFeBWdgQ4bNsW4pJdUD34PlNmk79ZeyLbEs4ubEJa2/DITsXN4nSYciOv5W24Lj010oIm
 VR/gPNDjR3kO5COCcAyAxgNOsb6y2hlJgTYMIinptXpciVI2oMLPM9hoSzQso1XxTvkloP+BhkG
 hoXNbdxovUnrbngOfpPvIzx98GFDWJweav9YSrIQ105dEkCfNvVGV7voGGf92j6Zh79TYgc4T8L
 i7+VewBE0b+notS8fItTCzbGYC2HBedlBNkb2k2pEK9PefVDQKPYsPmxPeV37/LFWoLBuLNu8=
X-Proofpoint-ORIG-GUID: d2LaSoTiZUJY9qtP2abU8pTarC1m4pLk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 adultscore=0 clxscore=1030 suspectscore=0 mlxlogscore=784
 spamscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510140095
X-JNJ: AAAAAAABbUHwHMVUabfXXWucxb/bjmeM8o/lic48Nbe0eRXGv2xG9lrMlVlQ38dx4ahUcQUljDo7ttfVIO3GQRA4qtjzkFCx6cwv4GF7aIMla/3Am9b7BHXD/0Y2fAHgJrkqIiOzFL64MFEnbenQkcWCtyklWH3b6KEe7g0GY533lf1Q7kGqFZZ9FG0aRbGwqibcHwADyH0MsFGnVuan/dA/xVsiLsPh+TIeffKVIjEjaDFHIPD5/G9imPzUSeD5rDVCGdGT26p/yJYnzXnkiupdfqwwHVAYBoTKaE80HEqTFE0BFGaoSiBxB7xOHHA8mJZtUFQECedt4FKDvlTAGN1+kQ4RU+AHFCNnHJUdMJmHDGjApdOACbBLil2KviHKyz1jQc5ATRoP8H4qMeLadq+51bUOjDiTD3kpwYVLlAKGvwsc/ghEjhFs7gzvMW/gQAu1zltu+3khpPnMBsnJODiZIunypoxg2eg/a3i6cqE08VXKuvPjP3v4qgVclHbH1dRK9EOCNznn+Q9ShsHVYyequ8WEUJx3ltUYtsVARIAf/otquW0bm5hCU5zk4Jdk/6K3X7QOF105ToEKPsK2zbncUsULeNiFUOeFxZkY4dJSgIo+6cxSk+00EkbGryv3JbrdIGE11B2e22HWRwtLchDp/uKtNZ9Za8eLgnFTMa1VWXDisyA0nszvraIv/A3XJkDsQWrREPZqkDOgijkEzaeNDm5x85/js4Mls+2pFBsWfqR0UNheIPlIm4YGCYlQsa5AlO4mqrgUtRh1bvpJ2f2QuL3mVIM=
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

Changes in v3:
- Select FW_LOADER with PHY_AQUANTIA_UPLOAD_FW

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
 drivers/net/phy/Kconfig                       |  24 +--
 drivers/net/phy/aquantia.c                    | 139 ++++++++++--------
 5 files changed, 99 insertions(+), 89 deletions(-)

-- 
2.47.3

base-commit: 48f21e66e360552c75d70a50421d0e0ed1f59e90
branch: aquantia-fsloader-v3
