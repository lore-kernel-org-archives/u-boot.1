Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873E0C46CD3
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 14:48:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB84B877FE;
	Mon, 18 Dec 2023 15:48:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TdEYnNi0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3CFF87E17; Mon, 18 Dec 2023 15:48:38 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BBAA86F64
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 15:48:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=robh@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D7EC66101E;
 Mon, 18 Dec 2023 14:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438EEC433C8;
 Mon, 18 Dec 2023 14:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702910914;
 bh=Nl/4Qju8StrRIofVcTdVeGpmbqeL4PjNP1NAI3w2Biw=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=TdEYnNi0HD1pTzTsCxVjg07p8VmSZlcpuYuu9jZDnd4KLp6h24Uox/LC/G5VWYfZI
 INgPRbB5yVwG+fBPMlXaicwaIWEtC3h4/lbTxT7yf9w7VREY5SBF3xqryU72nnjTej
 InTQveRKJluXad38RyMvVbvldJk1UnEJMMm7XQFzqZWqYyHyUWUaEWUR2/1dh3gRFd
 KsDeO4nvGicz+RbzPr8SJHJJrQmsuqWrLjvlTZ3HK7CIv9pVuf5Lfpv/Cgu21gNgdV
 G7Q7aj+AJabj73GT5d73y0RmbReHZ3NLgA9FYv7h2yekBb3abZa5X8MH5hD6eVSZ12
 I/4uexH/YOIjQ==
Received: (nullmailer pid 3792451 invoked by uid 1000);
 Mon, 18 Dec 2023 14:48:32 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 devicetree@vger.kernel.org,
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Michael Walle <michael@walle.cc>,
 linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20231218133722.16150-1-zajec5@gmail.com>
References: <20231218133722.16150-1-zajec5@gmail.com>
Message-Id: <170291091219.3792434.8389294947030479112.robh@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: layouts: add U-Boot
 environment variables layout
Date: Mon, 18 Dec 2023 08:48:32 -0600
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


On Mon, 18 Dec 2023 14:37:19 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> U-Boot env data is a way of storing firmware variables. It's a format
> that can be used of top of various storage devices. Its binding should
> be an NVMEM layout instead of a standalone device.
> 
> This patch adds layout binding which allows using it on top of MTD NVMEM
> device as well as any other. At the same time it deprecates the old
> combined binding.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../bindings/nvmem/layouts/u-boot,env.yaml    | 55 +++++++++++++++++++
>  .../devicetree/bindings/nvmem/u-boot,env.yaml |  6 ++
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/nvmem/u-boot,env.example.dtb: partition@40000: 'ethaddr', 'reg' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/nvmem/layouts/u-boot,env.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/nvmem/u-boot,env.example.dtb: partition-u-boot-env: 'ethaddr' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/nvmem/layouts/u-boot,env.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231218133722.16150-1-zajec5@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

