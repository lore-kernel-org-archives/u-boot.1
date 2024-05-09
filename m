Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F06C25B10
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 14:38:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D746880A3;
	Thu,  9 May 2024 16:37:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jzbKU/Ei";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 536A388054; Thu,  9 May 2024 16:37:56 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CFBE87FD7
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 16:37:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5b2735f217aso345505eaf.2
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 07:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715265472; x=1715870272; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+5HkLJGrLllH1xojGL6e8CxNXG5j4+y38l2LNx+4yeY=;
 b=jzbKU/EisKpfXjfz9X1uPagvMZY+Jane+3sH1K//+sNoMWN/QXnZVwwL8qMhIe6wfx
 fGVKde2qeZcIkfJrBQrNoXgjnqoID9MHWyHGp/lMFa7CWDlsQ+3GgtiRVaJsyRqq3rm9
 dpoJ9jBCL4a3ME0KGWZ7usfb0JTbv+UTcfy/TCHe1CGGBjAUtNXOJBH8wk5Ns9wURg8Y
 kSLeOS4qrPlKh5S4hjF3cCxjI25lSEv4kmL5QvHtQoa6ETljV20llyu2wH8Dfla+Al9A
 rwbJD587oBtemTjOrBibHTlKoASEqGsyvK6ACXwQjDHbg8H5BZbtNyg2UmvdHOTC3KkR
 7nBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715265472; x=1715870272;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+5HkLJGrLllH1xojGL6e8CxNXG5j4+y38l2LNx+4yeY=;
 b=KqIKkXHlwNzwHAr1dXbrM1Jo4/LDn75/AC6cQlz+c8XN48TmzUo+2Z0mED4Ot5VIz4
 rQTMxsj9+ev1i4SUtCUj2JGXn2Nd3ous5D3RAuxhtOnohmIgHjtZeMvCOdOUXhHtEW7m
 PQKoTgmfLMj36uxMY3IFNM22giHov9VNUog0iNNAWxZy7aE/n0Pt9N7qXqLSanBeSz6e
 4O4ZH3ypdsYbD5apjyQjIoLDXygZU2fgifpEAXYPypdrtZeKJ+7hzTQYcgFBWrlHStSv
 LEeftCSCxeD1yRK4LHSagsrqMS/YeUmVfyF6fyAmbrQaANGxc3KoTHaHjnGTR0prk6nQ
 mH2A==
X-Gm-Message-State: AOJu0Yzm9iTldPBjJSJGURO6MRDrBflywzOk13NUZuxZncoi0O0xeaYA
 2wK9BUiebR4ThDXz8vULH0KBx3R3SC0+pR0Ce+1aNesV/BAj4R7GYomfJqOM79b9MZzmMhCrsvp
 Z
X-Google-Smtp-Source: AGHT+IEyYTxpdlMrc/lZ+i05uYGeae8qbAGPlgAOWcQrL/Op2dSbyUFevARHcnElt5r1BDytYbiLKg==
X-Received: by 2002:a05:6871:289a:b0:23c:bbe9:570 with SMTP id
 586e51a60fabf-24098a62d26mr6861230fac.37.1715265472677; 
 Thu, 09 May 2024 07:37:52 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf275b07sm74563685a.24.2024.05.09.07.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 07:37:52 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH 0/4] Clean-up patch set for MbedTLS integration
Date: Thu,  9 May 2024 07:37:37 -0700
Message-Id: <20240509143743.1496210-1-raymond.mao@linaro.org>
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

This patch set is picked from the previously posted serie:
"[RFC] Integrate MbedTLS v3.6 LTS with U-Boot"

They are not directly related to MbedTLS integration, but the
prerequisite for a few clean-up, refactoring and minor fixes.

Raymond Mao (4):
  image: remove redundant hash includes
  efi_loader: remove redundant hash includes
  md5: Use typedef for MD5 context
  arm: EFI linker script text section alignment

 arch/arm/lib/elf_aarch64_efi.lds |  1 +
 boot/image-fit.c                 |  4 ----
 boot/image.c                     |  2 --
 drivers/crypto/hash/hash_sw.c    |  8 ++++----
 include/u-boot/md5.h             | 10 +++++-----
 lib/efi_loader/efi_signature.c   |  1 -
 lib/efi_loader/efi_tcg2.c        |  3 ---
 lib/md5.c                        | 10 +++++-----
 8 files changed, 15 insertions(+), 24 deletions(-)

-- 
2.25.1

