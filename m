Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D0BC02187
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 23:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 805D080748;
	Fri, 17 Jan 2025 00:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HHxnMFqc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63C788073D; Fri, 17 Jan 2025 00:01:38 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDDFB8033D
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 00:01:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-71e15d9629bso478269a34.1
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737068494; x=1737673294; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GJ7yIKnmgtUZZJxqDHnUXl+khog1WIPAksWCWi0luW8=;
 b=HHxnMFqcaqK28TJQtymYn7D82vi32NZVANf5BQz8atqMmc3DEVui+jQZ5o6sNTRA0z
 bKqEmVjooQP1LtpwYhMnspqzYc7fwb0JZtDM/QOcEChDfEpLQAL5A0RNlYm+szRoVhyF
 cMJfsXkm93i1R/ZLsKmZazuplWMCl74/Vp+fXNTXDP93aS5E8z9a/WOOXfeiXqFXgeBr
 0wcRoZJPUmBmB18Xl9z4twG0Leirs24jjba23LW9lTZ+YoqN0EVT4/ugVkc5gKUzkdsw
 Iw8M47b/wKaIZYuCcUG9T30ppCf1+gODd65J/g/iEryxIn/2akliDkXv1z38rFq0e+/J
 /MXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737068494; x=1737673294;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GJ7yIKnmgtUZZJxqDHnUXl+khog1WIPAksWCWi0luW8=;
 b=Szq9lbViDe0rM5IqSL5gTajOkYEhdyF7AsrQvtivNAbDFn/ioQOjxbVQRCQXLWLJpu
 1yprdTNrAHU6wdJwwuFWA+cMuselETfMjB/eL2vRRQXOFhc534QNcTDBXne3u4NSWLPN
 pzP5guhTMElFSYJv9knDAtfjaLuzaF08xi1ku3x2jcRGvleM1hi4t45Va+EVVspoTyDU
 m2AGy7Qk+9rI8fswDo5wVGVMctQZCoHjlCv8DDqyMDoRU5NKqhj5c9zkdkWtNZ7OTTe5
 WkOoVRF0krhYJTRfKm7mYgvIzVn8y0c7mRVrXYmGYq4UVu6eGx9fy78vLjIOgf3KqomZ
 OLBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOfAmnSjQmFQ165m5jL3nwcl3nBEU0xS93rUB7Xs4wxFkEqDjRbfqYW45nxbcsgqAhN+38HS8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3/M6AHOE85N3nQz2UtUqtHTVDJlO7xR5ExWeV7sRI72auBeAB
 qXQy04js+SbWzHaZEDgq31SJ31Nku9p9aimvVzbssFTmhccXYidKReeHfxuaqhY=
X-Gm-Gg: ASbGncs6g+AWfyKAAioipyhEM38JA3K02qm9SNoTo451p88Q/UEnEU8+h0eeVC2Ft1s
 fFp0EQ5cS/uAmUntCTFfNZ2khki8veL+yhUHR/0WI27Z9Cv75+zF2zjYEWeK3AFxG0HnHEhvxob
 DTbMeE3DKs2XbJU46uNEepaN+3FPvLf2Ou3xj0u+fcHvCc9yTReqIjjtrtpE5PSjFRH2QWQNEqf
 vqljtngcPP4GDnIp+WpMOm0j/naO177HgZekcJoM7aCVxFxyuh1+YBoq1QFzPtC6tE=
X-Google-Smtp-Source: AGHT+IGfhyFiq2AX+6vxPVPYgRIM4wSGjRsmNuy8V/KTQhNGo6b2syL2tr3+uOXYTfugEsXY7hJSCg==
X-Received: by 2002:a05:6830:6319:b0:71f:c1df:1824 with SMTP id
 46e09a7af769-7249daec8b8mr191928a34.17.1737068493167; 
 Thu, 16 Jan 2025 15:01:33 -0800 (PST)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7249b485392sm488163a34.48.2025.01.16.15.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 15:01:32 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH 0/7] board: samsung: e850-96: Enable Standard Boot
Date: Thu, 16 Jan 2025 17:01:23 -0600
Message-Id: <20250116230130.3337-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
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

Make all necessary configuration and environment changes to enable
Standard Boot on E850-96 board. Also rework LDFW firmware loading code
to look for LDFW binary on EFI System Partition instead of dedicated
'ldfw' partition.

Pending "[RFC PATCH 1/1] efi_loader: Call efi_init_early() even earlier"
patch is needed to make EFI functional on E850-96, but this series does
not depend on it and can be applied independently.

[1] https://lists.denx.de/pipermail/u-boot/2025-January/577194.html

Sam Protsenko (7):
  configs: e850-96: Enable options for updated env
  configs: e850-96: Enable U-Boot environment on eMMC
  configs: e850-96: Enable more EFI features
  configs: e850-96: Enable Standard Boot
  board: samsung: e850-96: Load LDFW from EFI partition
  board: samsung: e850-96: Report LDFW loading failures
  board: samsung: e850-96: Provide bootstd default env

 board/samsung/e850-96/e850-96.c   |  7 ++++-
 board/samsung/e850-96/e850-96.env | 37 ++++++++-----------------
 board/samsung/e850-96/fw.c        | 45 ++++++++++++++++++++++++++-----
 configs/e850-96_defconfig         | 23 +++++++++++++---
 4 files changed, 75 insertions(+), 37 deletions(-)

-- 
2.39.5

