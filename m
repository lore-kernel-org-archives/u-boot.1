Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302E8C79F87
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 15:02:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36A2440CA6;
	Fri,  4 Sep 2026 15:02:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kxLTQYZF2XtY; Fri,  4 Sep 2026 15:01:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C4C4340C9E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788534119;
	b=mGtaLwlmr0clTT41+DZesmnGefrJUylR6tiOGQuQy3OiPjENmsLcZQNIIpgyuNBEfICk
	 ZYkll8wOrdNkDSAhB/laOJ3ZFDeyqm1oNE+Sn2RCGaxTrbk3MHJbpd2e0K8T6qy55OW8V
	 4xctD4YLOVYqrrYGTl7DaVTOt8SuFL9Y+Bmu7BGZn9M4b9csOpdSDEGhyzPaRUycDsGk2
	 8edM6aFWQtsjcycHpLfBQx0hnHADsFISsatw2J1OM20AzM0LYvV+SAy1El87HUHJwEaf3
	 +N1o47QVekPT42DpzHxxFEXmG9rlI5E2VQTVrsSfSuVl5ZXjj5kGljPTvr5Viq2Mrow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788534119;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NbpmhjWLv5xtdJQqfvl7v48AefIe6NRIyGAlTguYZfs=;
	b=oQRTdAltBO+MBxCeRO4RlwVs5fcxCHVayDIEAhrT9nXWH2UVS98bie9BnnP2OpIrFJu9
	 atpRlHAfkQDZhRELfdFB1dJBiE9sXitZFc7ZojwiCRlG9FwgPwAl6hKWrocBVBEErwSm0
	 ucUJ/G7eoXyIPX0k/KGHdQADUqyku8jFHG8O05/YPbMb/X6p76K9klQL4AFBcFeEvIeGc
	 qee1XR0xlRtAGZC7b42m6udFOQSSgNRJjU0ay2AqTTXiaVvfkVEc9w9EK2pKdgH+l1RCc
	 LdAJqZ5kbbwiF+GvMiWJlYrG4nsXHdoqxii/mnSNG1pWG2JvZEvRsqNjEED4sBypWJg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788534119;
	bh=NbpmhjWLv5xtdJQqfvl7v48AefIe6NRIyGAlTguYZfs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QKtF8oxlL76u//i/XzhuFO8bkydcUzCLXLKt4cM6gF4FIGVCw+MpFFiHVcjLIwb/m
	 0t7GOt60C/E29EWytAfNXFwqlzNvC3fkp++vPHeJFend2vwoROIuaaKtRZysO2sCL6
	 9o5G5T+1WAh3QjXAf8qbbkh3lqPeJxtfz770Fy1/NhaLtvcySS5vsEXGNLEH1SNhX2
	 booXTYW9/PPehyO8JIiHnizL2nu6GCO3Jhc4vOJS9w9fAUyUU+jPRmYK5DZqJrVPkh
	 Bbl92NeMU/UzVRj5O0jmTdIZ8hrK2XMzKJyxZqDLB3a7Auxvq4hlV9dnnszyr67o5K
	 X717HZjWCaDIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4C4340C9E;
	Fri,  4 Sep 2026 15:01:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DA173363
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 15:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CC83060BFF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 15:01:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hI4gysBdB6Iw for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 15:01:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B382E6083C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788534115;
 b=fTC4PE/3ng9ste7hJtXqBFbrwpJs8beNKlt9G8AOB4Ou2nW3Medl0AVek6HHqTCs/D6L
 h08aryt+15IX/JivdZrF3QHhY4PwUJic5XeUpEcksv6y7NBMrKWOkG0TTOiwFUxE793LZ
 74bIbvwe5rONo4UlWE/TNFROD76QNa/o60HX6rCSJb4PYEueBkdlay/gWi/3WnnUR58AS
 rJqsHR4SeMNLV0NtehzscwwsxhX9B0MhZUxfOoFKnPV8L6JVMZGTYZs+4Gj9/Xl9jMPq/
 BFohNYnmxrsb2SCnzHxf3No+18eh3AppGfGKKVtECBpqcYw9wfYFQRqv2CRD4W//UXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788534115;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=NbpmhjWLv5xtdJQqfvl7v48AefIe6NRIyGAlTguYZfs=;
 b=K20UUmCx8beNREhTdklwep0jUdFRQcooiPjvv42NpQGM9RtIDMFoNoRUFwKvcfE+BStt
 FVnntPVGkbsK3/YYmfU1MlIO/uosOQk9pSkRZFjioXFIL5wH6F9puyBUXAx+PFNQiMCFb
 KIo+GdriEBwetQekSS/qdCrpgsy9hxZLi2ygOk2oKNlUq1Vx3gBWiPzVGmSjjPDYbTZgq
 4hB1kDzWhomDWGch0Mb4jJikt3qb1OO8U0w5mLU2nOHl7UHpGz1Y8twhxYRHgVDu5aoDO
 b+IFDcAQ/CB5uycV+U8W2AwZpYFaw+CEMxfodEjo3beu9v8ZMXXSwjxeGGqMjwu0NPQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=T6TftYKO; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=T6TftYKO
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id B382E6083C
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 15:01:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CF051570;
 Fri,  4 Sep 2026 08:01:49 -0700 (PDT)
