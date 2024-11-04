Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED358D1BDD4
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 17:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21E3088FD2;
	Mon,  4 Nov 2024 18:51:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W3t7+6UH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9842D88F33; Mon,  4 Nov 2024 18:51:33 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E4FA8880B
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 18:51:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-83ac817aac3so175802439f.0
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 09:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730742689; x=1731347489; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WGanZBy9M3edqDmcU0oo6ewTIBOftdhFZB6GvMov7qE=;
 b=W3t7+6UHoo9ovLitZR3iYsxa4eiDdjeQI6oNnUdmnwRSBOEVrWYh4ETtMxDGvOiOII
 BhIeV7gxb5LvL9D2Rqbx2sfvDUChdno3F4+a/+9qX7F8bUAlQHSOEB6A4uUmn+0dVQ4L
 A2TOeIXKT35fO7zhlBRcf/vmrdBcLiv3mh3YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730742689; x=1731347489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WGanZBy9M3edqDmcU0oo6ewTIBOftdhFZB6GvMov7qE=;
 b=MGioWYZSMbxDOicqbymcb694bjaI/5oYRMizpcGT/5CQa8JrfmZC3pD+9bt4IvT1Nv
 5QV1/H6CDqFy/9TApnwrgrrCvQo/lqwstmRgHYFnsGJyOGIAZs5r3sG/Zk9qMKplA8eu
 s6ZsaX3z3ODuJz8Sv4IG8OSSE8x7sQpCvbdLirGLkdUOKI52rQjJsGgOeVI7bekWeUcO
 iFVMe3O+NcRga1UBv8aPTPkW9faQxrVLcfuXz/1JNu9MB50nnyB5AEDt1ZcQIA/AMH3W
 39Pqb5tFcmaGoEKQ1FMA4G9bYphobZBS5vLkAUAl6bpQhqj3yuyFTC6Y7s1S9pyPWwEt
 p+bw==
X-Gm-Message-State: AOJu0YwDGCd2BZv0ASIeCZQNHxY2cwLadfDHZWKSDTrtMmSikUyBC81d
 HpzAPztDB4xxnuH9VmTOFyO7nzLA2xVD4Phy9efIPbwCh1ItBczzxaaRMFjRYghBUevFEPBdVX8
 =
X-Google-Smtp-Source: AGHT+IF59vhDAjwI9DbUgQu2tmuG58AiVrurLVwYboJi7rNFqfR/yvoc258JVi41Z2ncvp59eAKQgA==
X-Received: by 2002:a05:6602:1592:b0:83a:b7a2:74e6 with SMTP id
 ca18e2360f4ac-83b56605610mr2610056139f.0.1730742689523; 
 Mon, 04 Nov 2024 09:51:29 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de04977b30sm2005288173.116.2024.11.04.09.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:51:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v3 08/19] boot: pxe: Drop the duplicate comment on
 get_pxe_file()
Date: Mon,  4 Nov 2024 10:50:59 -0700
Message-Id: <20241104175110.1048449-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104175110.1048449-1-sjg@chromium.org>
References: <20241104175110.1048449-1-sjg@chromium.org>
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

This function is exported, so document it in the header file. Drop the
duplicate comment in the C file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/pxe_utils.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index d6a4b2cb859..4fd26524286 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -133,16 +133,6 @@ static int get_relfile(struct pxe_context *ctx, const char *file_path,
 	return 1;
 }
 
-/**
- * get_pxe_file() - read a file
- *
- * The file is read and nul-terminated
- *
- * @ctx: PXE context
- * @file_path: File path to read (relative to the PXE file)
- * @file_addr: Address to load file to
- * Returns 1 for success, or < 0 on error
- */
 int get_pxe_file(struct pxe_context *ctx, const char *file_path,
 		 ulong file_addr)
 {
-- 
2.34.1

