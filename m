Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD67CD613C
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 22:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99519864A9;
	Tue, 10 Oct 2023 00:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m7baNl54";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D33F86489; Tue, 10 Oct 2023 00:03:01 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2059C864A9
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 00:02:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so13101665a12.1
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 15:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696888978; x=1697493778; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rjq4mQ6ok9vbI4s2uRAhNlsstGCnbhA6GK5uk3ZBc6s=;
 b=m7baNl54ROygrx7XlCvIuHL6Ud8wDcY/C9JHMJSm/GDG+swK6dftAN3+lOIEYeyOwJ
 UtTTs+Z8/hoa5NZauM6tXDkMT+A4Fn65a9PVGsZEeEAMqcYU0RVmxvl6vTlwMt9iaHUP
 rJ4HW7ZU7vAJFXXgW4b4WYQW4NBNsXha3RYwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696888978; x=1697493778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rjq4mQ6ok9vbI4s2uRAhNlsstGCnbhA6GK5uk3ZBc6s=;
 b=OteuvDyGaQv8YPQGAlSPXSQDtwD0BGeU2vOnRw48t8SuGtPNBoLmUEXsgNitKAYTt0
 djaUQ73wgbfDlBXjSJk482ovAHf7bWIF2auy3QfFDECQ9KDM3IIpk2HiN5LsJp3Ly29b
 OcsTSeuHTTzOvIr36I4syx37bp3upTcyCVAZAmz2fvtOq1nYu6M2Rd2VZaFfYoHl5ruf
 98hwH6dOS4XtyrHBd6f/jax/CVjBVbo20ZDWkr9QUvqzRorTUbP4Ftrm3EwIVxCtrht+
 shomjugBSccD0AG8YrqaTIZNf7Q5kF/N4LeUpAtQtAsgr/eqOKf/fWKNos7/t0w8K7vz
 GH9w==
X-Gm-Message-State: AOJu0YyzuW9fCCiFQ2rV3SnRC64yKIujAqDphiJwyiE6S/3GvXQ40nns
 VOo0K9BkuWdRbA/GXQ502XGd/hy8Y+exfAX25LRJ6Q==
X-Google-Smtp-Source: AGHT+IEtqWvxQ0Vgm+Jr6dpgRLt/9LzEMO9okKuLlajtYR50GrEGRE87hGyzUOZ2jPFoAGYSrwhOp2INK3c35n2NsdE=
X-Received: by 2002:a17:906:af10:b0:9ad:8a9e:23ee with SMTP id
 lx16-20020a170906af1000b009ad8a9e23eemr11254081ejb.13.1696888978460; Mon, 09
 Oct 2023 15:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231009201005.1964794-1-sjg@chromium.org>
 <20231009201005.1964794-2-sjg@chromium.org>
 <169688631230.3255827.3268332902446136449.robh@kernel.org>
In-Reply-To: <169688631230.3255827.3268332902446136449.robh@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Oct 2023 16:02:40 -0600
Message-ID: <CAPnjgZ3-eX5r02K_499wz3dQOs8nOO5o16CL9w1xyNsTXL0L2A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: mtd: binman-partition: Add binman
 compatibles
To: Rob Herring <robh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 devicetree@vger.kernel.org, Michael Walle <mwalle@kernel.org>, 
 Richard Weinberger <richard@nod.at>, U-Boot Mailing List <u-boot@lists.denx.de>,
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

On Mon, 9 Oct 2023 at 15:18, Rob Herring <robh@kernel.org> wrote:
>
>
> On Mon, 09 Oct 2023 14:10:00 -0600, Simon Glass wrote:
> > Add two compatible for binman entries, as a starting point for the
> > schema.
> >
> > Note that, after discussion on v2, we decided to keep the existing
> > meaning of label so as not to require changes to existing userspace
> > software when moving to use binman nodes to specify the firmware
> > layout.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Drop fixed-partitions from the example
> > - Use compatible instead of label
> >
> > Changes in v2:
> > - Use plain partition@xxx for the node name
> >
> >  .../mtd/partitions/binman-partition.yaml      | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml: properties:compatible:items: {'enum': ['u-boot', 'atf-bl31']} is not of type 'array'
>         from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231009201005.1964794-2-sjg@chromium.org
>
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
>

Oh dear, I didn't notice that output but I see it now. Could the check
return a non-zero exit code if something goes wrong?

Anyway, I'll send v4

Regards,
Simon
