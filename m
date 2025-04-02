Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB903C36018
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 19:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E70781E1F;
	Wed,  2 Apr 2025 21:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OGmuhOki";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA0CF81F0D; Wed,  2 Apr 2025 21:22:30 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5006580050
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 21:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac2dfdf3c38so20094666b.3
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 12:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743621748; x=1744226548; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tv24eyojKh+dBKgG8To9hxYO/r8ze6wcws/dDbOSbMA=;
 b=OGmuhOkijDScwLrC6+mFkEQ+85xbD5KIZgs+zAka7orh4xUBUKZ+kt8VjuM84C/Tsk
 CvfUYGHaRcgCtjH16fw20jOuJm6vGABrLouYMNRJYKMjqt87VkBRdA/jbLrkG6MHalL6
 0UZS5X6um37c5VBPGLd0NZ6mQ3dxiuzpE5TtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743621748; x=1744226548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tv24eyojKh+dBKgG8To9hxYO/r8ze6wcws/dDbOSbMA=;
 b=ZoAFTWbMTfCSsNzfX2GmER0noa1HX3wiqmxGYU9/vND8UkgiB1iol2AWEsAJYlIi6T
 Q3O+v38cDtToEt1eUfr/Pom2WQNDrxNq36CMTrhpQ3TwvQMR737vqp/STBhpV50biS4+
 6oQn9gmagu+1CmYW9iKbZE5HtfZv3lCiP/S0cwY3i394phLZXOC+7oyyCwAkcJl5WyD1
 0bTSlQOPjp1nFaFjgsRpa676imxHTaK9EabQ7jDEywmc2b8cDYSWhyU/TE2JL3FHWSfd
 oH/Y3w3RrRYG0Es6VaWZRsr47yhahq8n/BxXc/7gLBkU+HqkDE9MI7QE/e2Z8OZNCH3R
 71CQ==
X-Gm-Message-State: AOJu0Yx+4LBz5Ymrd0x2uiyoc6r+8xMe+J7Si2X8iwVGCjGyL4+YsYTH
 8cUTZffm3fof7vASjqB0l2Hp5bXDKAJ2Gvolx7XL3KFs5Lg5bj/gm2xAtyXZl+0Smo1KN9dsUec
 Mqs/gXBlmRmQbF3gZcp5wNPIQCEsDLA6dylLl
X-Gm-Gg: ASbGncvbPySIJtc6uxP0QAcPxWMTH4jyNmvy1yoI6el5mqlFF1MuqYPI0SQBhLvAEk7
 8pxZyuyFTLj3EQTtXR4RCxCZy1+259smBwXAcg6WhwwN42foom91iuUnaF0d3nilqgJqOm2UCGA
 mwTSmhogiIJY8EXNlsZ3E6LjddgVCQ
X-Google-Smtp-Source: AGHT+IGOJtLOPa8sbPwCdSyQs3QTEPfLugELQM8NAK5ldcDqs8XkXT6UjRLd58TvRkprkRRjJkM74Y3MZJaTARxwu+k=
X-Received: by 2002:a17:907:6e90:b0:ac6:d0f6:c85c with SMTP id
 a640c23a62f3a-ac738aa34d8mr1631840066b.20.1743621747449; Wed, 02 Apr 2025
 12:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTgtdETGCYYtH3ni7Wv0W6Ckv1SoZRG8djQ-3uKBn1YZWQ@mail.gmail.com>
 <20250304152909.GZ2640854@bill-the-cat>
 <CAFLszTiNQSs51iE=rcM7qQjipmWCKZiPX+gV2ztb+ZAB8m2MBw@mail.gmail.com>
 <20250305162236.GT2640854@bill-the-cat>
 <CAFLszTjv54tYLHkG=RNeXJoZ+f-QHxMH=B_aU2=iOZhaoD7qKg@mail.gmail.com>
 <20250307144631.GN2640854@bill-the-cat>
 <20250310155336.GJ2640854@bill-the-cat>
 <CAFLszTirohLrKadFfdw28UMfH7nt2owKHOGdf-ehwQqemQUpDA@mail.gmail.com>
 <20250331155144.GX93000@bill-the-cat>
 <CAFLszTjNXzkVe_OULMOtt2imSD5KY-KPMgxT7FA=fFqnm0aaeA@mail.gmail.com>
 <20250401171822.GM5495@bill-the-cat>
