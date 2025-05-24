Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25890C54FC6
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 14:23:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A8A183416;
	Sat, 24 May 2025 16:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="htg30Skx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEEF98344E; Sat, 24 May 2025 16:23:11 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92D348340C
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 16:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ad5533c468cso106773466b.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748096589; x=1748701389; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fY2MaSAlTIFuTNiHnqUQ6uR+EqX1HOpFiFMlVTRly2M=;
 b=htg30SkxIRsC4RmLkUI/upIhQl8b2n/Wqva/vh/Gryox7c049aDoYHuWnj7rqRw+/Y
 e1sZX/bSSI80gT1AZUbVZxScc1tS90ym0io5Zi1Sed8zBH8p6jEcKEEnqT3UrOC2Ru1J
 1XIu6NGd2tXv6KUcr/8SmpzY1rB5r4H7tRctk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748096589; x=1748701389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fY2MaSAlTIFuTNiHnqUQ6uR+EqX1HOpFiFMlVTRly2M=;
 b=Kzp/b/fAkhm47t1+ApXK09FfhHk4K+i3qdbmSao6AhN2i8k0SPSTV81wqNXPfIWI14
 G4TeLrCiXxzhm4JU7Llf+hY+r56cCDt9h7U6fSm0w/V0oasuDPDlqwcDrwG+A+7oBL43
 x1tno8v6uV3/kqMxsZ7O0axRyVDcSS2kPfW7wWK7bXqfcP4g3F2Iqak2NImEcyzzHIaY
 23qXRs0tVNAXonIWuVPRLdCRKUEfDYUw3+ucKPs3ZBVmCNolvkOs26lKSc8R2lwJXLpp
 /MpeM1Zrsb/z4PhnUZ3K9arqwSRCdB9BEMBVQTVR8+Kfy1O65fpsr+tJPxAsAnSQaRfr
 nmuQ==
X-Gm-Message-State: AOJu0YyLjozGvxYzOP1IZhxRWmYLaLhTY9y0h7KX4tZc/ldTOCoL4qbx
 PLAOJe91ej9j+IjQQJ7aq++VRweI7PjAGlbMTOhFKJwBouGNG7CS+tYYXlnhwPZlaJlD+hCTJ8G
 3n9rW2Rw5vTFNB0u2/4F9t3BwR4yYRby5gBxcvtmVUPEmprExVygHGt+bIW8=
X-Gm-Gg: ASbGncuS8s5LoAo26/LivHZvnXECUD9L06CFZPVa+OdGTqVR/4DJpS1aG24RbaU8ubQ
 hXsC9W3x1oEFEWTfE8bHrhtz/1edJtWpQNyfMnRBYT1r7sJ3AqA7YAAbO7qV8+8Qoga9gU1Z4DP
 hAyNSY2Uixouom8UloanLgx2Ukbg30T2k=
X-Google-Smtp-Source: AGHT+IEDIreq9NhvguVaxPs0Vju0YrGVzBh0qvZatLbbH6y1TmpJPcLpquRHF23uXlc/QBm1RI5WpB0iAMvSilowB5E=
X-Received: by 2002:a17:907:26c9:b0:ad2:52c3:2083 with SMTP id
 a640c23a62f3a-ad85b0fa46dmr220564866b.28.1748096588836; Sat, 24 May 2025
 07:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250504132356.2317305-2-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
 <CAFLszTi6LwvSoNtThF5DzKjJNFzJxB5rk5DjYi9wzsfkiwwjcg@mail.gmail.com>
 <20250523140455.GP100073@bill-the-cat>
 <CAFLszTj1v7dhvdj9vM70OP=Bb8j3FArYHS3SGcpnJO31z3Ns1g@mail.gmail.com>
 <20250523164717.GU100073@bill-the-cat>
 <CAFLszTg0CO5PqagaAZNov-N4rv6D17iUV_qnAasJ336zW=eG9w@mail.gmail.com>
 <20250523212539.GX100073@bill-the-cat>
 <CAFLszTioW78gyU2qK+-E5CcjyTAatvFuodWV3NKuwq5anBGdpg@mail.gmail.com>
 <20250524141805.GB100073@bill-the-cat>
