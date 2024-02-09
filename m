Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2298AC4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 12:05:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9418F87E6F;
	Fri,  9 Feb 2024 13:05:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="v/Srt/eT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/Md4RQIT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC7B787E39; Fri,  9 Feb 2024 09:07:00 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42CC287B6B
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 09:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t-8ch@linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1707466016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bvdmW6q709wJFBBDAfM690NM/U3MES6+aHC5TrmX6uI=;
 b=v/Srt/eTjuFatwMoOf/SDoyLE4EcNMAnBfXCqiBPveL1U/x8pgcilH3sT7BNhIcMYq137V
 3T0VRBd5pZeCAbsvflv1ziEKPlJQmmOPXpLF7NoXJOhgqN11WbgXJzW/5lwxYbUuIbECV8
 V+YhFApfr82KFVQKckan/453bdPhfXdSow1h1zb2Mu3wownCHaVUGjNH6em9/BOXlWdR7d
 Rcw45QA6IuHbxTcYrLjivo5HkTh+klfRihsTKa2YZfTz4wQdEmBjURI1hL4KFK2Ve5nNRf
 mFDv4qItrhoAHulLoAj0IXBsy4xHMSn/dKpZpIyj9vElvuSzttRGWBfS7iDgOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1707466016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bvdmW6q709wJFBBDAfM690NM/U3MES6+aHC5TrmX6uI=;
 b=/Md4RQITHese9Atf3/6nnLgto+pWdsnuSs2jiPDz7E81dS+4LfgxB53HtmtBj5/LCNWtVi
 QP7GX9OWMNDHJzDg==
Date: Fri, 09 Feb 2024 09:06:53 +0100
Subject: [PATCH] configs: am64x_evm_r5_defconfig: enlarge simple malloc
 pool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240209-am64x_evm_r5_defconfig-malloc-simple-len-v1-1-4a779a8bd557@linutronix.de>
X-B4-Tracking: v=1; b=H4sIABzdxWUC/x3NSwrDIBRG4a2EO66gxqaPrZQi1vymF3wEhRAI2
 Xulw29yzkENldHoORxUsXHjkjvUZSD/dXmB4LmbtNRGavkQLk1mt9iSrVc7I/iSAy8iuRiLF43
 TGiEisvgojJO53WFGRT23VgTe/6vX+zx/lg/9RXoAAAA=
To: Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Benedikt Spranger <b.spranger@linutronix.de>, u-boot@lists.denx.de, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707466016; l=1016;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=qX5prAOrhOw7tfSgYQByCGqWBDqd3mv6O3OyuqFBv50=;
 b=hgII6okcUBihO2BhwQlhN6yHrNlvb+Oay4Vx7RK8Z7RCtUPkCAeFkK3IPduChpYbRfsCBXPWV
 GldLmaMajj/AEab4AzNDPEF0EG6wGCjdSIQFGz6WeiIURkUKbEd2d1Z
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Mailman-Approved-At: Fri, 09 Feb 2024 13:04:59 +0100
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

With the default size the stack grows into the malloc, pool leading to
stack corruption and boot failure.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Note:

Maybe this should be increased for a broader set of devices.
---
 configs/am64x_evm_r5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am64x_evm_r5_defconfig b/configs/am64x_evm_r5_defconfig
index 56df6a4a19..707fe506f3 100644
--- a/configs/am64x_evm_r5_defconfig
+++ b/configs/am64x_evm_r5_defconfig
@@ -42,6 +42,7 @@ CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_STACK_R=y
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x400000
 CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y

---
base-commit: a4650bf65e4b7d3ef04c90ba8031374428e4a682
change-id: 20240209-am64x_evm_r5_defconfig-malloc-simple-len-b1e36478e431

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

