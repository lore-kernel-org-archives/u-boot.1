Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9C3E71072
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 13:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C309886637;
	Thu, 21 Sep 2023 15:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rvzPt8PF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B4AB867D2; Thu, 21 Sep 2023 15:59:12 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97302865D0
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 15:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=robh@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 06805B8204F
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 13:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F05C4E74F
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 13:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695304747;
 bh=wmDEKK6r47kpf+ld+hdkPk5u7i4BMiRX1uACfDM/WCw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=rvzPt8PFShH5jzht8DckmkGMPmKbUom2U7gRbjKOUwRBeaK7gNC26KKbY4EtaWHEA
 jwShW1O+VD641uBKjzqMFkyttT0pLh1T8k+OLQ8fwoyMvVtmgUBa6Q/8lcbHFZICEu
 BeY+4GXTb8Elpme1JCtQ2Nh2Ww5jpUfK7aLu6MXyX0bD5uK105aKxrqDQMklJFkC9l
 hmB5AOb5CDBKaJSGHepA3CgR3x1RqUb8yrVWJNslXArWYg3ulTPHdJ7TWOI0qMjgxP
 sUD7HFRbq4LmnKLXvylRjStp0rhkSd7uCLjPsxZ687x8l+RLF1hKyFwKqAM8ZaI1Yg
 8TttPqCtkymVQ==
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-503012f4e71so2537317e87.0
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 06:59:07 -0700 (PDT)
X-Gm-Message-State: AOJu0YyvJi0bxtBSWJfzvbLbKo5IOnt7EhxZFlyAY0GxcVBLahqzJxNh
 Zx1uFLFYhg/NXfzHo1dpClZkk1MsmSRn0HynBg==
X-Google-Smtp-Source: AGHT+IFH9qLgXlKcp+tDgQYzWGQz4qMwsZXOqN8oiEoDFfZ+HnuBiyGlfAUt4/+G/Om8uT/ukpsfA3Jjb42wa6/Hsds=
X-Received: by 2002:ac2:57cd:0:b0:503:a1b:d0c5 with SMTP id
 k13-20020ac257cd000000b005030a1bd0c5mr1974289lfo.14.1695304745680; Thu, 21
 Sep 2023 06:59:05 -0700 (PDT)
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
 <CAPnjgZ2CaLg2=Bbda0suwP8wYAM7H2iO-9U_Tw9tbxKu-YAnpA@mail.gmail.com>
 <CAL_JsqKh8BtWvhr6YFcZmzQ01U6QyY3vtLj6kvFTEdgtGWJM7g@mail.gmail.com>
 <CAPnjgZ15yqzJ64U7sk8MGurGKrLe=6tHKbi0YrXne95_HUtPuQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ15yqzJ64U7sk8MGurGKrLe=6tHKbi0YrXne95_HUtPuQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 21 Sep 2023 08:58:52 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+p6dv1gHB_M+BmMFpFyLE6qqHDgemhWn8O5KnT27aHHA@mail.gmail.com>
Message-ID: <CAL_Jsq+p6dv1gHB_M+BmMFpFyLE6qqHDgemhWn8O5KnT27aHHA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
To: Simon Glass <sjg@chromium.org>
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

On Tue, Sep 19, 2023 at 3:26=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Rob,
>
> On Mon, 18 Sept 2023 at 11:00, Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Sep 14, 2023 at 5:42=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Rob,
> > >
> > > On Wed, 13 Sept 2023 at 16:39, Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Fri, Sep 8, 2023 at 1:06=E2=80=AFPM Mark Kettenis <mark.kettenis=
@xs4all.nl> wrote:
> > > > >
> > > > > > From: Jassi Brar <jassisinghbrar@gmail.com>
> > > > > > Date: Fri, 8 Sep 2023 09:37:12 -0500
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Thu, Sep 7, 2023 at 3:08=E2=80=AFPM Simon Glass <sjg@chromiu=
m.org> wrote:
> > > > > > > On Wed, 6 Sept 2023 at 23:20, Ilias Apalodimas
> > > > > > > >
> > > > > > > > > > I beg to differ. Devicetree is more than just hardware =
and always has
> > > > > > > > > > been. See, for example the /chosen and /options nodes.
> > > > > > > > >
> > > > > > > > > There are exceptions...
> > > > > > > > >
> > > > > > > >
> > > > > > > > We've been this over and over again and frankly it gets a b=
it annoying.
> > > > > > > > It's called *DEVICE* tree for a reason.  As Rob pointed out=
 there are
