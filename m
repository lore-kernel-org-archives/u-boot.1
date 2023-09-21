Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB47EE7D0A3
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 17:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BDF686484;
	Thu, 21 Sep 2023 19:43:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NdmQpKZm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2AEF864A7; Thu, 21 Sep 2023 19:43:38 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A3C786466
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 19:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so1470237a12.1
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 10:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695318216; x=1695923016; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EgnrMvH7nNoTTQmn0I4esmIbISUlf8+1WX3otfUOgQw=;
 b=NdmQpKZmUKOgucsFeGjaBTg9EL357YTf2zLDr2fq9dK8C9ebaSKtaYrHgoghMrpBaj
 GfSLnvjR7Qy327H2hpv4yZMdzgsqo91W7NngPuRpZBlLhpbyRopQhw4Y5LOJOQblCyV/
 B1btoreK8TYu/QYWqRxkBBuVkDHpRkvh133WE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695318216; x=1695923016;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EgnrMvH7nNoTTQmn0I4esmIbISUlf8+1WX3otfUOgQw=;
 b=PmVLSy5x+lDuA4zeC+gTNLHujVN895EaX+einBTJZTFUnu/LxwpXLqJZ/xmtRW4xnp
 DN+/42as614U3gpG6uO3bbvuV8/2K2Kkrfrc1iaquaMViLCXjIjLcR/s+vOCMc3xOl1l
 lPWFpIPV+uxpRGM6wejDBVpmuaiBaamVpNhQ4ANrZkfhL/aYkezd4F+sySFO1eUgs3RS
 kukAbXgSKDFQN4jVWQ7dXY2hXHcCx3Zmes6KNzxldWgwr4tjhF6xqJ9AgNi3hBRcQJ9q
 YPBindpLnzM49MXz3W3ssEmuYYfl2Q6LuGV3dQRzYbpNgBlgxlWaAG4egDlTS0c7SZsn
 E/uA==
X-Gm-Message-State: AOJu0YxRMLvGeU6Kn+LYR07lsnOhHLZeS2Y2xAhTAEX43ZSyuLem9+YE
 5SlrWNDNVmO9pXDIxL/Cn83XRBncvopHPlkJDnxMFw==
X-Google-Smtp-Source: AGHT+IEZhR0gbD/qUVDGV7amu7gFhbL90a+lf1Iua27mWbovYAVuIoiLLgg+b6Egy8XAYE7zo8emnmokBuEgxgqNpgY=
X-Received: by 2002:aa7:da81:0:b0:525:76fc:f559 with SMTP id
 q1-20020aa7da81000000b0052576fcf559mr5450642eds.41.1695318215676; Thu, 21 Sep
 2023 10:43:35 -0700 (PDT)
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
 <CAL_Jsq+p6dv1gHB_M+BmMFpFyLE6qqHDgemhWn8O5KnT27aHHA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+p6dv1gHB_M+BmMFpFyLE6qqHDgemhWn8O5KnT27aHHA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 21 Sep 2023 11:43:18 -0600
Message-ID: <CAPnjgZ1mAvaRKa6iyHPwcuR0Z2qTCNTPQNzLOicGp6B_rdAtGQ@mail.gmail.com>
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

On Thu, 21 Sept 2023 at 07:59, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Sep 19, 2023 at 3:26=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Rob,
> >
> > On Mon, 18 Sept 2023 at 11:00, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Thu, Sep 14, 2023 at 5:42=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi Rob,
> > > >
> > > > On Wed, 13 Sept 2023 at 16:39, Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Fri, Sep 8, 2023 at 1:06=E2=80=AFPM Mark Kettenis <mark.ketten=
is@xs4all.nl> wrote:
> > > > > >
> > > > > > > From: Jassi Brar <jassisinghbrar@gmail.com>
> > > > > > > Date: Fri, 8 Sep 2023 09:37:12 -0500
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > On Thu, Sep 7, 2023 at 3:08=E2=80=AFPM Simon Glass <sjg@chrom=
ium.org> wrote:
> > > > > > > > On Wed, 6 Sept 2023 at 23:20, Ilias Apalodimas
> > > > > > > > >
> > > > > > > > > > > I beg to differ. Devicetree is more than just hardwar=
e and always has
> > > > > > > > > > > been. See, for example the /chosen and /options nodes=
.
> > > > > > > > > >
> > > > > > > > > > There are exceptions...
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > We've been this over and over again and frankly it gets a=
 bit annoying.
