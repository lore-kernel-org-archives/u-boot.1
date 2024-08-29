Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1ECC83F2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C441288C73;
	Thu, 29 Aug 2024 17:02:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iJOP8F8u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90EF188C88; Thu, 29 Aug 2024 17:02:56 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FA0C889A7
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 17:02:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7a1d6f47112so47931685a.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 08:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943773; x=1725548573; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tg1AKqkwGoOrOrSDTeA1xgP4WfJMFTshB4ix6r2U4p4=;
 b=iJOP8F8uFExsTiSpyNQG18VWAA0V8ODWL8R9HV4sGT0/twQTC7aLEhVFSfHmiTWl6/
 LTMtbKfE6z4ZoejzakbYwveR1MkucveN0fpSJEyqTZ93Fy6IDdc5xR22WKnT5HPPMRs8
 lwUCuuuUKyJSuKj5LlOKm7IGaU+SEiqEbvwkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943773; x=1725548573;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tg1AKqkwGoOrOrSDTeA1xgP4WfJMFTshB4ix6r2U4p4=;
 b=jftPIkXUtXfyHEeKk5YIqCViqfzeBYC6Yay7CXoVqQ/0xIwZ7IE83WzxAQi8RXkGNo
 ZldTCVtE7ZglTB15fk6t78SUK6mWdoHaRfpX6nyxfaPGHs/RzceYWFjMfRfKubCFtvrg
 lqG67pA2MqVdeVH+EHyA0/9h+DhxJdl4ecabasiUUcS4pkivEIAHN5Xbfh16Y68s0QwJ
 14z6FufXSe+kqPq7v/aJNTriZYvLIVGFeBq+QUkr7PXCPLe/CZECsnwk8MMlOMHs1vDD
 bBG6EpEpJDrqkt133OWXdg2V3AWjsCclzW+nPOQM3vGtjxEdZDn5cye2Is69xhTvpYev
 HQag==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6i+JT2oUhIMYRl9YkdB9OzPQ5YE4U+wPNW4Rq4NFkd5FmYF9NPififJRs6oojcvLyDeTb40c=@lists.denx.de
X-Gm-Message-State: AOJu0YzaupNWdaeeu8GmNSF+OoBh2uZaIg21smxsSkLmuSyLHB89qSpZ
 Nribqpgywz8qIh31SDCC8rw7XdouMC0M2kOmyByqemXsT3CfPGy8UWlGqV5nXxWfACIO+Nm1SpZ
 bl19q2SSKidgcM6ggXCGcrlodQSZsKgY5L0tA
X-Google-Smtp-Source: AGHT+IFkKu+nNI92yoKBaEV0QY+oNu+bazkQeuYfbsywNtlgLBonuj+u5w5OFxqZhax3f5GHJhSqg2iQfdkV2pIzmNA=
X-Received: by 2002:a05:620a:448d:b0:7a1:cd2c:f37d with SMTP id
 af79cd13be357-7a80427a9d3mr354118785a.66.1724943769268; Thu, 29 Aug 2024
 08:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240828164523.125770-1-sjg@chromium.org>
 <20240828164523.125770-4-sjg@chromium.org>
 <CALeDE9Ptr0Ln4H24yMqxuw1+E_Wt5qBGdQabUH54PaYUTPf9Yg@mail.gmail.com>
 <CAFLszThK_t5EwL28vnzmSp5UZQrSEpBRsaXhnNudMQRe8-7Ejw@mail.gmail.com>
 <CALeDE9O-kmnqkosThf8xQpLZ2tEebiHvrUEzVJNDjiEff2-t2Q@mail.gmail.com>
 <CAFLszThD=Haj4M5rUYfpjPDjr9JEOPygQb9tV36frcAM5Ey9tw@mail.gmail.com>
 <c63147f4-d364-4568-8f6e-c0348914446a@linaro.org>
In-Reply-To: <c63147f4-d364-4568-8f6e-c0348914446a@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 09:02:38 -0600
Message-ID: <CAFLszTgzM-FT64AYTy6FXwUw3FQg-3MQ7x0TZc6xBhX5c+bXEg@mail.gmail.com>
Subject: Re: [u-boot-test-hooks PATCH v4 3/3] Provide some basic scripts for
 Labgrid integration
To: neil.armstrong@linaro.org
Cc: Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

Hi Neil,

