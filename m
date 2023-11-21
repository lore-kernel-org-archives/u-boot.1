Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395DAC61D88
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 01:10:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FC858641F;
	Tue, 21 Nov 2023 02:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="sETx9JFK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52D32864F3; Tue, 21 Nov 2023 02:10:51 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98516863F8
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 02:10:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C81273F2A2; 
 Tue, 21 Nov 2023 01:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700529042;
 bh=ipq482jMhYisygk53MzTxp9OvnWfZQJjI5Zd4E52m6s=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=sETx9JFK1zNhZ/fMdm+ClsGXY56MNks2WZU4epZ1igpezcEFraljipJxgrW2caa9n
 +1AsKs8aBrm99auDYzJ82TUshCHlweJYjI6ztFmr7F++/pzhumybyGGd/i+w6F2YpS
 IZydfdBCJ1exTqReQw0seZNKAkKJ+yxu+itRsIVvAD/FvqR52g+RU67apfKg/Al2vq
 Y1gS0MUwZf1YKafpgu4HQagOCKoVBPwqsCHROm0l4ibTvAsCar3kn4l4EDtlWBUDK9
 PYtxczOnD+Gvc9tP2qS7kPi7CpFgk6Xqd3WxEA6uygB0KOUB7314/onwL13VG/kssc
 xcpf33L/3Hjpg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: fix efi_show_tables()
Date: Tue, 21 Nov 2023 02:10:35 +0100
Message-Id: <20231121011035.54128-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Since commit 041840eeeb12 ("efi: Split out table-listing code into a new
file") the `efi tables` command prints random numbers instead of GUIDs.
%pUl expects a pointer to a GUID not to a string.

Set maintainer for file cmd/efi_comon.c.

Fixes: 041840eeeb12 ("efi: Split out table-listing code into a new file")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 MAINTAINERS      | 1 +
 cmd/efi_common.c | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c1cb2dc4d..40786023ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -993,6 +993,7 @@ S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-efi.git
 F:	arch/arm/lib/*_efi.*
 F:	cmd/bootefi.c
+F:	cmd/efi_common.c
 F:	cmd/eficonfig.c
 F:	cmd/efidebug.c
 F:	cmd/nvedit_efi.c
diff --git a/cmd/efi_common.c b/cmd/efi_common.c
index f4056096cd..f6e3494892 100644
--- a/cmd/efi_common.c
+++ b/cmd/efi_common.c
@@ -17,10 +17,10 @@ void efi_show_tables(struct efi_system_table *systab)
 
 	for (i = 0; i < systab->nr_tables; i++) {
 		struct efi_configuration_table *tab = &systab->tables[i];
-		char guid_str[37];
+		const char *guid_str;
 
-		uuid_bin_to_str(tab->guid.b, guid_str, 1);
-		printf("%p  %pUl  %s\n", tab->table, guid_str,
-		       uuid_guid_get_str(tab->guid.b) ?: "(unknown)");
+		guid_str = uuid_guid_get_str(tab->guid.b);
+		printf("%p  %pUl  %s\n", tab->table, tab->guid.b,
+		       guid_str ? : "(unknown)");
 	}
 }
-- 
2.40.1

