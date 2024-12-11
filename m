Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C88AE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84A3D80285;
	Wed, 11 Dec 2024 14:54:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i8NH4TIz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1985F80209; Wed, 11 Dec 2024 14:54:37 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D99F280285
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:54:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-844ba46e0e4so148793739f.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733925273; x=1734530073; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T1dOJqfhavQlk1vzE1H71zxp82RS5HyP8F7dPO0ifK4=;
 b=i8NH4TIzmTVbLpoeqVdbf8GaXvBD3aVoJU7IPmr5Ybqd+C8Az9fGtVw+VYeO6xshIl
 Nn/ZnvYJBNz+PBaIpt1N7qUeg/HGc/29BMURVlHlJnXM96hmgqUKsO4o8LIE53jRJFz3
 HsG2Z2Bs3J1a/lRhV/BPodUmH9ura4aZSakuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925273; x=1734530073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T1dOJqfhavQlk1vzE1H71zxp82RS5HyP8F7dPO0ifK4=;
 b=QeipLNRVO8mNCzmYm5Li+91f801mYfiyODUub+AYmCyEXGejp1Q6N0/rUbVOzvtkwQ
 gBbfOteuJ9FYnzgYxu57eh4BVw3wYzj8L1S7tlsiegE2F8qONJIrNwUqWeYsGRknlVms
 rCmE27UPLFUrwEQ0N4DJlD3wPjNaICr5+WzYdj8HQg0yk2MptTq6TfqZ68Of9C/DefOB
 0djJICoUYJDYectTLFrixDTrNRUkQP/FHmm43RvDKlJ9dx+rRD8MprQNS0k8vv21oS15
 X5rj7TTxIJw2NkUqH/NDu3O+qyzBZmooZ9NXtmjl649Uj6E7bA2GDAQrttWg8cdnc2oS
 QYXw==
X-Gm-Message-State: AOJu0Yy6q+EK85rHz3DCOwHghGcN4tQHr+gTf8qIW308TRvhBqP9ZFr2
 oLfsaoWKYlBVgjVcLknkX2J7fRbPTKX4Oqjul//o02tc4cADjJ2K52ctOIeR0+Z7Vwcrz2pPjWM
 =
X-Gm-Gg: ASbGncs0HZHbQWjmjkmqL0yLyCTdPI6AK49jZHi4p/PV4pfUXvSLEk91VGh8d6J9b+O
 pLEYwQrDptOaUlKUYA9LbeV/dnyN+s4HpFRCM4qQRjSgyRnPsLx/+HK4xZysWt1k89cdTgLBdKZ
 c9Bhm2Zla1rB/POMPhl4Z+QA2yF8R6PqiQmG5LvLxq1SrSLATXBwUDkM4EXmidv/vUlb2oJ9yAG
 01Wb5DqCBB2GbK7pDZDX9tqijlJtLtm7r+euAJX9ggaSgUL2b8vnb2B7GIVGhl46TAq+2iqmQWx
 VUF+shpplYBOago=
X-Google-Smtp-Source: AGHT+IGEiC8i2ZAcO82HitrJTr37v/rceZs3QfLwse8aybYcbtaPPSRedQXSrcJiV01QH0hg5ulpaw==
X-Received: by 2002:a05:6602:3f89:b0:842:ef83:d3cf with SMTP id
 ca18e2360f4ac-844cb62862fmr407576339f.11.1733925273091; 
 Wed, 11 Dec 2024 05:54:33 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d46f66f0sm695441173.30.2024.12.11.05.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:54:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 05/23] efi_loader: Update startimage_exit self-test to
 check error
Date: Wed, 11 Dec 2024 06:53:59 -0700
Message-Id: <20241211135418.563803-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211135418.563803-1-sjg@chromium.org>
References: <20241211135418.563803-1-sjg@chromium.org>
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

Check for an error returned from the decompress() function, just in
case.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 lib/efi_selftest/efi_selftest_startimage_exit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_startimage_exit.c b/lib/efi_selftest/efi_selftest_startimage_exit.c
index b65a10b7a4b..8d119f054c5 100644
--- a/lib/efi_selftest/efi_selftest_startimage_exit.c
+++ b/lib/efi_selftest/efi_selftest_startimage_exit.c
@@ -84,13 +84,15 @@ static efi_status_t decompress(u8 **image)
 static int setup(const efi_handle_t handle,
 		 const struct efi_system_table *systable)
 {
+	efi_status_t ret;
+
 	image_handle = handle;
 	boottime = systable->boottime;
 
 	/* Load the application image into memory */
-	decompress(&image);
+	ret = decompress(&image);
 
-	return EFI_ST_SUCCESS;
+	return ret;
 }
 
 /*
-- 
2.34.1

