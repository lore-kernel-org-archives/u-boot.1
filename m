Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172AFC87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 18:44:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A3B783AEA;
	Wed,  6 Aug 2025 20:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="AYM0Vhw+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AF1480C83; Wed,  6 Aug 2025 20:15:09 +0200 (CEST)
Received: from mail-io1-xd61.google.com (mail-io1-xd61.google.com
 [IPv6:2607:f8b0:4864:20::d61])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 744E98433B
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 20:15:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dregan@broadcom.com
Received: by mail-io1-xd61.google.com with SMTP id
 ca18e2360f4ac-88350d4008fso1494239f.2
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 11:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1754504103; x=1755108903; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ygpMvrACWCKX/+PDajQhN9p5uN98v3MXIsBATLRHm4E=;
 b=AYM0Vhw+/B3jfAT0a8OKCxnnaymvwdZokKH+iv/atL1LN3QqiqohqvuMcb8ycS0Qqj
 MoZ29JsXGgtIyHOXgAOufjx6uNNpv7SmOSCaFwj19PSXgYQpwThb50OeeTE6rO6OZp+9
 ByZ+ScMlsjiuwnBADBNvesYbEsHG9lB2L5Bas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754504103; x=1755108903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ygpMvrACWCKX/+PDajQhN9p5uN98v3MXIsBATLRHm4E=;
 b=SWVMP/GyJUX2t5+8zKNrH+c6JbYs7+kn8kErP1SZ4JAW4lXHcolYh9vv9Vzgk42Lkv
 RyVV/e7dIrv6bXfipJNbTyAD5j+irKgPa6Y8c2zE+yD7mgRjeEbQUnBJ/6hAxExDKVlj
 MwajtEQp95lX6YmNSCUeIL3n27CK5isiT7kLnitVf9uGMe1ENAYkfYWQ/r4QTpMpbPdp
 vUilOH0LRSbdEUPFfv7GimxW9Gt+Zj6Zse+M/Hgpr+lH/433V/rqsWc9J1OKxbDdGnFa
 w1jdurvMR4BIXkD115xAYgZdTyGTOFMbULELK8P2ZxsvKrtz1Hk42wmJuXgfNks+lgf7
 UTqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUupxAHDR2JCwctOlB4fm7aqrGUuhLtfFQXykiNhNiL8QuCQsGzGgJBDpCGpfKGkkYwzLde4Ls=@lists.denx.de
X-Gm-Message-State: AOJu0YyOZsDcnlmhJY8eZuT3RRKlMj8xMiniP7SZzwny4DLU/69QAEej
 c9TpwmAJWAjrb9pQSFKEP9jGVqWPlSLO34awsp0cegGcI0UhfrgpWm7+HsnIgvN/uUPxMVXBUd9
 xrzx0qgNfQI9u6717+9TEjclCtHV7jpOOTg==
X-Gm-Gg: ASbGncuyfOPUeAIDc9PdmdMwVrHMJpR9nsflOrieWRgXTUvZrzk92AWoXLRvLTl3IyL
 ju6LzRdId1X/b7le89t1Y9gir24BKLIVt2VRTsudBB9zNn7IeoeWGoBjVqRH5ZdmVLNIePFdgto
 gwARhnvKQNW5FARBOIWUrjec1dv+BBLquwWkr/aFERtA7lOnNpx03p34y+90QRixCBjLPNIztH+
 lC+hrhwFHA1NaPYqZodIWu+Qu/f4URx5NMS88A0aUWRy5qOubSmTUa8p+Ne0wKOpnvgx5YFQVZr
 EE4pY1HG/tNSWNLgkKAhMWaEUoVKVIgilNtbDXQ2J1YPb+TMi8ANKZISnVTR/JvQo4UX1RMXKd/
 Vr1JLeGgHBvQ3Zw==
X-Google-Smtp-Source: AGHT+IG1N9jYXVGge1EQ6OWtS79PSL51jAEEDwzTdUtqPF+7lGpFPLXuoHeYKuYF7ja0KfsmeSj4MfOXQIaY
X-Received: by 2002:a05:6e02:330a:b0:3e4:1521:9234 with SMTP id
 e9e14a558f8ab-3e51b8eafd0mr20677675ab.4.1754504103185; 
 Wed, 06 Aug 2025 11:15:03 -0700 (PDT)
Received: from bcacpedev-irv-2.lvn.broadcom.net ([192.19.161.250])
 by smtp-relay.gmail.com with ESMTPS id
 8926c6da1cb9f-50a7e17fbfasm434156173.50.2025.08.06.11.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 11:15:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From: david regan <dregan@broadcom.com>
To: dregan@broadcom.com, dregan@mail.com,
 William Zhang <william.zhang@broadcom.com>,
 Anand Gore <anand.gore@broadcom.com>, Tom Rini <trini@konsulko.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Subject: [PATCH 1/4] cmd: nand: bug fix MTD_OOB_AUTO to MTD_OPS_AUTO_OOB
Date: Wed,  6 Aug 2025 11:14:00 -0700
Message-ID: <20250806181450.2324488-2-dregan@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250806181450.2324488-1-dregan@broadcom.com>
References: <20250806181450.2324488-1-dregan@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 06 Aug 2025 20:44:29 +0200
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

bug fix MTD_OOB_AUTO to MTD_OPS_AUTO_OOB since MTD_OOB_AUTO does not exist

Signed-off-by: david regan <dregan@broadcom.com>
---
 cmd/nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/nand.c b/cmd/nand.c
index 2f785deeb7f6..e09e145bc2d8 100644
--- a/cmd/nand.c
+++ b/cmd/nand.c
@@ -412,7 +412,7 @@ int do_nand_env_oob(struct cmd_tbl *cmdtp, int argc, char *const argv[])
 		}
 
 		ops.datbuf = NULL;
-		ops.mode = MTD_OOB_AUTO;
+		ops.mode = MTD_OPS_AUTO_OOB;
 		ops.ooboffs = 0;
 		ops.ooblen = ENV_OFFSET_SIZE;
 		ops.oobbuf = (void *) oob_buf;
-- 
2.43.5

