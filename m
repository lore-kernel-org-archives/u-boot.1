Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CFECDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 13:30:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5745084894;
	Thu, 25 Jun 2026 15:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="J65TR8Tr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6674884949; Thu, 25 Jun 2026 15:30:37 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C71BC847C8
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 15:30:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id B4C18C5CD50;
 Thu, 25 Jun 2026 13:30:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 17FD45FF03;
 Thu, 25 Jun 2026 13:30:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8556E104C9730; 
 Thu, 25 Jun 2026 15:30:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782394233; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=NX3rZmKBSdBjwznaF9TV5SeSBTyR0Gul4UgV3afPMvk=;
 b=J65TR8TrrTaetxOdSc78IK4Ed5yL+YvtS23aYQ5YYB1tasLpBghUUZT13EuhtACQls9Kse
 XGDtTEo5Fdsv/jxV714O8LVjVJXGsK45HXRRoEIM/OgWmph00+sU1qr51MY+8aMEAwZOtJ
 ZF33tw0x6G9MA56FApoYRvyNxNtNA9M5hSoPZBq5vgNCGOcoAsCOuPb0dLs8GsRSBYm6ED
 9yNUHFEUiufXFOCPDWgSQk53TupnERjbHTI5sv5Et4EkeEk3E1GlPaKNg0293x46SWsw0Y
 8xZ1a6/VrsU4KG0Idqk8dd2BaPqdDXW8X9JZm0h6SQZAbgU/M4ZwarHTJ0TuNw==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: Andrew Davis <afd@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Beleswar Padhi <b-padhi@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 "Richard Genoud (TI)" <richard.genoud@bootlin.com>
Subject: [PATCH] remoteproc: k3-r5: Fix crash when issuing rproc init
Date: Thu, 25 Jun 2026 15:30:06 +0200
Message-ID: <20260625133006.365756-1-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
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

Prevent NULL pointer dereference with lockstep mode.

Since commit 21d03d60e909 ("j7200 defconfig: add rproc commands"),
issuing rproc init command with cluster configured in lockstep results
in a NULL pointer dereference.

This is because ti_sci_proc_request() is called on both cores on the
same cluster, without checking if they are populated.
To fix that, only request the core being probed, as there is no need to
request the other one.

Moreover, the old code was requesting both cores in lockstep mode, but
only releasing one:
it called k3_r5f_proc_request() with ti_sci_proc_release(), instead of
using k3_r5f_proc_request()/k3_r5f_proc_release() or
ti_sci_proc_request()/ti_sci_proc_release().

So, replacing k3_r5f_proc_request() by ti_sci_proc_request() restores
the intended behavior.

Fixes: 21d03d60e909 ("j7200 defconfig: add rproc commands")
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 drivers/remoteproc/ti_k3_r5f_rproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
index 7326f5a4b30b..c5810dd0994a 100644
--- a/drivers/remoteproc/ti_k3_r5f_rproc.c
+++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
@@ -861,7 +861,7 @@ static int k3_r5f_probe(struct udevice *dev)
 			return 0;
 		}
 
-		ret = k3_r5f_proc_request(core);
+		ret = ti_sci_proc_request(&core->tsp);
 		if (ret)
 			return ret;
 
-- 
2.47.3

