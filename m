Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CB0C369AE
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 08:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDA9582A65;
	Sun, 13 Apr 2025 10:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744534702;
	bh=JWYvabKTy7xPTkfDIp/lE3JtHmtIYTujumewUcymK0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cc8JNrvzf2n6lwfykGzlYZtY2VQP4w52udL+g15gjhZAa6XWFLJX12bLgfybY7hUm
	 KYP1L0r28oeXld258lkdL8zm9lBHPRZXDmrRT86QUkqVGa8/X5w/7tlrOeFgBnfv89
	 E2pgGlpltijDpnyHpLSn+LkQZOeowyHSuHixf388ZuTx0vEUy1v/Ofsmss4ceAJ6KY
	 Xsa5wokiWoUBCGhThAFvFgFVgdOOdWHAOeE1g2+K17VpjcrSrnnykTlDuq2vIW1spP
	 qXS4r8IUWwwHlDanylv+aplvQ6K6qCkQGenXiv8mWtqIQYeeqD4y7oyO5K2j+QA+3h
	 s/GEX9a2lk+BQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3976C82917; Sun, 13 Apr 2025 10:58:21 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FBCA82944
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 10:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="TQR67o7i"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 62CE81007B829; 
 Sun, 13 Apr 2025 10:58:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744534698; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=JWYvabKTy7xPTkfDIp/lE3JtHmtIYTujumewUcymK0M=;
 b=TQR67o7i1X/1wceHtCPjHR5Pq/XExXZ6tijonPXStFiLxQ1i4u8LahgVvqh3xdn5Cj809Z
 xH6D+zM1iHggLxogcBDQAMAj8lVvy2EyCR5FdOCtpIlf8AILTz2G2skWQdkmsXP1Vs1qOf
 oB6MjeRpBqc22AGAhcXuDk8spxJB9o5s5se+WeKpr63Uk5za4u2QDyxiCEJdZtnKbYDXIA
 SRePEzcP9EdE1UgVvWThphhCdef2HK/JHPB2Ec6hABWngoXJQWoz1Vf5U0+RYFIFZELErJ
 4Pxuq94yZflV+GjIFPM4AlvsOQcGA7oYdImf3atiBDpdXnyG7I2nuij25kn1pw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/7] fs: exfat: Implement trivial 'rename' support
Date: Sun, 13 Apr 2025 10:55:04 +0200
Message-ID: <20250413085740.5953-6-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250413085740.5953-1-marex@denx.de>
References: <20250413085740.5953-1-marex@denx.de>
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

Implement exfat_fs_rename() to rename or move files. This is used
by the 'mv' generic FS interface command. The rename implementation
for other filesystems was added recently and was not part of exfat
porting layer due to merge issue, which made 'mv' command crash,
fix this by adding the missing implementation.

Fixes: b86a651b646c ("fs: exfat: Add U-Boot porting layer")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 fs/exfat/io.c   | 5 +++++
 fs/fs.c         | 1 +
 include/exfat.h | 1 +
 3 files changed, 7 insertions(+)

diff --git a/fs/exfat/io.c b/fs/exfat/io.c
index 43c05713ed0..c56f5675987 100644
--- a/fs/exfat/io.c
+++ b/fs/exfat/io.c
@@ -1013,6 +1013,11 @@ exit:
 	return err;
 }
 
+int exfat_fs_rename(const char *old_path, const char *new_path)
+{
+	return exfat_rename(&ctxt.ef, old_path, new_path);
+}
+
 void exfat_fs_close(void)
 {
 	exfat_unmount(&ctxt.ef);
diff --git a/fs/fs.c b/fs/fs.c
index 0b62217fd59..1f36872fb9a 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -401,6 +401,7 @@ static struct fstype_info fstypes[] = {
 		.ln = fs_ln_unsupported,
 		.unlink = exfat_fs_unlink,
 		.mkdir = exfat_fs_mkdir,
+		.rename = exfat_fs_rename,
 	},
 #endif
 	{
diff --git a/include/exfat.h b/include/exfat.h
index 7e43beeb348..75fce5b6566 100644
--- a/include/exfat.h
+++ b/include/exfat.h
@@ -20,5 +20,6 @@ int exfat_fs_unlink(const char *filename);
 int exfat_fs_mkdir(const char *dirname);
 int exfat_fs_write(const char *filename, void *buf, loff_t offset,
 		   loff_t len, loff_t *actwrite);
+int exfat_fs_rename(const char *old_path, const char *new_path);
 
 #endif /* _EXFAT_H */
-- 
2.47.2

