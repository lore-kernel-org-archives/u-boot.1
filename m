Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1769CC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:34:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C438C878C6;
	Mon,  4 Dec 2023 01:30:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eFkeGAqr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CB4D87873; Mon,  4 Dec 2023 01:30:43 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 756BF878C6
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:30:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6d855efb920so2093619a34.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649839; x=1702254639; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CBpWzzEe+mW1xxQC8Sb2jd+13nzscUzeqr3Aoi58Bz0=;
 b=eFkeGAqrdlou95UIDIRNEr6EuxcHTpuuV5d7Unb992nNLU2WfEVcaggXY2SYcyRKho
 gNC84gPDcMqh1nCVGb6Pl7E2s3+wusSIFxyLheCdPTpobAHIi2fyNyLKhvPCiTGty9P1
 wdyazy8XFpolkM9bJEjl+MDGlP0eCLFEy1g9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649839; x=1702254639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CBpWzzEe+mW1xxQC8Sb2jd+13nzscUzeqr3Aoi58Bz0=;
 b=aMGQaXkT7AVYYhBXJRXgZrrt2Q45AgUs4PINybC9dpK92f7LAz5WduJoF98cPFAAVK
 U91qHxVbvzgxQO/wDo3pljoz/bSUpEa1PiT2QaHoaUJMfqiYoMSRAiPS8eL3o+BaS9qL
 6peAb34FNdoYkhLqhutv0pdg/Ul1667dZ/hyd08+2Nh3JV+afk6RCiTjYZqhQ1H6JFjC
 fjJ+o5/iVHQgnU6NkotrRLeWIAoLnohduXm5nNcl1nCI1eMqUpjQnyNd45yZxkQY/cK+
 mv6GAMcCAJY65Iaz1LQ4ISEfIcHKZ0nqC4P+GK5yTcysOgOthV1nAvAQwHnJn2NDsKKt
 BezA==
X-Gm-Message-State: AOJu0YwVqURNPJy5A1NlOQv5bz728IXcTiXkOk1a/IlYtPciDQIwuheK
 TGpBeAc8rAuRdy3WDqRmFIG5K2t9hv5K5AKzahfsTw==
X-Google-Smtp-Source: AGHT+IEFOCbYyiJj5HJyrohXbv4uUDY8v6rIjDxrzYzKnRK0llnReQuQUj/kQWiZ+Aff3ITDPZe6FA==
X-Received: by 2002:a05:6830:390e:b0:6d8:5ab6:6544 with SMTP id
 br14-20020a056830390e00b006d85ab66544mr4515293otb.36.1701649839025; 
 Sun, 03 Dec 2023 16:30:39 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 o24-20020a056a001b5800b006ce3a0b4bfasm2346433pfv.24.2023.12.03.16.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:30:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 13/13] x86: zboot: Tidy up the comment for zboot_run()
Date: Sun,  3 Dec 2023 17:29:38 -0700
Message-ID: <20231203172933.13.Ie349ceed16b88ecd28511cd4678c867fbeb0d8bc@changeid>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204002944.897949-1-sjg@chromium.org>
References: <20231204002944.897949-1-sjg@chromium.org>
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

The current use case (ChromeOS) is the uncommon case. Document how this
function is more normally used, where base is 0 and cmdline is NULL

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/bootm.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/bootm.h b/include/bootm.h
index c815c40e3c4d..1800ca32c264 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -248,11 +248,14 @@ int bootm_process_cmdline_env(int flags);
  *
  * @addr: Address where the bzImage is moved before booting, either
  *	BZIMAGE_LOAD_ADDR or ZIMAGE_LOAD_ADDR
- * @base: Pointer to the boot parameters, typically at address
- *	DEFAULT_SETUP_BASE
+ * @size: Size of bzImage, or 0 to detect this
  * @initrd: Address of the initial ramdisk, or 0 if none
  * @initrd_size: Size of the initial ramdisk, or 0 if none
- * @cmdline: Command line to use for booting
+ * @base_addr: If non-zero, this indicates that the boot parameters have already
+ *	been loaded by the caller to this address, so the load_zimage() call
+ *	in zboot_load() will be skipped when booting
+ * @cmdline: If non-NULL, the environment variable containing the command line
+ *	to use for booting
  * Return: -EFAULT on error (normally it does not return)
  */
 int zboot_run(ulong addr, ulong size, ulong initrd, ulong initrd_size,
-- 
2.43.0.rc2.451.g8631bc7472-goog

