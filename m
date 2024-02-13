Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885FCC4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 14:40:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83E6787D96;
	Tue, 13 Feb 2024 15:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C/eCBoEJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84D6787D94; Tue, 13 Feb 2024 15:39:40 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3342987CAB
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 15:39:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-60792653b94so4298707b3.3
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 06:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707835171; x=1708439971; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lPw5O+02i4EARUs89+vHsTKltkaj5jGgHB5ox1kqHBc=;
 b=C/eCBoEJOWAmLRRj5p4wUzuXlJgpgpCLgRHQkd4HinFBP0wZNtbnZgiD6C5FxKFKgi
 vnGkwDLoKGyJ4tnHzBF2Oa4eB5FOkSUodGfEob85Gv9viwmyryiYNt0lC2V0TsD4EJjq
 0aOqSjywM/NL2ty9XABYrX959fsx7d/qKSdDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707835171; x=1708439971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lPw5O+02i4EARUs89+vHsTKltkaj5jGgHB5ox1kqHBc=;
 b=oyrqmqvZXcIz6fdEf8EWus7YMCff3GfgIOfy0cAcrya2ROF2foOiXMT9uf7fbip61d
 8typUW+/KD/fbsnEc0ZiOkl9i2/OO334cmkZeh+GSWFEU7/4QIZNQ/q28X/S2t3Y1tiH
 p0Q1iW06tsCzVDTO1xj/DD2CzNSQ8/VArN1UP3gVMaquxp4/kJdAa0I9iN/8pjKsTlK3
 soddNz/0n3TFnL+00oZw1Wk14A8qHv6CspDHmpFm0+cYZnoOTZadyifHYghvut2PI881
 9v/g2nrkonL1237Hrd4jnUxFcoHTN7E1+xsFaHkDrpgS8SqrwEGSIBdVBdm4lgxPwlf0
 IMVQ==
X-Gm-Message-State: AOJu0YyT2KYTm31/WVO/ZRJfdru1QPCILLUaxq2AQGcUDHdSnWoomcmz
 7rERDFA6NtX6iXuYMpsMuftTZigRa2QpPt8w0GmCtYa4RU2q7OhBuqaMaZSIPayfFXM34+R3qmw
 I
X-Google-Smtp-Source: AGHT+IEk1NSuSmu74qN055PF0las7jsiKoIIZ65ECf3uVjcBZrKSWSAbbHoHqTKxZ5WljVyeNCgvOQ==
X-Received: by 2002:a0d:d449:0:b0:607:7f8a:1751 with SMTP id
 w70-20020a0dd449000000b006077f8a1751mr2406493ywd.22.1707835171276; 
 Tue, 13 Feb 2024 06:39:31 -0800 (PST)
Received: from bill-the-cat.. (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 d21-20020a814f15000000b00604997f9e77sm1765928ywb.5.2024.02.13.06.39.30
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 06:39:30 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/3] CI: Switch to using coreboot from our image
Date: Tue, 13 Feb 2024 09:39:27 -0500
Message-Id: <20240213143928.91443-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213143928.91443-1-trini@konsulko.com>
References: <20240213143928.91443-1-trini@konsulko.com>
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

Instead of downloading coreboot binaries from a Google drive location,
use the ones we have built ourselves.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml |  7 +++----
 .gitlab-ci.yml       | 11 +++--------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index e2646783ee62..aebcc8908687 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -236,10 +236,9 @@ stages:
               cp images/spi-nor.img \${UBOOT_TRAVIS_BUILD_DIR}/;
           fi
           if [[ "\${TEST_PY_BD}" == "coreboot" ]]; then
-              wget -O - "https://drive.google.com/uc?id=1uJ2VkUQ8czWFZmhJQ90Tp8V_zrJ6BrBH&export=download" |xz -dc >\${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom;
-              wget -O - "https://drive.google.com/uc?id=149Cz-5SZXHNKpi9xg6R_5XITWohu348y&export=download" >cbfstool;
-              chmod a+x cbfstool;
-              ./cbfstool \${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f \${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
+              cp /opt/coreboot/coreboot.rom \${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom;
+              /opt/coreboot/cbfstool \${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom remove -n fallback/payload;
+              /opt/coreboot/cbfstool \${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f \${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
           fi
           virtualenv -p /usr/bin/python3 /tmp/venv
           . /tmp/venv/bin/activate
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 278a2e2bbf31..66f3cb14b03a 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -70,14 +70,9 @@ stages:
         cp images/spi-nor.img ${UBOOT_TRAVIS_BUILD_DIR}/;
       fi
     - if [[ "${TEST_PY_BD}" == "coreboot" ]]; then
-        wget -O -
-          "https://drive.google.com/uc?id=1uJ2VkUQ8czWFZmhJQ90Tp8V_zrJ6BrBH&export=download" |
-          xz -dc >${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom;
-        wget -O -
-          "https://drive.google.com/uc?id=149Cz-5SZXHNKpi9xg6R_5XITWohu348y&export=download" >
-          cbfstool;
-        chmod a+x cbfstool;
-        ./cbfstool ${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f ${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
+        cp /opt/coreboot/coreboot.rom ${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom;
+        /opt/coreboot/cbfstool ${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom remove -n fallback/payload;
+        /opt/coreboot/cbfstool ${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f ${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
       fi
     - virtualenv -p /usr/bin/python3 /tmp/venv
     - . /tmp/venv/bin/activate
-- 
2.34.1

