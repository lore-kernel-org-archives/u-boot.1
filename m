Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B91C83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 10:01:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 653D682CFA;
	Wed,  2 Jul 2025 12:01:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FS6QdgOR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D02EA82F00; Wed,  2 Jul 2025 12:01:39 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F9CD800D7
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 12:01:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a6e8b1fa37so3657790f8f.2
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 03:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751450497; x=1752055297; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ExDJP5cKyLckfl7EtbQIEoQoulq/o2yQFt0mrGVGfK4=;
 b=FS6QdgOR2/a2tpJ5DzTUK15OlUtREjKfRBrUO/vDdzjxyGh+cNW5XdajlazGvV+mBO
 KBZzUhnpuL4uT/sr4NOG+q/zjnYVbJZ2nfDcuMTTiPCT2i3K2pPkR0ZnLS/tK885K0yV
 05buaR+nI9/ICcFCuyaQW8Xw4RfW9W1okq26y2tpYb5PJdWMtImCOOTYeq2Ck3BN0WC9
 kw4PljI6alTuD0aEMtMYuZGSYYZmU/gATTl6ysbTE8sJJqRNrlO00aaGnz+R5JtPmn5A
 yycUf8Uqp+bMw2u9otBKi7vMppqB1aNkUOq4z+sp9dR2y5hCWbQxqconPL+DxFbef8ct
 iFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751450497; x=1752055297;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ExDJP5cKyLckfl7EtbQIEoQoulq/o2yQFt0mrGVGfK4=;
 b=HpSiEDfXGXuifoI1iM1SvEr4ijHnz+mJFlYa4XBfgnRd9EBM13rdZBMIsldyOwR/VJ
 u+ExmCJkPvBoEc2Oss77IhJ81I8txFM8f1R0goVBWi/zNSAH2IBWroToiKBVOeKr81LU
 1RD/2nvekElwJ6pYO7OwalMLX/B8e1dd3QpyoK/c2ml8z2iiblHGf3twPMjISNH5aYdD
 dpYlYsTC7OJz3yl0kfk6u570XaFEPPEQnN+OJGkDuz4hYZcv0ZXz/faEvsfuNloqtacc
 zBAkdovBS7x1PTMmUQ1S8+KV7388IUaNhvLpR4MHX8BVSVKQKyP5uhr3pOpZnvUW827t
 Sm/w==
X-Gm-Message-State: AOJu0Yy7JrLWHmwWcjzeWk26sPZIn13FmaenRWQwZPpQbJISLiNkPWsm
 un7twVNhpcCnjSNFzif/2wycz/l+wchtn4a5BDcTFwr/PEdnOD/2qSsx5hy+qLrq/JQ=
X-Gm-Gg: ASbGnctkr/4yMuHZk1rcWzk6f1L7KNV2UmwpwpztGWSCQenkq+NYMxf1He5fvZixyhU
 tuHgngKlHR6NaOSQh3bePxoo1/6TVWE1rydO4JjUN5MkQs13OCZN54K3jyAGayuI8HiKOYjsES6
 iNXfknLb/Z0+fXUbfizOhFIp5DxkGFuFgUyOMT6Fs9NISwZb027UlHTcASUbqHjknRPwVE87sd+
 WCVyy4yobJjMAYkjzy1nGWH8nL1Vvsz25SNQzouucqzF9ZTu0Cmakec+GtqgwnAAsqYBlmWPQQC
 MugXjZUCuyDv+weLZVngdegLGg7d7cIAk03x2ri5Dm6n+gh4UFR+OqyqLUAdiB7L5xakW/0Ai5H
 HKlVvTO0OWtVQGg==
X-Google-Smtp-Source: AGHT+IFkNbNpJKnHOHvQWDKkbiT61Z9Y1XUgYfllRIHpo+XLwx36ONBUOjwqwBON+dgpv3rc9YVk5Q==
X-Received: by 2002:a05:6000:2809:b0:3a4:f892:de7f with SMTP id
 ffacd0b85a97d-3b2001acb8fmr1073368f8f.36.1751450496983; 
 Wed, 02 Jul 2025 03:01:36 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:2aa3:3d9f:604c:fc30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e74fbsm15850233f8f.10.2025.07.02.03.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:01:36 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v2 0/3] efi_loader: Address some issues found by Smatch
Date: Wed, 02 Jul 2025 11:01:35 +0100
Message-Id: <20250701-efiloader_fix-v2-0-eb6db16bbe4e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH8DZWgC/3WNywqDMBBFf0Vm3ZTRtPax6n8UKWMcdcAmZSJiE
 f+90X2X514OZ4HIKhzhni2gPEmU4BMUhwxcT75jI01iKLA44wVzw60MgRrWVyuzKa2zJd5cyc0
 VklNTZFMreddv1pviyLodH03ivIeeVeJe4hj0u3enfFv/JabcoGltSmCNxCf7GMSThmPQDqp1X
 X8mQ1cVxAAAAA==
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, Tom Rini <trini@konsulko.com>
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

Smatch reported that there were some unitialised variables and
dereferencing of NULL pointers. This series addresses these issues.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v2:
- Address review comments on 2/3 to return EFI_UNSUPPORTED and eliminate
  the use of protocol_interface
- Collect RB tags for unchanged patches
- Link to v1: https://lore.kernel.org/r/20250701-efiloader_fix-v1-0-f3c6e0b0ae43@linaro.org

---
Andrew Goodbody (3):
      efi_loader: Prevent dereferencing NULL pointer
      efi_loader: Prevent dereference of uninitialised variable
      efi_loader: Prevent free of uninitialised pointer

 lib/efi_loader/efi_file.c | 2 +-
 lib/efi_loader/efi_http.c | 9 ++++-----
 lib/efi_loader/efi_net.c  | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)
---
base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
change-id: 20250701-efiloader_fix-63c3609c6ed8

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

