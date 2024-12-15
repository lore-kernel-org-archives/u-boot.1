Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F642E7717F
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 15:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4532800D2;
	Sun, 15 Dec 2024 16:18:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NWR3xl7K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B495780066; Sun, 15 Dec 2024 16:18:30 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB9CB8005D
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 16:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3541A5C4230;
 Sun, 15 Dec 2024 15:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25965C4CEDD;
 Sun, 15 Dec 2024 15:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734275904;
 bh=BmfkDjizKG1+Buafa1ZtSkt5nDBG5cY8Hi2KaFJVx+U=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=NWR3xl7KAuwzY1raV57Jot6DoTe1qRpuiN+i6tF+M5CVbSDNShDGv62ngh40VcPAj
 IvhPwJkcMiqYRP2Ox3JCXg6qEsmga1qjZt413ocKhmc6HtD7Q7T5FJH/GFJjo5rY4V
 Y6nJ6srqJoVC1xNItNMJhLslE8XI1n4MRK3NhPsUob8zm7ljCog4nmOb9Ax4yYhj6b
 EYxFZWjwW3M6vZ2V/loWay8u+lTztRfFR/r+NNBX8++RqxO8ObycjEswac02tNZJlX
 evQWtUbfxLgIT4shdZb2GvGq3JrVtlElLogvW0uC25e0ECj8R149HHI1jmLM3VulfH
 I+60q0VgNoTIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 0C579E7716A;
 Sun, 15 Dec 2024 15:18:24 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH 0/4] Misc. PowerPC MPC83xx fixes/cleanups
Date: Sun, 15 Dec 2024 16:18:12 +0100
Message-Id: <20241215-mpc83xx-misc-v1-0-8cd6daae4f93@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADTzXmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIwMz3dyCZAvjigrd3MziZN00E2OLNPNUA1OTFAsloJaCotS0zAqwcdG
 xtbUA9Ox/jV4AAAA=
X-Change-ID: 20241206-mpc83xx-misc-f438f7e054d8
To: Mario Six <mario.six@gdsys.cc>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734275902; l=843;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=BmfkDjizKG1+Buafa1ZtSkt5nDBG5cY8Hi2KaFJVx+U=;
 b=rTjv5iYzT/+KOIXi4nlFtyufgqv5Ob6HdAXlFkMmWzP9Px5IbsAxqk2jKpOHsIL4Ahl+SZEMi
 H80K8IbMcF5AUzqRnnA9kIiGloOI0sqWrLCwVzyRfOggn1F3d6mSIml
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
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

This patchset contains a few small fixes/cleanups for the MPC83xx
platform.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
J. Neuschäfer (4):
      powerpc: mpc83xx: Fix timer value calculation
      powerpc: mpc83xx: Allow including initreg.h into multiple files
      powerpc: mpc83xx: Use defined constant for SPCR[TBEN]
      gpio: mpc8xxx: Preserve pre-init state of outputs

 arch/powerpc/cpu/mpc83xx/initreg/initreg.h |  8 ++++----
 arch/powerpc/cpu/mpc83xx/interrupts.c      |  3 ++-
 drivers/gpio/mpc8xxx_gpio.c                | 12 +++++++++++-
 drivers/timer/mpc83xx_timer.c              |  2 +-
 4 files changed, 18 insertions(+), 7 deletions(-)
---
base-commit: 9bc62c980d418f0a67632ab29cd3501072cdb6f0
change-id: 20241206-mpc83xx-misc-f438f7e054d8

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>


