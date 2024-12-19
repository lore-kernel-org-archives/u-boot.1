Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49166E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 18:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ACB18036D;
	Thu, 19 Dec 2024 19:29:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cAEBXXyN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E0CE8035E; Thu, 19 Dec 2024 19:29:46 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE5B1803CF
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:29:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-844e10ef3cfso80696839f.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734632982; x=1735237782; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmYNmrbAeYv0Sh1EWrfaiKx/UwCgZHMfqJoAMoZFvRQ=;
 b=cAEBXXyNIdZ2P1Swv2U6wx4j5pwMFZOivMiQHA/c1EJi+AdOt8kxDtQGP4PtKr1miK
 k50z+Va2wKikdFbfWrXEyMSb9TigwXLn3AoPAXIMvOFND0tYGuyW42p65K36XYuL8fLb
 tLPxYoXRoY0JNCvoDtme6KEJAlA9YN8HHg/+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734632982; x=1735237782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fmYNmrbAeYv0Sh1EWrfaiKx/UwCgZHMfqJoAMoZFvRQ=;
 b=J0hYv4t3FQE5sgSNZ9rITp7DKzaSLtjJjm2qjR/2dpxWJ0Vs3E4huQpaBWQbNVZjPt
 zxR5K0Q/JVMuYZIPKlGmzea6X4bPkK7HRd5BXQ6Mudb7xEbEUxJtGwm+m1sBjBJTmlSp
 27zUNydIQIYjOaKTv8KIQqE3UjnsJpHKFZSLHoZ748HswZVZ2foUNx3D789U+vMyazy6
 hG33ml397FF2WG+NoFY7r8oSr3pLx+2hgXrHnI3y4IAQ1oPtNtBN3Gl7CcTXlG4XJwjS
 aOfPFEXnlRdwPfsgCiH8a998Z9nm5c6TWQgDua/S0RgpzA1J2rAyPwix75YA+hEOrlWC
 ykUA==
X-Gm-Message-State: AOJu0Yy2zqUyZY4rblw3tgv+gnpSHnlxa6HbCxZVQNVwmH45S7mp2KIX
 H2AN9dIaiLmGaSgeKr1EO4ZTb3q7ysc0BBJG8N8hu738nMdHLD2kCxVl3Dx9BAFj6Hv/XG1RCGM
 =
X-Gm-Gg: ASbGncv1s+EVe8596DHANJUPdZU+00dLhJBw+QQZHbElKepEKkrzUv3TJ46v+T4UGfB
 +XzxAbHk2huVwWWEPJGUs0Xvi3sNjzFbLcBR1cCthrGDgO/BEHjfKqmX8CIYC5ieuXtNbelkSXw
 Hf/733nJuZ7TxQ8z/zCQlp2lrqgiukxc1EegqPS1VU6PnGji8rVIeFqhqnGfCfbW0NciCO3I0bc
 r5+ulusmu6PRZCp81aZGT6HdOHRv5+QsBJk7E+I62kxDyyBS18P8TiOEs7cNm0y03f5iRMBjxFb
 ZEqlbdHKe0Ln64KN8g==
X-Google-Smtp-Source: AGHT+IHy1t4WaNvTOvwKlcM8DlVE4rDDFDIiIxK69uDpJxm4x6Yl49pXHIAOrhV4aqJZ7gNOBXcZmQ==
X-Received: by 2002:a05:6602:1651:b0:841:8d66:8aea with SMTP id
 ca18e2360f4ac-84987bdfd59mr439196439f.2.1734632981912; 
 Thu, 19 Dec 2024 10:29:41 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68bf676c6sm393655173.50.2024.12.19.10.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:29:40 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 13/19] spl: Drop a duplicate variable in boot_from_devices()
Date: Thu, 19 Dec 2024 11:29:01 -0700
Message-Id: <20241219182907.2609704-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219182907.2609704-1-sjg@chromium.org>
References: <20241219182907.2609704-1-sjg@chromium.org>
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

The variable 'ret' is defined twice, which is not intended. This may
have been a local merge error.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 2eefeb6d893 ("spl: Report a loader failure")
---

(no changes since v1)

 common/spl/spl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 702920bd2f7..ad31a2f8b6c 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -612,7 +612,6 @@ static int boot_from_devices(struct spl_image_info *spl_image,
 	for (i = 0; i < count && spl_boot_list[i] != BOOT_DEVICE_NONE; i++) {
 		struct spl_image_loader *loader;
 		int bootdev = spl_boot_list[i];
-		int ret;
 
 		if (CONFIG_IS_ENABLED(SHOW_ERRORS))
 			ret = -ENXIO;
-- 
2.34.1

