Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A04E7B60F
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 13:23:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B22787056;
	Wed,  4 Oct 2023 15:23:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lgjdKlvH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D505586ECA; Wed,  4 Oct 2023 15:23:35 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9649686679
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 15:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 2FC4BB81CB1;
 Wed,  4 Oct 2023 13:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61F3C433C8;
 Wed,  4 Oct 2023 13:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696425812;
 bh=Cs49wLfWry1gUJz3zmbnz/n3dTtUCCiCZN1xN6bowL8=;
 h=From:To:Cc:Subject:Date:From;
 b=lgjdKlvH5tnTjg6gfYUX1ca0UoWoZ9DtiySt9yc4xngcQV2LoJ678vdogjHraI00i
 6oovdpHNAR/ctjNT72jB9e5+DKYTajaUkoAjV5CzGYQJBIGo9jXsMIJaL1+xWtdzLl
 622u9sYUtp9kxkiqx5pwuumCpU/HgBA65js7amJYlL2r+Xnz/td6RoGZWiDzpoVlnO
 ux4xxLL1W2yNnNp4r4PthB7BohGmh/c15c+O7Jru1FbptBMZEdJojrX/bn+YDrxNLs
 zi7pocEoK/2FGCec9jH/alco5O9y3xLzftzNH2dJeYIEANRLMnfkL960lq9C70h1dr
 1lpPUjcjBE9aA==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com,
	nm@ti.com
Cc: vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org, jonas@kwiboo.se,
 srk@ti.com, afd@ti.com, bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 0/2] board: ti: am6x: Switch to standard boot
Date: Wed,  4 Oct 2023 16:23:22 +0300
Message-Id: <20231004132324.44198-1-rogerq@kernel.org>
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

Roger Quadros (2):
  board: ti: am62x: am62x.env: Fix boot_targets
  board: ti: am64x: Switch to standard boot flow

 board/ti/am62x/am62x.env        | 2 +-
 board/ti/am64x/am64x.env        | 1 +
 configs/am64x_evm_a53_defconfig | 5 +++--
 include/configs/am64x_evm.h     | 2 --
 4 files changed, 5 insertions(+), 5 deletions(-)


base-commit: 90c81f407dd4a7747385b10f9b8f732202c45cde
prerequisite-patch-id: afb49f33f198747451687f83936f039049365924
prerequisite-patch-id: 1d8297eb0a3b44d8578cae785cc22f0fb6077239
prerequisite-patch-id: 4ae9fdc0b3737e55289a78a59d546a08c03d62e5
prerequisite-patch-id: 2be0e0caf153bec2c453b2f21342ba207c1ee13d
prerequisite-patch-id: 7710703ce9a41b72ff3fb89abf0823625a5b5454
prerequisite-patch-id: 60d61440bf0ab8c0bea8b971ef18aa6d0d26e113
prerequisite-patch-id: c974e6d80489cbb0ee8cc1f3e19bcc9cf47f25b6
-- 
2.34.1

