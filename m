Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5ABD58E51
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 04:54:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14D0183F14;
	Mon,  2 Mar 2026 05:54:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="C7wK2kqY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1775A83F2A; Mon,  2 Mar 2026 05:54:22 +0100 (CET)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E540183D17
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 05:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ronand@alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B750A2C044C;
 Mon,  2 Mar 2026 17:54:17 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1772427257;
 bh=uY2h9KfM8Bm84erFk0b3bpGYIRhDJk++W05tLBvfV8c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=C7wK2kqYG6prhXWCskIM0BI1Q7zElvGAvRdCUTZYlv+4awEEvdiqE/7cg17So6h3p
 UKBfPDfv7+MVlmOyjl8DZ3qaGOqYCLZ9lw4yKch798xa86s4+U8HD0lUMJkJhcUo9e
 dDRB16VjFmMbI2q8O+l0pNh/LZRz/kjgET9t17RsmgJ3VyOo+CPnOpfpHV3NkY7cMw
 2eEp0y41f1xv0zgXkGC76XSPsg6Jf3HKwbqXMLqxsyQaWRyUOZE9NTm+LPN38D8E9H
 h7sSFxS6TGRhjOqlyJ22ZPye67AUI/ZDj1ED4mWWDKjGenCDIKhFOcI8GLjMJKNPtV
 61Oryf2vc9qdA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B69a517f90000>; Mon, 02 Mar 2026 17:54:17 +1300
Received: from ronand-dl.ws.atlnz.lc (ronand-dl.ws.atlnz.lc [10.33.12.18])
 by pat.atlnz.lc (Postfix) with ESMTP id 9178513ED5B;
 Mon,  2 Mar 2026 17:54:17 +1300 (NZDT)
Received: by ronand-dl.ws.atlnz.lc (Postfix, from userid 1930)
 id 910D584004F; Mon,  2 Mar 2026 17:54:17 +1300 (NZDT)
From: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
To: u-boot@lists.denx.de
Cc: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH v3 3/4] usb: Add code spacing in usb_bulk_msg function
Date: Mon,  2 Mar 2026 17:45:34 +1300
Message-ID: <20260302044532.2891813-6-ronan.dalton@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302044532.2891813-2-ronan.dalton@alliedtelesis.co.nz>
References: <20260302044532.2891813-2-ronan.dalton@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=d/NWygjE c=1 sm=1 tr=0 ts=69a517f9
 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=Yq5XynenixoA:10 a=rGdjWK6fmDhT0VZwAXQA:9
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
Changes for v3:
- No changes

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

