Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2BFCE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A3A686C0D;
	Sat, 23 Sep 2023 21:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AgKwpNRm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4273E86BE7; Sat, 23 Sep 2023 21:47:42 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 703A186C03
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52f3ba561d9so9702194a12.1
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498460; x=1696103260; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JYABJNHv15fslNgGxizOVxhjTz5U/nNT7IlYl0efZLA=;
 b=AgKwpNRmGqxRxHq+Wcrrsf0JyTEMV5dxz69mtwe4nJvbScOFLvwYuA0aX/NRLmvrr+
 pMAk0rhmlsVjYhCWnM8sFDjIez1jFGlWHwTv5OK3343xf0j4IwbKDtBZe5JIQKeWKAFD
 qwtbskSZiZEBeFbFo8h0Drj7KcC22DlNAcYAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498460; x=1696103260;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JYABJNHv15fslNgGxizOVxhjTz5U/nNT7IlYl0efZLA=;
 b=JIGmFOgKm+kAnl+sK2ZHucW+VWn26bfT6uvMKCUQd6fLOtXghrwqUw5CYV4tYukYOB
 tJ0hjtdMBhiX16fqLMjpcPKvQVjFG8EGbiRQRGhmlJv8ahXV3x+jaXvNahbuNfdYVApU
 SDACK9/pytf3cWDQz1RNA9hVBPWj5JtxMBqwfnI1l3tBn/JSJzagH57F5uASdTXxNDKp
 xrdgaQcC6/4MYK41sOo1m08x6Fzbg8tJp62N5ok29htfQZzY2jbfi+2H+HQRLvUP9u2E
 nIgArezegKne37eaqrlutgXaOmFuxuGr8D7RI7TdH9GhdJrXAcnVEzo7mggb2v52EcfB
 YjgA==
X-Gm-Message-State: AOJu0Yyjb+WUkbBW0CAWWcIiy/oZafGdv+WLSSSf61HT18ivGNAGKQsJ
 pCaFJ+MoP7VVeHF4FEpyL3xXJTXNJSv4wSz03bnAIDRl4YH0s8I5gJ0=
X-Google-Smtp-Source: AGHT+IEo/QQ3L70sZl/tKOEU1Qu1V8kpmzACpaN+btQ5kx+lINjmu1WObN3kKR+ve+Aq1x2sRrAc65RACn3N5t6/dKM=
X-Received: by 2002:a05:6402:26c5:b0:52b:db44:79e3 with SMTP id
 x5-20020a05640226c500b0052bdb4479e3mr9097874edd.4.1695498459857; Sat, 23 Sep
 2023 12:47:39 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 23 Sep 2023 12:47:39 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230907160023.49339-5-sjg@chromium.org>
References: <20230907160023.49339-5-sjg@chromium.org>
 <20230907160023.49339-1-sjg@chromium.org>
Date: Sat, 23 Sep 2023 12:47:39 -0700
X-Google-Sender-Auth: WEP5HGZIhJb6mng7aIDIhDBI4uw
Message-ID: <CAPnjgZ1ptu-r7v=AOrdgo0KzteWwgz8bYPxbk_yYNGfq7o9X5A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] kontron_sl28: Use u-boot-update.bin instead of
 u-boot.update
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Michael Walle <michael@walle.cc>, 
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

A '.update' extension does not get preserved by buildman, so change it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Acked-by: Michael Walle <michael@walle.cc>
---

(no changes since v1)

 arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi | 2 +-
 doc/board/kontron/sl28.rst                        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

Applied to u-boot-dm/next, thanks!
