Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADF2CCD183
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 15:12:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D938D83835;
	Mon, 13 Oct 2025 17:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZJMcMENx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C2088398C; Mon, 13 Oct 2025 17:12:16 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 191EE8382A
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 17:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6399706fd3cso6375570a12.2
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 08:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760368333; x=1760973133; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6e7yEtsJ7IADg5BL9xja26puuuYtNWfJpS5WDXB7PKU=;
 b=ZJMcMENxLjq/ZtZbdgMQ/f3Lx+ZpsDAamrJyX6qsJqXwi0vcnxfW93WC4FaRHoQK1x
 fZXPCowG1wV1TfGtTpB4UbU6GPN5ptumkk1sZM2H8y4+KOFFM6xk1SP9RuhVLftbCDxr
 Z1ou3Yd2uvh3dYED8nRDzXB7D/mHtp4MnU0uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760368333; x=1760973133;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6e7yEtsJ7IADg5BL9xja26puuuYtNWfJpS5WDXB7PKU=;
 b=L5hXQ8irUHWQl69qQyXOLjq1GbyxRvbcXcJDsYYIJFik8fM+6HGOVrZ9BdAwbfKA/8
 sqCHMwWeJlUsOouWe2PxPUDRDcYmqOImV4B2VRyjK5jmnAHJercV1HfvakZVqX5v5VJI
 jHPEHD+T/SfUmyOIvafhKo5MOSHShwBm7DeuyQouQceNrHT3xWY3+ti7HmiFdHTIrCfi
 jM/Lvcf7TCwhtKe9NJFa0MnecMCKwGJUb4h4Z5jodrwq2pPV2cU2eH8ZjOUg4QfgQSUc
 xIKzkthVc1RGAcTPWsYB1RPwkPd+QEHqbqGVwJ8/GyAgZ/OROJ0mjPH41yofkYuZ03po
 zfnw==
X-Gm-Message-State: AOJu0Yxb/6yXHMSnkd+8JlHj+NlLYbFUvAYg2ihqG+BNnX9ztSnzEJMj
 grgCfb6FU5FqvZaL8Ct25Fr/5g/8YiBghc3yF1Yod1SixIoVZF30g/I2cYAJ7jYMNhN7s9sQyhX
 v++clZzBULfbvrRLGFmLximz6A7LIgfnldaHcBuwP
X-Gm-Gg: ASbGncvX7Z55HRPhquG95tBd7PFf0ymq9Q9ypxK3O9zhRX1o0/nsNEVsp8pwpMuXJ27
 JqorUBDESvJv6pbCbMoFiXjeiZPkOrQ+6WLPe9FoILz9+kzev65oxoiV+UKnrAqKYRcX4wXkgtD
 auBXXvD/ZBWjYUUV+HcoEcOjl0BlcQ5iCI9TvdvJOjvmUtLRRoPSISfRhgwtinE4us7Mx+WVvBw
 5Muo5Ljw16vXbnAetZ3XkQ+InwdTHYkMWSDsxBIKXfKg9lPd5WOeTXDu04Pj6sO1v14yg==
X-Google-Smtp-Source: AGHT+IFSZq9YJFtYlhReOJvjpQ3sAYhplryFYDPcWQ7FtbPBmBeHiEULmThsDSGtmB+aaMTT5WONKudGyCCq2S2FS7Q=
X-Received: by 2002:a05:6402:3589:b0:639:fa9e:3602 with SMTP id
 4fb4d7f45d1cf-639fa9e3a99mr15379224a12.35.1760368332553; Mon, 13 Oct 2025
 08:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20251012064412.2892979-1-sjg@chromium.org>
 <20251012064412.2892979-3-sjg@chromium.org>
 <20251013141339.GC6113@bill-the-cat>
In-Reply-To: <20251013141339.GC6113@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Oct 2025 16:11:59 +0100
X-Gm-Features: AS18NWCom47EwhyHkxKXS7BDfbCew5Rh1Lig7S8eEkE555j1j6PJpZ3gxS379Jg
Message-ID: <CAFLszThGU4_+=jUc09HvZSMpk3XyMuyXv_hquY=dTRECS2xOYw@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] boot: Move obtaining the label into a common file
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
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

Hi Tom,

On Mon, 13 Oct 2025 at 15:13, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Oct 12, 2025 at 12:43:54AM -0600, Simon Glass wrote:
>
> > The 'bootflow list' command supports looking at the EFI device-path when
> > available. Move this piece into a common function so it can be used
> > elsewhere.
> >
> > This updates the output from 'bootflow list'.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> You were supposed to drop this patch since it was only needed for
> another patch you have dropped. Thanks.

Oh I didn't know that. So in fact are there only two patches remaining?:

boot: Move preparing bootdev into a function
boot: Improve comments related to global bootmeths

Regards,
Simon
