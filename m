Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A392AC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:06:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 128FC88980;
	Tue, 16 Jul 2024 09:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KNvKaFI1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4275688998; Tue, 16 Jul 2024 09:04:39 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAB34889AD
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42679f33fefso34562925e9.2
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721113476; x=1721718276; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=THURiOFI4eFaC4+/VLRstvjiqTNqsx1tTNjCIB2Ulbs=;
 b=KNvKaFI136lOsSvUR2SHV9r6qWoCpfsed4Ft/q3s3zQxeoy9X3vLsYW+e5hYpqVMYw
 6tZRiYtL2Q+tUEBU0VjBjnVvU0eXUsTI+uAAypGzDlBxMNovcOrjjh4U7gSQvIBoZj21
 TQojAPZzsZsgqRM9UeGxJym/3l13Hu27Yzat8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113476; x=1721718276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=THURiOFI4eFaC4+/VLRstvjiqTNqsx1tTNjCIB2Ulbs=;
 b=g8V8Jdy/0hcirdxDJTXGSCCEy/59+jXfNSzuqFNRNM9dn4jEsekhNENwJ+z3dRKyj2
 oU0BNPKgScT77DYR/o/RM4Z5UzX3pTqjLuhi4OMFnZxOQ2Dp9Py+xEA2z017jEwefsil
 Y0GCtjFwJNBLimQ6YzKFnVD4Nji+dB5pdhcbZJyS/Hinl9ONSXROBfwp6Y2dHin0msBi
 5ow2IK46E6oWJfmWFKxa8nay3sgYMCRIP4B3870aAnpZ47WnPrrh/TmJcpxBpEMc6yyG
 MTv81pMxdxtFsAsaRvzDBvB6Qb2ojUXsEWOc2zbmA+uoX99mluw+vw8NtMi9dNj6jxEx
 SQiw==
X-Gm-Message-State: AOJu0Yxsv6wxma3L+8Nfpyo6sxfYAAJ38nRxk/MHLOpGvAvAVh1FUFum
 xlegXZInJHJUdxuGtsmDCKCfwLE63O3PQsV2T2Za+FwalgcRjg+oKnO5gbvFqeD8+g518AS4DdE
 =
X-Google-Smtp-Source: AGHT+IGtqSrZ1JvkIIaa9iYAzk1zd9ASHsYfz2X68bpV62xYr3euCoVXS6uqs13NQ2LHRvsf4rzUQg==
X-Received: by 2002:a5d:678f:0:b0:367:9329:246b with SMTP id
 ffacd0b85a97d-36826101c57mr672511f8f.25.1721113476331; 
 Tue, 16 Jul 2024 00:04:36 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2cc286sm149446295e9.33.2024.07.16.00.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:04:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 12/14] doc: Add a link to VBE from the bootstd docs
Date: Tue, 16 Jul 2024 08:04:17 +0100
Message-Id: <20240716070419.1897560-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716070419.1897560-1-sjg@chromium.org>
References: <20240716070419.1897560-1-sjg@chromium.org>
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

Link to this page to make it easier to find the VBE docs.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 doc/develop/bootstd/overview.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index e4924b55ae7..4a55b7da00a 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -416,7 +416,7 @@ Bootmeth drivers are provided for booting from various media:
    - :doc:`extlinux / syslinux <extlinux>` boot from a network (PXE)
    - :doc:`U-Boot scripts <script>` from disk, network or SPI flash
    - EFI boot using bootefi from disk
-   - VBE
+   - :doc:`VBE </develop/vbe>`: Verified Boot for Embedded
    - :doc:`ChromiumOS <cros>` ChromiumOS boot from a disk
    - EFI boot using boot manager
    - :doc:`QFW <qfw>`: QEMU firmware interface
-- 
2.34.1