In-Reply-To: <20250524141805.GB100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 May 2025 15:22:57 +0100
X-Gm-Features: AX0GCFufbAHcHMpAxT83zCis0pjOQKu5cBfCXmzf98jT-ioghAq-521ArC0bUhU
Message-ID: <CAFLszTj=6W2miuLkU0Acbi-HBNSAiq-9YfwdOu0-+OSSy9+gvw@mail.gmail.com>
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

On Sat, 24 May 2025 at 15:18, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, May 24, 2025 at 05:23:48AM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 23 May 2025 at 22:25, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, May 23, 2025 at 09:20:37PM +0100, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 23 May 2025 at 17:47, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, May 23, 2025 at 05:32:36PM +0100, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Fri, 23 May 2025 at 15:04, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Fri, May 23, 2025 at 08:19:30AM -0500, Simon Glass wrote:
> > > > > > > > It is easier for tests if the top-level control logic is all in one
> > > > > > > > module. Create a new do_patman() function to handle this. Move the
> > > > > > > > existing code into it.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > (no changes since v1)
> > > > > > > >
> > > > > > > >  tools/patman/__main__.py | 49 ++----------------------------------
> > > > > > > >  tools/patman/control.py  | 54 ++++++++++++++++++++++++++++++++++++++--
> > > > > > > >  2 files changed, 54 insertions(+), 49 deletions(-)
> > > > > > > >
> > > > > > > > Applied to sjg/master, thanks!
> > > > > > >
> > > > > > > Odd. I thought you had posted this against master or next, intending it
> > > > > > > for mainline, which is why I assigned it to you in patchwork. I see the
> > > > > > > cover letter is missing what commit it's against. And instead here you
> > > > > > > are once again spamming the list and with messages about your personal
> > > > > > > tree. Why?
> > > > > >
> > > > > > I'm applying it to my tree and intend to send you a PR at some point,
> > > > > > with collected tools/ patches. So I believe I need to send emails
> > > > > > about applying things and update it in patchwork. Let's discuss this
> > > > > > in a future call.
> > > > >
> > > > > I don't see what there is to discuss. Please follow the normal process
> > > > > for mainline and stop spamming the list with notices for your personal
> > > > > tree. You're also diverging your own tree further from mainline by doing
> > > > > this and making it less likely (multiple people have told you they don't
> > > > > want to review things not against mainline) any follow-up work will get
> > > > > comments other than that it's not applicable to mainline.
> > > >
> > > > For patman, I have another series [1] I'm planning to apply to my tree tomorrow
> > > >
> > > > Would you like me to send 'applied' emails for it to the mailing list?
> > > > Or perhaps just for the cover letter? Would you like me to send you a
> > > > pull request?
> > > >
> > > > Regards,
> > > > Simon
> > > >
> > > > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=456256
> > >
> > > Yes, that's another series that while I disagree with the direction
> > > you're taking things, would rather apply to mainline than let it bitrot
> > > in mainline. So please send a PR against next. And that would also apply
> > > to the series this email is in reply to. As again, I had expected it for
> > > mainline and not your downstream tree even if I think we (and our users)
> > > would all benefit from managing the python portions differently.
> >
> > OK, once I have applied the remaining two series I will send a PR.
>
> Based on the emails in my inbox this morning, you're doing the opposite
> of what I asked for. But maybe this afternoon will bring something
> different.
>
> > You didn't express a preference for the 'applied' emails. It seems
> > better to send these emails so that there is a record of the patch
> > being applied.
>
> I guess I wasn't clear enough. Stop spamming the list with *anything*
> about your personal tree. And if you're going to send anything about
> something that's intended for mainline, you should make patman act more
> like b4 and NOT send a message to every patch. I know I used to, but the
> workflow b4 enables is much better for everyone.

How do I (or anyone else) know whether a patch was applied? If you
only reply to the cover letter, doesn't that mean that the patches are
left 'hanging' in the mailing list?

I didn't know you had changed your policy on this...it certainly seems
odd to me. I often find Heinrich's patches are 'silently' applied, so
perhaps he does the same thing?

Regards,
SImon
