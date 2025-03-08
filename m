Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B966C282EC
	for <u-boot@archiver.kernel.org>; Sat,  8 Mar 2025 15:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EED98058A;
	Sat,  8 Mar 2025 16:52:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nq7EfrzR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7E8180C93; Sat,  8 Mar 2025 16:52:32 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E329803CC
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 16:52:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-543e4bbcd86so3395949e87.1
 for <u-boot@lists.denx.de>; Sat, 08 Mar 2025 07:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741449122; x=1742053922; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TRj2OMXfPv4CpomwBDI0CjnlXYBzvXmfO3B7wrDKOZI=;
 b=nq7EfrzRtAJjk4BMlHMxFKUzRIs8Rny2/h8IuBiyIRp1dfnp2YQEvoF69C7uSX73OV
 DJwVqem+Icu9ezw59IEBO12+I9tdV4Eb1T5XZt2ytZqjVKCcjKWJZxcXvksrOLOujxgH
 gnN18ftzhobfFon0CuQl0LBx80P27xJTaPqRiQBp9qBUsSXPGdeZg1CdD9EaZo3ddt6U
 XKdxAyoUVbcbfLfLqjMgx0QPaqKjbc4Mrujv8GEnQtkMGIUPt9o+0rc371rbxeuh/1Ak
 wl+BpUvSiwHcdxqZMVL0effD4zpxj/Ts1cbGoZMYmTw2XoTPs7ydtmwPka4hF1/D+D8P
 xJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741449122; x=1742053922;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TRj2OMXfPv4CpomwBDI0CjnlXYBzvXmfO3B7wrDKOZI=;
 b=m7eUOi2mYUs956TkJK5TyzeH7N2bTDGCQUjeR5avuGemW5X13I2xVQdWTxJN3fl9r/
 FQpP/knrLcUdFGcEksr5rUFxZ/L/b0cUbBHGxXPDj2ogtNEx3Ay04x0QX+8qwbgvCKoM
 J88Nd4/XvC070IAdkhIZdpIq7Wh58h5SU9NWM/z7QNnXjGyJlj8/903z77dxYtcOpczH
 nhcEtHv3m2+pVDz1EmnZIOyfzzxXHSoWqZfRgV1K0udfuslQO0luR5AcYN152rX2MLxn
 XVhz57pYrvNHXKmZkMhwZX9lBJgGusm2eaACgMKRajBuuHe819d+IyM7q9pGc8PFMGv+
 3U8w==
X-Gm-Message-State: AOJu0YziMzRCKDEQMew+CJA7UEcq3MPLyCkNVoW4PBJw8G+mpBIeZrSC
 GEiJSwns0Hkx6qPQ/3ME0WGTe0L3Qa/yLk+vPmg07QDutxvY3xTg
X-Gm-Gg: ASbGnct+vK6rZ1DfJdne3k7uDLXix7QR3ZKj2JbpAb+CK3udq+54f//Kg3Rt3NkNeKH
 XjntJNmQty+E2/nenglCQUaEYNbGYXwGMypzcKYVFWGexq0aVSa5fuToiwR4wUFvCEkSeOfqBDG
 RjkOkuSP5HC0PaZrV1YAtcLATV8XqYkKca6+RHfpomTHqmGEnRpcNTTmR8EYg09+cEj/NAZHefy
 IfqUhSSzP7x+IvXmyU2EQb51Df0Q6N1nu7jcsBT6NFx4F7B7ZPD9jq/OPgJXfPfw8QPRjR0Mn/F
 Q1blC6ss/0yxYC4bvOFWl8YJQVYU8FPD9NzW
X-Google-Smtp-Source: AGHT+IEEju9sYwpL+7kCwSivvJz2zQAXArWQ84cBE87KruUZXP412qtMe+AGWPJFLtzW27cKyHoGFw==
X-Received: by 2002:a05:6512:3ca0:b0:549:39b1:65c2 with SMTP id
 2adb3069b0e04-549910cbf59mr2721965e87.48.1741449121449; 
 Sat, 08 Mar 2025 07:52:01 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5498b1c3524sm846908e87.228.2025.03.08.07.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 07:52:00 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/1] sandbox: swap bloblist and fdt loading address sequence
Date: Sat,  8 Mar 2025 17:51:26 +0200
Message-ID: <20250308155127.27893-1-clamor95@gmail.com>
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

The existing memory layout places the bloblist at 0xb000 and the fdt at
0x100, resulting in a 0xaf00 size constraint for the fdt. This constraint
has been reached. Lets modify the layout by moving the bloblist to 0x100,
device tree to 0x1000 and placing early memory allocation after pre-console
buffer at 0xf4000. This should guarantee sufficient memory allocation for
future expansion.

Tests passed: https://source.denx.de/u-boot/custodians/u-boot-tegra/-/pipelines/25038

---
Changes in  v2:
- memory map of sandbox remapped further as agreed
---

Svyatoslav Ryhel (1):
  sandbox: remap memory load addresses

 arch/sandbox/Kconfig         | 2 +-
 common/Kconfig               | 2 +-
 doc/arch/sandbox/sandbox.rst | 6 +++---
 include/configs/sandbox.h    | 2 +-
 test/lib/kconfig.c           | 8 ++++----
 5 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.43.0

