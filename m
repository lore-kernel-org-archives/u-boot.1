Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D61CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:43:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BA7A86E37;
	Thu, 12 Oct 2023 05:41:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kkEiyg1c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B57AA86C0B; Thu, 12 Oct 2023 05:41:36 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB2E986E06
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:41:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50585357903so751076e87.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082091; x=1697686891; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UqD/7t0pHiD/A1D+TVC0jVRhUdy6D5qb2bjFC/PdJc4=;
 b=kkEiyg1cltHAq7JQHl87hvB91VhBdTyge9RmPVglwgGNuz0phvhWKcblmZ8msHlAIl
 L+OMlOYzPoTax8IhMouj/FPBqQjWZNWzTHVcnDci/0X9Owqvy0J2NUYbFuX9KwQvBLzy
 tZTk8Xyjiig+de96EWfm3zrc+iG2owoeeuP7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082091; x=1697686891;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UqD/7t0pHiD/A1D+TVC0jVRhUdy6D5qb2bjFC/PdJc4=;
 b=cXdqLs2dnHChOsJGJD2oi0BN2+z/FQVhzRbS0QksouzIe0Jb6fEIVtuwk/ygnMfbSb
 GHV1WbOy9ul7JievV4s9ApUr7GG8Nd6nw7RT4R+4Njz6L70GdJCi0SZ4YKrp51Wa/i/u
 EU2yhrFAhwPFLMAreL0qDLFuSF3ich4pf177fk9DyUxrO44vOQlWkXqoJ3h1j8JaqVl/
 MnwzsUBtE/iCVjBf5VciGNmXjkdOS0hud+k+J8pdZqucrwHb0olGNO4T8vq6M1g9LYrS
 jAxOz08xyxJlmr8uDYy5NqsHWEs3qtSiDQlyWZEoihXsTnvWA2cuX/zW8WGokMgwtrpD
 WRnw==
X-Gm-Message-State: AOJu0YyFG+Qd9sPp7eg41bizmi8a1ze9ZPpSp1uUTkhAu620vbXScEup
 JabPjjV9BxtuP9NC0bvJZctsMfWzZH/10YjRdJZpLw==
X-Google-Smtp-Source: AGHT+IGjcdHHqUks4N3VBxCSI9q5rZhvus8FmGXhe4gZvXBEhWqxZiJ8sEB9S33VnjgEGWvOwy3ON0YBJKirqAyhjiM=
X-Received: by 2002:a19:a414:0:b0:502:a55b:c2d7 with SMTP id
 q20-20020a19a414000000b00502a55bc2d7mr19256311lfc.60.1697082090831; Wed, 11
 Oct 2023 20:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231009201005.1964794-1-sjg@chromium.org>
 <20231009201005.1964794-2-sjg@chromium.org>
 <169688631230.3255827.3268332902446136449.robh@kernel.org>
 <CAPnjgZ3-eX5r02K_499wz3dQOs8nOO5o16CL9w1xyNsTXL0L2A@mail.gmail.com>
 <20231010170600.GA1046256-robh@kernel.org>
In-Reply-To: <20231010170600.GA1046256-robh@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:40:58 -0700
Message-ID: <CAPnjgZ1dX9QUJ1cv4z8k1ptyWm2sk=ax_8vQzYUs5erA+VJ7bg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: mtd: binman-partition: Add binman
 compatibles
To: Rob Herring <robh@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, devicetree@vger.kernel.org, 
 Michael Walle <mwalle@kernel.org>, Richard Weinberger <richard@nod.at>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Tom Rini <trini@konsulko.com>
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

Hi Rob,

On Tue, 10 Oct 2023 at 11:06, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Oct 09, 2023 at 04:02:40PM -0600, Simon Glass wrote:
> > Hi Rob,
> >
> > On Mon, 9 Oct 2023 at 15:18, Rob Herring <robh@kernel.org> wrote:
> > >
> > >
> > > On Mon, 09 Oct 2023 14:10:00 -0600, Simon Glass wrote:
> > > > Add two compatible for binman entries, as a starting point for the
> > > > schema.
> > > >
> > > > Note that, after discussion on v2, we decided to keep the existing
> > > > meaning of label so as not to require changes to existing userspace
> > > > software when moving to use binman nodes to specify the firmware
> > > > layout.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > Changes in v3:
> > > > - Drop fixed-partitions from the example
> > > > - Use compatible instead of label
> > > >
> > > > Changes in v2:
> > > > - Use plain partition@xxx for the node name
> > > >
> > > >  .../mtd/partitions/binman-partition.yaml      | 48 +++++++++++++++++++
> > > >  1 file changed, 48 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
> > > >
> > >
> > > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > >
> > > yamllint warnings/errors:
> > >
> > > dtschema/dtc warnings/errors:
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml: properties:compatible:items: {'enum': ['u-boot', 'atf-bl31']} is not of type 'array'
> > >         from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
> > >
> > > doc reference errors (make refcheckdocs):
> > >
> > > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231009201005.1964794-2-sjg@chromium.org
> > >
> > > The base for the series is generally the latest rc1. A different dependency
> > > should be noted in *this* patch.
> > >
> > > If you already ran 'make dt_binding_check' and didn't see the above
> > > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > > date:
> > >
> > > pip3 install dtschema --upgrade
> > >
> > > Please check and re-submit after running the above command yourself. Note
> > > that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> > > your schema. However, it must be unset to test all examples with your schema.
> > >
> >
> > Oh dear, I didn't notice that output but I see it now. Could the check
> > return a non-zero exit code if something goes wrong?
>
> No, because things go wrong too often and then it breaks for everyone.
> It's better now, but only because of the above reports and 3
> maintainers.
>
> Also, it is not fatal. The schemas are checked against the DT
> meta-schema, but are used for validation if they pass just draft2019-09
> meta-schema. That allows new DT meta-schema checks to not start
> excluding previously used schema.

OK I see. Another suggestion would be to remove non-warning output.
Perhaps I can do that with make -s though.

Regards,
Simon
