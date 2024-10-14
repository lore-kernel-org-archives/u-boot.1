Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C60D1812C
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 16:08:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C3F289005;
	Mon, 14 Oct 2024 18:08:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=devpi.de header.i=@devpi.de header.b="gz++J+OZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 368EE8910D; Mon, 14 Oct 2024 18:08:51 +0200 (CEST)
Received: from smtp6.goneo.de (smtp6.goneo.de [85.220.129.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4ABE88FBD
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 18:08:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lehmanju@devpi.de
Received: from hub2.goneo.de (hub2.goneo.de [85.220.129.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp6.goneo.de (Postfix) with ESMTPS id 510EA240CB1;
 Mon, 14 Oct 2024 18:08:45 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub2.goneo.de (Postfix) with ESMTPS id 3341D24030E;
 Mon, 14 Oct 2024 18:08:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devpi.de; s=DKIM001;
 t=1728922123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=T4pneX3d6qT2FZDkbozHLp4hvyMy5t4wCTtyDx7uvlE=;
 b=gz++J+OZmkK3fNWrmdyWxdizzcTwwYPVsbsdHoYSyUcZJ5Ox1QOEJ8px+U4astdb6oTLbM
 6IHzJNBc2vl6/l0/uAly+8KkeO/z7VHSoZh2Mz/oj87x1aA26xwfMis6XKIN16518WIZB8
 QFVdAUFAUiL4zHQiikogFhNsv1THDZ0crXb2ZXcOl2cIGludIWtguH0bJiaQNUpWClKEGj
 i0Sh43bRpylrHBYTTYqBPrejPpU/IQlZYrfvOGVwfzUTgxogj1JjgZUfZtZp9MXjMibVpQ
 M+qwEeT9A3IT8Ex5lQYbAnQ7nCmGKR+k30EtA6iTMtchzsmzDhSgLwXIFoyEug==
Received: from p200300cbef3987100000000000000193.dip0.t-ipconnect.de
 (p200300cbef398710000000000000076d.dip0.t-ipconnect.de
 [IPv6:2003:cb:ef39:8710::76d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub2.goneo.de (Postfix) with ESMTPSA id DCF79240192;
 Mon, 14 Oct 2024 18:08:42 +0200 (CEST)
From: Julius Lehmann <lehmanju@devpi.de>
Date: Mon, 14 Oct 2024 18:06:35 +0200
Subject: [PATCH] scsi: fix disk capacity too small by one sector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-fix-scsi-disksize-v1-1-0edb9959b580@devpi.de>
X-B4-Tracking: v=1; b=H4sIAIpBDWcC/x2MQQqAIBAAvyJ7bkFNEPpKdBBdawksXIhI+nvSc
 WBmGghVJoFJNah0sfBROphBQdxCWQk5dQarrTPaOMx8o0RhTCy78EOY/Bi08TGk7KB3Z6Uu/c9
 5ed8PzKlEXmMAAAA=
X-Change-ID: 20241014-fix-scsi-disksize-d73a017cadf4
To: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, Julius Lehmann <lehmanju@devpi.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1566; i=lehmanju@devpi.de;
 h=from:subject:message-id; bh=n/pNrEMW0wSFZQ3OvQiqu+vcNRsNkql3IYd3icAs6Bc=;
 b=owEBbQKS/ZANAwAKARK2S7xC0EEDAcsmYgBnDUIK9nKMlUZF5IhjT+nn5sMX7w+c98hRdQfIs
 n+XFrkrmRyJAjMEAAEKAB0WIQTCqoxFzEvlxm0XalUStku8QtBBAwUCZw1CCgAKCRAStku8QtBB
 A2NKD/0fVE+eudu/EeSEKkNvrvzq/vpJEcDAkdOab8m6/cNNg6W9pBoysZwzH5xZ3r/MPCaA4NL
 jT/zo6Y6PbkpGGSMFPejxepjN/sIBK5Dbk6pSx2IOhE302vUDhWzoolw1fscQneX9IiMbSsyj3o
 6I+cJoYoTU33oB4/3yUg9ncQ875oSs84OpwuH4Ids8wNBngZtAL3hZsg8i/Za93FHoU2jw8h0pB
 yxOOG03/QJTNTT4B5WGuACYNb+uBeoCfwFd2VpD8Nn42Sp9Zo5WRT3guFfs241mnoLFX9ewkM5O
 kcSyZCXaP/bNaFrz3jTFVMoJmhOvvr7jsJdXczSN5p5JlxAgtwWm94EaBoE/Y9gXnUEC5PaiU+U
 yeOxjAe3+Gztlgz/dbm4cjzQ2mFx9ZtCno2Oc6LA1ciYo3JlRvztWPBEIGkBa+NmYspK9Rin7Ma
 VTwxFhLS7isxMhRy6xU541PQZMgWp8NTJ3ocpeTeUtPavC/CvCw/AzP9u0ZHxNNohJPmRYb8e1/
 lbv4XkysX56JXLU6WV46nqQ1WoL7dQIrp32r8c0daXGgnsT+jRPyJ/X9quTaiO7PytnKCYX2APT
 XHl5NyNnE3knKGA6frnDEdhr9rtwKOFfp8YzsQdybpIVuBajPgfvgtWqoYMADW9UfQetQFjLscL
 m8BbJnlYyUzwIZw==
X-Developer-Key: i=lehmanju@devpi.de; a=openpgp;
 fpr=C2AA8C45CC4BE5C66D176A5512B64BBC42D04103
X-Rspamd-UID: aa5397
X-Rspamd-UID: af9695
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

SCSI READ CAPACITY reports the address of the last
block and the block size. The total number of blocks
is thus last block address plus one.

---
This patch fixes the disk size reported by scsi. Up until now, the reported disk size is too small by one sector. Read/Write operations on other sectors have not been affected. Trying to partition scsi backed storage via ums has resulted in "storage too small" errors.

doc: https://linux.die.net/man/8/sg_readcap

Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
---
 drivers/scsi/scsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 51cacf3479236be6c6ea3e7d15b87e03f10e7f3a..bcdeda95ed1514119057cc67974fec465cf5672c 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -309,6 +309,7 @@ static int scsi_read_capacity(struct udevice *dev, struct scsi_cmd *pccb,
 			 ((unsigned long)pccb->pdata[5] << 16) |
 			 ((unsigned long)pccb->pdata[6] << 8)  |
 			 ((unsigned long)pccb->pdata[7]);
+		*capacity += 1;
 		return 0;
 	}
 
@@ -332,6 +333,7 @@ static int scsi_read_capacity(struct udevice *dev, struct scsi_cmd *pccb,
 		    ((uint64_t)pccb->pdata[5] << 16) |
 		    ((uint64_t)pccb->pdata[6] << 8)  |
 		    ((uint64_t)pccb->pdata[7]);
+	*capacity += 1;
 
 	*blksz = ((uint64_t)pccb->pdata[8]  << 56) |
 		 ((uint64_t)pccb->pdata[9]  << 48) |

---
base-commit: 29e5dbc55c64c6450f066c55a5bc48bd1717aa1b
change-id: 20241014-fix-scsi-disksize-d73a017cadf4

Best regards,
-- 
Julius Lehmann <lehmanju@devpi.de>

