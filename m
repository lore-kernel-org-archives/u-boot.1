Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30768C6FA8F
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 17:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 437EC864C3;
	Tue, 29 Aug 2023 19:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RDemqKef";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0654A8647B; Tue, 29 Aug 2023 19:25:26 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 907D3864CF
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 19:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5009d4a4897so7233143e87.0
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 10:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693329922; x=1693934722;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XsD5H0SeljbZWyXJn3Mtd91J9/Sxnrx8HQFfjOL4XTo=;
 b=RDemqKefy+F4831+/5cVBCUIIrutojCiukpCV/eyOv1CM7j/DfIUhbcvDGkY0DtqSl
 KbAvnVboHuf5aP7/lMBaM4dkZIYNnV7hhbhTyOYRZR0my4GsvGEhqZ1RaPPntiTdVm3E
 xu/Bb/NL8/VLJ0miSQHrpkmHtvbOWVKloMWJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693329922; x=1693934722;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XsD5H0SeljbZWyXJn3Mtd91J9/Sxnrx8HQFfjOL4XTo=;
 b=jdmOEaLXKgLgI2o2OB5wkKzfJawKkBSZHVh+LLhmSGcfYv3B/V42cNRwbvP/QlC12a
 Cao6VU37fMefqeqkXDNkSUvDDJZzHgVpD5wUzL5WHw0SGAt18VqNrSTsVmpmhMq1wznN
 0TfNzmyGZeI+xlNHNvWfUuKv4wRRCDxnvCZSL/rgJFLKXtGMRwqCPJ/r+AT0d7z45xgC
 yUFl9bzi6vlDFk5I7CxYWhLdpXdjpKvI4PhtYVebka0NPggmO6eZP63mEiIXcX/CM7gk
 EixhP7I9hv7lWqZjFLJgy028q/d8oQ4ChLKLsqAyXXqad9tZ9Dd3nXsO1LclZMOtUKE1
 eW5Q==
X-Gm-Message-State: AOJu0Yyi1OBTcGebvvQT0tT0jT3u9ChNeRveUWhwy84Q2OlyRRw/7DBQ
 /mE4X1GFgCyuqZ3svnb+1SSpFVaSZibzARU/hW5/Yw==
X-Google-Smtp-Source: AGHT+IEoOaCdpwM/vE+fzqITKfJDrmXA7N5bhcQZxQGTJj8buEudgAqF9ZgJH9R6lHpSFIQTZh2ObtkeeFs4tou9PpM=
X-Received: by 2002:a05:6512:12c4:b0:4fd:d538:b97b with SMTP id
 p4-20020a05651212c400b004fdd538b97bmr24192337lfg.29.1693329921403; Tue, 29
 Aug 2023 10:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <20230826090633.239342-6-sughosh.ganu@linaro.org>
 <CAPnjgZ3AexW4vfO-A8WYGE0OD5EZnOUA7tA1QP71Bcw51QArBQ@mail.gmail.com>
 <CADg8p96zOXDaVV9CFcbeKgdZwG7pwfCp66GEY_eoYC6FCHeKZA@mail.gmail.com>
In-Reply-To: <CADg8p96zOXDaVV9CFcbeKgdZwG7pwfCp66GEY_eoYC6FCHeKZA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 29 Aug 2023 11:25:09 -0600
Message-ID: <CAPnjgZ3W-jRRAbaS3gckcd8CrjRUpcBTvNS+uPnJ70CXNeCWAQ@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] doc: Add a document for non-compliant DT
 node/property removal
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Sughosh,

On Mon, 28 Aug 2023 at 12:35, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> hi Simon,
>
> On Mon, 28 Aug 2023 at 23:25, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Sat, 26 Aug 2023 at 03:07, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > Add a document explaining the need for removal of non-compliant
> > > devicetree nodes and properties. Also describe in brief, the macros
> > > that can be used for this removal.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > >  .../devicetree/dt_non_compliant_purge.rst     | 64 +++++++++++++++++++
> > >  1 file changed, 64 insertions(+)
> > >  create mode 100644 doc/develop/devicetree/dt_non_compliant_purge.rst
> > >
> > > diff --git a/doc/develop/devicetree/dt_non_compliant_purge.rst b/doc/develop/devicetree/dt_non_compliant_purge.rst
> > > new file mode 100644
> > > index 0000000000..c3a8feab5b
> > > --- /dev/null
> > > +++ b/doc/develop/devicetree/dt_non_compliant_purge.rst
> > > @@ -0,0 +1,64 @@
> > > +.. SPDX-License-Identifier: GPL-2.0+
> > > +
> > > +Removal of non-compliant nodes and properties
> > > +=============================================
> > > +
> > > +The devicetree used in U-Boot might contain nodes and properties which
> > > +are specific only to U-Boot, and are not necessarily being used to
> > > +describe hardware but to pass information to U-Boot. An example of
> > > +such a property would be the public key being passed to U-Boot for
> > > +verification.
> >
> > It has nothing to do with describing hardware. The DT can describe
> > other things too. See the /options node, for example.
> >
> > Please don't bring this highly misleading language into U-Boot.
>
> Please point out what is misleading in the above paragraph. What is
> being emphasised in the above paragraph is that certain nodes and
> properties in the devicetree are relevant only in u-boot, and not the
> kernel. And this is precisely what the devicetree maintainers are
> saying [1].

