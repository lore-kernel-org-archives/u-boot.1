Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71188C5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 12:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1FD58070C;
	Tue, 10 Jun 2025 14:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GfWPEJMH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8874780C83; Tue, 10 Jun 2025 09:41:33 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 437A5805D7
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:41:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7482377b086so2552253b3a.1
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 00:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749541289; x=1750146089; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4V6OAXYXgSP+NLjWY239LEJ42BKL3etAUuVpmhMncKo=;
 b=GfWPEJMHy2ZmGlhYzEcT4VIJjMABRkwrNW5+bebc+TJM3u7PImxvFr4EQmgD/gYuQn
 EcbnwJkJsS94i3OkYB6fx0nUJl/CjnFp9z2OEv7GEkoAQEPKG/kAkPjG61e73kIXOWKg
 CoH7Vic9VyxNB9Csyqght/v9JprG8FsofmOf2ZztRGErk4X23qgnETZBLrzlIwmfdvef
 q1Cd/MF3sa227kXoiif1qu9wNIIS4T+BxLLLHfZR/N2UA4BEdPftJhjL3ldKV/yW3PHH
 t9U5LCpWtPxTdVigDUb+AZctI86fjfI3pQO+y5qHg+zmRFDnHZ6ZTw/67T0+UT3VtUoW
 6Q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749541289; x=1750146089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4V6OAXYXgSP+NLjWY239LEJ42BKL3etAUuVpmhMncKo=;
 b=L80htKRY+AwED3ZS9RJWsaWcA+tUU6vBVNnklGK2HDkjFfzhkkpBGro4mR+h5IxsDR
 GWct1tEqbtntzoh/lF+ueGirkrnEvYI5VGZfqMJv1pOWI+Ffx98ebIFlnsSIeakqg4Sc
 547DKLRr1wZOL/hsrSXwqCnWRIVwaFallsq5eUGcuosX4kNUWBZxEz6q8Ech+KuyNqLE
 xxphhOU03UUEXKgFEqFyxcf6U0f998aED97VarUiqxza+jmWUpe57NLDPWfgkgYkOc3v
 c4PLz0L/cEqi7HOkMYDHdMROA6tJXFAnbwZZ91s9w+/Ydhx42mOKceo20eP9cQsR9HdA
 UkrA==
X-Gm-Message-State: AOJu0YyVMk6WzGqzfWTXQ5wz3gMzkr/+ZyUu3OoHvxkTmuoQ4qf1Lb0m
 sEYtKfK6MDx3tQIy20DqPNkwcSzLLog1arLfDAJ8bUek0woEskE69ozE64D+s1Ro
X-Gm-Gg: ASbGncsuUwh0/QpLmLDz74MJvoqkRbt+IKzWQZ0C2JPcld9Xdvar8H14TXP6cQqKnqW
 eO7W4nsyrARPgWPyVNpbJPArHblL816S3fA/UcwVIO09fRMJtcjSlPLjDepDCofmciAWdAtmqmt
 TIubIsQIn+Uc2jk9V7aeRTyk2xg3lnonGX2idY+1LZu/7JReTvrZPcdo44Pztvvvwsdr5ULW5wW
 53NlBMl5fRFp8wB576GMp3cm1/aU8vtfnyzDRCPjpd8MhBlORJIlIJ69y3yAWEniaFB1HCYGBi1
 h3Se6yEz93zE1DifwtFYaN+6AM5algzPHAZpJjezYf4UMQzGmZ8HxJWIcWP/sQkOsBAMGsVtnD1
 z43C46pNsLPQGXwHdgHI9UWT0nVhEHT8TI8Q=
