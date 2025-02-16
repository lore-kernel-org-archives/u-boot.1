Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F19CC02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 21:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6E29807E1;
	Sun, 16 Feb 2025 22:18:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l+hyu3d5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7F1780F10; Sun, 16 Feb 2025 22:18:17 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC2488056A
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 22:18:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B5124A40F3B;
 Sun, 16 Feb 2025 21:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67E0BC4CEDD;
 Sun, 16 Feb 2025 21:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739740694;
 bh=ocAAKkpNeD1R37ZlvXCW9INUlqN8UcuGOX/TcPPNr8k=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=l+hyu3d502D7JxpHV3nbAricYDapFjMiukqmsEFbwRp9mSvjNcifKDzksk0Gfq/h8
 asb+cA+TywNhgiajMmbvnwC/4CHILQ0BL8dUY0qElzOB1yGPvdHSdcUgBtkjh2bDVy
 tIy0tVoRwYXQ6Q+wqvgWxa8aIKKAh0wCO4iWO9UMTzEA4wT8sqKcAhMtJfAAZzIBE2
 yEZ71CKUISfHIcq/1lMRk4/23s7lFZaTzJy3kjqFV0QbBRDWjslR/aOtzavYuZ9A/O
 GK6bWHvnf5v/hi4zDyQXm2d+e0iAXw3yeGkHsAfgaXtegRSmKD7aTbk0IZkEIDsi/0
 nlVvVQp2haHsQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 5622AC02198;
 Sun, 16 Feb 2025 21:18:14 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH 0/2] net: tsec: Improve receive error path
Date: Sun, 16 Feb 2025 22:18:11 +0100
Message-Id: <20250216-tsec-v1-0-9a704bedd048@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABNWsmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0Mz3ZLi1GRdo8TkFDOjJMs0CxMTJaDSgqLUtMwKsDHRsbW1AD/iLYp
 WAAAA
X-Change-ID: 20250216-tsec-2acd62b9f844
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739740693; l=603;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=ocAAKkpNeD1R37ZlvXCW9INUlqN8UcuGOX/TcPPNr8k=;
 b=ll7CbA5opicZYcLkskJDYE/Th5a0ezXbI/xinvVGwPuYReZ5d95IR6G199JDmRWwSBjEty9oo
 x7Rya2I5U97DZgWSU/f+Bye64K5xJvnh+Wl59LGc2/oRHVDu30f6IHt
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

Currently, errors in the receive path of the TSEC Ethernet driver result
in an exhaustion of packet buffer descriptors. This series fixes it.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
J. Neuschäfer (2):
      net: tsec: Reorder tsec_recv and tsec_free_pkt
      net: tsec: Re-arm packet buffer in error case

 drivers/net/tsec.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)
---
base-commit: 5919f48b1c751b85453adca96493ab16f9098be0
change-id: 20250216-tsec-2acd62b9f844

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>


