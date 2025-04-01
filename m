Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA099C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 15:45:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14D6781E6C;
	Tue,  1 Apr 2025 17:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S7QPhV2D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 247E981F59; Tue,  1 Apr 2025 17:45:52 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5A4481DE3
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 17:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac3eb3fdd2eso1054198966b.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 08:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743522349; x=1744127149; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H/ly3g1iIt52yaaQObreCXLqBcc2fUYkPUPujqt6TvI=;
 b=S7QPhV2DSVcvFt7MXgzyi+2bBNTaDmn9Ug79MYn/TCeyVQgBAPZbdW3cjiv6axutWx
 BChBUDr9p0QolLRJE0cxtCvR7YL0GZoNE0hsqCuKPLmYKGgpOrLCJYeLmwBCFJKex3MS
 kWslHRnr4w5En2LqyJN5c/QNOt3n1y9nXwbEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743522349; x=1744127149;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H/ly3g1iIt52yaaQObreCXLqBcc2fUYkPUPujqt6TvI=;
 b=oI1C6qmM8lwSJHH5zF/o6jjRgPAOUMcNHMvIGm6LeMeNCiCP8L+gQ3ObqFem//XhnV
 0rYf4MsW4LbCQxenlf5j2SUDVrj5+N6or5zEHFXogrIFTHNvexV09TBaqQ48doSPXjWX
 nJouttvuhvU4vmt0uNvcQjmdDr36vCYDn+ba9H2wItKaI5BJ7NdmSWedvNU3n4YbpSsa
 mBrPjQBFCQrhbFpsqDTIhdqpVoUbTqsTbRQzj6/FqcWAC4X7amiMzIscuD0Bvu6D07Zk
 fwCKFiqkhL0HshF/AM46vFIBQJt3IOEOHsI3AIy4Mcy+MOWzJLLhKdVEEc3JTdbroSin
 Pz9Q==
X-Gm-Message-State: AOJu0Yx+lN7jGtLNI6zFlEOZB+RuSQfvlfwfUF1mfb7QrB71sUCQ9iam
 z2h4UH5hlTVtWfTGCqCu1Tqy4dZio3Q3mYmB1WnKCua7GbYJadHjEEP23gTXDlWymcgJX6wRw1Y
 5o+RGJxxGpzBxZywNwX+IJCfJdOx+ybbVcA68
X-Gm-Gg: ASbGncsTA57EZLBPzLwg9mf5Hz4DZMITh77ApZyfs4jeuG3NOZ5odWqLk84BViaR2qO
 0sghSXP3nAdswrLz7Mc+pqKTmQGHdXHVuybHjRu+ASYLWQ1OUrsvbXFdrNXtynFomnczcquOlNX
 GTWU49ljSDE4ykwyl1vbTWhsYRWW3s
X-Google-Smtp-Source: AGHT+IHrNnDYxKSPfBZBAufge+GHLlpKz1vDqQ/mg1unLAcYl1WqKvP5TQpEVtY2Z6NUqHzmrLdVP+czk0q+E0ASbuI=
X-Received: by 2002:a17:907:7d8c:b0:ac3:8896:416f with SMTP id
 a640c23a62f3a-ac782b63ed1mr338958866b.15.1743522349061; Tue, 01 Apr 2025
 08:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTgnj+ZFq1vEcSSKCOeYjx0NKesO8Lo3aOJ2Nm-jhuTvig@mail.gmail.com>
 <20250224232303.GJ1233568@bill-the-cat>
 <CAFLszTgtdETGCYYtH3ni7Wv0W6Ckv1SoZRG8djQ-3uKBn1YZWQ@mail.gmail.com>
 <20250304152909.GZ2640854@bill-the-cat>
 <CAFLszTiNQSs51iE=rcM7qQjipmWCKZiPX+gV2ztb+ZAB8m2MBw@mail.gmail.com>
 <20250305162236.GT2640854@bill-the-cat>
 <CAFLszTjv54tYLHkG=RNeXJoZ+f-QHxMH=B_aU2=iOZhaoD7qKg@mail.gmail.com>
 <20250307144631.GN2640854@bill-the-cat>
 <20250310155336.GJ2640854@bill-the-cat>
 <CAFLszTirohLrKadFfdw28UMfH7nt2owKHOGdf-ehwQqemQUpDA@mail.gmail.com>
 <20250331155144.GX93000@bill-the-cat>
