Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58CDC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 09:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A0A1888D4;
	Wed, 24 Jul 2024 11:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="beMT9DPa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5C6E888CC; Wed, 24 Jul 2024 11:51:14 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68FB9888D4
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 11:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3683329f787so3594792f8f.1
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 02:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721814672; x=1722419472;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XYMNXtV5yAkUO/WAv6knShMF9ZW7boatBCduP1wxqz0=;
 b=beMT9DPajTZcAWBbbBene6Y/CIMGdCE6KvHfEf/sr/c2jf3stN7JNCO8ZjwT8sAyCC
 HTUB/Ed32wpC5E+sxSodoU0WHyB7526k2UPE+aVezFaA6N6uEjjMITkYkZc/CU+8yWCL
 1eTzfXgSdnq6vooYVE61fn60AKu+7OxSI9vnnBt5Vg8pDZdYICukbbA2amgxkZi4vlkN
 +LU+ALO4NhKfyazxD6lIHp3m13l6+zIoA+xm0QS1Uk1SfLDH8whorWtEBI8Gkg+HfJdw
 /PcqQq/9KkOJ1E3qua47P4jUO8O+pHnVtQXjPyBfJmJ9EsvoBPqIHhmmRB7HzEl15OWl
 U26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721814672; x=1722419472;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XYMNXtV5yAkUO/WAv6knShMF9ZW7boatBCduP1wxqz0=;
 b=YlmMSI1rT2Hts5HhnkxyOlBTgrjpUru3qnKWf6SpQ4d6Qy3ebwgqjeSFhhjEg3I5Ky
 SAbMeMdhZOIMzDzyduWEykRX3UpKikTjhVPEDtmkNov1RMEuNBPBnAAZocXhL9Ic+cyZ
 PYzqBGIyZLUjqDtcf2qTe4KwQVuE42Pc7linqQspiZjFg2ExXabxFrBG5LP+9hlBsvZj
 QKeRGnLUjJj1OPASi9hVdx4ITic0MKFtZKxgBTNZGRM0dh3iGyuKUTLRkBJ3GgIMaKSX
 OXNzs26CqWfiqmvSD9jG6cDCUZ8xMiigstACp2VpSSeu3ZAdQEmV9s8Ax6+t981Nr+Fc
 dq5w==
X-Gm-Message-State: AOJu0YwtBj3xJjQpsYr4rj0yaSIhs76UbggRJhfK89b3fKutxrdlrQ61
 6I4RIThhXn64uW5c+aKOZvAhVAi2ZwRUwCn48fVvdGaGS0sycNEUkoZCZ8O9HCo6LquIFKOHSLR
 M
X-Google-Smtp-Source: AGHT+IHDAF0tgI4dNAgF0v5i9eT8/G8hfs9VFnc/N0vCdYuS2MnHhlLbEijvY2LSihh+9JKiXL7IDA==
X-Received: by 2002:a5d:510a:0:b0:367:9765:b2ae with SMTP id
 ffacd0b85a97d-369bae9983dmr7800241f8f.61.1721814671503; 
 Wed, 24 Jul 2024 02:51:11 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868ac54sm13831889f8f.28.2024.07.24.02.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 02:51:11 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Wed, 24 Jul 2024 11:51:06 +0200
Subject: [PATCH] cmd: bcb: Fix segfault on invalid block device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-bcb-crash-v1-1-44caff15bce4@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAInOoGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyMT3aTkJN3kosTiDN1EE0vDVDMDYzNDoxQloPqCotS0zAqwWdGxtbU
 Aqy1mD1sAAAA=
To: Tom Rini <trini@konsulko.com>, Cody Schuffelen <schuffelen@google.com>, 
 Dmitrii Merkurev <dimorinny@google.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14.0
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

When blk_get_dev() fails, block NULL and gets de-referenced in
the error path by a printf(), resulting in a crash.

This can be reproduced on sandbox with:

$ ./u-boot --command "bcb load mmc 0 0"

Fix the message by using the functions arguments (iface, devnum)
instead.

Note: partition (being a global static initialized) can be used safely.

This issue has been reported by coverity [1]

[1] https://lore.kernel.org/all/20240723141844.GF989285@bill-the-cat/

Fixes: dfeb4f0d7935 ("cmd: bcb: extend BCB C API to allow read/write the fields")
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 cmd/bcb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/bcb.c b/cmd/bcb.c
index fe6d6cb2c381..97a96c009641 100644
--- a/cmd/bcb.c
+++ b/cmd/bcb.c
@@ -172,8 +172,8 @@ static int __bcb_initialize(const char *iface, int devnum, const char *partp)
 	return CMD_RET_SUCCESS;
 
 err_read_fail:
-	printf("Error: %d %d:%s read failed (%d)\n", block->uclass_id,
-	       block->devnum, partition->name, ret);
+	printf("Error: %s %d:%s read failed (%d)\n", iface, devnum,
+	       partition->name, ret);
 	__bcb_reset();
 	return CMD_RET_FAILURE;
 }

---
base-commit: f659ba43837e5ae5a35fdff3736c8e13f9062abd
change-id: 20240724-bcb-crash-a491e603612d

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

