Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FD4CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 22:50:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90C7A87E13;
	Thu, 11 Apr 2024 00:50:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="UQJW9vN/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDF3188120; Thu, 11 Apr 2024 00:50:51 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F15768785F
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 00:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 486A83F1FF; 
 Wed, 10 Apr 2024 22:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712789449;
 bh=3LtLsCMmv1V6esy1+Ec04j1ftncyFDzBvAI8PkyMQ6Y=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=UQJW9vN/vyrYnZlnASmVri9Fd7Uaw44pdDJco9xbD29Wh2TnKXru8rEIp4v/RfMXd
 pODJjOb67PdHAJEIAW+XYXH0vc3NsgFy3i+iBWixMXF0kO/FSjZFS0D/FwdhzfFSMh
 IsdaMKYmmdxY6x2af+n3kofW9x6lSSV7I1G/wK8j3hm/5j8w4ehU9a3Q1gSXaPD3Cs
 BJh5J3dA+AKQT1fxVFDlk+taQj80rO+WtDzGBcGXwJXpRfaU3jRvTtJtFjyCd50ElK
 r5ph0SuJCc8OOAnyDI/iTmGuSONyJgR8V9qzBXjnT/JChgczA163L+280ChwCs/OU/
 5V3k77dkP6VYw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Eddie James <eajames@linux.ibm.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: sanitize efi_tcg2_final_events_table
 definition
Date: Thu, 11 Apr 2024 00:50:43 +0200
Message-ID: <20240410225043.40100-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

The length of the variable name typically is not 1.
Neither the length of the variable name nor the size of the appended
data is known in the include.

* Define the size of element variable_name as variable.
* Remove the unusable element variable_data.

Addresses-Coverity-ID: 467400 Out-of-bounds read
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/efi_tcg2.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/efi_tcg2.h b/include/efi_tcg2.h
index b21c5cb3dd6..a75b5a35b6e 100644
--- a/include/efi_tcg2.h
+++ b/include/efi_tcg2.h
@@ -150,16 +150,14 @@ struct efi_tcg2_final_events_table {
  *				the variable.
  * @variable_data_length:	The size of the variable data.
  * @unicode_name:		The CHAR16 unicode name of the variable
- *				without NULL-terminator.
- * @variable_data:		The data parameter of the efi variable
- *				in the GetVariable() API.
+ *				without NULL-terminator followed by data.
  */
 struct efi_tcg2_uefi_variable_data {
 	efi_guid_t variable_name;
 	u64 unicode_name_length;
 	u64 variable_data_length;
-	u16 unicode_name[1];
-	u8 variable_data[1];
+	u16 unicode_name[];
+	// u8 variable_data[];
 };
 
 /**
-- 
2.43.0

