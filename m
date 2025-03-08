Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D83C282EC
	for <u-boot@archiver.kernel.org>; Sat,  8 Mar 2025 20:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE73B8169D;
	Sat,  8 Mar 2025 21:16:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741464985;
	bh=UHHKnFonwue+WXIKvH4YuEyD4WTFVUOzJjppiJOui9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EXQy4fBXLAxeUgOcAJa5LhfCEMVdEaJzcRXKHdqvUICDQjBAPo04ZN972Mqj3+jGw
	 vSHqVgwJ/+m8tcHF9HauJXFPxkkiFJ8/KkWbOM9zUF/dzZsNQGP3er7snLO7gsvUpZ
	 77BrpD0nqZVmJ+yWvcnk4qpvgnfhhyzIObZ17aRigcE3sjylctTv8ZJDDnSvaFyDRm
	 0dtTary9y0boLUiiILEPpTTXGsGg24JO4jemznz035GV8h55aqX18/TSlOIVVf/cC6
	 rDIc5euTqmEMbJGa1vvG5heJJe0ye8XOEV45obKT1x6miHDflZdSfAHAsOuAHggrJP
	 WCqMxfwmj3/kg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFD9A8169D; Sat,  8 Mar 2025 21:16:24 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E524F803CC
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 21:16:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="FDVZSHjX"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3C1BA101E897E; Sat,  8 Mar 2025 21:16:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741464982; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=UHHKnFonwue+WXIKvH4YuEyD4WTFVUOzJjppiJOui9I=;
 b=FDVZSHjXkMUR0iIZ2KlKD3Wo3rjg/odpbMJPoeDF6p15ZEt0/dKJYjRGkkR8jfJIadD8TF
 BpEtlFq4baax12HpHji2qmjdcPvHwEcvynW1of1Y2bFN5vKyK72g+SiwTeUcIKAYA5RQus
 dYMEq4dg33KSjYtQ0Mgj9lzC0IKht06wSQOqFfY7/SBQzyMSDsDXNg5+HR1bGh/XmMbXpt
 2iZLPk+5a2sJ7JfaEJWdvOc8GEQ5Szoee+0lCs+75Ck25FcvPJAwvARdc4scbPEPm/BH/l
 yCeNdAvgag4NCva9o6HUWOXoRU1CkPyg42D6JWkVcc+d6Ta93/C7iTRnngxInQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/12] fs: exfat: Demote filesystem detection failure message
 to debug()
Date: Sat,  8 Mar 2025 21:12:13 +0100
Message-ID: <20250308201533.1315951-10-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250308201533.1315951-1-marex@denx.de>
References: <20250308201533.1315951-1-marex@denx.de>
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