> > > > > > > > > It's called *DEVICE* tree for a reason.  As Rob pointed o=
ut there are
> > > > > > > > > exceptions, but those made a lot of sense.  Having arbitr=
ary internal ABI
> > > > > > > > > stuff of various projects in the schema just defeats the =
definition of a
> > > > > > > > > spec.
> > > > > > > >
> > > > > > > > Our efforts should not just be about internal ABI, but work=
ing to
> > > > > > > > provide a consistent configuration system for all firmware =
elements.
> > > > > > > >
> > > > > > > Sure, programmatically we can pass any data/info via DT, howe=
ver it is
> > > > > > > only meant to map hardware features onto data structures.
> > > > > > >
> > > > > > > devicetree.org  landing page
> > > > > > >     "The devicetree is a data structure for describing hardwa=
re."
> > > > > > >
> > > > > > > devicetree-specification-v0.3.pdf  Chapter-2 Line-1
> > > > > > >    "DTSpec specifies a construct called a devicetree to descr=
ibe
> > > > > > > system hardware."
> > > > > >
> > > > > > But it doesn't say that it describes *only* hardware.  And it d=
oes
> > > > > > describe more than just hardware.  There is /chosen to specify
> > > > > > firmware configuration and there are several examples of device=
 tree
> > > > > > bindings that describe non-discoverable firmware interfaces in =
the
> > > > > > Linux tree.  And it has been that way since the days of IEEE 12=
75.
> > > > > > There are also bindings describing things like the firmware par=
tition
> > > > > > layout.
> > > > >
> > > > > Yes. The exact title for 1275[1] is: IEEE Standard for Boot
> > > > > (Initialization Configuration)
> > > > > Firmware: Core Requirements and Practices
> > > > >
> > > > > I see "configuration" in there. However, in the OF case, it's
> > > > > generally how firmware configured the hardware and what it discov=
ered.
> > > > > That's a little different than telling the OS how to configure th=
e
> > > > > hardware which is what we do with FDT.
> > > >
> > > > For the /options node it says "The properties of this node are the
> > > > system=E2=80=99s configuration variables."
> > > >
> > > > Then there is section 7.4.4 which has a large list of options which
> > > > don't seem to be so narrowly defined.
> > > >
> > > > In any case, this is not quite the point, which IMO is that we need=
 DT
> > > > to support firmware use cases, whether or not a 29-year-old spec
> > > > thought of it or not. In fact it is amazing to me how forward-looki=
ng
> > > > Open Firmware was.
> > > >
> > > > > Then there's stuff that's how
> > > > > to configure Linux which we try to reject.
> > > >
> > > > Fair enough: Linux has user-space for that.
> > >
> > > Yep, the question I usually ask is who needs to configure something
> > > and what determines the config. Changing things with sysfs is much
> > > easier than changing the DT provided by firmware.
> > >
> > > > >
> > > > > Once we get into configuration of the OS/client (including u-boot=
),
> > > > > making that an ABI is a lot harder and if we use DT for that, I d=
on't
> > > > > think it should be an ABI.
> > > > >
> > > > > > > If we want to digress from the spec, we need the majority of
> > > > > > > developers to switch sides :)  which is unlikely to happen an=
d rightly
> > > > > > > so, imho.
> > > > > >
> > > > > > It isn't even clear what the spec is.  There is the document yo=
u
> > > > > > reference above, there are the yaml files at
> > > > > > https://github.com/devicetree-org/dt-schema and then there are
> > > > > > additional yaml files in the Linux tree.  As far as I know it i=
sn't
> > > > > > written down anywhere that those are the only places where devi=
ce tree
> > > > > > bindings can live.
> > > > >
> > > > > There's not any restriction.
> > > > >
> > > > > My intention with dtschema schemas is to only have "spec level"
> > > > > schemas. (Stuff we'd add to DTSpec (but don't because no one want=
s to
> > > > > write specs).) Hardware specific stuff lives somewhere else. That
> > > > > happens to be the Linux tree because that is where all the h/w su=
pport
> > > > > is (nothing else is close (by far)). Last I checked, we've got ~3=
700
> > > > > schemas and ~1500 unconverted bindings.
> > > >
> > > > That scope is quite a bit narrower than I understood it to be. It
> > > > seems to leave a significant gap between the Linux repo and yours.
> > > >
> > > > >
> > > > > > Anyway, let's face it, there is some consensus among developers=
 that
