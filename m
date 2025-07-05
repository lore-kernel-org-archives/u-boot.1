Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FD6C83F03
	for <u-boot@archiver.kernel.org>; Sun,  6 Jul 2025 03:50:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79711810EB;
	Sun,  6 Jul 2025 05:50:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="im7G/Cga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA3698206E; Sat,  5 Jul 2025 20:48:21 +0200 (CEST)
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch
 [79.135.106.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E2D2809A5
 for <u-boot@lists.denx.de>; Sat,  5 Jul 2025 20:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rjstoneus@pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1751741298; x=1752000498;
 bh=2M9zfLCBlsWqTu8yaCBcg6deGc9yMCYS6gDDdapVAbA=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=im7G/Cgaax9TQfhfBzebSHetH2wjgWLGshXYauKiY90mPQdmfqYa2UNKkCSKKSso8
 LJhJ5eUq81P9rztye2n7psd2m2ZaD9C16ieSypNs0MQ8FzmQ6HQi5sirVs6jOPlP6/
 XTKSVj7va3uVZGDkJBT3INH29rHI6wlCZ3ZKso5ZMf9xKHqYDTHAOrZEDg+CWjtiQp
 Lv7R5AEUwkDb+/YEp8o/qAoejjwpirk37h+1TnBnLDD2VDhmlZWEgriivfX4jyfxJq
 gj7lfCbBiAeYE1E6hMhsgTW8MWbZs/wEkOrIxh62yse/5/apR3NRwhY+xOa8kRBDJG
 aJCRU32xOQf1g==
Date: Sat, 05 Jul 2025 18:48:12 +0000
To: u-boot@lists.denx.de
From: Robert Stone <rjstoneus@pm.me>
Subject: [PATCH] drivers: remove -mgeneral-regs-only for truetype
Message-ID: <2a6ea8e8-788e-4eab-b06b-b553cf4f8320@pm.me>
Feedback-ID: 39838635:user:proton
X-Pm-Message-ID: f4a7ac20097ee0ccb21aff1826ebe8cf7d51a21e
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------96c04fd319e64f19b58999b193b0c3536ef9d0e9c75091a554ce68dbbac196de";
 charset=utf-8
X-Mailman-Approved-At: Sun, 06 Jul 2025 05:50:01 +0200
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------96c04fd319e64f19b58999b193b0c3536ef9d0e9c75091a554ce68dbbac196de
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID: <2a6ea8e8-788e-4eab-b06b-b553cf4f8320@pm.me>
Date: Sat, 5 Jul 2025 11:47:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Robert Stone <rjstoneus@pm.me>
To: u-boot@lists.denx.de
Subject: [PATCH] drivers: remove -mgeneral-regs-only for truetype

 From a364b45738c1fc2e937a8d845f419b8c5c64d751 Mon Sep 17 00:00:00 2001
From: rjstone <rjstoneus@pm.me>
Date: Sat, 5 Jul 2025 11:22:09 -0700
Subject: [PATCH] drivers: remove -mgeneral-regs-only for truetype

For almost everything, -mgeneral-regs-only is a good optimization, but
console_truetype.c does using floating point, so the build will fail
unless it is compiled without -mgeneral-regs-only.
---
Sorry if this is formatted improperly. I had some trouble setting up 
patman and format-patch. Also having some email software problems.

  drivers/video/Makefile | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index ebe4a3961fc..a1a408da2fb 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -15,6 +15,7 @@ else ifdef CONFIG_CONSOLE_ROTATION
  obj-y += console_core.o
  endif
  obj-$(CONFIG_CONSOLE_ROTATION) += console_core.o
+CFLAGS_REMOVE_console_truetype.o = -mgeneral-regs-only
  obj-$(CONFIG_CONS
OLE_TRUETYPE) += console_truetype.o fonts/
  obj-$(CONFIG_DISPLAY) += display-uclass.o
  obj-$(CONFIG_VIDEO_MIPI_DSI) += dsi-host-uclass.o
--
2.34.1

--------96c04fd319e64f19b58999b193b0c3536ef9d0e9c75091a554ce68dbbac196de
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0Fgmhpc2sJkEQjl2rWJkrnNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmeuQNNDtStIzfbK6Uc+9/FhFiEExt5p7tzELQem
AB4jRCOXatYmSucAAChmAP9XXKK7lYoeTRu/scZYdbtyfB6aszRoIOhC9P4x
FU6+zgD/ZF5fd6kKYupIAAb2tUVQmdwv0x382fgtOzxWLorfrgM=
=iNEr
-----END PGP SIGNATURE-----


--------96c04fd319e64f19b58999b193b0c3536ef9d0e9c75091a554ce68dbbac196de--

