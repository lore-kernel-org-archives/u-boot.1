Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE88AC3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:21:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BC1788871;
	Mon, 29 Jul 2024 18:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I8pxSCYt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BD1188842; Mon, 29 Jul 2024 18:19:34 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08C5F8882D
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:19:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b5dfcfb165so20302106d6.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269971; x=1722874771; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CZR5u2TX4S6IfF/VIODFuUgBatEYef4Rkm1J7FliZgs=;
 b=I8pxSCYtmVTVD1J+aMaQTP3d1y6pODuNHHq7JbMZpLsYMwW0YFbHQgpmfC7RO0UptP
 owj+O05ETit6spLQJ0oUrGik0qirmtqLqAeNIJHIDU5G+HR25n4BedCFwIKs68gJF2fX
 x4ipKaMbFajNbrdssNPcThlC2lZtDtQHk7NDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269971; x=1722874771;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CZR5u2TX4S6IfF/VIODFuUgBatEYef4Rkm1J7FliZgs=;
 b=XSNbphdtH7j2+6f7ferxvPAUXF15nZOViifiIf8t3a/8kPW/QCnmws/8VR5+qIzeVM
 d/srN9evilLIBHZ/M7sZpn5rUBrUSclqf3g+HJFvVvD+Yg2xWOW8GJuum5LPrZg96IVH
 F6bMEwBqhHwqyFDTtPrWADHILt/tekX1KcSEqYOdKSTXmVYA9ufRTc+KKmvBGk4zsK2s
 3xhTk1IpvcpLV+QzsqglGB6urILVSsDteLYcDm5jpdjC5x7UDTlYm8Zs2FuEDy6uJNxf
 boDD9fq+jVqG4kuLdzeIdcufACJpogZasHVSin1FdNT7sKvcrrEZpFJyejI/oy6Z20UO
 YK0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdb0BSD78yGTbMZLt87DNt7Ubb4+OHWtEHCsZKyJNtE3J/uYDA00NhGNv9Q2DzBVjASWQzZ+T7XFwjtvaOAlaThqfFFA==
X-Gm-Message-State: AOJu0YzB7RXU6lHopXtV09GU5wNIGnFYlI/lE3LVbUzGeqTJ1WyU2VfN
 tYlxelosIvS/2+Pt9jUqi/5RUbznKm+VRDuo3SDDt9eSjNxrBp/s9QJACDp1GPCtqmgJ7Wv/Iyt
 zBDs+Bk2aqXITrKyQaZ61UG9XbVRnthWNxw2x
X-Google-Smtp-Source: AGHT+IGsdSdje9buunPpj4he4BbP+q65Rx0ncComqJBN3yLLrmQCgXWXWL1mFCClD482dz+BSYMeF0JObMELeeDRcQI=
X-Received: by 2002:ad4:5fce:0:b0:6b5:df48:bc6e with SMTP id
 6a1803df08f44-6bb55b156b3mr113689096d6.39.1722269970927; Mon, 29 Jul 2024
 09:19:30 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jul 2024 09:19:30 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240720104950.2730773-12-sjg@chromium.org>
References: <20240720104950.2730773-12-sjg@chromium.org>
 <20240720104950.2730773-1-sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:19:30 -0700
X-Google-Sender-Auth: jXcudLz3Rl1tqp-0GfmHbE9ss2E
Message-ID: <CAFLszTjEELxgEBGdqLEMOM8VGCQZB8FKPUr3pfLDLDchyCMF4w@mail.gmail.com>
Subject: Re: [PATCH 11/20] binman: Correct indentation in testSplPubkeyDtb
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Lukas Funke <lukas.funke@weidmueller.com>, 
 Marek Vasut <marex@denx.de>, Neha Malcom Francis <n-francis@ti.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
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

This function has strange indentation. Fix it.

Fixes: 8c1fbd1f607 ("binman: ftest: Add test for u_boot_spl_pubkey_dtb")

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/ftest.py | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

Applied to u-boot-dm, thanks!