That is not relevant though...we need to make sure all the nodes are
in the dt schema.

It is misleading because you imply that DT should only describe
hardware. That is not true.

>
> >
> > > +
> > > +This devicetree can then be passed to the OS. Since certain nodes and
> > > +properties are not really describing hardware, and more importantly,
> > > +these are only relevant to U-Boot, bindings for these cannot be
> > > +upstreamed into the devicetree repository. There have been instances
> > > +of attempts being made to upstream such bindings, and these deemed not
> > > +fit for upstreaming.
> >
> > Then either they should not be in U-Boot, or there is a problem with
> > the process.
> >
> > > Not having a binding for these nodes and
> > > +properties means that the devicetree fails the schema compliance tests
> > > +[1]. This also means that the platform cannot get certifications like
> > > +SystemReady [2] which, among other things require a devicetree which
> > > +passes the schema compliance tests.
> > > +
> > > +For such nodes and properties, it has been suggested by the devicetree
> > > +maintainers that the right thing to do is to remove them from the
> > > +devicetree before it gets passed on to the OS [3].
> >
> > Hard NAK. If we go this way, then no one will ever have an incentive
> > to do the right thing.
> >
> > Please send bindings for Linaro's work, instead. If something is
> > entirely U-Boot-specific, then it can go in /options/u-boot but it
> > still must be in the dt-schema.
>
> Please re-read the document including the last link [1]. If you go
> through that entire thread, you will notice that this is precisely
> what Linaro was trying to do here -- upstream the binding for the
> fwu-mdata node. It is only based on the feedback of the devicetree
> maintainers that this patchset was required.

It looks like it should go in /options/u-boot ? Can you resubmit it there?

The stripping is a no-go for me, sorry. It is absolutely going to
destroy any chance of tidying up DT in U-Boot.

Please also figure out how to add DT validation to U-Boot, so we can
see what the gap is. Once we have that in, I will be happier to do
workarounds.

Regards,
Simon

>
> -sughosh
>
> [1] - https://lore.kernel.org/u-boot/CAL_JsqJN4FeHomL7z3yj0WJ9bpx1oSE7zf26L_GV2oS6cg-5qg@mail.gmail.com/#t
>
> >
> > > +
> > > +Removing nodes/properties
> > > +-------------------------
> > > +
> > > +In U-Boot, this is been done through adding information on such nodes
> > > +and properties in a list. The entire node can be deleted, or a
> > > +specific property under a node can be deleted. The list of such nodes
> > > +and properties is generated at compile time, and the function to purge
> > > +these can be invoked through a EVT_FT_FIXUP event notify call.
> > > +
> > > +For deleting a node, this can be done by declaring a macro::
> > > +
> > > +       DT_NON_COMPLIANT_PURGE(fwu_mdata) = {
> > > +               .node_path      = "/fwu-mdata",
> > > +       };
> > > +
> > > +Similarly, for deleting a property under a node, that can be done by
> > > +specifying the property name::
> > > +
> > > +       DT_NON_COMPLIANT_PURGE(capsule_key) = {
> > > +               .node_path      = "/signature",
> > > +               .prop           = "capsule-key",
> > > +       };
> > > +
> > > +In the first example, the entire node with path /fwu-mdata will be
> > > +removed. In the second example, the property capsule-key
> > > +under /signature node will be removed.
> > > +
> > > +Similarly, a list of nodes and properties can be specified using the
> > > +following macro::
> > > +
> > > +       DT_NON_COMPLIANT_PURGE_LIST(foo) = {
> > > +               { .node_path = "/some_node", .prop = "some_bar" },
> > > +               { .node_path = "/some_node" },
> > > +       };
> > > +
> > > +[1] - https://github.com/devicetree-org/dt-schema
> > > +[2] - https://www.arm.com/architecture/system-architectures/systemready-certification-program
> > > +[3] - https://lore.kernel.org/u-boot/CAL_JsqJN4FeHomL7z3yj0WJ9bpx1oSE7zf26L_GV2oS6cg-5qg@mail.gmail.com/
> > > --
> > > 2.34.1
> > >
> >
> > Regards,
> > Simon
