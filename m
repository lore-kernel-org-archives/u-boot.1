Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21664E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 22:08:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D0C9801EB;
	Thu, 12 Dec 2024 23:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gerz.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gerz.io header.i=@gerz.io header.b="Nr0lTDct";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32270801A9; Thu, 12 Dec 2024 23:06:51 +0100 (CET)
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [188.68.61.103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 407CA801A0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 23:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gerz.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=burak@gerz.io
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
 by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4Y8RQJ5t5hz873H;
 Thu, 12 Dec 2024 23:06:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gerz.io; s=key2;
 t=1734041208; bh=jmwB2W7ZKqjkUZS3jZafDT7JHLK0Y3us6x2MmZSUgm0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Nr0lTDctW9bxmliySK29c22UApWqdVEe4M3Uf4gaAKCwQ4iMgrg+RcPIWWxuXalyv
 m5MPA7ptTvoqmOB4pyxqBxCGlxE/kRlY/JMcCM6N8lNLVOQFDmgBHO7UM90uxy3TEy
 Xnb61Zal39Id4J7AQMJcX6rxXE0+yDkWOzD7eoQlKCI4IjGoyhAjKwkCSkNvqLMcY8
 ni4i+D8xBBokbsyP3iZ4PqFw+/c9lOnoWq3eeMtUwqx3OB+cXmhFC2nKtp2PXPlGBM
 e5m14iBM2jWVacpgM7kJCjDyHVLjt/lnoTnfsyLH3QxiSVnxhmSIsZ1PlNbDHJ13nE
 Y6ckl7ryIU/sg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4Y8RQJ5SKrz8732;
 Thu, 12 Dec 2024 23:06:48 +0100 (CET)
Received: from mx2e3f.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy02-mors.netcup.net (Postfix) with ESMTPS id 4Y8RQJ43Z8z8sZP;
 Thu, 12 Dec 2024 23:06:48 +0100 (CET)
Received: from localhost.localdomain (adsl-84-227-222-208.adslplus.ch
 [84.227.222.208])
 by mx2e3f.netcup.net (Postfix) with ESMTPSA id 69EC06040B;
 Thu, 12 Dec 2024 23:06:43 +0100 (CET)
Authentication-Results: mx2e3f;
 spf=pass (sender IP is 84.227.222.208) smtp.mailfrom=burak@gerz.io
 smtp.helo=localhost.localdomain
Received-SPF: pass (mx2e3f: connection is authenticated)
From: Burak Gerz <burak@gerz.io>
To: u-boot@lists.denx.de
Cc: Daniel.Venzin@mt.com, eballetb@redhat.com, manut@mecka.net, burak@gerz.io,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] efi_loader: enable support for file renaming
Date: Thu, 12 Dec 2024 23:06:28 +0100
Message-ID: <20241212220635.25971-2-burak@gerz.io>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212220635.25971-1-burak@gerz.io>
References: <20241212220635.25971-1-burak@gerz.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <173404120436.21016.12521411030247298800@mx2e3f.netcup.net>
X-Rspamd-Queue-Id: 69EC06040B
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: QEzk7buEvz5sk3GLwU56fxIL36RBSbz5dRWweb8=
X-Mailman-Approved-At: Thu, 12 Dec 2024 23:08:35 +0100
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

EFI applications can issue a file rename to U-boot - add support for
this

Signed-off-by: Burak Gerz <burak@gerz.io>
---

 lib/efi_loader/efi_file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
index 95b3c890ee..b4d1a9dad5 100644
--- a/lib/efi_loader/efi_file.c
+++ b/lib/efi_loader/efi_file.c
@@ -975,14 +975,15 @@ static efi_status_t EFIAPI efi_file_setinfo(struct efi_file_handle *file,
 		}
 		pos = new_file_name;
 		utf16_utf8_strcpy(&pos, info->file_name);
+
 		if (strcmp(new_file_name, filename)) {
-			/* TODO: we do not support renaming */
-			EFI_PRINT("Renaming not supported\n");
+			if (set_blk_dev(fh) == 0 && fs_rename(fh->path, new_file_name) == 0)
+				ret = EFI_SUCCESS;
+			else
+				ret = EFI_DEVICE_ERROR;
 			free(new_file_name);
-			ret = EFI_ACCESS_DENIED;
 			goto out;
 		}
-		free(new_file_name);
 		/* Check for truncation */
 		if (!fh->isdir) {
 			ret = efi_get_file_size(fh, &file_size);
-- 
2.45.2

