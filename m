Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5FFC35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:05:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E48C81F7B;
	Wed, 19 Mar 2025 16:04:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hxyBYXMn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB3CE80FF0; Wed, 19 Mar 2025 16:04:08 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8E7982033
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 16:04:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5e5e63162a0so10304011a12.3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 08:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396646; x=1743001446; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RLb/hRBQRKSYML5DF0DoHenIMuGcyKNvvlNQOiN1Qfs=;
 b=hxyBYXMnsXsTRm0enty0y2qv4hCsvQ/ylZNbI6pTiD/XMUI6U/zBc5FIPbOGHHIxX8
 33IlQjUPJjv9JhcAPLrk5EqmTBBiXn8pbnnP+JCGkln9XqWTpVtQC0lc4BgOiEKyJk1Z
 q4i76jVErxaVHAwI3RI1IIy9At9F2bBUGuvXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396646; x=1743001446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RLb/hRBQRKSYML5DF0DoHenIMuGcyKNvvlNQOiN1Qfs=;
 b=HAhL++mVpT3Sd3iVuntsgqzBt4MSVpGVqq+9O/d1lWAVu0XO0zeNV2rIcOqrcSyivN
 U4R1+F9nvI2vHxWs02XnJHundvbGC7kBLlMvN8irC+MQe6kXpheXGJOOWX1yYgrNZE30
 btCTSTU50KoedrbcDG7Td1UEVbS0wuLdIkNwIqtHT0yAuRVw8iXBOdrwRXBLruAPpsvq
 b72MIUeI0y87xVTy21slJnjDJN/bAbZq+V76rRzT0Z+LlLTua6ItH4V4AffYNwikSu8H
 /U6ZO5M7sAe3exvrPKxGqaUJvN5F0PanELC+r1BkeYg+uTWBxyeFTR7zPF2bLPLgEcJ+
 Q0yg==
X-Gm-Message-State: AOJu0YxNuVaBVVk5GhwnVzBM4I7pv8aQ2QA/zr020w6SsbOtEcqzBqg5
 V0oFe6+ycgWe2bHMTK7omUKIFxC10EYJPwxmNfwEOLzDVrgYgMAD7QXOVSl9ILK+8c+6thGLeId
 dOXf4To/ASTpOtFCjoTXSuq4a5jB5K0x7Phlm
X-Gm-Gg: ASbGncsuW2LGRxXth81m8DpkouS+/bhSfC/CMGCvWAdur7PmfWO3qoLimhbnqjURvjD
 D42GF0KSTRdi0/chirUniVEzZnwJ1J/nByWpQlV0SkLqnLgXnn5cO90H0svy7/D8B0fqnkoeK73
 DxfUV4HUbe8vj/W3Up/kI76k6WwPs=
X-Google-Smtp-Source: AGHT+IFSRObOOWin1KuYUL4oqWBCyq2K+CkJ1ndj1MHkENmp9mi7nquQ2jDnBSfzSBs+09Wt1y9K+V66qlJItxBm6Fs=
X-Received: by 2002:a17:906:d7cc:b0:ac3:afb1:dee7 with SMTP id
 a640c23a62f3a-ac3b7dd4e7cmr359780966b.28.1742396646179; Wed, 19 Mar 2025
 08:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250319114947.2188805-1-sjg@chromium.org>
 <0bdf2e32-80f3-415f-a3b8-eecf5a4edd5f@cherry.de>
In-Reply-To: <0bdf2e32-80f3-415f-a3b8-eecf5a4edd5f@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 19 Mar 2025 15:03:53 +0000
X-Gm-Features: AQ5f1Jq-uqa0X9n4c_LyMPGlKNwLPMKItJqGNuAuoI-HcqzabAq32U1kWtJVlXI
Message-ID: <CAFLszThmVOd2G2zSHy8mNHEQ=FW7c+KNTD_XLxiQgbMKM=AxXw@mail.gmail.com>
Subject: Re: [PATCH] log: Add helpers for calling log_msg_ret() et al
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

On Wed, 19 Mar 2025 at 13:04, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 3/19/25 12:49 PM, Simon Glass wrote:
> > Logging of function return-values is used very frequently in U-Boot now.
> > Add a few helper macros to make it less verbose to use.
> >
> > It turns out that the log_ret() variants are not so useful, since it is
> > not obviously where the error is coming from. So only the log_msg_ret()
> > variants are worthy of these macros.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   include/log.h | 26 ++++++++++++++++++++++++++
> >   1 file changed, 26 insertions(+)
> >
> > diff --git a/include/log.h b/include/log.h
> > index 4f6d6a2c2cf..bdda7af570c 100644
> > --- a/include/log.h
> > +++ b/include/log.h
> > @@ -380,6 +380,32 @@ void __assert_fail(const char *assertion, const char *file, unsigned int line,
> >   #define log_msg_retz(_msg, _ret) ((void)(_msg), _ret)
> >   #endif
> >
> > +/*
> > + * LOGR() - helper macro for calling a function and logging error returns
> > + *
> > + * Logs if the function returns a negative value
> > + *
> > + * Usage:   LOGR("abc", my_function(...));
> > + */
> > +#define LOGR(_msg, _expr)    do {            \
> > +     int _ret = _expr;                       \
> > +     if (_ret < 0)                           \
> > +             return log_msg_ret(_msg, _ret); \
> > +     } while (0)
> > +
> > +/*
> > + * LOGZ() - helper macro for calling a function and logging error returns
> > + *
> > + * Logs if the function returns a non-zero value
> > + *
> > + * Usage:   LOGZ("abc", my_function(...));
> > + */
> > +#define LOGZ(_msg, _expr)    do {            \
> > +     int _ret = _expr;                       \
> > +     if (_ret)                               \
> > +             return log_msg_retz(_msg, _ret);        \
> > +     } while (0)
> > +
>
> Mmmm not sure this forced return call is a good idea, this would forbid
> us from performing some unwinding for example.

Yes, it is really only for simple cases. Without the return, there
isn't much value and you may as well not use this macro.

>
> I don't really see how that is better than simply calling
>
> return log_msg_retz("abc", my_function());

That's not the intention. It actually replaces:

ret = my_function();
if (ret)
    return_log_msg_ret("abc", ret);

I use this a lot in my code. You can't always just return, since there
may not be an error.

>
> ?
>
> If we were to keep this, I would recommend to rename the macro and fix
> the docstring because it does not only log if the function returns a
> non-zero value. It does actually return.
>
> So something like
>
> LOGZ_AND_RETURN(_msg, _expr)
>
> maybe?

Sure, longer names are easier to learn, but then it is so long I doubt
anyone would use it.

Perhaps LOG_RET() and LOG_RETZ() ? But they might get confused with
log_ret() and log_retz(), which I am actually thinking of deleting.

I would like the shortest possible name to avoid spilling functions
onto the next line all the time.

Regards,
SImon
