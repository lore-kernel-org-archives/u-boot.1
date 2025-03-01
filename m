Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211E3C021B8
	for <u-boot@archiver.kernel.org>; Sat,  1 Mar 2025 07:00:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5BD4810ED;
	Sat,  1 Mar 2025 08:00:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YFI16tfs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73A7A810ED; Sat,  1 Mar 2025 08:00:00 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC5E2805D7
 for <u-boot@lists.denx.de>; Sat,  1 Mar 2025 07:59:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e3c8ae3a3b2so2128015276.0
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 22:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740812396; x=1741417196; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FPDnl9uJVLWguKzdnW9zUqtHWN5eeeZBjveAIgPV9ZA=;
 b=YFI16tfsq0STzU0MW2n7ePAMJdDlXKeSpiZ2xBRZ5fuuiDSw2+A7aJDkSEVo7d1rEv
 5xl1DJJ6VPwZx+VGWQQN1C26UIGGFJSY7sV3ZxgZtsz0HDqYCwrj3iF8e9g76fMDSldA
 GdS6gfF3qAli8vt9Q5sHcwEdAXbQuHilKkbiuZ/F0158ni1Cnm8BIJ2u65PsDEnJLfik
 09fToK45Ilhodkg/GFPUqC+5Xk4x7NRGhOWl2OSm79yPowSdcTX8CpB/KzFbx4rIWgHK
 DPteWQqEt9eUQyqIWFXnyUPYOcp1MKaw7PRkUhDGSxV+hZ7Sbc0R0DDOTkWuBG4v0IWc
 Nx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740812396; x=1741417196;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FPDnl9uJVLWguKzdnW9zUqtHWN5eeeZBjveAIgPV9ZA=;
 b=KA4D8hb41TgJcIeBJMv/noskdz72D0iH1ed1lDpvcSNvtvS0sYf3Ew4v6JOB+ygpfL
 sSgjDOydARGzem1vABda+7DpMAXT2cCc+DAO4eKRdwlSMgHzx5IwIqAsd1IKvJFmJrOw
 Kj//zS9CXCJjzraIf5w/u2t5dFNITxFNfqGJjbYNq3Z5c+0HFa9YfEVQ/SFXSw/2qZJr
 +6Ywrq/xJLCBqLkc5IgzVdKfMcuD3ntpA5kNfhigAxeO82qrgqv6dAYUGgumJSN9AHZR
 gwZtcXt8Lg3Fjwmk4sYCvjXhUxWFOkmbzuph1F52ZC0b/XYJ/ZTRyFz205HCXlV1uWpt
 WOyQ==
X-Gm-Message-State: AOJu0YyAJJ9U0A1dT8oGFrOfFLTbJFoLxDDScqkz6ZTGenl2sy+BQDBy
 DuDKEzLgX4rnET2uicBI5FnE7SZlpUdoKSeaAQlIApTZ/xzLx16XDWDAz+EMTWxsQISuwPO6S5d
 7txoH4F8/QpoYkj87bQejXXES2IS11GsIN8mHfA==
X-Gm-Gg: ASbGncsPNzdKPSexLemkeBNXblMJkbu4700V0EeVgT+aIjwvns3GY92PgEpryemVMli
 SxtoSFKA0YBHy+SSoJBssL83iqSmseHSUd2dzKneZDzrRzNvRS7qIDjah8jQmsV/V5d9PQLDg5I
 Yr8dSSkQBHRUXhn01Ods2xJmAw33rKB+Z5cvIxtJa3h7y25TlxB9Y8DRvsmQ==
X-Google-Smtp-Source: AGHT+IEyuspr5fg2DttJyDd65ChgsCtkiRu8NQBz4o9USZkDUPdVi0khs5Ooq/1ClAqvXkEA4wJU1gJR0kmyCIIE7RQ=
X-Received: by 2002:a05:6902:1691:b0:e60:a3c1:6ec1 with SMTP id
 3f1490d57ef6-e60b2e9b587mr7027591276.19.1740812396479; Fri, 28 Feb 2025
 22:59:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740672437.git.jerome.forissier@linaro.org>
 <fc96dd94cb39b60571b43ef80c5c89ff7999e94b.1740672437.git.jerome.forissier@linaro.org>
 <4f570bef-8409-4b82-ad6f-0e060901d7f4@linaro.org>
In-Reply-To: <4f570bef-8409-4b82-ad6f-0e060901d7f4@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 1 Mar 2025 08:59:20 +0200
X-Gm-Features: AQ5f1Jo-LaXwMvj1vlhkMlyY6XBMMldrweii1gQOlUlqInQlXCK5WPCB3ApL2QU
Message-ID: <CAC_iWj+-1aJr4dE8v0M7Fq5nxxkkq+sL6jAb1=pMVOPqtS4XPg@mail.gmail.com>
Subject: Re: [PATCH 4/5] net: lwip: add support for built-in root certificates
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

Hi Jerome,

