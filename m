Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5612E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 17:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40BB6801BF;
	Thu, 12 Dec 2024 18:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EKb0IgQX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B6ED80200; Thu, 12 Dec 2024 18:06:02 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAF05801BE
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 18:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id A91DBA42961;
 Thu, 12 Dec 2024 17:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B28EC4CED0;
 Thu, 12 Dec 2024 17:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734023158;
 bh=ZcU6uQ7ejaFY/D4tPICQRF7swS4pWua3gbeiw/SjWxs=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=EKb0IgQXcneeTRSB7a4zzoOIgCiQJvvuz5hlcwT4PduyHS7GmYutp05x9kkbhALMI
 PYAJa5SaA0nZs/gmk+irevkPtgBHwCCw5pQy+cTTx0Fd2XiviOZzNpNzR6R99ZQtZt
 wfBfpCkJBQcqBm3a4iwZbu890DqaTS+m4JdX2WgXhtAe+2CKI9JVeKTfOBXb4Pk9Iy
 pOfAxmY4KMeqW1z2D2KNXu6CZ3AAQe10edr9pa2tpEB2aLGdEL0VeY5ff/HhKb5gr9
 iUG8/TPO6OeTMwc3OMhsnfhrpgQIa8v10bFFqbSVM4vwr4KTl+G06FVM5kFPipoiY+
 cAk8OvDzz2lng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAB6E7717F;
 Thu, 12 Dec 2024 17:05:58 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH 0/2] powerpc: Fix and enforce distinction between
 immediates and registers
Date: Thu, 12 Dec 2024 18:05:45 +0100
Message-Id: <20241212-gpr-checks-v1-0-8c084c5fc0b6@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOkXW2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyNL3fSCIt3kjNTk7GLdlFQDA7OUlEQLQ8skJaCGgqLUtMwKsGHRsbW
 1ANxExHNcAAAA
X-Change-ID: 20241129-gpr-checks-de006dda819b
To: Mario Six <mario.six@gdsys.cc>, Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734023157; l=882;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=ZcU6uQ7ejaFY/D4tPICQRF7swS4pWua3gbeiw/SjWxs=;
 b=Fcgm6nOpVyMcjFy4P3CmkabP9WqMwwfBrNAn7qU8IVTpQQNNvYOG+loXXnjEFIthxY1lyMc/O
 FS33e0/s4clA5gug0I7sErGOOT8yTlefokWKHtBY0I7YaPjgvo6O1zq
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

This patchset changes the definition r0 etc. to %r0, so that the
assembler can check that registers are only used where expected, and
fixes the fallout.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
J. Neuschäfer (2):
      powerpc: Fix 0 vs. r0 confusion in X/D-form instructions
      powerpc: Introduce and enforce assembler checks on GPR usage

 arch/powerpc/config.mk           |  2 +-
 arch/powerpc/cpu/mpc83xx/start.S | 72 ++++++++++++++++++++--------------------
 arch/powerpc/cpu/mpc85xx/start.S | 24 +++++++-------
 arch/powerpc/lib/ppccache.S      |  6 ++--
 include/ppc_asm.tmpl             | 66 ++++++++++++++++++------------------
 5 files changed, 85 insertions(+), 85 deletions(-)
---
base-commit: a75acb55442302aeaca993a5c4337fd130766e58
change-id: 20241129-gpr-checks-de006dda819b

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>


