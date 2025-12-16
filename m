Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421B2D5E15A
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 13:43:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2525839FA;
	Tue, 16 Dec 2025 14:42:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="a+u1G8X7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 000A083984; Tue, 16 Dec 2025 14:42:01 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAFD083623
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 14:41:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=streamunlimited.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peter.suti@streamunlimited.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so35927495e9.3
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 05:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=streamunlimited.com; s=google; t=1765892519; x=1766497319; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cfiZUZHZCYRIZAj2phY/BXIv8wETdsOKzw4iEaZ/G2E=;
 b=a+u1G8X7WYhkp7+NHgK3yzSfYrLr9PDSV7vh74KZDaCQblcKPzgoeI2BPh5Y3tyi6y
 8uVS/YJ93oTauYPQ762n9QD0HyNF0iRTvOZJzxmhX0wCU7KUA7gv20voYWAb7op27L1c
 ToYUsF7RdN4OIWPsUn5vHONltPXosFPJnbEMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765892519; x=1766497319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cfiZUZHZCYRIZAj2phY/BXIv8wETdsOKzw4iEaZ/G2E=;
 b=uAuY9CZa9s2E9jgXsy079GK5BH+jYcTanio28zgIkK2iqjLOXT+dmkrui2UugY26F8
 eUYbxEuIKQdbaXHJ6BkBh3S3alM04jvwBsHdjdnPqx/a0zgk24VXmDTxm8tetf/dvAWS
 xo2yNzY0ojpaOZWlsRqubq2Bs4/6DUhAmgEJkQnMyilcS0N8gEEFxexE8ALonQwXM9Ql
 EOGc5NnDpSo/06UiDUKwgC77dAnXtOAWRj7Ef4y8Z6/aR9mz1n1egDndaIuHbeRHr2IU
 YxxPgXgUTfBybwu+EwVR7Gm6jgQPJyf942ERJ2RpOTZHrwnTTBqCx9COPN8Bkfp1L82p
 GqHA==
X-Gm-Message-State: AOJu0Ywe90SeDAIAkfzFjh9TX+gCx0EiD5wB05ES2zHUsNiKD+VVYyRc
 c+kAULM8oErJxE2aMojlkjObr79lv+cWIU/NYipG1GMcUOeSyh951kZdJ3WnDACrNfhcX5Hszv1
 KnB4K9+w7UA==
X-Gm-Gg: AY/fxX4YH9P2CG9zD8N1Ms7oadUIbPrnRdKUv8SAe9ONxelsIwPJ70bBx/lcoz5tvMC
 4ymZodZzi+qXtvVRPTBH6LpuqaJZkARky38oNiekt5BxqORGDNG99vLSP8pBZVn1sStcKzRKG6G
 JKal3qGQAB4ZLhC1qMo9OoY29WPCPoEyZ4FgZMRvKJx7JB/4qV6ZNnYiCIpuCzFI5WJM0ZZg4d4
 I/jzSmLDIanw2d3I0vWbJQCur5EuwMGQ1SDwQCga8/VNnYeKmHocOMSbi9aeGOZjGnVmPvzXrFp
 +OfVUoyehwPKVVtS34RV83cpRuLGGUCcHbr6kR0VNgoXwZQYH8UTBLT7c+Cht4e8zQ47JpgAae+
 DzKM95o6PetJBOIIPDSaZOtF3Sd+53pO5uuKyEquzMZ1xWXsuIKHvxdFEOlGma5uVncVbI8aKVp
 UAhHwCjAVw4i7ZIwQymTHP6SqLhe3a7kXLZOEWLJZTh3JRo68sCeIGyLpAxtLbuWI=
X-Google-Smtp-Source: AGHT+IFVn9HzQpe21oPltLlw0ihx9II3RhzJOpC9yweD4Ja2ySnOdXgCgzXNGpq0u+o8o4KnqIZQpw==
X-Received: by 2002:a05:6000:25c1:b0:431:3a5:d9b0 with SMTP id
 ffacd0b85a97d-43103a5db88mr3806692f8f.56.1765892518982; 
 Tue, 16 Dec 2025 05:41:58 -0800 (PST)
Received: from petersuti-sue.lan (vpn.streamunlimited.com. [91.114.0.140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-430f4126477sm19694532f8f.10.2025.12.16.05.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 05:41:58 -0800 (PST)
From: Peter Suti <peter.suti@streamunlimited.com>
To: u-boot@lists.denx.de
Cc: Peter Suti <peter.suti@streamunlimited.com>,
 =?UTF-8?q?Radek=20Dost=C3=A1l?= <radek.dostal@streamunlimited.com>,
 Tom Rini <trini@konsulko.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 2/2] cmd: mtd: fix default length calculation when offset is
 specified
Date: Tue, 16 Dec 2025 14:40:42 +0100
Message-ID: <d34e03afc6c5bba074bae1684ca1f74159735210.1765892031.git.peter.suti@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1765892031.git.peter.suti@streamunlimited.com>
References: <cover.1765892031.git.peter.suti@streamunlimited.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Dec 2025 14:42:57 +0100
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

When the 'mtd read' command is issued with an offset but no size (argc=1),
the length defaults to the full partition size ('mtd->size').

This calculation is incorrect because reading 'mtd->size' bytes starting
from a non-zero offset results in a read request that extends past the
end of the partition. This causes the MTD layer to return error -22
(EINVAL).

Fix the default length calculation to be 'mtd->size - offset' so that
reads starting from an offset effectively read "to the end of the
partition" rather than attempting to read out of bounds.

Signed-off-by: Peter Suti <peter.suti@streamunlimited.com>
[add {} for better readability]
Signed-off-by: Radek Dostál <radek.dostal@streamunlimited.com>
---
 cmd/mtd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 1d1845bce44..9f6e3226c15 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -519,7 +519,15 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 		goto out_put_mtd;
 	}
 
-	default_len = dump ? mtd->writesize : mtd->size;
+	if (dump) {
+		default_len = mtd->writesize;
+	} else {
+		if (start_off < mtd->size)
+			default_len = mtd->size - start_off;
+		else
+			default_len = 0;
+	}
+
 	len = argc > 1 ? hextoul(argv[1], NULL) : default_len;
 	if (!mtd_is_aligned_with_min_io_size(mtd, len)) {
 		len = round_up(len, mtd->writesize);
-- 
2.43.0

