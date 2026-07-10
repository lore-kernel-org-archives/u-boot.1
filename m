Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDE1C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 18:12:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE23784B51;
	Fri, 10 Jul 2026 20:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NvE26GQU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B01DE84B07; Fri, 10 Jul 2026 16:33:18 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDF2D84AF6
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 16:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4728c12ba97so478317f8f.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783693996; x=1784298796; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zMq+XcJKM5JTy54o8hppCTU5+eZ5lU7FwgB+J0W91Ak=;
 b=NvE26GQUcNR6WkVXUiEdSX97QqLwmvQuPQ7kfrta+vINYVO2X1eEgpwtieAShqdalQ
 Od4CFJd+LjP0OLHC08YTO6q93XaNBd6CzN/0LzzFeZ7ehH3JYYGHbWXOYDZWJ9nndTSY
 DuT9YdT4rYVYeY8S1NSzqBwD6Xsb4BeJIPBZyhUnkQI1moz96W0VZeabB7gQ8QDwaSrY
 6zoB4HjlyHx6ea+lgdqUxCr/KXVeM7b4FRgNeSuv6VWwD/mbyCLVhIAc+k/czoh8BmuL
 JZmMGpwqZH6X1uths57ik9HGjCrI+U22JlgoMtjIFak8D9PubUSEMmpI4Ju0OP+fZTZD
 97aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783693996; x=1784298796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zMq+XcJKM5JTy54o8hppCTU5+eZ5lU7FwgB+J0W91Ak=;
 b=HdweIZ3cW5OICvec9qQ2n+7rmvWRwk5eDg1FtWrTNNEp2W6BOyspUkuWWqyD1gC6TV
 qPlVckk6ZX+amhz1v072JxDfARwRyRjGA3ZML1xT3iWnTqdDWElPGf2gdT1x1kLf8zdq
 uvg6EB+f5PPm7hYFi1BnE3lDXQD0T6q4zKE5iOlk6It3zKx40dN2hBQ3homhGg8MR/lm
 /NDmGu8inZkbf9J10zAqXoGwy8Vi22rgFBPp8NEn0J+ZP6/MC/95GUh4a5zFNpZSjxxv
 Qp3yCkp39tA0/VvrsqM2z1Cq/GXpAR4splqzvBh5A5zeZ5PeUsbYxDNcYklrjZl6HBFn
 fTmQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RolpOZCuT1QLt1wgmsBYLUqBMeRl52q1SHskUB7iqOVa04wjTAa4Kbvv0AOLf6U5skUvrdfm7M=@lists.denx.de
X-Gm-Message-State: AOJu0YwW6msw2C6UusFS9dXqnOQslOiHzeysTmPRf2/HKGQiyAstp2G9
 fribnBqCkET+M8kFG+uWdtZn1YpoVmkQYAbVXMPBlaW6g8WroVTE1GYx
X-Gm-Gg: AfdE7ckIAxe3XCdNxnhwiRNhGrZd0/ytMH7ji4u8qUoO3Ip4aedMXjJQd9twyfHJm/F
 +IoAHsHjrBXw6xaXr3SFejk5e6huJGU9cm8AEDA0f8ypP+Uk5lVBGsV9mG4KFnRYDInqquUqhTh
 e8cvGMBWuSaFGvqKOBR513EsBOmWG7+aYbp7XsjgSQZiLk9YymGYSk7cXdCgNS2WVrn1munNmlD
 nqhUbj2Lh5WhV5b3o+26ICtxI5asFBjY5kDWsPgnwGi2cNm6dpLb1MyrhbWvS66bkYzaMosCctL
 d0aXQJ4+6qitXUukxaSvEuEZjrh+q8XyW7Sy8Lcoycbw1yrRlAjuge3Q0R4J8G5JQCy9/rC1+A4
 YG91I7F61VGzYsBdfeYuaLT3UneYTcXmxt0DRqwAesVsGx9BqTtOqVmN+9HF2QrFbPwh2eUIAhx
 JzhWiq
X-Received: by 2002:a5d:5d0e:0:b0:470:258b:b20a with SMTP id
 ffacd0b85a97d-47df072e0cdmr13149463f8f.10.1783693996150; 
 Fri, 10 Jul 2026 07:33:16 -0700 (PDT)
Received: from vitor-nb ([2001:8a0:c4c6:f00:3cb5:ed02:715f:532b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d83bdsm60549688f8f.13.2026.07.10.07.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 07:33:15 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 2/7] toradex: tdx-cfg-block: Add aquila tda4 0230 pid4
Date: Fri, 10 Jul 2026 15:33:00 +0100
Message-ID: <20260710143258.285091-11-ivitro@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710143258.285091-9-ivitro@gmail.com>
References: <20260710143258.285091-9-ivitro@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Jul 2026 20:11:20 +0200
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

From: Vitor Soares <vitor.soares@toradex.com>

Add the new 0230 PID4 to config block handling:

- 0230 Aquila TDA4 Octa 8GB IT

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c | 1 +
 board/toradex/common/tdx-cfg-block.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index c46dd46ca981..3ac253e69ead 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -191,6 +191,7 @@ const struct toradex_som toradex_modules[] = {
 	{ VERDIN_IMX95H_4G_ET,                   "Verdin iMX95 Hexa 4GB ET",             TARGET_IS_ENABLED(VERDIN_IMX95)         },
 	{ VERDIN_IMX95H_16G_IT,                  "Verdin iMX95 Hexa 16GB IT",            TARGET_IS_ENABLED(VERDIN_IMX95)         },
 	{ SMARC_IMX95_HEXA_4GB_IT,               "SMARC iMX95 Hexa 4GB IT",              TARGET_IS_ENABLED(TORADEX_SMARC_IMX95)  },
+	{ AQUILA_TDA4O_8GB_IT,                   "Aquila TDA4 Octa 8GB IT",              TARGET_IS_ENABLED(AQUILA_AM69_A72)      },
 };
 
 struct pid4list {
diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index 3ff7c2b6376a..8fe76640c461 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -154,6 +154,7 @@ enum {
 	VERDIN_IMX95H_4G_ET,
 	VERDIN_IMX95H_16G_IT,
 	SMARC_IMX95_HEXA_4GB_IT,
+	AQUILA_TDA4O_8GB_IT, /* 230 */
 };
 
 enum {
-- 
2.54.0

