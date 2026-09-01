Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B918C624D3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 16:29:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06014407A4;
	Tue,  1 Sep 2026 16:29:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8BlkQFqJIsQm; Tue,  1 Sep 2026 16:29:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788280193;
	bh=MR72HRPNj6WPJOg3vIanP3H0dHCHjTS/NwfZiPAHtM8=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ph0M2UoMPfWhW/4BTNvu/hQLgZnBL9wzN1x8dez8ty4ft1Z8v2NS1udFiPmKoQF2m
	 cPxtSHxNNBvsZM10MZvckAPt53EwSMqI5SIdTQmtbHzI1U7vQupLxJondaxB9yKg56
	 Qre7uRxRX02ci0KdJHPICE3H5gS1s4+lSBLOTcsIv6Mdb7sNm2HFg5JIbsKGZ506H1
	 ParIiJhF+EudE9w9qZj371dobCofeVCFnOSHuo1GE3cLGmgvEaz4b1ZSMcyEV8XwRR
	 Cawy7BMe4/j321dr5Q/A9cdY/59Nx0r4CVNzcufWj8obZK4rtGrXFLqfOec2xZg4o5
	 VhlLO4wDfUREg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6495D40744;
	Tue,  1 Sep 2026 16:29:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 31F4E422
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 16:29:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 231E580966
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 16:29:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z1nskt-i71Og for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 16:29:51 +0000 (UTC)
X-Greylist: delayed 524 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 01 Sep 2026 16:29:50 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=gdEfIdM8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id CAF2780960
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 16:29:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8DBA1756;
 Tue,  1 Sep 2026 09:21:01 -0700 (PDT)
