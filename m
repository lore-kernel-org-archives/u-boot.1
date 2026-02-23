Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9D9E83847
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 02:20:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D0FE83935;
	Mon, 23 Feb 2026 03:20:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="V44akPJr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA91283BC9; Mon, 23 Feb 2026 03:20:52 +0100 (CET)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3461683642
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 03:20:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ronand@alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B122A2C0301;
 Mon, 23 Feb 2026 15:20:43 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1771813243;
 bh=NoBOpCkVFQaLYzy4ZEAujRE7z24VPXkJ6SVFNT2c+PM=;
 h=From:To:Cc:Subject:Date:From;
 b=V44akPJrwxNKeQjbYTVLJHVCwqdQnme6WP59Ho37XAlRQugK62+URtx5jfLZmAzL1
 KTFzOB610jZOkxBc/BIdyeCMhDI+NdrTagMjvD2bIQcHBkNEt4jGKXv3/GxDT0fvgi
 7aLep3uwlxcKCHeJRSNdWI5l0VPnKgjkQtKR0QAm531zXyRKoKzH95uQT+x/AXRNS4
 0StXCAPgPoX55VuoaSndb5FhLIs0KXGRHXy5c49oytqldrFT8jsULQcLsRgwvDB0nv
 sYv/PHO1x1bALGgkHv0Iidk9MDely1Ro7sU6K2RU8jzfH2EovCon8nlv1Y5nMiTF1n
 jqNAmPAefC3mg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B699bb97b0000>; Mon, 23 Feb 2026 15:20:43 +1300
Received: from ronand-dl.ws.atlnz.lc (ronand-dl.ws.atlnz.lc [10.33.12.18])
 by pat.atlnz.lc (Postfix) with ESMTP id 8146713EE00;
 Mon, 23 Feb 2026 15:20:43 +1300 (NZDT)
Received: by ronand-dl.ws.atlnz.lc (Postfix, from userid 1930)
 id 7DEAF84004F; Mon, 23 Feb 2026 15:20:43 +1300 (NZDT)
From: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
To: u-boot@lists.denx.de
Cc: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>,
 Marek Vasut <marex@denx.de>, Philip Oberfichtner <pro@denx.de>
Subject: [PATCH] usb: Fix timeout check in usb_control_msg
Date: Mon, 23 Feb 2026 15:20:33 +1300
Message-ID: <20260223022033.1286565-1-ronan.dalton@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=d/NWygjE c=1 sm=1 tr=0 ts=699bb97b
 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=HzLeVaNsDn8A:10 a=cg1ZugnLTOg7RUvZk7gA:9
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

The timeout check after the while loop in the usb_control_msg function
checks for equality with zero, which is incorrect because timeout will
actually be -1 after exiting the while loop due to a timeout.

Currently this means that -1 is usually returned by this function when
-ETIMEDOUT should have been returned instead.

Fix this by comparing timeout with -1 instead. Add a check for
timeout being negative at the start of the function and return -EINVAL
in that case, since a negative timeout doesn't make sense either.

Signed-off-by: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
Cc: Marek Vasut <marex@denx.de>
Cc: Philip Oberfichtner <pro@denx.de>
---
 common/usb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/common/usb.c b/common/usb.c
index 6a4ad346f4b..2cbc432b131 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -226,6 +226,9 @@ int usb_control_msg(struct usb_device *dev, unsigned =
int pipe,
 	ALLOC_CACHE_ALIGN_BUFFER(struct devrequest, setup_packet, 1);
 	int err;
=20
+	if (timeout < 0)
+		return -EINVAL;
+
 	if ((timeout =3D=3D 0) && (!asynch_allowed)) {
 		/* request for a asynch control pipe is not allowed */
 		return -EINVAL;
@@ -259,7 +262,7 @@ int usb_control_msg(struct usb_device *dev, unsigned =
int pipe,
 		mdelay(1);
 	}
=20
-	if (timeout =3D=3D 0)
+	if (timeout =3D=3D -1)
 		return -ETIMEDOUT;
=20
 	if (dev->status)
--=20
2.53.0

