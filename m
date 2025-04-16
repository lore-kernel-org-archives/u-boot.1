Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EF5C369BA
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 07:49:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACCD781E18;
	Wed, 16 Apr 2025 09:49:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T3fG6/W7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC18D82D09; Wed, 16 Apr 2025 09:49:00 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B436F819FC
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 09:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4394a823036so63645415e9.0
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 00:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744789738; x=1745394538; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eIXz2ULdtTo2cHCBGPZmIlBy5TVprQMk1fc+WG0HSoA=;
 b=T3fG6/W7If/K/7flgdQy0knVtTLPhGx/RJ8ojgSi0IZMgqAtFzWZD/FsLd/y2xPIEr
 cAG7cd9zK8aKDJC8qgV1wJJj7iVyY8TA56JNWKyfhGanqqbkyH08JJ4LdmSrYPkpMu0k
 90JxKwJ/udws+cqO4/BM9eFaluw3nGl/aqEgamXfadwCCqLiTnnMGxhl50kDboRuOc2l
 r9yq9R/OVSdhinW/BfgAmJeRcYbnfxtOiV26MoPDl+zjJKsxcD4o2dZGYC1e7xbmbvB4
 VOr65FbQz6EI70AMHYSLDlwQH437uybt2QnsVCKFnO7jaFqCDxnwtZUztCO05d0h3eBH
 YSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744789738; x=1745394538;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eIXz2ULdtTo2cHCBGPZmIlBy5TVprQMk1fc+WG0HSoA=;
 b=aTg+sbI1r7CXwoI2e3xkP0eRJ8XoWVIbxq4w9vwkUymG8PDy0OLF3S9lPefNsqBqE/
 Yj81ZzGmIdWT9G8+2t01qT0OLFRoYJdHsAPOPrqAZVAO3h8FTXAZ5DWWF/rSbUSQ9oTW
 HDadKojIoaRLmEzB3TFOgIgP806d9OFTb0KN1J83TGMNiTXgqZZmAfD2Qe5/3efFWLT+
 lHl3bRe90DVywXB4JVUTZeXbwRHC21hGcNUNxcLt4dxWY8IJdS8LOd0wFH73ILS+cvN+
 YZAm15XCS0yY9FyBdIIfUgHEN1m3ojWKdioWBdzBbUsUsj1Rjd5BYZ3roDaR7nZVi3U/
 0AXg==
X-Gm-Message-State: AOJu0Yy+ULE6Pdx5A3HrZWxoCnnMAYiqynVu2SdHYOIyFd+0ePyDwV5G
 pHBh/FAHmc41jWdbwE1lfgYHxoWQzq1b6VS7oVJ3YmdU/rnsQgyRp3f669kXitWMScBZO4lLaxc
 4wRs=
X-Gm-Gg: ASbGnctuSowFdwDp+5EZW9wYHtU3pqIUPfQc9Ai7yDkA79wmrVoT/qKfh/gX/pbdRPe
 uM33XAnUCVVhaRQNUvpzDZK4kZtZoIKYzTBmQH0hxP+L8AJdfU8t2NpQN3juW+f5jJjiW+Y4LFk
 /nzbpQvCrJE8CobI1kR0s2UqQ/p5u4Tf73FVlSE1VtzTprythTekHcrxCBBaO+rJn/vI88NRaNV
 ioQJ0xEmd3DNMKpmmr+gl5qN5thdZWa8EUMlVdwjdz7mDFzzi3TAc7C/WE8xsWtIAC5JUkwiMJw
 w84PIJWz1kBT0VcHl/Zvceb53M80UumTLI3RDk/bmXemwbNu
X-Google-Smtp-Source: AGHT+IEdwz+mgfL0Hcv2Et2JTJgh+425cQdkr8BZHi8aGxiuHvXV6uD2ybziD/4aAOWOARPV7C9qwA==
X-Received: by 2002:a05:600c:3552:b0:43d:1824:aadc with SMTP id
 5b1f17b1804b1-4405d6cd0ebmr5683245e9.29.1744789737934; 
 Wed, 16 Apr 2025 00:48:57 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44043529fdbsm26929035e9.1.2025.04.16.00.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 00:48:57 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v3 0/2] ut: fix print_guid() and enable UNIT_TEST for
 qemu_arm64
Date: Wed, 16 Apr 2025 09:48:19 +0200
Message-ID: <20250416074839.1267396-1-jerome.forissier@linaro.org>
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


There is a bug in the print_guid() unit test in test/common/print.c when
PARTITION_TYPE_GUID is not enabled but either CMD_EFIDEBUG or EFI are.

The first patch fixes the issue and the second one enables UNIT_TEST in
the qemu_arm64 defconfig so that the unit tests are run in CI (this
platform has CMD_EFIDEBUG so the bug applies).

Changes in v3:
See changelog in individual patches.

Jerome Forissier (2):
  lib/uuid.c: use unique name for PARTITION_SYSTEM_GUID
  qemu-arm64: enable UNIT_TEST

 configs/qemu_arm64_defconfig | 1 +
 lib/uuid.c                   | 9 ++++-----
 test/common/print.c          | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.43.0

base-commit: 8c98b57d72d5e5b94ed064fe1041e51216165334
branch: fix-qemu64-ut
