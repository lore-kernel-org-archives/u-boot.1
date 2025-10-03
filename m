Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE23BCAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 10:42:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12858836C1;
	Fri,  3 Oct 2025 12:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A+7yF7R3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3131836D3; Fri,  3 Oct 2025 12:42:54 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4A808366F
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 12:42:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-421851bcb25so1130280f8f.2
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 03:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759488172; x=1760092972; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oCDYLkh+KshuwSTVkheXZw94lvm1Kd+FSVX8FP0D1FQ=;
 b=A+7yF7R33awJY093pTWgJCif4szlHn0iAqYWr74Ff7SyY4GhJlcSFFGqnlV1Am88UH
 VMRvmsQQUg1+vyVR6JRGbVPoaz7GeZxPBKNglNi1Kp0vA0RxfucbLEmG7fu88OiCMAt8
 /EQ/7dbLes5qURqT8Z0McXmXgzjQAe5mITwVXdaa2m2omEj/1K7WQZgUbCfCDrNLDpZP
 tgETwTGi6jrZ946ok7bFzu4jzhLh1GlaBXhjFwqeJBQsda9YQFLGJLSSOWFV13lwEBlZ
 45C7nveJd5CXKVuui3NlOrL7IdAO/q6Od7XaMlFuj+OXOxa1joy5pQ/IXFYHaPd7G8+M
 NwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759488172; x=1760092972;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oCDYLkh+KshuwSTVkheXZw94lvm1Kd+FSVX8FP0D1FQ=;
 b=jVkYtGaNbMGXRwuO1n1Q8TZTY4TQFud8qrPNEu5WMKHaiZYPniTOVgdeB/CikZL16k
 w7l84bc//98Z27RG0ldZBUnpRZZSWmMbn7BB68/5naElww7trvJDeybGFIgrSBl8KpgS
 s7dUs8L0s0EbYaTlsJ4PCCgnuF3BFDSsnKHo1D32lfUTInA6CxHorapfouDq3RALfL2A
 f7eWOtx1BMxoH+xxg49oPe7aANhl3ixm6ZuFCcQb5yyuERwPobqlSdI8kFRuQNw1W1g5
 iuV8SDpEtI57FHMv9uNntN0K4clUscXc3ZSJHr/jndt5majc04Gs9+mZ294yOW0ORtW4
 SJJQ==
X-Gm-Message-State: AOJu0YxWhI0wOjBMhnYqK1bACeyYN5eOs7HYQ9M2+JO7jv6JywJ7PAFU
 +koL/EBSYyaDXI2hPCezfOJ+K0KgG+Y4Lyoc/XxIRhUXpHBYrS0nK+vnShnew+68E1cWkivgug8
 OfJlG
X-Gm-Gg: ASbGncttdnPP52fR2+Qm1tlMsbBPEbvOYn4VjA6JWbiSvCPX/bq1hy260+YvyTv757x
 5N2DZXyNumWYyzJbJfYFwCynR8ewcnG4jfQfQo5IhqTZXGjaOp/Pmg/RV1gDrNNclVvHExAFm7T
 Bnx65jpamITIubwKBJXYNlFPoA3YJ7z4CuOlHiod+qXx1JgV+Uc4i//FN64jjAduB1Qq9nagH33
 SURI09RED0nOvHT66gwLvUJkfrEPohVjcCRN8m7FpDFhBeCdwwverXqQWzdCalmaK5nqkjeJoxR
 Nx4woFHZaFOgo7HzAcPfEkLffMwBRfOv6emDjRKvZKP2znHCDncCN+IUJ8GtTsOz4BMFLyZTnUi
 WeJkAw3BPYI0Y1K3Vs6XuUF77g5RnaQjgs8UogACz6SHL/dMUK+j6I1L/QgNTxTfn7SMGo2OYwQ
 Cpf5M=
X-Google-Smtp-Source: AGHT+IFd4pXZ8w4eDhzkAGZG1LvxiFnYUdtvT6bxox7TlthocnAeT56S/9K92WknNnpMF15PpkxJWQ==
X-Received: by 2002:a05:6000:603:b0:3ee:3dce:f672 with SMTP id
 ffacd0b85a97d-4256712a5dcmr1324377f8f.4.1759488172065; 
 Fri, 03 Oct 2025 03:42:52 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ebd:e301:a6dd:d590:166e:6c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f0846sm7470005f8f.45.2025.10.03.03.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 03:42:51 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/3] fs: ubifs: Address some Smatch issues
Date: Fri, 03 Oct 2025 11:42:49 +0100
Message-Id: <20251003-fs_ubifs-v1-0-a48d4861670a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKmo32gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwNj3bTi+NKkzLRi3RRTC1PLlMS0NEtTcyWg8oKi1LTMCrBR0bG1tQA
 IyNQyWgAAAA==
X-Change-ID: 20251003-fs_ubifs-d5859daff957
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Alexander Dahl <ada@thorsis.com>, Michal Simek <michal.simek@amd.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

Smatch reported some issues in this driver including a possible memory
leak, not detecting an error pointer as a return value and dereferencing
a possibly NULL pointer.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (3):
      fs: ubifs: Ensure buf is freed before return
      fs: ubifs: Need to check return for being an error pointer
      fs: ubifs: Fix and rework error handling in ubifs_finddir

 fs/ubifs/lprops.c |  6 ++++--
 fs/ubifs/super.c  |  2 +-
 fs/ubifs/ubifs.c  | 16 ++++++++--------
 3 files changed, 13 insertions(+), 11 deletions(-)
---
base-commit: da47ddebd16a7e1047da8537fbf01558d2a89fcf
change-id: 20251003-fs_ubifs-d5859daff957

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