> > > > > > > > exceptions, but those made a lot of sense.  Having arbitrar=
y internal ABI
> > > > > > > > stuff of various projects in the schema just defeats the de=
finition of a
> > > > > > > > spec.
> > > > > > >
> > > > > > > Our efforts should not just be about internal ABI, but workin=
g to
> > > > > > > provide a consistent configuration system for all firmware el=
ements.
> > > > > > >
> > > > > > Sure, programmatically we can pass any data/info via DT, howeve=
r it is
> > > > > > only meant to map hardware features onto data structures.
> > > > > >
> > > > > > devicetree.org  landing page
> > > > > >     "The devicetree is a data structure for describing hardware=
."
> > > > > >
> > > > > > devicetree-specification-v0.3.pdf  Chapter-2 Line-1
> > > > > >    "DTSpec specifies a construct called a devicetree to describ=
e
> > > > > > system hardware."
> > > > >
> > > > > But it doesn't say that it describes *only* hardware.  And it doe=
s
> > > > > describe more than just hardware.  There is /chosen to specify
> > > > > firmware configuration and there are several examples of device t=
ree
> > > > > bindings that describe non-discoverable firmware interfaces in th=
e
> > > > > Linux tree.  And it has been that way since the days of IEEE 1275=
.
> > > > > There are also bindings describing things like the firmware parti=
tion
> > > > > layout.
> > > >
> > > > Yes. The exact title for 1275[1] is: IEEE Standard for Boot
> > > > (Initialization Configuration)
> > > > Firmware: Core Requirements and Practices
> > > >
> > > > I see "configuration" in there. However, in the OF case, it's
> > > > generally how firmware configured the hardware and what it discover=
ed.
> > > > That's a little different than telling the OS how to configure the
> > > > hardware which is what we do with FDT.
> > >
> > > For the /options node it says "The properties of this node are the
> > > system=E2=80=99s configuration variables."
> > >
> > > Then there is section 7.4.4 which has a large list of options which
> > > don't seem to be so narrowly defined.
> > >
> > > In any case, this is not quite the point, which IMO is that we need D=
T
> > > to support firmware use cases, whether or not a 29-year-old spec
> > > thought of it or not. In fact it is amazing to me how forward-looking
> > > Open Firmware was.
> > >
> > > > Then there's stuff that's how
> > > > to configure Linux which we try to reject.
> > >
> > > Fair enough: Linux has user-space for that.
> >
> > Yep, the question I usually ask is who needs to configure something
> > and what determines the config. Changing things with sysfs is much
> > easier than changing the DT provided by firmware.
> >
> > > >
> > > > Once we get into configuration of the OS/client (including u-boot),
> > > > making that an ABI is a lot harder and if we use DT for that, I don=
't
> > > > think it should be an ABI.
> > > >
> > > > > > If we want to digress from the spec, we need the majority of
> > > > > > developers to switch sides :)  which is unlikely to happen and =
rightly
> > > > > > so, imho.
> > > > >
> > > > > It isn't even clear what the spec is.  There is the document you
> > > > > reference above, there are the yaml files at
> > > > > https://github.com/devicetree-org/dt-schema and then there are
> > > > > additional yaml files in the Linux tree.  As far as I know it isn=
't
> > > > > written down anywhere that those are the only places where device=
 tree
