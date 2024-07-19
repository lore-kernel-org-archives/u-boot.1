Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DC3C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 15:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 890F788BEB;
	Fri, 19 Jul 2024 17:05:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fpoge7v4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF14F88BF9; Fri, 19 Jul 2024 17:05:26 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44470882EF
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 17:05:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6b7a3e4686eso11345756d6.1
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 08:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721401523; x=1722006323; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PXx9fxa/vWX1ORAVb3f5pnOuRBFascrxoYqRF8kmeFE=;
 b=fpoge7v4WzOrwoCa5xgafwwtqn+8YfkvEIakAxx5AquVyhWc12w6lrSJF+Q7p6DJvo
 9eCSsKyVeO62MZGeZamWCybEGDcwfDADuPyc8enoY8j0593GvGwUoiKRRPUAee1AJerr
 4PzfxAOqUvLUiVN9QYIs4ScU1ZAKcmnifLPpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721401523; x=1722006323;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PXx9fxa/vWX1ORAVb3f5pnOuRBFascrxoYqRF8kmeFE=;
 b=ZP7rOMYKsM48c2SAddrXvEsK/huJpXxxVO3nYjOioZlWDGfS6mfTnyDMBsbIAeOpik
 1YZVS7CQR0qZTvKcIW3jxy0hihoCmZPsKrjv+53d1s35iDGb4HrqfefPxSKWs94VU+fP
 8ZGPsilHCKSxTcbHPeq+17JxsmNp68OxCM/3YVSzt/Q731DJ5kemG4SI23ns77sEpVkw
 gLWYFDeYiRDbvuyo1WrP4Fo9aZAZjutXouzNctJhYOY3L484i4uH19RGorc6Q4nOoVXw
 EMUDUA1KBggf1CBVt/DCC+g77YpTu5baTQ8jL+DlMG5xtFp79E0ZW/+kBaUs0jrOXJCg
 VMkw==
X-Gm-Message-State: AOJu0YzeQadpejOyZBI5adMFywJRNXZQhwf/tbvw8OZVzHrSaKx/HVa9
 kH9piZb9W4FvnXDEHM2gdSniMHENNjcykAYwzul5SjJupCELkm3wrf8JhFjiFLZ2QR626f4YU33
 fIO7qNbG9LnkG1cjwR3OKoaAegIqUN6P9Dtin
X-Google-Smtp-Source: AGHT+IG2rnPsSOSiD0bwKpWI3IZLjWLo503EdG0oSlqMIneFvZlDNbnvv4MYl8LylcI37vjb91hbppiLNqF9IFO5308=
X-Received: by 2002:a05:6214:1d03:b0:6b7:8fc3:7d00 with SMTP id
 6a1803df08f44-6b95a7cc721mr3572716d6.41.1721401522958; Fri, 19 Jul 2024
 08:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
 <20240717-docker-image-v1-5-7c7fc6251e7a@flygoat.com>
In-Reply-To: <20240717-docker-image-v1-5-7c7fc6251e7a@flygoat.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 19 Jul 2024 16:05:12 +0100
Message-ID: <CAFLszTggmP6Q=SS55XZj1L1TLrOrFTjg_JG49_9OpRvZfRC0eg@mail.gmail.com>
Subject: Re: [PATCH 05/18] binman: Workaround lz4 cli padding in test cases
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Wed, 17 Jul 2024 at 15:29, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
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
> ---
>  tools/binman/ftest.py                           | 7 +++++--
>  tools/binman/test/184_compress_section_size.dts | 1 +
>  2 files changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index e9ad145e790d..0143d5e41737 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -4518,6 +4518,8 @@ class TestFunctional(unittest.TestCase):
>          dtb.Scan()
>          props = self._GetPropTree(dtb, ['offset', 'image-pos', 'size',
>                                          'uncomp-size'])
> +        data = data[:0x30]
> +        data = data.rstrip(b'\xff')
>          orig = self._decompress(data)
>          self.assertEqual(COMPRESS_DATA + U_BOOT_DATA, orig)
>          expected = {
> @@ -6118,8 +6120,9 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
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
> index 95ed30add1aa..1c1dbd5f580f 100644
> --- a/tools/binman/test/184_compress_section_size.dts
> +++ b/tools/binman/test/184_compress_section_size.dts
> @@ -6,6 +6,7 @@
>                 section {
>                         size = <0x30>;
>                         compress = "lz4";
> +                       pad-byte = <0xff>;
>                         blob {
>                                 filename = "compress";
>                         };
>
> --
> 2.45.2
>
