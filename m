Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072EDC7EE3A
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 09:38:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26F9D82F5D;
	Fri, 27 Jun 2025 11:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F0BsiRko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8CDB82F46; Fri, 27 Jun 2025 11:37:40 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5642F82EA5
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 11:37:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-450ce3a2dd5so14676025e9.3
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 02:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751017048; x=1751621848; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8iP/eIKzuzJOPuVAGr2D28+bHqdvLKyCVUdj5OafDvg=;
 b=F0BsiRkoyBXXhxb+d9olTX8mWtBoIstnN0JGJQy4Q7nC98g9lPG0RRsIhvxAxThJrz
 BK9lqsYfg0YmYv5KLNsMikbM+Al9gIBM7AiKrvPUdBmUpDDF5logw42OTXeMAa6j5sWn
 sB7lRQ6x7QgtdVtys+0NiR3YU+vsM44qlT2aiuxXuLWSa2xdgRX0CcIyJ341nRr/yBOs
 hGbPt8rAlEqr5GLvqIic5vMMdzFBMjDDEX96wio73XKXtNsV4xKT/UKIBwMZAtAL1g5E
 I0g3MstuFsyJ5c3whhOM/TUs44ov5L2TiR3AYIym1rDHAse8uu3eBI1YtLomy+GCmgcj
 h8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751017048; x=1751621848;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8iP/eIKzuzJOPuVAGr2D28+bHqdvLKyCVUdj5OafDvg=;
 b=j3ZOaAamPoQsejPZJYIeceZwlcsXfzm4cCT0vH6S/cbsSZJWLtKEQ636qsT3x8bW53
 movibOBjd9FUfykib0RyBIBXHj0p0n2W9ETUac1nxvD+UiIKd/v++N92HAZ5UdiOlNhl
 s6GuKjhzSb2Me0xIbw9tnBl0p8aSlAq2/bwsSfVXMm5v8/5TKx5t7RK9K1qe3oOaJSuO
 Ob3sUL2oSun9MdBMObP9d4OzQSZKaweFFB0sdhnleXIr0JUpuR+3TyrtbV7ULBr98KaX
 +FfuW/MPu7mjv8k2Y8GnVzSUu/SkofqmBSEJ1FEcEZ8qcDc3ApxqcmfqlSEvauR8hSq+
 PATA==
X-Gm-Message-State: AOJu0Yw0uuOsOf1+qmgTtlwkg8btxIrDjSqrvH4vBRgxCioUOE230g9z
 /CvgUYfZZWeSC8jUmK7MGot7/65WnNqrMr/zCK8+nwDG36FepApa5zfXClzKz9XJZtCB8zppWup
 Ks34UWRDTeQ==
X-Gm-Gg: ASbGncsFM9o64sXa0biAc1oR4tEQH2DFD1353qV0QctsD7FZuK8Q7eYfnkvwfliCRlC
 pcb6p7vF18jYNr1XND/+sLZv6G6eee0YdFY8AMCSxxvmAwWTz1ZsIeYgIXXKEvLmyR6GgdS9miX
 BzD6QrxoXf+e+Y8c9GnFojTMM+0LB2YplGV87WKxWeLnpKGBPNixGMhGu/CPpIpwaEg+ywMIXNw
 RC+mHxSwBKUqDOX8+NoLUtXfj0NAvYbrz8stBTzbFT0GOGI4MCGCbLhVq/ZfzO35VMNo2+arQoo
 ygrqv1pTba0qzj3K6vIgJEG7fGuA3Xn3G6gqkknpiss/64ueafHOyC+bArUR7xoJaPfeV2jRoIe
 ehPF1KMZ/A1qlfg==
X-Google-Smtp-Source: AGHT+IEsL6Obtkep/9mc1c6Ml/02jyP2HtbrQ4gIakFchf9CQoY/ByzAa/I5wEnx055VQEc7jGghvg==
X-Received: by 2002:a05:600c:8112:b0:442:ccfa:1461 with SMTP id
 5b1f17b1804b1-4538ee5d268mr26984995e9.13.1751017047642; 
 Fri, 27 Jun 2025 02:37:27 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:c61f:677:c14a:b7e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e9d1csm2234958f8f.13.2025.06.27.02.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 02:37:27 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v2 0/2] tpm: Attempt to return value not in enum
Date: Fri, 27 Jun 2025 10:37:25 +0100
Message-Id: <20250625-tpm_enum-v2-0-ea3f84f6b639@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFVmXmgC/22NSw6CMBCGr0JmbU1bBcWV9zDETGGASaQlUyQaw
 t0trF1+/3OBSMIU4ZYtIDRz5OAT2EMGdY++I8VNYrDa5rqwuZrG4Un+PShdXolKzMkVDlLcYST
 lBH3db4UB40SyGaNQy5/941El7jlOQb775Ww29c/6bJRRlxMabFvtmnN9f7FHCccgHVTruv4AM
 Fae8roAAAA=
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

The function tpm2_name_to_algorithm attempts to return -EINVAL
for an error but that is not included in the enum tpm2_algorithms
which is defined as the return type for this function.
Add -EINVAL as TPM2_ALG_INVAL to the enum so that it can be
returned as desired. Update the code to use this enum value.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v2:
- Add patch to make use of new enum value TPM2_ALG_INVAL
- Link to v1: https://lore.kernel.org/r/20250625-tpm_enum-v1-1-73a1aff0bd4c@linaro.org

---
Andrew Goodbody (2):
      cmd: tpm: Fix attempt to return value not in enum
      tpm: Make use of TPM2_ALG_INVAL from enum

 cmd/tpm-v1.c                 | 1 +
 cmd/tpm-v2.c                 | 6 +++---
 cmd/tpm_test.c               | 1 +
 drivers/tpm/sandbox_common.c | 1 +
 include/tpm-v2.h             | 1 +
 lib/tpm-v2.c                 | 2 +-
 6 files changed, 8 insertions(+), 4 deletions(-)
---
base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
change-id: 20250625-tpm_enum-098ee9a5eb6b

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

