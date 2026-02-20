Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD55C55AB9
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 13:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0597383D0F;
	Fri, 20 Feb 2026 14:04:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="dUL95la8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51FBE83CD3; Fri, 20 Feb 2026 05:48:01 +0100 (CET)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACFEB83946
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 05:47:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ronand@alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5D4A02C04D4;
 Fri, 20 Feb 2026 17:47:52 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1771562872;
 bh=MqClzFsYrzFqvZaQOsYbKNapKnSSvcpPfiNxXBnRHZ0=;
 h=From:To:Cc:Subject:Date:From;
 b=dUL95la8TECKPw8ASC0dsspO4md2dW8T3H/eHxo6Ucv/XJ4+1CaIxxW1W7iSepQKX
 4fyg/vQvkuV01wSi55UnJ9qX7t75F8iD73asOhwxS/MS6gQ/AlP4bS09PSBDfCFBHH
 AarDwq88sNviftliBfFN+4jUMXoYvlcDCX7p7q0lk16BWKmJyS8EkPhVIwDuK6ceRW
 m71rf9DtAwXcERMy+oWxZYf/h5b9b3GRC2G0eG8lDdUoVIc+y8Jh/43w9Fqz3Um66E
 Vd97UMEFT+8gG1/CiXzA9LAjuSSyeHigUED0V+MdwNIDepeV8CJRemqSN7MsCx2CaC
 y8CdjnyObID7A==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B6997e7780000>; Fri, 20 Feb 2026 17:47:52 +1300
Received: from ronand-dl.ws.atlnz.lc (ronand-dl.ws.atlnz.lc [10.33.12.18])
 by pat.atlnz.lc (Postfix) with ESMTP id 3223713ECD2;
 Fri, 20 Feb 2026 17:47:52 +1300 (NZDT)
Received: by ronand-dl.ws.atlnz.lc (Postfix, from userid 1930)
 id 2D02884004E; Fri, 20 Feb 2026 17:47:52 +1300 (NZDT)
From: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
To: u-boot@lists.denx.de
Cc: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>,
 Marek Vasut <marex@denx.de>, Philip Oberfichtner <pro@denx.de>
Subject: [PATCH] usb: Fix USB read configuration error on some devices
Date: Fri, 20 Feb 2026 17:47:09 +1300
Message-ID: <20260220044709.1065540-1-ronan.dalton@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=d/NWygjE c=1 sm=1 tr=0 ts=6997e778
 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=HzLeVaNsDn8A:10 a=R4PBVHzQumiQ7lRicsAA:9
 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Mailman-Approved-At: Fri, 20 Feb 2026 14:03:59 +0100
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

The following error sometimes occurs on PNY USB sticks:

  =3D> usb start
  starting USB...
  USB XHCI 1.00
  WARN endpoint is halted
  WARN endpoint is halted
  usb_new_device: Cannot read configuration, skipping device 154b:6000
  Bus usb3@500000: 1 USB Device(s) found
         scanning usb for storage devices... 0 Storage Device(s) found

Note that this USB stick works correctly in Linux but not in u-boot.

Work around this quirk by adding a small delay before calling
usb_get_configuration_no, which it would fail in otherwise (with the
error code -EINVAL).

Signed-off-by: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
Cc: Marek Vasut <marex@denx.de>
Cc: Philip Oberfichtner <pro@denx.de>
---
 common/usb.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/common/usb.c b/common/usb.c
index 6a4ad346f4b..00d051edec5 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -1197,10 +1197,17 @@ int usb_select_config(struct usb_device *dev)
 	err =3D usb_get_configuration_len(dev, 0);
 	if (err >=3D 0) {
 		tmpbuf =3D (unsigned char *)malloc_cache_aligned(err);
-		if (!tmpbuf)
+		if (!tmpbuf) {
 			err =3D -ENOMEM;
-		else
+		} else {
+			/*
+			 * PNY 32GB USB 2.0 flash drives seem to require an
+			 * additional delay before getting the next descriptor.
+			 */
+			mdelay(1);
+
 			err =3D usb_get_configuration_no(dev, 0, tmpbuf, err);
+		}
 	}
 	if (err < 0) {
 		printf("usb_new_device: Cannot read configuration, " \
--=20
2.53.0

