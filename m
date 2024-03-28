Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48242CD11DD
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 20:37:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 888DD881DD;
	Thu, 28 Mar 2024 21:37:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M91K4TnG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E580C880E8; Thu, 28 Mar 2024 21:37:20 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE67187C62
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 21:37:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=robh@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 764C0CE2CDB;
 Thu, 28 Mar 2024 20:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2B2C433C7;
 Thu, 28 Mar 2024 20:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711658235;
 bh=o3TMU6J+1La8rLs2zcigdVj1AgPp6xVFZzSdMIJZ+dg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M91K4TnGiHgnYf7fli2rIaNCPFSkgB6FKdjUAO5LIu+nLxhre2FmA5y0q+G5YL4e6
 MiTAjHYTr1oxozM2m47RyyTZJ/LT5eG4uPj2MAyGRBedG6rcsR5Tax0POrIqgAoMyU
 LKosAXuzI2Uy4snnO31W2VpbtqGm1tCav8w8LVxJNoRhfxmAtOS1HfewJiBVSdspFY
 EC3ZzPqtPr9KcLWvpsmo5rzrdvQonI72X/tvdCOqtD8Sh92lPUEqy+SU2V6MiK52AD
 +eMkSrIuaBew8BqY8qbXt9b8o7KxmCl99ESbA45vXyLDpOJr9RApK8z2FR4V2aPbqu
 GVrhTPC293Q1A==
Date: Thu, 28 Mar 2024 15:37:13 -0500
From: Rob Herring <robh@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: Michael Walle <mwalle@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v10 2/2] dt-bindings: mtd: fixed-partition: Add binman
 compatibles
Message-ID: <171165823084.305347.5584935515178377776.robh@kernel.org>
References: <20240326200645.1182803-1-sjg@chromium.org>
 <20240326200645.1182803-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326200645.1182803-2-sjg@chromium.org>
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


On Tue, 26 Mar 2024 14:06:45 -0600, Simon Glass wrote:
> Add two compatibles for binman entries, as a starting point for the
> schema.
> 
> Note that, after discussion on v2, we decided to keep the existing
> meaning of label so as not to require changes to existing userspace
> software when moving to use binman nodes to specify the firmware
> layout.
> 
> Note also that, after discussion on v6, we decided to use the same
> 'fixed-partition' schema for the binman features, so this version
> adds a new 'binman.yaml' file providing the new compatibles to the
> existing partition.yaml binding.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v10:
> - Drop binman,entry since it is likely not necessary
> - Put the description back
> 
> Changes in v8:
> - Switch the patch ordering so the partition change comes first
> 
> Changes in v7:
> - Adjust MAINTAINERS entry
> - Put compatible strings into the 'fixed-partition' binding
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
>  .../bindings/mtd/partitions/binman.yaml       | 53 +++++++++++++++++++
>  .../bindings/mtd/partitions/partition.yaml    | 21 ++++++++
>  MAINTAINERS                                   |  5 ++
>  3 files changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

