Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5F3C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 17:00:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96F2A883AC;
	Tue,  2 Jul 2024 19:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pSE046xr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22B8D883AC; Tue,  2 Jul 2024 19:00:33 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBF25883A9
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 19:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-36703b0f914so2839545f8f.0
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 10:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719939630; x=1720544430; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=djvdJnmDOeXWIocbLWvF02El5tJr8Fngi76wloKtEd8=;
 b=pSE046xrzCyCmB4MEJl2Pk/vH1n79Obg+upznd3+5r7snOKi/8pVnq8JCrY3A5X/Gw
 ULmcnONHSpAUFxTTzjDrZ2qfYBqnMtYCX1OjHicZ8QLwbxGQXEl/vErTh+CvbLWUMMym
 G3OsVglxBHG81ifnAmJGRfQ9KIO2gRYxxvyV3y/x/RkhHgc/37MtcQScssa2BU36+MjR
 RtoGEUcGrEDfGbwNn+mFiJLCTB5PjgaHjT0kPentt2QFQLaGDmkoiHuJo/vj52/kVa8M
 +qo4FT91pR+DJVMqqNc3pYXigWYJEdSQOW7dr6xSinQGfDxCDPaqyDFmezs6QTTALOCx
 nDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719939630; x=1720544430;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=djvdJnmDOeXWIocbLWvF02El5tJr8Fngi76wloKtEd8=;
 b=UtWmJZdw7ZpNuJvlV1ygDnKaVt0cMUqPIEm+ccsr2b/vvtdLnR+CRYn4MIo/gW4iyl
 kGJzubMsNlqMd9Ybh0wcGJF45KWfecB69DjHR5VU1YBiKm2YgWoPB59N1Alps0yO54ww
 BHj58AKq3FXfIzetUiZhkcre9ut3qBjGHuu2bA2LMi/7ZGa1nGI+ZvRl0x+JGs8/zU0E
 6dtm+J2ap+TD1VAdq2hCIA9RYYnUURD0oUtgEJBm2A0SrnK8NsiIeBAkrGuXahhjEnU4
 2phBMc2Vim47qR+S9rfgRNKv9qK9rmijYMAXVvov8D/3sltIMlTSYpxbcT8r+rC1qg94
 i6nw==
X-Gm-Message-State: AOJu0Yz8euftvlPD4onx4nNv9WE0IPoiO3WEZelaKBOHoPzcaHEn5Clw
 6PHggF0+ju72DasbVNXFG7KLuk0ng5mZzQQByRYTWTyvrJL4Vk5TzNyN7zsspvLQ99gTauvNlVz
 +Gm0=
X-Google-Smtp-Source: AGHT+IGS/C4zZ14GQK9Rm5mPTVuA7H9gLmKqQBzGQklXRJq6mPF6LUtTfO2OY+TlsKCrkyjKedP94Q==
X-Received: by 2002:a05:6000:1f8e:b0:366:e09c:56be with SMTP id
 ffacd0b85a97d-36760a63050mr13190060f8f.6.1719939629879; 
 Tue, 02 Jul 2024 10:00:29 -0700 (PDT)
Received: from artemis2.broadband ([2a0a:ef40:ea8:cd01:9aec:1017:ab08:a7e5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36784e3e0f5sm2532832f8f.11.2024.07.02.10.00.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 10:00:29 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] sandbox: Fix LTO to work with STACKPROTECTOR
Date: Tue,  2 Jul 2024 18:00:09 +0100
Message-Id: <20240702170009.484961-1-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.2
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

Add the STACKPROTECTOR symbols to the script that generates the
symbols that should not be removed by the use of LTO when linking
a shared object. This prevents a fail to build due to link errors.

https://source.denx.de/u-boot/u-boot/-/issues/35

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---

Changes in v2:
- Made the new match more specific and added it to the grep run rather
  than run grep twice

 scripts/gen_ll_addressable_symbols.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/gen_ll_addressable_symbols.sh b/scripts/gen_ll_addressable_symbols.sh
index 13f670ae0e..fc5ee0e9c0 100755
--- a/scripts/gen_ll_addressable_symbols.sh
+++ b/scripts/gen_ll_addressable_symbols.sh
@@ -11,5 +11,6 @@
 set -e
 
 echo '#include <linux/compiler.h>'
-$@ 2>/dev/null | grep -oe '_u_boot_list_2_[a-zA-Z0-9_]*_2_[a-zA-Z0-9_]*' | \
-	sort -u | sed -e 's/^\(.*\)/extern char \1[];\n__ADDRESSABLE(\1);/'
+$@ 2>/dev/null | grep -oe '_u_boot_list_2_[a-zA-Z0-9_]*_2_[a-zA-Z0-9_]*' \
+	-e '__stack_chk_guard' | sort -u | \
+	sed -e 's/^\(.*\)/extern char \1[];\n__ADDRESSABLE(\1);/'
-- 
2.39.2

