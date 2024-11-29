Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FD1D72A11
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 20:00:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8120E89411;
	Fri, 29 Nov 2024 21:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UAfddUUD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 825F98948B; Fri, 29 Nov 2024 20:42:40 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70A7B89463
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 20:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BA1925C0540;
 Fri, 29 Nov 2024 19:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C31BC4CECF;
 Fri, 29 Nov 2024 19:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732909356;
 bh=5p1ZuMH4hjGy0QxNBSAhRF0kND0CdqEMCGSoiIiObDY=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=UAfddUUDIAcUgkOW2nPFY5ObOeOvBmDeNFiuK+uhojDexZrQGagtXZj5X51isb85m
 yiGpWzrbiFyg/3hJ+D816QhGTSmpnyhQt31wm5siSs5/E3yFBC1efqsKfgZfMB7utY
 61b6k0q5+zI8UOipqO1vP1M4xw4g2jpEEr3oriRBmSJUJBDBMgsggPhWkbmDmG7YOl
 rF/CVDn8iFT2wjMU8YA8a67N97SSoYmZ+JvF8rs37f6NFRr5zHW+otZ0FtRSOFrqKu
 WFqYblZ/3k7vfxa7eE+yjGSCNVgKK7VfuALxSzXZ69y0u0KHUlDwlhf9X+oy8gY7u5
 fZs00/cDpnBDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 3600FD729FE;
 Fri, 29 Nov 2024 19:42:36 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH 0/2] Minor typo fixes
Date: Fri, 29 Nov 2024 20:42:27 +0100
Message-Id: <20241129-typo-v1-0-1ac3fef74eee@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACMZSmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyNL3ZLKgnxdyxSTFJNEC/PEZLNUJaDSgqLUtMwKsDHRsbW1AFt66id
 WAAAA
X-Change-ID: 20241129-typo-9d4d4a87ac6e
To: Mario Six <mario.six@gdsys.cc>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732909355; l=519;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=5p1ZuMH4hjGy0QxNBSAhRF0kND0CdqEMCGSoiIiObDY=;
 b=a3E0EblwADltd9wOWEAmEirDDjTsCVKYSoLVvmqAL7uuP8Kz2LfHIrhHm1di94w79HSQtZfE/
 5+LeV3JfetJAFN1lAsprMqW++5VFc69wF5v7veQoiJhsI7/e9Mhh6xd
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailman-Approved-At: Fri, 29 Nov 2024 21:00:21 +0100
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
Reply-To: j.ne@posteo.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This patchset includes two small typo fixes.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
J. Neuschäfer (2):
      clk: mpc83xx: Fix typo in "Coherent System Bus"
      doc: sending_patches: Fix spelling of "its"

 doc/develop/sending_patches.rst | 2 +-
 drivers/clk/mpc83xx_clk.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 62224280d9e89648ae90346c0aede76f9b7e7610
change-id: 20241129-typo-9d4d4a87ac6e

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>