On Thu, 29 Aug 2024 at 08:44, <neil.armstrong@linaro.org> wrote:
>
> On 29/08/2024 14:17, Simon Glass wrote:
> > Hi Peter,
> >
> > On Thu, 29 Aug 2024 at 04:43, Peter Robinson <pbrobinson@gmail.com> wrote:
> >>
> >> On Wed, 28 Aug 2024 at 22:25, Simon Glass <sjg@chromium.org> wrote:
> >>>
> >>> Hi Peter,
> >>>
> >>> On Wed, 28 Aug 2024 at 12:14, Peter Robinson <pbrobinson@gmail.com> wrote:
> >>>>
> >>>> Hi Simon,
> >>>>
> >>>>> With Labgrid we don't need to specify the various methods, except for
> >>>>> the console, which simply calls labgrid-client.
> >>>>>
> >>>>> This allows supporting any boards in your lab, without adding per-board
> >>>>> configuration to these hooks.
> >>>>>
> >>>>> Provide ellesmere files as an example.
> >>>>
> >>>> What's ellesmere?
> >>>
> >>> It is a lake but also the name of a computer.
> >>>
> >>>>
> >>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>>>> ---
> >>>>>
> >>>>> Changes in v4:
> >>>>> - Support pytest fully with dual-build boards like Beagleplay
> >>>>>
> >>>>> Changes in v3:
> >>>>> - Update scripts for latest version of Labgrid integration
> >>>>> - Add poweroff.none and poweron.none
> >>>>> - Provide -n flag when querying board info
> >>>>> - Target the grpc version of Labgrid which is now in -master
> >>>>> - Update README to cover the changes
> >>>>>
> >>>>> Changes in v2:
> >>>>> - Make use of the common script (only) to set bin_dir
> >>>>>
> >>>>>   README.md                    | 50 ++++++++++++++++++++++++++++++++++++
> >>>>
> >>>> Maybe that should be in a separate labsgrid readme?
> >>>
> >>> My hope is that Labgrid becomes the normal way of running these tests,
> >>
> >> Generally I agree with automated testing platforms, I think <insert
> >> you're preferred platform here> makes sense, there's a bunch like
> >> Linaro and a bunch in the arm ecosystem use LAVA [1] and  there's a
> >> bunch more that I'm aware of.
> >
> > I am somewhat familiar with LAVA and I believe it can be used to test
> > U-Boot, although I need to learn how. Looking at a test run [2] for
> > beaglebone black I see that it is using a recent kernel but the U-Boot
> > seems to be older.
> >
> >>
> >> Does it make sense, of course at some point in the future post this
> >> being merged, make sense to look at a general way of making it easier
> >> to plugin these sort of HW test platforms using this as a basis? I ask
> >> mostly because putting a bunch of my devices into some sort of
> >> platform can auto test things and of course everyone has an opinion to
> >> which is the best one :-P
> >
> > Yes. I had heard from Tom that Labgrid is the new hotness for now.
> > Having dug into it I believe it is a good solution, although it can
> > certainly be improved to handle scale better.
> >
> > Anyway, IMO the current test hooks are not a great solution, just
> > because the configuration is spread all over the place and it relies
> > on lots of little shell scripts. So I believe that the Labgrid
> > integration is a closer to where we want to be with others that come
> > along.
>
> I'd say all those scripts are actually here to ease integration with any
> system, booting U-Boot and Linux are two different beasts.

That's fine, go ahead and use the scripts. My point is that Labgrid
doesn't need them and in fact it makes everything pretty painful if we
try to use all of them.

> Most of the time you need special jumpers enabled to setup vendor-specific
> bootrom mode to reflash or ram-boot U-Boot.

I deal with this by soldering onto the recovery switch. For example
Beagleplay needs it, otherwise it boots from internal eMMC or
something.

Perhaps Linaro could create a standard here, where boards have a
'recovery' line which labs can twiddle?

> So forcing us people to switch to Labgrid because it matches your boards
> behavior is a little adventurous, and while we can add some enhancement
> to the actual pytest and hooks, I'm against saying Labgrid should be the
> golden CI system.

Who is forcing anyone to use Labgrid?

I invented my own system (Labman [3]) several years ago. Let me know
if you are interested and I can share some slides. I was thinking of
trying to tidy it up, but Tom suggested that Labgrid might be worth a
look. I had never even heard of it before that.

I don't mind about choosing golden CI systems. The more the merrier. I
want to have my boards connected to gitlab so things like bloblist
changes don't break my boards. At this point I have convinced myself
that Labgrid (as amended) is a good solution for this.

Regards,
Simon

>
> Neil
>
> >
> > I would love for you to add a board into Labgrid and see how you go.
> >
> >>
> >> [1] https://validation.linaro.org/
> >>
> >>> so having it in the main place (and perhaps eventually removing the
> >>> old way) is my goal.
> >>>
> >>>>
> >>>>>   bin/console.labgrid          | 42 ++++++++++++++++++++++++++++++
> >>>>>   bin/ellesmere/common-labgrid | 46 +++++++++++++++++++++++++++++++++
> >>>>>   bin/ellesmere/conf.all       | 24 +++++++++++++++++
> >>>>>   bin/getrole.labgrid          | 25 ++++++++++++++++++
> >>>>>   bin/release.labgrid          | 22 ++++++++++++++++
> >>>>>   bin/release.none             | 22 ++++++++++++++++
> >>>>>   bin/u-boot-test-getrole      | 38 +++++++++++++++++++++++++++
> >>>>>   bin/u-boot-test-release      | 26 +++++++++++++++++++
> >>>>>   9 files changed, 295 insertions(+)
> >>>>>   create mode 100644 bin/console.labgrid
> >>>>>   create mode 100755 bin/ellesmere/common-labgrid
> >>>>>   create mode 100644 bin/ellesmere/conf.all
> >>>>>   create mode 100644 bin/getrole.labgrid
> >>>>>   create mode 100644 bin/release.labgrid
> >>>>>   create mode 100644 bin/release.none
> >>>>>   create mode 100755 bin/u-boot-test-getrole
> >>>>>   create mode 100755 bin/u-boot-test-release
> >>>>>
> >>>
> >>> [..]
> >>>
> >>> Regards,
> >>> Simon
> >
> > Regards,
> > Simon
> >
> > [2] https://validation.linaro.org/scheduler/job/4089871#results_482796468
>

[3] https://github.com/sjg20/u-boot/tree/lab6a/tools/labman
