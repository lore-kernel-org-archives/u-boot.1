Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29A4CD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 07:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A438848D2;
	Tue,  2 Jun 2026 09:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Aa1FTW8n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CB82848BB; Tue,  2 Jun 2026 09:19:08 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2F0284881
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 09:19:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 881E1409C2;
 Tue,  2 Jun 2026 07:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60898C2BCB4;
 Tue,  2 Jun 2026 07:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780384742;
 bh=isRyibY0H+lkNaujLtRY0btlPaqJyqRSHaBLQFbwFiU=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=Aa1FTW8n1iiT5uLJswItOcwb1dZ1yNgdbMP8A0H/obrnQcsSPpVS1h8TEiMNoH0BH
 tVXLjYVHJH5MoNHBdEkxhEPdcDX8grww+azjJ2R3Ms+KMO5rzWCAqz+sFMPbH+gOlt
 RNnQIZ/j15a1vds83qe2TKjJzmRK9eeUHVJSaKvri+PGs8AmpPCwg/G9RQ1v1DJ5JU
 icJDnj9zswyLb0xY8Omgx+XpVARfQjvdxVDT4uOiukntEJ4bvL+02LJKk4n/XEpxb7
 Tn6XKefpoG4Z0DtpBt8XetQrf/EZRqp0fDpyoj+1zqbLaQXg8juyZOlLHUzUyntqon
 juDAzJoFZgB9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 455ACC5DF71;
 Tue,  2 Jun 2026 07:19:02 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Subject: [PATCH v2 0/6] MSM8916: Bring secondary cores online with spin-table
Date: Tue, 02 Jun 2026 17:18:56 +1000
Message-Id: <20260602-msm8916-smp-support-v2-0-792e53dac374@samcday.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ7CIBQFr9KwFgMoQl15D9NFhY9lQUF+29g0v
 btYY9y4nJe8mYUgZA9IztVCMkwefewLiF1FTNf2d6DeFiaCCcm4UDRg0DU/UQyJ4phSzAOVToK
 6HWvLFJDyTBmcf27Wa/PhDI+xyIff2HkcYp638sTf6zei/0YmThk91FIrx7VxzFywDca2897EQ
 Jp1XV/gohYkzQAAAA==
X-Change-ID: 20250127-msm8916-smp-support-5f5e7b49d07e
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780384740; l=2524;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=isRyibY0H+lkNaujLtRY0btlPaqJyqRSHaBLQFbwFiU=;
 b=iFhHh4pMqtNlVMoMA5WecbooVSaEtSHaaMmN2BOQ2B5JT3QoHMODvbu13uPKcW66AV3LCgTrB
 pzIt8tDv3YOC/GRWGxpUA6Rcyoq1bAxBFUR8bJp8TljDtvCcm29N1g9
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This patch series depends on the "mach-snapdragon: handle platforms
without PSCI support" patch that was submitted earlier today. That first
patch lays some groundwork to handle detecting when a device is booting
without PSCI and deletes the /psci node in that case.

This series builds on top of that detection by rewriting all CPUs with
enable-method="psci" to "spin-table".

Once this is done, the existing spin-table support in U-Boot handles
further patching the nodes with the appropriate cpu-release-addr and
reserving the memory with the spin-table instructions.

Interestingly, this spin-table code doesn't seem to be in active use
anywhere, and it had bitrotted a little. But after blowing the dust off
it and fixing a couple of missing #includes, it works great.

I extended the spin-table support a little to make it easier for
consumers to plug in a method that is called for each CPU that needs to
be brought online. This saves the qcom board code from needing to hook
into ft_board_setup or something that runs before booting the OS.

Signed-off-by: Sam Day <me@samcday.com>
---
Changes in v2:
- Reworked the SCM impl to be a proper firmware driver, and streamlined
  the API so callers aren't forced to deal with calling conventions
  (thanks Casey).
- Link to v1: https://lore.kernel.org/r/20250128-msm8916-smp-support-v1-0-39587f18cf0c@samcday.com

---
Sam Day (6):
      armv8: spin_table: Fix missing includes
      armv8: spin_table: add hook for booting cores
      firmware: Add qcom SCM driver
      mach-snapdragon: fixup CPUs with PSCI enable-method
      mach-snapdragon: MSM8916 spin-table CPU boot support
      qcom_defconfig: enable spin-table support

 MAINTAINERS                            |   2 +
 arch/arm/cpu/armv8/spin_table.c        |  20 +++
 arch/arm/include/asm/spin_table.h      |   3 +
 arch/arm/mach-snapdragon/Makefile      |   1 +
 arch/arm/mach-snapdragon/board.c       |  41 +++++
 arch/arm/mach-snapdragon/msm8916-smp.c | 138 +++++++++++++++++
 configs/qcom_defconfig                 |   3 +
 drivers/firmware/Kconfig               |   9 ++
 drivers/firmware/Makefile              |   1 +
 drivers/firmware/qcom-scm.c            | 274 +++++++++++++++++++++++++++++++++
 include/firmware/qcom/scm.h            |  71 +++++++++
 11 files changed, 563 insertions(+)
---
base-commit: 30b77f6aa146c96b831cb4ece038130b655b6a41
change-id: 20250127-msm8916-smp-support-5f5e7b49d07e

Best regards,
-- 
Sam Day <me@samcday.com>


