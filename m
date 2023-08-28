Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DEFC83F16
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 10:19:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F15E864C5;
	Mon, 28 Aug 2023 12:19:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EuEO7Pkr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A16F6864C8; Mon, 28 Aug 2023 12:19:02 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEF85864C4
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 12:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-52713d2c606so4029323a12.2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 03:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693217935; x=1693822735;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WDxvt0RXcBW4Z2eXO3dKJCYg3dd4jxhKSK0mVJ289MA=;
 b=EuEO7PkrqkffUhwS/kfTq2jR0l8lverb/OGCa4Xev1XBpekAa8On/Mjo9I0pVLu24V
 wvj5KUzgVBoqfVlCkrxeG5Ha5Oor3zrBZS8pwurcPuYUt4w4/yUnZ8mvNtKGuNySH6wc
 BAU0+f7viv6jUo1skJG63bBle+/2tSh6AlHHqPGjLbZpL3ZCdMNKHVJnQMtvHwXyCuoj
 CT2UvhnZgi7kc9p8uUdZJgj3t6dGJFCJa4gwUB8axjkow7VkfWEvtETDaus7MkYiz75g
 3k37OY+5yw9paJCFHib5w4mK+wrlaURpCSHwrIzFuTYIFGkoaZUEsCS9dSJxXCQMW201
 0Mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693217935; x=1693822735;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WDxvt0RXcBW4Z2eXO3dKJCYg3dd4jxhKSK0mVJ289MA=;
 b=RGwtnbeKtix0cFc4yDBVWRo9nMLI1w23qdMUoAi+pomNeIKk7p+zdCaxMnPRkECxLn
 G5MjTUn5iFYmYVlWcJupEwoQH2hsJnTXqxsDuVGg/W7Eui0wHr8tfKEFT613eNSLyndB
 2Dxn16SiLhjKLJOePvduJGSiARQMOvssIMJRXUnssy4RqqwXe2j2lxvCV2tzwr/0R5rI
 fxNgrKqPLKxVFf5MxqBG2HBHVLFzUMy6WNB3AkpGQxS4PUAjOfDYCO2ZL7YPNxGzQ8XK
 ooH4yJ0qTuRccoVhjg+otF3r69MDU+IZYqnefOAhUUcmTlXQxQS6ehUao38FeN2TdwDk
 6A6g==
X-Gm-Message-State: AOJu0YyoJbQVd0a44bV/DvCindfzjlSzO/yAzwbUrsiHgzrW/8pSikLq
 oH5OHkELQ5LkXFb7GwgrJ8zbrbvZshROGI1kPAfy5g==
X-Google-Smtp-Source: AGHT+IFJ+eBZG1mCpie33qzFOD9IBShQGH/V0khJmH88m2ZLLW1zjWgJHY/LPMl3HPGvtgwLzlMWn9N7SbIyjNsalB8=
X-Received: by 2002:aa7:d651:0:b0:522:3a0d:38c2 with SMTP id
 v17-20020aa7d651000000b005223a0d38c2mr20514305edr.9.1693217935376; Mon, 28
 Aug 2023 03:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <20230826090633.239342-6-sughosh.ganu@linaro.org>
 <2000e1e6-539a-2aa6-a6c6-1fcc9db5d13d@gmx.de>
