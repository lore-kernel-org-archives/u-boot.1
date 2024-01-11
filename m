Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7F7C4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 08:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D83FB878B1;
	Thu, 11 Jan 2024 09:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="l4mWohVV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A5F6878C8; Thu, 11 Jan 2024 09:25:43 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 816D88786C
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 09:25:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.home.xypron
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CFB0442FE1; 
 Thu, 11 Jan 2024 08:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1704961541;
 bh=H05jHx3eFDt1UZgV/BaQFCFwnLzP7x9z02f8kdoR2Dk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=l4mWohVVEkKng8G/CqSRFxIOsghypb5AyFFGVpu3wKrpfuTzmLyz4gEvkWMuoaVSI
 mAHYkIsiZcM8V1hGNcJkbagWR2nCf5ISAP5pYzYOWPUpQSUGJNPeoMtE2vVFCJ7jg9
 ZLAF5LycS3CFNC4yFEUJ0OLHGdXsruTcnDuyaTmeDG9L7ivlgSgtXO79/pXyNlESpP
 OXiffNiDE2a43h+kBx3MZMNJQFxkIOnLVbwfH26UA8nxrNa7s3MiRT5bODs0KVSiCQ
 4Oy0wrGIhJBhpnH07nwveopS3hDkel+ty3hFeTO1WCmFYNE8gtvy1KD1E5tYJGY7jA
 qSRXNnMz2ZEfg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] cmd: efidebug: check pointer after memory allocation
Date: Thu, 11 Jan 2024 09:25:35 +0100
Message-ID: <20240111082535.191136-1-heinrich.schuchardt@canonical.com>
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

After calling efi_alloc() we must check that the return value is not NULL.

Fixes: f01c961ee34c ("cmd: efidebug: add uri device path")
Addresses-Coverity-ID: 477185 Dereference null return value
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/efidebug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index e10fbf891a..997469b485 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -754,6 +754,10 @@ static int efi_boot_add_uri(int argc, char *const argv[], u16 *var_name16,
 
 	uridp_len = sizeof(struct efi_device_path) + strlen(argv[3]) + 1;
 	uridp = efi_alloc(uridp_len + sizeof(END));
+	if (!uridp) {
+		log_err("Out of memory\n");
+		return CMD_RET_FAILURE;
+	}
 	uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
 	uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
 	uridp->dp.length = uridp_len;
-- 
2.43.0

