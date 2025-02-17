Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43768C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 15:49:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B17180C8F;
	Mon, 17 Feb 2025 16:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WgYN3keR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 205B3807F1; Mon, 17 Feb 2025 16:48:58 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 808A38083C
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 16:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 77F94A4166A;
 Mon, 17 Feb 2025 15:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D3E4C4CEE4;
 Mon, 17 Feb 2025 15:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739807334;
 bh=Vbqt3KOb4chSAnlaTarptv5LOLGhmoTGufJULP+YovI=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=WgYN3keREwlqIoTz9l7feXmIDt5PkmR0s3KLXV7rXPQ9nN31yyhChVs25IvHcHnDK
 OpGopYVYE/KJWPosSit7t13A2dANJoFu4sY67lQsdWoLrp5jXEhhDVnLTFg0GQaNqD
 PPbH0+y4uc2DZt9bT5JFE9FJOmsNrmb9W15Uz9O4XRIKZMSj8T7pZRp9Q/d26GdkNg
 eE77C406gXGFZnjYdxxSANRVej1klgBSXMTI8DLQBkHby5K84CDuOppmGnzQZUJIWK
 Vkt2rZSR9C1LEmTZtZf5hyfNcrRVJXc/tYBKxUMX7abd+MNU0uQDPHAopzV7ljudy5
 tn34VC19bSqzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 130D5C021A9;
 Mon, 17 Feb 2025 15:48:54 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH 0/2] PowerPC MPC8xxx compile-time checks
Date: Mon, 17 Feb 2025 16:48:46 +0100
Message-Id: <20250217-immap-size-v1-0-f9be2e9e7b1a@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAF5as2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0Nz3czc3MQC3eLMqlTd5DTLNLM0AzNDY8tUJaCGgqLUtMwKsGHRsbW
 1ANbPozJcAAAA
X-Change-ID: 20250217-immap-size-cf9f6f06139e
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739807332; l=838;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=Vbqt3KOb4chSAnlaTarptv5LOLGhmoTGufJULP+YovI=;
 b=M8VYQwm4N1B06R829rzLytUXY1jBnflXswHipSxUMOA5jut+FwnF998BoXG28SdK6ORM/y7hw
 fchgTDCzhA6D436kcHNGPpWoVdAXwY7cMB6M6JtzrkYb+h6L1/Kvneq
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

This series happens entirely in the C preprocessor, catching some kinds
of bugs a bit earlier than they otherwise would. Everything has been
compile-tested, and there should be no change to runtime behavior.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
J. Neuschäfer (2):
      powerpc: mpc83xx: Check the size of peripheral structs
      powerpc: mpc8xxx_spi: Catch bad chip variants earlier

 arch/powerpc/include/asm/fsl_i2c.h     |  2 ++
 arch/powerpc/include/asm/fsl_lbc.h     |  1 +
 arch/powerpc/include/asm/immap_83xx.h  | 37 ++++++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/mpc8xxx_spi.h |  3 +++
 4 files changed, 43 insertions(+)
---
base-commit: 52ae6d8588ac8d96b7866ecb29029eff375c7171
change-id: 20250217-immap-size-cf9f6f06139e

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>


