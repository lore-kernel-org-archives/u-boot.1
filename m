Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9995DEEAA7B
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 22:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92EC886661;
	Fri, 15 Sep 2023 00:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nd7WzhBp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C890865FB; Fri, 15 Sep 2023 00:42:04 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02BE686661
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 00:42:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99357737980so200830666b.2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 15:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694731321; x=1695336121; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FdnHcOICU3ShaVB232uLyizLPfFpHKQDV0gCnldBz4k=;
 b=nd7WzhBp+fIy/hwGhm6oxTBJ8RhIqXk8xrWqr7RXKmw16FOTS1ChcoCturWbqlNd/y
 S5moAanB0plXovWFYV5we5tjy+BgBjFYO5pQJBzXwADO3OffmNoShObNwM0YdmUbzvEX
 fYYWYt2rcUYtFy/o1GnbZKKfPXdEYk76RTvGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694731321; x=1695336121;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FdnHcOICU3ShaVB232uLyizLPfFpHKQDV0gCnldBz4k=;
 b=dBQCzYvTgqSk8xEWqtr+xncEnf5mqAT6EU81HtyT2r4fMHIWN5mAb7Q44AEvyhDsx1
 S+8z9/i6fiiaWjKglSsacgAVXkwUaDMyLP2X3i0fndZKhEjLq6HVux4D8HC4a2EmaJ2i
 Np6QraNbbRxaj+rGWfOuaECmRsFffYBcqkz4288RTekFSGStKdjiTOE+zahP/RhcS/Y5
 gr/yStxYml7V6J1G7bwkLIu2g+JPVEF4kXVU7OhFMu1Bg3GX7+GlGC0sfcOjXiFftpkk
 jrQqIESZtr3IsCeKLKc0i5LWmrDzm11CdqO2DFsvlKtC/yWBVVJ3adiDn8Sx0Lk9PUq4
 C1UA==
X-Gm-Message-State: AOJu0YxEHn9nG3zsbDm7+X6QvplVHPE5mCnqoKZqFWMtFUKGxyQHKv+l
 +w0hQxHsEY4WyjmvnoZtpWJ8iIdu3LgVYabRqzP7Nw==
X-Google-Smtp-Source: AGHT+IHQJ4OWw/kirj96Blr6sGvP+71hDRC1QoOSJGh47HHc8ATlrCNB+Q7qCaJMiK2uNLLu0P6dFLHpoErA6pmhKdY=
X-Received: by 2002:a17:907:78d8:b0:9aa:209f:20c2 with SMTP id
 kv24-20020a17090778d800b009aa209f20c2mr6303642ejc.54.1694731321229; Thu, 14
 Sep 2023 15:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
 <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
 <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
 <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
 <20230906142139.GA1236014-robh@kernel.org> <ZPldgbS8mu+5DG7Q@hera>
 <CAPnjgZ0kcOZp65d_-wwYyjbTwC-aDamvGU50aa34o2PeZjZk6Q@mail.gmail.com>
 <CABb+yY0VJDu+L2C10E1O-uAU-p0OwuTq6XVF2XbYuOc2fBqoww@mail.gmail.com>
 <875y4kh77c.fsf@bloch.sibelius.xs4all.nl>
 <CAL_JsqKehgMGReC2GZseCy5JufgL9on9NTu7Bouh9-kUDFmfSQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKehgMGReC2GZseCy5JufgL9on9NTu7Bouh9-kUDFmfSQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 14 Sep 2023 16:41:43 -0600
Message-ID: <CAPnjgZ2CaLg2=Bbda0suwP8wYAM7H2iO-9U_Tw9tbxKu-YAnpA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
To: Rob Herring <robh@kernel.org>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>,
 Jassi Brar <jassisinghbrar@gmail.com>, 
 ilias.apalodimas@linaro.org, pbrobinson@gmail.com, sughosh.ganu@linaro.org, 
 u-boot@lists.denx.de, trini@konsulko.com, xypron.glpk@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Rob,

On Wed, 13 Sept 2023 at 16:39, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Sep 8, 2023 at 1:06=E2=80=AFPM Mark Kettenis <mark.kettenis@xs4al=
l.nl> wrote:
> >
> > > From: Jassi Brar <jassisinghbrar@gmail.com>
> > > Date: Fri, 8 Sep 2023 09:37:12 -0500
> > >
> > > Hi Simon,
> > >
> > > On Thu, Sep 7, 2023 at 3:08=E2=80=AFPM Simon Glass <sjg@chromium.org>=
 wrote:
> > > > On Wed, 6 Sept 2023 at 23:20, Ilias Apalodimas
> > > > >
> > > > > > > I beg to differ. Devicetree is more than just hardware and al=
ways has
> > > > > > > been. See, for example the /chosen and /options nodes.
> > > > > >
> > > > > > There are exceptions...
> > > > > >
> > > > >
> > > > > We've been this over and over again and frankly it gets a bit ann=
oying.
> > > > > It's called *DEVICE* tree for a reason.  As Rob pointed out there=
 are
