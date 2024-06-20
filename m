Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCEDC2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD86888577;
	Fri, 21 Jun 2024 01:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HP6Jj68K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1FEE8834D; Fri, 21 Jun 2024 01:06:44 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DA9E88551
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7eb7a2f062cso50900039f.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718924801; x=1719529601; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1DwbEmlb7j97i9Q+0Gkqlcn3kq0fvAKIR9SwwmRHzEg=;
 b=HP6Jj68KOTqeKI2nemKOfNdVLhzf2InSfhMP0snq2j+Grv5Bi8Csfqn9ezlUsM/TGm
 gy7bqmBojuUXFTLFuM4N5fiPjbuL/dRzkOf67FDDpJD4pf+HwDrg0rQwLNjYJchNIj4L
 CJ9Zp13lf5dwsqDwuZ3uZAZvMzjjEdcscSawc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718924801; x=1719529601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1DwbEmlb7j97i9Q+0Gkqlcn3kq0fvAKIR9SwwmRHzEg=;
 b=tpg9imPBJU4K0Lq78vHCoaCNmoep4V+dBNNRV1iiGlpzXeOim1AVZf+Ut7VKRATDVf
 lTYnsfMG+9pkQNsR3fYDs58hkbdXDevX0SkKVBVwA1JceSs7HXj4aj612jnZPgTBcXbY
 t/evL8iRwLNgRHWWXJREvixbclAs1QBY1MF0J8Qo33prWwHHvkHz3zxH5dbcfU99rK7u
 BFfwdfNYZCW8/qwLoo7EpSVGtJbHl6L1EszME5EpQdnUP78LZOFi0va8xygVUeqsLVq1
 8C1O+YS1q8WujghggBEcpZuZktGXdZtqO1LNYc5st5krnwJDPoSnJDnZ2tFGFDqxgeDd
 GZ+Q==
X-Gm-Message-State: AOJu0YxTN04/S9GihWdzQdymFn1Pu725ofasgQCkkdpQ6cg3fqvz5COa
 Bv+8PMAoSp9pAcdJ3SYoAJqjfuwJzgLbFiSjTSaVRNFnEsj66c9VFSile8WY8PhW2m+BeJbsEFH
 q3w==
X-Google-Smtp-Source: AGHT+IEsvXZk/8a8pw19QP5yQfu1jz/W3kDS36Xemy6AJ+IqloNbYigXXGLTDQQzRH4hMCBYlRdzIw==
X-Received: by 2002:a05:6602:60cb:b0:7eb:ae17:c234 with SMTP id
 ca18e2360f4ac-7f13ee5a7c2mr801108739f.11.1718924800692; 
 Thu, 20 Jun 2024 16:06:40 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110f566sm53269173.44.2024.06.20.16.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 16:06:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 03/18] mkeficapsule: Add a --version argument
Date: Thu, 20 Jun 2024 17:06:10 -0600
Message-Id: <20240620230625.1797397-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620230625.1797397-1-sjg@chromium.org>
References: <20240620230625.1797397-1-sjg@chromium.org>
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

Tools should have an option to obtain the version, so add this to the
mkeficapsule tool.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 doc/mkeficapsule.1   | 4 ++++
 tools/mkeficapsule.c | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/doc/mkeficapsule.1 b/doc/mkeficapsule.1
index c4c2057d5c7..c3d0f21488a 100644
--- a/doc/mkeficapsule.1
+++ b/doc/mkeficapsule.1
@@ -87,6 +87,10 @@ Generate a firmware revert empty capsule
 .BI "-o\fR,\fB --capoemflag "
 Capsule OEM flag, value between 0x0000 to 0xffff
 
+.TP
+.BR -V ", " --version
+Print version information and exit.
+
 .TP
 .BR -h ", " --help
 Print a help message
diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index 6a261ff549d..c112ae2de8d 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -21,6 +21,8 @@
 #include <gnutls/pkcs7.h>
 #include <gnutls/abstract.h>
 
+#include <version.h>
+
 #include "eficapsule.h"
 
 static const char *tool_name = "mkeficapsule";
@@ -28,7 +30,7 @@ static const char *tool_name = "mkeficapsule";
 efi_guid_t efi_guid_fm_capsule = EFI_FIRMWARE_MANAGEMENT_CAPSULE_ID_GUID;
 efi_guid_t efi_guid_cert_type_pkcs7 = EFI_CERT_TYPE_PKCS7_GUID;
 
-static const char *opts_short = "g:i:I:v:p:c:m:o:dhARD";
+static const char *opts_short = "g:i:I:v:p:c:m:o:dhARDV";
 
 enum {
 	CAPSULE_NORMAL_BLOB = 0,
@@ -70,6 +72,7 @@ static void print_usage(void)
 		"\t-R, --fw-revert  firmware revert capsule, takes no GUID, no image blob\n"
 		"\t-o, --capoemflag Capsule OEM Flag, an integer between 0x0000 and 0xffff\n"
 		"\t-D, --dump-capsule          dump the contents of the capsule headers\n"
+		"\t-V, --version               show version number\n"
 		"\t-h, --help                  print a help message\n",
 		tool_name);
 }
@@ -969,6 +972,9 @@ int main(int argc, char **argv)
 		case 'D':
 			capsule_dump = true;
 			break;
+		case 'V':
+			printf("mkeficapsule version %s\n", PLAIN_VERSION);
+			exit(EXIT_SUCCESS);
 		default:
 			print_usage();
 			exit(EXIT_SUCCESS);
-- 
2.34.1

