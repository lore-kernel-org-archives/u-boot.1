Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679E5C61DDE
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 22:44:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31DC280E37;
	Sat, 29 Aug 2026 22:44:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L0vLCJ7Oli_k; Sat, 29 Aug 2026 22:44:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788043495;
	bh=8+nN/B3kzAkc40KCbvTJYsw4MFl7bi51rMOMlRvqRAQ=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Xw0WprYovWuhsROY5HSh5JeIf3H2sSndYHniH9vFkK/9dZoC6mT7BaTnn38nSQMQ3
	 ij1OevgRyXWYk6ltdlSwS8D9cBZYhX8FTN1NKDF6CKJaHozofVrlVeYM7beqkwex75
	 Dzm54vi0l+/wXkdXJISN+WA8KFxHGbrdU8T9DeEAzxBpn3fHCpGBUCS5cPKTa0mrWh
	 eBLW9lVKS0kKSisgsVEt3Uc7Ge2HncaeUYd4CMothaKespAfCM1Jzh3Cxq0WVR9rSs
	 jxPlCkJrpItWNv4oTvodzujUSDmAZD9ule8ezI8sRAiXM1hsiBfp9xGOMNy6OAS2xG
	 oxnTO8mRkSmDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48C9F80E30;
	Sat, 29 Aug 2026 22:44:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 58B76118
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 15:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 56C5C40052
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 15:53:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id INW8wddBRRKd for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 15:53:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=graeme.harker@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=T+iwaWMx
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6228840068
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 15:53:26 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so1321526f8f.1
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 08:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788018804; x=1788623604;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8+nN/B3kzAkc40KCbvTJYsw4MFl7bi51rMOMlRvqRAQ=;
 b=T+iwaWMxx6icuqMlVd0Foo/lmMpK8cuj1YfCtDE3LTE6KuadM85J+HxHlPmu38Lhlf
 zFa+zRBmcvftJCKFJAeUXtFy3h1x4AwJ+q20vfwvag74ViJG0VZO9BJpjNHkul6p8tfE
 VZVdS03iGS9sevwIiD1AMkOBdTFdGoYBWZfN1g6GxxGNN+fu9ZKddYFvXBbkOsGqSOMN
 w0IScluWM+yCybOJ1tTiDka+vVzwIByBGaf+Eb55u9JbSX1qihI2iCrSfxj2nWP2Y3z8
 NJxZDO3VjbhnpQ9y87QSPxvgWxqKX2IZ+HxLSp/XiXZqtTR2yVeyc/4Z2Hoev8A+KAPv
 ms6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788018804; x=1788623604;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8+nN/B3kzAkc40KCbvTJYsw4MFl7bi51rMOMlRvqRAQ=;
 b=eq/HFijqxyfb7jyywJlfZXH0hGz+LfGNxuaBT+TuNa9h8zS8K1rLMQ0XrZemlUVSPE
 v3KZ4PZUprby4KghxvuoTWspoUwODaICb5w4ceecX17sXQihvA/foQ1wNFpNFYLnnNmu
 npD2qn14T/3icswYtkXKLWlqdJ4UHI8bXQkzeNsnS5JxHL26naNzDJWc0K5cfNgMOzW2
 nQ3Mazr57xZaax90goUqVOV9CCboYniK04bmGSPiv8VbXP7lqbNZkv6wMEERjxFtoLjr
 Qo9H2NFuPomnoF9wyp0jbCRV3rNNr7hYlvYuSCVLNCWIIr0d8ecZeTJwGEDEY474CicE
 8MmA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSFgrtBwLqqjjUVMm8UUiVjRo7Z6mbM3u4K0KWv1mBahTjI+lj1aHMukHhlHQ/nDIMbiyjzlI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lC4qS+wkBNJ+ubbrmQPOY8F0f9tTSARgpCvXlzqM/dhXd2ulNh
 agIYOydb3RS0dbuQOmKduasFnS14vVg+AoE/6sAUfr29xR5IBaZrOebH
