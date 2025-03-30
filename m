Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08525C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 09:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F4BB80BA8;
	Sun, 30 Mar 2025 11:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K29WNpXQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 805F08198B; Sun, 30 Mar 2025 11:01:43 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87F8280BA8
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 11:01:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e6c18e2c7dso6522419a12.3
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 02:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743325301; x=1743930101; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7tzvSGggDgnFH9vx44kEl6dq3bsm8FdsyLyL4q/RbdU=;
 b=K29WNpXQEFa1Ln5JrX1pFZfjDglkaqw3UFp4XUDRwjwY0u4tYYkWrB/PiYBLBv6/yZ
 Tvq8sPAS5bkw+rLPb5DJlHUk2H+rtMi+pSjs+pp9Hw41XGpkGyTTwGVJ397hZZADI/QN
 9oMnzhTibmiA9oP5svGof0Caeax2TPruuG/SdjVg9XzkymZKZulkUPHVc+pkJwdkDfvI
 2eLTwmGP2Ho2ylO/qOQ5aEOgCBUiV3SdyUZTWwxkueT9ulehISrFuG2e+yiBgiaiwB2O
 ikS7uCNNXcQb+inj8bCfm+NLbMurn//d+JWXT7/Ymjoz3z0P78leqzml46VwiHcBZUVe
 tXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743325301; x=1743930101;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7tzvSGggDgnFH9vx44kEl6dq3bsm8FdsyLyL4q/RbdU=;
 b=ryQPK9Rj7ltsd19ILDg941uNIimXg6MmKF8m9ZYHohWoNrMIC6tclCShwLxqcRtusL
 NglEmtcVqo9oGUs0a/fzwrQFTaVdG5DPsv4SXyq/Z0oma7Vx6HK3QG2jWtcG4bl+loTZ
 z2NZ8U91OgmJhgXkaptI3vCMRs4RH8HVA0slbwkcPZX06c30JhgSZ/yngkJbdxpieA1W
 68UsqS3W9SdhC97ivEoHHXV1v+Y6IP5b/a2NYj+FqO90OxF7ZZSm6GIAkEAtZWrcBNWJ
 fhUr/riOCRJX18nOT/VcdtK7M878wDhEKgr0yK+y7CN4hrlGp9KmddX6+meImicHFeSe
 tsGw==
X-Gm-Message-State: AOJu0YyDf6XaXROsQTpPQbmOZq4nu56xqxLP8xiLw91eW4gcprocqhty
 /uRjOYbok1WJB1uLZ8YZdCM1kuak3YX9uZaa26r/V3+dB3u//rT0
X-Gm-Gg: ASbGnctTRLTiRowrwTbjQ/HTjwPLuvpXuwdOCz61VcW17fymylHv0noIBIvd5MQ4HK2
 RZdquMg7AKUCKGxnksflpc1MfZZ+Bg/f55y0tzsbqBE1s7TQ9Rc5AJxq1d+OTtfE/rG8FRv++xp
 YFuX6FIwDu1jvvmBbeR+Byq0pn6QuQygk9boy4RvCfI1C+FubuQ8X4ysC73LxZ0wYT2cm2TZGZO
 V4ZVIVx/btPGQIJRetR3SNNHrfRmXy0cptiB/kaYtSEvjtUWsbmgebcYIQyxHKe1XCPI272Ctc3
 rdyaMGQ+ePcaW73hb4uTidK7vrmkU8APxzgN
X-Google-Smtp-Source: AGHT+IHDxHjbxKyuqrMxYkdVPs9lDKSoQGIM4x7BKIGpdw4Xrt2NLVm5Smg11RNil4oelB30UH3YFA==
X-Received: by 2002:a05:6402:1d50:b0:5e0:60ed:f355 with SMTP id
 4fb4d7f45d1cf-5edfcfcd029mr4533342a12.18.1743325300464; 
 Sun, 30 Mar 2025 02:01:40 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5edc16aac10sm4172595a12.9.2025.03.30.02.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 02:01:39 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/2] Add missing SPL_HAVE_INIT_STACK for ouya and mocha
Date: Sun, 30 Mar 2025 12:01:18 +0300
Message-ID: <20250330090121.8312-1-clamor95@gmail.com>
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

Ouya and Mocha were added around the same time SPL_HAVE_INIT_STACK was
introduced by Simon and therefore do not include this config option. It is
critical to add it before any defconfig resync, since the SPL_STACK option
will then be removed.

Svyatoslav Ryhel (2):
  configs: ouya: add missing SPL_HAVE_INIT_STACK option
  configs: mocha: add missing SPL_HAVE_INIT_STACK option

 configs/mocha_defconfig | 1 +
 configs/ouya_defconfig  | 1 +
 2 files changed, 2 insertions(+)

-- 
2.43.0

