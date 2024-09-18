Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC736CDD55C
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 21:43:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AFF388FD6;
	Wed, 18 Sep 2024 23:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ePlz0xZP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18A5B88DC1; Wed, 18 Sep 2024 23:43:47 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43D4688FF6
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 23:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-110-162.46.114.pool.telefonica.de
 [46.114.110.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id AD47F3F384; 
 Wed, 18 Sep 2024 21:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726695824;
 bh=YrNf9DsKfkUcQTpz0WI9m4nSC/65pv9++lQZQHbmY2I=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ePlz0xZPQbSrU2CUjHSrn6M9sJXv7H5wkyumjXPVARKeEweoMq+CHS1ANfz2EKhg6
 pS8P/2RzyqFkY6tQGw6gJwL/8o9cqzF8K1olVdfEZExGsE0FpXh4Pk2OnD5Ych8r+k
 PlwE3FhGh8IjhbsTMyW/BwzP6O9fKYq7Qj5beL1cM+E0Zzk9Ke6q2480rqU6rTJ0RE
 wnnoWA3rt7q+vS5CGu9jQII/hK/MnsOgqSuDKTGez6Kl7GFM6BxgJ9w2PCskCdMtSt
 N+tZrtOa0mVdFCebNmEZK19s2yD2h6T6rBuzHysr6deCr52J8iB7KEgMTS+J02jqfP
 lkSGVySv1a2pw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd/efidebug: fix some function descriptions
Date: Wed, 18 Sep 2024 23:43:42 +0200
Message-ID: <20240918214342.20197-1-heinrich.schuchardt@canonical.com>
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

The function name must match the name used in the description.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/efidebug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index 1a191eb9994..e040fe75fa1 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -665,7 +665,7 @@ enum efi_lo_dp_part {
 };
 
 /**
- * create_lo_dp() - create a special device path for our Boot### option
+ * create_lo_dp_part() - create a special device path for our Boot### option
  *
  * @dev:	device
  * @part:	disk partition
@@ -1127,7 +1127,7 @@ static void show_efi_boot_opt(u16 *varname16)
 }
 
 /**
- * show_efi_boot_dump() - dump all UEFI load options
+ * do_efi_boot_dump() - dump all UEFI load options
  *
  * @cmdtp:	Command table
  * @flag:	Command flag
-- 
2.45.2

