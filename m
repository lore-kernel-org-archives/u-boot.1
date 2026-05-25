Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7FBCD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 14:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03007847C8;
	Mon, 25 May 2026 16:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JjYxjV/L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23E36846C6; Mon, 25 May 2026 16:03:44 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3FD6847C8
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 16:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bd124546379so1474153666b.3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 07:03:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779717821; cv=none;
 d=google.com; s=arc-20240605;
 b=jctLOjLYfNDe4GqTYHAQF5Wb1JIm1sViwA2hq2SSbiW1OwufhV+eLRHKmUbO4qD9gu
 ZZzEiYbqN4jHL/kFciMn/CpMRWrroWI5cRV4+L6HpE93IPuqVVOGm82IamVW96mZVYYv
 GI75m6FQF9xuBRONUlOsYJmsOuUfZ6As4vZ5veaNZOsU3QXJ1kcEjHQJK4Rwx0AoMX/1
 O+iIcrsrJs+HoDzYZYwI4739twaRyTek2O95ZpnCakMY1M1swV8nSta+QWHmHRvpVJxP
 MNHfUwn6G1K9IzFPuotfZrF8bvtBeO36X+ogLPPsodfjEni7bEPP2nbc7qnkxb4Dtz29
 gMrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=INz/us/AAUyNfiM4zLzt2+l8RHDNfV0rlb8GrQjePkI=;
 fh=oBfp1r1YcBJM/dQub5Zk4lOksgO7VVAJ7JSkhciMNJc=;
 b=WrRgMqIj8Q2ylj/EMnvAxfjPmcJMPEwXkLvsmZJMNh+X7Y7hsFgssvS93aNPBdVImk
 y2l7edLAdnXCuhitP+GP9+iLZS3rygqeTPpZQnU78u+iEwjJWiFRjGX7PWGM/54x+0Dy
 XrTr3qWrJBXokmqmPWy0EJSEPiKfiZcBOb/8Sji5OlxjjHc/9JQyYk1JVv59WvBHdWan
 JyRRUQmnncrYOE/fbyi2+VnJewxQpRKBADH3JPRKKK3jhApduG8oOhAvGPZ6DdWgsg80
 bxeAp9b2wrYPeYTjt4cONnTI8rJOPk7KJt2ppRUNHcQ602fo6woZ1Z8vUX7TsxdlTTBS
 qNfQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779717821; x=1780322621; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=INz/us/AAUyNfiM4zLzt2+l8RHDNfV0rlb8GrQjePkI=;
 b=JjYxjV/L2LN6+mVWINC5E/gHk7xrVEOioeCSPvLrs8jpRAacXS/jKqpEIXjW0GVPIu
 B8om7yj4nR+Lf3JjfNAwgeDbrxDZ6Odnd4jbD+Y9KIG5C0/o8mOYVfj3no9MhAC+vOPM
 BAD2g6BYcSAbiHn3aHZHeIfLMHt1znjPHMO+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779717821; x=1780322621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=INz/us/AAUyNfiM4zLzt2+l8RHDNfV0rlb8GrQjePkI=;
 b=hg8qFl7ucUTU5IZXMV1BH3j1buCAXgb5auvGsmkRJs5yILanhsGEL/AhZO3DceRvjG
 KozaM/A3YWR8/bf8Tt5lCinaZ8iQ76r/Stl5oDtsBWEHiWEEnDU93PGDTZQ23lY4hnnb
 UNTuAwz5kETmH6qBe9cCdhjwV8HE0GuHVwavdvA1WGadttCDesklXEgN4ChEGmKhc2eD
 T3NmJVI/6rSYSxTNmKzBDtLtomIhIvTZp4WcHnv8mDnGu0dryYVrZ9rq/0l5QAAsv+Px
 NzBmhLYz3X/dEpgQElC9NjZijgVI+wd/RHiUCSRPYf4wdHD6/V3WTCGg+VNvjkE5F7i7
 QO+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9cOn0wuf77VqCsrtIdvZR8IcqDYblTYe5DnlyckMfkP5An0EF42EEm+ERCTA95IW/UL37RfWk=@lists.denx.de
X-Gm-Message-State: AOJu0YwmHPIsXXQUC1G/oFku7RXmXm/fLe5jKl63l9TGiJXrjO+FYjAh
 AlS6p+C4bKnFIb138S6ZmD3VzZW0ajhuxn63r+V0LmCn2yTRTYWKKrsgW73Fja7JRjfVF4DYjoo
 UyWOKYFXrZH3VtpIdqQlNuRtHJRXgw+tvqJIdguwf
