Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA00C282D0
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 13:09:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 434E88144A;
	Tue,  4 Mar 2025 14:09:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dG8yqtoK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CBF98144A; Tue,  4 Mar 2025 14:09:57 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48AE281426
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-85ae33109f6so128326139f.2
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 05:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741093792; x=1741698592; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B2zsLws430/BEZfatNjeaNnrcxmYUstVjp1pSXgNQjc=;
 b=dG8yqtoKpSy15RHagnPcppzR8KbFCRXa2OBwXfwGoyN6M15tOJsUu2tpCdBFYiL5Mk
 hQz5iDLV8p0Bs+fP4XtNEx7KeYfTZhiqcRFvdCLwYtGray/IHtOZaNoHLajrstic/OgE
 01ymu6gOEboU32eQ8uC8pdCYQ4UCkfKJwmiiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741093792; x=1741698592;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B2zsLws430/BEZfatNjeaNnrcxmYUstVjp1pSXgNQjc=;
 b=eihzJf4i9gin9usvz4hnAvvbLV9/yB7hGPpwwW/amgnPUyWCeQstgvGL7WDLYYnukH
 161p4mt7+cCj7Hao/jSPvVZeuKiBNPkS4YCuP3QjXfdk2ziQ9IjloVmGarWZUOlYJ5iQ
 dZnxypUkuFfLcEDSwUmRO1dvLi3nH8PDlae3yT2H87LeHaxhXWdzHxQdPc86rkYyCqCr
 qBC2CTS31jqSuiaI+7qB3glvbJbSEXkunz0iDewTJDvZfmuloxTipWUjRJ1mg9UJcZt5
 9xIuTq1n9aYf1RcQlrEOQhdBAQ0/IJgvmZtzPZi9L+ppBva1ER/xm06nMA7GEUtyGwun
 c6pA==
X-Gm-Message-State: AOJu0Yybx3b1+yClf/IfIbQd9u8sxzK9ixPP2HimXF/dGZfSiS7Cb+O5
 WrAkvtp7m3KPM/Mpv0sSZ5qrfTnKnb3WZyv6Oe5Q1iUjAftGNwbSxob5eJ/0y3cgrTdzE4sIWPE
 =
X-Gm-Gg: ASbGncu5gtgpXEPGrpbTRJulqFrFj1YPAAmKk4MiXA8/3J1A+25F0Uug2KeFUrZEjkG
 KMdPg/C7e2emIvfM+Jl+mKv0ITBvhbyNCyY1q2U1s1cayZF05coZ9ewzGxXJGiEqLMG69uBmmIi
 rBEvCnkXS+HVZobDQMtOsezpc+Ju8JRA7+y1R0WIlutl1mQARct6p0zTkuZp75QyB6dm/d0KYgd
 iux/t/f0HC2CxstQlTlJYzKL6UJgkB5/UorY1lW/0NDRS6P1iemPQ7I3EPLJO8tM5ZrpJE7qgNP
 xy0jXbUv44c48qJ1VszfY5USB8fRG7nwUYxNu6N1PXv9xWbl+z2xL68qNYUrFlHsB8ILTXAyzyr
 Cdj+Sxg==
X-Google-Smtp-Source: AGHT+IFeVk5D4YEfJgPxOfg3ikO6Q7IhaDzABGkAPI6HA0ubK85OPhUHK08gV7enBQ8OdoE/ttqEjw==
X-Received: by 2002:a05:6602:640f:b0:855:63c8:abb5 with SMTP id
 ca18e2360f4ac-85881fdba3amr1839428939f.13.1741093792636; 
 Tue, 04 Mar 2025 05:09:52 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-858753cd304sm287383839f.33.2025.03.04.05.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 05:09:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/7] binman: Check code-coverage requirements
Date: Tue,  4 Mar 2025 06:09:37 -0700
Message-ID: <20250304130947.109799-1-sjg@chromium.org>
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

This series adds a cover-coverage check to CI for Binman. The iMX8 tests
are still not completed, so a work-around is included for those.

A few fixes are included for some other problems.


Jiaxun Yang (1):
  binman: Workaround lz4 cli padding in test cases

Simon Glass (6):
  binman: Exclude dist-packages and site-packages
  binman: Drop GetRootSkipAtStart()
  binman: fit: Drop unused code
  binman: Drop algo check in CheckSetHashValue()
  binman: Work around missing test coverage
  CI: Run code-coverage test for Binman

 .azure-pipelines.yml                           |  5 ++++-
 .gitlab-ci.yml                                 |  4 +++-
 tools/binman/etype/fit.py                      |  2 --
 tools/binman/etype/section.py                  | 17 -----------------
 tools/binman/ftest.py                          |  7 +++++--
 tools/binman/main.py                           |  8 +++++++-
 tools/binman/state.py                          |  3 +--
 .../binman/test/184_compress_section_size.dts  |  1 +
 tools/u_boot_pylib/test_util.py                | 18 ++++++++++++++++--
 9 files changed, 37 insertions(+), 28 deletions(-)

-- 
2.43.0

