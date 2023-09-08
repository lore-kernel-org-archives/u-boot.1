Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990B7EEB562
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 18:05:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 887F6869CD;
	Fri,  8 Sep 2023 20:05:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="FS6+r1nR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13040869E6; Fri,  8 Sep 2023 20:05:00 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8417869BC
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 20:04:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 21d52880-4e72-11ee-ac31-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 21d52880-4e72-11ee-ac31-005056994fde;
 Fri, 08 Sep 2023 20:04:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=content-type:mime-version:subject:to:from:message-id:date;
 bh=pyfrXJLLLsYEKHgOARtGppEaPGum4EAKs0hFSnfD2bc=;
 b=FS6+r1nRh2nIrF0o3MTPAI4+7NWFQuADQE75lT1pKOqKG5MbYm38O+S/qNv8RmxxYKSMonTORgi+7
 bnCwsUeA9IUuaHtl923K+l2c0bSle7qdhiUokSRm6ccYvvUxFy/eVUCv0L39si9Qs/0txO+l0Pq7t9
 hoMcjWDICRS3Chg8Qwcd7hMAB6SijipJcszN0s/ZrfjtEvxQ0a//FOPAcV1Lu1VO6aCtAXW6LJHH/F
 1USSH1aVFe6tnkZQO/oAeAdl4Dh+9AZCt2DuvG2z3OpitSx+2iW//0aomyvrgSOoO+OEDXardl0pVw
 KTFgcjoD3nT6I6fb8MasyMKQltQppEA==
X-KPN-MID: 33|a163+kmlEqD13VIlA6BNXkuZKw+c8+6JwkdwQib/J0Q/pS86XkVE8kXDuI9rO4P
 XtCiadBugO0PRvYGgmH6DUyRm5SV7pcI/Pym9OxeVZv0=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|0PWFkMSBFf5EcbdH3BCh/VyOpNRtMeDxsF/PY2MnNd9SwC+uxKepesvpnEDqKzm
 OZ8zbw7bFVek9cGNZv8gmZQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 371de594-4e72-11ee-acaa-00505699d6e5;
 Fri, 08 Sep 2023 20:04:56 +0200 (CEST)
Date: Fri, 08 Sep 2023 20:04:55 +0200
Message-Id: <875y4kh77c.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: sjg@chromium.org, ilias.apalodimas@linaro.org, robh@kernel.org,
 pbrobinson@gmail.com, sughosh.ganu@linaro.org,
 u-boot@lists.denx.de, trini@konsulko.com, xypron.glpk@gmx.de
In-Reply-To: <CABb+yY0VJDu+L2C10E1O-uAU-p0OwuTq6XVF2XbYuOc2fBqoww@mail.gmail.com>
 (message from Jassi Brar on Fri, 8 Sep 2023 09:37:12 -0500)
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
 <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
 <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
 <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
 <20230906142139.GA1236014-robh@kernel.org> <ZPldgbS8mu+5DG7Q@hera>
 <CAPnjgZ0kcOZp65d_-wwYyjbTwC-aDamvGU50aa34o2PeZjZk6Q@mail.gmail.com>
 <CABb+yY0VJDu+L2C10E1O-uAU-p0OwuTq6XVF2XbYuOc2fBqoww@mail.gmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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

> From: Jassi Brar <jassisinghbrar@gmail.com>
> Date: Fri, 8 Sep 2023 09:37:12 -0500
> 
> Hi Simon,
> 
> On Thu, Sep 7, 2023 at 3:08 PM Simon Glass <sjg@chromium.org> wrote:
> > On Wed, 6 Sept 2023 at 23:20, Ilias Apalodimas
> > >
> > > > > I beg to differ. Devicetree is more than just hardware and always has
> > > > > been. See, for example the /chosen and /options nodes.
> > > >
> > > > There are exceptions...
> > > >
> > >
> > > We've been this over and over again and frankly it gets a bit annoying.
> > > It's called *DEVICE* tree for a reason.  As Rob pointed out there are
> > > exceptions, but those made a lot of sense.  Having arbitrary internal ABI
> > > stuff of various projects in the schema just defeats the definition of a
> > > spec.
> >
> > Our efforts should not just be about internal ABI, but working to
> > provide a consistent configuration system for all firmware elements.
> >
> Sure, programmatically we can pass any data/info via DT, however it is
> only meant to map hardware features onto data structures.
> 
> devicetree.org  landing page
>     "The devicetree is a data structure for describing hardware."
> 
> devicetree-specification-v0.3.pdf  Chapter-2 Line-1
>    "DTSpec specifies a construct called a devicetree to describe
> system hardware."

But it doesn't say that it describes *only* hardware.  And it does
describe more than just hardware.  There is /chosen to specify
firmware configuration and there are several examples of device tree
bindings that describe non-discoverable firmware interfaces in the
Linux tree.  And it has been that way since the days of IEEE 1275.
There are also bindings describing things like the firmware partition
layout.

> If we want to digress from the spec, we need the majority of
> developers to switch sides :)  which is unlikely to happen and rightly
> so, imho.

It isn't even clear what the spec is.  There is the document you
reference above, there are the yaml files at
https://github.com/devicetree-org/dt-schema and then there are
additional yaml files in the Linux tree.  As far as I know it isn't
written down anywhere that those are the only places where device tree
bindings can live.

Anyway, let's face it, there is some consensus among developers that
what Simon has done in U-Boot is pushing the use of devicetree beyond
the point where a significant fraction of developers thinks it makes
sense.  And I think I agree with that.  But you can't beat him with
the spec to make your point.

Now the devicetree is cleverly constructed such that it is possible to
define additional bindings without the risk of conflicting with
bindings developed by other parties.  In particular if U-Boot is
augmenting a device tree with properties that are prefixed with
"u-boot," this isn't going to hurt an operating system that uses such
an augmented device tree.

The real problem is that some folks developed a certification program
that allegedly requires schema verification and now propose adding
code to U-Boot that doesn't really solve any problem.  My proposed
solution would be to change said certification program to allow
firmware to augment the device tree with properties and nodes with
compatibles that are in the namespace controlled by the firmware.

Cheers,

Mark

