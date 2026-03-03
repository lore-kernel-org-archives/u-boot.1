Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3B7EDEBE3
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 18:39:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EFD783F59;
	Tue,  3 Mar 2026 19:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BOeCPKwb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F380683F61; Tue,  3 Mar 2026 19:39:32 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A93B283F2D
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 19:39:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D7EBE416FC;
 Tue,  3 Mar 2026 18:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A30BC116C6;
 Tue,  3 Mar 2026 18:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772563168;
 bh=33RJAP6z3WESZvGfnWZSGAX5vMwWlQyL+9kciEGoXX8=;
 h=From:To:Cc:Subject:Date:From;
 b=BOeCPKwb8GalI6RUPw7QnZXHxIddzJIwUQBw95sgoy6MxglC/qEPHOjtZOMeESm5t
 MiS/lV2gWlsLpld3bTJiB4shNHLcRN9cHRKb1supcGXuq607O18UM37w1INst+F76q
 3NGDedhxdnmES8jBr/PluRflOU46+WmNViSBqI+YkuTIfPyTfJwSux+i9FgzoLJ1By
 9WsJLQDlqKZVaP6LlMQOySPPcGEqntwCG21xBJshGU+Tt3qaJ85JamlAFhBDVFI5o3
 PScbKMiJEDbXRpBl+8mlmrIIusJBolhx0L+7KSOBRwa3FVga+1uEHq7QDmMS28nk2w
 2G46AEQSr2wRw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Heiko Schocher <hs@nabladev.com>
Subject: [GIT PULL] Please pull u-boot-dfu-next-20260303 into next
Date: Tue, 03 Mar 2026 19:39:25 +0100
Message-ID: <871pi0u59e.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Tom,

Here is a PR for next

Fastboot:
* mmc: make boot partition offset configurable for bootloader offsets
* arch: imx8qxp: Override weak fb_mmc_get_boot_offset

CI:
* https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/29417

Regards,
Mattijs

The following changes since commit cf6aa7cf731d3b1b296802e47e9800b0d6bed65a:

  Merge patch series "bootcount: Small clean-up and fix, and dm_i2c single-word support" (2026-02-18 16:35:12 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-next-20260303

for you to fetch changes up to 94b7c3b2622ae1e43aae0d92005ac8ca4dd9f134:

  arch: imx8qxp: Override weak fb_mmc_get_boot_offset function (2026-02-19 11:27:51 +0100)

----------------------------------------------------------------
u-boot-dfu-next-20260303

Fastboot:
* mmc: make boot partition offset configurable for bootloader offsets
* arch: imx8qxp: Override weak fb_mmc_get_boot_offset

----------------------------------------------------------------
Adrian Freihofer (2):
      fastboot: mmc: make boot partition offset configurable
      arch: imx8qxp: Override weak fb_mmc_get_boot_offset function

 arch/arm/mach-imx/imx8/cpu.c | 21 +++++++++++++++++++++
 drivers/fastboot/fb_block.c  | 15 +++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)
