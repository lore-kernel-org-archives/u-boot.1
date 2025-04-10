Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E3FC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 09:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B34683B52;
	Thu, 10 Apr 2025 11:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XbyXEQx+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0BF583B5A; Thu, 10 Apr 2025 11:27:07 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ED3F83B32
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 11:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 12E6F5C0F09;
 Thu, 10 Apr 2025 09:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B6EC4CEE3;
 Thu, 10 Apr 2025 09:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744277223;
 bh=ap44BEu/bhlAXrmz58pQst4h0dO7ZcsYVZ1UFlPCURE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=XbyXEQx+7M/zycfEDkADl3RRRDlMCo0LQQzpn8yuOFec4HNWoCMfT1I/iWaYj4M/D
 9euWqFmIaPP/74rP9jpWgjImq0roFeppJ/BggbWkeYCtUFfcF6Vr1F3dCLkNTA6MTX
 V9rnaA1AhHs23g/+GpQPOfGl8WwDgSTMAcpiseXg0RX5oze3ZRApr0EDG8twROfiOo
 jP5FC0D8UvV3p/nqK1jhzZfw0yLr0ln2kgW4u30OLayt6a2wjWfqxY71gzFxhZ+ehi
 tILT2dY8+K5etZfjzrS8DSVgbt093sqAi/ajcKIPAkJbf26Sec7izn5UCnLHhw/uRv
 7ahIz4AFbeZFA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Simon Glass <sjg@chromium.org>,
 Alexander Kochetkov <al.kochet@gmail.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Brandon Maier <brandon.maier@collins.com>,
 Neha Malcom Francis <n-francis@ti.com>, Paul HENRYS
 <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>, Philippe
 Reynes <philippe.reynes@softathome.com>, Stefan Herbrechtsmeier
 <stefan.herbrechtsmeier@weidmueller.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 5/7] binman: Workaround lz4 cli padding in test cases
In-Reply-To: <20250304130947.109799-6-sjg@chromium.org>
References: <20250304130947.109799-1-sjg@chromium.org>
 <20250304130947.109799-6-sjg@chromium.org>
Date: Thu, 10 Apr 2025 11:27:00 +0200
Message-ID: <874iywgye3.fsf@baylibre.com>
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

Hi Simon,

Thank you for the patch.

On mar., mars 04, 2025 at 06:09, Simon Glass <sjg@chromium.org> wrote:

> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
>
> Newer lz4 util is not happy with any padding at end of file,
> it would abort with error message like:
>
> Stream followed by undecodable data at position 43.
>
> Workaround by skipping testCompUtilPadding test case and manually
> strip padding in testCompressSectionSize test case.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Tested that this solves issues when using lz4 1.9.4.

This patch solves:
https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/38

Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>
>  tools/binman/ftest.py                           | 7 +++++--
>  tools/binman/test/184_compress_section_size.dts | 1 +
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 1a92a99b511..e46a1e84372 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -4613,6 +4613,8 @@ class TestFunctional(unittest.TestCase):
>          dtb.Scan()
>          props = self._GetPropTree(dtb, ['offset', 'image-pos', 'size',
>                                          'uncomp-size'])
> +        data = data[:0x30]
> +        data = data.rstrip(b'\xff')
>          orig = self._decompress(data)
>          self.assertEqual(COMPRESS_DATA + U_BOOT_DATA, orig)
>          expected = {
> @@ -6218,8 +6220,9 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>  
>      def testCompUtilPadding(self):
>          """Test padding of compression algorithms"""
> -        # Skip zstd because it doesn't support padding
> -        for bintool in [v for k,v in self.comp_bintools.items() if k != 'zstd']:
> +        # Skip zstd and lz4 because they doesn't support padding
> +        for bintool in [v for k,v in self.comp_bintools.items()
> +                        if not k in ['zstd', 'lz4']]:
>              self._CheckBintool(bintool)
>              data = bintool.compress(COMPRESS_DATA)
>              self.assertNotEqual(COMPRESS_DATA, data)
> diff --git a/tools/binman/test/184_compress_section_size.dts b/tools/binman/test/184_compress_section_size.dts
> index 95ed30add1a..1c1dbd5f580 100644
> --- a/tools/binman/test/184_compress_section_size.dts
> +++ b/tools/binman/test/184_compress_section_size.dts
> @@ -6,6 +6,7 @@
>  		section {
>  			size = <0x30>;
>  			compress = "lz4";
> +			pad-byte = <0xff>;
>  			blob {
>  				filename = "compress";
>  			};
> -- 
> 2.43.0
