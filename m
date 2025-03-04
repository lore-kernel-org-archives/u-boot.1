Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7247C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 13:13:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69716817E6;
	Tue,  4 Mar 2025 14:13:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ec2MF//I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 304AC819D2; Tue,  4 Mar 2025 14:13:53 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14457816AB
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:13:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aaf900cc7fbso1009846266b.3
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 05:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741094030; x=1741698830; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ntq2xljvbkvqX6TQYEZfwGlIOHTIbFOLRg72kkBWeF4=;
 b=ec2MF//Ifb1lyLbeTspsS9+jrZBvYoWi7+3j2oFZvi7dtmVnPVAw73ACRoBCpP9CbJ
 iz+P+UwdNxPZU9nhsMygZKA04Ef3/Vje9UQSD9xV8kVbcbBZZEzsA39mSaz6FbgC40FZ
 Lx1niwcl9SRZNGNzLVUJ9BydcZzTPmdtLl5hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741094030; x=1741698830;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ntq2xljvbkvqX6TQYEZfwGlIOHTIbFOLRg72kkBWeF4=;
 b=dLQ3vkbdKeter6wtyOrbSXNoAHNprXW2QKXT+7ijq0il9Z4WEC+V3Y2WfU4zFeQ5jg
 0pmvSf+EYsJXr34VsevyX5FtdwYnxndvIvhtCike2dSLNgvEGKdYiESFsJK+vVY8GFjV
 aHnLkSSpYaMzB8LTUW1ybSaXJrTxAq+jtG3wxc9Cn27qUuAWC36IeuISN6gwfIrhfNOw
 mj13KCtZo+z1DT95J0pamekTSLqpFV/zOmAiYGPSsMcZI58Voa9e9iPZz+J1f7OL4q9O
 RPMOZpN9EtXetvDzg2vFAelnYHJF0d7iwrZoi36CqpyrAD8RMvwYfBNyn9A6dO9eoROM
 w+gw==
X-Gm-Message-State: AOJu0Yx6ArBwNZsZYzL8Le2TFog0ZHQTZf1z96/enjaGM6BQ0dy1b1ba
 5dSUtPKo/nxuku50uWPu/xmiT14GSIPxb29Gcy/zbVRfq+bfJrD9/mPUDoffMix8r67huf9oJ9T
 X0gGhPYkRopPrwB0pWtunv16z2JDPzW+/htHx
X-Gm-Gg: ASbGnct5j34FPrkvNzTdJgCh0ddudw4dtfZ+B1/niuC1FcLnqyvPp+RkC80jWC0gDlK
 ciALs/wmXZnH0s9PFU43S0GjZMbY6qDTyJdFeP38injC1gKGKOkapb8etdxEI/h5QVcfxj95k9y
 +uMW58dTendkrRYe+IzwYsepwlQvc=
X-Google-Smtp-Source: AGHT+IGDurlx7DmfWZ3lQtXYbx1bJ/ZCMXRho+F7tSSQlHmkH+Cw3QnXoaIum7lncTQJilMEiueapkgORcUSn+0L7Q8=
X-Received: by 2002:a17:906:840d:b0:abf:53ef:6584 with SMTP id
 a640c23a62f3a-abf53ef731amr1446873866b.50.1741094030381; Tue, 04 Mar 2025
 05:13:50 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTiKbg2twYpJJTFb9bFya+5D2DsVPBGKXuw9pw6Y+cvUbg@mail.gmail.com>
 <20250220174005.GA1233568@bill-the-cat>
 <CAFLszTh=Mn9Hxe41KBB+8xjBBxVv=spV=g26tY+Hq6q43EM4=w@mail.gmail.com>
 <20250220204001.GC1233568@bill-the-cat>
 <CAFLszTjx1uQU+O=XrS6BBijpiSNtdR_-X_9LCjYZCSe+A0HC8g@mail.gmail.com>
 <20250221141940.GG1233568@bill-the-cat>
 <CAFLszTh=oq3z4P_tAKYETHE40yfHQOH1XHeKqmhQEAQ=PL1HUw@mail.gmail.com>
 <20250221175320.GN1233568@bill-the-cat>
 <20250221181055.GO1233568@bill-the-cat>
 <CAFLszTgnj+ZFq1vEcSSKCOeYjx0NKesO8Lo3aOJ2Nm-jhuTvig@mail.gmail.com>
 <20250224232303.GJ1233568@bill-the-cat>
