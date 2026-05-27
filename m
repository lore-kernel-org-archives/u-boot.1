Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D16FCD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 04:10:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBB14846DE;
	Wed, 27 May 2026 06:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rlu86dCa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CA14846F8; Wed, 27 May 2026 06:10:06 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAFC084659
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 06:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bd8faef2e18so1374775566b.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 21:10:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779855002; cv=none;
 d=google.com; s=arc-20240605;
 b=bc+9U/L3wU3F8VFw1ikV385uhT9oz+pUgsFquwGd/xOt8q5AfQ0ookcYHHR32PiKSI
 YEkkynYDD5efk6m7W4+lTrIkM/ipRPNxfCtlmUGyUWrTxixcoYmyXfqNtDD7mhu6kL5f
 JwdVMntn0ckfVB/ZNksDBk3wh4vaKSX/wQFyp57JBBy+Prrq/hopZFIq+/n1yvp350g9
 2ac7gk6mEFajjWkWdkHwAWD1iH3K3Uz586kraVyu39gec3PTNiyOsdv+wMzbQkXUF8yl
 jWYB6MhrYfJI5F65LQlWLlC0t0+RhY9jUhRVizeaBQBs86vZGBlecSpBdxW5EDhCIZ8A
 VgWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YrhN6YepkXobi4JHu99SGUvRNQeBOyaizWRQbMWOH18=;
 fh=6RH5P0FCppt2OmYognj2cnigE8IYWKkoEY1Na75/oYc=;
 b=PivqUQRAQKPMgpgMEekoTop+WobRhqbfgNpmrG66WRniZg5lZsLQO2WWtpO5jmJmxG
 2wkUGFd9Au5C1x8endLtoMeBB1dRQ7q20Imc3Fi1cotzWAdy286WYpqBqFpruGKuGSAm
 YHA0jojbt/FK7vlxC3oBkdBR5eIrvD6kHhIqnxmH3SIi574Ha+oVHjwvMCxhBNwh3EsZ
 nPfTeEPXSEgypRJ2WOegaRsBkTfqm94T3rJy5OZh4DJulNB1vEN44MFytwBqKL1CFris
 APIVtIYjVVo6mRAPVigo7CkVoZH5rK2k77kaa/BDtbh5PjqhfdaSrECcguKFBLpGKRZ1
 Syhw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779855002; x=1780459802; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YrhN6YepkXobi4JHu99SGUvRNQeBOyaizWRQbMWOH18=;
 b=Rlu86dCa4ZmPw0JIWUMdxhpuEzG9VshUmE5x4F9eGxZbYgxBOzd+F9rYPavS4nqoKU
 M7uwFlSlboT+Oy+YpKwADzDdYHGSO+/gX55xxuqhsDUyiZaMVE5xhNLX6ayLkBrWb/zi
 A5S4cMpHx2lx0X/B6plHeCv0K4AYwpu4sn/aU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779855002; x=1780459802;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YrhN6YepkXobi4JHu99SGUvRNQeBOyaizWRQbMWOH18=;
 b=ihkMZnuxbwyZwn4aEH8qQpQ1wvWfUxSYJKFGrO+9t1oPWlKPYLPObSI/gfVo/ZZSDl
 MVvJUGE8A/p+HugwRxClcX6ZQFZeStcQQ2m28AukpmZRsYcO8PtTslxgqNSLiCuu4jUM
 bmfElQncRwMQ+i9kvdK0iBq1NeQsSLMtfPfCi488P+PgJPbSalmVv29YghtcuW1hEBfV
 Z5qYhhs3exrnDgg/hahIJ9o3ta/U58wceYeRCJS+Fws2y0/ePjK8xZ/qrLAz4vKZp1f4
 1icw4bP1LwWMsNayjd+TEAn0l0T8ado4pxYJVE2/GOILd1vxJd+nHSq+HhbECNDSvvuX
 1UGQ==
X-Gm-Message-State: AOJu0YzD2A+Tdolad7g90NIFy8f5XV1IBWKAF8Pi7MlxhoD9ANyjJmnk
 KlrmeybpMxEG0uLNkfZqJnwTICBNFC3sHQYlZU7VT/0FiS/6XelXpmRrv1/bLCjzI2vC/aI2aac
 KVrnI96cp6F7AYhR704onr9de2ykd5zboNja/v6Mo
X-Gm-Gg: Acq92OHD+TzWRUlCGW+8Qfah6Uwwe0gTl+i3MT+msDrif8IGUfW6E9ktF9IEFIHNniY
 I3iueaAL2t2NhrVVstlOZvp15GQV5F5xciDY9yd+PIyU9DiePXiUazKpXzt/Dv7U2J+04kNvTZS
 MJ6sIVX+qBL+uWvUky9YUk4K4TzGh069oCpehB8G3zHzsQZxSYS/X6fyM7mIPW2ktk6xo+x/cdm
 valiG7preH4iJdMJlxDyKURbZf9f5IhN0ipyBw9jfTSXB3WFstSM202k0fduVz4a9NPxQYJJh9S
 sSX9hM8A2IbbbLTdNBHmU5Uu3AY=
X-Received: by 2002:a17:906:3098:b0:be1:4856:4f5b with SMTP id
 a640c23a62f3a-be14856837fmr462989666b.7.1779855002240; Tue, 26 May 2026
 21:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260519225458.5587-1-ravi@prevas.dk>
 <20260519225458.5587-2-ravi@prevas.dk>
 <CAFLszTijyoJ2H1kG+6T3wAccHyXFj+M+Mf1w13RU1kVc0Pweag@mail.gmail.com>
 <87cxyhg9im.fsf@prevas.dk>
