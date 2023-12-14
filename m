Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE543C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D4F287706;
	Thu, 14 Dec 2023 17:54:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=prolan.hu header.i=@prolan.hu header.b="EJ9G5meP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B867E87706; Thu, 14 Dec 2023 17:54:37 +0100 (CET)
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6DFE87706
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:54:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Csokas.Bence@prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain
 [127.0.0.1])
 by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 760AFA0B08;
 Thu, 14 Dec 2023 17:54:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :from:from:message-id:mime-version:reply-to:subject:subject:to
 :to; s=mail; bh=mv0zHx5T24nYeTNV/ugi2ngozr/6DOyPsEhkPy2ptMk=; b=
 EJ9G5mePx5DEfdSC4wwtpXIi3T2yH02jKLosNhk6TgvhKq1F1Gm/Q1ioImQlWvJu
 AzLfX8Wffjn+DfNZOJ3drGAGRVyB/D9GA7rOAwPoy1FTnSp87AXzdK0Tv5OHhUb9
 HvfA2iafy7YgOjc6lIFgiIuizhaCdQXMIl5CMdTIkeu9r0ZqkZMGNzE4mY9KEQOT
 vCIa90aZDpYNUjvIaIHomIx0yvEGR5Fncyg2xdYDKlUU+diepScgczF8oJDe/Ru8
 Gglmd3tdizhpxOvKV2hjFfnoWvTJcSQ9kxC+AIdJcIOoVMTZ4pt/5LwMRt9PzTJe
 ArpkkBs5DYnBROPEgnq0zMPUnwJuwBj4ER5XvtFjazGdKnn56apOpJZl8d9EEbsK
 ndO9CkPNn5aWNHMvyzOurNx7TevvVF+R+OVnrEa2AH4BUjmvav9GJugsOthi1Ljs
 t6aMjUHiwmZRZao69BBnWVIHBzsBzqouxv3TS2FTaN9hyEeZtduGpbeY4Gn8qsw5
 +EkfMm6iGol2OvuZeGRXu5SHO5YYPytCXtrVuSOFmOdpIYwlwfD/JTjivRwHpaY9
 STIZ8ECvDG3vdiKrRecc5fcthwrrqQmhhQGfxr+iXpvi74teyhWEHE3+v6vBb5Ic
 H9qa6SzkbudWIC0Xm8D6RU41W2+bpTbMUJCLKOTDaq8=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>
To: <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Haijun Qin <qinhaijun@eswincomputing.com>, 
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>
Subject: [PATCH] lib: rsa: Print detailed error info in rsa_engine_init() on
 engine resolution failure
Date: Thu, 14 Dec 2023 17:54:17 +0100
Message-ID: <20231214165416.35354-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK; S=0; OP=CALC; TIME=1702572873; VERSION=7966; MC=1667362346;
 ID=83671; TRN=0; CRV=0; IPC=; SP=0; SIPS=0; PI=3; F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29CE70385C6D7166
X-Mailman-Approved-At: Thu, 14 Dec 2023 17:54:56 +0100
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

Signed-off-by: Csókás Bence <csokas.bence@prolan.hu>
---
 lib/rsa/rsa-sign.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
index d20bdb58a5..0d67a80b82 100644
--- a/lib/rsa/rsa-sign.c
+++ b/lib/rsa/rsa-sign.c
@@ -317,7 +317,8 @@ static int rsa_engine_init(const char *engine_id, ENGINE **pe)
 
 	e = ENGINE_by_id(engine_id);
 	if (!e) {
-		fprintf(stderr, "Engine isn't available\n");
+		fprintf(stderr, "Engine '%s' isn't available\n", engine_id);
+		ERR_print_errors_fp(stderr);
 		return -1;
 	}
 
-- 
2.25.1