Received: from [127.0.1.1] (unknown [10.57.5.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EA963F85F;
 Tue,  1 Sep 2026 09:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1788279665; bh=o46LXW105TMiP3yffdiC4aLVBD0BiEs4JXBo/KjS28c=;
 h=From:Date:Subject:To:Cc:From;
 b=gdEfIdM8heQ9II+v3FjkGQbwED2h9Xqp8emBr+zRsfGU7hIA/Vs+VAY8jP3Zbjwk2
 MtGJXCTsRB1sE5K6xk5QS/WmntCnzg49TWiTCp9sqNHkAwPG2FnW1iAJX8SySOjWct
 bwxqgQwjGYFzFKf15ud/o6ePoj1NRD75pNkKOvbw=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Tue, 01 Sep 2026 18:20:44 +0200
Subject: [PATCH] spl: rename DISABLE_ALL_EXECPTIONS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260901-typo-v1-1-89ea773a9a05@arm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSwND3ZLKgnxdEzPT1FRjUyMTC9NkJaDSgqLUtMwKsDHRsRB+cWlSVmp
 yCUivUm0tAKf3wi1oAAAA
X-Change-ID: 20260901-typo-465ee352485c
To: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Daniel Golle <daniel@makrotopia.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3861;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=o46LXW105TMiP3yffdiC4aLVBD0BiEs4JXBo/KjS28c=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqlvtvMxmSDK3ZbcmqmgIvAQn/khkQ0Tl6nZL9P
 pHmQ02h4ySJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCapb7bwAKCRDLSfhWdqMG
 lK7JB/9IYzQrzeJ2BScKQ8GPVWkSFDq7ezdggdmMsKc7g0jFjPujpo1SophZvs1gKgcPpA6cBcs
 FKe/NpddfHd0Yr4WjqA0a8iSDXhp3QP21nubs0xMt7WrUfj6hvMtw++srAjAOCK1dbZ0jloKRA4
 HqJTqhCTQEkoozLBDt1f2x4XbxcCkMTxbHL1KL9MVlLmvPgCfF0a+b1UOk8FMZA8tNiClu7HmWx
 7B0FWQkB/zy2l3UVhP/e/Ih8JKLJsCQNAm2z7h8gJTT0YiCncRUTVPREskSh70M43zdv4YwODF4
 jwhIFyultJLbfm3tCLj/4IDjUIK/jEepmEy1IV+Mt8T3WA5e
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The DISABLE_ALL_EXECPTIONS define has a typo; fix all occurrences using the
following command:

  find '(' -type d -name .git -prune ')' -o -type f -print |\
    xargs sed -i 's/DISABLE_ALL_EXECPTIONS/DISABLE_ALL_EXCEPTIONS/g'

This can be verified by pre-processing, for example with the following
commands:

  make libretech-cc_v2_defconfig
  make spl/arch/arm/mach-meson/spl.i spl/common/spl/spl_atf.i

(Adjust as needed for cross-compilation.)

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/mach-meson/spl.c | 2 +-
 common/spl/spl_atf.c      | 8 ++++----
 include/atf_common.h      | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-meson/spl.c b/arch/arm/mach-meson/spl.c
index 28a63f39d36..73445064e4d 100644
--- a/arch/arm/mach-meson/spl.c
+++ b/arch/arm/mach-meson/spl.c
@@ -84,7 +84,7 @@ void board_init_f(ulong dummy)
 
 		SET_PARAM_HEAD(&spl_ep_info, ATF_PARAM_BL31, ATF_VERSION_1, 0);
 		spl_ep_info.pc = CONFIG_SPL_TEXT_BASE;
-		spl_ep_info.spsr = SPSR_64(MODE_EL3, MODE_SP_ELX, DISABLE_ALL_EXECPTIONS);
+		spl_ep_info.spsr = SPSR_64(MODE_EL3, MODE_SP_ELX, DISABLE_ALL_EXCEPTIONS);
 
 		regs.regs[0] = 0xc0000000;
 		regs.regs[1] = (unsigned long)&spl_ep_info;
diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
index 17acd3665df..cb0604ce034 100644
--- a/common/spl/spl_atf.c
+++ b/common/spl/spl_atf.c
@@ -75,7 +75,7 @@ struct bl31_params *bl2_plat_get_bl31_params_default(ulong bl32_entry,
 	bl32_ep_info->args.arg3 = fdt_addr;
 	bl32_ep_info->pc = bl32_entry ? bl32_entry : 0;
 	bl32_ep_info->spsr = SPSR_64(MODE_EL1, MODE_SP_ELX,
-				     DISABLE_ALL_EXECPTIONS);
+				     DISABLE_ALL_EXCEPTIONS);
 
 	bl2_to_bl31_params->bl32_image_info = &bl31_params_mem.bl32_image_info;
 	SET_PARAM_HEAD(bl2_to_bl31_params->bl32_image_info,
@@ -91,7 +91,7 @@ struct bl31_params *bl2_plat_get_bl31_params_default(ulong bl32_entry,
 	bl33_ep_info->args.arg0 = 0xffff & read_mpidr();
 	bl33_ep_info->pc = bl33_entry;
 	bl33_ep_info->spsr = SPSR_64(MODE_EL2, MODE_SP_ELX,
-				     DISABLE_ALL_EXECPTIONS);
+				     DISABLE_ALL_EXCEPTIONS);
 
 	bl2_to_bl31_params->bl33_image_info = &bl31_params_mem.bl33_image_info;
 	SET_PARAM_HEAD(bl2_to_bl31_params->bl33_image_info,
@@ -149,7 +149,7 @@ struct bl_params *bl2_plat_get_bl31_params_v2_default(ulong bl32_entry,
 	bl_params_node->ep_info->args.arg3 = fdt_addr;
 	bl_params_node->ep_info->pc = bl32_entry ? bl32_entry : 0;
 	bl_params_node->ep_info->spsr = SPSR_64(MODE_EL1, MODE_SP_ELX,
-						DISABLE_ALL_EXECPTIONS);
+						DISABLE_ALL_EXCEPTIONS);
 	SET_PARAM_HEAD(bl_params_node->image_info, ATF_PARAM_IMAGE_BINARY,
 		       ATF_VERSION_2, 0);
 
@@ -166,7 +166,7 @@ struct bl_params *bl2_plat_get_bl31_params_v2_default(ulong bl32_entry,
 	bl_params_node->ep_info->args.arg0 = 0xffff & read_mpidr();
 	bl_params_node->ep_info->pc = bl33_entry;
 	bl_params_node->ep_info->spsr = SPSR_64(MODE_EL2, MODE_SP_ELX,
-						DISABLE_ALL_EXECPTIONS);
+						DISABLE_ALL_EXCEPTIONS);
 	SET_PARAM_HEAD(bl_params_node->image_info, ATF_PARAM_IMAGE_BINARY,
 		       ATF_VERSION_2, 0);
 
diff --git a/include/atf_common.h b/include/atf_common.h
index 03cfcc69cd7..9ef1ef186e1 100644
--- a/include/atf_common.h
+++ b/include/atf_common.h
@@ -69,7 +69,7 @@
 #define DAIF_IRQ_BIT (1<<1)
 #define DAIF_ABT_BIT (1<<2)
 #define DAIF_DBG_BIT (1<<3)
-#define DISABLE_ALL_EXECPTIONS	\
+#define DISABLE_ALL_EXCEPTIONS	\
 	(DAIF_FIQ_BIT | DAIF_IRQ_BIT | DAIF_ABT_BIT | DAIF_DBG_BIT)
 
 #ifndef __ASSEMBLY__

---
base-commit: 3f19667468fb93bcb5702d23aa057b72639e3ac8
change-id: 20260901-typo-465ee352485c

Best regards,
--  
Vincent.

