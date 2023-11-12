Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E7BC4167B
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:46:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 213B3871AB;
	Sun, 12 Nov 2023 01:45:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kY5RwMgy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CECF86FF2; Sun, 12 Nov 2023 01:45:51 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3E1086FA6
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:45:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7a68b87b265so124063439f.2
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699749944; x=1700354744; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nPC9JcjXNAjZrtLIT8R9mFy9HO6UO84QGVSE3RgXc9g=;
 b=kY5RwMgyLXxVcI4lZNvJj3+gfDsPHIESQqky5Z7wBkWXdmC3m0C/LTHrHtLycUVEDy
 S4xram3Ih1VXsuNiPnVdzhzfBDgDsU+1G2kfYy3ZtptHVhyAVdm+QSZMfk2D2COSzdTn
 BlpUGWMgYKWYMdiMaLb80kU6ldQH6oQQJg/UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699749944; x=1700354744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nPC9JcjXNAjZrtLIT8R9mFy9HO6UO84QGVSE3RgXc9g=;
 b=hkKBoEtuP1Iz7IGSWqKSxdRhaHiCfRkUNuYzg77pQVvwXeYTOW7rf/Vbp7XIIF/S5/
 obD1FtdVierqrOcG/csWsZ/xlsJrBieXQ5kSKJ2LeOeX8Dq/vfQQoRpLISxIEPwcJSXW
 TZbkIQULrTbPSIEp78u9StObRL5uIaRNy9Cq59A1wK8LMjnEqV9ksWRrO21YWSNDbiyA
 5/0EGnxlXxWbx+F9NjFfZxUmXNaY+y4G/al0hSqmMVdJpuQfdlxD0ifqgnDxMUT9EcOW
 HNCxxqbuxWndwTIXRy9ar0/gJ4UIYNmSCtqxHSs5HINkWVAYtViZJ3Uei6fpjqz4i8pT
 omoA==
X-Gm-Message-State: AOJu0YwUvFrKpHrHx5r8LlIvLfqi6ZVf9PqzJGAhIXClRi/SSbQB+f0S
 uykpKfvzg4Xuwp54j16pJoGIctMg9txRym+qfIbVHw==
X-Google-Smtp-Source: AGHT+IE6RXVCR0Et/px93/7ef6iM+WkTyAZD9ZNBMc5b3yjKZakknJ4EmBDX/dMHZQwHsPTn1589vw==
X-Received: by 2002:a5e:8b43:0:b0:7ab:ec1f:f486 with SMTP id
 z3-20020a5e8b43000000b007abec1ff486mr3848063iom.4.1699749943801; 
 Sat, 11 Nov 2023 16:45:43 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a5ec111000000b00785cfdd968bsm765277iol.5.2023.11.11.16.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:45:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 1/4] bootm: Allow ignoring the load address with
 kernel_noload
Date: Sat, 11 Nov 2023 17:45:32 -0700
Message-ID: <20231111174533.v2.1.Iae1cd9e0e207784e680480ee52021ec5caed877e@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112004539.80982-1-sjg@chromium.org>
References: <20231112004539.80982-1-sjg@chromium.org>
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

This image type is supposed to ignore the load address. But at present
it fails if the load address is missing. If it is zero, the image is
loaded at address 0, which may not work on all boards.

Make use of the kernel_addr_r environment variable, instead, since this
seems to be a more reliable final address for the kernel.

Another option would be to create a new Kconfig for this, or to use a
region of memory known to be free, e.g. calculated from the DRAM banks.
But in any case we should try to avoid conflicting with the
kernel_addr_r variable. So the approach in this patch seems reasonable
to me.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index cb61485c226c..7583be5a4515 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -176,7 +176,13 @@ static int bootm_find_os(struct cmd_tbl *cmdtp, int flag, int argc,
 
 		images.os.end = fit_get_end(images.fit_hdr_os);
 
-		if (fit_image_get_load(images.fit_hdr_os, images.fit_noffset_os,
+		if (images.os.type == IH_TYPE_KERNEL_NOLOAD) {
+			ulong load;
+
+			load = env_get_hex("kernel_addr_r", -1UL);
+			printf("Using kernel load address %lx\n", load);
+			images.os.load = load;
+		} else if (fit_image_get_load(images.fit_hdr_os, images.fit_noffset_os,
 				       &images.os.load)) {
 			puts("Can't get image load address!\n");
 			bootstage_error(BOOTSTAGE_ID_FIT_LOADADDR);
@@ -229,7 +235,7 @@ static int bootm_find_os(struct cmd_tbl *cmdtp, int flag, int argc,
 
 		ret = fit_image_get_entry(images.fit_hdr_os,
 					  images.fit_noffset_os, &images.ep);
-		if (ret) {
+		if (ret && images.os.type == IH_TYPE_KERNEL_NOLOAD) {
 			puts("Can't get entry point property!\n");
 			return 1;
 		}
-- 
2.42.0.869.gea05f2083d-goog

