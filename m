Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1556C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 10:55:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 629CF82B17;
	Wed, 30 Apr 2025 12:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ItwrLDKt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 733A782B19; Wed, 30 Apr 2025 12:55:56 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C8B58283E
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 12:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7F9933FE57
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 10:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746010553;
 bh=fj9EOtnyQzcbue3MjJZHe/RMqsmf1OhsBIgASVQ03NQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ItwrLDKt3dDooGMH2Ai8FEz1OacIdaet1iw4VpLsYdAq/VxlKO6vZiifRAXeCtpnr
 bKWWVIUxagsSYpooT78ZKttjUrgpJpVYkqk9c+jXb+m20Vaz2/D2hSinqmm/Q2bosB
 Hl5kb90oKrPcZW96snbtaMbamw2t8bnXgCptAwVETFUORK3Qfzderf+9GdNjU/rB4Q
 f0BO0d2AhAg6+G9DoQLHyy7D5wJT3L2O/ovkiHY9m/hmusauAJH5SBDJejQV3UxAeh
 tk5pBnnZ/harJ4TlMlu4+a3K0YIjP5CIj2wSfKvDWV/YVc4/FQOuBrGC8BI9MAgr/6
 QXltJIBCsCqdw==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3913aea90b4so2093118f8f.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 03:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746010553; x=1746615353;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fj9EOtnyQzcbue3MjJZHe/RMqsmf1OhsBIgASVQ03NQ=;
 b=OYdzOCfllk7wSh+c0BaqQzR2oTj35UuejBMf9IeVCffgp9SuAmp7Ls5PdD2oXATpRe
 nVwud8dhHSvN6rgK4zKH+g1k3/xU9TUtHrqFyMtGrywHuDxHf5DzJhcnaYNNg8P1gnRB
 HcruGkZXTQiCaTNoCgL37vfxmPOF0Au4lJLNDFIkFdoc292k/k0i8gxzMkGD/RCbI+fR
 ZgUgJLqEGpKxq6Kl+LEOIdciuqy0mjExuOUh2Pxv3ydL3wXDG5FBg5gYob4AONQGJulx
 VWtHvbPkLUPPpgs/msmoJFmojMrBPpd15hbvbeBPP/vioCRGj5logDidx2d1Umu/u2mJ
 UWRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXttUiouWeEuJmxWWFoC3k7sPDjqUCHKr4RzrVTYpmJDwxKekoeNLYnZOcXWxpMkf8wJeeNAG4=@lists.denx.de
X-Gm-Message-State: AOJu0YxxUBREiAIc3T+A8EAfKtrOo5sSO+Kl20hbxQ5WUj85Klih//CJ
 9bkbs6+yhYweVSA9wFuipJZSSgv8Y/zQzRcy4MVxbt1LH5Q5ciuTqihGdjViAaG64DtVUjQLbRM
 AEAYTCsfwxMpdwPtygTrNj+VWkNnnLDsRRbsFmt98E+x1TJ9p87hrHjQDYrSY0iFAIBg=
X-Gm-Gg: ASbGnctn0pok/AU5OhCZRH4IsOrjMF9aVy4ftdVoPflVn5MdneRbeI++WrtNwl4PWJf
 42XyTHICxYAa8pUUx/3UjDvoNQsmmKe0ktEm16e9DG7uN3Bql2GczRU/tkumwKA/Fk9nYDlnXYU
 ipTjjcDBNK0qhoENOYEqnGqn9LhgXPTUBDq6ZAZJgo203R/KRSaAnU+uSxjUCIJKV5kw+bVArP3
 Yz4O6IGB1CTTTvCQyuJm51czPao70UgD8RRyUCLhwlj9Mdtoah5Vxtl9WtzhR4lm1H4nG4OeIdY
 Jz/X4Z4N29yvxl0cH6RylYjn/+vcQzy2uNXO+AaEypUnzA==
X-Received: by 2002:a05:6000:402b:b0:399:71d4:b8 with SMTP id
 ffacd0b85a97d-3a08f76626dmr2215997f8f.23.1746010553089; 
 Wed, 30 Apr 2025 03:55:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+x1UIvy1LNEcAtHGn4s1LKVoaw547pwOm5VAvhDKy2jIpKqmzLr8O/GG4jISofWQZjRPWvA==
X-Received: by 2002:a05:6000:402b:b0:399:71d4:b8 with SMTP id
 ffacd0b85a97d-3a08f76626dmr2215974f8f.23.1746010552725; 
 Wed, 30 Apr 2025 03:55:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:3035:6e0:9d1c:a02f:5865:bfa0:f5d4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8c968sm16422139f8f.8.2025.04.30.03.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 03:55:52 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?=E7=89=9B=20=E5=BF=97=E5=AE=8F?= <Zone.Niuzh@hotmail.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] bootm: pass kernel load address not entry point for
 IH_OS_EFI
Date: Wed, 30 Apr 2025 12:55:46 +0200
Message-ID: <20250430105546.327442-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

The EFI sub-system needs the load address and not the entry point
to boot the binary passed from the bootm command. The entry point
is derived from the PE-COFF header of the binary.

Fixes: ecc7fdaa9ef1 ("bootm: Add a bootm command for type IH_OS_EFI")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 boot/bootm_os.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index dc9d3e61fca..a3c7cb5332e 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -498,11 +498,11 @@ static int do_bootm_efi(int flag, struct bootm_info *bmi)
 	/* We expect to return */
 	images->os.type = IH_TYPE_STANDALONE;
 
-	image_buf = map_sysmem(images->ep, images->os.image_len);
+	image_buf = map_sysmem(images->os.image_start, images->os.image_len);
 
 	/* Run EFI image */
 	printf("## Transferring control to EFI (at address %08lx) ...\n",
-	       images->ep);
+	       images->os.image_start);
 	bootstage_mark(BOOTSTAGE_ID_RUN_OS);
 
 	ret = efi_binary_run(image_buf, images->os.image_len,
-- 
2.48.1

