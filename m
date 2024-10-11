Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468D2D24470
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 17:34:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 903A989291;
	Fri, 11 Oct 2024 19:34:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="G4kWRaay";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7D1B89321; Fri, 11 Oct 2024 19:34:00 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF45288FCF
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 19:33:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 29BA73F1E0; 
 Fri, 11 Oct 2024 17:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1728668038;
 bh=vajMN3luEeO8eVYSxsf+bjIZOWBZpP4MbrZa3JhNWJU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=G4kWRaaySzJYJyBArZ4LuQ0vHzsXsZKbaDJTe2mU+AMCqufUEMHbT540m4gWYo4V5
 nokwsQJ8D/BJxixcK8N4Lp8ENJT7XqO0tqmRosejuco9czQmRm+3WOLGYfFSVQjGBB
 35Inl09mNkkWQ7rHFVNN5W4lYz7ERtfBriiO6GJiMTLp/Dacw3YXU5ASL/wkmLQhh5
 IuErRDGFAodD58YZL5fSZAObcO/4rv6iiqS16AcKdjopDvMvUP/mxcm0M578GT01tY
 +p2c5dB18vvrMltvqpQjHHkh1eTAINRoKpYLYZq8bc1osabftua/LtWGaRXee91/7e
 YIHeoAwJMfbYQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: provide variable BootOptionSupport
Date: Fri, 11 Oct 2024 19:33:40 +0200
Message-ID: <20241011173341.24330-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The UEFI variable BootOptionSupport is required by the UEFI specification
[1]. It reports if specific types of boot options are honored.

We don't support any of these extras. So we should set the value 0.

[1] 3.1.4 Boot Manager Capabilities, UEFI Specification 2.10 Errata A,

Cc: Vincent Stehlé <vincent.stehle@arm.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_setup.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index a610e032d2f..05d035f4eb5 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -179,6 +179,22 @@ static efi_status_t efi_init_os_indications(void)
 				    &os_indications_supported, false);
 }
 
+/**
+ * efi_init_boot_options_support() - indicate supported boot option types
+ */
+static efi_status_t efi_init_boot_options_support(void)
+{
+	u32 boot_options_support = 0;
+
+	return efi_set_variable_int(u"BootOptionSupport",
+				    &efi_global_variable_guid,
+				    EFI_VARIABLE_BOOTSERVICE_ACCESS |
+				    EFI_VARIABLE_RUNTIME_ACCESS |
+				    EFI_VARIABLE_READ_ONLY,
+				    sizeof(boot_options_support),
+				    &boot_options_support, false);
+}
+
 /**
  * efi_init_early() - handle initialization at early stage
  *
@@ -261,6 +277,13 @@ efi_status_t efi_init_obj_list(void)
 	if (ret != EFI_SUCCESS)
 		goto out;
 
+	/* Indicate supported boot option types */
+	if (IS_ENABLED(CONFIG_EFI_BOOTMGR)) {
+		ret = efi_init_boot_options_support();
+		if (ret != EFI_SUCCESS)
+			goto out;
+	}
+
 	/* Initialize system table */
 	ret = efi_initialize_system_table();
 	if (ret != EFI_SUCCESS)
-- 
2.45.2

