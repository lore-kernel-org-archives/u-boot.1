Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69544C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 15:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BABAF84B85;
	Fri, 10 Jul 2026 17:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V3Yeiy4i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D27D84B85; Fri, 10 Jul 2026 17:23:51 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98CC784B72
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 17:23:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naveen.osdev@gmail.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-51c0006ea8eso7019091cf.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 08:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783697028; x=1784301828; darn=lists.denx.de;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0CFX2oTvC+jAgiHAe1EjHxdqWRamf8QNYwZwftjdd4w=;
 b=V3Yeiy4iQYY0XMRd9RJ8ai/a79kX/L7a5DiEt1xYodVAM0m1oPg9clPTkIfEiflcFU
 /Pa0OUdy+ttlC/pSAk/dbjSc60L/UFT607kgVnvkmBvbUy1VCCiCpZ8oFqqbIx6JdTrp
 maQ96FXe4PJE2R/3k9czNsRZov0wHpiTEx30ubVf4UlMbQdAVwVrCQrkMkwV3x/undUc
 k612lXnXG+TLmEKk/XRP6pAU+BK7FEGijftDNfYCPIS+LT3PrI3wEKkdKc+fdjlig8eF
 hQurX4frVYwVrPHC3fxmwEcv2DIv0xi3HQ6dtlb2u16n2rAzae5g5/hXiT/6Ozvxfssy
 BaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783697028; x=1784301828;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0CFX2oTvC+jAgiHAe1EjHxdqWRamf8QNYwZwftjdd4w=;
 b=bOqR3FwEMu/INAa6S4wWd+7Du9WjtzDDCQHrjE1rBqYoRUWrNmpvo7qM8R3eBYWLt+
 qx4AN0DZaXN6rKopyu3aMa0Pa1YDJxSXHt4yUQ71LXIGcjqOpFNTOoVedgxaztUff+RG
 VV10t4qz5eHFHmD5MLgQjmFPTo8H7lLXNqUkjbpydWdcwXU9jArnCzA7+uLfVVZpOntP
 +t3bgApqWeLECD0UfWh1k8Tz8P+Xhb1jvh3MtKMCRj38S0cwjm1GvrB/Uk32DnZW8T10
 ol8t6QRs45IyPFeJ8/aoihqLVgQuTjZI4myS2oERAgYp/KRveDHw/9VGqoFVzyOdUN+Z
 RxtQ==
X-Gm-Message-State: AOJu0YzAhoFHz8UjxnZhZAPfQ9uDP261/1Ewf1aOyFS2W4qY78C2gSX5
 U0kss1W6upF1e4hNW0FN2j0zy9QWYsQhIcUtdhql81qhHOd828skbAjLodThDA==
X-Gm-Gg: AfdE7cm5cPStnZlyfnCwx50KlOfW+V4dHwbpEY0fGOjIdZ/72ailRBGKOA06Csnjii9
 knMNkUIW0fVFYSnltxklrHJtL/xMhbNeDkLAJQb3m4W20K4RfZZ8eWUydgS0R+06VHGCV6NGp7a
 eggp6y6Q7wo/bMZ647E4hg/2DThUPqyLg2GYe4TBjUkmBS/Lss5Z9dK4Cgv3vY7H4GFqZewL1y7
 vRKgtvP5dgxk0dnkQTreBGWirU/z4gF9V53cDUHUxFiKAvZyhvZ6mnVoMJpJWmbIaJI+X/UteqY
 R4JXHeisRrdwM07mUYj5gy7qA6gWISt52NlUreQBIwsbbKYDgAZxwcPhmgxhJ3AZ72S5lxQmshZ
 Sx7rahkUlAUaXRS8FMzO7fXzIQsE9bTC+bVCA/IcBAidTF3K/svK0pCpLtX2ZD1GJeuXb01S3NS
 kkhu4IlMRFJg==
X-Received: by 2002:a05:622a:6d02:10b0:51c:b98a:244b with SMTP id
 d75a77b69052e-51cb98a3766mr10191171cf.62.1783697028395; 
 Fri, 10 Jul 2026 08:23:48 -0700 (PDT)
Received: from localhost ([49.36.187.33]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51cba49439dsm3896991cf.27.2026.07.10.08.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 08:23:48 -0700 (PDT)
Date: Fri, 10 Jul 2026 20:53:44 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH] cmd: strings: interpret second argument as a byte count
Message-ID: <j22mfoxsbrv264hukqkqdo3rr3lfnp3aramfno3proupzriafw@qe5czb3jnsyj>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The help text advertises "<addr> [byte count]" but do_strings()
stores argv[2] directly into last_addr and the loop condition tests
"addr < last_addr", i.e. it treats the value as an absolute end
address. When invoked as documented (e.g. "strings 0x40000000
0x100") the loop condition fails immediately because the supplied
count is far below start_addr, and the command prints nothing.

Compute last_addr as start_addr + hextoul(argv[2], NULL) so the
argument is used as a length in bytes, matching the help. The
existing repeat-mode fixup (last_addr = addr + (last_addr -
start_addr)) continues to preserve the same byte-count window
across CMD_FLAG_REPEAT.

Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 cmd/strings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/strings.c b/cmd/strings.c
index beac2a6e6b3..3727c00341a 100644
--- a/cmd/strings.c
+++ b/cmd/strings.c
@@ -21,7 +21,7 @@ int do_strings(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if ((flag & CMD_FLAG_REPEAT) == 0) {
 		start_addr = (char *)hextoul(argv[1], NULL);
 		if (argc > 2)
-			last_addr = (char *)hextoul(argv[2], NULL);
+			last_addr = start_addr + hextoul(argv[2], NULL);
 		else
 			last_addr = (char *)-1;
 	}
-- 
2.43.0

