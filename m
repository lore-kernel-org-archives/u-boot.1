Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3DFC54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 15:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC1C382B0E;
	Sat, 24 May 2025 17:27:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WXuaRPnf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F55D82B70; Sat, 24 May 2025 17:27:11 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A89D82A8B
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 17:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-603fdd728ccso592078a12.2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 08:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748100428; x=1748705228; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h2FLvHQ46tZ12OTUlqUSORYGI11cAxB/y+ZMJ6Sme74=;
 b=WXuaRPnfcmxpuj5zVu0cZ1x00YnQDousKHUy0i6Fl4C4Al3oUyWYeTs+ItTwbrvcVL
 8WRsuWkaSHIzGWHKDLLIW3T5Vm/E8vFoJf/srXF4rTedMmzvu2OASTcAbzSQF1CHYaCB
 GT/zKE6KCbumQPBvmI3fZ6C+sQbNKAYNXi9Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748100428; x=1748705228;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h2FLvHQ46tZ12OTUlqUSORYGI11cAxB/y+ZMJ6Sme74=;
 b=urO2V/NoGkeIT0xfWRER1p4fi4Cj1MODyB6uhkxesdnF4vsFnkKVcDrERxF26dn7kf
 VpYXmalXL+6uoz9DfJoszS5RMD+KleRx5yyEoQj3GhU+2rNon0Qc+M6EXQkHiJXO8/39
 K6gwaVAfkqQlx4lLzEVXrImBxUcB/OaT5nmE7M7ELmHJDA2S0Je4kv9Ac58S7lQXCatq
 DomL0s37hrANwVWtrlxV/SpMrysn61fLqU4ekmP6T/Qmbreedb5TEWjIFg+E/K450rWN
 EgTkTEGQvtbIGhOwnY3z7vSlw+yQaI8Hi1ro0GJyzk1t2uu0GrCMmAyII1Xs7oWPRxbj
 5VuQ==
X-Gm-Message-State: AOJu0Yy84hKaU8RC8zZQP7ZgCIbuUuNu2a3jqz3W63B5R//jBSkgv6d9
 IdGzi0wgjtkH5QbPxLXWR+rxm7to67k3G5LqM63g6W6/pXZiWSHwY65QZIxBKfGIKQUaOrLBIzs
 TZDCyAfDOeu53q7rfGKjlut64CuNLVv5A8OyP9JFxnKMmbxnhkGf2ido5d8thng==
X-Gm-Gg: ASbGncs6vyxh5uwWkOtBDWViVuHMyRSP3J5aqPrAi/JCq98qLfwzH3cwDSbZS8Mz5oE
 VStteddiKxCrNxr+TabdWBTQih4BWygyKEsyWVVJe1P4XBgC/bnzEtpU2dFR284qAjOcPZDcE79
 imsEYDnAyBcPBlgLLpvqBmJBAoQogaIzA=
X-Google-Smtp-Source: AGHT+IHgJp5fBHCo38Pw4MUjztYtOPOu17JC9ZnlH4wfLg2BK0NmuUQSRqd7f2TNg0kFZ27d0hEA6R/SZATT56Vk99k=
X-Received: by 2002:a17:907:3f29:b0:ad2:3fff:7bf with SMTP id
 a640c23a62f3a-ad85b2da118mr231511766b.37.1748100427596; Sat, 24 May 2025
 08:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTj1v7dhvdj9vM70OP=Bb8j3FArYHS3SGcpnJO31z3Ns1g@mail.gmail.com>
 <20250523164717.GU100073@bill-the-cat>
 <CAFLszTg0CO5PqagaAZNov-N4rv6D17iUV_qnAasJ336zW=eG9w@mail.gmail.com>
 <20250523212539.GX100073@bill-the-cat>
 <CAFLszTioW78gyU2qK+-E5CcjyTAatvFuodWV3NKuwq5anBGdpg@mail.gmail.com>
 <20250524141805.GB100073@bill-the-cat>
 <CAFLszTj=6W2miuLkU0Acbi-HBNSAiq-9YfwdOu0-+OSSy9+gvw@mail.gmail.com>
 <20250524143124.GI100073@bill-the-cat>
 <CAFLszTizvrb9jX+a6-BVVtrH-fU5T_DdV8gakyEszSVCojp3hQ@mail.gmail.com>
 <CAFLszThUpdm2e0QgYuENfmC8+4L-29iW7XQgNLhZzpkkyEeUnw@mail.gmail.com>
 <20250524145114.GO100073@bill-the-cat>
