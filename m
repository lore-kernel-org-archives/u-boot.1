Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4872DE9370C
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 13:10:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF8D586C3B;
	Thu,  5 Oct 2023 15:07:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A4YAdF+0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5409864DD; Thu,  5 Oct 2023 15:07:01 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51A3F86C7A
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 15:06:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 02EBC6192B;
 Thu,  5 Oct 2023 13:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1E2C3279E;
 Thu,  5 Oct 2023 13:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696511209;
 bh=fkYteOgBd7MlWnjlYNgHwNknS+j4WgTF2n/kMsvacQ4=;
 h=From:To:Cc:Subject:Date:From;
 b=A4YAdF+0HPR8tPYsy23YQobSt0wskcnkpjU0fdYr8PNwjmjrq3O+1w5RA+R7HbiJZ
 0+FTFj2Uh5wXA81eY4+M6mFs71n6Ky6MCqTH5WO12fyrXT6yE2kbdGIQUMPNd6i/gP
 52gKgTRXVuKCh+pQJ3Tcuo/N6whDifJ1zq60MOfpUed93+SX20Q0aQXb2kbDug+nSq
 VbItyGKFwVsnebBrm2KQbSvZAfemPSRG5G8X5nz8FBoM33Y5gd6swPwKufXtd9iIw5
 3nkC7HhlRdba8Ri5SeB3dQK/IaZarNAXBP0v2hC+KItp9KL5NrnlyF1VMQR/0lbEJm
 3IPeg3tQenFlQ==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com,
	nm@ti.com
Cc: vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org, jonas@kwiboo.se,
 srk@ti.com, afd@ti.com, bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 0/2] board: ti: am6x: Switch to standard boot
Date: Thu,  5 Oct 2023 16:06:40 +0300
Message-Id: <20231005130642.21402-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series switches am64x to standard boot flow.
Also minor fix to am62x boot targets.

NOTE:
Tested on AM64x GP EVM but I had to hand edit the grub.cfg
file provided with the TI release [1]

from,

menuentry 'boot'{
linux /Image root=PARTUUID=3a4a99a8-02 rootwait rootfstype=ext4
}

to,

menuentry 'boot'{
linux /Image console=ttyS2,115200n8 root=PARTUUID=3a4a99a8-02 rootwait rootfstype=ext4
}

else there is no console output.


[1] https://dr-download.ti.com/software-development/software-development-kit-sdk/MD-yXgchBCk98/09.00.00.03/tisdk-default-image-am64xx-evm.wic.xz

cheers,
-roger

Changelog:
v2:
- Added Nishanth's Reviewed-by for patch 1
- Dropped unnecessary headers and macro from patch 2

Roger Quadros (2):
  board: ti: am62x: am62x.env: Fix boot_targets
  board: ti: am64x: Switch to standard boot flow

 board/ti/am62x/am62x.env        | 2 +-
 board/ti/am64x/am64x.env        | 1 +
 configs/am64x_evm_a53_defconfig | 5 +++--
 include/configs/am64x_evm.h     | 9 ---------
 4 files changed, 5 insertions(+), 12 deletions(-)


base-commit: e29b932aa07fa0226d325b35d96cd4eea0370129
prerequisite-patch-id: afb49f33f198747451687f83936f039049365924
prerequisite-patch-id: 1d8297eb0a3b44d8578cae785cc22f0fb6077239
prerequisite-patch-id: 4ae9fdc0b3737e55289a78a59d546a08c03d62e5
prerequisite-patch-id: 2be0e0caf153bec2c453b2f21342ba207c1ee13d
prerequisite-patch-id: 7710703ce9a41b72ff3fb89abf0823625a5b5454
prerequisite-patch-id: 60d61440bf0ab8c0bea8b971ef18aa6d0d26e113
prerequisite-patch-id: c974e6d80489cbb0ee8cc1f3e19bcc9cf47f25b6
-- 
2.34.1

