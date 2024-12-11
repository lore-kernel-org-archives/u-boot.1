Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2DFE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 22:26:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6E5680212;
	Wed, 11 Dec 2024 23:25:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="s2KbFsoE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E3AD80192; Wed, 11 Dec 2024 23:25:53 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A931C801DD
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 23:25:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C86E75C67D2;
 Wed, 11 Dec 2024 22:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15988C4CEDD;
 Wed, 11 Dec 2024 22:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733955949;
 bh=IfwXNrjStpdZHnvc7viDk+ybbinFcvPASWXbh4NRW/Q=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=s2KbFsoEYx+uaN+AgMi3J7mbrbIjcGkAL5/H96QZJKd/N6EA1wXZPu1fQkeNr5w4t
 kXT3i5rxm+e8zF72xU5WAmz/B9UHoZ0zT4UCDRZykLFYBJaHhUhaO7x08bUlky/YK/
 H5fSrtY5TpyKKNO/tDG95EjOpI+wf4BUApobvjosdgIgdB+I7QctRvqnAVz7d3+Sjj
 isqRJ73ZLUSuVawmKa6LdXHDSYL8JBYrNgyZ7CYl4pvA+nw09jsavL+CgxBd6O74wW
 irb5O9xpPPtqjNb3mAeu8SWR1mHOYO3C/lZnKJ8PxeYVBHIj8rH60zier32OVGJk0y
 vzFJS9WXTYnEw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 03A79E7717D;
 Wed, 11 Dec 2024 22:25:49 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH v2 0/3] cmd: ufetch improvements
Date: Wed, 11 Dec 2024 23:25:24 +0100
Message-Id: <20241211-ufetch-v2-0-2b5432ffaeb1@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFQRWmcC/zXMQQ6DIBCF4auYWZcGRovWVe/RuFAZChswQEkbw
 91LTVz+Ly/fDpGCpQhjs0OgbKP1rgZeGljN7F7ErKoNyLETyFv21pRWw1qU1PdiQTkrqOctkLa
 fA3pOtY2NyYfv4WbxX0/idhJZMM6UHqRoxbCo7v7YfEzkr44STKWUH9ZnNpudAAAA
X-Change-ID: 20241203-ufetch-326e771b26ad
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733955947; l=758;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=IfwXNrjStpdZHnvc7viDk+ybbinFcvPASWXbh4NRW/Q=;
 b=PeO/m15lNwKB+vXxaPSAVnPoDbKplLmdFhSV6sXSECDDwNnPXxo3fu3V9uzBCkVLo9TBzdKfH
 j29thTTuWNKC+PPw2ZtDlApINg41E/GPjprjICQTApC6pX8dxxs4p2E
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

Following the recent addition of the "ufetch" command, this patchset
improves it in a few ways.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
Changes in v2:
- Address comments and add R-b tags from Caleb
- Link to v1: https://lore.kernel.org/r/20241205-ufetch-v1-0-df861318bd49@posteo.net

---
J. Neuschäfer (3):
      cmd: ufetch: Fix type mismatch on 32-bit
      cmd: Allow building ufetch without CONFIG_BLK
      cmd: ufetch: Show CPU architecture under "CPU"

 cmd/Kconfig  |  1 -
 cmd/ufetch.c | 17 +++++++++++------
 2 files changed, 11 insertions(+), 7 deletions(-)
---
base-commit: a7efabf75cc7a31bc0c9dc8a1509a788ade238bc
change-id: 20241203-ufetch-326e771b26ad

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>


