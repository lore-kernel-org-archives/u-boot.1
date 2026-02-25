Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383E7FD3775
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 16:50:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46B4D8416F;
	Wed, 25 Feb 2026 17:25:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZOHNdjQb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8977384199; Wed, 25 Feb 2026 17:25:19 +0100 (CET)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 542A884150
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 17:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7d4c307db9aso3938561a34.3
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772036646; x=1772641446; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WT0egzFuXLGSO2MQE02bbBmiVYZEAni8PpguUDtoAEk=;
 b=ZOHNdjQbv9vt+ub9hKW+vRVnQZ2pqAYszcBCTXiqD0nUy65mcvQtefwDShp7ysTnyi
 CwhJmcPb+o+GFm7uy89wad6OpO8/uEzE7dhli/lNM6zlEGCclIoEkfprUyd1TpgKOWdr
 F73r1IgB4+JCvxVDgJVHFJ5pcGU2C3xaVTOIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772036646; x=1772641446;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WT0egzFuXLGSO2MQE02bbBmiVYZEAni8PpguUDtoAEk=;
 b=qixvJuDDGyjiiRZ3cszBWkksJD2jl+clOtXiykpqaw6jPVHMYPjgYgmAykqwfDCDhT
 8GzuWEIuD0DQiq9xdnBEVDLSTF57dk95zJdLGZV1quJADtrgjQljKDwDisiq5bhNJ3m7
 lMr403IS833Bu8D26rK/2bwfjuZvac3FMpUWjMoTVSf6GADMI45cEfS2Xk8BIc8kmVSO
 yBzRpXbRVSD1z+qBnFtV7S9uuqV0kAp1tUU1T8UPico/F+ZQt1d3ZkfwriNUgwJ7bZGL
 WFPCWxD2BA7EMfjLIL3JOm3GRwCIZ+tf0n+l0c/n5j+XKwd7D43P+q3pO9XCpn8ZWOMd
 UOwQ==
X-Gm-Message-State: AOJu0Yy24mM5Sk/ZMRDcpnCOFI6s2S/TYETSEugtvwewDHMaZ3TMbDxr
 f/EGk2nSyZpfUxRiut67UvJUEc42uUHW1EzptRffoTX0Lh0v3iYGSH1iTELg++gWE/7Gx8ZwHXm
 QWsiE2Q==
X-Gm-Gg: ATEYQzzYnr6uLWK57LAjuiBoVnYytm7yTp3HiV6bsgO4ZPFqnIllbRN1sV6mh9nIE30
 pzqhImvQ2dgd0lFL0lUpLSUaz8hbVGPXmw0C2MMCh1yIF4FQb91U8b/yeTI+qvTaz12SXHkrabC
 xoRmz8P95bA5FN6xBLhYLsiDpFUKxgApMoX8wyOJ2ESSjz0O3JdgnreO6u5hmTubXsgDUMXnymH
 iGxX1UgvRkDLXCBf1/b8HZCMNPJA3xwa0hZda+bVDzI268uw/ivdHTb7dioy9BC+6dhyi9DHuD6
 5o8hauAfusbNVBFyg2yuk8NiDkdeMz1/LVQSmLWNlDqvLA01wu+DkldI1g+1OiyM06GiCm9266I
 TMViJZtENLEZWP4I0Di6ScfuCUKCulG2uXQzbttzht+HK0lgvr07UGM5rq640PmIyiJG+AIjMh6
 X8GOAZITyUvfvj1lxrcwabDEuRn3hT
X-Received: by 2002:a05:6830:3c84:b0:7cf:d14f:a4aa with SMTP id
 46e09a7af769-7d582a6757cmr442966a34.20.1772036646192; 
 Wed, 25 Feb 2026 08:24:06 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf7874csm13534383a34.1.2026.02.25.08.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 08:24:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>
Subject: [PATCH 0/6] Provide classes for building disk images with FS
 partitions
Date: Wed, 25 Feb 2026 09:23:44 -0700
Message-ID: <20260225162357.3449937-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Refactor the test filesystem helper into a class-based design, reducing
duplication and making it easier to create disk images for testing. Add
a helper class for creating disk images with partition tables.

Convert a test over to use it. Provide a few other minor improvements as
well.


Simon Glass (6):
  test: Update fs_helper to support passing in the image
  test: Update comment for fs_helper.setup_image()
  test: fs_helper: Drop the size_gran argument
  test: Convert fs_helper to use a class
  test: Add a helper class to create disk images
  test: Convert test_efi_bootmgr to use FsHelper

 test/py/tests/fs_helper.py        | 308 +++++++++++++++++++++++++-----
 test/py/tests/test_efi_bootmgr.py |  38 ++--
 2 files changed, 271 insertions(+), 75 deletions(-)

-- 
2.43.0

base-commit: 8fd76675efbe7af785ccc1ba1ac8b9f7e10f6715
branch: testfs
