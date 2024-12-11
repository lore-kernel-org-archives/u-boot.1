Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6249E7717F
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 00:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19D9F801FE;
	Wed, 11 Dec 2024 01:45:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M3ID5dzU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 012AA80209; Wed, 11 Dec 2024 01:45:13 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5C0180079
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 01:45:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-843d7f16827so230438439f.0
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 16:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733877908; x=1734482708; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iwDxdSiZZEJEJeRC/kzvLEj3AqbS6qE7a8XNJXe0LZI=;
 b=M3ID5dzU7RmpO7BXyH7yp18wJ4zcMzkXiRqhMyEQKO7gcm6JuI4jYRGVmnndHtiGvj
 Uu422biK8AJpzugIwQYblpqbd5oxJ2qiXGwFAqcubLzyiMdkUKp5112LHGamzhygX0lR
 tIGC55QeW1zvnjNjytKtZEw4PlSK8KvQ0z3sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733877908; x=1734482708;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iwDxdSiZZEJEJeRC/kzvLEj3AqbS6qE7a8XNJXe0LZI=;
 b=aZnhRCIAXnfV4ZxPGzyazoEawyZIpkfKCARfSqpBbdeaukHMYNGAj5SPtBHvlP1F3i
 0NTBSAH5A+XozNKQ0SWS3kj6CR42mA7+mvaQFQIYVQUE1ucj5Pjpj2JBCIMP9DVRztsm
 Nyje3+9zvwr/m8NRfZNM6mXenLDD3SW2Hrn8ENUwFSGqQngDQQI/0ochgIZWED0+31PR
 ix8vdtsLiCSmaiX15ulJhAR62oIvglbiVyGnA7JefXXCTKrLo2hqBwAOAD3V5D9qmMs6
 0W1xu73LtEeIxwv2/QO0ppA34GgvwlBL+MGcOAtkNNf2Z3Mm/THREuZp0KqgjV2dG+gL
 FZtg==
X-Gm-Message-State: AOJu0YyM8Vvypgwuxok08I9NSHlkIUGfxtD2GUVuPvYiX3EZyRoAg8UK
 wwhfnx9YA8tUXZZLm/3CjA6WqWpalNeqSBzkp5VaK9WLRuEIwmlcd0hJTETbRPKfV7OjuOSWXPw
 =
X-Gm-Gg: ASbGnctLkNacFTeb3gRCWga33jL+QZKU6Bim4tma/pGehiboHYfn+hTuXT8E/hlUEJh
 QdCqSb3iaHt27U03vnszKLeLpY49IRhpTXXSSGlE8sqXgyZmCu81knEtkRiBDd7Q6vYeyPG7w1P
 Djm1P2Q6SjrfZgo9+VUOoAp6vQ4r2Er8UkEzohmN1VFOF0893CnC9x3UMyHyVpk6IM2lzHYYEGe
 rXwuVRvU4wn7BRhbpVckB/t37lgWokQwun1cZvgwOh1Cru9tnPiITmyITckK3yAS7jaYVCaDGw4
 jZSCBI3RuwJDj+s=
X-Google-Smtp-Source: AGHT+IE/9eDvIzQX5Xf/TwM7/yWErbXEkQPdS9tAk9Kl/JefkTUiGzODLH0SdVX0XOxeBT+t1xHQNA==
X-Received: by 2002:a05:6e02:1d8b:b0:3a0:c820:c5f0 with SMTP id
 e9e14a558f8ab-3aa0a66cb85mr9483565ab.24.1733877908447; 
 Tue, 10 Dec 2024 16:45:08 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a9ced6dfafsm17251305ab.54.2024.12.10.16.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 16:45:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Raymond Mao <raymond.mao@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/3] efi: Minor tweaks to the EFI app
Date: Tue, 10 Dec 2024 17:45:00 -0700
Message-Id: <20241211004503.3775922-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

This little series adjusts a few things related to the app:

- Support OF_SEPARATE with 32-bit app
- Use OF_SEPARATE now that it is actually functional
- Fix a bad symbol name for the dtb

With these the apps both seem to function OK, and OF_EMBED is not needed
anymore.


Simon Glass (3):
  efi: Correct logic for OF_EMBED and OF_SEPARATE co-existing
  efi: Support an embedded DTB for the 32-bit app
  efi: Switch over to OF_SEPARATE for the app

 Makefile                        | 4 ++--
 arch/x86/lib/elf_ia32_efi.lds   | 5 +++++
 configs/efi-x86_app32_defconfig | 1 -
 configs/efi-x86_app64_defconfig | 1 -
 include/asm-generic/sections.h  | 2 +-
 lib/fdtdec.c                    | 2 +-
 6 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.34.1

