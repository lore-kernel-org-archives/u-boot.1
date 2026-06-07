Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD16CD8C89
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 19:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4548E838BB;
	Sun,  7 Jun 2026 21:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q+fZbu8B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2B77846D3; Sun,  7 Jun 2026 17:46:08 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C31A6801A9
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 17:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+raz.benyehuda.mobileye.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 21FAA60018;
 Sun,  7 Jun 2026 15:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C889DC2BCB4;
 Sun,  7 Jun 2026 15:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780847164;
 bh=0YZa3XgrAxE3m6lpx/T7mJEs/9QPTvZVXgxLoQZ8F+E=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=Q+fZbu8B0mIJOBkTz85nGOH6WriEGf0OViFlRnk9CyW+HIk5HEsVeDP3nb4EybnHq
 iuZSo0a45gU6//SjDTWDhxDBuPDuB/PltK1YeXiiboHnBhDO3EC/M2QcFfykRBGW3g
 o1A6okANsBJuD+ppM8rQbBlBStG3pEKyLHl38y2OGntK2l4GepNXV1X9WQx646bwLk
 Fy5OnFHTAzEGzPXJAV4fGqlkSP9atMamIrtUoa2zA6l3FvA2rNp8RxsXgu4hi+H8JT
 aL+Vp1iv7Gw6SWOl/9ZRSQ9y3Pochsks+/8bGVD86GvQIlR1zWebvDGMHt95GTAqI2
 O098FcrJpKFIQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id BBF44CD8C8C;
 Sun,  7 Jun 2026 15:46:04 +0000 (UTC)
From: Raz Ben Yehuda via B4 Relay
 <devnull+raz.benyehuda.mobileye.com@kernel.org>
Subject: [PATCH v2 0/5] ufs: Exted cmd line
Date: Sun, 07 Jun 2026 18:45:30 +0300
Message-Id: <20260607-ufs_tool2-v2-0-f79ff26ab18c@mobileye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABqSJWoC/yXM0QpAMBSA4VfRubaa0cSrSGIOjmTaGSl5d8PlV
 3//BYyOkKGMLnB4EJNdA1QcgZnadURBfTAoqbTUMhf7wI23dlEiSUyaFakupMkg9JvDgc7vVdW
 /ee9mNP4dwH0/tWUcNm0AAAA=
X-Change-ID: 20260607-ufs_tool2-11c3493690c4
To: u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Michal Simek <michal.simek@amd.com>, Julien Stephan <jstephan@baylibre.com>, 
 Udit Kumar <u-kumar1@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Jared McArthur <j-mcarthur@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>, 
 briansune <briansune@gmail.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1685;
 i=raz.benyehuda@mobileye.com; h=from:subject:message-id;
 bh=0YZa3XgrAxE3m6lpx/T7mJEs/9QPTvZVXgxLoQZ8F+E=;
 b=owEBbQKS/ZANAwAKAZ+a6ZSW6I45AcsmYgBqJZIsmgGnF7xuKRorEvGAhY7S6BI+mICzICgM+
 9QiqjDBeVWJAjMEAAEKAB0WIQSC7lz5E3UmOrJvRDqfmumUluiOOQUCaiWSLAAKCRCfmumUluiO
 OUskEACMLRVhWHAeO3rrjY1LXmHNjlsJmJ4+mGPeaURsPKYMnjCugelCHNSlcvH6mD3ihx4G2L1
 nTbO1DQg9sZUiSDSAutpK31nobPaLA0O9+09w/3MX80/+VS1skilWuJ1db78ai29jrXnFl+HHpH
 QCeWEuljjV7GbxvKZhKW7/sVMoNxNkKdn05iZ6ngwFxEACaemy8s5A06mUmeYHaH+N19kMTXJqE
 psE7G2TDznD/8KHw+Hp2qCUPxx4JE45JE1Azjny7J4zefhy+qL5jAO7cuWr/U4rNDs6wfPBQEVb
 AXVHDlqA23UDMXWqU7t7+UjO5wkuN2vL5T94cA2uU4BvCbTEp3YhvRlkTTyVdNqfLNocK0i2liI
 3xzV3mqyqMzB6Zb748utb3qg36wcuOULZagnWXWwjUBTHKGvTIKHk04e/1KptDgyxMHz1Ro/iNc
 6tYZ5gkigA+2vCPQjC9lp38HRNdn/FBxkKHALE+dOH2m4sMf2coYElnlEoW5TR6C7OH7Zdpr209
 hjEtCKCBu2GY11Xfkfu40iuoykgo/id1VHn/q4RryFQj+nnmtYLtA915WgCEOnXQdSeGPw8Jqlq
 qZ8BL9kUpjH2q9zAB1rUt9Pvf+JHt1KmtK4wPpXoU23Ht9Me01Xz0+oI36GEKJIUbs6ZqZPKKa+
 AeVYnjXo/7Fz0gA==
X-Developer-Key: i=raz.benyehuda@mobileye.com; a=openpgp;
 fpr=82EE5CF91375263AB26F443A9F9AE99496E88E39
X-Endpoint-Received: by B4 Relay for raz.benyehuda@mobileye.com/default
 with auth_id=808
X-Original-From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailman-Approved-At: Sun, 07 Jun 2026 21:34:17 +0200
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
Reply-To: raz.benyehuda@mobileye.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The UFS command provides utilities for querying, displaying, and modifying
UFS device configuration and descriptor information. It is commonly used to
configure UFS logical units (LUNs) in U-Boot, allowing storage devices to be
provisioned and reconfigured as needed.

Features:

* Display Device, Geometry, Unit, Configuration, and Power Descriptors
* Display LUN configuration and calculated capacities
* Modify fields in Device, Configuration, and Unit Descriptors
* Query common UFS runtime flags
* Commit configuration changes or clear all LUN configurations
* Decode and format descriptor contents for easier debugging
* Provision and configure UFS logical units

Changes in v2:

* Add HBA ID support
* Move ufs_tool.c to cmd/ufs.c
* Add myself as reviewer
* Rename patch subject to  "ufs: document the UFS command"

Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
---
Raz Ben Yehuda (5):
      ufs: Expose selected UFS functions
      ufs: Add flags according
      ufs: extending ufs cmd line
      ufs: document the UFS command
      MAINTAINERS: Add myself to the list of UFS maintainers

 MAINTAINERS              |    3 +
 cmd/Makefile             |    1 +
 cmd/ufs.c                | 1309 +++++++++++++++++++++++++++++++++++++++++++++-
 doc/usage/cmd/ufs.rst    |  226 ++++++++
 drivers/ufs/ufs-uclass.c |   18 +-
 drivers/ufs/ufs.h        |   16 +
 include/ufs.h            |  374 ++++++++++++-
 7 files changed, 1929 insertions(+), 18 deletions(-)
---
base-commit: 0c035ff60c1e8caee7fccd2673ce75380dee825b
change-id: 20260607-ufs_tool2-11c3493690c4

Best regards,
--  
Raz Ben Yehuda <raz.benyehuda@mobileye.com>


