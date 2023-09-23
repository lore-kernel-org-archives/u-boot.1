Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC720CE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 18:13:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDA168692B;
	Sat, 23 Sep 2023 20:13:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h7qRSFF/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F05B28469B; Sat, 23 Sep 2023 20:13:49 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5DF08469B
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 20:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-533c4d20b33so2264622a12.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 11:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695492827; x=1696097627; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zkVfLHiW4vGg7BTUXMyadAwzHXNZ3SA4Ne/lAD2XG9c=;
 b=h7qRSFF/ONTjFZojbeVVH2F1yS2cjogwbH48WWMw7FWzb7WfJFYImU2DjE+8TGIRVI
 AvBWaQRtZ/RhoIXLF4xeNzyh8oUM8mOY2vLYFemnibsMjjpvG/8h7r+B7i1HRIB9TTfe
 1iNyy03ekJNaRq5NW4AywdqczTU3ZrQQ5a9Jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695492827; x=1696097627;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zkVfLHiW4vGg7BTUXMyadAwzHXNZ3SA4Ne/lAD2XG9c=;
 b=fOzWJtGCRZ1AWtwdTb1bLaFEOkvO3p+cOKm+OftueontrxvBJhPofsXEZy75ikFpA5
 TzJivZiTX9l9slubsd8+CKaFpVYR5Q4CJrCiwa1mjwrc2v36+wu5RFxBrJJY/SkAwc+W
 pXgYz+EJdDzrse8fHx+wKlD4wbAei8xI6j1xq3ZDwdDSnlkj4U5jk7t++gCguJf0VSqW
 yfotI7gK/41YXgSQraf4HSqzr1L9ZOLAFKOnDxTrghjFXH1pUloKRZ87/dOPOFQ30kkn
 JWkNtyEqEzBrcZE7+qUeUwmXDjRr837zM6bSK/+qWf0MCKsnceL4UqwW2/kHWSUFAWg4
 RzjQ==
X-Gm-Message-State: AOJu0YzJ7uCfKh6wAVKjuCGFvvEn8VGVNlCR3F2WpgCg+td4+Nf4cwhG
 awAoikZ4zUZ6VNxO695EzZjxi3ihojxVaAiZRfWmcw==
X-Google-Smtp-Source: AGHT+IEDRnj79i0OX80wGy/QqVplV9bydHA4OL4b20/BpcKj0Fq5er7mb9tsrLEriXqnSY0trzUVs+zVlcuY/qFix/0=
X-Received: by 2002:a05:6402:291a:b0:533:dd4d:2941 with SMTP id
 ee26-20020a056402291a00b00533dd4d2941mr1406752edb.16.1695492827239; Sat, 23
 Sep 2023 11:13:47 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 23 Sep 2023 11:13:46 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <691dad64df80993ca4cfb6d0e33964ed26f50bee.1694779918.git.michal.simek@amd.com>
References: <691dad64df80993ca4cfb6d0e33964ed26f50bee.1694779918.git.michal.simek@amd.com>
 <cover.1694779918.git.michal.simek@amd.com>
Date: Sat, 23 Sep 2023 11:13:46 -0700
X-Google-Sender-Auth: bzbvlC8iC-Kv7ShJeUwY4aDPdfs
Message-ID: <CAPnjgZ1hf68F3YKTp1p3ruTG2vhgg+F=rn3=2DTZCTTTWnQeUg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] trace: Fix alignment logic in flyrecord header
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
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

Current alignment which is using 16 bytes is not correct in connection to
trace_clocks description and it's length.
That's why use start_addr variable and record proper size based on used
entries.

Fixes: be16fc81b2ed ("trace: Update proftool to use new binary format").
Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- s/start_addr/start_ofs/g'

 tools/proftool.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

Applied to u-boot-dm, thanks!
