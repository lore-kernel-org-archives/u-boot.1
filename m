Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4590FE67A6B
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 06:30:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0AAC83F7D;
	Tue,  3 Mar 2026 07:30:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="l0QEwsNk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8613383F7F; Tue,  3 Mar 2026 07:30:01 +0100 (CET)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D03A83F75
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 07:29:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ronand@alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 60B732C030A;
 Tue,  3 Mar 2026 19:29:52 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1772519392;
 bh=4fyZ2GwR0i0miW6w8VPlNLSTI0mIR8+Kp7bZIvEZtkQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=l0QEwsNkTQQFiebl1oQbRQ+V7skJlGDMyLwFj1Px8/AGK1BVXIyhFKfBaaWULTska
 R5Pf0g7KzpyiE+QjipvntBUbOpbJkYDqV8YhEDAQYKCZ4//s8KPliko5BtGWIH4aLm
 9uRs04d7kA2FVfGCtKMwt+Amw+3mYp19uCz2Uwy8P729TkW5ec/FaUAnEywm8yKdcE
 L7i2JkxGYOG5Pf6jLDvU1LkykVNhcuXborywelXKHnMlsUHxRqJGXPRH4q9AqXjbr0
 KLQTios38LTHA32bnjRajROtD9SEaXoRyGdmQm84vJat+Zh9PPTH0bHEYJ7fcMmLtd
 Zt3WDQMgJ+0VA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B69a67fe00000>; Tue, 03 Mar 2026 19:29:52 +1300
Received: from ronand-dl.ws.atlnz.lc (ronand-dl.ws.atlnz.lc [10.33.12.18])
 by pat.atlnz.lc (Postfix) with ESMTP id E070413ED5A;
 Tue,  3 Mar 2026 19:29:51 +1300 (NZDT)
Received: by ronand-dl.ws.atlnz.lc (Postfix, from userid 1930)
 id D76A684004F; Tue,  3 Mar 2026 19:29:51 +1300 (NZDT)
From: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
To: u-boot@lists.denx.de
Cc: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>,
 Marek Vasut <marex@denx.de>, Philip Oberfichtner <pro@denx.de>
Subject: [PATCH v4 4/4] usb: Convert ad-hoc poll/timeout sequences in usb.c to
 iopoll
Date: Tue,  3 Mar 2026 19:25:07 +1300
Message-ID: <20260303062503.3392544-8-ronan.dalton@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303062503.3392544-2-ronan.dalton@alliedtelesis.co.nz>
References: <20260303062503.3392544-2-ronan.dalton@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=d/NWygjE c=1 sm=1 tr=0 ts=69a67fe0
 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=Yq5XynenixoA:10 a=D029-m6IjDprw9L5G2cA:9
 a=3ZKOabzyN94A:10
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

The usb_control_msg and usb_bulk_msg functions in usb.c use a while loop
and delay to wait for a USB control message to be processed. iopoll
provides a macro to do this for us which can be used instead.

Replace the while loops with calls to the read_poll_timeout macro. Also
add a check for timeout being negative at the start of the functions and
return -EINVAL in that case, since a negative timeout doesn't make
sense.

This also fixes a bug where usb_control_msg would check if timeout was
equal to 0 to determine if a timeout occurred, when it should have been
checking if it was -1 instead. This caused -1 to be returned by the
function in most cases when a timeout occurred instead of the correct
error code of -ETIMEDOUT.

usb_bulk_msg now returns -ETIMEDOUT instead of -EIO on timeout.

Signed-off-by: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
Cc: Marek Vasut <marex@denx.de>
Cc: Philip Oberfichtner <pro@denx.de>
---
Changes for v2:
- Changed headline, previously called:
  usb: Fix timeout check in usb_control_msg
- Fix timeout check bug by using iopoll instead of just fixing the if
  statement
- Update usb_bulk_msg to also use iopoll as well
Changes for v3:
- No changes
Changes for v4:
- Return -ETIMEDOUT from usb_bulk_msg function on timeout
- Update commit message to mention usb_bulk_msg return value change

 common/usb.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/common/usb.c b/common/usb.c
index 1c139d86e90..488ec0532b1 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -40,6 +40,7 @@
 #include <errno.h>
 #include <usb.h>
 #include <linux/delay.h>
+#include <linux/iopoll.h>
=20
 #define USB_BUFSIZ	512
=20
@@ -224,8 +225,12 @@ int usb_control_msg(struct usb_device *dev, unsigned=
 int pipe,
 			void *data, unsigned short size, int timeout)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(struct devrequest, setup_packet, 1);
+	volatile unsigned long usb_status;
 	int err;
=20
+	if (timeout < 0)
+		return -EINVAL;
+
 	if ((timeout =3D=3D 0) && (!asynch_allowed)) {
 		/* request for a asynch control pipe is not allowed */
 		return -EINVAL;
@@ -253,14 +258,12 @@ int usb_control_msg(struct usb_device *dev, unsigne=
d int pipe,
 	 * interrupt handler may set the status when the USB operation has
 	 * been completed.
 	 */
-	while (timeout--) {
-		if (!((volatile unsigned long)dev->status & USB_ST_NOT_PROC))
-			break;
-		mdelay(1);
-	}
+	err =3D read_poll_timeout((volatile unsigned long), usb_status,
+				!(usb_status & USB_ST_NOT_PROC), 1000,
+				timeout * 1000UL, dev->status);
=20
-	if (timeout =3D=3D 0)
-		return -ETIMEDOUT;
+	if (err =3D=3D -ETIMEDOUT)
+		return err;
=20
 	if (dev->status)
 		return -1;
@@ -276,22 +279,29 @@ int usb_control_msg(struct usb_device *dev, unsigne=
d int pipe,
 int usb_bulk_msg(struct usb_device *dev, unsigned int pipe,
 			void *data, int len, int *actual_length, int timeout)
 {
+	volatile unsigned long usb_status;
+	int err;
+
 	if (len < 0)
 		return -EINVAL;
=20
+	if (timeout < 0)
+		return -EINVAL;
+
 	dev->status =3D USB_ST_NOT_PROC; /*not yet processed */
=20
 	if (submit_bulk_msg(dev, pipe, data, len) < 0)
 		return -EIO;
=20
-	while (timeout--) {
-		if (!((volatile unsigned long)dev->status & USB_ST_NOT_PROC))
-			break;
-		mdelay(1);
-	}
+	err =3D read_poll_timeout((volatile unsigned long), usb_status,
+				!(usb_status & USB_ST_NOT_PROC), 1000,
+				timeout * 1000UL, dev->status);
=20
 	*actual_length =3D dev->act_len;
=20
+	if (err =3D=3D -ETIMEDOUT)
+		return err;
+
 	if (dev->status =3D=3D 0)
 		return 0;
 	else
--=20
2.53.0

