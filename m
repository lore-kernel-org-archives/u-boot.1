Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D615DC54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 02:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 351B487D70;
	Wed, 27 Mar 2024 03:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Q6o0UsUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A287187E3F; Wed, 27 Mar 2024 03:35:16 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E961780EED
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 03:35:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42R2Z7OS056490;
 Tue, 26 Mar 2024 21:35:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711506907;
 bh=Qrx7jpNlsM416Y/oBHDoB3RSQCBjdUTTfs/8h1aBtpI=;
 h=From:To:CC:Subject:Date;
 b=Q6o0UsUZ8fFaw722aVbtT6MkzQjc4lrH06RsQu+eLvBEpbyNPfSffttKLsGcmH2fA
 Sc2FXCNWhxgVsjNsrtEziKBtI5SDIk98Y9NhmbZsBk3ykC3SD/EMiRFMJ7xLf4QHdV
 Yfk3ujH3dG2Pg34vGXe3NRZBJ/FQcOd3FNXzZy0k=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42R2Z7mp097387
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Mar 2024 21:35:07 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 21:35:06 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 21:35:06 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42R2Z6HE037319;
 Tue, 26 Mar 2024 21:35:06 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Masahisa Kojima <masahisa.kojima@linaro.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, Rasmus
 Villemoes <rasmus.villemoes@prevas.dk>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [RFC] Makefile.lib: find capsule ESL dtsi file when
 CONFIG_OF_UPSTREAM=y
Date: Tue, 26 Mar 2024 21:34:51 -0500
Message-ID: <20240327023451.2288523-1-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 27 Mar 2024 03:59:16 +0100
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

When CONFIG_OF_UPSTREAM is enabled, DTS files are in SOC subdirectories (vs the
top level dts directory), but when CONFIG_EFI_CAPSULE_AUTHENTICATE is enabled,
the dynamically created dtsi file containing the capsule ESL DT node is in the
parent directory.  This results in a build failure because the #include inserted
in the DTS file is local to the current directory.  Update Makefile to have the
DT preprocessing of #includes search in the parent (dts top level) directory
too.

I'm not sure if this is the best solution.

I was also tempted to just manually include the capsule-key property in the
board dts, and avoid the Makefile implicit inclusion trickery.  I would actually
prefer this approach as everything is more explicit.  But this isn't an option
because if CONFIG_EFI_CAPSULE_AUTHENTICATE is enabled, the implicit inclusion of
the dtsi file happens.  It would be better, IMO, if we only included the
generated dtsi file if CONFIG_EFI_CAPSULE_ESL_FILE is defined.  Was only
supporting the implicit inclusiong approach an intentional design choice?

Thanks
Jon

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 12857316c58..62f87517c09 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -334,7 +334,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 	(cat $< > $(pre-tmp)); \
 	$(foreach f,$(subst $(quote),,$(dtsi_include_list)), \
 	  echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
-	$(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
+	$(HOSTCC) -E $(dtc_cpp_flags) -I$(obj) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
 	$(DTC) -O dtb -o $@ -b 0 \
 		-i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) || \
-- 
2.34.1

