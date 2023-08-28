Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AD4C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 17:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E293F86523;
	Mon, 28 Aug 2023 19:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Unibqtl/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22A648652D; Mon, 28 Aug 2023 19:56:03 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 919C086507
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 19:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-d749f57cb22so3367865276.3
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693245356; x=1693850156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EQ/V4PTP82FgWtKgXp9KxXcBoP48bnqYtnXGvK7MydQ=;
 b=Unibqtl/sTbwK7t6KB3eTk3WyHbz82vNMymXrjXcDG+bOki7emZfQhoVGLQ2uVKn7J
 eJR0ALhZrMuftXyo6F+krI+hX0YGHL+1tlOWCm2I/aLeCengjd2aj+c1DNnZzUrr9KiT
 6BIPX1VSrDDBAwcBewjZwlqlG4ApJXoNW57e4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693245356; x=1693850156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EQ/V4PTP82FgWtKgXp9KxXcBoP48bnqYtnXGvK7MydQ=;
 b=ZIfE+4jHXCQfjhFe6kewLUbNphirQ6dl0HfDqhs/VGBFGHDmhsFbZgq8oHqbeI4Jvk
 fFWkMv8FmjZMAM4Zz3PPrLolXvYL9yyO6NlrwPOdB0BqiylwjREzHwaUKgeh/AeuoOk6
 T4V8YYG2MCea5zCwmyLtfl2ZjMdTZ3QZW9+UDePcdfWbYoYzy/ZVvGf6c7GoYEfil+T0
 bKCFnjcWbCEN+8KzrAoON1UgjUAsDRpKNbKJFO6YR6DcgVg+d3pQZ0s0msjvKAqLiVMN
 H0GmyjjupQHj8a0Rrtq4RmRViKTxXxG62lEZbHfVCEM0po2bNdnaIs5VmZeXYiqKQy7l
 UFUA==
X-Gm-Message-State: AOJu0Yz7HwA7+2EAhlcOnrJg+QkUtq9a6dgs03XnsHdi/4hKN+uTuTW7
 UK5mukGpNYpdrSh8+JyZsMe6+ySNh/A03o2cIN1Raw==
X-Google-Smtp-Source: AGHT+IEZp2kVSxHTtbFLsPHBp7F7He6p1Jjqh3uC62bPu8FItK6DHmMiqn86hyPjQHyjgbhQy/DFgCssl6TfnYBEIZM=
X-Received: by 2002:a25:ac04:0:b0:d77:fef1:6a22 with SMTP id
 w4-20020a25ac04000000b00d77fef16a22mr13925572ybi.58.1693245356104; Mon, 28
 Aug 2023 10:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <20230826090633.239342-6-sughosh.ganu@linaro.org>
In-Reply-To: <20230826090633.239342-6-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Aug 2023 11:54:46 -0600
Message-ID: <CAPnjgZ3AexW4vfO-A8WYGE0OD5EZnOUA7tA1QP71Bcw51QArBQ@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] doc: Add a document for non-compliant DT
 node/property removal
To: sughosh.ganu@linaro.org
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

On Sat, 26 Aug 2023 at 03:07, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add a document explaining the need for removal of non-compliant
> devicetree nodes and properties. Also describe in brief, the macros
> that can be used for this removal.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  .../devicetree/dt_non_compliant_purge.rst     | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 doc/develop/devicetree/dt_non_compliant_purge.rst
>
> diff --git a/doc/develop/devicetree/dt_non_compliant_purge.rst b/doc/develop/devicetree/dt_non_compliant_purge.rst
> new file mode 100644
> index 0000000000..c3a8feab5b
> --- /dev/null
> +++ b/doc/develop/devicetree/dt_non_compliant_purge.rst
> @@ -0,0 +1,64 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Removal of non-compliant nodes and properties
> +=============================================
> +
> +The devicetree used in U-Boot might contain nodes and properties which
> +are specific only to U-Boot, and are not necessarily being used to
> +describe hardware but to pass information to U-Boot. An example of
> +such a property would be the public key being passed to U-Boot for
> +verification.

It has nothing to do with describing hardware. The DT can describe
other things too. See the /options node, for example.

Please don't bring this highly misleading language into U-Boot.

> +
> +This devicetree can then be passed to the OS. Since certain nodes and
> +properties are not really describing hardware, and more importantly,
> +these are only relevant to U-Boot, bindings for these cannot be
> +upstreamed into the devicetree repository. There have been instances
> +of attempts being made to upstream such bindings, and these deemed not
> +fit for upstreaming.

Then either they should not be in U-Boot, or there is a problem with
the process.

> Not having a binding for these nodes and
> +properties means that the devicetree fails the schema compliance tests
> +[1]. This also means that the platform cannot get certifications like
> +SystemReady [2] which, among other things require a devicetree which
> +passes the schema compliance tests.
> +
> +For such nodes and properties, it has been suggested by the devicetree
> +maintainers that the right thing to do is to remove them from the
> +devicetree before it gets passed on to the OS [3].

Hard NAK. If we go this way, then no one will ever have an incentive
to do the right thing.

Please send bindings for Linaro's work, instead. If something is
entirely U-Boot-specific, then it can go in /options/u-boot but it
still must be in the dt-schema.

> +
> +Removing nodes/properties
> +-------------------------
> +
> +In U-Boot, this is been done through adding information on such nodes
> +and properties in a list. The entire node can be deleted, or a
> +specific property under a node can be deleted. The list of such nodes
> +and properties is generated at compile time, and the function to purge
> +these can be invoked through a EVT_FT_FIXUP event notify call.
> +
> +For deleting a node, this can be done by declaring a macro::
> +
> +       DT_NON_COMPLIANT_PURGE(fwu_mdata) = {
> +               .node_path      = "/fwu-mdata",
> +       };
> +
> +Similarly, for deleting a property under a node, that can be done by
> +specifying the property name::
> +
> +       DT_NON_COMPLIANT_PURGE(capsule_key) = {
> +               .node_path      = "/signature",
> +               .prop           = "capsule-key",
> +       };
> +
> +In the first example, the entire node with path /fwu-mdata will be
> +removed. In the second example, the property capsule-key
> +under /signature node will be removed.
> +
> +Similarly, a list of nodes and properties can be specified using the
> +following macro::
> +
> +       DT_NON_COMPLIANT_PURGE_LIST(foo) = {
> +               { .node_path = "/some_node", .prop = "some_bar" },
> +               { .node_path = "/some_node" },
> +       };
> +
> +[1] - https://github.com/devicetree-org/dt-schema
> +[2] - https://www.arm.com/architecture/system-architectures/systemready-certification-program
> +[3] - https://lore.kernel.org/u-boot/CAL_JsqJN4FeHomL7z3yj0WJ9bpx1oSE7zf26L_GV2oS6cg-5qg@mail.gmail.com/
> --
> 2.34.1
>

Regards,
Simon
