Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8315ACCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 12:34:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E51C683A24;
	Sat,  1 Nov 2025 13:34:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="hUtr+8L0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4473683A2B; Sat,  1 Nov 2025 13:34:20 +0100 (CET)
Received: from outbound.pv.icloud.com
 (p-west1-cluster4-host5-snip4-2.eps.apple.com [57.103.65.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A2CE83A1B
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 13:34:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-4 (Postfix) with ESMTPS id
 51B90180138C; Sat,  1 Nov 2025 12:34:13 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=2m6KWMcHx5YyT8mjPFIZ/Y4kQqtMnGLhemLcwbylAhY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=hUtr+8L0jm4NTLANHv946zQirdMOo05C3RJ/6SaUoDLlqf/JmR5VV/IM+KDG/Bv7rJCCvcVDMSGAt+SvU1Syi8kJrEX1eZE9JJAWYtKWVaesapMqbSlbPDpKRj/5JlQhy9kCRilJ4+Nuea1sDV73hNhfL9ZgmF64Ng6gZHol5mHr/XHSxp9o+DO+YZtpckP7aEwfUPWIfqJ71sCWj2Rydeh4HftdNmkwex8CyALco7bR4TBH6HFeR5oFSoMa4FPWnU7WQoJ7wOUN9hMHP7UjJe6ZHJMJ/Rte/HMhXcXEj7+2SD0WsMKzkcz+aN1SnPH3vAC+6ul5Yu4WZS/MZxT3Qg==
mail-alias-created-date: 1549370554000
Received: from debian.. (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-4 (Postfix) with ESMTPSA id
 B129018001AE; Sat,  1 Nov 2025 12:34:09 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <ziyao@disroot.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Beiyan Yun <root@infi.wang>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v5 0/2] net: phy: aquantia: Switch to generic firmware loader
Date: Sat,  1 Nov 2025 20:31:33 +0800
Message-ID: <20251101123401.110681-1-root@infi.wang>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UORRKrg5qIu2oMxy5pQ8BcZf-6b5k-oX
X-Proofpoint-GUID: UORRKrg5qIu2oMxy5pQ8BcZf-6b5k-oX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDEwNyBTYWx0ZWRfX7Sr9mXev/BoR
 afU02Hl5Jy3Vn8uMRmcV0SnojhTmDX9P5cLFT8mO1+BOKwwZuo+6SES8YEEdU+KKGuNRuIfvskh
 1x92bpM1E6njvjlC/4ekQZT7sH/0L5BFqvO6bc0vnyn0sfIzIf89nk354wGvUCEmeB25il6qJ4C
 bUia/v2MaZV+zehIEdXvY8sbXrAcv+jqLOCYK+6A1/gkPKVcrNuRqgQyi2UYCpoVRKdt+Ghlxzi
 KgRANhVDWH1PwjMRfgy3G/LZxDwchO6VL+E3aR58GU0h6amQ0VRu6jVOjHsu3c7+wCxeelD2M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-01_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1030 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=617 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2511010107
X-JNJ: AAAAAAABJ6T82fAitsKP6ovMpnmkmJC0flwOewzETW9kTdFhqfkT4BsOFTdSosRaYJXqc2mxKeWWvPwWZCpJ++aVlgAzYow1+yqv9KFG5PiK5tmDzqyLZdmAiU0Sp3Wy1bM9KbZZtG/2bF3bFGIgH+uO+8ciErvEuY8HnQpjnkcyex8M3cuSUeWCncFwJ14lyfY0IamFV1czy71JLTlCrCrdG3+g0OSKgr+yGSzadetSmw6A3LdmLe7SNMA3t9h1hEzAH5N8Fs9KsD9N1sUkeM8IOjfzsQvwDrNeoZPq2+NOe2Ju5vfmxb1N80427kuaOrp7f++Ifc15oW/BSjvL2qd6TVi+f2OgzNkdV21FllGAoLoLx7q/qIhR0PDnOm7X4s+G5poWn5ZBcfG44rYLflFY3aIwR/dIaU9+dL2vIUL2Bl9ivzIZ+x5Pj+kn3KyZsRs+Kgpgh1NPaANinvQbJX9QzOJfYZm8oSXH0iKP07JMJLTC5KtpuNABitJl8v/M4+ncPsYsMQ8IOywDEnxdtGWR47Yh3CEiGNdOPprn5gZ4c+G3ADXz9JzRfUgj7mkdLOoYe3KiIetkxvHeyc8UIWMo470RrwtMICgMbSsZAYvQCmmqtjlSypQkheIKHxCuooYURJ3kBOk7xOZwBdL5FZZrlE0nQ3ttoifMoVHFe3DZyNEXxI1MGzNCLNdGx/X+VILc+dQ7L2J8pEoHZnSUVGpYxW3JVlCyRbDBdnLMI9Qxv9Wacubyp51WN5pN9YsOm7BXZQtjZdxZKo0Ljorrlabg4Kjq0Mi7D2S1vE988DDL05EX/CiQr0BUXyCyHw==
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
the generic fwloader framework.

The existing loader is limited to loading firmware from an MMC device,
which restricts its use on many devices (e.g., routers) that may use
other storage like USB or have a UBIFS root filesystem. Migrating to the
generic firmware loader allows firmware to be sourced from any backend
supported by the fwloader scripting framework.

The series is structured as follows:
- The first patch prepares current loading code for fwloader.
- The second and main patch replaces the custom loader with generic one.

This change has been tested on a Buffalo WXR18000BE10P router, loading
firmware from a UBIFS volume for Marvell CUX3410.

Changes in v5:
- Remove fsloader codepath
- Drop binding changes
- Make script name static
- Minor refactor

Changes in v4:
- Split firmware upload helpers change
- Reorder `aquantia_read_fw`
- Make `aquantia_read_fw` weak to allow overide
- Rename exit label in `aquantia_read_fw`
- Kconfig polish

Changes in v3:
- Select FW_LOADER with PHY_AQUANTIA_UPLOAD_FW

Changes in v2:
- Add support for script based loader

Beiyan Yun (2):
  net: phy: aquantia: refactor firmware upload helpers
  net: phy: aquantia: use generic firmware loader

 drivers/net/phy/Kconfig    |  23 ++++-----
 drivers/net/phy/aquantia.c | 103 +++++++++++++++++--------------------
 2 files changed, 59 insertions(+), 67 deletions(-)

-- 
2.47.3

base-commit: 62b45e82bdbf703571450e97f605893fe0d50530
branch: aquantia-fsloader-v5
