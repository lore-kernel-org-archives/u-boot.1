Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1BCC19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 18:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8899B806FC;
	Sun,  2 Mar 2025 19:31:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740940306;
	bh=k/unDTP03msACCA9keNWGBV9LlBQ2P6b6HoB3g8ICrs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PIg/iVf62cqAMCO5pGNjNki61AgAjuRP7Qd54noHBwZV+IWrsLWnKWsSxcN2jEoUU
	 QWKS5g1Dhxeo8+V+JY+tTTIpO/hXNMheUm+Awd0GNsIgyCZAeJMfNuPOnm9GcIY3uv
	 eAMoZlx5oSKZ1ITHyWFuFW9IW9ZbwDfjRyizzEp0gZ/VqbPBd1qbokFIResT7PsD9V
	 441ir3LqId5JQIbrHjFpDmG6Y44DaM3CNeJ3zktTyyAgaOPXmpTw99nKSBhawxsvA0
	 RzRxi7rN+JC41J89VzSwQQha1itPWV+cnYdyP32VixoCEDmlp+aiAw+PH0VVO2w6pB
	 7hkyCwYReKjeQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FB93807B1; Sun,  2 Mar 2025 19:31:45 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32AC88058A
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 19:31:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="MYuY8C8N"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DDEA210382D03; Sun,  2 Mar 2025 19:31:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740940302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=k/unDTP03msACCA9keNWGBV9LlBQ2P6b6HoB3g8ICrs=;
 b=MYuY8C8NMokERtFyiQvW0WSWuQDGhic8uQGAkq+wxIAz2uf/Vgu35ikQQmA6FXz4DOmskn
 ZzHkePUaFFdgAPImDxntXhfYDFIOkBR4k5yUJL0ZJrAU1gkQrL5v1YpSPRjQCRY6O5now0
 8o96HKD+r8Yuu7p9smdMi6VmRaWszaw30Vfa19YWBCumBj68/cDdfaDxKQeoyuF6fKrJaQ
 0+9810R9VM8dvh2dD0nQLusSCSpbTUISgmylLXUmUV7JPDZQ7MGLM2FRV4q7iAxavJy0Nl
 I6tCGAkwqEAqq+5U/+SC2L23co8ut2L9ciGGSSOTkgHJBZvEsHVOPcwG0pfkQA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] scripts/setlocalversion: Reinstate .scmversion support
Date: Sun,  2 Mar 2025 19:30:28 +0100
Message-ID: <20250302183128.326418-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The .scmversion is used by oe-core to append U-Boot version string.

LOCALVERSION is not fully compatible replacement as it adds trailing
"-dirty" string at the end of version string in case the U-Boot git
tree contains uncommitted changes. This behavior itself is correct.
However, OE builds do clone U-Boot sources from git and may apply
additional patches on top, which are not tracked in U-Boot git tree,
but rather in the OE metalayer git tree, which leads to the addition
of "-dirty" string as well.

The .scmversion used by oe-core used to replace the version string
suffix fully, including the "-dirty" string. Reinstate support for
the .scmversion to let OE core do exactly that as it used to do it.

Fixes: 5c02350fa03d ("scripts/setlocalversion: sync with linux v6.9")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 scripts/setlocalversion | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index dbe048210d6..26d121816dd 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -48,6 +48,10 @@ scm_version()
 	done
 
 	cd "$srctree"
+	if test -e .scmversion; then
+		cat .scmversion
+		return
+	fi
 
 	if test -n "$(git rev-parse --show-cdup 2>/dev/null)"; then
 		return
-- 
2.47.2

