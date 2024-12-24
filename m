Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9B7E77188
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 16:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45A3480352;
	Tue, 24 Dec 2024 17:01:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bOlA3pzg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BBF780435; Tue, 24 Dec 2024 17:01:33 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0023801F5
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 17:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6d8fd060e27so37807936d6.1
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 08:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735056089; x=1735660889; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2yWbh1zWnh9x242OqYtnLdY02gWlC1YgLKwnLWJ2ygY=;
 b=bOlA3pzgsEyaOdzgIOy/bhjVFlbpYS4ZhRQmbePNToG1jpfg9/9IZqADWFRFXvvkZG
 m/PpE31PWhhGWTaiajRJQtvwNrYzjLuDnhEerz585QLac6ChAb0h+MTTEyB0oukwM0sk
 O8C7QkNf1HQvIBzY1zokgdpF2K/FxtIlFiAcndECSegpoItRSwkKRcvGCZ9PWu0tszJt
 VXkq5pUfoSKtiRiWj7PnW/i3w2U/XAcaOSJsPqJRmHqhwD+LVOgyHCh/fv2i/Of8gSEr
 M8+TdhFTm5oaYdS5bw3aeUUgD9g5WcCGKLeiSYT3qw303een+cpJKEDji11wk5TSzYJ+
 IIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735056089; x=1735660889;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2yWbh1zWnh9x242OqYtnLdY02gWlC1YgLKwnLWJ2ygY=;
 b=LNbb23mmlZrZlyx2+3EcYoyPpqmXi1juIn1oLrwVxvdFPqRH85TOacxHv6gciLHZSF
 uVS/P7n6tcTZCG3JMBTLc+igWB7BlQyowNFl1rgGeEOUZ177xvqwqs+EOdvJRFkrI8AU
 /3aXhYw2eo6styS38kXrfqscmXtoWiIY29LYaOCzaJcuNOrB6SXm45uDFrUKH+OUGu2E
 acmcCgUwgB+/u0CQoHauxOapBupubB4vrmWM+Qgb8s3za31hc8k39DUvVfqRoOkSRYs9
 5NioUl9jx0yFa4FcUU5/wIAa3QAng+P5kK+VO539Gzz85UkN4bJ3SNj6L7vyJLYwNVcE
 HApQ==
X-Gm-Message-State: AOJu0Yx+mg+ZoukrJyhta/EFBguUojF1eec08xLF60aMYEXvGH8wmxBW
 lzQycjASj4YwSiLzQu+Caz4WHNW9CANqZ9lhGWQ2dMWCNt05XBxVRtQJM0EJJqEYj5EHkmB4SaX
 +
X-Gm-Gg: ASbGncsQbmMaSvPRwlXaQusJZp6hHJdiF8lQaJ2w0VBrINUA2M/JeQwClntb2oxA3oS
 a7Vn4IPIrNdCzmDnlv6vMNgfqSdM6CuS65wkdWNZOAvazcctQ4OYZC8K5U/uZYNnwz8t17ovAex
 G7jwlrK4/9MBCK9Dslipp5UXfD8Ceh63ZHaKRSmnR5NFk7/EN484OHQ8jbygkwN7aEqMLoXCEOq
 7PVq+UOXeo+smnYpMuCJHMxkETY4rErw9pjJRiaCm1ykc3jZ0oq7no/BZSSgGl6pBmghVsWOyCk
 JQMrVb1K+0SWrHKCFQW4GEuVULessj6esNxSTIz6lR5sQjnJwumtZeE=
X-Google-Smtp-Source: AGHT+IEYEfl35We/5i0ZJ1gDfksqyFxC4pEVcuZ6u4UVGVISfLXLImnVrGvs/qcWQPEPtHDaA2FE+g==
X-Received: by 2002:a05:6214:234f:b0:6d8:f611:3af0 with SMTP id
 6a1803df08f44-6dd233af13fmr249539686d6.48.1735056087838; 
 Tue, 24 Dec 2024 08:01:27 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d432asm53840816d6.110.2024.12.24.08.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 08:01:26 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 00/11] Tpm exit with error when algorithm dismatches
Date: Tue, 24 Dec 2024 08:01:02 -0800
Message-Id: <20241224160118.675977-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

This patch series add the logic to report errors when:
1. An eventlog is handed over from the previous boot stage but TPM device
   was configurated with an algorithm that does not exist in the eventlog.
2. TPM device was configurated with an algorithm that is not supported by
   U-Boot.
3. Failures observed when parsing the eventlog.

In all above cases, tpm_tcg2 should exit with error and prompt logs.

Moveover, this series include miscellaneous fixes and refactoring to
simplify the logics in tpm and tpm_tcg2.

Ilias Apalodimas (8):
  efi_loader: Don't warn if the TCG2 FinalEvents table is not installed
  tpm: Rename tpm2_is_active_pcr()
  tpm: Rename tpm2_allow_extend()
  tpm: Don't create an EventLog if algorithms are misconfigured
  tpm: Keep the active PCRs in the chip private data
  tpm: Simplify tcg2_create_digest()
  tpm: Simplify tcg2_log_init()
  tpm: Don't replay an EventLog if tcg2_log_parse() fails

Raymond Mao (3):
  tpm: refactor tcg2_get_pcr_info()
  tpm: add flag in hash_algo_list and API to check if algorithm is
    supported
  tpm: add kconfig control in tcg2_create_digest()

 include/tpm-common.h      |  18 +++-
 include/tpm-v2.h          |  65 ++++++++-----
 include/tpm_tcg2.h        |  12 +--
 lib/efi_loader/efi_tcg2.c |   2 +-
 lib/tpm-v2.c              |  72 +++++++++++++--
 lib/tpm_tcg2.c            | 190 ++++++++++++++++++++------------------
 6 files changed, 230 insertions(+), 129 deletions(-)

-- 
2.25.1

