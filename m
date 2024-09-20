Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EBFCF9C58
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:01:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D0FC88B89;
	Fri, 20 Sep 2024 18:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c/TQdcmw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F47688883; Fri, 20 Sep 2024 18:01:27 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1094D8888F
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6c353f2f954so15784836d6.3
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726848084; x=1727452884; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6r8mSflMlDRbJo5j2i2HQ29R7fGcHPLoi0aai202kSk=;
 b=c/TQdcmwmvgMcWPzjR+nvqpP1+FZwt3hRWeEHoFkPQXR2r924rthEM7MIUzXM1/IQf
 N8DRQ71yCPaeZDD92JsrwZIZmO5sBeP9DS9lko0SPrV4jk4LvHlCoGWpH2MEsbhftKCc
 uaaBMX7btKxTghsC4nsWr00mzzOtdwGmxitR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726848084; x=1727452884;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6r8mSflMlDRbJo5j2i2HQ29R7fGcHPLoi0aai202kSk=;
 b=cgrrQDZtCQTz1CMd5xnWeMFwHmSNwXqPZPn+zKOgnKD4Bs47t6R7w/iqd+ZAezks/j
 NKdfc1VaxXPqvt4sIowcwA8vMwoOgXxoIEjJuoTEDxhzYPJWN+dCLJqJI4f4mj8SbOc/
 Hzvi+eEtCiheRtSHq3tJqky4H5kRJlBea/HkgXCAcI9Cu9zPG9mtlDlklK6rw9vegg45
 ue9ufhUGihQYHilCxRsRf9gCC7tUioMlBXSIzKjzrJnyPpSlqQ1Z7iPmNavYXG2uom0U
 KKNBB9emta3F01NEfm0xupDXOBTaAGUo3tGjP95DS5tErNbkl0jAgeKz/e8G5i0XEPzw
 8XBQ==
X-Gm-Message-State: AOJu0Yxs1Y4LVg7Q/CH4M61lr+QKDg9KXTSTTMS4ckAq7uctnMXPdmkz
 wdjxWjYSU4W5PBHpD/pysqcOGQbZ4qvhPNGV8MzDaCyVLiTgjIkUXxdoCycqfUVvVqkcfuWsJgi
 9l3ENV2wx5jFmTzXlCEHimH2cRpMZqVp7g0KV
X-Google-Smtp-Source: AGHT+IH3u+YmR+Gs2xO3yEgZM1AvNULB+0SKDwa6GmIAH+W6KloC7ey1VK8LDWrw5VuglVsf6GooZ6rsg8MKqIALQPs=
X-Received: by 2002:a05:6214:5d8f:b0:6c5:8ed1:6c6a with SMTP id
 6a1803df08f44-6c7bd5fe09bmr37650266d6.43.1726848083779; Fri, 20 Sep 2024
 09:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240811122924.4035982-1-sjg@chromium.org>
 <20240811122924.4035982-9-sjg@chromium.org>
 <fb0358d9-9632-4222-b69c-763e7fa381b5@cherry.de>
In-Reply-To: <fb0358d9-9632-4222-b69c-763e7fa381b5@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 18:01:13 +0200
Message-ID: <CAFLszThxjd1s9YEOt+V+b3S2=ba4xuXEHwJgLh-6ykySycYD1w@mail.gmail.com>
Subject: Re: [PATCH v3 08/15] log: Avoid including function names by default
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Anderson <seanga2@gmail.com>
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

Hi Quentin,

On Mon, 12 Aug 2024 at 11:42, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 8/11/24 2:29 PM, Simon Glass wrote:
> > Unless function names are requested, the logging system should not
> > compile these into the code. Adjust the macros to handle this.
> >
> > This means that turning on function names at runtime won't work unless
> > CONFIG_LOGF_FUNC is enabled. We could perhaps split this into a
> > separate option if that is a problem.
> >
> > Enable CONFIG_LOGF_FUNC logging for sandbox since the tests expect the
> > function names to be included. Fix up the pinmux test which checks a
> > logging statement.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v2)
> >
>
> You did make some changes though:
> common/log_syslog.c wasn't patched in v2.
>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Ah yes, I fixed the v3 changelog in v4 [1]

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20240822135503.2363706-8-sjg@chromium.org/
