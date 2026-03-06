Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC38F0180E
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 08:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E8D883F8A;
	Fri,  6 Mar 2026 09:58:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="Myn1ZRDV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C138883F2D; Fri,  6 Mar 2026 09:58:36 +0100 (CET)
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch
 [79.135.106.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54BAF839A8
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 09:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail; t=1772787511; x=1773046711;
 bh=PmcFAMZFNXcVnsLcglJ3I+/QjEusavR8cflZ8M4avkI=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Myn1ZRDVpIlNZMhYPY+5NiBiYeLFrCOUgvpfaa4oUOH3t8hZzExNqITOe1AbU8eo8
 7TG3LFZ5LmGU2XLHrD8GGqzZOcUZQa9ay0unuqnGH5oE+VXZ3MrD1PMDspHs7cXiQM
 ZHPVUXRw1RZi6gZJVDvMFdNsVNW4HHTnV/3X9CfPkUkWlrz9DxCvDpJ4DE7C8yOTs8
 kI7diGqqrEN5Rwbj/EMp24cgNI4lTQF4SdwD3gOB9DetXG1ukJ12H7rAEVLcUOAmB8
 XGw+Yoj1kd+YyJJuOJ40ZVthcXoQAm2MorQeC8BADW180UwGN7w+DHiQD1QGBRff4W
 XoV4KmBn4HZgA==
Date: Fri, 06 Mar 2026 08:58:27 +0000
To: u-boot@lists.denx.de
From: Philip Molloy <philip@philipmolloy.com>
Cc: linux@analog.com, Philip Molloy <philip@philipmolloy.com>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Philip Molloy <philip.molloy@analog.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/4] Minor i.MX DDR init clean-up
Message-ID: <20260306085824.886254-1-philip@philipmolloy.com>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: d2392377f7e7f3b1c4be01e2136227d7d4d8a5a7
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

This series makes minor clean-up changes to the i.MX DDR init code.

Unfortunately, I don't have access to any NXP hardware. I ran into LTO
issues with my Fedora toolchain building imx8mm_evk_defconfig. And
binman issues because of missing binary blobs with some imx9*
defconfigs. But compilation was successful.

To support an upcoming ADI SoC that also uses LPDDR4 and Synpsys IP I
would like to leverage the i.MX implementation. Therefore this clean-up
can also serve as a kind of pre-RFC. I would love to know if the
maintainers are open to transitioning to a more generic implementation.
If so, I'll submit a proper RFC. I'll also be at Embedded World next
week if anyone would like to discuss in person.

Some additional context and a comparison of DDR init implementations:

https://philipmolloy.com/ddr-init.html

I reviewed the NXP i.MX downstream repo on Github.[1] The changes in
this series are not fixed downstream. The only major difference with
downtream for the PHY driver appears to be "Quickboot" support, which is
specific to the i.MX 95.

[1]: https://github.com/nxp-imx/uboot-imx

Philip Molloy (4):
  ddr: imx: Remove duplicate includes
  ddr: imx: Remove undefined declarations
  ddr: imx: Remove unused macros
  ddr: imx: Remove unnecessary macro argument

 arch/arm/include/asm/arch-imx8m/ddr.h | 10 ++++------
 arch/arm/include/asm/arch-imx9/ddr.h  |  8 ++------
 drivers/ddr/imx/imx8m/ddr_init.c      |  8 ++++----
 drivers/ddr/imx/phy/ddrphy_utils.c    | 15 +++++++--------
 drivers/ddr/imx/phy/helper.c          |  4 +---
 5 files changed, 18 insertions(+), 27 deletions(-)

--=20
2.53.0

base-commit: 7995bf8dea2d5b3eb7fcb836636f4773924ec35d
branch: ddr-imx-clean-up

