Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC945E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 11:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDDBD800D0;
	Thu,  9 Jan 2025 12:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eqtjXN/h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D75BA801F5; Thu,  9 Jan 2025 12:29:06 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 883FC8005B
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 12:29:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d0ac27b412so879658a12.1
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 03:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736422144; x=1737026944; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SNY26mmCYRUmFH0c7NqnIVLcCfht9vaHlRqvsAqC37Q=;
 b=eqtjXN/hFHRK0rwztM3Po0JPFYrVioeI2tqjmYjZkZZ6gKIPrMzQAxHQbuG+S2UkU/
 OqnM/tI35Hk9z3HiDbWcM58uTblDyZVN52X84njniVwqeRvmvxdi5KhLSGNY1YD4JIhS
 oQoPSreSAGrlDdyUH2yTguIZFIjsIvJlOyGyc5gIXgRKBKKf0qOAzYLDF0Cy+Cezd9Zs
 RRVaoTFxG7dK+XQP+a+QhlTZbQUWw3HQl+J45hkxA8cwHl3k2WIJ4SG4X7PTEC5mcdZm
 uaPP2NhJ+xyzwrE4FelwRwtC4SiiNAD31l0ml4D9MkOOSsjEo7BOfX/bSGYkFGrOpnse
 cHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736422144; x=1737026944;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SNY26mmCYRUmFH0c7NqnIVLcCfht9vaHlRqvsAqC37Q=;
 b=hCsGmNfsCS340hXNjXrx+Qraq05RqSs2mXIQyNPfIFMtBQfzhF6Ho/u7wr6kAlFblZ
 +pdQe+ttwiSHx7h1mDpfqAte/MlCowasfczCrTTOc+0dnY9DuH8vEFru7O6fzIOJogZW
 hpFFe1JlsZXA2kb1XAC3yywjqOx0XAX+aZE0xAOgKKxhp8IROKuZgiXkJXXBYk7of2IZ
 ktdHpXpxq9yFn19ypTW7l9r69a6/3PPwmXxWsFmumFVuGFwga1vms0Spv8kn5UcyJVko
 KV/OQpLEAqSvYEuDRF7Ww5ZqvYaJnDagDR2qZMWZg2yqZ85E+352NbVm2dbSwCDODsN4
 m5/Q==
X-Gm-Message-State: AOJu0Ywdeypg6WMC/sXutjc+dfH0MHXP/tbcMsx0ax8XgJJcBHLniyyW
 rdnQ1/rXfT+MO8y48w7ChhNcX15g6KTTfMmSwz0Evm0X4y5F+fSVkIvfcQ==
X-Gm-Gg: ASbGncs0TVUSgVCz00pj0uM8+TJ0Ss0vPqNEUaAqGCr8byTUlwAMA+eTq6lK8fZVVu2
 15BHnE0SwN4ioEzLRuacAj6JVWikwyPoL4yASp5XfBIq02HdmVrlVStpifjHt/bARDHjYevQavy
 GbB9stY3LfXCkq+d4a2k7aJDAigFfGuEh7dCbwPApYQqgmC1X+65A3y87V1PqvRexn3pzUBV7uv
 TY/oLXos5MrkHwNmsLwMiiw9FfCy2kR+mDgtdyo3924n89Y7A9RrTK6tIXE
X-Google-Smtp-Source: AGHT+IFhqB6Irajuk3La3t0LoGN/MITskpPm6mpUXO18+XHzPRuK7zqxgVieee0LfxA2M7gnjR5kQw==
X-Received: by 2002:a05:6402:27d2:b0:5d1:22d2:8965 with SMTP id
 4fb4d7f45d1cf-5d972e6e417mr6042146a12.30.1736422143438; 
 Thu, 09 Jan 2025 03:29:03 -0800 (PST)
Received: from igor-t14.. ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9900c9f4bsm518546a12.34.2025.01.09.03.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 03:29:02 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] MAINTAINERS: move myself to reviewers for avb/ab
Date: Thu,  9 Jan 2025 12:28:22 +0100
Message-ID: <20250109112854.825204-1-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.43.0
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

As Mattijs Korpershoek is in fact doing overall
maintenance of AVB/AB code, move myself to reviewers.

CC: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ba31f86feb..72a446acf9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -66,8 +66,8 @@ F:	lib/alist.c
 F:	test/lib/alist.c
 
 ANDROID AB
-M:	Igor Opaniuk <igor.opaniuk@gmail.com>
 M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
+R:	Igor Opaniuk <igor.opaniuk@gmail.com>
 R:	Sam Protsenko <semen.protsenko@linaro.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
@@ -77,8 +77,8 @@ F:	include/android_ab.h
 F:	test/py/tests/test_android/test_ab.py
 
 ANDROID AVB
-M:	Igor Opaniuk <igor.opaniuk@gmail.com>
 M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
+R:	Igor Opaniuk <igor.opaniuk@gmail.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
 F:	cmd/avb.c
-- 
2.43.0

