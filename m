Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B4AC2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 12:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E15182ED0;
	Wed, 21 May 2025 14:36:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nUZfxGDw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 525B182D33; Wed, 21 May 2025 08:28:30 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1436782BD6
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 08:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-74267c68c11so5584892b3a.0
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 23:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747808906; x=1748413706; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tPU4xzwky9MRfWmVogC9je/kjNyDJV2zEmByO0wvh1Y=;
 b=nUZfxGDwAhNfZnaSOQCh4OT4I8kBGM8TjqYdv/HFNOCm08z2P2VC9oS3dSPwJQ/e8u
 hqcGZs6h14Zix4qxkXPI4d15DPjh5ZVMPX4eQniCDYfmiVwn+SljHEKEAUTCe9xDMRdI
 vpMM0OWh1KrxFCIUqyOx725G/aN+WJ6R7wi+UZ8KYmbBl+qxz2O5h2baVdbz7e6eZlFV
 TqdEGbFG2i3TUPIGHwR1w6MD+hjHtawABp2g08gQEdyMmP/LsYzR4q84E2jJQTSGkS6p
 aKjrXBLv5/G4d/LgCfOQT2+DgA4kQMA1QmsyOMMjXoCra8kZwviaRHqx/YeWsOiSRRu/
 1mjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747808906; x=1748413706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tPU4xzwky9MRfWmVogC9je/kjNyDJV2zEmByO0wvh1Y=;
 b=QfJSbXiKTWa7qibeAEe4VXpLI66m+xqsfQfVnl/yngjPtn2gde5Z5IgGZRLbkFEXnu
 O86ks0S1XKGYaUnsXmrTa0SExCfkBUt/PbNL7pB3ZG9ZcCwdsbIezGyiKZXe+vl12YQJ
 fA0yPUD/ffLErvn8+7KNyxERufZ/lcLdN4saR4A9l8+grCBvobNVCzmKa99DOtN3j0u/
 y2FtGZw83bD3InwV4mK8qtGPouCnvjz6SirXl8HVx0CVSIqiQ0xRocZGjVKcOS6gdKPy
 FolW1Ixw/9OukeTxiOBSmtQSt2jt5Q1E/7vVWkdsq4aGjYnn78PU18/0ZcWOypdnghNq
 s9Lw==
X-Gm-Message-State: AOJu0Yxm6ztvNcQpxrQ3hM0G/OeVypkvk6z79rOrRlqWe3dKNedyCBvY
 dd5XInLD/kEqVTqAbLUzYqWSFhErWZe1/m2rXUVH2CkkrsZkpvlsRKIJ14SANxet
X-Gm-Gg: ASbGncueKaVAxFE8X8yMw8yURJiAi6dxpd5pn3KhHaQSuksaTpUssp3DwBVvi9v9KWl
 Ayym5kyBmVgM7UIOCSLqUSkiR19U7j7j6m2q2TRPLk0igmvolx0uEhgK7RkGb8aAYaZS6aM8LPN
 7FOvI63yYTVON8eYxLwA7rzYfQGxwajNpjJQpTheqZ172FOTGSw9tzEeuIA3WCv3oAhv3whyJA2
 ZnDCl24HC1c6OXBf84KtVXab8tifwqVZgtK4X5xagbre3NDsCBM9Mrft/I2MEJcmQX/d574nbTt
 aG+HOD7mAqY0MickZ74UNX3SNHJfFdD2FG8PEJQpBvVuYyxqOaticZdaEoqV+1FFlohfgSkBZXQ
 2h+12eQRnncKByzgvX5CHOOMlHwcM7i4kjzBMhB4=
X-Google-Smtp-Source: AGHT+IFMbn+8dDhCJLfhjOy6LGHEO7BJvzm/bC+NV3nblIy2fa0XuVVsiXe5iaZXFv89W01xdwWATg==
X-Received: by 2002:a05:6a00:4c87:b0:730:9502:d564 with SMTP id
 d2e1a72fcca58-742acce2c1cmr26368828b3a.14.1747808906195; 
 Tue, 20 May 2025 23:28:26 -0700 (PDT)
Received: from noble-leuven.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a982b884sm9277911b3a.95.2025.05.20.23.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 23:28:25 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, carlos.lopezr4096@gmail.com,
 aristo.chen@canonical.com, quentin.schulz@cherry.de, ada@thorsis.com
Subject: [PATCH v3 0/4] mkimage: validate image references in FIT
 configurations
Date: Wed, 21 May 2025 06:27:41 +0000
Message-ID: <20250521062745.3458-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: 20250505100852.9364-1-aristo.chen@canonical.com
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 May 2025 14:36:46 +0200
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

I would like to apologize for the confusion caused by my v2 submission. Due
to an issue in how I sent the patches, the series did not appear correctly
grouped on Patchwork, making it harder to follow and review.

This series introduces a validation step in mkimage to ensure that all image
names referenced under the /configurations node of a FIT source (ITS) are
actually defined under the /images node.

### Motivation

When using mkimage to build FIT images, it's easy to mistakenly reference
nonexistent image nodes in configurations (e.g., referencing a missing `fdt` or
`firmware` node). Such issues are often not caught until runtime in U-Boot.

This series aims to catch these errors early during FIT image creation by
validating the configuration references in mkimage itself.

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

Aristo Chen (4):
  tools: mkimage: propagate error codes from fit_handle_file()
  tools: mkimage: validate image references in FIT configurations
  binman: test: Ensure all config references exist in /images node
  test: py: add mkimage test for undefined image references in FIT
    configs

 test/py/tests/test_fit_mkimage_validate.py    | 58 +++++++++++++++++++
 tools/binman/test/170_fit_fdt.dts             | 14 +++++
 .../binman/test/220_fit_subentry_bintool.dts  |  2 +-
 tools/binman/test/223_fit_fdt_oper.dts        | 14 +++++
 tools/binman/test/284_fit_fdt_list.dts        | 14 +++++
 tools/binman/test/333_fit_fdt_dir.dts         | 14 +++++
 tools/binman/test/334_fit_fdt_compat.dts      | 14 +++++
 tools/binman/test/335_fit_fdt_phase.dts       | 14 +++++
 tools/binman/test/345_fit_fdt_name.dts        | 14 +++++
 tools/fit_image.c                             | 42 +++++++++++++-
 tools/mkimage.c                               |  7 ++-
 11 files changed, 203 insertions(+), 4 deletions(-)
 create mode 100644 test/py/tests/test_fit_mkimage_validate.py

-- 
2.43.0

