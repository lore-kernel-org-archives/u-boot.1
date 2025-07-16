Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B8FC83F22
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 13:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F9D1831C2;
	Wed, 16 Jul 2025 15:55:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F+Yc1z5+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5893F83236; Wed, 16 Jul 2025 15:55:26 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47FB1830B5
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 15:55:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 304D7614A5;
 Wed, 16 Jul 2025 13:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA49C4CEE7;
 Wed, 16 Jul 2025 13:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752674122;
 bh=RVyb71zlqqSfXll+iDYpp5+5ScnVs68AQ1GNOMiEXdc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=F+Yc1z5+yKQZIQMVYynqKEXM8xM6JrP4fSvAu+LcDIEbqLd37W0l+hiXOQ5AxZftx
 /q9PGJIdsxpB2TLQVhidwlGYYxtytn59Kix3W63GCs/GeIHvTNoLWrq2oM50cdvuQx
 EZJTfsyeJHqTZZupF7+elkYflkSp2xpL09rdQPCbwVMO2FY/6/ONED4KUIXlsyKTIa
 3+pw3WE78VFJfSz+1yaLx76AG2NvvEBeir3hhc48IVlInGlr+DB1IdLe5SGII1A53+
 RqsMeViI+dlOZAtKRjK/Hs0HHE1d9uULlP/SWiQMCl6YbPzgGYvvz4SObBtTfslBQE
 Dn3UNkag0eoBg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Enric Balletbo i Serra <eballetbo@kernel.org>, u-boot@lists.denx.de, Tom
 Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, ekovsky@redhat.com, Enric
 Balletbo i Serra <eballetbo@kernel.org>
Subject: Re: [PATCH] docs: Update FIT signature testing instructions
In-Reply-To: <20250716-fix-signature-test-docs-v1-1-4d2ad5ebcc28@kernel.org>
References: <20250716-fix-signature-test-docs-v1-1-4d2ad5ebcc28@kernel.org>
Date: Wed, 16 Jul 2025 15:55:19 +0200
Message-ID: <87qzyg2qbc.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Enric,

Thank you for the patch.

On Wed, Jul 16, 2025 at 15:12, Enric Balletbo i Serra <eballetbo@kernel.org> wrote:

> Update the FIT signature testing instructions to use the pytest suite instead of
> the old vboot_test.sh script.
>
> Signed-off-by: Enric Balletbo i Serra <eballetbo@kernel.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  doc/usage/fit/signature.rst | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/doc/usage/fit/signature.rst b/doc/usage/fit/signature.rst
> index b868dcbf9fdb28e85128d402478e3120dafcca2f..e5b5a8432e9eb1cb8ba727dc26e1e3a46cb41f51 100644
> --- a/doc/usage/fit/signature.rst
> +++ b/doc/usage/fit/signature.rst
> @@ -433,16 +433,14 @@ CONFIG_LEGACY_IMAGE_FORMAT
>  Testing
>  -------
>  
> -An easy way to test signing and verification is to use the test script
> -provided in test/vboot/vboot_test.sh. This uses sandbox (a special version
> +An easy way to test signing and verification is to use the vboot tests
> +provided in the pytest suite. This uses sandbox (a special version
>  of U-Boot which runs under Linux) to show the operation of a 'bootm'
>  command loading and verifying images.
>  
>  A sample run is show below::
>  
> -    $ make O=sandbox sandbox_config
> -    $ make O=sandbox
> -    $ O=sandbox ./test/vboot/vboot_test.sh
> +    $ ./test/py/test.py --bd sandbox --build -k vboot
>  
>  
>  Simple Verified Boot Test
>
> ---
> base-commit: bcc7bc69b92ab728790aea0d08b2ae5e22d3b09d
> change-id: 20250716-fix-signature-test-docs-335cc19f8b49
>
> Best regards,
> -- 
> Enric Balletbo i Serra <eballetbo@kernel.org>