> > > > > exceptions, but those made a lot of sense.  Having arbitrary inte=
rnal ABI
> > > > > stuff of various projects in the schema just defeats the definiti=
on of a
> > > > > spec.
> > > >
> > > > Our efforts should not just be about internal ABI, but working to
> > > > provide a consistent configuration system for all firmware elements=
.
> > > >
> > > Sure, programmatically we can pass any data/info via DT, however it i=
s
> > > only meant to map hardware features onto data structures.
> > >
> > > devicetree.org  landing page
> > >     "The devicetree is a data structure for describing hardware."
> > >
> > > devicetree-specification-v0.3.pdf  Chapter-2 Line-1
> > >    "DTSpec specifies a construct called a devicetree to describe
> > > system hardware."
> >
> > But it doesn't say that it describes *only* hardware.  And it does
> > describe more than just hardware.  There is /chosen to specify
> > firmware configuration and there are several examples of device tree
> > bindings that describe non-discoverable firmware interfaces in the
> > Linux tree.  And it has been that way since the days of IEEE 1275.
> > There are also bindings describing things like the firmware partition
> > layout.
>
> Yes. The exact title for 1275[1] is: IEEE Standard for Boot
> (Initialization Configuration)
> Firmware: Core Requirements and Practices
>
> I see "configuration" in there. However, in the OF case, it's
> generally how firmware configured the hardware and what it discovered.
> That's a little different than telling the OS how to configure the
> hardware which is what we do with FDT.

For the /options node it says "The properties of this node are the
system=E2=80=99s configuration variables."

Then there is section 7.4.4 which has a large list of options which
don't seem to be so narrowly defined.

In any case, this is not quite the point, which IMO is that we need DT
to support firmware use cases, whether or not a 29-year-old spec
thought of it or not. In fact it is amazing to me how forward-looking
Open Firmware was.

> Then there's stuff that's how
> to configure Linux which we try to reject.

Fair enough: Linux has user-space for that.

>
> Once we get into configuration of the OS/client (including u-boot),
> making that an ABI is a lot harder and if we use DT for that, I don't
> think it should be an ABI.
>
> > > If we want to digress from the spec, we need the majority of
> > > developers to switch sides :)  which is unlikely to happen and rightl=
y
> > > so, imho.
> >
> > It isn't even clear what the spec is.  There is the document you
> > reference above, there are the yaml files at
> > https://github.com/devicetree-org/dt-schema and then there are
> > additional yaml files in the Linux tree.  As far as I know it isn't
> > written down anywhere that those are the only places where device tree
> > bindings can live.
>
> There's not any restriction.
>
> My intention with dtschema schemas is to only have "spec level"
> schemas. (Stuff we'd add to DTSpec (but don't because no one wants to
> write specs).) Hardware specific stuff lives somewhere else. That
> happens to be the Linux tree because that is where all the h/w support
> is (nothing else is close (by far)). Last I checked, we've got ~3700
> schemas and ~1500 unconverted bindings.

That scope is quite a bit narrower than I understood it to be. It
seems to leave a significant gap between the Linux repo and yours.

>
> > Anyway, let's face it, there is some consensus among developers that
> > what Simon has done in U-Boot is pushing the use of devicetree beyond
> > the point where a significant fraction of developers thinks it makes
> > sense.  And I think I agree with that.  But you can't beat him with
> > the spec to make your point.
> >
> > Now the devicetree is cleverly constructed such that it is possible to
> > define additional bindings without the risk of conflicting with
> > bindings developed by other parties.  In particular if U-Boot is
> > augmenting a device tree with properties that are prefixed with
> > "u-boot," this isn't going to hurt an operating system that uses such
> > an augmented device tree.
>
> Until someone has some great idea to start using them. If the OS
> doesn't need something, then why pass it in the first place? What
> purpose does it serve? It's an invitation for someone somewhere to
> start using them.
>
> The downside of keeping the nodes is it creates an ABI where there
> doesn't need to be one necessarily.

I'd love to get away from the idea that DT is just for the OS. We are
trying to use it for firmware-to-firmware communication, too. The
programs on each side of that interface may be different projects. For
that, we do need to have a binding, otherwise we end up with series
like this one.

>
> > The real problem is that some folks developed a certification program
> > that allegedly requires schema verification and now propose adding
> > code to U-Boot that doesn't really solve any problem.  My proposed
> > solution would be to change said certification program to allow
> > firmware to augment the device tree with properties and nodes with
> > compatibles that are in the namespace controlled by the firmware.
>
> I don't think we should decide what to do here based on said
> certification program. It can adapt to what's decided. Probably, the
> /option nodes will be stripped out or ignored for certification.
>
> I accepted u-boot options node schema into dtschema, but now have
> second thoughts on that. Now I'm getting more u-boot specific
> (perhaps, not clear) stuff and widevine stuff internal to a TEE.

Where should these bindings go such that ARM / Linaro are not trying
to remove them? I would be OK with moving them out somewhere else, but
how are people supposed to deal with such fragmentation? My
understanding was that dt-schema was an attempt to set up a neutral
area where bindings could be accepted that were not just for
Linux...did that change?

U-Boot is certainly the firmware project that is trying hardest to
clean up things in this area...but it isn't the only consumer of these
bindings. Given that we invent a new bootloader about every 6 months,
I'm pretty sure the number of consumers will grow.

Regards,
Simon
