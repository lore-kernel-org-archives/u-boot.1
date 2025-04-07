Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C789C369A1
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 20:04:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE84F8313F;
	Mon,  7 Apr 2025 22:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ar3pJ3MI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D1AD82EAA; Mon,  7 Apr 2025 22:02:49 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B26A830F1
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 22:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso3595885f8f.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 13:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744056167; x=1744660967; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IOH8DkuVLxYfs/lJIWeNLRlOYkCQiYfxlfgFqsd0JDE=;
 b=ar3pJ3MIPB+dRogA5Cr7usIvtcbAY9j7iEQfEC4iF4Nsf6EDmwRG9wIsDv76tgCY+T
 46zUlBp6DnZGUtdBu7CG7bTVgCVuHmou8z+A3chcLwVxxScpObQUyC+yufWN99E32QFe
 xl3bkpxReIgn+m0H6Xs4bNVDWwsjSZdp3L30JuIU7sVO4HdxSd3vPTf1mjDSMEprRgVE
 KwDxKd7yXna7717oN/bm7nuUwg77Z3Hj8vEj3rFjpwQjMTyNsjLMf5ftvoCQTrhG4mnq
 LGDgGgg5LUF4kFUqb8zG9jPw183JSVGGDaNdCVatwAE0TK/MaI4CXlBE+T5aGEKAGv4U
 Ipcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744056167; x=1744660967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IOH8DkuVLxYfs/lJIWeNLRlOYkCQiYfxlfgFqsd0JDE=;
 b=Fu61vPaS7TneHTDcQKp+AjBROKOt+OYdzoUYSjbTUwAuJSLsPiYHjVQqdHL2paeFgq
 IVxU1weMG5JM1Ap0Jt7n0IUy6hKpUTHF/8KVXJYW5MXhWLSlT4Y8iWjjGVz+7OYjshOw
 txNFox4dCLxHuLfkFpC55kcMYKt2O4SCHsxVYB4uvgH51703T6v9PTT5e7Uq/GDyqt70
 +g9V/58O6MSGChwDG7Z8CQIvQzcPAjJd1Kd/0Qp/QWu1nRsR79w5gZ3Ou2SkmT8mFhgS
 u3BLrKVGrl8fMrTwvNV+ukZStRh6oWlLQO/6inHeIGkEo1fnQKbbP77ILWBiBz5lzv8u
 MbIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1U50dPFfHu52sKajp8yhXvl/XZUN+M/5Z1b5f+kDJyv7au1G//CvnccX+E5htDSV4a/8x4sg=@lists.denx.de
X-Gm-Message-State: AOJu0YxhKBhHKEikKNL1OgCJ4lHuLHvwEpHB+hYftD95JzQDs7usqAez
 J++SsYsE6fat1+tVPUazn4K/T1/RphLLpwQecFXSC7EJVq8RaDP9
X-Gm-Gg: ASbGnct9w9yigVCNEys1PcaMl6M3e/yDTH2FxiHuOkL2Wd5SKfyNGhXlpiXazBzcLJb
 ng/J4iIuD8KWtY8i+xk8uD0Gd3sh2SpQS3TpXMycl63qCdBHB0WyCndv19RHZ4avNYchpTF/xv3
 07GUqA9ye7gVzpj/4AxE3ZI6njPfYCviw9D0iYMD1VL9q6IidbOG8QWJtlF17TZl1QKa1AKVIyg
 XGemOdRSBP8ywwBb/qkeXbh/63JLaT7/pvneBpBh01mmZTU9ubFFrrc6mPdbFZchJkyuaSETzw4
 l4mTLiPpri+nxmmKxQbLA+4xn/0ayZwC939NP55N3bdiq/eRuixFTV0owUFyt4QV2ovW3j4lDlt
 gGeRpGkNHfcQojg==
X-Google-Smtp-Source: AGHT+IECNyjw0wiQagz30PAFi84yIQx6in5IObRMZEiIzkIKf1lSSJHkBfI7cO9zoeHEpeoyPKJTIQ==
X-Received: by 2002:a5d:6d8a:0:b0:39a:cc34:2f9b with SMTP id
 ffacd0b85a97d-39d6fc291b3mr8067360f8f.16.1744056166716; 
 Mon, 07 Apr 2025 13:02:46 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-39c301b9d55sm12723354f8f.42.2025.04.07.13.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 13:02:45 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Bruce Suen <bruce_suen@163.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 11/14] spinand: call SPI setup_for_spinand if supported
Date: Mon,  7 Apr 2025 22:01:55 +0200
Message-ID: <20250407200208.25594-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407200208.25594-1-ansuelsmth@gmail.com>
References: <20250407200208.25594-1-ansuelsmth@gmail.com>
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

Call SPI setup_for_spinand() if supported and defined to configure the
SPI slave for the attached NAND. This is needed to configure the SPI
with the NAND page size and spare size for correct configuration of the
device.

Call it as soon as the NAND is detected to correctly handle SPI
controller with select_op_variant detection.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mtd/nand/spi/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index f5ddfbf4b83..3a1e7e18736 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -941,6 +941,19 @@ spinand_select_op_variant(struct spinand_device *spinand,
 	return NULL;
 }
 
+static int spinand_setup_slave(struct spinand_device *spinand,
+			       const struct spinand_info *spinand_info)
+{
+	struct spi_slave *slave = spinand->slave;
+	struct udevice *bus = slave->dev->parent;
+	struct dm_spi_ops *ops = spi_get_ops(bus);
+
+	if (!ops->setup_for_spinand)
+		return 0;
+
+	return ops->setup_for_spinand(slave, spinand_info);
+}
+
 /**
  * spinand_match_and_init() - Try to find a match between a device ID and an
  *			      entry in a spinand_info table
@@ -964,6 +977,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 	u8 *id = spinand->id.data;
 	struct nand_device *nand = spinand_to_nand(spinand);
 	unsigned int i;
+	int ret;
 
 	for (i = 0; i < table_size; i++) {
 		const struct spinand_info *info = &table[i];
@@ -975,6 +989,10 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		if (memcmp(id + 1, info->devid.id, info->devid.len))
 			continue;
 
+		ret = spinand_setup_slave(spinand, info);
+		if (ret)
+			return ret;
+
 		nand->memorg = table[i].memorg;
 		nand->eccreq = table[i].eccreq;
 		spinand->eccinfo = table[i].eccinfo;
-- 
2.48.1

