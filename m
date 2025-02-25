Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DE0C021B8
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 20:06:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D15780977;
	Tue, 25 Feb 2025 21:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JkGQfTkK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1172080977; Tue, 25 Feb 2025 21:06:47 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 840A980805
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 21:06:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3d03d2bd7d2so57418885ab.0
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 12:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740514003; x=1741118803; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VzXbJnD9uCAb9RfkZfWA3zH1O1Xlxvce78VWsaZ/yrc=;
 b=JkGQfTkKUZAFL8+6rBIeYbxe7XVciIRy08LiWtHovVOOSKAsP/z6gU1aSf8bcqH+Ie
 a5uXfS1231YXHpUvxyMRuByfhwJfnpLMcaI2qb9gLOwlKTodBcp49JQfaFfb0Ofai+ow
 9Fzx0Zx7Do3FLH2mOl4sW4q2wbK8wGl0MyX6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740514003; x=1741118803;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VzXbJnD9uCAb9RfkZfWA3zH1O1Xlxvce78VWsaZ/yrc=;
 b=leE+yKjZxld8NqzZ7TtuwJtb0i5kj7pOk5VGMGYl9iJ3H71+JoF0ll1Jjwf0VnsPCs
 rguWF/TRtkxuZ8aBhx0AnW224M55+01RpH5ttWrAma45KyzbRdAH/wdBUvHq2VhHVOY3
 Sl96ivONCGrRdMg5Nh7Y9xBdLBxtfCWwtpchAWuNjSyZ/T32ZQKQMbN9FTObHo/j867Y
 LAsd/15hTidkjmTijVkAOAf3hpmmN9im22XwktvqEMihRSW1QLmCoaJeEmdIbijgNQnm
 ZEqiZcbVN3+LLPa9q56upWmyoxbX0JYvKt+I59qd2mYU4eRMYCW7MBvZLrdk/Y6f+0i5
 Oj9g==
X-Gm-Message-State: AOJu0YyzBMT0jBHBAlE+3Kqqz5egHN+SoV5rvUx/u3jVgNyiNWsGmmn1
 1auviiGVmDAqNhPISaczNFH1yNZiCpDzHpCIcZbgKJoseB9CTizlysdpvWaPKvI1QCkWlIvcU3E
 =
X-Gm-Gg: ASbGncub6vpZ5mp9m+QEpQsga55X1Ztd0w+yKbm3kh93+umzPYxnXrbu5pjdq88/z9C
 cLgAGgEPdS2aCCxOD0bZmMRQh6R2PRcRbmW2xKX0scjZH9a3MPu0mc5amPup0LTvFNWjZdgk0jb
 zoGwUM1TIfdqn+yHrmfxwHtRtk7EjvlAnu4FM7P8VgVkaPFAMA95zLx/NsUXIHO8R4TKGC6L2Eb
 ti8lEUAYmtvXSQqfxik4fqD1RXCc+IU/7hd5Fy7QR9xapw7i2Tokpp0H4TDF/AO0hjmlun1B9x7
 V9yOybcJDJrnWNzUJ+UFfE36n4zlZu/ES4zrDvM+2g/O7JV8R0uog5t+a+jBUqw=
X-Google-Smtp-Source: AGHT+IHxyAHrCbyIRoN1+YwlLcP6PoI1ndwVXRQTJM+9ge7thW/4sEz42Lm4/xFSBHoMANUEode32Q==
X-Received: by 2002:a92:ca0f:0:b0:3d0:1fc4:edf0 with SMTP id
 e9e14a558f8ab-3d3048802e7mr45746415ab.15.1740514002692; 
 Tue, 25 Feb 2025 12:06:42 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d361ca210bsm4653305ab.55.2025.02.25.12.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 12:06:40 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/7] binman: Check code-coverage requirements
Date: Tue, 25 Feb 2025 13:06:25 -0700
Message-ID: <20250225200635.3781149-1-sjg@chromium.org>
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
  binman: Workaround missing test coverage
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

