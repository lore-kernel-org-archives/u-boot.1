Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA22C83F0F
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 12:18:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A50588C09;
	Thu, 29 Aug 2024 14:18:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kGVkwp3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1BBB88C03; Thu, 29 Aug 2024 14:18:05 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B76688B86
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 14:18:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7093abb12edso394715a34.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 05:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724933882; x=1725538682; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k1DmfVvlKIGIfX+kV6e1Df8r2btMOjK8uhdtTnkwuRg=;
 b=kGVkwp3HyX1Z/YTtGZVODdracB0zSWifNYEf0towH0LoMOgr0LFRkgzPjhAUpVy5IM
 gBDR5f68D/eVUHg9xQ4DSIyv2clSPwiadlZ1AE4qxjd6SZ9yXOY8V6D+c8v2nd5WLX8O
 KvH/ljY7vN6eBfN5s4TqceRkfjQzLKsXF6oxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724933882; x=1725538682;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k1DmfVvlKIGIfX+kV6e1Df8r2btMOjK8uhdtTnkwuRg=;
 b=NRVgUy0ihFVznvi6vp4XLqmnBiuDCx+EHS7acJtV4MTkL5xQEUm89u1iibJF7D5InW
 LjXWIfu9UKv1VrDFILrvxv6q500u4zYupnyl3Q7W5Eikn3j3pCU7Usy9c0ElPV9UkF7a
 7wPCThaUGzJhd7M0twF6AUgFfd71QJYNOu9BTQBp07PR1D6AqyxrG/D5geCNMrItymLz
 fSwB+a6ZZ5qsiW7KuzRSD2jv2W5591Efg1AeJCQSRS9D+3zN+k6oAxBySjoA1Pfw7NM7
 Fkf9blZ6zNMV7OGZGC/AjUMiEurSzkPP0IdugEGL+QeK4PGdqPH/qaGKPIZIjCFkXhMC
 ijnw==
X-Gm-Message-State: AOJu0YyHmihKmejFx67u8pDga4GEULOvJ6q+7x64LZL2Tz8ZbSBp52hR
 xROJKWjhrxyFIhHYxHKpAIGSjdV32/LmT2Y6GKWy3SOOmp+IVUQRzu+RMLhPyhnEQaTV8oH9p2U
 2Vhmh5ntBM5DN1MbcnoFrXyUZ5XSBBz/wym2RbKp4rPhwFjw=
X-Google-Smtp-Source: AGHT+IFxeqFloOH5VPs+Z73dIpw7pb5ah6iyPO340oWWJ9H/O1vEOGX9JkwfIUL306p2IYL7rbxqTPOzzArYvGUHNIw=
X-Received: by 2002:a05:6359:4c10:b0:1a5:6b71:dde6 with SMTP id
 e5c5f4694b2df-1b603bebb88mr360126455d.3.1724933882036; Thu, 29 Aug 2024
 05:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240828164523.125770-1-sjg@chromium.org>
 <20240828164523.125770-4-sjg@chromium.org>
 <CALeDE9Ptr0Ln4H24yMqxuw1+E_Wt5qBGdQabUH54PaYUTPf9Yg@mail.gmail.com>
 <CAFLszThK_t5EwL28vnzmSp5UZQrSEpBRsaXhnNudMQRe8-7Ejw@mail.gmail.com>
 <CALeDE9O-kmnqkosThf8xQpLZ2tEebiHvrUEzVJNDjiEff2-t2Q@mail.gmail.com>
In-Reply-To: <CALeDE9O-kmnqkosThf8xQpLZ2tEebiHvrUEzVJNDjiEff2-t2Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 06:17:51 -0600
Message-ID: <CAFLszThD=Haj4M5rUYfpjPDjr9JEOPygQb9tV36frcAM5Ey9tw@mail.gmail.com>
Subject: Re: [u-boot-test-hooks PATCH v4 3/3] Provide some basic scripts for
 Labgrid integration
To: Peter Robinson <pbrobinson@gmail.com>
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

Hi Peter,

