Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE234C83F3F
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 09:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B762386915;
	Mon,  4 Sep 2023 11:22:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sxt+LVo/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A2EA86500; Mon,  4 Sep 2023 11:22:28 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A08AF868AE
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 11:22:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52a0856b4fdso1597279a12.1
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 02:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693819345; x=1694424145; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sEy8BLjZMhdH0v3ORBUnOVtNiHTbtuAjOBgsjGkEcXM=;
 b=sxt+LVo/7OmmELtbDGZHiG75wPfG3hlUbyGP924w9l/d6m+P8f3s/6fe+ba56ETj1e
 Um1n7nnW5uu5HjEsNFwBw0BlMJaV/Om6cPCejOBbax16al2A4TfBSYeHmcYyQW6iG9BW
 EN38YAiT3zvFOVi5049K3KTwF+ellXF7HsqpSsu0ZiipQv53+wl03h7CgTygTTGmYACR
 pY5hzaddMFzRC7HOge0tWnCoPwTC/xOCpTVGpjiF4MwryED0RfU/t1w1+X/o4QiOjOAD
 LOB462b+2dG7LH+yby+qk9QuIFMM9eikFyTT6I/8T0YRk46Uup3Xxsqj+qbgajXrfiop
 A/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693819345; x=1694424145;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sEy8BLjZMhdH0v3ORBUnOVtNiHTbtuAjOBgsjGkEcXM=;
 b=agwhChitYoEnF6GObESQFa3X8/BcuPtSBbeg5+YPWyjlbCTseX6CxZARx+kWcPwSLr
 gG5enO57DFZcvNLHuUmzu7YeW2+SGsowowawRvT4dGMkVQXYDmEja5U3LCrF/9IAPoeU
 VJYEEWtXhfyALXz7p95qZpUyb9WTUoBywYo8O1Zoj4AP780PNnTYXLnkL8B3vWBK8UX3
 VnfmLIpVcyWH7VAsB0V7teTcZKSPg4RaR9bi6+m0yq9GrKBSmlL/wL/LO1rfbPJvdWWS
 jx8xvV2Ay3utUwtsn4zD9jzFI6xW6vNfN8B8dV/kucrBCqjZL7Y0uSkqn6PWS245WVkE
 MuoQ==
X-Gm-Message-State: AOJu0YxwB2e0Z/1lQBD2t+iFtWDahL7Z6J93T9+Km8erBQ+figJTgOrF
 Zapvzgngd80IOflbInpB0YkxiotN0rPpVQcJvVc=
X-Google-Smtp-Source: AGHT+IGGnakUV9a4cLopVX9Pct1SzB6x56WCL606khXzH9UUbAKbaGsOSE0Nw4nsa4ZhXh1Kc4h6wwag+NVX63alq7s=
X-Received: by 2002:aa7:d316:0:b0:52c:164:efe5 with SMTP id
 p22-20020aa7d316000000b0052c0164efe5mr6492895edq.39.1693819345219; Mon, 04
 Sep 2023 02:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230823184746.842091-1-sjg@chromium.org>
 <20230823184746.842091-7-sjg@chromium.org>
In-Reply-To: <20230823184746.842091-7-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 4 Sep 2023 17:22:11 +0800
Message-ID: <CAEUhbmVYRm0rHNkGj4TDR3NcGeOQY9iAqSj3JByx_cDg1FxC6w@mail.gmail.com>
Subject: Re: [PATCH 6/8] x86: broadwell: Set up MTRRs
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Simon,

On Thu, Aug 24, 2023 at 2:48=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> The current condition does not handle the samus_tpl case where it sets
> up the RAM in SPL but needs to commit the MTRRs in U-Boot proper.
>
> Add another case to handle this and update the comment.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  arch/x86/lib/init_helpers.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/lib/init_helpers.c b/arch/x86/lib/init_helpers.c
> index 60a2707dcf1..bf0c921577d 100644
> --- a/arch/x86/lib/init_helpers.c
> +++ b/arch/x86/lib/init_helpers.c
> @@ -15,7 +15,8 @@ DECLARE_GLOBAL_DATA_PTR;
>  int init_cache_f_r(void)
>  {
>         bool do_mtrr =3D CONFIG_IS_ENABLED(X86_32BIT_INIT) ||
> -                IS_ENABLED(CONFIG_FSP_VERSION2);
> +                IS_ENABLED(CONFIG_FSP_VERSION2) ||
> +                (IS_ENABLED(CONFIG_TPL) && IS_ENABLED(CONFIG_HAVE_MRC));

So this combination is only for Samus TPL case, not a generic one, right?

I hate this as it's easy to break. Maybe we should be calling an API
from the board specific codes to determine whether we should do the
MTRR programming. Thoughts?

>         int ret;
>
>         /*
> @@ -23,11 +24,9 @@ int init_cache_f_r(void)
>          *
>          * booting from slimbootloader - MTRRs are already set up
>          * booting with FSPv1 - MTRRs are already set up
> -        * booting with FSPv2 - MTRRs must be set here
> +        * booting with FSPv2 or MRC - MTRRs must be set here
>          * booting from coreboot - in this case there is no SPL, so we se=
t up
>          *      the MTRRs here
> -        * Note: if there is an SPL, then it has already set up MTRRs so =
we
> -        *      don't need to do that here
>          */
>         do_mtrr &=3D !IS_ENABLED(CONFIG_FSP_VERSION1) &&
>                 !IS_ENABLED(CONFIG_SYS_SLIMBOOTLOADER);
> --

Regards,
Bin