In-Reply-To: <20250331155144.GX93000@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Apr 2025 04:45:37 +1300
X-Gm-Features: AQ5f1Jp_8jAvislzhrek1w0OwCjKFOdUIMadC69xdu-9so1x1fQcWhxrc7mKKf4
Message-ID: <CAFLszTjNXzkVe_OULMOtt2imSD5KY-KPMgxT7FA=fFqnm0aaeA@mail.gmail.com>
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

On Tue, 1 Apr 2025 at 04:51, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Mar 28, 2025 at 11:42:20PM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 10 Mar 2025 at 09:53, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Mar 07, 2025 at 08:46:31AM -0600, Tom Rini wrote:
> > > > On Thu, Mar 06, 2025 at 09:10:47AM -0700, Simon Glass wrote:
> > > [snip]
> > > > > Again, back to this thread, if you want me to migrate things, consider
> > > > > applying the sunxi patches as I have described above. I will then look
> > > > > at the next target for bootstd. But while you hold this up, I cannot
> > > > > move forward with more bootstd migration. It doesn't seem that much to
> > > > > ask.
> > > >
> > > > I will take another look at what's still relevant. But I believe it's
> > > > still blocked on the fact that it changes behavior and breaks users.
> > >
> > > In details:
> > >
> > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-2-sjg@chromium.org/
> > >
> > > Now that the underlying BLK problem is resolved, this can just be
> > > dropped I believe. Removing the BLK dependency from BOOTSTD can happen
> > > when you're supporting a flow that lacks a BLK device entirely. This
> > > would be another reminder as to why putting unrelated changes in a
> > > series is a problem.
> >
> > OK, then just don't apply this patch. Problem solved?
>
> Well, for a hypothetical v6 you would not include it, sure.
>
> > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-3-sjg@chromium.org/
> > >
> > > This is fine.
> > >
> > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-4-sjg@chromium.org/
> > >
> > > This is not fine. This is also not a sunxi problem. It means that we
> > > should drop bootmgr from rockchip, where the conversion has already
> > > taken place, and would need to drop it from future conversion too.
> > > Neither of which are desirable changes.
> >
> > Why do you say that? I don't understand how this relates to rockchip
> > or why we would need to drop bootmgr from that.
>
> Then you don't have enough of a grasp of the details of the area you're
> trying to solve problems in? Or maybe you need to refresh yourself on
> the details of the area you're trying to work in.

Or perhaps there isn't a problem? The sunxi case is special because we
have a FEL boothmeth. That isn't present on rockchip, for example.

>
> > > This patch in particular is
> > > where we have the note:
> > >
> > > "Yes, the introduction of boot standard changed the boot order and
> > > specifically deprioritizing scripts is unexpected."
> > >
> > > Which should have had more attention than it did.
> >
> > From memory the scripts are a fallback used when the other things
> > don't work, so that was the decision I made at the time.
>
> The key point being we changed behavior that others depended on, and
> didn't document it well and didn't make sure the change would work for
> them either.
>
> > > This is the thread that to me spelled out in details where the
> > > conversions are now blocked. We changed behavior and that in turn breaks
> > > users that have come to rely on ordering.
> >
> > I don't know what action to take on that comment. We cannot have 100%
> > backwards compatibility with the scripts, which after all weren't even
> > documented. But it is very close.
>
> You need to get feedback from the people you want to migrate from the
> scripts and ordering and rely on to something else and see what works
> for them.
>
> > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-5-sjg@chromium.org/
> > >
> > > Is an alternative to the above which then turned in to a discussion that
> > > I would very briefly summarize as "no discussions were had between
> > > stakeholders before integrating efi bootmgr with bootstd".
> > >
> > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-6-sjg@chromium.org/
> > >
> > > This is fine, but only relevant once migration happens.
> > >
> > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-7-sjg@chromium.org/
> > >
> > > If Andre is fine with this, this is fine.
> > >
> > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-8-sjg@chromium.org/
> > >
> > > This is a generic bugfix. I will take this to next today.
> > >
> > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-9-sjg@chromium.org/
> > >
> > > If Andre is fine with this, this is fine.
> >
> > Well, is he? I thought he was. Can you check?
>
> You're free to. It's one of the innumerable examples of why when you
> group multiple things in a series and there's problems with another part
> of the series, unrelated changes get dropped.

It would be easier for me if you could apply the patches as I've suggested.

But if you are willing to apply these patches and just want me to send
the series again without the BLK and RFC patches, I can do that.
Please let me know either way.

Regards,
Simon
