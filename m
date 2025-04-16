Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB26C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 06:13:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C22FF81F45;
	Wed, 16 Apr 2025 08:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=temperror (0-bit key; unprotected) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="QPmRT7K7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6AD082B44; Wed, 16 Apr 2025 08:13:48 +0200 (CEST)
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97AB381026
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 08:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=prvs=1215f95e09=ms@dev.tdt.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
 by relay.expurgate.net with smtp (Exim 4.92)
 (envelope-from <prvs=1215f95e09=ms@dev.tdt.de>)
 id 1u4w1o-007dWv-71; Wed, 16 Apr 2025 08:13:44 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
 by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <ms@dev.tdt.de>)
 id 1u4w1n-007sOF-Jc; Wed, 16 Apr 2025 08:13:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
 s=z1-selector1; t=1744784023;
 bh=Hrpld41CbwwBeeoCms2Jvpp5kEC1cYL4Gl66ERCKk8c=;
 h=From:To:Cc:Subject:Date:From;
 b=QPmRT7K74EmHC/YUsM8nH8Bt4o7TOhoFcPP10kEdQH3i8FAkHcbGdMyiSrBA5sx/w
 d3LqEejMnYWRTe45zVOYOvPJJdkFfQqXlt5wz7Gldh4LiNuTg1o6ruUOeTZ1dWYs+z
 5hj3DxKEuUQSdHBHC8MK6jHi+G6MHTf3RK6YcrClOMepwQRddmmiO5ZYb/tNCN4eAM
 ZEE752eW3ciongc/plmggiYBR0hqdFjlcg7Yz49jyFQcahmzD7KoxqufSRLA3AUbeq
 9ZsO74R6+poOOR3KW7W4MLPh4Cp87dfrFqm9rSEIEB3iYbvcGE8FVqK9jxN4/noonJ
 l7Xjtw3YBGSdw==
Received: from securemail.tdt.de (localhost [127.0.0.1])
 by securemail.tdt.de (Postfix) with ESMTP id 2AE51240041;
 Wed, 16 Apr 2025 08:13:43 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
 by securemail.tdt.de (Postfix) with ESMTP id 268CB240040;
 Wed, 16 Apr 2025 08:13:43 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
 by mail.dev.tdt.de (Postfix) with ESMTPSA id 697D924FCE;
 Wed, 16 Apr 2025 08:13:40 +0200 (CEST)
From: Martin Schiller <ms@dev.tdt.de>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, josua@solid-run.com, sr@denx.de,
 Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH] cmd: tlv_eeprom: return after successful read from EEPROM
Date: Wed, 16 Apr 2025 08:13:16 +0200
Message-ID: <20250416061316.1348271-1-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1744784024-7E5433B0-0C67D922/0/0
X-purgate: clean
X-purgate-type: clean
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

Commit f6eff35b8c19 ("cmd: tlv_eeprom: handle -ENODEV error from
read_eeprom function") removed the needed 'return 0' after a successful
read. As a result, the usage message is shown when 'tlv_eeprom read' is
successfully called.

Let's fix it by adding the needed 'return 0'.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 cmd/tlv_eeprom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/tlv_eeprom.c b/cmd/tlv_eeprom.c
index 0aec7521770..d7c229e5441 100644
--- a/cmd/tlv_eeprom.c
+++ b/cmd/tlv_eeprom.c
@@ -476,6 +476,7 @@ int do_tlv_eeprom(struct cmd_tbl *cmdtp, int flag, in=
t argc, char *const argv[])
=20
 		printf("EEPROM data loaded from device to memory.\n");
 		has_been_read =3D 1;
+		return 0;
 	}
=20
 	// Subsequent commands require that the EEPROM has already been read.
--=20
2.39.5

