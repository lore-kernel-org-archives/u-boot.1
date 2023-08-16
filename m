Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635C2C001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 11:54:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C9838620C;
	Wed, 16 Aug 2023 13:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uJLniX5A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D305C860F1; Wed, 16 Aug 2023 13:54:42 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E09798638B
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 13:54:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4fe15bfb1adso10392204e87.0
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 04:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692186879; x=1692791679;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8pmF3g35zoQ6MiDOecTgaCHkXXgbV9yZDh/yj5Kbk+o=;
 b=uJLniX5A50NEkyNZPOqqs3P/VXANaOaMJ9zKxtpp1/OVxpvawET88W6x6XXGnQz0r7
 GkLvllgiOi9XBkXEOSrPmg7uAmXjK5hn4jpzH5Oc/fQhv15q9OLD5rxAHcSB9Kl2s0Ry
 n7Lff9581eGGKEDSP8kTFlwwA1WAPAYrnqnlCdGFvBh9LQ+U2LvyY2tI0Ti/Kuuuhgnf
 lICnZi5llnkhlrhuPj2rd5Fjl5bF/EKXxlQR+mkamATt+JeZagobb987dwD1yrgcK3L6
 ffLRLBxsQP4+ZgwkPX0733hAcQaIaxSBzerAfoqi8jNNunSf7d2ui/PipFnL1svi6lMH
 36ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692186879; x=1692791679;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8pmF3g35zoQ6MiDOecTgaCHkXXgbV9yZDh/yj5Kbk+o=;
 b=SjoL2KQZ47x/L0nZs/MPSTaQ0e9ub+2KvPbArxWGhTkCcJMuSMwOhnbbm/zgIJzcnf
 xapvILFpy+VHPSjbO6zM8G3VJSuT3M6mDp7xXaF9m0NRJhBRh+/tQngyXddXevepF1rU
 1/rtQxITTIq4qIV+y+7XsTQIRdfKAe/tQSFZpsAXwN+HiVIi8RbFAK+/CtDvwwJdszrv
 tSaEYRj2GprTNUObtS5sKc6yBZY/oLizPXpqaVCN0HwcDHGKa2PPc+Bpfo6Q7NdBAeop
 ChjC6awCRaXc/NWmlc0oMikeV/TWX/q1Te3CMdyfHozsJAecw+pAwdqWD8mfcpUOBDYY
 4oeA==
X-Gm-Message-State: AOJu0YxvEeClOHg09RFxUSrkZfH+G1ZMWONYZ2uAlnE9cTtdlx72f/2h
 OU4yeIrCn4Axb7+3g5KklZrVuqN0NPRPwsCectWYtg==
X-Google-Smtp-Source: AGHT+IE7E7KLmSfwW4oL/csG5qG1udnpF73nsL4nyawKw75tDjbU0C6Dz8t04i17cnRZU5Biv+BqeNQfaRg7umR9bF4=
X-Received: by 2002:a05:6512:3e19:b0:4fb:8ee0:b8a5 with SMTP id
 i25-20020a0565123e1900b004fb8ee0b8a5mr1834149lfv.46.1692186879040; Wed, 16
 Aug 2023 04:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230814133253.4150-1-maxim.uvarov@linaro.org>
 <20230814133253.4150-4-maxim.uvarov@linaro.org> <ZNo3+qhKIEqmdMTh@hades>
 <CAD8XO3a-C1oiZdcy_sk0DOzKwPEq7pBW6CsDeSHM-bmLE=RXHA@mail.gmail.com>
 <20230815144249.GM3630934@bill-the-cat>
 <CAC_iWjJm=95uNW1y=FLkEyMpcubYa29ZLM_CZooPRT8mt+jWVg@mail.gmail.com>
 <CAD8XO3a2euUOpM-JHN2p3taL=Eh=-51wyjkoDNqNFmX6pvNXfQ@mail.gmail.com>
In-Reply-To: <CAD8XO3a2euUOpM-JHN2p3taL=Eh=-51wyjkoDNqNFmX6pvNXfQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 16 Aug 2023 14:54:03 +0300
Message-ID: <CAC_iWjLXDCCx6oksQgOy+OBrrVCWwJkRMbEo8+gr0btdY5D6Jw@mail.gmail.com>
Subject: Re: [PATCHv6 03/14] net/lwip: implement dns cmd
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de, 
 pbrobinson@redhat.com, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 goldsimon@gmx.de, lwip-devel@nongnu.org
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

On Wed, 16 Aug 2023 at 14:01, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
>
>
> On Wed, 16 Aug 2023 at 16:26, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>>
>> On Tue, 15 Aug 2023 at 17:42, Tom Rini <trini@konsulko.com> wrote:
>> >
>> > On Tue, Aug 15, 2023 at 06:42:14PM +0600, Maxim Uvarov wrote:
>> > > On Mon, 14 Aug 2023 at 20:19, Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> > > wrote:
>> > >
>> > > [...]
>> > >
>> > >
>> > > > > +/*
>> > > > > +* This function creates the DNS request to resolve a domain host name.
>> > > > Function
>> > > >
>> > > > You need the name of the function as well.  Please have a look at how the
>> > > > rest of the code is documented.
>> > > >
>> > > > > +* can return immediately if previous request was cached or it might
>> > > > require
>> > > > > +* entering the polling loop for a request to a remote server.
>> > > > > +*
>> > > > > +* @name  dns name to resolve
>> > > >
>> > > > @name: etc
>> > > >
>> > > > > +* @varname (optional) U-Boot variable name to store the result
>> > > > > +* Return: ERR_OK(0) for fetching entry from the cache
>> > > > > +*         ERR_INPROGRESS(-5) success, can go to the polling loop
>> > > > > +*         Other value < 0, if error
>> > > > > +*/
>> > > > >
>> > > >
>> > >
>> > > Is there any command to check all the files for the comments style?
>> >
>> > I suspect if you included them in docs, htmldocs/etc would note
>> > problems, Heinrich?
>> >
>>
>> Yes 'make htmldocs' blows up on errors, at least for the EFI subsystem
>>
>> Cheers
>> /Ilias
>
>
> O! Ilias thanks for the reference. First patch for doc/develop/net_lwip.rst needed direct references:
>
> .. kernel-doc:: include/net/lwip.h
>    :internal:
>
> to force Sphinx  to generate docs for these files. (as I understand for .c files it does checks and for .h files it generates docs).
>
> Without specification syntax is not validated. It will be good to do something to check all U-Boot .h files for the common syntax later.

You need comments that look like this
  /**
   * parse_event_log_header() -  Parse and verify the event log header
fields
   *
   * @buffer:                     Pointer to the start of the eventlog
   * @size:                       Size of the eventlog
   * @pos:                        Return offset of the next event in
buffer right
   *                              after the event header i.e specID
   *
   * Return:      status code
   */

Cheers
/Ilias
>
> BR,
> Maxim.
>
>
>
>>
>> > --
>> > Tom
