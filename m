Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62925C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 10:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67330878E1;
	Mon, 23 Oct 2023 12:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698056276;
	bh=AzD4mvSMnffYeS/UoOiYbbTi1bx5hHXB76dG+buSx0E=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DwxVQHbRKvXk/I5KzXKy83FalG37gYHYvr8j4RdsMMFnUlLZ56KoZtdTNyiI+atZ4
	 0FBYyBoTUvfAMoxWQ6CbrIZR/8amnhjGiMDmPbNjtDXRFwH68yc19iEQ8NsG3kg6Wl
	 FonamddGxCvX5NK+crSybRklAh3TclP0xzfI4YbIs9PvKjyGQWWKMbUa6qTh5pWCHi
	 1OQgxo9BLm3qx0drx/pFeVQPUDCsaIMFWQDol5aU4Nt4cVFqJwTVUKZ4NpXjbB598b
	 J5CbvmLSLRjtcUQ+h1DX5Vw5q3UUp20Fmn5ZhaY85DAwQBwDNY5iacvcrIU7QcpZr0
	 3H+MhLyuhKvXQ==
Received: from crub (p508b605d.dip0.t-ipconnect.de [80.139.96.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 835DA878D7;
 Mon, 23 Oct 2023 12:17:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698056274;
 bh=AzD4mvSMnffYeS/UoOiYbbTi1bx5hHXB76dG+buSx0E=;
 h=Date:From:To:Cc:Subject:From;
 b=uuGMl4EaU6qhSoyx2YeztbW1hTBBfO9zVmaYL2EmrOdRFbeOxxTfwCMI14Un3zYqZ
 ftn4zwZ/gs0shsTMXKIvqa1Pj+pbxsMPE/7KnimLtKGnM6DGtfq46i3+HRiKjrJlxO
 vsBOCsxm0UoT76l82WSNo3LgeNZpvEnD2uL1oeYjg6hEHluRLm2w/BGJDihFGRyW3i
 YeSgsydGh4bP2lM4GsIT396Esy/BqkZ3Fv//1JH8hBH1H3Vy9HOHWJMMvjc2zHnqCo
 DUMCnl/1goZWPAX2LEOPeqJ0HH+8fFzBHWtfNxkijYDLAKLlwSlZy3wHJnJAs59IWa
 w2kWgtA3FDZLw==
Date: Mon, 23 Oct 2023 12:17:53 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Please pull u-boot-video
Message-ID: <20231023121753.4b2cb806@crub>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

please pull video driver updates for v2024.01-rc1.

CI: https://source.denx.de/u-boot/custodians/u-boot-video/-/pipelines/18257

Thanks!

The following changes since commit 9a3a58396b78b1f9d0c14580dc03f81d29207dd2:

  Merge https://source.denx.de/u-boot/custodians/u-boot-marvell (2023-10-20 12:54:33 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-video.git tags/video-20231022

for you to fetch changes up to 846dcae7337e25d1608c891fb68ce4227bc6b710:

  video: tegra20: dsi: use regulator_set_enable_if_allowed (2023-10-22 19:28:31 +0200)

----------------------------------------------------------------
 - updates for pwm_backlight, simple_panel and tegra20 to keep
   fixed/gpio regulator counter in balance

----------------------------------------------------------------
Svyatoslav Ryhel (3):
      video: pwm_backlight: use regulator_set_enable_if_allowed
      video: simple_panel: use regulator_set_enable_if_allowed
      video: tegra20: dsi: use regulator_set_enable_if_allowed

 drivers/video/pwm_backlight.c     | 13 ++++++-------
 drivers/video/simple_panel.c      | 10 +++++-----
 drivers/video/tegra20/tegra-dsi.c |  8 +++-----
 3 files changed, 14 insertions(+), 17 deletions(-)
