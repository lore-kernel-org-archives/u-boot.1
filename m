Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A70BC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 14:29:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E7DD877E7;
	Wed, 13 Dec 2023 15:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uvBXPCRo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73217871AA; Wed, 13 Dec 2023 13:14:03 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50E07877D4
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 13:14:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=will@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id D18A5B81AFD;
 Wed, 13 Dec 2023 12:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D52CC433C8;
 Wed, 13 Dec 2023 12:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702469640;
 bh=2ypXgnL4ECCpmdKkPHhPyQw7+zd7cb6G6jntIn0W0sk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uvBXPCRoFNVcz10CIj8UBIpbjMFwKXefOdwwu1fICqolJgD8TVfji1yCzxM8z7X3d
 e2plc4DaOL7/ZIN+zN9h4gIwy7aNXl6HdJ08DviZxC/rVmhappflf1g2rETpLsT/Eb
 qBrXqhuakwbA8sf+s8mVebkMLadD4KG+GYkGICZqdqcwldnS9K3D1ikMPeKplbxEqG
 XIpZatoZxQbCpN4D63NwqmhWvWoeabTSiE6ASlGnHG+DHAiYCoQO3y3xPg5Qwu0ytS
 IUIISRPA9t8EjdGuMgWirtz5z7Lbgvg+Qmcq+tRNg9Yqfxjr25XRrOiLQ5g7Q0woL4
 Mh18eR3L9hVnw==
Date: Wed, 13 Dec 2023 12:13:53 +0000
From: Will Deacon <will@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org,
 Masahiro Yamada <masahiroy@kernel.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Nicolas Schier <nicolas@fjasle.eu>, Tom Rini <trini@konsulko.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Nathan Chancellor <nathan@kernel.org>,
 Nick Terrell <terrelln@fb.com>, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
Message-ID: <20231213121353.GA31326@willie-the-truck>
References: <20231202035511.487946-1-sjg@chromium.org>
 <20231202035511.487946-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202035511.487946-3-sjg@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Wed, 13 Dec 2023 15:29:33 +0100
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

On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote:
> Add a script which produces a Flat Image Tree (FIT), a single file
> containing the built kernel and associated devicetree files.
> Compression defaults to gzip which gives a good balance of size and
> performance.
> 
> The files compress from about 86MB to 24MB using this approach.
> 
> The FIT can be used by bootloaders which support it, such as U-Boot
> and Linuxboot. It permits automatic selection of the correct
> devicetree, matching the compatible string of the running board with
> the closest compatible string in the FIT. There is no need for
> filenames or other workarounds.
> 
> Add a 'make image.fit' build target for arm64, as well. Use
> FIT_COMPRESSION to select a different algorithm.
> 
> The FIT can be examined using 'dumpimage -l'.
> 
> This features requires pylibfdt (use 'pip install libfdt'). It also
> requires compression utilities for the algorithm being used. Supported
> compression options are the same as the Image.xxx files. For now there
> is no way to change the compression other than by editing the rule for
> $(obj)/image.fit
> 
> While FIT supports a ramdisk / initrd, no attempt is made to support
> this here, since it must be built separately from the Linux build.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v9:
> - Move the compression control into Makefile.lib
> 
> Changes in v8:
> - Drop compatible string in FDT node
> - Correct sorting of MAINTAINERS to before ARM64 PORT
> - Turn compress part of the make_fit.py comment in to a sentence
> - Add two blank lines before parse_args() and setup_fit()
> - Use 'image.fit: dtbs' instead of BUILD_DTBS var
> - Use '$(<D)/dts' instead of '$(dir $<)dts'
> - Add 'mkimage' details Documentation/process/changes.rst
> - Allow changing the compression used
> - Tweak cover letter since there is only one clean-up patch
> 
> Changes in v7:
> - Add Image as a dependency of image.fit
> - Drop kbuild tag
> - Add dependency on dtbs
> - Drop unnecessary path separator for dtbs
> - Rebase to -next
> 
> Changes in v5:
> - Drop patch previously applied
> - Correct compression rule which was broken in v4
> 
> Changes in v4:
> - Use single quotes for UIMAGE_NAME
> 
> Changes in v3:
> - Drop temporary file image.itk
> - Drop patch 'Use double quotes for image name'
> - Drop double quotes in use of UIMAGE_NAME
> - Drop unnecessary CONFIG_EFI_ZBOOT condition for help
> - Avoid hard-coding "arm64" for the DT architecture
> 
> Changes in v2:
> - Drop patch previously applied
> - Add .gitignore file
> - Move fit rule to Makefile.lib using an intermediate file
> - Drop dependency on CONFIG_EFI_ZBOOT
> - Pick up .dtb files separately from the kernel
> - Correct pylint too-many-args warning for write_kernel()
> - Include the kernel image in the file count
> - Add a pointer to the FIT spec and mention of its wide industry usage
> - Mention the kernel version in the FIT description
> 
>  Documentation/process/changes.rst |   9 +
>  MAINTAINERS                       |   7 +
>  arch/arm64/Makefile               |   7 +-
>  arch/arm64/boot/.gitignore        |   1 +
>  arch/arm64/boot/Makefile          |   6 +-
>  scripts/Makefile.lib              |  16 ++
>  scripts/make_fit.py               | 291 ++++++++++++++++++++++++++++++
>  7 files changed, 334 insertions(+), 3 deletions(-)
>  create mode 100755 scripts/make_fit.py

I'll need Masahiro's Ack on the scripts/ changes before I can take this
one.

Will
