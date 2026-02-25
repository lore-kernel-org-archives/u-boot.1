Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26C2F5544C
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 03:21:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CF2183D8A;
	Wed, 25 Feb 2026 04:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="nWPrE/1+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1946183DCB; Wed, 25 Feb 2026 04:20:58 +0100 (CET)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6465D83C39
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 04:20:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ronand@alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7E7642C028B;
 Wed, 25 Feb 2026 16:20:48 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1771989648;
 bh=4sCEv+rUOHrJKL3/plobk6cOj12vVruTyFVipCWatgc=;
 h=From:To:Cc:Subject:Date:From;
 b=nWPrE/1+3NM8f/1MM3gbj/kPFDJX7rQ4vEuWVAmDiEaLKP88vsqbl7WqITS2wmKKm
 6TxUSPAM62avtJJj6eDzoNOi49XSbICYDl0oYGriFQjghlDVyCXjbm9jfdA4kKz13U
 i0q2hWc5FO7NADKQSjTnpWjhnn62xdXkLT5Iv1yK0gVoogSV04RIDW2Q8ntsSTe5Jo
 cPwPm1syQZrJg5quUKW1Qj//46un9N6qAAYlZKELJPBHom9mAaD8rE5qnhIkD+vTb5
 wE69S8jX3JvjMfZRxrrD8Lkjt8FJQPrEh1LxBnhGOdXj/UKeUyUlwH2yO5fUbAMrQG
 6pXVrB0NtR8/w==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B699e6a900000>; Wed, 25 Feb 2026 16:20:48 +1300
Received: from ronand-dl.ws.atlnz.lc (ronand-dl.ws.atlnz.lc [10.33.12.18])
 by pat.atlnz.lc (Postfix) with ESMTP id 51FAA13ECC4;
 Wed, 25 Feb 2026 16:20:48 +1300 (NZDT)
Received: by ronand-dl.ws.atlnz.lc (Postfix, from userid 1930)
 id 5133184004F; Wed, 25 Feb 2026 16:20:48 +1300 (NZDT)
From: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
To: u-boot@lists.denx.de
Cc: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH v2 1/4] iopoll: Fix read_poll_timeout macro documentation
Date: Wed, 25 Feb 2026 16:05:29 +1300
Message-ID: <20260225030531.1826670-2-ronan.dalton@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=d/NWygjE c=1 sm=1 tr=0 ts=699e6a90
 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=HzLeVaNsDn8A:10 a=QX4gbG5DAAAA:8
 a=kDSm9L-BpcNF3i-JwtkA:9 a=3ZKOabzyN94A:10 a=1uPSbw4tHp4s5AvNYBEr:22
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

The read_poll_timeout macro has some incorrect documentation. @addr is
referred to but that is now replaced with @args.

Update the macro documentation to make it more similar to the equivalent
Linux documentation, which doesn't have this issue.

Signed-off-by: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
Cc: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: Marek Vasut <marex@denx.de>
---
Changes for v2:
- This is a new patch in the patch set

 include/linux/iopoll.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index 0ee2bddaa83..d6573fafab0 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -12,16 +12,17 @@
 #include <time.h>
=20
 /**
- * read_poll_timeout - Periodically poll an address until a condition is=
 met or a timeout occurs
- * @op: accessor function (takes @addr as its only argument)
+ * read_poll_timeout - Periodically poll an address until a condition is=
 met or
+ *			a timeout occurs
+ * @op: accessor function (takes @args as its arguments)
  * @val: Variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @sleep_us: Maximum time to sleep in us
+ * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops).
  * @timeout_us: Timeout in us, 0 means never timeout
  * @args: arguments for @op poll
  *
  * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
- * case, the last read value at @addr is stored in @val.
+ * case, the last read value at @args is stored in @val.
  *
  * When available, you'll probably want to use one of the specialized
  * macros defined below rather than this macro directly.
--=20
2.53.0

