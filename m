Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C65CE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:50:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 535B886C1E;
	Sat, 23 Sep 2023 21:47:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J5Bc3Rr6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4DD586BE1; Sat, 23 Sep 2023 21:47:45 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0871586BF9
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5041bb9ce51so6353956e87.1
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498462; x=1696103262; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B7MtqIBw1h8HO/NW1aPntEcFyye96y13xbjuA36M6+c=;
 b=J5Bc3Rr6ZxpRU9pvuXmD6+ENtekSMAnZgiN0PJ2QW9YIwKCac4evRIAvw45P7DqCS3
 OQB1wONtCiUZ28wmIdrLTPtvTCjSfPhW7HjdupQSv3nylR9g1hpz+1FkwifYuBWMLNiJ
 E2zJnA9xodOiGjPIydJY3LKc8urtbTtMSChQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498462; x=1696103262;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B7MtqIBw1h8HO/NW1aPntEcFyye96y13xbjuA36M6+c=;
 b=IdxK9rBa5dT2A/aCyDBx3YbyyPkVqKsFLRaf/0pSYkAdEU0WaXlpc0p5KH7DHa2eX7
 wSLn8Uz61frOxV//IMl7TSwTcpsG+wNTUlrHFfuKcEaTieyMlhcS+eF3n3SKgtmjGbac
 04zcguPLsPUpmdb5FVWT6eRICEHbBN5uVjj30dVhDZ4gG4KG4ztOuhp+rexYz6miSb1A
 DGhdmnWx1UOkvtxaXQl1mMiPsHmxnPueVsGqOGpnDnKUJ74JbeT6OEnFc0f1C8Vfqo6o
 uKkk4IJ+qi9MNCEAcvgaJO+hpuKsWJvFsLNzjhBFV1vw5agKdVMqspbwFdQriDcW09k4
 6+/A==
X-Gm-Message-State: AOJu0Yx2F8/s/UX8ZcAhMfNpxE87Mh7gGLEzRN64S1FpmWizfKsR+gnT
 WS23mqimkJotHH+CKR6b57PbkrTQYr45S/kGfrPIrg==
X-Google-Smtp-Source: AGHT+IFfBmKlWgYSRcEJjT5+W2MLoi8z8WPlHGIGpDEVdJsDBLmUeN5MVLx8hbb1BsRsfNZ1jEV3Y2KbPu7HpPJVehs=
X-Received: by 2002:ac2:5e34:0:b0:500:9734:545a with SMTP id
 o20-20020ac25e34000000b005009734545amr2132418lfg.5.1695498462246; Sat, 23 Sep
 2023 12:47:42 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 23 Sep 2023 12:47:41 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230907170844.GW305624@bill-the-cat>
References: <20230907170844.GW305624@bill-the-cat>
 <20230907160023.49339-1-sjg@chromium.org>
 <20230907160023.49339-2-sjg@chromium.org>
Date: Sat, 23 Sep 2023 12:47:41 -0700
X-Google-Sender-Auth: xDWfLZ7ax4OyI055a1LX6zW0kGI
Message-ID: <CAPnjgZ1rTVxWGh2kDSJm8GvhhD=MCAByUOnJdu9q9tKkU8-mDQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] buildman: Keep all common output files
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
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

On Thu, Sep 07, 2023 at 10:00:17AM -0600, Simon Glass wrote:

> Make a list of common output extensions and use it to ensure that the -k
> option preserves all of these.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

-- 
Tom

Applied to u-boot-dm/next, thanks!
