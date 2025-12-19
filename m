Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F26E6689D
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 21:48:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75147803F5;
	Fri, 19 Dec 2025 22:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fpuayZa+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9AEE80FA1; Fri, 19 Dec 2025 22:48:20 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2C9A80050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 22:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 441C640289; 
 Fri, 19 Dec 2025 21:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1766180898;
 bh=5tMZmu7kAOM3wn2/qSd+BBv2+TmLjzpjaf4hoLcwcWs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=fpuayZa+DMZDs2CghOHbR8CAEq20JjtfhIasRA2x/eMmiACpwlevQREEbAQPxsNFU
 D9lGgBgK6prm+tNrV0+uDRb1SqihSyy6IMam/AbcGByAErS8hAPk4QVZjQGgtZU16n
 fYL6cuUYigPjqaUt6jfxK1RKIU+RSXXSF2HACOgDEhCjYemrmsTyy4PsqIX1fayGyQ
 OonI86rP/J9ICct/ohqffNbzxnv6zXK5uJdIjOAzamImGN9sSboBhnjkOyEJ0B26d+
 lQz8jibFQH3MrmGpJsdprEr6I4bCiII2HpupFj9nrXiGtojCViHKOuhKuvQimyIUAb
 Y/42k2oHOKxdeZW2Gon0icouWWySN39JLinaW+cLe/tD/gRUIjOpw33CUtAIAaNy4x
 Y38VJs+a1BwTTvz+V1Ql/GePY8b9YtnVBodispogxfshS/Ut7wm7t6VYTuXbPL8Pl0
 lhCbkf7rCpmzFJyREfDFnIDun8xfG2wP/I3iPXC5ISibmMCGbrC3zE8W1Je5XruiZA
 2ARsOnqmx9DF0Pan9d7gYcIHAtUBMDvQt84Y+jt3VXpbqDEQM2lbsawQrOUrKaamdS
 8Zx/QwIaGTb3p5RSt2stxyFDWxUowELxc94q6baxRidu6/4KoGF5wQmsNr2w93dxn9
 9adI03/aP1Av5B/P8dJeyapo=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_selftest: remove unnecessary __efi_runtime_data
 attribute
Date: Fri, 19 Dec 2025 22:48:12 +0100
Message-ID: <20251219214812.168957-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Assigning a single variable to section __efi_runtime_date while the rest of
the test is in the boottime section does not make much sense.

As we do not set a virtual address map here, we don't need a runtime
section.

Update the variables at runtime test.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_selftest/efi_selftest_variables_runtime.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
index 0886b4894b8..fd570d673f0 100644
--- a/lib/efi_selftest/efi_selftest_variables_runtime.c
+++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
@@ -17,8 +17,7 @@
 #define EFI_ST_MAX_VARNAME_SIZE 40
 
 static const efi_guid_t guid_vendor0 = EFI_GLOBAL_VARIABLE_GUID;
-static const efi_guid_t __efi_runtime_data efi_rt_var_guid =
-	U_BOOT_EFI_RT_VAR_FILE_GUID;
+static const efi_guid_t efi_rt_var_guid = U_BOOT_EFI_RT_VAR_FILE_GUID;
 
 /**
  * execute() - execute unit test
-- 
2.51.0

