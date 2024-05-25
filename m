Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245DCC25B78
	for <u-boot@archiver.kernel.org>; Sat, 25 May 2024 08:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1316D8836D;
	Sat, 25 May 2024 10:11:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IvCFPp82";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52F47883E4; Sat, 25 May 2024 10:11:03 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42B3E8817B
 for <u-boot@lists.denx.de>; Sat, 25 May 2024 10:11:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=net147@gmail.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-24cbb2b71b4so525647fac.2
 for <u-boot@lists.denx.de>; Sat, 25 May 2024 01:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716624660; x=1717229460; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DFYnt2A1m1eEMW9he0XIbzkXBb54P4RC5QwmlAEU9Qg=;
 b=IvCFPp821jyKcGqI03TLEOxGV7Dgpog226qsszxUxJW7m4h3UdrL1RxG9nlUk8LbSA
 dsSL8jCN4BVR839BWZr22nCrG9dgKbMIAmOCZf/UONtLG5iP+wRZOVKHZ2BFwwADGTF0
 4xUzYslJ29MeHUXDUL45gTduEHDSRFNbjFltk4c9DVDKKqevY5yeX+PBD1NGl4O1YPtu
 I1YMTz+U88nQPEaZzIugGe7+xU1Znog8s9QdQSPUynw8jd7Y++XuN4bib5e94z8hAEkt
 kJR3zTidVTgd02MiGWK9AOOySlv/pPVXTVDZ0c2NwygRXCTHaWe8HcikKp3XRXMA8AeX
 rMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716624660; x=1717229460;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DFYnt2A1m1eEMW9he0XIbzkXBb54P4RC5QwmlAEU9Qg=;
 b=r8Om98/ak0G7aLaKmFE8lRp2H9vxip07xupbiudThmw9DOC4o6IA4TplvsZLQE6gHh
 JSFB28tHCFfwaumAC5sTbeiu/B3tf/KcD8t0Hhly82bqPkEFcY/2RAjK3hVJ+QYUpoWE
 g1LJoaqIXKl2SbEt/nlZPqFJTQ9mX7sS6RfjEhJoxJ1gvedNASNR3UGtpbdkdpAQ3ZHy
 YfwYfoSZysbNhdw73w5VHjEQToCL2GUu4mhyz8Y05Ku2/qPnhRUtoEKBZk6x7XRJRBVD
 cWXKd/7FJrEibDmEcqSXNFzAvYXsCzY+oZlj8w/5x6nH1LKV4DAaFvf3xqplxMsLs9PW
 6lUg==
X-Gm-Message-State: AOJu0YxP5cHWe+vo+rRN3BoC4mY1x8qc1iNbykzNEznh88LVTdwXMiRg
 ph5KwgEjFdsRi/CylXGxSjdafjJn3sMArT0ZsxAnUbTxLIdTLA9u
X-Google-Smtp-Source: AGHT+IH74aY4m4YXf5NUap3oe562AFxMaRIeuU/eKmfB8Ro0Ey2gkHu/Ep1xepgqV+r6KDp1PXsRiQ==
X-Received: by 2002:a05:6870:3289:b0:23c:e5e3:8771 with SMTP id
 586e51a60fabf-24ca151bf60mr4488157fac.42.1716624659791; 
 Sat, 25 May 2024 01:10:59 -0700 (PDT)
Received: from 167-179-157-192.a7b39d.syd.nbn.aussiebb.net
 (167-179-157-192.a7b39d.syd.nbn.aussiebb.net. [167.179.157.192])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fc05bb88sm2080015b3a.62.2024.05.25.01.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 01:10:59 -0700 (PDT)
From: Jonathan Liu <net147@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jonathan Liu <net147@gmail.com>
Subject: [PATCH] sandbox: enable support for the unlz4 command
Date: Sat, 25 May 2024 18:10:53 +1000
Message-ID: <20240525081053.2818481-1-net147@gmail.com>
X-Mailer: git-send-email 2.44.0
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

This does not work with sandbox at present. Fix it up to use map_sysmem()
to convert an address to a pointer.

Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 cmd/unlz4.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmd/unlz4.c b/cmd/unlz4.c
index 5f20838e899..4b66794a72c 100644
--- a/cmd/unlz4.c
+++ b/cmd/unlz4.c
@@ -7,6 +7,7 @@
 #include <common.h>
 #include <command.h>
 #include <env.h>
+#include <mapmem.h>
 #include <u-boot/lz4.h>
 
 static int do_unlz4(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -26,7 +27,7 @@ static int do_unlz4(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_USAGE;
 	}
 
-	ret = ulz4fn((void *)src, src_len, (void *)dst, &dst_len);
+	ret = ulz4fn(map_sysmem(src, 0), src_len, map_sysmem(dst, dst_len), &dst_len);
 	if (ret) {
 		printf("Uncompressed err :%d\n", ret);
 		return 1;
-- 
2.44.0