In-Reply-To: <20250224232303.GJ1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Mar 2025 06:13:36 -0700
X-Gm-Features: AQ5f1JpkMuzYQKzgFj_7UOL3hLFPV8hNLbh9ViMqX4tuuey3HS-I6Okt-EzZJDc
Message-ID: <CAFLszTgtdETGCYYtH3ni7Wv0W6Ckv1SoZRG8djQ-3uKBn1YZWQ@mail.gmail.com>
Subject: Rate of innovation in the project (Was: Re: Rate of change in the
 project)
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
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

(I changed the subject as 'change' sounds like change for change's sake)

On Mon, 24 Feb 2025 at 16:23, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Feb 22, 2025 at 05:00:59PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > (I think you chopped off too much context, so I've added it below)
>
> That's fine. But I omitted it because it's also true for any other DM
> migration, and bootstd more fully and adding more classes of devices for
> bootmeths and I honestly think you have a half dozen big things that are
> in various states of being merged and enabled and perhaps even more that
> didn't get much past sandbox being enabled.

Yes I often have new ideas and start things.

>
> >
> > On Fri, 21 Feb 2025 at 11:11, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Feb 21, 2025 at 11:53:20AM -0600, Tom Rini wrote:
> > > > On Fri, Feb 21, 2025 at 08:03:12AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > [snip]
> >
> > [unsnip]
> > > > > > >
> > > > > > > Sure, but we can't even get sunxi bootstd or LED over the line. How do
> > > > > > > you imagine we could retire the legacy image?
> > > > > >
> > > > > > Partly by focusing on one thing and not 5 things at a time. bootstd is
> > > > > > stuck on reworking efi bootmanager integration, and LED is waiting for
> > > > > > someone to confirm that really, finally, we have all of the old use
> > > > > > cases supported in the new code.
> > > > > >
> > > > > > But more importantly, do we really have anyone not using u-boot.img? I
> > > > > > don't know.
> > [unsnip end]
> >
> > > > > If we did one of these sorts of things at a time, we would only get
> > > > > 2-3 things done each year!
> > > >
> > > > A project with 4 yearly releases finishing two 2-3 big changes a year
> > > > sounds great to me. Rather than not finishing a dozen things?
> > >
> > > As this is a huge thread already, I'm splitting this part out.
> > >
> > > I would seriously frame slowing down and having just one big change
> > > being in progress at a time, until it's done, as a good thing, not a bad
> > > thing. We're a small community with limited bandwidth.
> >
> > I can't see how that would work.
>
> Well, what we have today is clearly not working well enough for you. And
> "just land my changes" is still not an option for mainline.

You really haven't addressed my point here.

>
> > I just looked at LED[1] originally sent almost 5 months ago and the
> > latest version is marked 'changes requested'. I don't know of any
> > changes I can make. Are you hoping that [sorry forgot who it was] will
> > get around to digging the only affected device out of his drawer and
> > try to get the activity-LED going? It might take a while.
>
> Yes, and as a reminder it's only been 6 or 7 months since mainline had
> all of the required functionality, maybe. And what *you* could do to
> speed things along is implement the functionality on any of the boards
> at your disposal. Anything with a LED today would be fine for this.

Oh well. I would have thought that Christian's series was enough there?

>
> > The sunxi one[2] was sent over 6 months ago and the latest version is
> > also marked 'changes requested'. You could apply that series with
> > either the bootmgr revert or the patch that drops bootmgr for sunxi.
> > Then Heinrich can come along with his patch on top of that.
>
> The sunxi one is blocked because it needs to be rebased on top of the
> fix I did for BLK stuff and then yes you also could have done the
> "bootstd uses bootmanager" idea that you've both agreed is a step in the
> right direction. Because it's actually a generic issue with bootmgr +
> bootstd that only became more evident as more platforms moved
> towards using it.

So can you clearly explain what is blocking sunxi? Does it just need a
rebase? Which patches should be included and which not? Also we
normally expect patches sent first to have priority. Here you have
apparently applied your BLK stuff and then want me to rework on top of
it?

I agreed to the bootmanager work-around but I'm certainly not going to
write it. I would rather make bootmgr more iterative, if that is
possible.

> Which is why I had spent so much time trying to get
> you to migrate more SoCs to bootstd because it's your feature.

So take the sunxi patches and then I'll do the next one? On the one
hand you complain that there are too many balls in the air and on the
other you stop the balls from landing. It just doesn't 'compute' for
me, sorry.

>
> So yes, I think things would be in a better place if we tried to get
> *less* big things done at once and didn't pick up another big thing
> until the last was really done.

You should address my point above. Are you trying to limit me to 3-4
large series a year?

Regards,
Simon