X-Gm-Gg: AYBFou1jsZTe2WqosgnJ80+hHUy7XGZaa79PE415+550T1sHYFJZs5Rc6KXugx32VP9
 DeqRKPEINP1hvPGpzXsc0JFf2+eH9ViiKXBwhtoDf5hHM10Ds4CVGjnAKjQVvHbyT6t2E9zKjHr
 w+x0CxgSaQz2De0V/tZkbPDzvf//7djaTORTd4Jz/mu0uEAlFvI/kAWIQFj3Hr5W4MC9FxlVvs6
 NdjZjpkSr3K0IEaF9nIPCMokLNztbv+5YHHiGRLSA1zDgm5A+RVquMDPB1+Wj2CeYSipty1sQbL
 43wycdd1ZxiquuzEVVcR36Wk4gs0cLSs3HKSB2gCiwCL6/dP0/tkeb4WkbIAthqXC8fIIPf4FHW
 8rTv+6uicNHv+8Isefksq9V7cnKGf5hVOQ8nsSdC3n+o9MFJJ8o0S+hGZ4duuxXiNyn+5j4JQTK
 pD16Hbgdo0FBRV/XB+7f/vqGgo/f1l4jaM9WRI+4oydQq8u5+AVz1x4tAYPmrYUS9pnA==
X-Received: by 2002:a05:6000:4213:b0:484:3310:f397 with SMTP id
 ffacd0b85a97d-4843310f427mr5652417f8f.24.1788018804261; 
 Sat, 29 Aug 2026 08:53:24 -0700 (PDT)
Received: from [127.0.1.1] ([147.148.142.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4843310ab29sm3486757f8f.0.2026.08.29.08.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 08:53:23 -0700 (PDT)
From: Graeme Harker <graeme.harker@gmail.com>
Date: Sat, 29 Aug 2026 16:53:07 +0100
Subject: [PATCH] ide: Fix truncation of device strings by one character
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-ide-strlcpy-fix-v1-1-05676b02d822@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGIAk2oC/yXMQQ5EQBCF4atIrXVCDaJdRSxohRJBupgQcXc1Y
 /m95P0XCHkmgSK4wNOXhZdZEYcBuKGeezLcqgEjzKIcrZKMbH5y62k6Pkz+QUyb2tqkTUFfqye
 d/8Wyei17M5Lbfhm47wdldaI8cwAAAA==
X-Change-ID: 20260829-ide-strlcpy-fix-83225ba994d5
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Graeme Harker <graeme.harker@gmail.com>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Sat, 29 Aug 2026 22:44:54 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

strlcpy() takes the full destination buffer size, including room for the
NUL terminator, and copies at most size - 1 characters. The vendor,
product and revision fields of struct blk_desc are declared
char[BLK_*_SIZE + 1], so passing BLK_*_SIZE drops the last character of a
maximum-length string.

This dates from the conversion of these copies from strncpy() to
strlcpy(), which kept the size argument unchanged even though the two
functions interpret it differently. The original was correct:

	strncpy(desc->vendor, ..., BLK_VEN_SIZE);
	desc->vendor[BLK_VEN_SIZE] = '\0';

copying up to BLK_VEN_SIZE characters into a BLK_VEN_SIZE + 1 byte
buffer, where strlcpy(..., BLK_VEN_SIZE) copies only BLK_VEN_SIZE - 1.

An 8-character firmware revision such as "HDX 5.08" on a SanDisk
CompactFlash card is therefore reported by "ide info" as "HDX 5.0". The
boot-time banner is unaffected, as it prints the local blk_desc filled
by ide_ident() before this copy.

Pass sizeof() the destination instead.

Fixes: db89e72302d0 ("ide: Move setting of vendor strings into ide_probe()")
Signed-off-by: Graeme Harker <graeme.harker@gmail.com>
---
 drivers/block/ide.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ide.c b/drivers/block/ide.c
index c1a46dd2a94..44ce054bdf5 100644
--- a/drivers/block/ide.c
+++ b/drivers/block/ide.c
@@ -1045,9 +1045,9 @@ static int ide_probe(struct udevice *udev)
 
 		/* fill in device vendor/product/rev strings */
 		desc = dev_get_uclass_plat(blk);
-		strlcpy(desc->vendor, pdesc.vendor, BLK_VEN_SIZE);
-		strlcpy(desc->product, pdesc.product, BLK_PRD_SIZE);
-		strlcpy(desc->revision, pdesc.revision, BLK_REV_SIZE);
+		strlcpy(desc->vendor, pdesc.vendor, sizeof(desc->vendor));
+		strlcpy(desc->product, pdesc.product, sizeof(desc->product));
+		strlcpy(desc->revision, pdesc.revision, sizeof(desc->revision));
 		desc->removable = pdesc.removable;
 		desc->atapi = pdesc.atapi;
 		desc->lba48 = pdesc.lba48;

---
base-commit: 67a095a6896828056e4a1a0ba0e9bb20f5595c59
change-id: 20260829-ide-strlcpy-fix-83225ba994d5

Best regards,
--  
Graeme Harker <graeme.harker@gmail.com>

