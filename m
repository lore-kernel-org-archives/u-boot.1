Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B975C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 13:58:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD5178141D;
	Mon, 10 Mar 2025 14:58:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="raHsH9q6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47EB88144F; Mon, 10 Mar 2025 14:58:09 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBFF5811DF
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 14:58:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e639040ec74so1000231276.1
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 06:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741615086; x=1742219886; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NIc707JRUqzwKChfUBP0F8qgA2bPbS4fy78N5FoPt60=;
 b=raHsH9q6VsSjWLLlOfr6E3Ii5Sli1VoU7Fw+2oGWtkAt2PujBqH75XcJ8qw/pXVD5E
 rj1LsYzzcRaLFfDqJt26bBZjIBCHBqxYm4GUFeesoRgd+5VRwvrVJAdneYNXdoWJNIYD
 fzJg79FM3t4IS25glZol8G0hPbO5gg215XfWmipqz+GfTU+bbAqnjlninsJU2ApQxNFH
 rrB8jCFYSTZSQofm9PPGCdMEwh+UVZFdAo59u/9T9/S4UKC7c1yi2//S7AULhVnyv+6t
 3jQvVMtwDGhqlU2NdmZQQTUVolLWJ2eXfgLB7Ft4keS/UoeDEJYuzOlhX0b5RG0qOI6W
 thyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741615086; x=1742219886;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NIc707JRUqzwKChfUBP0F8qgA2bPbS4fy78N5FoPt60=;
 b=rQcPRoorUU+3CE0S1uNWsRYURKPXv4xnw84Jv+a74CKmKILoVnR0ly7ZaZFnY2KB9e
 mXQDasfF/YlKVgqwmYpQui+HPBwQ34LWlY8qqqcHN7/4CAXoimS4cofAVT59tiptXIDq
 UkI+p4kKsB7Y0ig8EJMCBYyXlXiNSyQxLmdAKzw5rPfy9Mql05d8PJZTTN8RrxfQ9Fd+
 YodoCcKVx58MO4NDyXNtmXG5OwffXFxPXMoGzEwt4jMJ1BQRe3TARLaJjdc9ASMoCT3O
 GpMrv0nSPQQjVlKl+rIBMP/PLUipWqH2uiOnTb1DlKdjsRwtngX/DlZJ/Sb29dlK8xiA
 MmbA==
X-Gm-Message-State: AOJu0YxR7wk5yOxipyC9nj8ZFMvQ5YlIMiyL2w7W4rBHxpO9nt1fhFyw
 Iqy62tqkXvpQhki2eEujS1H+Vzzvemoxw6aClzSZ2nivJMr/U0KSj/foHmF7XAVCiYYenITmlVQ
 keXCZYgVhyArwuo6WXsMRnmC4Ys16ZWMlwXt0eg==
X-Gm-Gg: ASbGncu6fMtzybaJ7B7/6h0eZXnRskpVCVcfqOLhxVQq8r/SlF4kXURMLMf/2XCp0ZP
 ecVmuCzmAw0GUubEBiI2rmJ2Pi508GUIQqs7mVg41TFHx9CHWtSe70z//uc4SJhEjDNddINMj4y
 pj4GbRPNaDoWEjhBi1Hbrh9Ty3DHQ=
X-Google-Smtp-Source: AGHT+IFGE3/OC2BwJdN8QjyC0tzFCkXbo484FL2y6T7IqYLiykoEg4iMDNLEKbNQYduG9jEEqjbRgTkFxkGNOMG+0uA=
X-Received: by 2002:a05:6902:e01:b0:e5e:85:a9e8 with SMTP id
 3f1490d57ef6-e636f54063fmr11928261276.5.1741615085667; Mon, 10 Mar 2025
 06:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250305142650.2966738-1-jerome.forissier@linaro.org>
 <20250305142650.2966738-5-jerome.forissier@linaro.org>
 <CAC_iWj+kn1Ah98XthW_kGmNQHjKy=VEL9kd+PjVKV9phwJeVcQ@mail.gmail.com>
 <4c723e83-5287-4c94-8859-e1c49d6af927@linaro.org>
 <CAC_iWjLbpU-1NW5YzxuEauAizjLS1iB_tjMiCBWu2tbjuf189A@mail.gmail.com>
 <684ad95c-eff2-4ed4-a305-670977eff7ed@linaro.org>
 <CAC_iWjLwbtqLmr71rqEuM2c01LNe09W7xVdZvT9XCH+ivsjd-g@mail.gmail.com>
 <baf67248-1d3d-4489-b900-e15b48ca4c1e@linaro.org>
 <CAC_iWj+FEusnb8jSkGSyLyjcM8ejJELtc1+swsTK6JKQ1+NG2w@mail.gmail.com>
 <db313ea7-8132-4fdd-bd7c-6c42feb03215@linaro.org>
In-Reply-To: <db313ea7-8132-4fdd-bd7c-6c42feb03215@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Mar 2025 15:57:29 +0200
X-Gm-Features: AQ5f1Jpx4AJKdW9VBCUhG1WDrQDKDHRUvwqCcYsQPXPFw0abXpziLFj5Cvqsr_0
Message-ID: <CAC_iWjJiLjfERkLV9KUfPhHad5KuFLy08L367UWc4Bva5PAHwA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] net: lwip: add support for built-in root
 certificates
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>
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

