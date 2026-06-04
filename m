Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBB9CD6E6B
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56C34849B7;
	Thu,  4 Jun 2026 14:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WH0DUvTm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 682EE84908; Thu,  4 Jun 2026 13:25:59 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 237C98486A
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 13:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+raz.benyehuda.mobileye.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8616643969;
 Thu,  4 Jun 2026 11:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61BC0C2BCB8;
 Thu,  4 Jun 2026 11:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780572355;
 bh=AL7VqZ4sEXVoy0juNT5hOLixCQkNcQ0vguXsZuTO8OQ=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=WH0DUvTmJ+wutaZ4UDJ6iOZ7Bo7TzdUIBRiBoQeVadVFOBWQTJdiLhR2UwdtXsOT2
 GEHPmwX51VW8aBT9x4kVVR89RTPZXcKpASrcWvELDG0yB7Lys/UIuWWYgASVvV4uKs
 fhGF0Y2YfIYEs1fa7YKBAbyXY24n5c+7UJXCEes88WN626UrhkEJe7iMU1eqtInvaD
 u+2KT180As9mKiqjGAotFZEne091MS1QHGvol8Tjj/AvVtD77BYRYNVjzPPlfK7FzV
 jMpNxnHFnpyWi6himvsU4Lr+cP3ITHgxTFqkWGifkBtse9NGluf9pHK8Tq2eWgl3Qd
 3LsfalGEbpY0Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 56744CD6E4A;
 Thu,  4 Jun 2026 11:25:55 +0000 (UTC)
From: Raz Ben Yehuda via B4 Relay
 <devnull+raz.benyehuda.mobileye.com@kernel.org>
Subject: [PATCHSET PATCH 0/6] UFS-TOOL
Date: Thu, 04 Jun 2026 14:25:48 +0300
Message-Id: <20260604-ufs_tool-v1-0-741ed00232c0@mobileye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALxgIWoC/yXM4QpAMBSG4VvR+W21YYpbkcSccSTTDlJy74afT
 73fdwGjJ2Qoows8HsTklgAVR2DGdhlQUB8MiUxymctM7JabzblZpF2vpVJKF6mFkK8eLZ3fVVX
 /5r2b0GzvHu77AQKjp9psAAAA
X-Change-ID: 20260604-ufs_tool-3bd50111593f
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Yao Zi <me@ziyao.cc>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Michal Simek <michal.simek@amd.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Jared McArthur <j-mcarthur@ti.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Alexey Charkov <alchark@gmail.com>, 
 Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1687;
 i=raz.benyehuda@mobileye.com; h=from:subject:message-id;
 bh=AL7VqZ4sEXVoy0juNT5hOLixCQkNcQ0vguXsZuTO8OQ=;
 b=owEBbQKS/ZANAwAKAZ+a6ZSW6I45AcsmYgBqIWC+U4tQOhcoB3gOVLVCJtH+oOvEM2XVtaTyA
 MaNdiAGc+yJAjMEAAEKAB0WIQSC7lz5E3UmOrJvRDqfmumUluiOOQUCaiFgvgAKCRCfmumUluiO
 OVvZD/0eIAoDtd/ZJCbg2otUL/iTTihYivEt99ANWWE5O4EKcDLp9bi5EHNX8AD767GFv1jg6Mc
 7IDjUqFvflfKIuyBEFYsUmv4SA3OpbmY0oNqXBTe2w/MzGZECfODG7xDK7nO+746oQQd1gAZFyP
 sN6wBTxpcmnYl69NytMe1n1Whva6kG9MGUw0jAJ/MFRKYXg1r7NVoj2TSUZicZ5qofwEvV2qfhF
 1EJu1Nl4WSshxAT212hTNs+SJiUtSauxaDQGU/6pIpPHQiWdD++ALmBPi80GX4Kh8xgHllVKbl8
 y36hAvqbTLkWGzGQn0Hahyp5Ieh/oAioLGznqCWodgVm6dmwH3U0ejkyyR+XPnDC0efSDgEPOCk
 Lyqvt24LOR3nO2T4+1j4M/YapCqlX4tw+8/kGB1kK4D021GDZ0XIn2loltlEQzib0OnoOMjvNPq
 h0+oQLb7qhxVqwJs7s7QmtBmpA0nf2oM3UqeVvRPhrOLr5A1+sY9ZgU1PimzHQxIaVWBZ58t3gP
 L3Udp4L42IL4dIsXNE9A+7ZiijM3eUkq0iJekmcr4cYqSfL85r36mczzzVpFGOJ9oUvozjsgF/l
 0XCP5E6awSPcf8Y9dne5nhTRZZV6eINoX8VJufwccPxVBeAtQ53eT86uR2UuIg1R4jMM8glUsJt
 lcGbeWp9ucphnEA==
X-Developer-Key: i=raz.benyehuda@mobileye.com; a=openpgp;
 fpr=82EE5CF91375263AB26F443A9F9AE99496E88E39
X-Endpoint-Received: by B4 Relay for raz.benyehuda@mobileye.com/default
 with auth_id=808
X-Original-From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailman-Approved-At: Thu, 04 Jun 2026 14:30:17 +0200
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

This is version 2 of the ufs-tool patchset.

Patch [1/5]: UFS tool implementation for querying, printing and configuring UFS descriptors.
Patch [2/5]: Remove the static qualifier from selected functions to allow access.
Patch [3/5]: The cmdline UFS tool.
Patch [4/5]: Add support for the UFS tool to Kconfig and the Makefile.
Patch [5/5]: Documention of the ufs tool.

Testing:
- Built for x86_64 and RISC-V.
- Tested on RISC-V hardware.
- No regressions observed.

Changes in v2:
- Replace printf() with log_err().
- Clean up code style and adopt reverse Christmas tree ordering.
- Add HBA ID support with a default value of 0, overridable by the user.
- Add documentation in .rst format.

Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
---
Raz Ben Yehuda (6):
      MAINTAINERS: Add myself to the list of UFS maintainers
      ufs: add UFS descriptor/configuration utility support
      ufs: Expose selected UFS functions
      ufs: ufs tool
      ufs: add ufs_tool to Kconfig and Makefile
      ufs: doc/usage/cmd/ufs.rst

 MAINTAINERS              |    5 +
 cmd/ufs.c                |   93 +++-
 doc/usage/cmd/ufs.rst    |  217 ++++++++
 drivers/ufs/Kconfig      |   15 +
 drivers/ufs/Makefile     |    1 +
 drivers/ufs/ufs-uclass.c |   18 +-
 drivers/ufs/ufs.h        |   16 +
 drivers/ufs/ufs_tool.c   | 1231 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/ufs_tool.h   |  394 +++++++++++++++
 9 files changed, 1977 insertions(+), 13 deletions(-)
---
base-commit: 0c035ff60c1e8caee7fccd2673ce75380dee825b
change-id: 20260604-ufs_tool-3bd50111593f

Best regards,
--  
Raz Ben Yehuda <raz.benyehuda@mobileye.com>


