Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB23C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 14:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5488686689;
	Mon, 13 Nov 2023 15:50:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FrgHOSL9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 852C58654D; Mon, 13 Nov 2023 15:50:23 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E8BE870F2
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 15:50:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.lan (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DF53541719; 
 Mon, 13 Nov 2023 14:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699887019;
 bh=giyIZR+CS3/bcZn88WuvnB4jISURESOJO9ImgIAW3PE=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=FrgHOSL9UWAqCcfN0K5nIjWn5HvYGPzj5ze6RRnRlrJKmRUBCwF+biD9bzX1m6iqC
 6EXWTM2G/uqMpfnDCZ1zDpBXeCLbphixOXf1YzNMhJke/SBF+FBWAe14L7XVB5/feq
 ID+zBxriSVaCgk5oiBGQpoPPadCYos9l7Rydv60WtELTGehuquF9VWymbqg4Uwm3XX
 91lsy3f4G1UKkxc/GSOkfCIvhzzJOfreaoCEAXIoFPxV4lmdlztuBZ3bEup2Ttt8x6
 iOZbTFqGM1nmYItbJDW/+YnMQJeqSZMePOfqdH1P/gTdQGTGWfszzpjXtc0szsGt6D
 si3Jsb6Nux2FQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: improve efi_var_from_file() description
Date: Mon, 13 Nov 2023 15:50:16 +0100
Message-Id: <20231113145016.7673-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

It is unclear to developers why efi_var_from_file() returns EFI_SUCCESS if
file ubootefi.var is missing or corrupted. Improve the description.

Reported-by: Weizhao Ouyang <o451686892@gmail.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_var_file.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
index 62e071bd83..dbf76f93de 100644
--- a/lib/efi_loader/efi_var_file.c
+++ b/lib/efi_loader/efi_var_file.c
@@ -204,8 +204,11 @@ efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
  * File ubootefi.var is read from the EFI system partitions and the variables
  * stored in the file are created.
  *
- * In case the file does not exist yet or a variable cannot be set EFI_SUCCESS
- * is returned.
+ * On first boot the file ubootefi.var does not exist yet. This is if why we
+ * must return EFI_SUCCESS in this case.
+ *
+ * If the variable file is corrupted, e.g. incorrect CRC32, we do not want to
+ * stop the boot process. We deliberately return EFI_SUCCESS in this case, too.
  *
  * Return:	status code
  */
-- 
2.40.1

