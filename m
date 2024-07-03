Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EDCC30653
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 10:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FA4888805;
	Wed,  3 Jul 2024 12:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="WsRe6nGR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF08F88802; Wed,  3 Jul 2024 12:13:09 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E4548880C
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 12:13:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9C2FB148A8F1; Wed,  3 Jul 2024 12:13:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1720001585; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=PvzGQcTWYxE8hyNe1j7ZSXJH/oYZ2dasR3m8wWtSKpg=;
 b=WsRe6nGRDxSgzT9oghzrlPxa1XI5GnpnXdIRJp3zJpIr/4v3rBXnidoFNTpBvGOjg8KSaP
 7K4a8Pwb73gweleDCj8oyYNKh2KA5m7T9Dcj+RIEnT6jEutHlG5pT5RRPxQqFXoARvSW6y
 ek9eOiUBWqDBpakn/6lr+59jAsmlYNc/+rddb5wOm9btmDqjYfhlHu57p5r4R5Qyt4ehKc
 QxByxXhjpvh/u9I8bCuYbEqY+/nL+CDojhtV3f1aaMFD+lAhjcKQEt2tcvwKXfMAyMVgpx
 7fOOpl14xiSV5aknYIpDcrXPyecIBS6a/0BSVYsiBEt8mk4tvR+Pc1Ydez6y0A==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Heiko Schocher <hs@denx.de>,
 Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/4] fs: ubifs: Set pointers to NULL after free
Date: Wed,  3 Jul 2024 12:12:56 +0200
Message-Id: <20240703101258.1670825-3-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240703101258.1670825-1-ada@thorsis.com>
References: <20240703101258.1670825-1-ada@thorsis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Global superblock pointer 'ubifs_sb' and volume pointer 'ubi' of type
struct ubi_volume_desc in private member sb->s_fs_info of type struct
ubifs_info, can be allocated and freed at runtime, and allocated and
freed again, depending which console or script commands are run.  In
some cases ubifs_sb is even tested to determine if the filesystem is
mounted.  Reset those pointers to NULL after free to clearly mark them
as not valid.  This avoids potential double free on invalid pointers.

(The ubifs_sb pointer was already reset, but that statement was moved
now to directly after the free() to make it easier to understand.)

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 fs/ubifs/super.c | 4 ++++
 fs/ubifs/ubifs.c | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 788f88f0495..321c9b9351e 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1758,11 +1758,13 @@ void ubifs_umount(struct ubifs_info *c)
 	ubifs_debugging_exit(c);
 #ifdef __UBOOT__
 	ubi_close_volume(c->ubi);
+	c->ubi = NULL;
 	mutex_unlock(&c->umount_mutex);
 	/* Finally free U-Boot's global copy of superblock */
 	if (ubifs_sb != NULL) {
 		free(ubifs_sb->s_fs_info);
 		free(ubifs_sb);
+		ubifs_sb = NULL;
 	}
 #endif
 }
@@ -2061,6 +2063,7 @@ static void ubifs_put_super(struct super_block *sb)
 #ifndef __UBOOT__
 	bdi_destroy(&c->bdi);
 	ubi_close_volume(c->ubi);
+	c->ubi = NULL;
 	mutex_unlock(&c->umount_mutex);
 #endif
 }
@@ -2340,6 +2343,7 @@ out_bdi:
 out_close:
 #endif
 	ubi_close_volume(c->ubi);
+	c->ubi = NULL;
 out:
 	return err;
 }
diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
index 58b3f3659c1..506e29958c3 100644
--- a/fs/ubifs/ubifs.c
+++ b/fs/ubifs/ubifs.c
@@ -928,6 +928,5 @@ void uboot_ubifs_umount(void)
 		printf("Unmounting UBIFS volume %s!\n",
 		       ((struct ubifs_info *)(ubifs_sb->s_fs_info))->vi.name);
 		ubifs_umount(ubifs_sb->s_fs_info);
-		ubifs_sb = NULL;
 	}
 }
-- 
2.39.2

