Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DA1C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 19:15:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E2B881A04;
	Thu, 13 Mar 2025 20:14:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741893274;
	bh=Y9Rsa8Pmpb26lXmX4k6dB874SfI3wCnnSLHNpfz0Ytc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ef9p8axlObQgjjn+6dYjP5tz9vMH/5SlkKjTg1lOtoHVOsxarRXfxeLhKboK3T3de
	 nnfZlXcU85yxr7dgOV4IURA+1pf/Cq+9CkvrMwUQ1vbLzl4p3ZfZ9/rr3FiDfX2rxb
	 OMGZLoRgzKkV/uggwdPAzgdlnR3qiXTkXBvxpCkL6Lnjy9P2BQpetnqzcZgKP6XWIc
	 cjwQIUb9G2RsS/7NEJrdolWrJ3lv8NZ/75D7TchRZE3UTTpjPzPrroYRTynCAYVRnb
	 pRokQJkT5l1CFKMDluzoINtVxxU/ucfV7jV8vQs2hEar1PFWKzFyqos2b/wNOThucG
	 Vr5mCjCJh+Zrw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2881810E8; Thu, 13 Mar 2025 20:14:27 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6C73819D9
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 20:14:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="YG+UlIIC"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4CC561020211A; Thu, 13 Mar 2025 20:14:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741893262; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=Y9Rsa8Pmpb26lXmX4k6dB874SfI3wCnnSLHNpfz0Ytc=;
 b=YG+UlIICCy8wfRv+BpqHCXByiabdc5gU18vaPKFqjkQZuR4iRvYJlig5uqqCf0hdhVlgLm
 dppF6k81CO0BAS2gtoqRUakPCQGWSGxzeXVba9VASSsmQmTnfeisjIYcgSH07Bqh1UQA8Y
 8xQh+ctpJetCNbtKpVMMWoG524NpGZ//BOujM3wuHnJMdxv8v8Bxp9LIJEUehFjbhKAlm7
 szdkgsU6iTaYaomPMaLR9tMqXPWZxhSk35xJVdvYQQh08dxP5B+K0DzbRSgd2ChoYpyGlr
 vpu/whOpNbWFuMcPLcDnSi1+3S95wgK6T0AvHJo710Rv9SDaaNnOpggFyk0Z9w==
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
Subject: [PATCH v2 09/11] fs: exfat: Demote filesystem detection failure
 message to debug()
Date: Thu, 13 Mar 2025 20:13:25 +0100
Message-ID: <20250313191348.170054-10-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313191348.170054-1-marex@denx.de>
References: <20250313191348.170054-1-marex@denx.de>
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

