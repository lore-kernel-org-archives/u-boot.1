Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5B0E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC8368021A;
	Fri, 20 Dec 2024 05:04:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gTbyMvgC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 259C68021D; Fri, 20 Dec 2024 05:04:55 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16A4A80087
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:04:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa67f31a858so259158466b.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667492; x=1735272292; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k/zrzY9BdY9K4xdSffzLQTj/9t6mGiR/RHs4Gcd0xLM=;
 b=gTbyMvgCw/jZdF3jj1gMedyrMyCdYFaLpIuPMHqnHfCFbnvPVLFYdOfsj8se8NU+qj
 j7MLGQRU9feo4MzYyT2S2JHR1h4LA9+46V07ZZKdgb3GGoNbnzKGgRXs+O8C+yCF84wY
 hKjUt3/oNAR3aK9F1vQTknSEPj9PVy6yR7Ksg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667492; x=1735272292;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k/zrzY9BdY9K4xdSffzLQTj/9t6mGiR/RHs4Gcd0xLM=;
 b=Ifl/b4s9tHfwcIe0T33pK9Io7Fu/NXrjr4mVYQUfrDEOmgg8JWgc+GaaDLyVmxgiZ3
 +OrD+d6NKFb2VLQPQZeHwgDQHdr4xsWLiDHkETADewTpz/CRjE/roFvYPphOa/exPwBP
 mhPUFmkYGG7U+uuAT3+z8gQyRI8Eu/wSo/gr5kqbAcvR2xrws8kLx/WEAIu54Zuzp4qN
 O9T+lWja9c7r+4vjBn+N3CwkNnKLRnsb1M6RFEadNLWTmUQ6bq+oMeU5GvqpcdCu92Vl
 XHCfKuGSyYjQ0L2cNtGmZC6ppWCK9mpfOot46JA6K31y/wTJpA/2L2eUSSaerhnV8CZR
 bkmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW+VZ3r+9a3lAZSpPTuKj+2JflCTqxcPIKgn156MfILjKaqdmBMxdc4en7RTHsUM+fLNFlL0U=@lists.denx.de
X-Gm-Message-State: AOJu0YyzOFkJ6RQozo1bqlEj3hvnvLskwdSwnBuchuiPUxkRj0jIC2IF
 vbXAuyoMQhRChlHR3CpdVQxme+a08wCDHUZtBB4pd/HshjGuO1zBSKCxAw27l/ap4wqj6eYx3xm
 s2QBTWkDY3Npc1pl9vLIgh1N3NNMXuQuCdDr475OrxQpQQHk=
X-Gm-Gg: ASbGncsKZEgXVuuYU2dn+0uuQnJ6MBp9RuDFUxDhhXSaQG/OfGnVNxjxwKz0S89krJ8
 EyxM0lgLlo/1cPrehqfpX36YQtLvHPkF6qkzBc40=
X-Google-Smtp-Source: AGHT+IFWW16o7ih/Apw+dFma6WHQ6n+8xtspWGkUHjclcBpGpCPhx7HoXotDkiYEH/Z5UBs9He3havrVVLnmwDES7AI=
X-Received: by 2002:a17:907:2d27:b0:aa6:6ea7:e5a7 with SMTP id
 a640c23a62f3a-aac2ba3f453mr89753266b.28.1734667492530; Thu, 19 Dec 2024
 20:04:52 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 20:04:51 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-47-sjg@chromium.org>
References: <20241206023626.2456858-47-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 20:04:51 -0800
X-Google-Sender-Auth: MAXRvB3vd36gWgLdotjryzGGy30
Message-ID: <CAFLszTiP=Etgg7E-Khpsnz+sUNaeEwhnKC6QF+vjNg_a4Ngpjw@mail.gmail.com>
Subject: Re: [PATCH v3 46/46] bootmeth_extlinux: Refactor extlinux to split
 boot
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Add a new extlinux_setup() function which sets things up so that the
bootflow can either be booted, or just probed.

Provide a readall() method so that images can be read into memory,
without booting the OS. Adjust the boot() method so that it can boot,
after any changes have been made by the user.

Update the test to change the bootargs and check that they are booted
with the changes intact.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Pass through the bootfile since extlinux and PXE are different

 boot/ext_pxe_common.c | 53 +++++++++++++++++++++++++++----------------
 test/boot/bootflow.c  | 24 ++++++++++++++++++++
 2 files changed, 58 insertions(+), 19 deletions(-)

Applied to sjg/master, thanks!