> > > > > > what Simon has done in U-Boot is pushing the use of devicetree =
beyond
> > > > > > the point where a significant fraction of developers thinks it =
makes
> > > > > > sense.  And I think I agree with that.  But you can't beat him =
with
> > > > > > the spec to make your point.
> > > > > >
> > > > > > Now the devicetree is cleverly constructed such that it is poss=
ible to
> > > > > > define additional bindings without the risk of conflicting with
> > > > > > bindings developed by other parties.  In particular if U-Boot i=
s
> > > > > > augmenting a device tree with properties that are prefixed with
> > > > > > "u-boot," this isn't going to hurt an operating system that use=
s such
> > > > > > an augmented device tree.
> > > > >
> > > > > Until someone has some great idea to start using them. If the OS
> > > > > doesn't need something, then why pass it in the first place? What
> > > > > purpose does it serve? It's an invitation for someone somewhere t=
o
> > > > > start using them.
> > > > >
> > > > > The downside of keeping the nodes is it creates an ABI where ther=
e
> > > > > doesn't need to be one necessarily.
> > > >
> > > > I'd love to get away from the idea that DT is just for the OS. We a=
re
> > > > trying to use it for firmware-to-firmware communication, too. The
> > > > programs on each side of that interface may be different projects. =
For
> > > > that, we do need to have a binding, otherwise we end up with series
> > > > like this one.
> > >
> > > I don't think DT is just for the OS, but DT for the OS is an ABI and
> > > other cases may not be. Or they just don't need to follow all the sam=
e
> > > rules. Zephyr is doing their own thing for example.
> > >
> > > I don't think /options/u-boot is an ABI. AIUI, u-boot populates the
> > > node and consumes it. No ABI there (or limited to SPL to u-boot
> > > proper). I suppose a prior firmware stage could populate it, but that
> > > doesn't scale as then the prior stage has to know details of the next
> > > stage.
> >
> > I still don't understand the distinction, or really why U-Boot (or
> > u-boot) is different. The main reason for the /options/u-boot node is
> > so that prior phase firmware can tell U-Boot what to do. It is similar
> > to the /chosen node for the OS. If it is not an ABI, how can any
> > project rely on it? It is absolutely not just U-Boot generating
> > something for its own consumption. Where is that idea even coming
> > from? We even have an OF_HAS_PRIOR_STAGE Kconfig option for it in
> > U-Boot, specifically for TF-A, etc.
>
> Okay, I misunderstood the intent since I thought u-boot gets its DT
> from the one in the u-boot tree (at least usually).

That sounds right, although it isn't the intended destination. But in
any case, we want to use the same DT as is in Linux, so Linux needs to
accept DTs with these properties in them.

>
> Though I just looked at TF-A source and see no evidence of it doing
> anything with /options or /options/u-boot. I'm really not that
> interested in what is possible and only used by 1 board and fork
> somewhere. I'm interested in supporting what the community defines as
> best practice (e.g. DT (for OS) comes from firmware), but so far that
> hasn't been defined below the firmware-OS level. Yes, there's efforts
> addressing aspects of it, but it's not really clear to me what the
> high-level goals are and what projects are onboard.

So, chicken and egg? U-Boot cannot define /options until other
projects add them, but they won't until U-Boot defines them?

>
> Note that I did find "/secure-chosen" though. And if they want to use
> that, then fine, but I don't want to see it.

I wonder what that is? Is it in the bindings anywhere?

