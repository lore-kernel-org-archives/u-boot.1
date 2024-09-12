Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD0AEE57FB
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEF8988E36;
	Thu, 12 Sep 2024 03:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aiTTfYkr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E25B988E35; Thu, 12 Sep 2024 03:01:20 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACD1288DCF
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:01:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7cf5e179b68so298314a12.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102875; x=1726707675; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J2OC4Goc4SXwaOKVHCXQjvnrMZxN7RhutrTh1NKjbHM=;
 b=aiTTfYkrXbxW0nmwcdj1cP76u/mIK6RuCgHzpof+yxmLwpxJsbNEWaNSl/sU1du6ps
 8Hk6ilCiaE3jCcAJYaJq8HQJfPYrRw0cQ/GsoyNz+qTluUfPra3r1r4APuUAEaR5FBZs
 IRWNnszbvzcsFBa05Nqdd4WlMr93TucPuJfEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102875; x=1726707675;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J2OC4Goc4SXwaOKVHCXQjvnrMZxN7RhutrTh1NKjbHM=;
 b=DnZicpQ+NWS2cobbXUUXfV7sX3MILOsrNkuGsGUjUOmtzfDVrB3uR/pepV80Fu3dSZ
 dkgyA9ry8obWzUnOZyJ3zmmmuaiVl7NcFqAAd0hg3M865DBifkbHZ+9lNZBUV/w4QYvl
 qc4LtOJnVUES4RGnhE6Y9jYXxKkikos1jAw19miinLOyCwSpCuqMsk0/n6QCXD5Q2E1+
 3kj1+85r8egbbWGbYgKJaD+P7YxQlMGQxtqtIlNDWrxIvW2lpBsK+ibWS9c1wxP+vuEv
 0rsu3P6qNYHr9QpWMwr7mkgfvzKlEey1+KRg+gzPuhE22yqbtU8tz0X79q9qxtMnGGBE
 c/Aw==
X-Gm-Message-State: AOJu0Yw4pFjHhMo/JiYPHnxi3ftpmv5noWHmuIBMKS8Qz5cwcWcZSPHE
 76HMGpKnWgoyp5ychon6fP5ttZoZMlHj1283XuBsI5PkA3wm7HK/052KjCUnTGIc5t7gbmFsaep
 W8OnSVUEDiN/E/yEKuYLpnBg/4PAhkF4sINr18u8ELX1XnhY=
X-Google-Smtp-Source: AGHT+IFYS18tOVNq/lzbtcMUJHmFWjHnEyuQVNVlhkGwB7cdq/mRIAKYgkbaqeRjvDFf4f2aUZkdXisKJnTCD9jIcAc=
X-Received: by 2002:a17:90b:1e05:b0:2c9:5a71:1500 with SMTP id
 98e67ed59e1d1-2db9fb436femr1945238a91.0.1726102875561; Wed, 11 Sep 2024
 18:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1726048404.git.jerome.forissier@linaro.org>
 <721993374cd63a2cddced7aff045fd0f23d9ecca.1726048404.git.jerome.forissier@linaro.org>
In-Reply-To: <721993374cd63a2cddced7aff045fd0f23d9ecca.1726048404.git.jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 19:01:01 -0600
Message-ID: <CAFLszTio=nyY4NoDLNEa6v7n6HepBHKkJm1ioobTnHs2+wCOow@mail.gmail.com>
Subject: Re: [PATCH v4 01/15] buildman/toolchain.py: do not set CROSS_COMPILE
 for sandbox
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Brandon Maier <brandon.maier@collins.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
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

Hi Jerome,

On Wed, 11 Sept 2024 at 03:58, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> When building for sandbox, self.cross is empty.
>
> In MakeEnvironment(), CROSS_COMPILE is defined to be self.cross (with
> or without a full path), optionally prefixed by the toolchain wrapper
> defined in ~/.buildman. This is fine when self.cross is not empty, but
> it doesn't make sense when it is:
> - Either there is no wrapper and we end up with an empty CROSS_COMPILE
> which is the same as not defining it (the host compiler will be used),
> - Or there is a wrapper and CROSS_COMPILE will contain only the wrapper
> which obviously is not a valid compiler, hence an error.
>
> Test case:
>
>  $ sudo apt install ccache
>  $ grep -q toolchain-wrapper ~/.buildman || \
>      printf "[toolchain-wrapper]\nwrapper = ccache\n" >>~/.buildman
>  $ make mrproper
>  $ ./tools/buildman/buildman sandbox_noinst
>  $ ./tools/buildman/buildman sandbox_noinst
>  Building current source for 1 boards (1 thread, 24 jobs per thread)
>     sandbox:  +   sandbox_noinst
>  +arch/sandbox/lib/reloc_sandbox_efi.c:10:15: error: operator '==' has no left operand
>  +   10 | #if HOST_ARCH == HOST_ARCH_X86_64
>  +      |               ^~
> [...]
>
> The GetEnvArgs function is modified too, since the VAR_CROSS_COMPILE
> case has the same issue.
>
> In tools/buildman/test.py, testGetEnvArgs is extended and
> testMakeEnvironment is added. They check the 'arm' and 'sandbox'
> toolchains, with and without a wrapper.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  tools/buildman/test.py      | 46 +++++++++++++++++++++++++++++++++++++
>  tools/buildman/toolchain.py |  6 +++--
>  2 files changed, 50 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

I did not expect to still get that same error now, but OK.
