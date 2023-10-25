Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3A7C07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 12:11:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 150C28744B;
	Wed, 25 Oct 2023 14:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDD458744B; Wed, 25 Oct 2023 14:11:54 +0200 (CEST)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com
 [209.85.160.46])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4646F8717E
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 14:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robherring2@gmail.com
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-1d544a4a2f2so3632475fac.3
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 05:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698235909; x=1698840709;
 h=date:subject:message-id:references:in-reply-to:cc:to:from
 :mime-version:content-transfer-encoding:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HCPxgs4NDh+ho3+ibefi5n2+RrXmyVlZVu+Q51te2v4=;
 b=vJk48NjYA46cw3+XNgh5Afo16uGnpThcG3NRFY/fjZ1dhSB01vjbL/HH7UqjlSjryx
 HPICsA2IjHVYGed2JEJfEEnq9IVIbz2fZMVOqGsc9zOLlmccp50j3RVOcJvqsiW/oFWb
 L3uPhMnale3CZ3eDMM8+m6XgCNvOKcCW1PS0M1ko/7MnBTKYupoBx31Q6UPrZIp7tRHV
 ZlhbNWcL843dQNjncE3upePr5+VxxNVLfBInq/oJ+v1/yEnX4mq8WVm2VT/1ijcN8TCc
 TwBcbr4qr1T43VgCOY1wEG8Go6junp0YXibYAfUNNKQKoWWI+h157i7kl5tV6QWwEtBO
 p+2Q==
X-Gm-Message-State: AOJu0YzIYuujJ3l3zmOxzuIINsZq0HurZtC++Ve3payZsqU5imDfcm5d
 uNLTYubzrM5WIAPN5SVmRQ==
X-Google-Smtp-Source: AGHT+IHK4CWlhFUcrr2tQOB6IBVUM5SaULgdBfzfqNt/82aSi0iQDTiGIhgrsbRNKvEcKAMBHVkAfA==
X-Received: by 2002:a05:6871:78a:b0:1e9:d25d:3cb0 with SMTP id
 o10-20020a056871078a00b001e9d25d3cb0mr18681753oap.21.1698235908781; 
 Wed, 25 Oct 2023 05:11:48 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 nd25-20020a056871441900b001dcfaba6d22sm2620513oab.46.2023.10.25.05.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 05:11:48 -0700 (PDT)
Received: (nullmailer pid 3367369 invoked by uid 1000);
 Wed, 25 Oct 2023 12:11:47 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Conor Dooley <conor+dt@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
 U-Boot Mailing List <u-boot@lists.denx.de>, linux-kernel@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Michael Walle <mwalle@kernel.org>, linux-mtd@lists.infradead.org,
 Tom Rini <trini@konsulko.com>, Richard Weinberger <richard@nod.at>
In-Reply-To: <20231024213940.3590507-2-sjg@chromium.org>
References: <20231024213940.3590507-1-sjg@chromium.org>
 <20231024213940.3590507-2-sjg@chromium.org>
Message-Id: <169818808080.999988.12536383382799868342.robh@kernel.org>
Subject: Re: [PATCH v5 2/3] dt-bindings: mtd: binman-partition: Add binman
 compatibles
Date: Wed, 25 Oct 2023 07:11:47 -0500
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


On Wed, 25 Oct 2023 10:39:17 +1300, Simon Glass wrote:
> Add two compatible for binman entries, as a starting point for the
> schema.
> 
> Note that, after discussion on v2, we decided to keep the existing
> meaning of label so as not to require changes to existing userspace
> software when moving to use binman nodes to specify the firmware
> layout.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v5:
> - Add mention of why 'binman' is the vendor
> - Drop  'select: false'
> - Tidy up the compatible setings
> - Use 'tfa-bl31' instead of 'atf-bl31'
> 
> Changes in v4:
> - Correct selection of multiple compatible strings
> 
> Changes in v3:
> - Drop fixed-partitions from the example
> - Use compatible instead of label
> 
> Changes in v2:
> - Use plain partition@xxx for the node name
> 
>  .../mtd/partitions/binman-partition.yaml      | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml: properties:compatible: [{'enum': ['binman,entry', 'u-boot', 'tfa-bl31']}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml: properties:compatible: [{'enum': ['binman,entry', 'u-boot', 'tfa-bl31']}] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
Documentation/devicetree/bindings/mtd/partitions/binman-partition.example.dtb: /example-0/partitions/partition@100000: failed to match any schema with compatible: ['u-boot']
Documentation/devicetree/bindings/mtd/partitions/binman-partition.example.dtb: /example-0/partitions/partition@200000: failed to match any schema with compatible: ['tfa-bl31']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231024213940.3590507-2-sjg@chromium.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

