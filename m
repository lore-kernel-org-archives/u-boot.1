Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF90C982EE
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 13:12:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C71780C04;
	Mon, 21 Sep 2026 13:12:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id If_aCFuhK8M9; Mon, 21 Sep 2026 13:12:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A3A7D80BE5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789996364;
	b=qu6VEKwxcjut0ZUu5qyFqHUFIz1ssuNE0gCEEAIZOVFY3RD4sR/jsX52vwiuo4s0ReVV
	 cIGI2z1UejVfBGxHdv9kGK/BKc6uODt8P9xouCriyBHz4o5BnOZ1F4dtiX+97pFhji172
	 AMwEk3F03wW47d2djIOyqBK9tief7dsWqI1dLqzfJrCmuAQPhtCGQ4B98dzyV+ZHQiUsh
	 1TLs+XzqTGXHzjhpJ1RBl2DH8qv57dpkUiixlyKFgIfX53EJL4RLlwnADuP7w9fc4gi3x
	 XfQ85ZKgvONE+AplGsRvUzx91hAXL+RfCKT750YDV3qnAGlWeXtAMtlQtR7GjWwZr/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789996364;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0FdoypC5NZraymoZLUokvqm+j0+LkI0dnCNnvtgMWBQ=;
	b=NX+T22L3lMJ/uEc1Fbl8cFiZh5zWbZr90Nf2q/ybjSx1u0dqnKzKzyDmhkcIWaG2dXFR
	 ufG8Qas549ukBQbzL5l0zR53ZUL7JDSf/MLFEGxYapgy3tFfcKvf/Pt41bmco7smWZnPA
	 qyFOW5jWz9E0K+XnjGnW3OIZoDGL731t2hJLdKYG1cfhaerbsrdTwfrK049V0/Ri7Plm3
	 Yfbhg8+1ebF0sq1zWQ9RvR6f2S80lrzyq064XN+NEfwG8+TjSTGTo4XKTpbIh5abNrP4N
	 RiG/AmImRXdFhRfSq8uV2arP8Zp6XcFIJrvB8YyBGOyja8/k6jw+ZzPeGdsBVOgsCig==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789996364;
	bh=0FdoypC5NZraymoZLUokvqm+j0+LkI0dnCNnvtgMWBQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ufWT+/ylP9cqnqwqnUM5yoe+HljnLmWBCnG41epaHPXKkw92qg0KcBzIKCpEjbkHw
	 GrML2J9agu8JzmiDgMJ8NHsBxabA4qX4dsbPTwMvzcLtZpeDNBjQDNjMT46Bqebhs6
	 5vCiev1hEiuC/8hoBh2Djek17HBpqlnol8LDl2SP24wtqDaJAwB7CL4uXDV0exicUO
	 MKqp8zIZMWdp6winXiSL+xsdsvMR54itlNfMzb24xV4aBfJGhNnGdM3hctCjJF6jmd
	 uRn6vZD3zMgPEXCjscP2KpZgEKyH+uBBn4lN6WvbcjErkDFAfw+Ym5IrmxyxlLzLIv
	 U86pcXspF9EBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3A7D80BE5;
	Mon, 21 Sep 2026 13:12:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E2E6B522
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:12:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C9F52405F3
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:12:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VlKtm4VBBLI2 for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 13:12:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A9428404A1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789996354;
 b=WQj7IEoyYeu6r1QxXEqBFGLUnD7Ro0dK+/r1bIfrRzL7pErvxWitZmgcAmLIHqP5QLY8
 BkFDKwXcGtwtDC6IXsYEhI+eowYuC7/sBlfM22ksxTZQ8eovW+zO4FU4Y1HQfTd+Ixu/Z
 FoLf7lpW59G88fPozB0vCHOMqnrCozB6+hmHm8zYfZFhJM+M/I2EH9fUO2StkpNgMFcj0
 ZNv6t3k8YMWHU48HiN/n8vpSfv32k+LeIMERi7Wd9h8fS7HdY+0XKgt4PYXQEJTK89Lyu
 LZE9qveQscv66TqhPNk9jeHThm0Ky9c038rb1EeeE1xrdxJMm181hxUUKj3bPMZWIpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789996354;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=0FdoypC5NZraymoZLUokvqm+j0+LkI0dnCNnvtgMWBQ=;
 b=NgHkTFGKds63MUQ6Q3oHHsxIhRxR82sT63JGy6LFLIanrEjX73wwBJFTGn3iFOaNQOn7
 xHcjzCoxz3V5Li7ouDXTkRaTBKRByrwPpRWXS4GXGKw2l2W04qXz6gyAqCsK3w5qx0ZIa
 pwlFyjtxB0+Q3xJeR1Ol6+0I1InKhVdK9KOEWKilLr9a4t3sdS/GCoVRjV2lYI3V70JJB
 v2i199jbP9l1vNrYgQ+BSGTDXDqLpW+h+7r3LxEtLUgfd1VH1YoW69aMgMRXE7g0q/S+M
 hNhYU3JEkgvA6m8zZoxhOfNi3eWFO8jiLQjZ2trTXaDx+7DBIJVXW7ZZhlEZQkPRZfQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b="onj/m8G4"; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=onj/m8G4
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id A9428404A1
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:12:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A0601D6F;
 Mon, 21 Sep 2026 06:12:30 -0700 (PDT)