On Thu, 29 Aug 2024 at 04:43, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Wed, 28 Aug 2024 at 22:25, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Peter,
> >
> > On Wed, 28 Aug 2024 at 12:14, Peter Robinson <pbrobinson@gmail.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > > With Labgrid we don't need to specify the various methods, except for
> > > > the console, which simply calls labgrid-client.
> > > >
> > > > This allows supporting any boards in your lab, without adding per-board
> > > > configuration to these hooks.
> > > >
> > > > Provide ellesmere files as an example.
> > >
> > > What's ellesmere?
> >
> > It is a lake but also the name of a computer.
> >
> > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > Changes in v4:
> > > > - Support pytest fully with dual-build boards like Beagleplay
> > > >
> > > > Changes in v3:
> > > > - Update scripts for latest version of Labgrid integration
> > > > - Add poweroff.none and poweron.none
> > > > - Provide -n flag when querying board info
> > > > - Target the grpc version of Labgrid which is now in -master
> > > > - Update README to cover the changes
> > > >
> > > > Changes in v2:
> > > > - Make use of the common script (only) to set bin_dir
> > > >
> > > >  README.md                    | 50 ++++++++++++++++++++++++++++++++++++
> > >
> > > Maybe that should be in a separate labsgrid readme?
> >
> > My hope is that Labgrid becomes the normal way of running these tests,
>
> Generally I agree with automated testing platforms, I think <insert
> you're preferred platform here> makes sense, there's a bunch like
> Linaro and a bunch in the arm ecosystem use LAVA [1] and  there's a
> bunch more that I'm aware of.

I am somewhat familiar with LAVA and I believe it can be used to test
U-Boot, although I need to learn how. Looking at a test run [2] for
beaglebone black I see that it is using a recent kernel but the U-Boot
seems to be older.

>
> Does it make sense, of course at some point in the future post this
> being merged, make sense to look at a general way of making it easier
> to plugin these sort of HW test platforms using this as a basis? I ask
> mostly because putting a bunch of my devices into some sort of
> platform can auto test things and of course everyone has an opinion to
> which is the best one :-P

Yes. I had heard from Tom that Labgrid is the new hotness for now.
Having dug into it I believe it is a good solution, although it can
certainly be improved to handle scale better.

Anyway, IMO the current test hooks are not a great solution, just
because the configuration is spread all over the place and it relies
on lots of little shell scripts. So I believe that the Labgrid
integration is a closer to where we want to be with others that come
along.

I would love for you to add a board into Labgrid and see how you go.

>
> [1] https://validation.linaro.org/
>
> > so having it in the main place (and perhaps eventually removing the
> > old way) is my goal.
> >
> > >
> > > >  bin/console.labgrid          | 42 ++++++++++++++++++++++++++++++
> > > >  bin/ellesmere/common-labgrid | 46 +++++++++++++++++++++++++++++++++
> > > >  bin/ellesmere/conf.all       | 24 +++++++++++++++++
> > > >  bin/getrole.labgrid          | 25 ++++++++++++++++++
> > > >  bin/release.labgrid          | 22 ++++++++++++++++
> > > >  bin/release.none             | 22 ++++++++++++++++
> > > >  bin/u-boot-test-getrole      | 38 +++++++++++++++++++++++++++
> > > >  bin/u-boot-test-release      | 26 +++++++++++++++++++
> > > >  9 files changed, 295 insertions(+)
> > > >  create mode 100644 bin/console.labgrid
> > > >  create mode 100755 bin/ellesmere/common-labgrid
> > > >  create mode 100644 bin/ellesmere/conf.all
> > > >  create mode 100644 bin/getrole.labgrid
> > > >  create mode 100644 bin/release.labgrid
> > > >  create mode 100644 bin/release.none
> > > >  create mode 100755 bin/u-boot-test-getrole
> > > >  create mode 100755 bin/u-boot-test-release
> > > >
> >
> > [..]
> >
> > Regards,
> > Simon

Regards,
Simon

[2] https://validation.linaro.org/scheduler/job/4089871#results_482796468