In-Reply-To: <20250401171822.GM5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 3 Apr 2025 08:22:13 +1300
X-Gm-Features: AQ5f1JoIfsTc-Q8_xiawxhCBuyiC7zRCeWheXvvKTx_9pRvFibwJ-WyQ5q1gXSM
Message-ID: <CAFLszTjzxXW_SdDMbjPKitgQ6HSv3Vse6ANrr5QEr85A1byyHg@mail.gmail.com>
Subject: Re: Rate of innovation in the project (Was: Re: Rate of change in the
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

On Wed, 2 Apr 2025 at 06:18, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Apr 02, 2025 at 04:45:37AM +1300, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 1 Apr 2025 at 04:51, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Mar 28, 2025 at 11:42:20PM +0000, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 10 Mar 2025 at 09:53, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Mar 07, 2025 at 08:46:31AM -0600, Tom Rini wrote:
> > > > > > On Thu, Mar 06, 2025 at 09:10:47AM -0700, Simon Glass wrote:
> > > > > [snip]
> > > > > > > Again, back to this thread, if you want me to migrate things, consider
> > > > > > > applying the sunxi patches as I have described above. I will then look
> > > > > > > at the next target for bootstd. But while you hold this up, I cannot
> > > > > > > move forward with more bootstd migration. It doesn't seem that much to
> > > > > > > ask.
> > > > > >
> > > > > > I will take another look at what's still relevant. But I believe it's
> > > > > > still blocked on the fact that it changes behavior and breaks users.
> > > > >
> > > > > In details:
> > > > >
> > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-2-sjg@chromium.org/
> > > > >
> > > > > Now that the underlying BLK problem is resolved, this can just be
> > > > > dropped I believe. Removing the BLK dependency from BOOTSTD can happen
> > > > > when you're supporting a flow that lacks a BLK device entirely. This
> > > > > would be another reminder as to why putting unrelated changes in a
> > > > > series is a problem.
> > > >
> > > > OK, then just don't apply this patch. Problem solved?
> > >
> > > Well, for a hypothetical v6 you would not include it, sure.
> > >
> > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-3-sjg@chromium.org/
> > > > >
> > > > > This is fine.
> > > > >
> > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-4-sjg@chromium.org/
> > > > >
> > > > > This is not fine. This is also not a sunxi problem. It means that we
> > > > > should drop bootmgr from rockchip, where the conversion has already
> > > > > taken place, and would need to drop it from future conversion too.
> > > > > Neither of which are desirable changes.
> > > >
> > > > Why do you say that? I don't understand how this relates to rockchip
> > > > or why we would need to drop bootmgr from that.
> > >
> > > Then you don't have enough of a grasp of the details of the area you're
> > > trying to solve problems in? Or maybe you need to refresh yourself on
> > > the details of the area you're trying to work in.
> >
> > Or perhaps there isn't a problem? The sunxi case is special because we
> > have a FEL boothmeth. That isn't present on rockchip, for example.
>
> Again, you seem to have forgotten what the problems with the series
> were.

No, it's just that we disagree on the path forward.

>
> > > > > This patch in particular is
> > > > > where we have the note:
> > > > >
> > > > > "Yes, the introduction of boot standard changed the boot order and
> > > > > specifically deprioritizing scripts is unexpected."
> > > > >
> > > > > Which should have had more attention than it did.
> > > >
> > > > From memory the scripts are a fallback used when the other things
> > > > don't work, so that was the decision I made at the time.
> > >
> > > The key point being we changed behavior that others depended on, and
> > > didn't document it well and didn't make sure the change would work for
> > > them either.
> > >
> > > > > This is the thread that to me spelled out in details where the
> > > > > conversions are now blocked. We changed behavior and that in turn breaks
> > > > > users that have come to rely on ordering.
> > > >
> > > > I don't know what action to take on that comment. We cannot have 100%
> > > > backwards compatibility with the scripts, which after all weren't even
> > > > documented. But it is very close.
> > >
> > > You need to get feedback from the people you want to migrate from the
> > > scripts and ordering and rely on to something else and see what works
> > > for them.
> > >
> > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-5-sjg@chromium.org/
> > > > >
> > > > > Is an alternative to the above which then turned in to a discussion that
> > > > > I would very briefly summarize as "no discussions were had between
> > > > > stakeholders before integrating efi bootmgr with bootstd".
> > > > >
> > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-6-sjg@chromium.org/
> > > > >
> > > > > This is fine, but only relevant once migration happens.
> > > > >
> > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-7-sjg@chromium.org/
> > > > >
> > > > > If Andre is fine with this, this is fine.
> > > > >
> > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-8-sjg@chromium.org/
> > > > >
> > > > > This is a generic bugfix. I will take this to next today.
> > > > >
> > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-9-sjg@chromium.org/
> > > > >
> > > > > If Andre is fine with this, this is fine.
> > > >
> > > > Well, is he? I thought he was. Can you check?
> > >
> > > You're free to. It's one of the innumerable examples of why when you
> > > group multiple things in a series and there's problems with another part
> > > of the series, unrelated changes get dropped.
> >
> > It would be easier for me if you could apply the patches as I've suggested.
> >
> > But if you are willing to apply these patches and just want me to send
> > the series again without the BLK and RFC patches, I can do that.
> > Please let me know either way.
>
> Again, you should:
> - Take the non-bootstd sunxi enhancements, rebase them to next and post
>   for Andre. By themselves. This way they won't get stuck.

There's no point, though, since it doesn't provide the bootstd migration.

> - You should work with Heinrich to come up with something that handles
>   efi bootmanager and bootstd without breaking how our actual project
>   users use us.
>   There's no reason to migrate *more* platforms until we have this
>   fundamental problem sorted out.

It isn't actually a fundamental problem at all. We shouldn't even be
discussing this and it is really unfortunate that you continue to
block this effort.

As to bootmgr, I would be willing to implement a solution here, but it
would involve changes to how bootmgr works under the hood, i.e. to
have it be iterative instead of doing everything at the start. My firm
understanding is that such changes would not be acceptable to
Ilias/Heinrich and anyway I am unable to get patches into the EFI
subsystem.

So the fallback is the work-around which Heinrich proposed. He is free
to implement that if he likes, but I am not planning to do this myself
as I see it as a short-term measure and it may cause problems for
bootstd, as did f2bfa0cb1 which I bitterly regret allowing in (but I
suppose they were happier days before everything froze up).

> - You should work with any FOSS distributions to get their feedback on
>   what would make their life easier, from a user of U-Boot perspective.
>   bootstd won't be useful if it's not something our users want to use.

Bootstd is designed to replace the distro scripts and the feedback I
have received is that it is good at that. If you have any other
feedback, or any suggestions on people I should contact, I'm happy to
approach them, or they can email the list and cc me.

But really, it would be a lot easier if you could just apply this
series so we can move on. If I can see even just a glimmer of
compromise here it will help my confidence.

Regards,
Simon
