Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E946C3064D
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 12:53:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8071F88481;
	Mon, 24 Jun 2024 14:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sBZHNW2C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26B1087FFB; Mon, 24 Jun 2024 11:29:41 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0B108752A
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 11:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-354b722fe81so2675391f8f.3
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 02:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719221378; x=1719826178; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f/5jDULfPeKj+IdDgbZSR3O11+712DcHA7Hnqt/o6xo=;
 b=sBZHNW2CxPGDwrNC5Vri+L3HRlXd1ZBV6A4TjdWiPtLYzlFQZo77QGhcSh4aD21gZc
 Vo3PQEPccBnyJtDUOix+Ymq6GhEO3pOG9kAgYyNtteWKXBj2hzE0YQu+gJI2KsO1JJ3K
 bNhOTaOJPVG3JIe7ISD0uAoYczqBXxWMvcQifrZCxOKP25dyxK/PR5gNaKokS/3iCuka
 h7v+h3L3MSIQSCH6Xx3Ijd7+OoU16IP2cGwQAgv4a9hQFLUcn3myyG8BV+/6vwyXnsGO
 mxae3N4HAs8sPAuqrhkObTzEF2gE/eEkKXoiP8CAHW1gOV/N+M0OXDV79LpWT2HrcyPb
 NvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719221378; x=1719826178;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f/5jDULfPeKj+IdDgbZSR3O11+712DcHA7Hnqt/o6xo=;
 b=sspSFH/QiohHJengt7AQ7ncNtverUvX2QfrcKPK7hUJuzsdgTQV51VgexFlLHzzxhw
 4N89zhs1skzQPC9/o6EG4YvPA6IBlEv965YE2SneYvb3DP8OSK8NmbOCaIFoDenl6UHa
 GPzFpAkO8bZo39uPmROFvlgIZ33ac/eLihojC3vZaA6evUaOgOIwWVvLRyenfXbyt0HT
 1J2A1haMiYBp0Kopr9nYAb+e9MfqNzP1th0H3I4HBIEcKyvY/lMsfv0XgZvBUqckwp3u
 XUI8t0AjQmaf89xD97UeRVAdLj9230mju04VI+PdFk/xD8o8WquLcoRJNfTFvR4ZvQhp
 lH5A==
X-Gm-Message-State: AOJu0YywB/r1KBKQuny+HV1RomLsl1AtILLZiE7BeSjzEAxs0fPTB+77
 1AJN8NeREQM91J0L9BwRP7iWg4KDBGZ/kC1yxnw8nup55Z0xNmsrnNbJxjFiQ/1W9oFTA9O7kXq
 5UEU=
X-Google-Smtp-Source: AGHT+IH7ITVld1NUsT8TWUEYFFhIXbBtxmqBzdkkWJ3yT+INeUCFzmTtSXXOhzpeQKrtEIx8G7Etyg==
X-Received: by 2002:adf:ebcb:0:b0:360:9a3f:aa7d with SMTP id
 ffacd0b85a97d-366e4ecc6a5mr3335071f8f.1.1719221377921; 
 Mon, 24 Jun 2024 02:29:37 -0700 (PDT)
Received: from artemis2.broadband ([2a0a:ef40:ea8:cd01:8d98:dfde:453c:c55f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a8c8f50sm9449972f8f.109.2024.06.24.02.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 02:29:37 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] sandbox: Fix LTO to work with STACKPROTECTOR
Date: Mon, 24 Jun 2024 10:29:00 +0100
Message-Id: <20240624092900.2108175-1-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Jun 2024 14:52:21 +0200
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

 scripts/gen_ll_addressable_symbols.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/gen_ll_addressable_symbols.sh b/scripts/gen_ll_addressable_symbols.sh
index d0864804aa..ebf89b04bf 100755
--- a/scripts/gen_ll_addressable_symbols.sh
+++ b/scripts/gen_ll_addressable_symbols.sh
@@ -13,3 +13,5 @@ set -e
 echo '#include <common.h>'
 $@ 2>/dev/null | grep -oe '_u_boot_list_2_[a-zA-Z0-9_]*_2_[a-zA-Z0-9_]*' | \
 	sort -u | sed -e 's/^\(.*\)/extern char \1[];\n__ADDRESSABLE(\1);/'
+$@ 2>/dev/null | grep -oe '__stack_chk_.*' | \
+	sort -u | sed -e 's/^\(.*\)/extern char \1[];\n__ADDRESSABLE(\1);/'
-- 
2.39.2

