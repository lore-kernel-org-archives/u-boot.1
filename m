Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3640EF5544D
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 03:36:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FE8083DCB;
	Wed, 25 Feb 2026 04:36:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="yu9oYbmd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5746683E61; Wed, 25 Feb 2026 04:36:10 +0100 (CET)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 634B383D8A
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 04:36:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ronand@alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 756342C037C;
 Wed, 25 Feb 2026 16:36:02 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1771990562;
 bh=4IHXFxay7/OvcjcVk6P+AXVG/1j67A/3A6oB+ThjiIM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=yu9oYbmdK6+Fg7MbA4Dj9YSVPfweKAmzqdQKuH0JECi8GhpkqKROHaHH8I5fY53hk
 yw0N8IOFbx1tEl3Y5K+oRLsoGX0/LzGnQC76ljxyOShjFSi3IlainWthepJc+2cDIy
 CNpMdyPQHug9bZpl6BDbkqR3Xwn2tMgJpoYNZK1WkUVl9qZ2zioj3ZqvB0fJYT+RpY
 INPtNAlv2wwIvTD8JYs+59tIeZ6APUzjuYYhX3EifpcGg9vYKA2HlEGVCJog94fEjq
 CaRbBhKgDp9P1LsnveOLzD5j4ZXh2nzQODUr6FZmu20zHS7fFbS5gJRMG8PINRAy6i
 dE4jmAJG+M+tA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B699e6e220000>; Wed, 25 Feb 2026 16:36:02 +1300
Received: from ronand-dl.ws.atlnz.lc (ronand-dl.ws.atlnz.lc [10.33.12.18])
 by pat.atlnz.lc (Postfix) with ESMTP id 4720D13ECC4;
 Wed, 25 Feb 2026 16:36:02 +1300 (NZDT)
Received: by ronand-dl.ws.atlnz.lc (Postfix, from userid 1930)
 id 45FD284004F; Wed, 25 Feb 2026 16:36:02 +1300 (NZDT)
From: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
To: u-boot@lists.denx.de
Cc: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>,
 Marek Vasut <marex@denx.de>, Philip Oberfichtner <pro@denx.de>
Subject: [PATCH v2 4/4] usb: Convert ad-hoc poll/timeout sequences in usb.c to
 iopoll
Date: Wed, 25 Feb 2026 16:05:37 +1300
Message-ID: <20260225030531.1826670-10-ronan.dalton@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225030531.1826670-2-ronan.dalton@alliedtelesis.co.nz>
References: <20260225030531.1826670-2-ronan.dalton@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=d/NWygjE c=1 sm=1 tr=0 ts=699e6e22
 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=HzLeVaNsDn8A:10 a=D029-m6IjDprw9L5G2cA:9
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

Notes:
- usb_bulk_msg could be updated to return -ETIMEDOUT on the timeout
  case. Currently it looks like -EIO is returned if a timeout occurs and
  callers can't tell if a timeout occurred as such. The -EIO return code
  is also inconsistent with usb_control_msg which returns -1.

 common/usb.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/common/usb.c b/common/usb.c
index 1c139d86e90..4defda93a06 100644
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
@@ -276,19 +279,22 @@ int usb_control_msg(struct usb_device *dev, unsigne=
d int pipe,
 int usb_bulk_msg(struct usb_device *dev, unsigned int pipe,
 			void *data, int len, int *actual_length, int timeout)
 {
+	volatile unsigned long usb_status;
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
+	read_poll_timeout((volatile unsigned long), usb_status,
+			  !(usb_status & USB_ST_NOT_PROC), 1000,
+			  timeout * 1000UL, dev->status);
=20
 	*actual_length =3D dev->act_len;
=20
--=20
2.53.0

