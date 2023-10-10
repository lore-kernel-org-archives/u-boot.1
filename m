Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81A2CD8CAF
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 17:06:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13F2F85423;
	Tue, 10 Oct 2023 19:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DyA6xxGA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABB9B86A02; Tue, 10 Oct 2023 19:06:14 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CADF85423
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 19:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rob@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 400EB615AB;
 Tue, 10 Oct 2023 17:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EF4C433C7;
 Tue, 10 Oct 2023 17:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696957563;
 bh=fQxhBhW+tBsI74bpxoq2WhIg3iV6j9PgVFhC0vGwcw4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DyA6xxGAjMcq+pqRbop6Hl9L/a7izNrQx+URxcKHk4934m/rfCpF63VFp05pP7x8t
 oYV5j5bsLcXaK5nEP1CSnbk8TEubM0pjGVGBuDee6xu5DV7Gr21jNks+xxnIEDqSbN
 l5lHI+PA3HtR260Migd0jbiU0L+XaziHQezq21xNdTpiHcMtB3twWogwuHGGwxauBz
 ApJxqcjeKTyfLyunkMYYurP+MRGg5Wp2VzbZJ7GiNVpHXbGE4ZtWm9gV3JbmtWAdKA
 nH7/wVJ1I0ZR8LQfvdlzZ7oxPNQaj38l9ZwSPll8kUSuuy9a1ggijHyDW3aSUBW7x2
 666ToubamQsOw==
Received: (nullmailer pid 1059527 invoked by uid 1000);
 Tue, 10 Oct 2023 17:06:00 -0000
Date: Tue, 10 Oct 2023 12:06:00 -0500
From: Rob Herring <robh@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, devicetree@vger.kernel.org,
 Michael Walle <mwalle@kernel.org>, Richard Weinberger <richard@nod.at>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: mtd: binman-partition: Add binman
 compatibles
Message-ID: <20231010170600.GA1046256-robh@kernel.org>
References: <20231009201005.1964794-1-sjg@chromium.org>
 <20231009201005.1964794-2-sjg@chromium.org>
 <169688631230.3255827.3268332902446136449.robh@kernel.org>
 <CAPnjgZ3-eX5r02K_499wz3dQOs8nOO5o16CL9w1xyNsTXL0L2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3-eX5r02K_499wz3dQOs8nOO5o16CL9w1xyNsTXL0L2A@mail.gmail.com>
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

On Mon, Oct 09, 2023 at 04:02:40PM -0600, Simon Glass wrote:
> Hi Rob,
> 
> On Mon, 9 Oct 2023 at 15:18, Rob Herring <robh@kernel.org> wrote:
> >
> >
> > On Mon, 09 Oct 2023 14:10:00 -0600, Simon Glass wrote:
> > > Add two compatible for binman entries, as a starting point for the
> > > schema.
> > >
> > > Note that, after discussion on v2, we decided to keep the existing
> > > meaning of label so as not to require changes to existing userspace
> > > software when moving to use binman nodes to specify the firmware
> > > layout.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v3:
> > > - Drop fixed-partitions from the example
> > > - Use compatible instead of label
> > >
> > > Changes in v2:
> > > - Use plain partition@xxx for the node name
> > >
> > >  .../mtd/partitions/binman-partition.yaml      | 48 +++++++++++++++++++
> > >  1 file changed, 48 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
> > >
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml: properties:compatible:items: {'enum': ['u-boot', 'atf-bl31']} is not of type 'array'
> >         from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
> >
> > doc reference errors (make refcheckdocs):
> >
> > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231009201005.1964794-2-sjg@chromium.org
> >
> > The base for the series is generally the latest rc1. A different dependency
> > should be noted in *this* patch.
> >
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> >
> > pip3 install dtschema --upgrade
> >
> > Please check and re-submit after running the above command yourself. Note
> > that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> > your schema. However, it must be unset to test all examples with your schema.
> >
> 
> Oh dear, I didn't notice that output but I see it now. Could the check
> return a non-zero exit code if something goes wrong?

No, because things go wrong too often and then it breaks for everyone. 
It's better now, but only because of the above reports and 3 
maintainers.

Also, it is not fatal. The schemas are checked against the DT 
meta-schema, but are used for validation if they pass just draft2019-09 
meta-schema. That allows new DT meta-schema checks to not start 
excluding previously used schema.

Rob
