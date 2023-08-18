Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D3AC71136
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 03:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8883F86C88;
	Fri, 18 Aug 2023 05:10:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QXw/a4HM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5052186C71; Fri, 18 Aug 2023 05:10:51 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0409C86C8A
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 05:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5280ef23593so495104a12.3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 20:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692328246; x=1692933046;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SnoVr364AEeSF1Yr/E14qKhErIj075o+6SVm08JSVEM=;
 b=QXw/a4HMLgDQmCnnyyn4GPPiYVc0lf7NnCVi2UI3N0m2jdoDZEFlxV8p3hHGJ6tUrh
 VH7BavD5TlIrf9N4n4WseWSxTe+CBJf/xOSqscrDUjQU5dQjjbT85YnV4UPk/kqSfPjw
 gFP9vMuGuy7IIvkJbLeAfISxfajJ7G7HTpds4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692328246; x=1692933046;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SnoVr364AEeSF1Yr/E14qKhErIj075o+6SVm08JSVEM=;
 b=aMLb2e+nGLJWHrEmdVSC89SytebzNjVetR9rT3Ui1xybIvN+YjLG1XI0al6IDPy9ei
 fq48hJlPe+tvdPNaBc75ic8zKU74jYPIFCjGyp8rLjWNSlEIUo6/OyKO2Q+wNtKQtDB/
 U5PA+A2R7wDTiXd4sy4lSW3lDduMzv/kzm53++mfMN3FTu7h9f+uUMqUIu1lW1xpXJcc
 wA66B6YyW5wv5yukdDiOgYuXXS8wZpE/0iocnKg4+8htr4/B+n8QkPZQ+4ANJnXAS3ao
 /vACqddLOaqJf+/W4Cckm9ala8ecvf9gsTWYREF/cM6RUzsn9tXHAZbpSXaVxW11xyGh
 fVSg==
X-Gm-Message-State: AOJu0YzfxFCsbUTD2/dYm8gNcGPxK6RlYy7vF9EoFD9HloGUMK/McSBW
 eKMFG+PoGmu3GPdae5vGF3wwlJGCUkhGEw9sXqEjBQ==
X-Google-Smtp-Source: AGHT+IGXuDGg9m4hzUNkRyJeXmPImZBsF4Gqj35o/37wHuI8W8qCorVEQ5mpqS4tXWcCMMQU7rr2JWuReBcREXH3l+4=
X-Received: by 2002:aa7:de98:0:b0:525:734a:bf30 with SMTP id
 j24-20020aa7de98000000b00525734abf30mr1118784edv.36.1692328246562; Thu, 17
 Aug 2023 20:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230812002823.82576-1-seanedmond@linux.microsoft.com>
 <20230812002823.82576-3-seanedmond@linux.microsoft.com>
 <CAPnjgZ0FoQeKi4BSE=5v8ur+Ybe1V6v5QiyQ7dwuSRMTG3nRiQ@mail.gmail.com>
 <900f5906-e211-57ca-ad86-24f919b2de0b@linux.microsoft.com>
In-Reply-To: <900f5906-e211-57ca-ad86-24f919b2de0b@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Aug 2023 21:10:37 -0600
Message-ID: <CAPnjgZ2QL+V+z8zA27a1YZYS3inkxQLEMEQucRJ_N6mx6eXHCA@mail.gmail.com>
Subject: Re: [PATCH 2/5] drivers: security: Add TPM2 implementation of
 security devices
To: Sean Edmond <seanedmond@linux.microsoft.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Carlson <stcarlso@linux.microsoft.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Sean,

On Thu, 17 Aug 2023 at 17:29, Sean Edmond <seanedmond@linux.microsoft.com>
wrote:
>
> Hi Simon,
>
> On 2023-08-17 6:41 a.m., Simon Glass wrote:
> > Hi Sean,
> >
> > On Fri, 11 Aug 2023 at 18:28, <seanedmond@linux.microsoft.com> wrote:
> >> From: Stephen Carlson <stcarlso@linux.microsoft.com>
> >>
> >> This implementation of the security uclass driver allows existing TPM2
> >> devices declared in the device tree to be referenced for storing the OS
> >> anti-rollback counter, using the TPM2 non-volatile storage API.
> >>
> >> Signed-off-by: Stephen Carlson <stcarlso@linux.microsoft.com>
> >> ---
> >>   MAINTAINERS                     |   1 +
> >>   drivers/security/Makefile       |   1 +
> >>   drivers/security/security-tpm.c | 173
++++++++++++++++++++++++++++++++
> >>   include/tpm-v2.h                |   1 +
> >>   4 files changed, 176 insertions(+)
> >>   create mode 100644 drivers/security/security-tpm.c
> > This is a bit wonky w.r.t driver model. The TPM itself should
> > implement this API, perhaps ina separate file shared with all v2 TPMs.
> > You should not be opening the device, etc. in here.
> >
> > I hope that makes sense...you effectively need to turn the TPM into a
> > multi-function device within driver model. Of course TPMs are
> > multi-function devices anyway, but here you are making their functions
> > available more explicitly with a nicer API.
> >
> > Then you can call the TPM API to do what you want, but at least you
> > know that the TPM has been probed before you start.
> >
> > Regards,
> > Simon
> >
> Let's step back for a moment to understand our intention with this
feature.
>
> We want secure storage for the anti-rollback counter.  The intention is
> that this storage is provided by whatever "secure driver" (let's start
> calling it the "rollback driver").  On our platform, we're using a
> different "rollback driver" which accesses a non-TPM based secure
> storage (which we can't upstream because it's proprietary).  For the
> purpose of making this feature publicly available, we've added the
> TPM-backed "rollback driver" (this patch).  I'll make this intention
> more clear in the documentation, which should lead to less confusion?
>
> At the end of the day, all we require is dm_security_arbvn_get() and
> dm_security_arbvn_set(), to get/set from the secure storage (we'll
> rename these to something less ugly, because yes arbvn is gross).  We
> don't want to lock this feature to the TPM, because it doesn't enable
> us/others to choose a different secure storage mechanism.

It doesn't need to be locked to the TPM. But since you have a uclass you
can have different drivers implementing the same UCLASS_ROLLBACK:

- a 'stand-alone' one that does strage and secret things
- a TPM-based one that makes TPM calls

>
> W.r.t opening/initializing the TPM.  Someone has to open it?  In our
> case, it's being opened earlier with our measured boot, so "-EBUSY" in
> returned on tpm_open() (we return and everyone is happy).  My
> understanding is that this is the currently available way for multiple
> drivers to access the TPM.  Ilias has recommended we use
> tpm_auto_start(), which is an enhancement I'm planning to make.  This
> should clean thing up?  If this doesn't meet your expectations, can you
> describe in more detail how we should turn the TPM into a
> "multi-function device"?

The TPM will be probed automatically by probing its child device. Not
opened, though...that would have to happen elsewhere.

But it doesn't mean you need to turn the TPM into a multi-function device.
It's just that, in most cases, others would use a TPM to provide the
rollback counters.

For testing purposes, you should probably create a device which is a child
of the sandbox TPM2 and run the tests with that.

Regards,
Simon
