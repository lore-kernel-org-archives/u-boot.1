Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D71DC369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 16:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EAFD8081A;
	Thu,  1 May 2025 18:47:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="shYyswHp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 320EF81FDE; Thu,  1 May 2025 18:47:27 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F11C68070C
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 18:47:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2da3b3bb560so784031fac.3
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 09:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746118043; x=1746722843; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=SMNXUG2hpUiiE5yTmuhRwTi/t4EzNbGMRiJel44R9h4=;
 b=shYyswHpdcti9wSj01I/e/vw6CYZ4eCqpFQsFFuCRB/3N3JyyDLkI5iXk2cnqlN5HH
 76QOUxU2ogdthvb+n6MuVJ3QC9t/lJqnOCe10a8Ckvb2+Xt0+UFek4HKaDSloTP/ASDL
 VdznVif7xooMaxYTC/V7LSGtaz9NXlkTrYoO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746118043; x=1746722843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SMNXUG2hpUiiE5yTmuhRwTi/t4EzNbGMRiJel44R9h4=;
 b=rBozvQgDZ0/oXWJzB6zZzhFUZ1cppFhoB6u4YiOYYN3M/RogGOLQLXZb9JV8EdCaS7
 tK37DZKEQQuQ7YvNfj0g+PAhIPWlYfha7uXqzx/vncyBdO1w05htRbJKaxTYO2qtmvEu
 at9shYMb7T2OVvjJ7Rl1zPEDatAwcfJ+VvasZaSrjfUr09AR9JJybJrvmxxMtX8qlvN5
 K1IYOeKtUM247J6VKD6PTyUFEg6Mh+O3OZyiJsjepYZPBuJzp1bBnbG1mG/Er/KBgXii
 y3YLDwqdINWybtCPBBeLOZR7vDIScIbI6xFCPmkoFLVOdvr9v26fJw2FbUqr4Bs0Ow2D
 RoYg==
X-Gm-Message-State: AOJu0Yzy3tpnduz6aOGjcQZgMIXcodCd/i8pslBM4aXbDYbsQmRFsG0V
 4CDmoOedauBUA5DraN/4mlTDoFpcrdSEM2bSyswI1IfHDpwjMaClYKac+YoQARMNFgl9Eqx4o1y
 e
X-Gm-Gg: ASbGncvxx5NbIK86Cg35YP9i1qi6+HTwmnCg+IKN5ZZYs6lKwnzoGnE7VCJrdoiC88F
 suBgS/xR3w+S6hgUNnPNVKyiWxfC73fGbXUQCedGZeX1ENk5E+Auhih7izBNrIWWqPGdxWl3j6K
 u1RU1bJpeMxkP1OuWtUSR/evdCzp41unaej85wI+iiGyUuZ9BzL2q8VVBvPuSo2sKAR2chd/Cmq
 YPdexe+4N1iSzGGoL80bw2CeW7DJKOmFF8ndsMaL4sZEl0ztQO+DjTUdY/46cwafJ3Tb3CjV0SF
 /CYd2hMvJTkhRuaErA4e89Z/9d4ID+FM8dYC7C6RBeQuJjxtMjjX4CrVeU1Ez9GNBmDw+uLTHep
 fovgp
X-Google-Smtp-Source: AGHT+IG01mUbykY9jFg7gWr+CeU2+ynXkCVX9OKfJrfRTZcIznzkYN0EqRzXTJ1mgpA4hxbYgBDS1g==
X-Received: by 2002:a05:6870:1792:b0:2bc:7d6f:fa86 with SMTP id
 586e51a60fabf-2da934167camr1857433fac.35.1746118043609; 
 Thu, 01 May 2025 09:47:23 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa1207425sm193656fac.39.2025.05.01.09.47.22
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 09:47:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/4] cmd/cat.c: Add missing include
Date: Thu,  1 May 2025 10:47:18 -0600
Message-ID: <20250501164721.1494370-1-trini@konsulko.com>
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

This file references errno values and so needs to include
<linux/errno.h>.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 cmd/cat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/cat.c b/cmd/cat.c
index 6828b7b364e5..3167cda60327 100644
--- a/cmd/cat.c
+++ b/cmd/cat.c
@@ -8,6 +8,7 @@
 #include <fs.h>
 #include <malloc.h>
 #include <mapmem.h>
+#include <linux/errno.h>
 
 static int do_cat(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[])
-- 
2.43.0

