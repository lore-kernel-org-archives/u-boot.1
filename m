Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F40D1BDD4
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 17:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 925F188F68;
	Mon,  4 Nov 2024 18:51:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ShFH833G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BB4E89078; Mon,  4 Nov 2024 18:51:48 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7591788F9F
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 18:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-83ac817aac3so175812339f.0
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 09:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730742705; x=1731347505; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AH/I0XxzGK7id4U27Iqu4i8aUtBlEM5rJQ2ItONwAmk=;
 b=ShFH833GQbdcQYQjw/v+pJFvJg3Hxu6Jl1/9e11t7yw46JjTwgEnV1UKOg4wOETwQ3
 OWsmSggidUfvhGrvRvVv65oJB7Q0DeDkTzSK4+7PjyWhBGuN5ShCTWPuF2y9K/hSEpwM
 dZFhW80Xal0EouedTBOtE8xI+MWoQYWNcFCgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730742705; x=1731347505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AH/I0XxzGK7id4U27Iqu4i8aUtBlEM5rJQ2ItONwAmk=;
 b=WeRa4BZOJTiKgV5XLNcH5/ZCan+APsarlJuXANrsrc+JtWawic7GRBdVU0rbo0/2qV
 /8uTsEGmSxCe5dM7sEKfMlM1apEQw8ro5v5dgAntxwMh6a/B5bpqwM9Wn3Nl7PqAMsnX
 rmcCvGyhOZZ/k9c3cW41mVbBRdw1QtJe/0fp9tS+CnCBNLKSEaOpivoHTwhlwCl27dwh
 bVeLN1yRIkbpEevmBaUglZsXEzOYyMObhTPdC4El6t3rrTXBdxgKa0GPi28gr/dqpK9Q
 /dmwhfN9sy3roBBFjGPQ0tzzGECHCCaprw/zYDXExWSDa+aqi99oiO58aNfuMMuReh8F
 COpA==
X-Gm-Message-State: AOJu0YyjXf4OGI0MagxAxBSDYTJgHLq1Lu+n0FCQ874t2eXUe25fjw3h
 rCisUpBWiPt1EkUV7xKd7nTlX1T0JFUH3x9xsJUhMhAQGCYGJonFc+BwTMA6WoZBLUeipLTTXpg
 =
X-Google-Smtp-Source: AGHT+IEK/dPHSUMGZWrc4zYKsa/Zi5ivk9jBDO9s5fADxtuQKPBdAsRs4a+yJfkAquE3EZCgbA+uOQ==
X-Received: by 2002:a05:6602:2cc8:b0:83a:f447:f0b9 with SMTP id
 ca18e2360f4ac-83b56712446mr2351672339f.9.1730742704642; 
 Mon, 04 Nov 2024 09:51:44 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de04977b30sm2005288173.116.2024.11.04.09.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:51:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v3 17/19] bootstd: Export bootdev_get_from_blk()
Date: Mon,  4 Nov 2024 10:51:08 -0700
Message-Id: <20241104175110.1048449-18-sjg@chromium.org>
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

Export this function so it can be used from other files.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to export bootdev_get_from_blk()

 boot/bootdev-uclass.c | 2 +-
 include/bootdev.h     | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index a4e1d79ec9b..65a3b89e40c 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -319,7 +319,7 @@ int bootdev_get_sibling_blk(struct udevice *dev, struct udevice **blkp)
 	return 0;
 }
 
-static int bootdev_get_from_blk(struct udevice *blk, struct udevice **bootdevp)
+int bootdev_get_from_blk(struct udevice *blk, struct udevice **bootdevp)
 {
 	struct udevice *parent = dev_get_parent(blk);
 	struct udevice *bootdev;
diff --git a/include/bootdev.h b/include/bootdev.h
index 991b6229c1c..12c90c4ec1b 100644
--- a/include/bootdev.h
+++ b/include/bootdev.h
@@ -401,6 +401,15 @@ static int bootdev_setup_for_sibling_blk(struct udevice *blk,
  */
 int bootdev_get_sibling_blk(struct udevice *dev, struct udevice **blkp);
 
+/**
+ * bootdev_get_from_blk() - Get the bootdev given a block device
+ *
+ * @blk: Block device to check
+ * @bootdebp: Returns the bootdev found, if any
+ * Return 0 if OK, -ve on error
+ */
+int bootdev_get_from_blk(struct udevice *blk, struct udevice **bootdevp);
+
 /**
  * bootdev_unbind_dev() - Unbind a bootdev device
  *
-- 
2.34.1

