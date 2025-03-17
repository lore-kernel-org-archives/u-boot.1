Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6272C35FF1
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 03:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B26E817EC;
	Mon, 17 Mar 2025 04:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742181308;
	bh=0v+ncBBcIl64mCsrytplpnmfZwB3+xF1v7ss+kB8J10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tr9exfQUDzcvwAJQ+hXawhg/++cBw5z0iRlGWV7/wBj4PI6+sEBa5YXYC58FJXwWw
	 6XAFv1v0JypXO6ejxx1B8ZHWoNy1uo0sKT4M9iwXtxePO75S7XsjCcE/1diPA1O52D
	 QUtZdXaY8m/nMF170BCyrhxILZwgmVfYWTqxxhkwXOCSuV3MH0I092ucsIbhmlhesb
	 n7jBlrRtpPE/s+aGOE4rP/kPxyq7Lj1BJllQ4aZodRtOqTcyLh8KatQm4tdBoaRQYX
	 KPDn41opHaji9QmS2dIukOCpJnJNa+WuJW190mwCCbd4uic2CBIbsRixt8U5pz0Gq4
	 2517K6XXtRQZA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6916F810EB; Mon, 17 Mar 2025 04:15:05 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D46E81760
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 04:15:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="D7xnmS/1"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 98B58101F7A30; Mon, 17 Mar 2025 04:15:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742181302; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=0v+ncBBcIl64mCsrytplpnmfZwB3+xF1v7ss+kB8J10=;
 b=D7xnmS/18zNesa4aL3N5OTsdO+KusXHKiqJdsuCJNMUqRqzsYvaOJdyDJVdtVIoIPvzvR2
 cDh1nXnDrkWIPcsDuiFw1KI7udoJuKsqDdirDShTNvrVgPg4o63XIrO204qRfg1T9iGAd4
 CYGrBnAUoip60ettkd01H7vQAbUsBW5immz2yIuuy8YIhF6+dyQVd5KeNde/de4j1LXUfa
 VnDdXQj8/xaFeZx0frpHVakZ1ASWNLOQ2oPhBnoH0v5Csv+bG1qRmWOlw6Gx6F7v5CKAH6
 7gkOd74c6Hk0e3cLbLlx8+6DrnOShHtco/blndE2bggHnIUW3kpgyE+G3uFEHA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 09/11] fs: exfat: Demote filesystem detection failure
 message to debug()
Date: Mon, 17 Mar 2025 04:12:48 +0100
Message-ID: <20250317031418.223019-10-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317031418.223019-1-marex@denx.de>
References: <20250317031418.223019-1-marex@denx.de>
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

Demote "exFAT file system is not found" message to debug(). This is
printed when U-Boot attempts to auto-detect the filesystem via generic
filesystem API by attempting to mount the device, and fails to do so
because there is another filesystem in place. The libexfat-fuse code
prints this an error, which interferes with 'test_gpt' test. Demote
the message to debug().

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Baruch Siach <baruch@tkos.co.il>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Hiago De Franco <hiago.franco@toradex.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Add RB from Tom
V3: No change
---
 fs/exfat/mount.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/mount.c b/fs/exfat/mount.c
index c17a84735fc..0ff297af67b 100644
--- a/fs/exfat/mount.c
+++ b/fs/exfat/mount.c
@@ -226,7 +226,12 @@ int exfat_mount(struct exfat* ef, const char* spec, const char* options)
 	}
 	if (memcmp(ef->sb->oem_name, "EXFAT   ", 8) != 0)
 	{
-		exfat_error("exFAT file system is not found");
+#ifndef __UBOOT__
+		exfat_error(
+#else
+		exfat_debug(
+#endif
+		"exFAT file system is not found");
 		exfat_free(ef);
 		return -EIO;
 	}
-- 
2.47.2

