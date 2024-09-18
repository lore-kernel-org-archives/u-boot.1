Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BF0CDD55C
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 21:51:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8375B88FFD;
	Wed, 18 Sep 2024 23:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="AYnaHXI+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06FCD8900B; Wed, 18 Sep 2024 23:51:39 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F27D88FC7
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 23:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-110-162.46.114.pool.telefonica.de
 [46.114.110.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 85EA33F1C6; 
 Wed, 18 Sep 2024 21:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726696296;
 bh=qb+8RIKMSRUBLoWfmJgO/TMaPdgz5HJeOJmG6hRy27c=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=AYnaHXI+dzFo6kI8GkaWgyBS2rxOQIp7tTj3hH0w71/ZjdosDE0ATNPiTzGVHy90f
 XiVvbxypttbLU/Oh4KjWn+3PqiNP4tdOX8iDT6MCR7lM6e8Rg7L9f8Uzc9S0/Zxje2
 GprGou0MDUtc5f3EEbOetUr/uOYsp9JZH3Nu1vyezh7qYi1oveusIoQYmQQt/qhb7L
 7SYwzwdpjNWX5dYqS69W5ZgzmwYhAxDgeF0lZCRqtkd+P/mM8wf5XV19bRMo3asrUU
 oEAooHO7Fp7nnYxmvaaHzyBsRZTepDG9kd/S5fhyD00Pelrv6Cn6mzt+2OwoJAKfSm
 8x/Z+vzpt3O5w==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: correct efi_set_variable_int() description
Date: Wed, 18 Sep 2024 23:51:34 +0200
Message-ID: <20240918215134.21110-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

The name used in the function description must match the function.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/efi_variable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/efi_variable.h b/include/efi_variable.h
index 223bb9a4a5b..4065cf45eca 100644
--- a/include/efi_variable.h
+++ b/include/efi_variable.h
@@ -38,7 +38,7 @@ efi_status_t efi_get_variable_int(const u16 *variable_name,
 				  void *data, u64 *timep);
 
 /**
- * efi_set_variable() - set value of a UEFI variable
+ * efi_set_variable_int() - set value of a UEFI variable
  *
  * @variable_name:	name of the variable
  * @vendor:		vendor GUID
-- 
2.45.2

