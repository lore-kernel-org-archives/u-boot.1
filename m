Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891EEC072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 15:37:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8695087186;
	Sun, 19 Nov 2023 16:36:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CC8y8S0I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC23D87186; Sun, 19 Nov 2023 16:36:28 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA852870D0
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 16:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7a9857c14c5so132035839f.3
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 07:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700408175; x=1701012975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f/iIpS/hvCst/DJxhnXJQ2xG3OSRvKee1VdJ7EeJbSs=;
 b=CC8y8S0IxPYxt3Z/5Vo0NlJZoAPJU5Dm47cWY89YS4oWMwbHL3hDruqQZKIlL0ROhC
 +IaetKRQrk0X8Z2X8jSRWFgxugE7MCzKte6yraIxGE+12QaAOhDZdTFGUVEuOFEgsy+P
 3IOqZ5dx3ayZxkjFSEmyvIOEtTFCdnEFvKm+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700408175; x=1701012975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f/iIpS/hvCst/DJxhnXJQ2xG3OSRvKee1VdJ7EeJbSs=;
 b=HKYUeIkqvUt6oRo9gnStYQqjfJgxHbsmQwNNVsBsqSiDonXLyBT5IkDWgjOp51VkeL
 34EWyvxG83dVRHJvslbo/WoVMMOBp4NRjYsNR8VSXLToQphpcbb7KTX+bQyW5eun6ihK
 CbX0uLmCcb671IgVGjTWsSIr70ISHCE2uw96ybDiW4UTVIHPG0r3A/Vb6GVDNJTGM7+r
 7WvA2Xl7j3HIDhGlKXzpWt1dZR5MFWXD5ANG5P/IT2XaV3hoM/zHr/zbcAti0UYn1UMO
 fbpIiuMV23uM089EtjURIXSjuL0yE0uS0WEa72x14uYUVD3zt84v2yBegYGly3IaMoSL
 kc/g==
X-Gm-Message-State: AOJu0YwjCUZqjutwYBE9AJke1kzp7XB2b/ylwRU3UJ1Vp6KPVo8frwRX
 aHsUwGHZG99Y3vKo+EO+6pRj5u3TvjKWS4n3jlqkAw==
X-Google-Smtp-Source: AGHT+IGuDFqKsI6frbR2f4v0CHlS9zb6agek3aMp8FcOd0b2vq6c9eEpiKj4seOE9yW0QaAysrIatA==
X-Received: by 2002:a6b:e304:0:b0:794:c9a2:5fe3 with SMTP id
 u4-20020a6be304000000b00794c9a25fe3mr6382500ioc.4.1700408175338; 
 Sun, 19 Nov 2023 07:36:15 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 19-20020a0566380a5300b0046456924383sm1466712jap.73.2023.11.19.07.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 07:36:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/7] tools: Keep test_util and patman test files in the pip
 release
Date: Sun, 19 Nov 2023 08:36:02 -0700
Message-ID: <20231119153611.639252-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119153611.639252-1-sjg@chromium.org>
References: <20231119153611.639252-1-sjg@chromium.org>
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

The test_util module is actually imported by some tools, e.g. binman so
include it in the pip release.

The patman tool uses its test code when starting up, so keep that too.

Show a list of deleted files so it is clear what is happening.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/make_pip.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/scripts/make_pip.sh b/scripts/make_pip.sh
index 4602dcf61c88..25a4049271c9 100755
--- a/scripts/make_pip.sh
+++ b/scripts/make_pip.sh
@@ -29,6 +29,9 @@ repo="--repository testpypi"
 # Non-empty to do the actual upload
 upload=1
 
+# Non-empty to delete files used for testing
+delete_testfiles=1
+
 tool="$1"
 shift
 flags="$*"
@@ -58,6 +61,11 @@ if [ -n "${upload}" ]; then
 	fi
 fi
 
+if [[ "${tool}" =~ ^(patman|u_boot_pylib)$ ]]; then
+	# Leave test_util.py and patman test files alone
+	delete_testfiles=
+fi
+
 # Create a temp dir to work in
 dir=$(mktemp -d)
 
@@ -91,7 +99,9 @@ find ${dest} -name __pycache__ -type f -exec rm {} \;
 find ${dest} -depth -name __pycache__ -exec rmdir 112 \;
 
 # Remove test files
-rm -rf ${dest}/*test*
+if [ -n "${delete_testfiles}" ]; then
+	rm -rfv ${dest}/*test*
+fi
 
 mkdir ${dir}/tests
 cd ${dir}
-- 
2.43.0.rc0.421.g78406f8d94-goog

