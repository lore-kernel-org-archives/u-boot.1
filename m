Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49F4C001DF
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 21:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD29186F9A;
	Thu, 19 Oct 2023 23:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fxQ9p3+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09B4B86F9A; Thu, 19 Oct 2023 23:57:46 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7532B86F6F
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 23:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1ea1742c1a5so49816fac.0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 14:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697752662; x=1698357462; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EH9g5EsHRE81YAZ1i3+GHuOjU6FdNrmr097nyvVJnL8=;
 b=fxQ9p3+9MFdRaJ+rZMvizGAulCCL3roorLkyviVgLk3gEi+IgCRbJ9wS3tXgkPGisT
 d850wNGzEzZYizCbgKga+TSZQOtE0pZOxUAHZtX1zEhjBmKxAfD2DPeKpKUvaBe7asRq
 NDSss08m3PKqDzjOL158Og5GF10+ekyFOJ+C4tWnJEiMl0X1QTiD7IvLmJDB2t58ymvz
 WhXSy5x1PEK2px7aWCAv/8/L+TKJ3Go+xRzxgBMBCKPTyxkwwv8HtaHuiRFnBRyV51U0
 bL8eVeRrEUVswBOQ1W28qfYSb3G60gR2Uthx1euOYWzUsHUZNG8a/rUurT7af4mlRQpZ
 R5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697752662; x=1698357462;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EH9g5EsHRE81YAZ1i3+GHuOjU6FdNrmr097nyvVJnL8=;
 b=lD2j/XagA7R5uVIpwHd51sobBlpRCMddNqvdk328+lB2cWBt0Ff/QEVOIH5rc8OPfY
 cGpJihubBCswKffWjnPsOxtR9MD1wVU4I5Ep8P5qoWsABqAmtXl4D1ICwxp4t5tro7Zz
 0KySPukViKk/6k1k6w2OoSsuqZ4tfjcw6S0tYTz/KAJim4e9uNu1bQczOhAinV91ACgx
 +0KwFPZty+cNM7siWjYu0vDyTgNVmBAsUJxP/WYXdxWawhhVN0EUSIaslg8PIPbEkvnm
 jI8aszVlldGXSZGCHDp/ETVuC+fsZTmT3iuoTn4SeLSo2mFZ2m8i4xD8oNfkRrsrU/Wx
 fWMQ==
X-Gm-Message-State: AOJu0YxEtcozIl5JPTrFZAZpspygSmhVQdvjUJHDD3bZWoe3EW3In6/r
 zTLKJ5Xtt/78BbrzFo66BWY=
X-Google-Smtp-Source: AGHT+IGTltu1aSlygSW8KxnOPcHMyB7BeFpKQTMkCnCQUqSHs7B+k+p3FSGvi5aCPVdUPXBPCn8RqA==
X-Received: by 2002:a05:6358:5922:b0:168:a35c:f07b with SMTP id
 g34-20020a056358592200b00168a35cf07bmr11448rwf.0.1697752661828; 
 Thu, 19 Oct 2023 14:57:41 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:845f:888e:bc51:273a])
 by smtp.gmail.com with ESMTPSA id
 x27-20020aa78f1b000000b006bdfb718e17sm250280pfr.124.2023.10.19.14.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 14:57:41 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: joe.hershberger@ni.com
Cc: rfried.dev@gmail.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH] net: eth-uclass: Improve error message when MAC is not found
Date: Thu, 19 Oct 2023 18:57:20 -0300
Message-Id: <20231019215720.1839630-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

While bringinp up a new board without the MAC fuses programmed,
the following error message was observed:

Error: ethernet@30bf0000 address not set.

Improve the error message to make it clearer the reason of
the failure.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 net/eth-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index 4311f3fe6e89..1f0985ec52ca 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -594,7 +594,7 @@ static int eth_post_probe(struct udevice *dev)
 		eth_env_set_enetaddr_by_index("eth", dev_seq(dev),
 					      pdata->enetaddr);
 #else
-		printf("\nError: %s address not set.\n",
+		printf("\nError: %s a valid MAC address was not found.\n",
 		       dev->name);
 		return -EINVAL;
 #endif
-- 
2.34.1