X-Google-Smtp-Source: AGHT+IGK+dXDOcPeussjE8F2DeTdn4/WXqxtaXhf0UgHJBbGZgH0XRTQsJbRK0v+iT9e/gDicJ9d7Q==
X-Received: by 2002:a17:90b:4e8d:b0:311:a561:86f3 with SMTP id
 98e67ed59e1d1-313472c046fmr23323717a91.6.1749541289364; 
 Tue, 10 Jun 2025 00:41:29 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603092640sm65201945ad.54.2025.06.10.00.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 00:41:28 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, carlos.lopezr4096@gmail.com,
 aristo.chen@canonical.com, quentin.schulz@cherry.de, ada@thorsis.com,
 paul.henrys_ext@softathome.com, d-gole@ti.com, afd@ti.com,
 d.schultz@phytec.de, nm@ti.com, n-francis@ti.com, alpernebiyasak@gmail.com
Subject: [PATCH v4 0/5] mkimage: validate image references in FIT
 configurations
Date: Tue, 10 Jun 2025 07:41:16 +0000
Message-ID: <20250610074121.8308-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: 20250505100852.9364-1-aristo.chen@canonical.com
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Jun 2025 14:57:04 +0200
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

Hi all,

This series introduces a validation step in mkimage to ensure that all image
names referenced under the /configurations node of a FIT source (ITS) are
actually defined under the /images node.

### Motivation

When using mkimage to build FIT images, it's easy to mistakenly reference
nonexistent image nodes in configurations (e.g., referencing a missing `fdt` or
`firmware` node). Such issues are often not caught until runtime in U-Boot.

This series aims to catch these errors early during FIT image creation by
validating the configuration references in mkimage itself.

### Changes in v4

- The changes in v4 are for fixing errors in CI process
- In the FIT validation loop, updated image name check from:
  ```c
  if (!img_name)
      continue;
  ```
  to:
  ```c
  if (!img_name || !*img_name)
      continue;
  ```
  This ensures that both NULL pointers and empty strings ("") are ignored when validating image
  references in the /configurations node
- Resolves a regression on the `phycore-am62x` platform where `mkimage` reports an error due to
  missing image nodes referenced via the `loadables` property (e.g., "tifsstub-hs"). This patch adds
  the required `tifsstub-hs`, `tifsstub-fs`, and `tifsstub-gp` image nodes in the corresponding binman
  description, inspired by commit 622f826bf025 ("arm: dts: phycore-am62x: Package TIFS Stub").

### Changes in v3

- Series re-sent correctly as a single thread without code changes

### Changes in v2

- Use `fdt_stringlist_count()` and `fdt_stringlist_get()` to handle stringlist properties cleanly
- Validate additional properties (`firmware`, `fpga`, `script`)
- Improve error messages by including the failing configuration and property name
- Refactor error propagation in `fit_handle_file()` as a separate commit
- Update all affected binman test DTS files to include the missing `atf` and `uboot` image nodes
- Add a new Python test case under `test/py/` to ensure mkimage correctly fails when an image is missing

Best regards,
Aristo Chen


Aristo Chen (5):
  tools: mkimage: propagate error codes from fit_handle_file()
  tools: mkimage: validate image references in FIT configurations
  binman: test: Ensure all config references exist in /images node
  test: py: add mkimage test for undefined image references in FIT
    configs
  arm: dts: phycore-am62x: Add missing tifsstub image nodes for FIT
    loadables

 arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 94 +++++++++++++++++++
 test/py/tests/test_fit_mkimage_validate.py    | 58 ++++++++++++
 tools/binman/test/170_fit_fdt.dts             | 14 +++
 .../binman/test/220_fit_subentry_bintool.dts  |  2 +-
 tools/binman/test/223_fit_fdt_oper.dts        | 14 +++
 tools/binman/test/284_fit_fdt_list.dts        | 14 +++
 tools/binman/test/333_fit_fdt_dir.dts         | 14 +++
 tools/binman/test/334_fit_fdt_compat.dts      | 14 +++
 tools/binman/test/335_fit_fdt_phase.dts       | 14 +++
 tools/binman/test/345_fit_fdt_name.dts        | 14 +++
 tools/fit_image.c                             | 42 ++++++++-
 tools/mkimage.c                               |  7 +-
 12 files changed, 297 insertions(+), 4 deletions(-)
 create mode 100644 test/py/tests/test_fit_mkimage_validate.py

-- 
2.43.0