In-Reply-To: <2000e1e6-539a-2aa6-a6c6-1fcc9db5d13d@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 28 Aug 2023 15:48:44 +0530
Message-ID: <CADg8p941eO+UbHAP2eX-GqO2vzfggoHZxLP7eX0ASvaSZ92KVA@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] doc: Add a document for non-compliant DT
 node/property removal
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Sat, 26 Aug 2023 at 15:35, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 8/26/23 11:06, Sughosh Ganu wrote:
> > Add a document explaining the need for removal of non-compliant
> > devicetree nodes and properties. Also describe in brief, the macros
> > that can be used for this removal.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>
> Thanks for properly documenting the change.
>
> Warning, treated as error:
> doc/develop/devicetree/dt_non_compliant_purge.rst:
> document isn't included in any toctree
>
> Please, add the document to doc/develop/devicetree/index.rst
>
> Please, run make htmldocs before resubmitting.
>
> > ---
> >   .../devicetree/dt_non_compliant_purge.rst     | 64 +++++++++++++++++++
> >   1 file changed, 64 insertions(+)
> >   create mode 100644 doc/develop/devicetree/dt_non_compliant_purge.rst
> >
> > diff --git a/doc/develop/devicetree/dt_non_compliant_purge.rst b/doc/develop/devicetree/dt_non_compliant_purge.rst
> > new file mode 100644
> > index 0000000000..c3a8feab5b
> > --- /dev/null
> > +++ b/doc/develop/devicetree/dt_non_compliant_purge.rst
> > @@ -0,0 +1,64 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> > +
> > +Removal of non-compliant nodes and properties
> > +=============================================
> > +
> > +The devicetree used in U-Boot might contain nodes and properties which
> > +are specific only to U-Boot, and are not necessarily being used to
> > +describe hardware but to pass information to U-Boot. An example of
> > +such a property would be the public key being passed to U-Boot for
> > +verification.
> > +
> > +This devicetree can then be passed to the OS. Since certain nodes and
> > +properties are not really describing hardware, and more importantly,
> > +these are only relevant to U-Boot, bindings for these cannot be
> > +upstreamed into the devicetree repository. There have been instances
> > +of attempts being made to upstream such bindings, and these deemed not
>
> but these were not deemed fit
>
> > +fit for upstreaming. Not having a binding for these nodes and
> > +properties means that the devicetree fails the schema compliance tests
> > +[1]. This also means that the platform cannot get certifications like
> > +SystemReady [2] which, among other things require a devicetree which
>
> %s/require/requires/
>
> > +passes the schema compliance tests.
> > +
> > +For such nodes and properties, it has been suggested by the devicetree
> > +maintainers that the right thing to do is to remove them from the
>
> %s/that the right thing to do is//
>
> > +devicetree before it gets passed on to the OS [3].
>
> %s/on to/to/
>
> > +
> > +Removing nodes/properties
> > +-------------------------
> > +
> > +In U-Boot, this is been done through adding information on such nodes
>
> %s/is been done through/is done by/
>
> > +and properties in a list. The entire node can be deleted, or a
> > +specific property under a node can be deleted. The list of such nodes
> > +and properties is generated at compile time, and the function to purge
> > +these can be invoked through a EVT_FT_FIXUP event notify call.
> > +
> > +For deleting a node, this can be done by declaring a macro::
> > +
> > +     DT_NON_COMPLIANT_PURGE(fwu_mdata) = {
> > +             .node_path      = "/fwu-mdata",
> > +     };
>
> Where should such a macro be placed?

It should be placed in any file that will get compiled.

>
> > +
> > +Similarly, for deleting a property under a node, that can be done by
> > +specifying the property name::
> > +
> > +     DT_NON_COMPLIANT_PURGE(capsule_key) = {
> > +             .node_path      = "/signature",
> > +             .prop           = "capsule-key",
> > +     };
>
> Why is capsule_key needed twice here? What would be the effect of:
>
> DT_NON_COMPLIANT_PURGE(voodoo) = {
>         .node_path      = "/signature",
>         .prop           = "capsule-key",
> };

In your above example, voodoo just happens to be the name of the entry
that will be created. But the property that will be searched in the
devicetree for removal is "capsule-key".

>
> > +
> > +In the first example, the entire node with path /fwu-mdata will be
> > +removed. In the second example, the property capsule-key
> > +under /signature node will be removed.
> > +
> > +Similarly, a list of nodes and properties can be specified using the
> > +following macro::
> > +
> > +     DT_NON_COMPLIANT_PURGE_LIST(foo) = {
>
> What does foo refer to here? Can this parameter be eliminated from the
> syntax?

foo is the name of the entry being generated through the
ll_entry_declare macro. We do need this parameter for ll_entry_declare
to generate a unique entry. Using a common name results in a linker
error.

>
> Will the application of the removals be sorted alphabetically by this
> argument?

I am not sure how the linker arranges the entries in the list. Why
does it matter?

>
> What will happen if a property or node does not exist at time of
> removal? Hopefully that does not stop the boot process but is silently
> ignored.

Yes, it will not cause the boot to fail.

>
> > +             { .node_path = "/some_node", .prop = "some_bar" },
> > +             { .node_path = "/some_node" },
> > +     };
>
> Why do you need the first element in your example?
> Wouldn't deleting /some/node imply that all its children are deleted?

Ah, this is a bad example. I should be using a different name for the
second entry here. Will fix.

>
> Why do we need separate properties .node_path and .prop. It would be
> less effort to write:
>
> DT_NON_COMPLIANT_PURGE_LIST() =
> {
>         "/some_node_1/some_property_1",
>         "/some_node_1/some_property_2",
>         "/some_node_2",
> }
>
> I assume the macro does its job irrespective of non-compliance.
> Why not call it DT_PURGE()?

Yes, it can be called DT_PURGE. I was using the term non_compliant
simply to highlight the fact that we would need to use this for
removal of non-compliant nodes or properties.

-sughosh

>
> Best regards
>
> Heinrich
>
> > +
> > +[1] - https://github.com/devicetree-org/dt-schema
> > +[2] - https://www.arm.com/architecture/system-architectures/systemready-certification-program
> > +[3] - https://lore.kernel.org/u-boot/CAL_JsqJN4FeHomL7z3yj0WJ9bpx1oSE7zf26L_GV2oS6cg-5qg@mail.gmail.com/
