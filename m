Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE263C021B5
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 13:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AF5980F88;
	Fri, 21 Feb 2025 14:57:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D90PFLRE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0C13806FE; Fri, 21 Feb 2025 14:57:57 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4655080FAA
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 14:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aaf3c3c104fso376396366b.1
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 05:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740146274; x=1740751074; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bv15FRxwpytY7IiTGtu0cknU7+rJx6pVB30+sWEa/x0=;
 b=D90PFLREUsD68VCgmMw7AOKBAEIOP3A4xWzYu7RjnWq2uikdGvlorpOaT/bcNbNZzt
 jGXt7yI3bMLyOcgc++FbSrwSmuw2Hz9aSd2y+ZRFNrfstoVoXjz1GVZdKZBWpe1tzXcL
 G1apYY2+Q+7Lv9vTpK2/KGphl2/+xDdiedojs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740146274; x=1740751074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bv15FRxwpytY7IiTGtu0cknU7+rJx6pVB30+sWEa/x0=;
 b=Gb2A69NdieOAmh69512qpuonNGJMICbcCxLKAfBwfLQuHze4szEuEiEixdG+SeBOav
 aIPwOGE2bPV65FF+pA/hbWzkqj7Ua+hqb0znG3raoCLq/bs6m7QGfqlCbXlZO9MxNXLa
 LtQ6Q6UUB6avUH9JrSHiDcW594/XZ165lij3oKI1GbZ5HrAOnOV7ljsI8l4EJXkOLFUN
 948+XTuTVhrSIEcNN2GqUCJ2y3cukgdxh+zfYSf4AmVaa1SLqiwjdXA7301NZ/QwHYI5
 U+dkzCd6GfQcQXxxYuexd7IR7KCi4ja9O8t3cUE0j8Y+/vahevV7lxS3h6+NsIn9l+mY
 NoGA==
X-Gm-Message-State: AOJu0YzxViTebHsrwp/8X3sBamsWFhPB+x4UQL2ibyV3ysAFLAsOQCUg
 CoFCzhCKHjCghManslrscMAyDEcmVJWGA4dZPp3M9TwCzurfoBFMlFBUeW01i0QftCd31h63x/j
 dHSCVbzNn5US2WvougP/qsErv7oCLnV/qEBbT
X-Gm-Gg: ASbGnctzzAW3cj0QnvmhWz5sbofCMCSV4wC9+UtXkiDioWmMeNPHzt35Zn9SWQiNpbv
 2SSlUNxq0Z8F5Z6dVMEGLyXjDJRe5xOB36qktKryMGWGK5yfe0xjeCXU8s5Pbk+KguROgNoEnS6
 AImlUwpRtv
X-Google-Smtp-Source: AGHT+IHMswAaJQ8w7Gw7uJgqnNlK7fXQr70dchhaPOppRuSonJOWHsrX+AFvRzF18We5HXzhk08Pu2ftjnS8pPHGmOk=
X-Received: by 2002:a17:907:7808:b0:abb:4802:709e with SMTP id
 a640c23a62f3a-abc0de13481mr254454666b.42.1740146273691; Fri, 21 Feb 2025
 05:57:53 -0800 (PST)
MIME-Version: 1.0
References: <20250216204421.3560012-1-sjg@chromium.org>
 <20250216204421.3560012-27-sjg@chromium.org>
 <20250217174805.GQ1233568@bill-the-cat>
 <CAFLszTjr_oNvawcWSgAMC6EVqvTXNntg5fwjp2fm5Enhq_1m0g@mail.gmail.com>
 <20250218151224.GE1233568@bill-the-cat>
 <CAFLszTi132O0-yODOVOZ0_8HOKwA1JPn=xZBMovLma42GM+eng@mail.gmail.com>
 <20250219002526.GP1233568@bill-the-cat>
 <CAFLszThBbe0K5mz3YmkpsWUCFYXys_hp6ERyHpVqPLETntwKaw@mail.gmail.com>
 <20250219005027.GQ1233568@bill-the-cat>
