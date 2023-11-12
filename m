Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAAFC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D76287732;
	Sun, 12 Nov 2023 01:11:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b+wZxGPt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1946C86F40; Sun, 12 Nov 2023 01:10:24 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FCBD86FBD
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3594c100735so8156575ab.1
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747782; x=1700352582; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qui3+caDjS/36XzsG4V14K8OXXHoB7ue7vMCTgJ3Rog=;
 b=b+wZxGPtlO3htWT+pzNT2kEjbp676xl6BByiMHjpqxzBIN6ZjC7D4RCGt0KTREEboQ
 ly/CaFoyDg3swtLqflUnUojz+1y8qrPqLJ+99oBXOop1VkSRitUXFl/Pnxm6NIpiMNnl
 4dSCPuPkaPihPrqi4ywxtJKL4SP39Z0QG2Y7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747782; x=1700352582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qui3+caDjS/36XzsG4V14K8OXXHoB7ue7vMCTgJ3Rog=;
 b=bND8DEK9EvoXZp8Wcbumd2J7c5cKccoEy0X96Zy3HzIAu5oVFvDcbyEZ3FTwz3j2Wz
 9zr4I4PrFli0em6jjJdxO4OCUfyn3/Nzh71dCEvqEoTUyTKrgUFhy8crpKtGsn35RW4B
 OB9ZHQxaYmQtKxRpQijD8bw10BahMAopiXCnR9FUJQxdv0KfZTgclCnCBfXtX4SMbVV+
 /LqagCiL8I4Zpq4ONsO1/R1azt4phVPDP+jFhXoxP2mHpVAygEWhHcdwam+ERV+gRRIL
 omxY3jsyMDX1gz00plipylmeGPRadnMWqyYKkfF9S97RxuFvQS+Ua5NhswhRB+P1rp93
 8WzQ==
X-Gm-Message-State: AOJu0Yw0DQi0Sv5qXsZn9JlXtPoIku6meUIh5a2z+B476JzFhFSWv4Xb
 syCv71dmDA2UvS1ZTz+KsjK4aUFeTJ8eyVDTkv/2WA==
X-Google-Smtp-Source: AGHT+IGYKVzP2KCYC0iYulZ8GhGEVLxyu7J917pRQBSU6fDm1wQ7bBcfXhmD2tL9oU3DQyYEXQfljg==
X-Received: by 2002:a05:6e02:1062:b0:357:f72d:ad06 with SMTP id
 q2-20020a056e02106200b00357f72dad06mr5613842ilj.2.1699747782492; 
 Sat, 11 Nov 2023 16:09:42 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 13/29] bootm: Use the error return from boot_get_kernel()
Date: Sat, 11 Nov 2023 17:08:58 -0700
Message-ID: <20231112000923.73568-14-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112000923.73568-1-sjg@chromium.org>
References: <20231112000923.73568-1-sjg@chromium.org>
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

Rather than looking for a zero-sized image, use the error code returned
to determine if things are OK.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 57eaa1ff10df..5e3b5e940734 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -324,8 +324,8 @@ static int bootm_find_os(struct cmd_tbl *cmdtp, int flag, int argc,
 	/* get kernel image header, start address and length */
 	ret = boot_get_kernel("bootm", argv[0], &images, &images.os.image_start,
 			      &images.os.image_len, &os_hdr);
-	if (images.os.image_len == 0) {
-		puts("ERROR: can't get kernel image!\n");
+	if (ret) {
+		printf("ERROR %dE: can't get kernel image!\n", ret);
 		return 1;
 	}
 
-- 
2.42.0.869.gea05f2083d-goog