On Thu, 27 Feb 2025 at 18:38, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Sorry for replying to myself, I spotted a small mistake.
>
> On 2/27/25 17:09, Jerome Forissier wrote:
> > Introduce Kconfig symbols WGET_BUILTIN_CACERT and
> > WGET_BUILTIN_CACERT_PATH to provide root certificates at build time. The
> > file may be a DER-encoded (.crt) or PEM-encoded (.pem) X509 collection
> > of one or more certificates. PEM encoding needs MBEDTLS_LIB_X509_PEM.

I understand that for downloaded certificates supporting both is
convenient since DER might not be available. But why don't we limit
our built-in options to DER only, which is smaller anyway?

[...]


> > --- a/cmd/net-lwip.c
> > +++ b/cmd/net-lwip.c
> > @@ -39,6 +39,10 @@ U_BOOT_CMD(wget, 4, 1, do_wget,
> >  #if defined(CONFIG_WGET_CACERT)
> >          "\nwget cacert <address> <length>\n"
> >          "    - provide CA certificates (0 0 to disable verification)"
> > +#if defined(CONFIG_WGET_BUILTIN_CACERT)
> > +        "\nwget cacert builtin\n"
> > +        "    - use the builtin CA certificates"
> > +#endif
> >  #endif
> >  );
> >  #endif
> > diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> > index 79dd6b3fb50..950c5316bb9 100644
> > --- a/net/lwip/Makefile
> > +++ b/net/lwip/Makefile
> > @@ -6,3 +6,9 @@ obj-$(CONFIG_CMD_DNS) += dns.o
> >  obj-$(CONFIG_CMD_PING) += ping.o
> >  obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
> >  obj-$(CONFIG_WGET) += wget.o
> > +
> > +ifeq (y,$(CONFIG_WGET_BUILTIN_CACERT))
> > +$(obj)/builtin_cacert.c: $(CONFIG_WGET_BUILTIN_CACERT_PATH:"%"=%) FORCE
> > +     $(call if_changed,bin2c,builtin_cacert)
> > +obj-y += builtin_cacert.o
> > +endif
> > diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> > index 14466598d7c..f24aa9c2380 100644
> > --- a/net/lwip/wget.c
> > +++ b/net/lwip/wget.c
> > @@ -288,31 +288,34 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
> >  #if defined CONFIG_WGET_HTTPS
> >  static char *cacert;
> >  size_t cacert_size;
> > +
> > +#if defined CONFIG_WGET_BUILTIN_CACERT
> > +extern char builtin_cacert[];

const as well? IIRC all the bin2 generated variables end up in .rodata

> > +extern const size_t builtin_cacert_size;
> > +static bool cacert_initialized;
> > +#endif
> >  #endif
> >
> > -#if defined CONFIG_WGET_CACERT
> > -static int set_cacert(char * const saddr, char * const ssz)
> > +#if defined CONFIG_WGET_CACERT || defined CONFIG_WGET_BUILTIN_CACERT
> > +static int _set_cacert(void *addr, size_t sz)
> >  {
> >       mbedtls_x509_crt crt;
> > -     ulong addr, sz;
> > +     void *p;
> >       int ret;
> >
> >       if (cacert)
> >               free(cacert);
> >
> > -     addr = hextoul(saddr, NULL);
> > -     sz = hextoul(ssz, NULL);
> > -     sz++; /* For the trailing '\0' in case of a text (PEM) file */
> > -
> >       if (!addr) {
> >               cacert = NULL;
> >               cacert_size = 0;
> >               return CMD_RET_SUCCESS;
> >       }
> >
> > -     cacert = malloc(sz);
> > -     if (!cacert)
>
> HERE...
>
> > +     p = malloc(sz);
> > +     if (!p)
> >               return CMD_RET_FAILURE;
> > +     cacert = p;
> >       cacert_size = sz;
> >
> >       memcpy(cacert, (void *)addr, sz - 1);
> > @@ -328,10 +331,33 @@ static int set_cacert(char * const saddr, char * const ssz)
> >               return CMD_RET_FAILURE;
> >       }
> >
> > +#if defined CONFIG_WGET_BUILTIN_CACERT
> > +     cacert_initialized = true;
> > +#endif
> >       return CMD_RET_SUCCESS;
> >  }
> > +
> > +#if defined CONFIG_WGET_BUILTIN_CACERT
> > +static int set_cacert_builtin(void)
> > +{
> > +     return _set_cacert(builtin_cacert, builtin_cacert_size);
> > +}
> >  #endif
> >
> > +#if defined CONFIG_WGET_CACERT
> > +static int set_cacert(char * const saddr, char * const ssz)
> > +{
> > +     ulong addr, sz;
> > +
> > +     addr = hextoul(saddr, NULL);
> > +     sz = hextoul(ssz, NULL);
> > +     sz++; /* For the trailing '\0' in case of a text (PEM) file */
>
> This line should have been moved to _set_cacert() at the place I marked
> "HERE" above.
>
> The reason for this hack is, before even attempting to parse a file as
> PEM format (which is text-based), mbedtls_x509_crt_parse() checks that
> buf[buflen - 1] == '\0'. When a text file is obtained via wget there is
> no null terminator. Same when using bin2c. So adding the '\0' is
> necessary.

and if we do DER only for built-in this goes away as well

Thanks
/Ilias
