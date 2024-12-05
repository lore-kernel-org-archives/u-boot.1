Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8FCE7716E
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 23:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7558F8955D;
	Fri,  6 Dec 2024 00:38:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="p4w1+Rrj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D276A8908D; Thu,  5 Dec 2024 18:22:11 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CADAE88606
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 18:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id C7391A43857;
 Thu,  5 Dec 2024 17:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77175C4CEDC;
 Thu,  5 Dec 2024 17:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733419328;
 bh=f2ux/V8xNZgEK2gqBw/kfuuTjC3cCGXXhFIW6/RaliQ=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=p4w1+RrjGicDt5nz/lVrnvofAQVoFBBBGA+0hSO36WcdQjpeMKnrf3R1qv3A3aFjO
 9lWx+Bi3TYSf8osLEvzNZgZebP6KmcB87Taf3QiZ5caE6mPHOo5Olhpi4H7SlqwVGg
 tCLQ3xrxU5Bln2j7yNlPwyBE7693vUTm0w5RGrdTUMH9k9JrmxMNjDDmOyiQELeqzl
 QFj2Vv2EcCCctgoufdNJg3lmAuX4laSNuBzLVEjb70vELQ5e4iqZgPSdi/1chqUPXM
 HnNrsJS1wiA8RytKL46Y1+3iGCHa8aH6g5ezUxDGyu5i6ycr3O3pfVB5bWA4qB2me9
 QWoUo2WOewXmg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDB5E7716E;
 Thu,  5 Dec 2024 17:22:08 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Thu, 05 Dec 2024 18:22:00 +0100
Subject: [PATCH] powerpc: Support using upstream devicetrees
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-upstream-dts-v1-1-5a6bf6ccdfc4@posteo.net>
X-B4-Tracking: v=1; b=H4sIADfhUWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyNL3dKC4pKi1MRc3ZSSYl3LRMPUJBNTI5MkU2MloJaCotS0zAqwcdG
 xtbUAubBqs14AAAA=
X-Change-ID: 20241129-upstream-dts-9a1eb4524b53
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733419327; l=934;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=+qRUMnidrcaVmH3kl29PIN2BKtB/G2mg7uQctbHVEAE=;
 b=ibfCqMCme5GanDlomhTRM2CqVWzEaU2whEVP+gcUAkGChO3h2Om8FLNRc3n0FmLunyopfCQ1X
 3WMc3TAE3ZLBYVgiowEKiaN81V9+P8imX7D+Gsb5cKBK7UFdu52pAP9
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

From: "J. Neuschäfer" <j.ne@posteo.net>

For new PowerPC developments, it will be useful to borrow devicetrees
from Linux. This patch makes it possible.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
This may seem hypothetical, but I'm working on a new U-Boot port for a
PowerPC board.
---
 dts/upstream/src/powerpc/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/dts/upstream/src/powerpc/Makefile b/dts/upstream/src/powerpc/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..721ec5cb229e2a8ae57e90c9407f86054fcb7ad9
--- /dev/null
+++ b/dts/upstream/src/powerpc/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+include $(srctree)/scripts/Makefile.dts
+
+# Add any required device tree compiler flags here
+DTC_FLAGS +=

---
base-commit: 98dd010b311e68b8398428cadf56a6381f7de202
change-id: 20241129-upstream-dts-9a1eb4524b53

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>


