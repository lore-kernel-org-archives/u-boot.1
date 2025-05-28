Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C733BC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:26:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D08883989;
	Wed, 28 May 2025 10:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ec7TWFdn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88FA28397F; Wed, 28 May 2025 10:25:59 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5327D83970
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2cca475546fso2952254fac.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420755; x=1749025555; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SYGYR6EBFXufQX/9/N5o2/u4m5oXLjlHB+6uZNExpNA=;
 b=Ec7TWFdnNuwXeH6Kj7RvUCtQpiKdL6NwGJrnSTvNfCIuvuF/FbUtT0Ph9QLoShI8Sq
 BtPYe/eOzQNOhfTlwt+wqEhJXk0bMBZnMSDKZ5B0Q2GPFsRawInEJY4nmcJCa1QPD6vS
 QxBB5R7KKHiW7F+/2PT3DYGQwBVLIKgTiPHjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420755; x=1749025555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SYGYR6EBFXufQX/9/N5o2/u4m5oXLjlHB+6uZNExpNA=;
 b=uJcnxJERHTgrEUNVa9Ea0Dr6WyApu+tAckM0aX8nzuoZr69IKMmugU/uYsTt2UHaJx
 Sao1jjKOkeFMfljDWPIiRkFtKuf/v0u3EvYTlWdfG86/yIneAU0JCIy3hy+UnKhNWjGw
 p4r9/97VaY3NEtczBCZQDfrtEcmPMvVoHpSId5MkRTV1bZdhXAjTd1JrjVTduKCwe7Gw
 3n555kiAPsTZ/KMnmJX5SAM8xlfB69sqKOzg5LxMejHSLkt15aM4rJ4JC/RpFzbysLfh
 gGl5hl8i/Z6dKmxu6QcdhaeWQC7/DOe/JkDQ7fqdgea3CbKyRM/VC/VqO92RgZfjnfu4
 4zlQ==
X-Gm-Message-State: AOJu0Yylxx4lQy9uFf45m0P/cwI3vQsbd+Tbe1mjHZmF3N2J3uvDP9lA
 PibzIYtaR4wiUL/W/exEIej/aXbCaO2lcdcf/oS2Krxb7XrFj1t+BZuQbYuAbvLfBkqzNx83Uj6
 qfoFnBDuP
X-Gm-Gg: ASbGncubybEf9XXOOSMPf1ZaQ1TCbtAZANDQVw1B4RsvsQRaYcu0o6j2vsIcvipWCDF
 hKaK9C1lQR4tGudwNLvI2LRIiPsiwuvkc4T8BmZH2LvMLC5DHmJWUEXF2gy224PBGHfFDbVe7EE
 oZfcX19WVLTm1boAkGVUjP8PB+2L5vZpAgMC4LEJCxJuu5Gvgqat0l/0GDzIQWMvH1h4t1kgywb
 1GIWGoJKQzxrsbSdB863f08v3v2sfMxbyQiKEe02hmwsTgOthEawhqQTGTP+T9kZ1s0XuMQ1m5p
 CdNLjMUsOAJD0LHCsDt/o+XAHihwowRNQtFliQmr075tKNX9pGAAtSiSj7mj6dKujkl3vHYTox1
 QsOTaF79Zd82s
X-Google-Smtp-Source: AGHT+IEQTCIz40ucZziyaOyELQ5nBq1M4gC+rJHSJ4CM69MQ+4bhUci+NEScY93zLuZo1Ge41mVzkw==
X-Received: by 2002:a05:6e02:2411:b0:3dc:7d57:30a8 with SMTP id
 e9e14a558f8ab-3dd8b014df5mr10255855ab.10.1748420744761; 
 Wed, 28 May 2025 01:25:44 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:25:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/27] scripts: Change -k and -o options
Date: Wed, 28 May 2025 02:24:28 -0600
Message-ID: <20250528082520.152391-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528082520.152391-1-sjg@chromium.org>
References: <20250528082520.152391-1-sjg@chromium.org>
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

These have a different meaning in build-qemu, so capitalise these
options to avoid confusion.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/build-efi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/build-efi b/scripts/build-efi
index 2f4b916c49b..443a5ca4908 100755
--- a/scripts/build-efi
+++ b/scripts/build-efi
@@ -40,9 +40,9 @@ def parse_args():
                         help='Run on ARM architecture')
     parser.add_argument('-B', '--no-build', action='store_true',
                         help="Don't build (an existing build must be present")
-    parser.add_argument('-k', '--kernel', action='store_true',
+    parser.add_argument('-K', '--kernel', action='store_true',
                         help='Add a kernel')
-    parser.add_argument('-o', '--old', action='store_true',
+    parser.add_argument('-O', '--old', action='store_true',
                         help='Use old EFI app build (before 32/64 split)')
     parser.add_argument('-p', '--payload', action='store_true',
                         help='Package up the payload')
-- 
2.43.0