X-Gm-Gg: Acq92OHW2pTkfPDUX2ywXKLScUjHuXDeKR2xOp9GXLLZRRPH4w8buaoFaIkv3sZKLUt
 UisY2OYOMXWZssuLKrsi+UPuoBKlKMsB0wf9Ci8Er/xeiNk5PSYT1w7ro7WkQn26DxBymE3oNu5
 jBcV7cVVuh8yBBZaUAx1WIjqKCKIROFgOzCSpB3Ez40mSeuHjDgPG4U/U4F/1HuaFqvkfubd0HI
 nnEijkzWyGf+5w332oP2usZyTJgQC5EkoGaMjiIH6DSj82FGLN7frpMhTbRmmFYH+gVfovKh/1L
 1+hpJTOOgWQNTNy3
X-Received: by 2002:a17:907:1ca7:b0:ba6:8f34:b419 with SMTP id
 a640c23a62f3a-bdd23602369mr873143166b.13.1779717821359; Mon, 25 May 2026
 07:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTjnL6rn_mTA+jhcrRLF0yEtN4FVwTeGGy9GeGbgdB9fYw@mail.gmail.com>
 <20260515220758.GM1858239@bill-the-cat>
 <46705f94-6cef-4016-ab05-7839514e9257@amd.com>
 <20260518155842.GR1858239@bill-the-cat>
In-Reply-To: <20260518155842.GR1858239@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 08:03:28 -0600
X-Gm-Features: AVHnY4JzPLd6OFI9dMUGy-qsFA8XnJAniRrWikq6GeCi89Uq46nVM2YkBi3RDRI
Message-ID: <CAFLszTj771TqyyvF_MGhNM4tfucQSs6sMOHzXVYDtNKBv_AZxg@mail.gmail.com>
Subject: Re: AI-assisted review
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Mon, 18 May 2026 at 09:58, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, May 18, 2026 at 10:55:40AM +0200, Michal Simek wrote:
> >
> >
> > On 5/16/26 00:07, Tom Rini wrote:
> > > On Fri, May 15, 2026 at 03:03:21PM -0600, Simon Glass wrote:
> > >
> > > > Hi,
> > > >
> > > > There was a query on the call this week about whether I am doing
> > > > AI-assisted code review. As I said on the call: yes. Here is a brief
> > > > description of how it works.
> > > >
> > > > It is built into Patman (on the Concept tree) with a new 'patman
> > > > review' command. You give it the series name / number, or perhaps a
> > > > patch name/number and it applies the patches to a new branch, does a
> > > > review then adds its comments to its database.
> > > >
> > > > A '-d' flag can be used to create draft emails in Gmail (sorry, it
> > > > doesn't support other email programs yet). You then check and update
> > > > the emails and send them (or delete them). I am not an expert in
> > > > handling the 'user voice' part of AI, but have made an attempt to make
> > > > it follow any provided configuration, as well as to scan recent
> > > > reviews to actually create to create a voice.
> > > >
> > > > Obviously this is very rudimentary and could be expanded considerably.
> > > > But the mere fact that it creates draft emails is a win for me, even
> > > > if I ultimately delete or rewrite most of the comments. I can imagine
> > > > 10 different ways to improve it to be more useful.
> > > >
> > > > I wrote a blog post about it if you want more details, or you can ask me here.
> > > >
> > > > I am very interested in hearing how others are using these new tools
> > > > for code review.
> > >
> > > And the big thing for now is that since we as a project do not yet have
> > > an AI policy aside from "please don't". One of the points I was making
> > > on the call is that there's a difference in value between "Human
> > > reviewed it, looks fine" and "Human spent some tokens, agent didn't see
> > > any problems".
> > >
> > > And I know several other people have been doing at least first pass
> > > reviews with various agent-tools, it's just no one else has been posting
> > > reviews at your scale. And lessons learned from other projects is that
> > > the prompts are more important than whatever wrapper around the agent
> > > one is using.
> > >
> >
> > Don't think scale is the problem. Tool and integration is another topic.
>
> Simon posted approximately 100 reviews in about 24 hours. That scale is
> a problem, when most of them are just reviewed-by tags, from someone
> that has a history of doing human reviews. Reputation is a factor here
> I'm trying to figure out how best to articulate.
>
> I have thoughts on the rest that I want to get back to later, thanks.

I should point out that I tend to do reviews locally bit by bit and
then recheck and send out in batches later, particularly when I need
to dig into the code and check things. I suspect a lot of the
'reviewed-by' ones are on revised series where I already reviewed v1,
etc. For better or worse, patman tends to have something to say on
most patches (too picky for my style so I often delete comments).

Re the AI policy, I suggest adding it in the project docs (even if it
is very brief), rather than referencing a URL from another project.

Regards,
Simon
