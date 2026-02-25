Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E93F55449
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 03:22:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6FF683E62;
	Wed, 25 Feb 2026 04:22:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="qHKth0lC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89A9D83E7A; Wed, 25 Feb 2026 04:22:04 +0100 (CET)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5497A83D8A
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 04:22:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ronand@alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E5B812C028B;
 Wed, 25 Feb 2026 16:21:56 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1771989716;
 bh=/3vwqi6HawAF6ZcTLlkI48CNHA9F6zyATuCVJSAraL8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qHKth0lCSPBwlDz8QV9b8VhIUVyIRB2y8xsa3+Slsr7gGrY8RAyrWq0KzQsFcqzkA
 303mGR2yCfJVJLV6IyIkxGeDHyyoDfeJ4GOjCfqxOBLNLEq2oARaEUyUKV8CjAoaDl
 hXCRhMuyGbcieTfi23LyxkWWeniq7iLgK38VKeSZXMjyu+zSJuowPgHI21ZHagdbS9
 Wufydmdri4U2d7H/gVyrjomjbDXy7a69LIaXn2W8zjUZcgTDQrBGcgfHcdw1n/ZoNu
 39/4my3+7er7DLedvoiTyvJI2NKr7dA+/bni1g507XlgNhi54EmXr0tyE+SemrHk0J
 e3C5VoEQCSfhw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B699e6ad40000>; Wed, 25 Feb 2026 16:21:56 +1300
Received: from ronand-dl.ws.atlnz.lc (ronand-dl.ws.atlnz.lc [10.33.12.18])
 by pat.atlnz.lc (Postfix) with ESMTP id BF3D313ECC4;
 Wed, 25 Feb 2026 16:21:56 +1300 (NZDT)
Received: by ronand-dl.ws.atlnz.lc (Postfix, from userid 1930)
 id C0F9284004F; Wed, 25 Feb 2026 16:21:56 +1300 (NZDT)
From: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
To: u-boot@lists.denx.de
Cc: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH v2 3/4] usb: Add code spacing in usb_bulk_msg function
Date: Wed, 25 Feb 2026 16:05:35 +1300
Message-ID: <20260225030531.1826670-8-ronan.dalton@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225030531.1826670-2-ronan.dalton@alliedtelesis.co.nz>
References: <20260225030531.1826670-2-ronan.dalton@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=d/NWygjE c=1 sm=1 tr=0 ts=699e6ad4
 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=HzLeVaNsDn8A:10 a=rGdjWK6fmDhT0VZwAXQA:9
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

Signed-off-by: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
Cc: Marek Vasut <marex@denx.de>
---
Changes for v2:
- This is a new patch in the patch set

 common/usb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/common/usb.c b/common/usb.c
index 6a4ad346f4b..1c139d86e90 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -278,15 +278,20 @@ int usb_bulk_msg(struct usb_device *dev, unsigned i=
nt pipe,
 {
 	if (len < 0)
 		return -EINVAL;
+
 	dev->status =3D USB_ST_NOT_PROC; /*not yet processed */
+
 	if (submit_bulk_msg(dev, pipe, data, len) < 0)
 		return -EIO;
+
 	while (timeout--) {
 		if (!((volatile unsigned long)dev->status & USB_ST_NOT_PROC))
 			break;
 		mdelay(1);
 	}
+
 	*actual_length =3D dev->act_len;
+
 	if (dev->status =3D=3D 0)
 		return 0;
 	else
--=20
2.53.0

