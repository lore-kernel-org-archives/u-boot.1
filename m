Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E13CAC5A8
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 14:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F28383211;
	Mon, 22 Sep 2025 16:13:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EJxS/eBP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 042B1833ED; Mon, 22 Sep 2025 16:13:44 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25CBA82CF4
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 16:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-273a0aeed57so16895795ad.1
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 07:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758550419; x=1759155219; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iPhwYxK49aII+VjEHEdd60jyS4XpUVTwrLDfGWfneP0=;
 b=EJxS/eBPPvRiDkuf8RvuEHQ2c9XFjSBN64a9XyICIj2BYmpnWU1WARd90pB41So8xu
 2UeplWUywdGn/iJ0yZPgKEHfIRJRhNtIiq9ZNIFHJWmoGWuWomf33F7OGuvhqYnzbtqh
 yfS7AuYizksi3Wm1jA7nIEgsxLbhPseD3BTD/Ev659IeCbeWeGdb/9mhIK7wIi0c2oFI
 uS+hiiqHaCJgSZgBFrCysBpewlirJ6Qs4Qe+Dj/MKn+z5rOTMEVuRl9p03gsV3XNXyEa
 BNP7aN9OdNqfO9RA5uAlTcVN/8iMcahYVcP10voHsgd8CjRgES6YjcfAK98VOeBS2yr/
 mAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758550419; x=1759155219;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iPhwYxK49aII+VjEHEdd60jyS4XpUVTwrLDfGWfneP0=;
 b=Up4XJ/9qXSY8wcXzam+ZSaGDSnNfJQdex4kc16h/iN9JMy9vyhoFHNXk1dxV3hXM9z
 o2scSqMoGHg7y7Y2gBB4ZX9X0GfgU+6bAHWu7Nzz3NqR7hpmbQVez1qnytFklQiV6kcx
 G9bVYfmdQ+R9tSNQRTGqkLkWp+XsooMrLHq0vFWVXd4FWvnl4aq+zTpzuft114dE6XBb
 950yO/liSL9SdNcUxJ94nzLLxMVZWs7+i/Uqiz3D10dTJ8bX1cb71COfOn26CEiaIK0P
 Qr1TOkStSsIvRjutbYVtx1kBSmfYbpqmcO5FR2Eyz4mwvZKeX7oU1MV2+U76V6zwI5IE
 zmgA==
X-Gm-Message-State: AOJu0YzRvDlh/TthZ9iOXF4EedDDn91yDSw32JCg1bKUSPtnRtXe8LFH
 g9ST4jCOBq92vTJp3nXo4VjuXc80P28qhRbF1hQAgaoyL49YgldDWjfT5Ys38Q==
X-Gm-Gg: ASbGncshNXLKuOfcaOtXgjPEcZYAqzKBzcec78VpBRra/dvTrWZG2XjtMT1BgMG0/cx
 NN9qZG26roxfsWOlPMzbVB+onETlSQG1qxFgGOXu5utAl8OZGmuC1WXJ4EK3Je7KK/iRvhafI4B
 4rJq+PmBFo1tt3Ukb35wq4X+rd7Sm+RiYbUR87sWNQ4utZTCYXejYEe+6pJsDj3TdixZCPR7gnb
 N/kAIHN/ppHMlBlxvAioYyqNlaDM8X9edxrDQRz4d5jpowUf1xN/NbbtH4ENI47qrH66WbdR5/5
 BNTruKcFcw0hJXsTgU2H8K13whYz2fBcAgn7EiDa7AyK8PDubsdm+vjv2liOmi7Z3CIvbImBoFl
 CYr6jCSSWD5p0wDe/xMsHAVmclASGDWne1I3pYHSgC4YXBZs=
X-Google-Smtp-Source: AGHT+IGa4i0XSESq0kJfK7ZGno5zaxfFaRiSJcOiYqCtXvHqvLTkIOMx8ky8IrYIeplBs2kro4l60w==
X-Received: by 2002:a17:902:cf41:b0:26a:6d5a:944e with SMTP id
 d9443c01a7336-26a6d69d840mr180624915ad.24.1758550419253; 
 Mon, 22 Sep 2025 07:13:39 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:17f3:310f:2163:7ea3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698033d788sm134861495ad.127.2025.09.22.07.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 07:13:38 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20250922
Date: Mon, 22 Sep 2025 11:13:35 -0300
Message-Id: <20250922141335.207427-1-festevam@gmail.com>
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

Hi Tom,

Please pull from u-boot-imx/master, thanks.

The following changes since commit d33b21b7e261691e8d6613a24cc9b0ececba3b01:

  ARM: Remove mistyped GICV3 definition from ARCH_SYNQUACER (2025-09-20 12:02:58 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20250922

for you to fetch changes up to 1f95591cee01ea5e065b61d99a9853b164acbcf8:

  board: phytec: phycore-imx93: Fix i.MX93 voltage modes (2025-09-21 09:09:13 -0300)

u-boot-imx-master-20250922
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/27685

- Fix Phycore i.MX93 voltage modes
- Call DM post init function for init_r phase on i.MX8ULP
- Fix ELE FW version print bug on i.MX8UL EVK.
- Fix LPCG number in ccm_reg structure on i.MX93
----------------------------------------------------------------
Primoz Fiser (1):
      board: phytec: phycore-imx93: Fix i.MX93 voltage modes

Ye Li (3):
      imx: imx8ulp: Call DM post init function for init_r phase
      imx8ulp_evk: Fix ELE FW version print bug
      arm: imx9: Fix LPCG number in ccm_reg structure

 arch/arm/include/asm/arch-imx9/clock.h |  2 +-
 arch/arm/mach-imx/imx8ulp/soc.c        |  1 +
 board/freescale/imx8ulp_evk/spl.c      |  4 ++--
 board/phytec/phycore_imx93/spl.c       | 37 +++++++++++++++++-----------------
 4 files changed, 22 insertions(+), 22 deletions(-)
