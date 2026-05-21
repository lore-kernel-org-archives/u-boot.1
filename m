Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADCDCD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 19:11:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DA8E8488F;
	Thu, 21 May 2026 21:11:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=joggee.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=joggee.fr header.i=@joggee.fr header.b="ASM7ejLw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 131EA8484F; Thu, 21 May 2026 21:00:43 +0200 (CEST)
Received: from 19.mo583.mail-out.ovh.net (19.mo583.mail-out.ovh.net
 [46.105.35.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D16984825
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 21:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=joggee.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jonathan@joggee.fr
Received: from director4.ghost.mail-out.ovh.net (unknown [10.110.37.89])
 by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4gLyRC6wfjz5xpg
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 19:00:39 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-4ft52 (unknown [10.111.182.135])
 by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 3BFC7C2A68;
 Thu, 21 May 2026 19:00:39 +0000 (UTC)
Received: from joggee.fr ([37.59.142.96])
 by ghost-submission-7d8d68f679-4ft52 with ESMTPSA
 id wruYAFdWD2qqaiMAClDBow
 (envelope-from <jonathan@joggee.fr>); Thu, 21 May 2026 19:00:39 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R0012185d859-2ab7-4e06-a106-33e26f87c109,
 7537AC38F3606E29215488AFC0DC1D9DB0F104A7) smtp.auth=jonathan@joggee.fr
X-OVh-ClientIp: 83.204.164.57
From: Jonathan GUILLOT <jonathan@joggee.fr>
To: u-boot@lists.denx.de
Cc: Jonathan GUILLOT <jonathan@joggee.fr>
Subject: [PATCH] doc: wdt: fix typo for expire
Date: Thu, 21 May 2026 21:00:11 +0200
Message-ID: <20260521190011.32751-1-jonathan@joggee.fr>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 6221441414526419779
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFJLwp17keD3KFchNULlRipV5lLvtvl28FpAl1qQNcPHQHLWBeppRi5xvbLMmiBR22vosgg+DH8Wa/0I8cM9cHRjwiDooLLM6ZffyZCzJSAn2Rsz5DJdPcgn20RHkZu581JOWkaqEKYYE8UCPSFck8EOmdqH7TNfXM6v0dzJnEJ49UCPRmJnYvsRYU4ja2X/HZ4XjCBMuSQo8/4BGMUtApOv5zRzravNgrrlt7KrCqZDXq8pJ7GjnArysYsni/pSx46tyVrTr8Qvlc3c0eEWXWEYs16JMJKF64SBU7LYfddAchAPSbRKq42lJXDyVJwh+7zS24yA5XKca2DpGNjqGvhiLqHF14ml6XLLVmVgtpqPIBYXX9Toi2QwX0U/NLNHk+/DXOTtv3VfUbvYTil8axPQuLnHNX6rUFFWx/CRJ2RRv9YuFU9kYt/tlXJzVCO4wYsQaGI4cjX1aB5utjMufISI0+/Y3VgNSiqq48Ab8AlHTA3Pn3PpyJynhUCnIMtPo6PaXjIUbVKOsQtFCwxQfV+drUGRZ4C5CEausHarZEw4bykj/sgEj+l0GbMfW0WN7AlDIcRrt3zNj0FIB9/D3Zkz2PznaLwxDkgh8gPxymu7UbMkoWEwL33feMsQ9qQd6/RI3jyrGanJ+sU4qXwXY40mD9JdRNAwb4zSiI0wpzSCg
DKIM-Signature: a=rsa-sha256; bh=HdaA4lJR2MiqL5KUG4szzARaa3ng3JxKiv9EUZkRWJk=; 
 c=relaxed/relaxed; d=joggee.fr; h=From;
 s=ovhmo4398017-selector1; t=1779390040; v=1;
 b=ASM7ejLw4ew6Gv1SrqcRj4PxLtcpMFOiAHstntQQVDIZSuWcV6aYBoaeDMrv9Vmf9qEXma+r
 861IIzGfrLvAIsSCCABljWa383kBjBTioFO0W4Gfr45tzBnQQxVMCLo3Q1xiZw+rfrtG20egg82
 W7y7OvIDO3aP054L3F/kJ1mgpUNvy/JL8yXV5xFqohvvnArQX5glguZSJ7RZJi34wElUv3VeO/y
 9HJ4Kt3xT2PyioLA1UbqyORS4zhqSFIMkZXVpfXObTjkJ4lhouWdPJKLtHArkdgx4nOYeUJJdME
 ZIz2VCyeNQT2YysLxS46ygCneNnLJiEQZ8sf9Ue135O2g==
X-Mailman-Approved-At: Thu, 21 May 2026 21:11:12 +0200
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

---
 doc/usage/cmd/wdt.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/usage/cmd/wdt.rst b/doc/usage/cmd/wdt.rst
index 711b74d20da..28abf98def9 100644
--- a/doc/usage/cmd/wdt.rst
+++ b/doc/usage/cmd/wdt.rst
@@ -16,7 +16,7 @@ Synopsis
     wdt start <timeout_ms> [flags]
     wdt stop
     wdt reset
-    wdt expirer [flags]
+    wdt expire [flags]
 
 Description
 -----------
-- 
2.54.0

