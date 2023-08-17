Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF8DEB64DD
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 06:04:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78DD286A50;
	Thu, 17 Aug 2023 08:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="rS4x/gg3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B381686A2B; Thu, 17 Aug 2023 08:04:37 +0200 (CEST)
Received: from s.wrqvtzvf.outbound-mail.sendgrid.net
 (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A66486A2B
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 08:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:mime-version:to:cc:content-transfer-encoding:
 content-type:cc:content-type:from:subject:to;
 s=s1; bh=vckpvl9sBzHB3OIKKmW29sl1pgB/g5n6slZq2ITSFHM=;
 b=rS4x/gg3AEi7MrBP0oCuLLH5x6Nn8BOHvZaSKtpYTDlkovZlC1edkfuNXfF7DeRKjI5M
 EXsCsqnn4YPnsP1M+nSFoeqesyZJOVkUIZE0qjrXx0+LdsiFqhlyyMxGQEU2pMr1LQhJVk
 rD9Ou43jeMzPZuzhZb1gnrgLMRLpGZMhpXQkolJ+GwP1/TBUHBsjzXujmW1Vizx1MoFpWM
 P2caWAHrT63XEAMI7sN4cvTymImM4zTZpfN8Dv7LoaLDTbpfUb22r7vMWVNMNRyszGbaWN
 H6IKVknANFCp0EDOyA6EDktNFhVcLLgCVNldhEHtcPpTCCmEOuv9a/GW42845nOg==
Received: by filterdrecv-d7bbbc8bf-b8xkx with SMTP id
 filterdrecv-d7bbbc8bf-b8xkx-1-64DDB871-22
 2023-08-17 06:04:33.386259218 +0000 UTC m=+8490286.899608433
Received: from bionic.localdomain (unknown) by geopod-ismtpd-8 (SG) with ESMTP
 id OlPFFzOfR1igyrVAxoHl0A Thu, 17 Aug 2023 06:04:33.076 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/3] rockchip: Add supported RK3566/RK3568 boards to
 documentation
Date: Thu, 17 Aug 2023 06:04:33 +0000 (UTC)
Message-ID: <20230817060422.477759-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h3MHgd5FKiQU2GEaM?=
 =?us-ascii?Q?UtwEUSJKd=2FlmYYP0BfpJwsyaVrO6=2F2GmV2p4emY?=
 =?us-ascii?Q?m8mN4Z8742MUZ4gzhlzPxfrJyelvsHKAvKuvSW8?=
 =?us-ascii?Q?07srHEHXV3Q2AJBvupmkKMlBEbDVqQnDLQLvfyc?=
 =?us-ascii?Q?NXitBKqg+kIArzKOk=2Fqs0MaaReJOrBAd0H2RcF?=
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
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

This series add missing supported RK3566/RK3568 boards to documentation
and add related device tree files to MAINTAINERS for a few RK35xx boards.

Also added myself as a reviewer for RK3566/RK3568/RK3588 boards that I
have and can help with review and testing of e.g. defconfig and device
tree changes.

Jonas Karlman (3):
  doc: rockchip: Add supported RK3566/RK3568 boards
  board: rockchip: rk35xx: Add device tree files to MAINTAINERS
  board: rockchip: rk35xx: Add myself as reviewer to MAINTAINERS

 board/anbernic/rgxx3_rk3566/MAINTAINERS       |  3 +
 .../neural-compute-module-6/MAINTAINERS       |  6 ++
 board/radxa/rock5a-rk3588s/MAINTAINERS        |  3 +
 board/radxa/rock5b-rk3588/MAINTAINERS         |  5 +-
 board/rockchip/evb_rk3568/MAINTAINERS         | 55 +++++++++++--------
 board/rockchip/evb_rk3588/MAINTAINERS         |  3 +-
 doc/board/rockchip/rockchip.rst               | 20 ++++---
 7 files changed, 61 insertions(+), 34 deletions(-)

-- 
2.41.0