> > > > > bindings can live.
> > > >
> > > > There's not any restriction.
> > > >
> > > > My intention with dtschema schemas is to only have "spec level"
> > > > schemas. (Stuff we'd add to DTSpec (but don't because no one wants =
to
> > > > write specs).) Hardware specific stuff lives somewhere else. That
> > > > happens to be the Linux tree because that is where all the h/w supp=
ort
> > > > is (nothing else is close (by far)). Last I checked, we've got ~370=
0
> > > > schemas and ~1500 unconverted bindings.
> > >
> > > That scope is quite a bit narrower than I understood it to be. It
> > > seems to leave a significant gap between the Linux repo and yours.
> > >
> > > >
> > > > > Anyway, let's face it, there is some consensus among developers t=
hat
> > > > > what Simon has done in U-Boot is pushing the use of devicetree be=
yond
> > > > > the point where a significant fraction of developers thinks it ma=
kes
> > > > > sense.  And I think I agree with that.  But you can't beat him wi=
th
> > > > > the spec to make your point.
> > > > >
> > > > > Now the devicetree is cleverly constructed such that it is possib=
le to
> > > > > define additional bindings without the risk of conflicting with
> > > > > bindings developed by other parties.  In particular if U-Boot is
> > > > > augmenting a device tree with properties that are prefixed with
> > > > > "u-boot," this isn't going to hurt an operating system that uses =
such
> > > > > an augmented device tree.
> > > >
> > > > Until someone has some great idea to start using them. If the OS
> > > > doesn't need something, then why pass it in the first place? What
> > > > purpose does it serve? It's an invitation for someone somewhere to
> > > > start using them.
> > > >
> > > > The downside of keeping the nodes is it creates an ABI where there
> > > > doesn't need to be one necessarily.
> > >
> > > I'd love to get away from the idea that DT is just for the OS. We are
> > > trying to use it for firmware-to-firmware communication, too. The
> > > programs on each side of that interface may be different projects. Fo=
r
> > > that, we do need to have a binding, otherwise we end up with series
> > > like this one.
> >
> > I don't think DT is just for the OS, but DT for the OS is an ABI and
> > other cases may not be. Or they just don't need to follow all the same
> > rules. Zephyr is doing their own thing for example.
> >
> > I don't think /options/u-boot is an ABI. AIUI, u-boot populates the
> > node and consumes it. No ABI there (or limited to SPL to u-boot
> > proper). I suppose a prior firmware stage could populate it, but that
> > doesn't scale as then the prior stage has to know details of the next
> > stage.
>
> I still don't understand the distinction, or really why U-Boot (or
> u-boot) is different. The main reason for the /options/u-boot node is
> so that prior phase firmware can tell U-Boot what to do. It is similar
> to the /chosen node for the OS. If it is not an ABI, how can any
> project rely on it? It is absolutely not just U-Boot generating
> something for its own consumption. Where is that idea even coming
> from? We even have an OF_HAS_PRIOR_STAGE Kconfig option for it in
> U-Boot, specifically for TF-A, etc.

Okay, I misunderstood the intent since I thought u-boot gets its DT
from the one in the u-boot tree (at least usually).

Though I just looked at TF-A source and see no evidence of it doing
anything with /options or /options/u-boot. I'm really not that
interested in what is possible and only used by 1 board and fork
somewhere. I'm interested in supporting what the community defines as
best practice (e.g. DT (for OS) comes from firmware), but so far that
hasn't been defined below the firmware-OS level. Yes, there's efforts
addressing aspects of it, but it's not really clear to me what the
high-level goals are and what projects are onboard.

Note that I did find "/secure-chosen" though. And if they want to use
that, then fine, but I don't want to see it.

