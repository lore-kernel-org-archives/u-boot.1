Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E957CD6139
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 21:18:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 246BA86A3A;
	Mon,  9 Oct 2023 23:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kDGhdNn8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E05E585DE0; Mon,  9 Oct 2023 23:18:39 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDB33863CF
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 23:18:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rob@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C46EA60109;
 Mon,  9 Oct 2023 21:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B84C433C8;
 Mon,  9 Oct 2023 21:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696886314;
 bh=iSt8AzrjV3ha63/SCEd9J+ngrWGJ7HsJ3HlMTqPyOvA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=kDGhdNn8L8XsuxRCFYkxIgkqtlpF4iQoKFtXaFYv5ZWdAm58Jkmovmsgz7V/WI597
 VUBR41if5z33xJnGexOJnCzkz/9tzQ2+i9KQAiLGF3E2tPn8wM99V1tMUzCd5W6Nu3
 pDBmNqOGZ1cOrqgNt1B9xBM20Ln2COhYJS+rCxQR1is3cteB3ffYQHTLmlgQlr8VOB
 rzCa4LbPgFZp43zS36stt25z/Oe8ImVNunATd13lpUPiNJVvzxLMlDbGYbMOUd2Vba
 MzQY6gG8z6BejkDAtIemQPoCbIzZkd0zU/UoH6Jci4uDW/DiDazgRxMrAGM1kjuS3o
 0cGFFbWdV/rXA==
Received: (nullmailer pid 3255857 invoked by uid 1000);
 Mon, 09 Oct 2023 21:18:32 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 devicetree@vger.kernel.org, Michael Walle <mwalle@kernel.org>,
 Richard Weinberger <richard@nod.at>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Tom Rini <trini@konsulko.com>
In-Reply-To: <20231009201005.1964794-2-sjg@chromium.org>
References: <20231009201005.1964794-1-sjg@chromium.org>
 <20231009201005.1964794-2-sjg@chromium.org>
Message-Id: <169688631230.3255827.3268332902446136449.robh@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: mtd: binman-partition: Add binman
 compatibles
Date: Mon, 09 Oct 2023 16:18:32 -0500
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


On Mon, 09 Oct 2023 14:10:00 -0600, Simon Glass wrote:
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
> Changes in v3:
> - Drop fixed-partitions from the example
> - Use compatible instead of label
> 
> Changes in v2:
> - Use plain partition@xxx for the node name
> 
>  .../mtd/partitions/binman-partition.yaml      | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml: properties:compatible:items: {'enum': ['u-boot', 'atf-bl31']} is not of type 'array'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231009201005.1964794-2-sjg@chromium.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