Received: from [127.0.1.1] (unknown [10.57.49.254])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77AA43F673;
 Fri,  4 Sep 2026 08:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1788534113; bh=EILY1xDloa3t4BIxlUqMoe5NP/MKX6UwonZcKh4S1Lc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=T6TftYKOhGIA4bCtmznvMbY4NSGTQ11Fbq1c9aDyFOiEYGgd37XG6JOe66x61H3hq
 SDAkEIhNT1hsJDQK9fa6m6AI5daF0N96XSgoFI8mQY/nukX7cYg6XqK/bTL3NDhOYP
 qUbtAObU0F9FDZiIvEqRmW9XxGv836hYX+DyE+no=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Fri, 04 Sep 2026 17:01:38 +0200
Subject: [PATCH 2/5] efi_loader: add EBBR 2.2-2.4 ECPT entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-conform-v1-2-475b2947631a@arm.com>
References: <20260904-conform-v1-0-475b2947631a@arm.com>
In-Reply-To: <20260904-conform-v1-0-475b2947631a@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Shantur Rathore <i@shantur.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5480;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=EILY1xDloa3t4BIxlUqMoe5NP/MKX6UwonZcKh4S1Lc=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqmt1a63HkXwFc5UuhKDrapSc+6NZPBlQu4qqeX
 s0ZHKg+eg2JATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCaprdWgAKCRDLSfhWdqMG
 lNYxB/9AFSYe0G9dyHsmD0RMGKd/QITOKo/mMlDmpBOqCThNKj9HErj8wC+xYvTwWHP6Er5qYo5
 5droypvw1sHqUlT+UqKenurjzhfg3N5MF7rrY4BnmLTM62VpE+qeEdJzrMZou7AXg2fdpjyUM03
 3esLrGj1YqxnOMhUeUKghea3FJ9BoorVUC4FzBPHGPkw1TeS4imX3i/ck3CNBlXkRECTXHOg1G0
 n7QYLLihKDCG2PO6h9joggYDFC1yxSTMvD18E179OopfIm8dQpVwmjgKBt68WE3s0ncJaSc8BIj
 gvMOCMXUS62GdQeN/xCknCr7pQtTTBWYvu7eYUvl+7XJqwRZ
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

Add three ECPT entries for the EBBR versions 2.2, 2.3 and 2.4
conformance profiles:
- Define the three EFI_CONFORMANCE_PROFILE_EBBR_2_[234]_GUIDs.
- Introduce the three HAVE_EFI_EBBR_2_[234] non-visible configuration
  symbols to compute the actual system conformance status with the
  dependencies.
- Add the three EFI_EBBR_2_[234]_CONFORMANCE configuration menu entries
  to control the addition of the corresponding GUIDs in the ECPT.

Following what was done for version 2.1, as many entries as possible are
added optimistically by default in the ECPT, and this can be overridden
manually by the system integrator after inspection if necessary.

Conformance cheat sheet:

  EBBR  Additional requirements
  ----  ---------------------------------------------------
   2.2  TCG2 & capsule "on disk"
   2.3  Authenticated capsules in FMP format & boot manager
   2.4  Non-UEFI (privileged firmware)

We do the following configurations dependencies approximations:

      Configuration symbol  Used to approximate
  ------------------------  ------------------------------------
  EFI_HAVE_CAPSULE_SUPPORT  Firmware update is performed in-band
                    TPM_V2  A TPM is present

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 include/efi_api.h                | 12 ++++++++++
 lib/efi_loader/Kconfig           | 52 ++++++++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_conformance.c |  9 +++++++
 3 files changed, 73 insertions(+)

