Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5FAD72A11
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 20:00:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C6738948E;
	Fri, 29 Nov 2024 21:00:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DIWBnF8d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8514389463; Fri, 29 Nov 2024 20:42:42 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6BE089487
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 20:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BF3945C5D72;
 Fri, 29 Nov 2024 19:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66BBCC4CED4;
 Fri, 29 Nov 2024 19:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732909356;
 bh=JKnfMikZFUaNngsHvNQ5KPnjCYfTzWL0jeslrbo16ag=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=DIWBnF8d7ahESUwF8GePw3MGhpazu8yR1SfVwxiK9aoKEU127JKbDyPvUU6nWYugD
 yzPaMFtK8KArROxu6pWT5EcivbvK3udFtsn9MJ7rNy+iHc+4I+6XzTQFwKSRotGjJ0
 3Dy3NmArQoxVrvJMgTpULp+dDN88Q8d2bJ4KIc1BQZeZNsyZLOZu9EDNdbYtpII4tR
 z9DV4ZOOaQSupIhmU2qhC/z3u6c/Gs/kADfNDFzLQDRfk1rUwbCs4umnAMfOFCyUPO
 8fsV26pJJzKc0ycFM4tERsjSd4UboXAWBLxf4hl0vj81yWW5pQiR8fP30zxHRqw2CD
 9iKR+Sv8moauQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 562EED72A00;
 Fri, 29 Nov 2024 19:42:36 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 29 Nov 2024 20:42:29 +0100
Subject: [PATCH 2/2] doc: sending_patches: Fix spelling of "its"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241129-typo-v1-2-1ac3fef74eee@posteo.net>
References: <20241129-typo-v1-0-1ac3fef74eee@posteo.net>
In-Reply-To: <20241129-typo-v1-0-1ac3fef74eee@posteo.net>
To: Mario Six <mario.six@gdsys.cc>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732909355; l=910;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=NllmgewEy4nTBlFIvFRSMaSbrEZOxfKQ4ss3cfPTC7M=;
 b=uXNcpgdBHVzhYag0ONfx97vxOfolQihBOU9NuWId0wdJRZTbM+BnlK4panFKd7Y62j77Cf/IH
 ALsR4934vWqC6stO9w1slVPflUga7CKkbhLhusGhYSgqANUflVs9qbT
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

From: "J. Neuschäfer" <j.ne@posteo.net>

Although it has historically been different, the current standard
spelling of the neutral singular possessive pronoun is "its".

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 doc/develop/sending_patches.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index e22b5e3e244eac9f7e451781a380caba93f2ab17..ee6e34089b5b24b01b0ad30e142f80ae4a356089 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -377,7 +377,7 @@ The following are a "rule of thumb" as to how the states are used in patchwork
 today. Not all states are used by all custodians.
 
 * New: Patch has been submitted to the list, and none of the maintainers has
-  changed it's state since.
+  changed its state since.
 
 * Under Review: A custodian is reviewing the patch currently.
 

-- 
2.45.2


