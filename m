Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F38F3D32A
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 16:14:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3F2E83F2E;
	Thu,  5 Mar 2026 17:14:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80AE983F75; Thu,  5 Mar 2026 17:14:02 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 80F8C83F2E
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 17:14:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96B52339;
 Thu,  5 Mar 2026 08:13:53 -0800 (PST)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.129.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1FD343F694;
 Thu,  5 Mar 2026 08:13:59 -0800 (PST)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/4] lib: uuid: add EBBR 2.1 conformance profile GUID
Date: Thu,  5 Mar 2026 17:13:46 +0100
Message-ID: <20260305161349.2317130-2-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305161349.2317130-1-vincent.stehle@arm.com>
References: <20260305161349.2317130-1-vincent.stehle@arm.com>
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

Add support for printing the EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID as human
readable text.

This is added in the GUIDs range, which is compiled in only when
CONFIG_CMD_EFIDEBUG is set.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Tom Rini <trini@konsulko.com>
---
 lib/uuid.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/uuid.c b/lib/uuid.c
index 0a166320e07..d9d5414d4bf 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -254,6 +254,10 @@ static const struct {
 		NULL, "EFI Conformance Profiles Table",
 		EFI_CONFORMANCE_PROFILES_TABLE_GUID,
 	},
+	{
+		NULL, "EFI EBBR 2.1 Conformance Profile",
+		EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID,
+	},
 #ifdef CONFIG_EFI_RISCV_BOOT_PROTOCOL
 	{
 		NULL, "RISC-V Boot",
-- 
2.51.0