>
> > As to the scaling, I agree. That suggests we try to make things
> > generic, i.e. have an /options node with these sorts of generic
> > settings. Candidates for that are console and logging controls, for
> > example. I would prefer that to /options/u-boot, as you know.
> >
> > >
> > > > > > The real problem is that some folks developed a certification p=
rogram
> > > > > > that allegedly requires schema verification and now propose add=
ing
> > > > > > code to U-Boot that doesn't really solve any problem.  My propo=
sed
> > > > > > solution would be to change said certification program to allow
> > > > > > firmware to augment the device tree with properties and nodes w=
ith
> > > > > > compatibles that are in the namespace controlled by the firmwar=
e.
> > > > >
> > > > > I don't think we should decide what to do here based on said
> > > > > certification program. It can adapt to what's decided. Probably, =
the
> > > > > /option nodes will be stripped out or ignored for certification.
> > > > >
> > > > > I accepted u-boot options node schema into dtschema, but now have
> > > > > second thoughts on that. Now I'm getting more u-boot specific
> > > > > (perhaps, not clear) stuff and widevine stuff internal to a TEE.
> > > >
> > > > Where should these bindings go such that ARM / Linaro are not tryin=
g
> > > > to remove them? I would be OK with moving them out somewhere else, =
but
> > > > how are people supposed to deal with such fragmentation? My
> > > > understanding was that dt-schema was an attempt to set up a neutral
> > > > area where bindings could be accepted that were not just for
> > > > Linux...did that change?
> > >
> > > No change, just not communicated I guess. And again, bindings are not
> > > "just for Linux". They are hosted there because that is where *all*
> > > the hardware support is (by far). But we'll probably never get past
> > > the "Linux binding" perception no matter what we do or how many times
> > > I say it.
> > >
> > > To rephrase things a bit, I'm happy to host anything that's
> > > multi-project, not a large number of bindings, and not a
> > > device/hardware specific binding. The device specific bindings live i=
n
> > > the kernel tree primarily. For any new binding (foos/#foo-cell type
> > > ones), I want to see multiple users. Really for these, probably best
> > > to start with them in Linux repo (or elsewhere) and then promote them
> > > to dtschema. That gives a little flexibility in changing/abandoning
> > > them.
> >
> > So now I am not sure what you are suggesting. Are you wanting bindings
> > in many places (yours, Linux, U-Boot, TF-A, ...)? I am sure you are
> > aware that if we put bindings in U-Boot they will not be considered as
> > bindings at all, including by Linaro.
>
> If the instances of a binding are only produced and consumed in
> $project, then it is perfectly fine to host the bindings in $project.
> It's also not something fixed. It can start out in $project and get
> moved out if it proves useful elsewhere.

Does Linaro agree with that, though? We have this thread which suggests not=
.

I really think we need to resolve this somehow. It is just causing so
much churn and confusion.

How about we agree that firmware can have bindings and that the DTs
with those bindings can be in Linux, with no conditions other than
binding review?

>
> > To restate the problem, we need (and until your previous email I
> > thought we had) a unified repo where cross-project, firmware-targeted
> > bindings can be accepted and agreed by interested projects.
>
> I'm happy to take those (assuming I'm not bombarded with 100s). So
> far, nothing I've seen is clearly cross project. Send me stuff that
> has acks from multiple projects.

Part of the disconnect here is that you seem to be assuming that each
project has its own DTs and hacks them up as much as it likes, but
that is not the world I advocate. I would like to have one DT which
can support both firmware and OS.

>
> > > Removing nodes and/or properties and where things live are mostly
> > > independent discussions. SystemReady can adapt to whatever is decided
> > > for the former. In general, IMO, when passing DT from stage N to N+1,
> > > the N+1 stage should remove things which only apply to N+2 stage. For
> > > example, kexec removes /chosen and recreates it for the next kernel.
> >
> > Sounds good. But note that the reason for that is a conflict, since
> > the node is used for different things - i.e. the two kernels need
> > different settings. That is quite different from the case I am talking
> > about, where the settings either apply globally (to interested
> > projects) or to a single project (for all boot phases of that
> > project). In my case, I believe there is no need to remove anything.
>
> There is also no need to keep it. We can always decide to keep it
> later if there is a need. We can't decide later to remove it because
> someone may be relying on it.

Is this an open source project relying on it, or a closed-source one?
Bear in mind that if someone removes a firmware feature and the OS
doesn't boot, they will fix the firmware.

Anyway, I don't mind what people do here. I was just pointing out that
using the same node for two different things seems awkward, to say the
least.

>
> > Regards,
> > Simon
> >
> > PS Zephyr is absolutely doing its own thing. Apart from the fact that
> > it doesn't even have a runtime DT, the bindings are entirely within
> > the project. and bear little relation to Linux bindings. I was not
> > around for that decision, but I suspect part of the rationale was that
> > many of the MCUs which Zephyr targets are not supported by Linux. Of
> > course, that is not fully true and I believe it will become less true
> > with time. Then, perhaps, in 5 years it will be Zephyr's turn to think
> > about bindings more deeply.
>
> Little overlap is part of it, but a large part of the reason is Zephyr
> needed something machine parsable and it was before we came up with
> dtschema. There's desire to adopt dtschema, but at this point I
> imagine with the first reason, there is little pressing need. They've
> got something that works for them.

Right, which sounds like where U-Boot started and was for years forced
to stay. That is what I am trying to change.

Regards,
Simon
