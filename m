Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28545C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 20:45:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 511D488785;
	Tue, 16 Jul 2024 22:45:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mail.de header.i=@mail.de header.b="RSfRP67g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADB1988A07; Tue, 16 Jul 2024 22:45:31 +0200 (CEST)
Received: from shout02.mail.de (shout02.mail.de [IPv6:2001:868:100:600::217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66BB588440
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 22:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=seb-dev@mail.de
Received: from postfix03.mail.de (postfix03.bt.mail.de [10.0.121.127])
 by shout02.mail.de (Postfix) with ESMTP id E2FBD240ED5;
 Tue, 16 Jul 2024 22:45:28 +0200 (CEST)
Received: from smtp01.mail.de (smtp01.bt.mail.de [10.0.121.211])
 by postfix03.mail.de (Postfix) with ESMTP id C16B5801CF;
 Tue, 16 Jul 2024 22:45:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
 s=mailde202009; t=1721162728;
 bh=6BT56+eLbqxhxFtBTSExCYtmuZEblMr2CB7civE53jE=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
 b=RSfRP67g+AjodDXxebSoNfFBQcNEY0JCXyjIDDlFUSmOj8Pyu1a3RcP0BfhDWhvKP
 Fsy0HqNX4bGFNaDEuVJR5MkWZLuX16v3Ie4LZonpNr7qwW5xQgNpEPShm060t62xYO
 Wh9C3yzpaPPJMnxk5fM2JR7zHMZCp/U6lKbqkjXLBbGIjXVjnWsI+dUYjacO1ibi4c
 08ZpXrw47KGXCV37S2Nq/KnyTy+Rm3g/9tdVMkgk9gd/mxQ4WYiMwc4dEkMwu4inCL
 KOTKMASLSUwDBTvtAdb3FhRBH/SQDBDBYPpH+MvOifCsKKsbNwlbOaIqwOY3TbwiIZ
 CvropO0dil1Cw==
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp01.mail.de (Postfix) with ESMTPSA id B48C5240A08;
 Tue, 16 Jul 2024 22:45:26 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 0/5] phy: rockchip: snps-pcie3: Fix bifurcation and spelling
Date: Tue, 16 Jul 2024 22:42:05 +0200
Message-ID: <cover.1721161722.git.seb-dev@mail.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate: clean
X-purgate-size: 1851
X-purgate-ID: 154282::1721162728-45DBE670-59E31C39/0/0
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

Several fixes for RK3588's PCIe PHY from upstream Linux [1][2], which
uses a very similar driver.
Tested on a FriendlyElec CM3588 NAS which uses PCIe bifurcation in
1x1x1x1 mode to enable four M.2 NVMe sockets. With these fixes applied,
NVMe SSDs get properly recognized in U-Boot.

In addition, v2 introduces a new patch to fix combo PHY muxing for
RK3588. [3]

While at it, correct a few instances where "rockchip" was written as
"rochchip" in two Rockchip PHY files.

Cheers,
Sebastian
---

Changes v1 -> v2:

 - Add new patch "phy: rockchip: naneng-combphy: Introduce PHY-IDs to fix RK3588 muxing"
 - Collect "Reviewed-by: Kever Yang" tags for all previous patches
 - Link to v1: https://lore.kernel.org/u-boot/cover.1720988760.git.seb-dev@mail.de/T/

Links:
[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c?id=f8020dfb311d2b6cf657668792aaa5fa8863a7dd
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c?id=55491a5fa163bf15158f34f3650b3985f25622b9
[3] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c?id=d16d4002fea69b6609b852dd8db1f5844c02fbe4

---
Sebastian Kropatsch (5):
  phy: rockchip: naneng-combphy: Fix "rockchip" spelling
  phy: rockchip: naneng-combphy: Introduce PHY-IDs to fix RK3588 muxing
  phy: rockchip: snps-pcie3: Fix "rockchip" spelling
  phy: rockchip: snps-pcie3: Fix bifurcation for RK3588
  phy: rockchip: snps-pcie3: Fix clearing PHP_GRF_PCIESEL_CON bits

 .../rockchip/phy-rockchip-naneng-combphy.c    | 53 +++++++++++++++++--
 .../phy/rockchip/phy-rockchip-snps-pcie3.c    | 42 +++++++--------
 2 files changed, 67 insertions(+), 28 deletions(-)

-- 
2.43.0

