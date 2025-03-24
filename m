Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D15FC36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 17:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C77C805C3;
	Mon, 24 Mar 2025 18:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hh66fHul";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88211805D7; Mon, 24 Mar 2025 18:12:57 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70AA5800C1
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 18:12:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 32A783F6B0
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 17:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1742836373;
 bh=V5ze4rOHbcw+cGXBzDyTaHeJ2oeFuoN+6UChuM6+DCs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=hh66fHulkb84n3ch0eA0esJ3D7t3K4nGzFkefnWbkTuub7e5ZAfDoWmE7JyN7iI1O
 Pbp5mYJ1zvhUqewEAoRR/neXQPqkPllP3V+81T+Z8QNH6036tyxUT5be2ILVAfkLGt
 jhGnpWMke7k5WAEIO5xPQ6h0vHp0h3STkHto+sv949U5ImUrFp0U6Ovh1p9CibCnnz
 vtM6MS6prrEg1p9900M1rPXU5EJsiupNyMNBqsTBRM9jKsDDe5VGzoBfyxtcKXFTUT
 W65rVeq0w8Iq9iIf7BhfaMxY3cBzaABUHJBA3P0EdEQvfUTVLQX43mxFIe0VVjgIo+
 o+jZN6ajrAQnQ==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43935e09897so29863495e9.1
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 10:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742836372; x=1743441172;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V5ze4rOHbcw+cGXBzDyTaHeJ2oeFuoN+6UChuM6+DCs=;
 b=JJP8cGI/iPipGN2HvJlSgwBkjpgmNF6YALAGhXN11goX8mNPbPlfoghYksB9ZmjezH
 ICvtbUXJvRfKQgQrQx4je8YrotFfLR7uxxImmz+mPyIGM7r5WWq5PuTlaoCeGFcM+Y4y
 arZ5pLDO4U0ku3C9gH6O/OG+t8k+NVRBREa6EtYhjfYGtMc/iYdFdK386E3CtKz3JZDg
 M84ZDCaA84XkTxbRfxTI1fFFrZLkLtRsRfQZqCCFxc46gngHIxoFwpaf+JPMj63T21ev
 910jR7R7Tm3moIgTqisdJJxe3bypkhrC6BY4ItZ2bWgqPD1yNoj7NOvAFJE8En2e37VW
 aUAA==
X-Gm-Message-State: AOJu0YynA5ZZoI0fWVKIelg00C2QnTRlmQbbyw5FgyKCtUfXcTYpGSk9
 rRa1KCs7+7kDd0AaD/QWcxUoaKNz5mkbD1/mribkvBvVBk5E2L+ubvlkRhYwnFi4qyhnvit+ZiU
 bdHZfdb+ewK+xUEBFHM9GzCuLmMoK7QbdHJ1lkHFRqLdPnp0d+GJCRLeZjNLCcUU9+S0=
X-Gm-Gg: ASbGncse1wRz2twX5e6RKWj2d4Zh+OJGbrWIuE8qdocYqBTD47NbfD5yW3smRufUtDC
 LZL0YrzR0hWBHY/95VQgipV4AGtOUHE4keBegpmPgRNONLv4zJ8meP923egZCBKqQsySeVPk69Z
 a042rGpACTJglxAP5jtnydM57B34czTHcq1w6Z14+l77JqEjVdNnzIbeMsPevIS4mGQggiEj8JM
 LDWAi/qkXCNM9xkFCL809HhtHhvpCYEnQRQSt+ONavFMXW0MUE9ZB02FSm7VDQlEGdv/7zV0tta
 8Y6c+g2zLEnOvwv2P5KsLgGBVgTWmFq9mSno1Uloqe742mWVImZ9sP/pdx/EDn6UesoAC7PBE8D
 MyNKLcjggD8EgMA4BHQ==
X-Received: by 2002:a05:600c:4e45:b0:43c:ee3f:2c3 with SMTP id
 5b1f17b1804b1-43d509eb3d4mr140046915e9.7.1742836372429; 
 Mon, 24 Mar 2025 10:12:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx+IttovI1yecWZK+16XWTy156mdpCHdWtXHYZzfS5cGG2ZfU+BZ/fudT1hd2X/gFzzWQdaQ==
X-Received: by 2002:a05:600c:4e45:b0:43c:ee3f:2c3 with SMTP id
 5b1f17b1804b1-43d509eb3d4mr140046635e9.7.1742836372064; 
 Mon, 24 Mar 2025 10:12:52 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9efdedsm11600126f8f.96.2025.03.24.10.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 10:12:51 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] cmd: pmic: add fall through comment
Date: Mon, 24 Mar 2025 18:12:43 +0100
Message-ID: <20250324171243.576862-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

Make fall through explicit via comment to allow building with
-Wimplicit-fallthrough.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/pmic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/pmic.c b/cmd/pmic.c
index 3ad1b8aa375..c5eea766a31 100644
--- a/cmd/pmic.c
+++ b/cmd/pmic.c
@@ -34,6 +34,7 @@ static int do_dev(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			printf("Can't get PMIC: %s!\n", name);
 			return failure(ret);
 		}
+	fallthrough;
 	case 1:
 		if (!currdev) {
 			printf("PMIC device is not set!\n\n");
-- 
2.48.1

