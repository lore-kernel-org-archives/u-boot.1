Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25975F5544C
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 03:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 727A683D8A;
	Wed, 25 Feb 2026 04:21:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Pep/J7wk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 439F583D8A; Wed, 25 Feb 2026 04:21:29 +0100 (CET)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27F1B83C39
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 04:21:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ronand@alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id ECA9A2C044C;
 Wed, 25 Feb 2026 16:21:24 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1771989684;
 bh=lrbXjXa8+idpekCP0bZcCPsFQofj0ljKjtJVZa1gA0o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Pep/J7wkJguytAIgxaAa81ukEvv79odo87zKScXJVkhQDE5maHR3lAS/nSeGCjkgm
 Ky//e9XR6MXBJuidj9rSuaQWcvs1gkH0g76VayiM2iz6DkPFZitNh8RxYwRUYBG82L
 VZeE4MjBTjnth68PJ5Yo+Rm1valun1/SU2c/UHkSUgHxdZtu5GgSf+vqNM0ErYJa1R
 AuWgHL8rumlduP03ae3TdBeigbv262hjfnq7MvpFk2AOdbk0L3tOWiGNZlhFq3mtEI
 YA3NZvlxjctaaDC7Nb5SbFZ2MwjQGnrKvBsVMLtqRdmGy7OK5FSgo5eUSTKVmvPiIe
 RM+XLt8Tch1PA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B699e6ab40000>; Wed, 25 Feb 2026 16:21:24 +1300
Received: from ronand-dl.ws.atlnz.lc (ronand-dl.ws.atlnz.lc [10.33.12.18])
 by pat.atlnz.lc (Postfix) with ESMTP id C5D4D13ECC4;
 Wed, 25 Feb 2026 16:21:24 +1300 (NZDT)
Received: by ronand-dl.ws.atlnz.lc (Postfix, from userid 1930)
 id C776984004F; Wed, 25 Feb 2026 16:21:24 +1300 (NZDT)
From: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
To: u-boot@lists.denx.de
Cc: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH v2 2/4] iopoll: Add missing parenthesis to read_poll_timeout
 macro
Date: Wed, 25 Feb 2026 16:05:32 +1300
Message-ID: <20260225030531.1826670-5-ronan.dalton@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225030531.1826670-2-ronan.dalton@alliedtelesis.co.nz>
References: <20260225030531.1826670-2-ronan.dalton@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=d/NWygjE c=1 sm=1 tr=0 ts=699e6ab4
 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=HzLeVaNsDn8A:10 a=QX4gbG5DAAAA:8
 a=BBqBLkX6TmY8kAbijEwA:9 a=3ZKOabzyN94A:10 a=kQaluDxiGj8jkIwhbQMR:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
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

Signed-off-by: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
Cc: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: Marek Vasut <marex@denx.de>
---
Changes for v2:
- This is a new patch in the patch set

 include/linux/iopoll.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index d6573fafab0..7dcbbac6443 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -29,12 +29,12 @@
  */
 #define read_poll_timeout(op, val, cond, sleep_us, timeout_us, args...)	=
\
 ({ \
-	unsigned long timeout =3D timer_get_us() + timeout_us; \
+	unsigned long timeout =3D timer_get_us() + (timeout_us); \
 	for (;;) { \
 		(val) =3D op(args); \
 		if (cond) \
 			break; \
-		if (timeout_us && time_after(timer_get_us(), timeout)) { \
+		if ((timeout_us) && time_after(timer_get_us(), timeout)) { \
 			(val) =3D op(args); \
 			break; \
 		} \
--=20
2.53.0