Received: from [127.0.1.1] (X72Y076X74-2.nice.arm.com [10.34.125.10])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E66A3F86F;
 Mon, 21 Sep 2026 06:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789996353; bh=jvWU4XCrL8eJj5O1XbHY/hVoF5MDT3Aec4MMT4HBO3w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=onj/m8G4N3DnalZedlg5Uwoyt66sA1/Z3Xg2QfAKeswfhhy5hG9I50VOodp/1cKVn
 Bjsr+im41FIWOoJHEeit3g8SnHH6lr2oaM3uEbClo5cnO2RJvTiIOiIy0EdreMCWcL
 Xf5+9POdCItzPsXVUVDh3gvEoM6sdEOSawN9Ufaw=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Mon, 21 Sep 2026 15:12:18 +0200
Subject: [PATCH v2 2/5] efi_loader: add EBBR 2.2-2.4 ECPT entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260921-conform-v2-2-daeb00359af9@arm.com>
References: <20260921-conform-v2-0-daeb00359af9@arm.com>
In-Reply-To: <20260921-conform-v2-0-daeb00359af9@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Shantur Rathore <i@shantur.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5445;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=jvWU4XCrL8eJj5O1XbHY/hVoF5MDT3Aec4MMT4HBO3w=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqsS08l69QT4dG1b2J5SaMi5n0nwyfdEwnvlIFv
 IQgDdkDqNCJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCarEtPAAKCRDLSfhWdqMG
 lL8dB/9iLA6nfX68seTKQNiK271kskVcsKb/+exMQP/UnDhUqb+GT5Zmj7X67SBzAEuQx6/+BOP
 fO7i1qweBmfVJEcR8zh7jI8ZiI3oZj9cwEC/lHHuWMmfXA2IduG9FiVi5BZpGXjCCcH758jNa1X
 xK5hFiSBW3AejX7dxYMfWhPghu+G+mXsXGiA8alMxgWO4dielVVDRcHQyoACkuGg4lWkQg9HlWK
 Qb52jgzvrZhe1l6HbkquMTvONNIwqIsQje+SCSuL/iJy0jT5CqrknPMfH5rXffjvxHKFhUS8fuR
 F0JJ0tyu/90jsf/ddTkfNDdLD91lgv7OcygClre/K8wua2oS
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
 lib/efi_loader/Kconfig           | 51 ++++++++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_conformance.c |  9 +++++++
 3 files changed, 72 insertions(+)

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
index aad8f860868..81231533946 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -577,6 +577,26 @@ config HAVE_EFI_EBBR_2_1
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
@@ -592,6 +612,37 @@ config EFI_EBBR_2_1_CONFORMANCE
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

