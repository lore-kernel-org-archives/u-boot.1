Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DFAC83F09
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 11:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A45388BD2;
	Thu, 29 Aug 2024 13:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lWTOa4Lw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE33B88B94; Thu, 29 Aug 2024 13:59:19 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A01988BEF
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 13:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3df02c407e9so226255b6e.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 04:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724932756; x=1725537556; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5juzOaFyS670r+P2Ww9P6h8MYpR6XCTEElkJKELJPa0=;
 b=lWTOa4Lwt0gE6ZGbjRTFDJZ7Xxjg3GA/RBl58ZpXPi09b8lhD+GZEK52xAo63yN35b
 xLJdsXWLiR5OoUnU25q3fTr1hwyQ9Np82AONJufRYwX4lSvtaarkOZV/bT36ueAxu/DM
 /Nbn5Ay0EH1+1V7uCG6ZnlPA0a5FfLcKtk6+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724932756; x=1725537556;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5juzOaFyS670r+P2Ww9P6h8MYpR6XCTEElkJKELJPa0=;
 b=Vt01SeN6RlgMaD7HOJ5eziobORzgAEsuGnU5v4Fo+5nfumIz+vPJ7XJ8ZW88uBQmN7
 wctguZXIYhF+VNsABZjbDaid+Ov6GBh4DMPF+TD6GT8WjFiIwL4Ex+s0Mpd+ReT35UUg
 sQOpppVXn9d0gzu78WpJA/uKJgVc/H0POjgMm40xVzLJB37rQaEY7ZJk1H54J1W8hCkv
 FSKVQDFHo6SPGTmY/gy3cctBYv/KVGfMB5iPtgPk0WvrTEauQXyDULkElBRtmP/paG4n
 xObkMCaM8jqS1JBT6Cp15jXwHVy7KAehzrDqEvENb06ch5eluIqx+lmxvP5r6s1UcK3+
 rUyA==
X-Gm-Message-State: AOJu0Yx5Z/KyIa1yxIpA/dzxp2vvVhwadqP/vYIwXmd+9O4OduXIm4oZ
 H/cImISzfRZBRPNdQtuekwfZF1EliTI6Y5X9Mcm3CvqXyqasDHcDpyM7I08AGNNoDUdMelCXddk
 6D/DpX9UFpMJNon4uWPjFth0zfn9FcDAxYWZns2aVQOoxN8A=
X-Google-Smtp-Source: AGHT+IHsl1HAR8d7foy2JPBRM0+5LCji1c8Kp4sQUUTLJkLTzf6Eal9gbM8q1qehiR7jkm2s56jsd4BOnCm2BoU2uLA=
X-Received: by 2002:a05:620a:178a:b0:79e:ff18:a510 with SMTP id
 af79cd13be357-7a8084a6eedmr311793085a.2.1724932378921; Thu, 29 Aug 2024
 04:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240828225610.3081635-1-trini@konsulko.com>
In-Reply-To: <20240828225610.3081635-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 05:52:48 -0600
Message-ID: <CAFLszTh=5Oknno_P3g+3G=ea8o0rhKwLWNoUoBA9uyO3R5dYjA@mail.gmail.com>
Subject: Re: [PATCH] test/py/tests/test_bootstage.py: Combine stash/unstash
 tests
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Love Kumar <love.kumar@amd.com>, 
 Michal Simek <michal.simek@amd.com>
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

On Wed, 28 Aug 2024 at 16:56, Tom Rini <trini@konsulko.com> wrote:
>
> When running the bootstage tests currently we get a warning like:
> tests/test_bootstage.py::test_bootstage_stash
> ...PytestReturnNotNoneWarning: Expected None, but tests/test_bootstage.py::test_bootstage_stash returned (37748736, 4096), which will be an error in a future version of pytest.  Did you mean to use `assert` in stead of `return`?
>
> This is because the unstash test will run the stash test and fetch the
> addr / size from that. Rework the test to be stash and unstash and then
> run the unstash command at the end of the current stash test.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> It's possible we could solve this instead by getting addr / size again
> from our environment file, and then also noting that order-wise the
> unstash test follows the stash test. However, this felt more clean to
> me.
>
> Cc: Love Kumar <love.kumar@amd.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  test/py/tests/test_bootstage.py | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/test/py/tests/test_bootstage.py b/test/py/tests/test_bootstage.py
> index a9eb9f0b4a11..bd71a1af3a25 100644
> --- a/test/py/tests/test_bootstage.py
> +++ b/test/py/tests/test_bootstage.py
> @@ -33,7 +33,7 @@ def test_bootstage_report(u_boot_console):
>  @pytest.mark.buildconfigspec('bootstage')
>  @pytest.mark.buildconfigspec('cmd_bootstage')
>  @pytest.mark.buildconfigspec('bootstage_stash')
> -def test_bootstage_stash(u_boot_console):
> +def test_bootstage_stash_and_unstash(u_boot_console):
>      f = u_boot_console.config.env.get('env__bootstage_cmd_file', None)
>      if not f:
>          pytest.skip('No bootstage environment file is defined')
> @@ -55,13 +55,8 @@ def test_bootstage_stash(u_boot_console):
>      # Check expected string in last column of output
>      output_last_col = ''.join([i.split()[-1] for i in output.split('\n')])
>      assert expected_text in output_last_col
> -    return addr, size
>
> -@pytest.mark.buildconfigspec('bootstage')
> -@pytest.mark.buildconfigspec('cmd_bootstage')
> -@pytest.mark.buildconfigspec('bootstage_stash')
> -def test_bootstage_unstash(u_boot_console):
> -    addr, size = test_bootstage_stash(u_boot_console)
> +    # Check that unstash works as expected
>      u_boot_console.run_command('bootstage unstash %x %x' % (addr, size))
>      output = u_boot_console.run_command('echo $?')
>      assert output.endswith('0')
> --
> 2.34.1
>
