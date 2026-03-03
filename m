Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DB9E67A6E
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 06:27:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FD4183F2D;
	Tue,  3 Mar 2026 07:27:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="BGat9Aui";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7598783F59; Tue,  3 Mar 2026 07:27:30 +0100 (CET)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F6E98063E
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 07:27:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ronand@alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4B32E2C030A;
 Tue,  3 Mar 2026 19:27:24 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1772519244;
 bh=4MqJXnK3ViZR2r9UNLKChi8NeNa11ey8DmVatqcq09E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BGat9AuiP8m4EiTKxeIEQZlJE+Cryqb76J/6/LnZhjgLJYSLiSk+ADrzMGj4WFnWr
 B2l6j7zyRWSAQqYBWtMXEWOyUpJqjtZabs072sIAocmv4i0aY+bb6HqC1Udi5HtBtB
 TgA1Ne/gYhzHSkWvkP0zN39E80O6FLFpVu6f6zK+4iHOMzWuiTHi1DuaWhRtIIbMF8
 acUoEOtEBGaizellJ7+SF8Rcw7dNIaRn3mqztRmJcyK3r6UOEWIvDizYi/i7GTGq4t
 ECKMM5hAdubmYbYoaG5B1pBKaYnyM6+j5thv512vqnkducr+Kjd00C5Oj/A/YIfIBe
 KbC+ibcHauAXg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B69a67f4c0000>; Tue, 03 Mar 2026 19:27:24 +1300
Received: from ronand-dl.ws.atlnz.lc (ronand-dl.ws.atlnz.lc [10.33.12.18])
 by pat.atlnz.lc (Postfix) with ESMTP id 1C24D13ED5A;
 Tue,  3 Mar 2026 19:27:24 +1300 (NZDT)
Received: by ronand-dl.ws.atlnz.lc (Postfix, from userid 1930)
 id 13B9D84004F; Tue,  3 Mar 2026 19:27:24 +1300 (NZDT)
From: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
To: u-boot@lists.denx.de
Cc: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH v4 2/4] iopoll: Improve handling of timeout_us param in
 read_poll_timeout macro
Date: Tue,  3 Mar 2026 19:25:03 +1300
Message-ID: <20260303062503.3392544-4-ronan.dalton@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303062503.3392544-2-ronan.dalton@alliedtelesis.co.nz>
References: <20260303062503.3392544-2-ronan.dalton@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=d/NWygjE c=1 sm=1 tr=0 ts=69a67f4c
 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=Yq5XynenixoA:10 a=QX4gbG5DAAAA:8
 a=nYCQuVUV0fLWk47C-iYA:9 a=3ZKOabzyN94A:10 a=kQaluDxiGj8jkIwhbQMR:22
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

The read_poll_timeout macro definition is missing parenthesis around the
usages of timeout_us. Also, the local timeout variable should be named
__timeout to distinguish it from any variable named timeout in the
surrounding scope.

Wrap the timeout_us parameter in brackets and rename timeout to
__timeout to follow macro definition best-practices.

This change brings the macro definition more in line with what Linux
does.

Signed-off-by: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
Cc: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: Marek Vasut <marex@denx.de>
---
Changes for v2:
- This is a new patch in the patch set
Changes for v3:
- Use __timeout instead of timeout variable declaration to avoid clashes
- Rename patch headline to reflect extra change mentioned above
Changes for v4:
- Update commit message to have more detail

 include/linux/iopoll.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index d6573fafab0..e851eb2cc41 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -29,12 +29,12 @@
  */
 #define read_poll_timeout(op, val, cond, sleep_us, timeout_us, args...)	=
\
 ({ \
-	unsigned long timeout =3D timer_get_us() + timeout_us; \
+	unsigned long __timeout =3D timer_get_us() + (timeout_us); \
 	for (;;) { \
 		(val) =3D op(args); \
 		if (cond) \
 			break; \
-		if (timeout_us && time_after(timer_get_us(), timeout)) { \
+		if ((timeout_us) && time_after(timer_get_us(), __timeout)) { \
 			(val) =3D op(args); \
 			break; \
 		} \
--=20
2.53.0

