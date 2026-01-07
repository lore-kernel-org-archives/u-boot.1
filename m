Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2695ED0D167
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 19:02:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAC5D8405C;
	Wed,  7 Jan 2026 20:02:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Iqt93lj+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 602F48406D; Wed,  7 Jan 2026 20:02:24 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EBFF83A26
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 20:02:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-64fabaf9133so4258987a12.3
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 11:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767812542; x=1768417342; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ctjkogSk9gJ2h2ipy6NdWIgZ5c0IYZmEsp6OVIfum2c=;
 b=Iqt93lj+j6m1gXV/GegJpV20BiuZlYilE+IhElLncy2au4FUT8H3hhmi45poh4WjHl
 CI4wfSMnE+uf/d5rMTtm4hoeuWaClZGpkK1+CE2nnvMUGlgnfeiPq+ho7Ec34LkkFB62
 qc37y3wY/nHtpqSi8vfM1/9NZVeyww+qdSqf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767812542; x=1768417342;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ctjkogSk9gJ2h2ipy6NdWIgZ5c0IYZmEsp6OVIfum2c=;
 b=LWq+QL3yidYKPBCU8cK0hN9xJy6Ncrym8jRhnTMlvejuuqDsbz2CkmE+iOQK4Ngf/9
 OYALTzL9BtO4kK10PXah6crv+NtWzdCUBZDN+biXH5adhZNvCU3K7S7m69DsirlwePaE
 5j4cTXfnhJhhVVifFOG7c0DLTv2ZIW616bKgzJnt9yLPgaDpPpQY95HGBbSBRMLw3EBH
 kMD7xEWeJX/MiWEMn0oX19TRDF5qye0hwFuIhCkrPkKyJBj7Eq6yoFhRD0bbO3D0saNP
 6anpjc4wIp4hv3488SBTVdZFgPkR51hbnGZMjxgLJf8PBEaXuDLOvzGEXFYwyp4xn16l
 J+Iw==
X-Gm-Message-State: AOJu0YxREgeEaAwqd9n30PT6SWaVDFwPnTlvvsW+4OVkHPS304Q1f6FX
 3P12/KdmCwDaBSgHxCapF9iY60p7r1sHKJkyOctCH282wXAc+XW8J+5MS3e/CuvWXyvr9NM9S0K
 Ifw+FII4q9uHVWVptptSwTns4FDiUA4IQOgok2kGug3az2zwTft4=
X-Gm-Gg: AY/fxX6dbd52mxG9Eq5eO8du2DPEyqSODL/wbWUsKS0jfzO/MLl4CwCorCQUMUtlpIg
 wZDUlOnqKSbzIYUdWy4f8w3kYxx1VoxhWUFWh5zLHl43kLIOqzRLpcRCOWpDwmz+93PLdfmkPcY
 KvEcxv+Dw1QTC6N6vwK5dhZNNNAnhN8NCx3lSnruoeL1GRWn+gLgElPFIThQcxkWc/5K8asH2ym
 nYuasS2lVGusHgMjg+9GG/eFrofx8zBwiIBWIFAE9n5/IpEFIs1PXmzcv5aOFlkHFv3Ww==
X-Google-Smtp-Source: AGHT+IEEQe5N6MXWZQI2fc/aif+/HUd04tJLg+6RrZ4aozQNFVKxSRvGUvh8t8JBdxn4xMhvk0o1EVxNMrxSTMiCnCw=
X-Received: by 2002:a17:907:3e85:b0:b83:f538:c2a6 with SMTP id
 a640c23a62f3a-b8444c4d0d5mr329914266b.6.1767812541891; Wed, 07 Jan 2026
 11:02:21 -0800 (PST)
MIME-Version: 1.0
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <20260107003131.3064800-11-simon.glass@canonical.com>
 <CALeDE9OzMUm4PjymcOs_iAWWwoN+BSi+gDHXq4JvmCsB_YM5vA@mail.gmail.com>
In-Reply-To: <CALeDE9OzMUm4PjymcOs_iAWWwoN+BSi+gDHXq4JvmCsB_YM5vA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 7 Jan 2026 12:02:09 -0700
X-Gm-Features: AQt7F2rQTSVVLG_qK78k0m7uheK_IID8ujUPqJ_-mKoe69e01b49X0-FQeH9FP8
Message-ID: <CAFLszTgPoJOvryUEdx5FSkgejy4p1nYrXd5cNXU_FUaWqeNwCw@mail.gmail.com>
Subject: Re: [PATCH 10/10] x86: Add cleanup_before_linux()
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <simon.glass@canonical.com>, Bin Meng <bmeng.cn@gmail.com>
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

On Tue, 6 Jan 2026 at 19:37, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Wed, 7 Jan 2026 at 00:40, Simon Glass <sjg@chromium.org> wrote:
> >
> > From: Simon Glass <sjg@chromium.org>
> >
> > This function is not present on x86, but there is an x86-specific
> > version which is never called. Add the former, making it call the
> > latter.
>
> If the later is never called up until now why is it actually needed,
> if it's not been missed until now why not just drop it? Please
> describe why in the commit.

I'll add it to the commit message for v2. The code is:

int __weak x86_cleanup_before_linux(void)
{
    int ret;

    ret = mp_park_aps();
    if (ret)
        return log_msg_ret("park", ret);
    bootstage_stash_default();

    return 0;
}

It seems important to park the APs before booting. I think it was just
an oversight.


>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Signed-off-by: Simon Glass <simon.glass@canonical.com>
> > ---
> >
> >  arch/x86/cpu/cpu.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/x86/cpu/cpu.c b/arch/x86/cpu/cpu.c
> > index c373b14df30..f756a9ebf09 100644
> > --- a/arch/x86/cpu/cpu.c
> > +++ b/arch/x86/cpu/cpu.c
> > @@ -80,6 +80,11 @@ int __weak x86_cleanup_before_linux(void)
> >         return 0;
> >  }
> >
> > +int cleanup_before_linux(void)
> > +{
> > +       return x86_cleanup_before_linux();
> > +}
> > +
> >  int x86_init_cache(void)
> >  {
> >         enable_caches();
> > --
> > 2.43.0
> >
