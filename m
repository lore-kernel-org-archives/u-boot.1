Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006AAC9EC88
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA862839E2;
	Mon, 12 Jan 2026 14:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="MgtrUlvc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47B1A83CBD; Mon, 12 Jan 2026 10:10:09 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C8E883B7E
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:10:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=streamunlimited.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peter.suti@streamunlimited.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso56003045e9.3
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 01:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=streamunlimited.com; s=google; t=1768209006; x=1768813806; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8ai0vDKWdwD/aNZRknYfyGycIfDw4HX7Q03N5B543A=;
 b=MgtrUlvcHrCAF9pIzqykZQVQ5KR8tWmEYAltG/U1Pi48fOBDlFcSBj0AO4uqCgo9oN
 VxdQcjFsioVu4J1zCkis8g2yl7BWsUhnl5+ZTDZnaTK0V40Rp6OY5lbXHowGxAW3lA/V
 qBXWNvFW1z6yzuQKGDUBcDxMHobEEsL05vBsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768209006; x=1768813806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J8ai0vDKWdwD/aNZRknYfyGycIfDw4HX7Q03N5B543A=;
 b=V90FeoVv0tJSnHZJV66iXQZijWKrO8AWjeKiNBhvQzydED633iwQFym9GZj/ossRu8
 1mp4SkT+JE4dZczy1MjkBGbEll51FqX7/xNzUtox1HkCpckQGRXfjgdyCiUfm1Q3p8/9
 PggsM2H+0Ns2QYaza+vmv46H+oL04PAE5tin5OneWCli2LiKo+oGuKhHHVKAA3XMqDvv
 bLN1qFG5I6jo9sLZDvlbjLtNceXJMIzxNsSy9ULibPVkabYpb75pmgycjA9OvlRxc4MV
 iRBbse55mXnkzH5YKTrifUwrUTJj+k2C3bk2VDXeQt766K/LkUaH5VD0v1qDfYjG1plk
 G20Q==
X-Gm-Message-State: AOJu0YzTw8pwePsuhWTL2uwaXWpdIthmy9e97jtkr7w1kQ0GjYBEbCqt
 XEgJRxwJ5iRr9sNGM4K/9uwOYJDZIjSKkjz9LgL4SnQz62QeIVqvRAauVVALa9Qn6SLrzDnQIRx
 aFsyXoWMVJQ==
X-Gm-Gg: AY/fxX7MdwIwjz7NmWzRCXS9KU3Sfayg0A0qtJk8S67BYsRsWPacN8mpx+lVThCjkqJ
 vB3CQXwfhmbMCWvlU2gmEblijW6+WRwcvmO0vqHZPirqriPsnL63LEEEtSP5IEiX9rN6uig0YKb
 bJqq4ghKvyOCA6zOvbuQzPWewILV1gH92Z6lxkaVj8Vk+p5wThPVUf1O27GykZyOzKY2VSpEN3I
 tuZdFS9EPBMtqUn2u6LmKe7qBL7mWe2Qr9aTZSGIkcuQ2aoTxttKnJrcKcNqgvaJoHO2oOlcZ9O
 ZuVgJxteTj806fVzdk2XrlIl02HZUjDcbmK4e4ya1nWs1g7GcwrWzClvdQUinlx1XuUawWE+bN0
 i/jbDsLDWFMgbDC19SVG2pQJ5500MSPsFoE9UnkSGowDnnW1OknTa0qi8PR3GMcABlwMTiPNSTa
 gCDp7LlDGXd7b1FX3ovRQH8ZKOKRfWonOBzECWCT202PfmfCiOgoM+XrqYmw==
X-Google-Smtp-Source: AGHT+IGu/UYABrybOApDM30Z8vSLe3v+hwScStobGXtUYfZ+/Je09d7RgxD8j3G3nLNnPIja3hjfrQ==
X-Received: by 2002:a05:600c:630f:b0:46e:1abc:1811 with SMTP id
 5b1f17b1804b1-47d84b3b75amr164768515e9.27.1768209006534; 
 Mon, 12 Jan 2026 01:10:06 -0800 (PST)
Received: from localhost.localdomain (vpn.streamunlimited.com. [91.114.0.140])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f69e13bsm346390335e9.7.2026.01.12.01.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 01:10:06 -0800 (PST)
From: Peter Suti <peter.suti@streamunlimited.com>
To: u-boot@lists.denx.de
Cc: Peter Suti <peter.suti@streamunlimited.com>, Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v2 3/3] cmd: mtd: fix default length calculation when offset
 is specified
Date: Mon, 12 Jan 2026 10:09:29 +0100
Message-ID: <55b0df6f4fb731bbb4a4c728849a48e53377fe85.1768208815.git.peter.suti@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1768208815.git.peter.suti@streamunlimited.com>
References: <cover.1768208815.git.peter.suti@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Jan 2026 14:09:41 +0100
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
---
 cmd/mtd.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 1d1845bce44..29189925b24 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -519,7 +519,17 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 		goto out_put_mtd;
 	}
 
-	default_len = dump ? mtd->writesize : mtd->size;
+	if (dump) {
+		default_len = mtd->writesize;
+	} else {
+		if (start_off >= mtd->size) {
+			printf("Start offset 0x%llx is greater or equal to mtd size 0x%llx\n", start_off, mtd->size);
+			ret = CMD_RET_FAILURE;
+			goto out_put_mtd;
+		}
+		default_len = mtd->size - start_off;
+	}
+
 	len = argc > 1 ? hextoul(argv[1], NULL) : default_len;
 	if (!mtd_is_aligned_with_min_io_size(mtd, len)) {
 		len = round_up(len, mtd->writesize);
-- 
2.43.0