In-Reply-To: <20250524145114.GO100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 May 2025 16:26:55 +0100
X-Gm-Features: AX0GCFsznUGg33D4-_KTfiz2vb6dlAJVfUROWfSk_rU4otlPBjAF_lj26C8aLBg
Message-ID: <CAFLszTgf+hY08ORLyxT_FsUwzZP36wjNvTKLRwwVcxBFh7URbg@mail.gmail.com>
Subject: Re: [PATCH v2 01/30] patman: Move all non-test logic into control
 module
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Sat, 24 May 2025 at 15:51, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, May 24, 2025 at 03:39:35PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 24 May 2025 at 15:35, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Tom,
> > >
> > > On Sat, 24 May 2025 at 15:31, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, May 24, 2025 at 03:22:57PM +0100, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Sat, 24 May 2025 at 15:18, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sat, May 24, 2025 at 05:23:48AM +0100, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 23 May 2025 at 22:25, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, May 23, 2025 at 09:20:37PM +0100, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Fri, 23 May 2025 at 17:47, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, May 23, 2025 at 05:32:36PM +0100, Simon Glass wrote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Fri, 23 May 2025 at 15:04, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, May 23, 2025 at 08:19:30AM -0500, Simon Glass wrote:
> > > > > > > > > > > > > It is easier for tests if the top-level control logic is all in one
> > > > > > > > > > > > > module. Create a new do_patman() function to handle this. Move the
> > > > > > > > > > > > > existing code into it.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >
> > > > > > > > > > > > > (no changes since v1)
> > > > > > > > > > > > >
> > > > > > > > > > > > >  tools/patman/__main__.py | 49 ++----------------------------------
> > > > > > > > > > > > >  tools/patman/control.py  | 54 ++++++++++++++++++++++++++++++++++++++--
> > > > > > > > > > > > >  2 files changed, 54 insertions(+), 49 deletions(-)
> > > > > > > > > > > > >
> > > > > > > > > > > > > Applied to sjg/master, thanks!
> > > > > > > > > > > >
> > > > > > > > > > > > Odd. I thought you had posted this against master or next, intending it
> > > > > > > > > > > > for mainline, which is why I assigned it to you in patchwork. I see the
> > > > > > > > > > > > cover letter is missing what commit it's against. And instead here you
> > > > > > > > > > > > are once again spamming the list and with messages about your personal
> > > > > > > > > > > > tree. Why?
> > > > > > > > > > >
> > > > > > > > > > > I'm applying it to my tree and intend to send you a PR at some point,
> > > > > > > > > > > with collected tools/ patches. So I believe I need to send emails
> > > > > > > > > > > about applying things and update it in patchwork. Let's discuss this
> > > > > > > > > > > in a future call.
> > > > > > > > > >
> > > > > > > > > > I don't see what there is to discuss. Please follow the normal process
> > > > > > > > > > for mainline and stop spamming the list with notices for your personal
> > > > > > > > > > tree. You're also diverging your own tree further from mainline by doing
> > > > > > > > > > this and making it less likely (multiple people have told you they don't
> > > > > > > > > > want to review things not against mainline) any follow-up work will get
> > > > > > > > > > comments other than that it's not applicable to mainline.
> > > > > > > > >
> > > > > > > > > For patman, I have another series [1] I'm planning to apply to my tree tomorrow
> > > > > > > > >
> > > > > > > > > Would you like me to send 'applied' emails for it to the mailing list?
> > > > > > > > > Or perhaps just for the cover letter? Would you like me to send you a
> > > > > > > > > pull request?
> > > > > > > > >
> > > > > > > > > Regards,
> > > > > > > > > Simon
> > > > > > > > >
> > > > > > > > > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=456256
> > > > > > > >
> > > > > > > > Yes, that's another series that while I disagree with the direction
> > > > > > > > you're taking things, would rather apply to mainline than let it bitrot
> > > > > > > > in mainline. So please send a PR against next. And that would also apply
> > > > > > > > to the series this email is in reply to. As again, I had expected it for
> > > > > > > > mainline and not your downstream tree even if I think we (and our users)
> > > > > > > > would all benefit from managing the python portions differently.
> > > > > > >
> > > > > > > OK, once I have applied the remaining two series I will send a PR.
> > > > > >
> > > > > > Based on the emails in my inbox this morning, you're doing the opposite
> > > > > > of what I asked for. But maybe this afternoon will bring something
> > > > > > different.
> > > > > >
> > > > > > > You didn't express a preference for the 'applied' emails. It seems
> > > > > > > better to send these emails so that there is a record of the patch
> > > > > > > being applied.
> > > > > >
> > > > > > I guess I wasn't clear enough. Stop spamming the list with *anything*
> > > > > > about your personal tree. And if you're going to send anything about
> > > > > > something that's intended for mainline, you should make patman act more
> > > > > > like b4 and NOT send a message to every patch. I know I used to, but the
> > > > > > workflow b4 enables is much better for everyone.
> > > > >
> > > > > How do I (or anyone else) know whether a patch was applied? If you
> > > > > only reply to the cover letter, doesn't that mean that the patches are
> > > > > left 'hanging' in the mailing list?
> > > > >
> > > > > I didn't know you had changed your policy on this...it certainly seems
> > > > > odd to me. I often find Heinrich's patches are 'silently' applied, so
> > > > > perhaps he does the same thing?
> > > >
> > > > Every custodian does things as they see fit for mainline, but most are
> > > > adopting b4 which means that no, I'm not sure why there would be
> > > > confusion, or where it would come from. The emails say what the commit
> > > > ranges are for a series, patchwork is updated and then periodically most
> > > > patches in patchwork then get their githash added. Replying to the cover
> > > > letter with the commit range for the series means it's very much not
> > > > "hanging".
> > >
> > > Generally I rely on seeing a reply to a patch to know it was applied.
> > > So it is confusing when the patch goes in but there was no reply to
> > > the patch.
> > >
> > > I've noticed that you seem less inclined to apply some patches from a
> > > series, instead requesting that the whole series is resent. Perhaps
> > > that is why?
> >
> > Also, was there an announcement about this change? If so, could you
> > please point me to it?
>
> I don't see why there would be an announcement? Now, again, please stop
> posting things to the public mailing list about your tree. I'm not the
> only person who has told you it's not helpful.
>
> I mean heck, a big part of the problem is that you keep replying to
> patches you posted for your tree and spamming the rest of the community
> about it. I can't tell if you're acting in bad faith or not anymore.

It's just that I am trying to work with your tree in areas where I'm
not blocked, to minimise the delta.

Most of the patches apply fine to -next . I could perhaps update the
tooling to indicate that. Would that help?

I'm thinking of adding a feature to patman to support multiple
'target' upstreams.

Regards,
Simon