diff --git a/include/efi_api.h b/include/efi_api.h
index d4fdd50c49e..17e55118cda 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -238,6 +238,18 @@ enum efi_reset_type {
 	EFI_GUID(0xcce33c35, 0x74ac, 0x4087, 0xbc, 0xe7, \
 		 0x8b, 0x29, 0xb0, 0x2e, 0xeb, 0x27)
 
+#define EFI_CONFORMANCE_PROFILE_EBBR_2_2_GUID \
+	EFI_GUID(0x9073eed4, 0xe50d, 0x11ee, 0xb8, 0xb0, \
+		 0x8b, 0x68, 0xda, 0x62, 0xfc, 0x80)
+
+#define EFI_CONFORMANCE_PROFILE_EBBR_2_3_GUID \
+	EFI_GUID(0x7721fc77, 0xa724, 0x11ef, 0x8e, 0xaa, \
+		 0xf7, 0xc9, 0xb1, 0x94, 0xba, 0x75)
+
+#define EFI_CONFORMANCE_PROFILE_EBBR_2_4_GUID \
+	EFI_GUID(0xf2bb0422, 0xda8e, 0x11f0, 0xa6, 0x7b, \
+		 0x1b, 0xe2, 0x20, 0x85, 0x40, 0x98)
+
 #define EFI_DEBUG_IMAGE_INFO_TABLE_GUID \
 	EFI_GUID(0x49152e77, 0x1ada, 0x4764, 0xb7, 0xa2, \
 		 0x7a, 0xfe, 0xfe, 0xd9, 0x5e, 0x8b)
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 40380876959..8ac4165b996 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -578,6 +578,27 @@ config HAVE_EFI_EBBR_2_1
 	depends on EFI_CAPSULE_FIRMWARE || !EFI_HAVE_CAPSULE_SUPPORT
 	default y
 
+config HAVE_EFI_EBBR_2_2
+	bool
+	depends on HAVE_EFI_EBBR_2_1
+	depends on EFI_TCG2_PROTOCOL || !TPM_V2
+	depends on EFI_CAPSULE_ON_DISK || !EFI_HAVE_CAPSULE_SUPPORT
+	default y
+
+config HAVE_EFI_EBBR_2_3
+	bool
+	depends on HAVE_EFI_EBBR_2_2
+	depends on EFI_CAPSULE_AUTHENTICATE || !EFI_HAVE_CAPSULE_SUPPORT
+	depends on EFI_CAPSULE_FIRMWARE_MANAGEMENT || !EFI_HAVE_CAPSULE_SUPPORT
+	depends on EFI_BOOTMGR
+	depends on BOOTMETH_EFI_BOOTMGR
+	default y
+
+config HAVE_EFI_EBBR_2_4
+	bool
+	depends on HAVE_EFI_EBBR_2_3
+	default y
+
 config EFI_ECPT
 	bool "Enable the UEFI ECPT generation"
 	default y
@@ -593,6 +614,37 @@ config EFI_EBBR_2_1_CONFORMANCE
 	  Enabling this option adds the Embedded Base Boot Requirements (EBBR)
 	  v2.1 conformance entry to the ECPT.
 
+config EFI_EBBR_2_2_CONFORMANCE
+	bool "Add the EBBR v2.2 conformance entry to the ECPT"
+	depends on EFI_ECPT && HAVE_EFI_EBBR_2_2
+	default y
+	help
+	  Enabling this option adds the Embedded Base Boot Requirements (EBBR)
+	  v2.2 conformance entry to the ECPT.
+
+	  Version 2.2 adds requirements around TCG2 and capsule "on disk".
+
+config EFI_EBBR_2_3_CONFORMANCE
+	bool "Add the EBBR v2.3 conformance entry to the ECPT"
+	depends on EFI_ECPT && HAVE_EFI_EBBR_2_3
+	default y
+	help
+	  Enabling this option adds the Embedded Base Boot Requirements (EBBR)
+	  v2.3 conformance entry to the ECPT.
+
+	  Version 2.3 adds requirements around authenticated capsules in FMP
+	  format and the boot manager.
+
+config EFI_EBBR_2_4_CONFORMANCE
+	bool "Add the EBBR v2.4 conformance entry to the ECPT"
+	depends on EFI_ECPT && HAVE_EFI_EBBR_2_4
+	default y
+	help
+	  Enabling this option adds the Embedded Base Boot Requirements (EBBR)
+	  v2.4 conformance entry to the ECPT.
+
+	  Version 2.4 adds non-UEFI requirements.
+
 config EFI_CONSOLE_DISABLE_ANSI
 	bool "Disable ANSI escape sequence queries for console size"
 	help
diff --git a/lib/efi_loader/efi_conformance.c b/lib/efi_loader/efi_conformance.c
index 470141af483..c1234681bb6 100644
--- a/lib/efi_loader/efi_conformance.c
+++ b/lib/efi_loader/efi_conformance.c
@@ -29,6 +29,15 @@ efi_status_t efi_ecpt_register(void)
 	#if CONFIG_IS_ENABLED(EFI_EBBR_2_1_CONFORMANCE)
 		EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID,
 	#endif
+	#if CONFIG_IS_ENABLED(EFI_EBBR_2_2_CONFORMANCE)
+		EFI_CONFORMANCE_PROFILE_EBBR_2_2_GUID,
+	#endif
+	#if CONFIG_IS_ENABLED(EFI_EBBR_2_3_CONFORMANCE)
+		EFI_CONFORMANCE_PROFILE_EBBR_2_3_GUID,
+	#endif
+	#if CONFIG_IS_ENABLED(EFI_EBBR_2_4_CONFORMANCE)
+		EFI_CONFORMANCE_PROFILE_EBBR_2_4_GUID,
+	#endif
 	};
 
 	ecpt_size = sizeof(profiles)

-- 
2.53.0

