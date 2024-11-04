Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45B4D1BDD4
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 17:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D44A088F33;
	Mon,  4 Nov 2024 18:51:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nPOxt8P0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A15AE8903C; Mon,  4 Nov 2024 18:51:38 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 662E488FE2
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 18:51:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-83aad99d6bfso167134739f.0
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 09:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730742694; x=1731347494; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hEvs6FGRXWaE0NLebtPoX/3Qd3/ApUU6TfD58J701R4=;
 b=nPOxt8P01JvcAUuuCp4I31duosSBHwrLgoS/sCkTdCApStDAFDUWDg4snoEgw6dcJn
 1SCSsYLNK9u7Dvjrt1VoRAA47hS+7WgS9PAVMvNsVEMxpn8+KRWJNeMs4qvIcmI/QgI3
 EOevXAflRpNB0fVs9hsx9W0t8cJ/sHdK0h8a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730742694; x=1731347494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hEvs6FGRXWaE0NLebtPoX/3Qd3/ApUU6TfD58J701R4=;
 b=QIAupeiMuexw65vyfgfI0ev5no8JrWZ7fNIxjC5fdU6oSpZJGmTNMibg8Qt0MEk7Z5
 bOODKCcOWVeZP8iDsd/tnzZhWarJ3pZ/2YsobZodDJRq50fJ2BFDNX+luP4Qay5dJnlZ
 hlSlKMbjlfVnCK5YB2KLOpaKIhH6/qUOGSn0y5cQwEKrmvBBMl9Z9EpZcmLMGrHNboT2
 i2oNz/yXSQwwf9EJr8xZpLQEzT0qmt65J/H7BDohKeSAuylc+tl/bt/4H9EUNZlnIwOz
 /dcNERUKSXXIypE1JvGJhrbThx/yXy3EBK4Ngwxo6HBJ+IOUY9vfbEHrNEXupMAPESnq
 ofWw==
X-Gm-Message-State: AOJu0Yy/Z+sw8foA1+7RBuzfspToDnB7ZmSyWFl/vD9rPfg0pC5cPCuI
 3wHJS+0y8Twd8VFiQy/6gx/y57Q1mlTie0E1jyb7Te5JHs9GQRn14w9/Sqc6A9jJA0dw46y/kts
 =
X-Google-Smtp-Source: AGHT+IEDF6HypJzKCbucmBWBwYzztyVvMdGjaFW21rLaT1LK3Habr01YUOZUet2A9Z2aVOPPysL9Sw==
X-Received: by 2002:a05:6602:164f:b0:83a:9488:154c with SMTP id
 ca18e2360f4ac-83b64f3b524mr1682812339f.3.1730742694618; 
 Mon, 04 Nov 2024 09:51:34 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de04977b30sm2005288173.116.2024.11.04.09.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:51:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH v3 11/19] bootmeth_efi: Check the filename-allocation in the
 network path
Date: Mon,  4 Nov 2024 10:51:02 -0700
Message-Id: <20241104175110.1048449-12-sjg@chromium.org>
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

If the filename cannot be set we should give up. Add the missing error
check.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Change the tag to bootmeth_efi

 boot/bootmeth_efi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index e8109e19bcb..1ff8788ebeb 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -269,6 +269,8 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	if (!bootfile_name)
 		return log_msg_ret("bootfile_name", ret);
 	bflow->fname = strdup(bootfile_name);
+	if (!bflow->fname)
+		return log_msg_ret("fi0", -ENOMEM);
 
 	/* do the hideous EFI hack */
 	efi_set_bootdev("Net", "", bflow->fname, map_sysmem(addr, 0),
-- 
2.34.1

