Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD32E7716E
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 23:38:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 907BB8959D;
	Fri,  6 Dec 2024 00:38:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QfrziPLp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A72A389100; Thu,  5 Dec 2024 19:35:39 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C1BE8950C
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 19:35:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 11BB05C5E6C;
 Thu,  5 Dec 2024 18:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C59FC4CED1;
 Thu,  5 Dec 2024 18:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733423735;
 bh=NFIN77ZSdu76R2hQht1rdHGOicutB88LEt1e23u2/cI=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=QfrziPLpD2cCoFXhc9arjqf2CVMnmwkRWtbi9kPDjBDnKqPL4p6R0luCsSRMP2dEP
 2s3C+IsQAmX227e50pjfxszk7+59rYl4LAct84uR3iUlZleWTdTPi9JhXgo9EMCwsX
 DP31AYT3VUlxbr1l572eFmsILhu2jAHNRJRL0/gFeagpf27EjC9t6qGIUOLb2ag6ny
 +9aZR5tNqhA8MYXse5fgr4Bu7Wo2lqfHJGsFJBbOVADXZMTM5xfsLuGScqQbyj/iw+
 aNJDk8DjybsxcoPcIv2iw27jM4VjOmSoudKzU0pGuaskiSKOxrWqO/j16PpkmTyvNT
 Qffl4c6Qnna+A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 7C381E77173;
 Thu,  5 Dec 2024 18:35:35 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH 0/3] cmd: ufetch improvements
Date: Thu, 05 Dec 2024 19:35:32 +0100
Message-Id: <20241205-ufetch-v1-0-df861318bd49@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHTyUWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIwNj3dK01JLkDF1jI7NUc3PDJCOzxBQloOKCotS0zAqwQdGxtbUAPxV
 GdlgAAAA=
X-Change-ID: 20241203-ufetch-326e771b26ad
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733423734; l=597;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=NFIN77ZSdu76R2hQht1rdHGOicutB88LEt1e23u2/cI=;
 b=6g0ONJ0lmFX/lJYvRVOnkIpq9AHY87wtLqjrRpC2GutCLhXp2JLgjcyDwa5/oL/1AM7lAiEpS
 aTY9aHB4A+DCiGk0nfYczR1jSEkhBdUzNCg9O7Tc6kuTtWIoPPfHknN
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailman-Approved-At: Fri, 06 Dec 2024 00:38:21 +0100
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

Following the recent addition of the "ufetch" command, this patchset
improves it in a few ways.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
J. Neuschäfer (3):
      cmd: ufetch: Fix type mismatch on 32-bit
      cmd: Allow building ufetch without CONFIG_BLK
      cmd: ufetch: Show CPU architecture under "CPU"

 cmd/Kconfig  |  1 -
 cmd/ufetch.c | 14 +++++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)
---
base-commit: e5c1c2c6d9da79d874015f6d33fa2c7a34899733
change-id: 20241203-ufetch-326e771b26ad

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>