In-Reply-To: <87cxyhg9im.fsf@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 23:09:49 -0500
X-Gm-Features: AVHnY4L6W-yFbLua4fPbO7UCt8rv2GbTW-4Qq2Nzcsq3sHil_Nn8qMRb4LSDaZ0
Message-ID: <CAFLszTj27Lg0ofO2YvWYm2CiJcPLbSQHUwPw-LzRR6=XR38V1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] image-fit.c: introduce CONTROL_DTB_AS_FIT config
 knob
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Rasmus,

On Tue, 26 May 2026 at 23:12, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> On Mon, May 25 2026, Simon Glass <sjg@chromium.org> wrote:
>
> > Hi Rasmus,
> >
> > On 2026-05-19T22:54:57, Rasmus Villemoes <ravi@prevas.dk> wrote:
> >> image-fit.c: introduce CONTROL_DTB_AS_FIT config knob
> >>
> >> Having scripts embedded one way or the other in the U-Boot binary
> >> means they are automatically verified/trusted by whatever mechanism
> >> verifies U-Boot.
> >>
> >> Writing those scripts in the built-in environment leads to
> >> backslatitis and missing or wrong quoting and is generally not very
> >> readable or maintainable.
> >>
> >> Maintaining scripts in external files allows one
> >> to have both syntax highlighting and to some extent apply shellcheck
> >> on it (though U-Boot's shell is of course not quite POSIX sh, so some
> >> '#shellcheck disable' directives are needed). Getting those into the
> >> U-Boot binary is then a matter of having a suitable .dtsi file such as
> >>
> >> / {
> >>         images {
> >>                 default = 'boot';
> >>                 boot {
> >> [...]
> >>
> >> boot/Kconfig     | 9 +++++++++
> >>  boot/image-fit.c | 5 +++++
> >>  2 files changed, 14 insertions(+)
> >
> >> diff --git a/boot/image-fit.c b/boot/image-fit.c
> >> @@ -1676,6 +1676,10 @@ int fit_check_format(const void *fit, ulong size)
> >>               return -ENOEXEC;
> >>       }
> >>
> >> +     /* For the control DTB to act as a FIT image, we only require an /images node. */
> >> +     if (CONFIG_IS_ENABLED(CONTROL_DTB_AS_FIT) && fit == gd_fdt_blob())
> >> +             goto check_images_node;
> >> +
> >
> > I wonder if you could avoid the goto by using a bool? E.g.
> >
> >    /* control DTB is trusted */
> >    bool as_control = CONFIG_IS_ENABLED(CONTROL_DTB_AS_FIT) &&
> >                      fit == gd_fdt_blob();
> >
> >    if (!as_control && CONFIG_IS_ENABLED(FIT_FULL_CHECK)) {
> >            ...
> >    }
> >   ...
>
> Not really. I mean, sure, I could avoid the goto, but it's not just the
> FIT_FULL_CHECK I want to skip, it is also the 'description' and
> 'timestamp' checks, so using that bool I'd have to modify those if
> statements as well. And I think the goto is actually the cleanest
> approach.
>
> The reason I didn't lift the 'check for an /images node' up and inserted
> the 'fit == gd_fdt_blob()' after, doing an early return, is that I think
> in the general case, the FIT_FULL_CHECK doing the basic sanity checks of
> the dtb structure itself must be done before we start asking questions
> about which nodes or properties it has.
>
> So I did go back and forth a little, but in the end I felt that this was
> the cleanest and most focused addition.

OK I really cannot countenance a 'goto' in the FIT code, one of the
foundations of verified boot. It's OK for error handling, but this is
no' that.

So how about splitting out the middle of fit_check_format() into a new
function that you call conditionally?

>
>
> >> diff --git a/boot/Kconfig b/boot/Kconfig
> >> @@ -103,6 +103,15 @@ config FIT_FULL_CHECK
> >> +config CONTROL_DTB_AS_FIT
> >> +     bool "Allow U-Boot's control DTB to act as FIT image"
> >> +     help
> >> +       Enable this to exempt U-Boot's control DTB from the sanity
> >> +       checks done to ensure FIT images are valid. This can for
> >> +       example be used to embed whole scripts in the control DTB,
> >> +       that can then be invoked using 'source ${fdtcontroladdr}'.
> >> +       See doc/develop/devicetree/control.rst for details.
> >
> > Please note in the help that this is safe because the control DTB is
> > necessarily trusted (any verification covering U-Boot also covers it),
> > and that only the address matching gd->fdt_blob is exempted - not
> > arbitrary FIT loads.
>
> OK. Something like
>
>        Enable this to exempt U-Boot's control DTB from the sanity checks
>        done to ensure FIT images are valid. This can for example be used
>        to embed whole scripts in the control DTB, that can then be
>        invoked using 'source ${fdtcontroladdr}'. In a secure boot setup,
>        this is safe, as the control DTB is necessarily covered by any
>        mechanism verifying U-Boot and can therefore be trusted. This
>        only affects the case where the image being checked is
>        gd->fdt_blob. See doc/develop/devicetree/control.rst for details.
>

Perfect, thanks

Regards,
Simon