On Mon, 10 Mar 2025 at 15:48, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 3/10/25 14:04, Ilias Apalodimas wrote:
> > On Mon, 10 Mar 2025 at 14:48, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> >>
> >>
> >>
> >> On 3/10/25 13:38, Ilias Apalodimas wrote:
> >>> On Mon, 10 Mar 2025 at 14:13, Jerome Forissier
> >>> <jerome.forissier@linaro.org> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 3/10/25 12:52, Ilias Apalodimas wrote:
> >>>>> Hi Jerome,
> >>>>>
> >>>>> [...]
> >>>>>
> >>>>>
> >>>>>>>>
> >>>>>>>> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
> >>>>>>>> +       cacert_initialized = true;
> >>>>>>>> +#endif
> >>>>>>>>         return CMD_RET_SUCCESS;
> >>>>>>>>  }
> >>>>>>>> +
> >>>>>>>> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
> >>>>>>>> +static int set_cacert_builtin(void)
> >>>>>>>> +{
> >>>>>>>> +       return _set_cacert(builtin_cacert, builtin_cacert_size);
> >>>>>>>> +}
> >>>>>>>>  #endif
> >>>>>>>>
> >>>>>>>> +#if CONFIG_IS_ENABLED(WGET_CACERT)
> >>>>>>>> +static int set_cacert(char * const saddr, char * const ssz)
> >>>>>>>> +{
> >>>>>>>> +       ulong addr, sz;
> >>>>>>>> +
> >>>>>>>> +       addr = hextoul(saddr, NULL);
> >>>>>>>> +       sz = hextoul(ssz, NULL);
> >>>>>>>> +
> >>>>>>>> +       return _set_cacert((void *)addr, sz);
> >>>>>>>> +}
> >>>>>>>> +#endif
> >>>>>>>> +#endif  /* CONFIG_WGET_CACERT || CONFIG_WGET_BUILTIN_CACERT */
> >>>>>>>> +
> >>>>>>>>  static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
> >>>>>>>>  {
> >>>>>>>>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
> >>>>>>>> @@ -373,8 +401,15 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
> >>>>>>>>         memset(&conn, 0, sizeof(conn));
> >>>>>>>>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
> >>>>>>>>         if (is_https) {
> >>>>>>>> -               char *ca = cacert;
> >>>>>>>> -               size_t ca_sz = cacert_size;
> >>>>>>>> +               char *ca;
> >>>>>>>> +               size_t ca_sz;
> >>>>>>>> +
> >>>>>>>> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
> >>>>>>>> +               if (!cacert_initialized)
> >>>>>>>> +                       set_cacert_builtin();
> >>>>>>>> +#endif
> >>>>>>>
> >>>>>>> The code and the rest of the patch seems fine, but the builtin vs
> >>>>>>> downloaded cert is a bit confusing here.
> >>>>>>> Since the built-in cert always gets initialized in the wget loop it
> >>>>>>> would overwrite any certificates that are downloaded in memory?
> >>>>>>
> >>>>>> The built-in certs are enabled only when cacert_initialized is false.
> >>>>>> set_cacert_builtin() will set it to true (via _set_cacert()), so it will
> >>>>>> happen only once. Note also that any successful "wget cacert" command
> >>>>>> will also do the same. So effectively these two lines enable the
> >>>>>> built-in certificates by default, that's all they do.
> >>>>>
> >>>>> Ok, so if you download a cert in memory and have u-boot with a builtin
> >>>>> certificate, then the memory one will be overwritten in the first run.
> >>>>
> >>>> No, because the downloaded cert must have be made active via "wget cacert
> >>>> <addr> <size>", which will set cacert_initialized to true, and thus the
> >>>> built-in certs won't overwrite them. Or did I miss something?
> >>>
> >>> Nop I did, when reading the patch. But should the command that clears
> >>> the downloaded cert set cacert_initialized; to false now?
> >>
> >> It's probably easier if it does not, so that "wget cacert 0 0" really clears
> >> the certs. We have a command to restore the built-in ones ("wget cacert
> >> builtin").
> >
> > So right now if  a user defines a builtin cert it will be used on the
> > first download.
>
> Yes.
>
> > If after that he defines a memory one, that will be
> > used on the next download,
>
> Yes.
>
> > but if he unloads it shouldn't the built in
> > be restired automatically?
>
> If he unloads with "wget cacert 0 0" then it means clear certificates, so no,
> the builtin should not be restored IMO. To restore them one needs to run
> "wget cacert builtin".
>
> I think it is cleaner to keep the same meaning for "wget cacert 0 0" whether or
> not builtin certificates are enabled. It's a matter of consistency.

Fair enough. It's mostly a matter of design, I was thinking to limit
the load/unload only on the memory downloaded certs and always restore
the built in if present. But I think what we have here is fine as well
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


>
> Thanks,
> --
> Jerome
>
>
> >
> > Thanks
> > /Ilias
> >>
> >> Thanks,
> >> --
> >> Jerome
> >>
> >>>
> >>> Thanks
> >>> /Ilias
> >>>>
> >>>> Cheers,
> >>>> --
> >>>> Jerome
> >>>>
> >>>>> This is not easy to solve, I was trying to think of ways to make the
> >>>>> functionality clearer to users.
> >>>>>
> >>>>> Cheers
> >>>>> /Ilias
> >>>>>>
> >>>>>> Cheers,
> >>>>>> --
> >>>>>> Jerome
> >>>>>>
> >>>>>>>
> >>>>>>> [...]
> >>>>>>>
> >>>>>>> Cheers
> >>>>>>> /Ilias
