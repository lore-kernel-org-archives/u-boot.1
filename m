Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4087EC3ABCE
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 03:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 582AF88D4F;
	Tue, 17 Sep 2024 05:54:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YA9Vj65w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C514F88D5C; Tue, 17 Sep 2024 05:54:50 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46A2488D13
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 05:54:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6c548eb3380so24298356d6.1
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 20:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726545287; x=1727150087; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rSdXzQoI71YcuGf5TgyYToB4DpKVkkeSPO2KnQSJLrg=;
 b=YA9Vj65weRRpqPNfVH9o0g98NCluI7siqkw4mQWv/H5YY8PkUkP0w0wHUxprLME+vR
 o4CsTtoiKuwTJ3Xzrs2AglH5B2fAdAaaIzTctzQGDO5xEt2ahnRIpw3szcPOJkk5nsNz
 GznbfQfWjk1uLV5QngUZrQfzfvk0gKE0SD3sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726545287; x=1727150087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rSdXzQoI71YcuGf5TgyYToB4DpKVkkeSPO2KnQSJLrg=;
 b=xIVM95oI+rsrDMlHClHIBkG6q9nARmv9kJW5i3HIPDd/Aaarafb9HuoEtkzhgbetBF
 VNpZ8CDknfocEsDyBizUj6kaOqlM9xR3QDxea8X4MT2t7yH0JtAER9B3IJLUFRzqiqEZ
 TCRRU8iLutos6O/AsaR6cwADHm4qNb99kOJuIauyaKF/vSCnPBAFX27HdzoofNsDprOF
 xUgPbjYt0cQOzEbAtv6W3hMcIBo8Qdke74JpCCybCGHzw3tG3vP706YAjnkLkVEelHLv
 FZ7m5mdVIbfckejrE/FScbYN81DJL7cQTZs6rJG1oCjmoFx5OlLeU9ddRG4w3JVyBKEl
 +UsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL4SLSzTSVBCoz/8EEUKdkNEifZyV9WUKVVP0c8SnNRvU6ywCIYTx7g48rdqQwuxUL/jUwg68=@lists.denx.de
X-Gm-Message-State: AOJu0YyS7pwY2H6THbrbtRwRi/174f34Abuil5YlxWEBcBVvl+hDs1AS
 2gglQ6bQHMiGRwuIKYWmZz9qe8CaZo4DaozNELSHyv0pL96yDLRRJzeozBKKXcUqIfpOFGSqOBV
 D9+N5feNhtL+UrxAo74tV1Zrk85p9E4LgUquJ
X-Google-Smtp-Source: AGHT+IHWeiy4j/X0mmnD9VQbv3A82XFgvybYyATJUfY6U1bldsBAfA7nkaqhDBxkDlPwf/zTY9bSN+TVjTSWaXywT5k=
X-Received: by 2002:a0c:f207:0:b0:6bf:8890:ae17 with SMTP id
 6a1803df08f44-6c573808998mr240414516d6.53.1726545287152; Mon, 16 Sep 2024
 20:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240902011825.746421-1-sjg@chromium.org>
 <20240902011825.746421-11-sjg@chromium.org>
 <d421b72a-eb0a-4aa8-be6e-3825c8b08da6@gmx.de>
 <CAFLszTjRSoWr0uncOdMY=6Oc4dnLP7gH2hj0BgDF67ukQEmmdw@mail.gmail.com>
 <20240916163319.GG4252@bill-the-cat>
In-Reply-To: <20240916163319.GG4252@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Sep 2024 05:54:36 +0200
Message-ID: <CAFLszTgVi7nzE2AxBb_u73r+dSWny_geSpXmNKG8NR1SQWhXJQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/14] efi_loader: Disable ANSI output for tests
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Mon, 16 Sept 2024 at 18:33, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Sep 16, 2024 at 05:42:12PM +0200, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Thu, 12 Sept 2024 at 08:58, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 02.09.24 03:18, Simon Glass wrote:
> > > > We don't want ANSI characters written in tests since it is a pain to
> > > > check the output with ut_assert_nextline() et al.
> > > >
> > > > Provide a way to tests to request that ANSI characters not be sent.
> > > >
> > > > Add a proper function comment while we are here, to encourage others.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > >
> > > This patch was already NAKed in the last version.
> > >
> > > Please, adjust the test framework if you need filtering.
> >
> > In what way should it be adjusted? I hope you are not suggesting that
> > sandbox should try to filter out ANSI characters in its assertions?
>
> Well, perhaps the pytest framework should be filtering it out? And
> again and to be clear, I can't reliably run these tests on _hardware_
> because of the ANSI characters tripping things up, this is not a
> "sandbox" problem.

Honestly, this approach (creating a problem and then dealing with it
downstream) is just not the way things should be.

As an alternative, I can send a patch to remove the code which blindly
sends commands to a terminal which may or may not be there. That would
be more correct than what we have today. We can then discuss how to
add ANSI back, with due thought to its downstream impact.

It's not great that  this discussion is still happening on a v5 patch.
There has been plenty of opportunity to provide an alternative option.
I doubt any exists.

Regards,
Simon