> As to the scaling, I agree. That suggests we try to make things
> generic, i.e. have an /options node with these sorts of generic
> settings. Candidates for that are console and logging controls, for
> example. I would prefer that to /options/u-boot, as you know.
>
> >
> > > > > The real problem is that some folks developed a certification pro=
gram
> > > > > that allegedly requires schema verification and now propose addin=
g
> > > > > code to U-Boot that doesn't really solve any problem.  My propose=
d
> > > > > solution would be to change said certification program to allow
> > > > > firmware to augment the device tree with properties and nodes wit=
h
> > > > > compatibles that are in the namespace controlled by the firmware.
> > > >
> > > > I don't think we should decide what to do here based on said
> > > > certification program. It can adapt to what's decided. Probably, th=
e
> > > > /option nodes will be stripped out or ignored for certification.
> > > >
> > > > I accepted u-boot options node schema into dtschema, but now have
> > > > second thoughts on that. Now I'm getting more u-boot specific
> > > > (perhaps, not clear) stuff and widevine stuff internal to a TEE.
> > >
> > > Where should these bindings go such that ARM / Linaro are not trying
> > > to remove them? I would be OK with moving them out somewhere else, bu=
t
> > > how are people supposed to deal with such fragmentation? My
> > > understanding was that dt-schema was an attempt to set up a neutral
> > > area where bindings could be accepted that were not just for
> > > Linux...did that change?
> >
> > No change, just not communicated I guess. And again, bindings are not
> > "just for Linux". They are hosted there because that is where *all*
> > the hardware support is (by far). But we'll probably never get past
> > the "Linux binding" perception no matter what we do or how many times
> > I say it.
> >
> > To rephrase things a bit, I'm happy to host anything that's
> > multi-project, not a large number of bindings, and not a
> > device/hardware specific binding. The device specific bindings live in
> > the kernel tree primarily. For any new binding (foos/#foo-cell type
> > ones), I want to see multiple users. Really for these, probably best
> > to start with them in Linux repo (or elsewhere) and then promote them
> > to dtschema. That gives a little flexibility in changing/abandoning
> > them.
>
> So now I am not sure what you are suggesting. Are you wanting bindings
> in many places (yours, Linux, U-Boot, TF-A, ...)? I am sure you are
> aware that if we put bindings in U-Boot they will not be considered as
> bindings at all, including by Linaro.

If the instances of a binding are only produced and consumed in
$project, then it is perfectly fine to host the bindings in $project.
It's also not something fixed. It can start out in $project and get
moved out if it proves useful elsewhere.

> To restate the problem, we need (and until your previous email I
> thought we had) a unified repo where cross-project, firmware-targeted
> bindings can be accepted and agreed by interested projects.

I'm happy to take those (assuming I'm not bombarded with 100s). So
far, nothing I've seen is clearly cross project. Send me stuff that
has acks from multiple projects.

> > Removing nodes and/or properties and where things live are mostly
> > independent discussions. SystemReady can adapt to whatever is decided
> > for the former. In general, IMO, when passing DT from stage N to N+1,
> > the N+1 stage should remove things which only apply to N+2 stage. For
> > example, kexec removes /chosen and recreates it for the next kernel.
>
> Sounds good. But note that the reason for that is a conflict, since
> the node is used for different things - i.e. the two kernels need
> different settings. That is quite different from the case I am talking
> about, where the settings either apply globally (to interested
> projects) or to a single project (for all boot phases of that
> project). In my case, I believe there is no need to remove anything.

There is also no need to keep it. We can always decide to keep it
later if there is a need. We can't decide later to remove it because
someone may be relying on it.

> Regards,
> Simon
>
> PS Zephyr is absolutely doing its own thing. Apart from the fact that
> it doesn't even have a runtime DT, the bindings are entirely within
> the project. and bear little relation to Linux bindings. I was not
> around for that decision, but I suspect part of the rationale was that
> many of the MCUs which Zephyr targets are not supported by Linux. Of
> course, that is not fully true and I believe it will become less true
> with time. Then, perhaps, in 5 years it will be Zephyr's turn to think
> about bindings more deeply.

Little overlap is part of it, but a large part of the reason is Zephyr
needed something machine parsable and it was before we came up with
dtschema. There's desire to adopt dtschema, but at this point I
imagine with the first reason, there is little pressing need. They've
got something that works for them.

Rob