In-Reply-To: <20250219005027.GQ1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Feb 2025 06:57:41 -0700
X-Gm-Features: AWEUYZnwjb5fbWm6tEv6qWY36q9YlmzhD8LZsetU8yR-2wECxTNsvnQcGs1q6bo
Message-ID: <CAFLszTiPZO5HEjCW6mCQquHa-p7P-mjiRcyKs7g0WN_jjTtMkg@mail.gmail.com>
Subject: Re: [PATCH v2 26/28] test/py: Allow tests to be filtered by role
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>, 
 Stephen Warren <swarren@wwwdotorg.org>
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

On Tue, 18 Feb 2025 at 17:50, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Feb 18, 2025 at 05:39:53PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 18 Feb 2025 at 17:25, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Feb 18, 2025 at 05:04:09PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 18 Feb 2025 at 08:12, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Feb 18, 2025 at 05:09:06AM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 17 Feb 2025 at 10:48, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Sun, Feb 16, 2025 at 01:44:11PM -0700, Simon Glass wrote:
> > > > > > >
> > > > > > > > Some test can only be run by a particular board in a lab, e.g. because
> > > > > > > > they are loaded with an OS image used by the test. Add a way to specify
> > > > > > > > this in tests.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > Changes in v2:
> > > > > > > > - Add new patch to allow tests to be filtered by role
> > > > > > > >
> > > > > > > >  test/py/conftest.py | 22 ++++++++++++++++++++++
> > > > > > > >  test/py/pytest.ini  |  1 +
> > > > > > > >  2 files changed, 23 insertions(+)
> > > > > > >
> > > > > > > This seems duplicative of the existing functionality we have, all
> > > > > > > hardware tests can only be run on platforms which configure what the
> > > > > > > test requires, in the boardenv file.
> > > > > >
> > > > > > I was afraid you would say that, and yes you are right, it is duplicative.
> > > > > >
> > > > > > With my lab I am trying to use Labgrid's configuration and not need
> > > > > > anything else. For example, the params on how to launch QEMU and where
> > > > > > to find the OS file are there, rather than in u-boot-test-hooks. It
> > > > > > allows me to run a session interactively just as easily (and with the
> > > > > > same flow) as I run the pytests and gitlab.
> > > > > >
> > > > > > In my lab, I actually don't have any Python things, apart from what I
> > > > > > added for that tftp test.
> > > > > >
> > > > > > I wonder if I could create a way to pass the env__ stuff in from Labgrid?
> > > > >
> > > > > Well, I was also afraid that was going to be part of your answer. A
> > > > > challenge I see with the way you're using labgrid is that details are
> > > > > kept there, instead. Is there some way to publish your configs so
> > > > > they're also available for reference? I indeed have been lax in doing so
> > > > > for the way I use it and so posted:
> > > > > https://patchwork.ozlabs.org/project/uboot/patch/20250217200638.356583-1-trini@konsulko.com/
> > > > > yesterday.
> > > >
> > > > Yes, that's great. It is a big help to have all the lab stuff in one
> > > > place and not being able to get things into that repo was one reason I
> > > > gave up with my local lab that used the hook scripts. Just too many
> > > > local branches and hacks, and too hard.
> > > >
> > > > Anyway, yes I'd like to get it in u-boot-test-hooks. I last pushesd it
> > > > to Labgrid 7 months ago [1]. I thought I did it at the end of November
> > > > but must have imagined it. Perhaps I could put the config files, etc.
> > > > into u-boot-test somewhere, like in a labgrid/sjg directory? Could you
> > > > give me access to that repo?
> > >
> > > I've updated the permissions and you should update the "bin/ellesmere"
> > > directory and add "py/ellesmere".
> >
> > OK, thanks, will do. Where should the labgrid config go? It is three
> > files and perhaps a few systemd scripts. See [2]
>
> Well, we have a "udev" directory. So I guess a "labgrid-sjg" directory
> and you can populate under that?

OK. I need to do another round of cleaning up things, but will do it after that.

Regards,
SImon
