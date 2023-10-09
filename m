Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C8BE95A91
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 07:46:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C22AE8692B;
	Mon,  9 Oct 2023 09:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ELMqsQX+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DB4086940; Mon,  9 Oct 2023 09:46:16 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8487B86504
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 09:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-533c8f8f91dso7337739a12.0
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 00:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696837574; x=1697442374; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LZ4vDAPS1GZ0DgNYk5ygw6JWcxlBbEuxtdIaAf0U1SU=;
 b=ELMqsQX+tIzIZ3rodcO50LhttkcK8799TaA5GbMlOq4Ep82s+mus0JsIvC3xpSe8ti
 LlZSbsGHwv6J0C3Wn0+Oxu1GkVwTx2yc8G8XGMs659tPM5rB3e2ji6maiAlrTcWEAsuS
 /DnhtB2Ta5UXX2pgvSzmh9pr4A4pzeWHOmMGp25ein1ImR9g+sUpM1ak9Mo08uQCqrCL
 jgQxlQm+I2YKcFXr7xcuOiEN43jSCIJf/SOPGKkEivwyaDWVQ3QYtBizNguwO+3WzeTS
 JPXEqaSx4+tT0M9sMHdx8rXkwe1VXzsa1EAFmqH2rLdPsA5PbFIc7jGWdWzvzKPP2a7g
 Y+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696837574; x=1697442374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LZ4vDAPS1GZ0DgNYk5ygw6JWcxlBbEuxtdIaAf0U1SU=;
 b=KUHVtNybdZQeNSwd3g47yfOTMz4BRsblmjEG29b9D6mNOigRgcyxMmWQOf1QKsSJJw
 8QuIWRkGTOtEkfmUz/paKJsm9EGu59A8exvcOqjp5WeZRe9I6Qf0MidUHdSlg26T9fX/
 96i4nGdw8U9Rr5IkA/bpZcZRsZU4/PI4n8D2mdos1ZpG2Wg359DUMm1SkzHQ15OmiTdV
 3x4M69JOfvJ1z69b0/IM1QEtDNM9IumZlP0Q/Hj4LHLPsxwPWezRD3el9t1yErAM3Su/
 pgs0oEuJSFulMtjVbosNVNME0FcooVskw9p3W9JF09GM16k30hq7G9qB8/yTJgBrJLVq
 yciw==
X-Gm-Message-State: AOJu0Ywaiw3tOxHwy9dMVHIe0D0scmTViXXwW57KBPLvvfTbvL92+V5B
 wxHIzHr5zxv2FUJiPsPIZ8/C/bhgN1o9rP5M8PNjFQ==
X-Google-Smtp-Source: AGHT+IEHur4rsMDhL9B0j+b98ZA5/fWL6U+9E7sz6mqvv86IrZsEb1fRBvzlH3k8WxzQ+LTxyJ1fQT0p66f9ZdM6BzA=
X-Received: by 2002:a05:6402:14d2:b0:530:e9bf:1ea3 with SMTP id
 f18-20020a05640214d200b00530e9bf1ea3mr13910446edx.7.1696837573954; Mon, 09
 Oct 2023 00:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231004112722.416877-1-sughosh.ganu@linaro.org>
 <20231004112722.416877-4-sughosh.ganu@linaro.org>
 <CAPnjgZ0_8FqJEarNvE6RN218PJWUGu1W0_f3iVjzBTibpQ1KFg@mail.gmail.com>
In-Reply-To: <CAPnjgZ0_8FqJEarNvE6RN218PJWUGu1W0_f3iVjzBTibpQ1KFg@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 9 Oct 2023 13:16:02 +0530
Message-ID: <CADg8p97Xpc6MVs+oviNZ1NnKq4cvAuntb1HpO4K0PnJ7DULj9Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] binman: capsule: Use dumped capsule header contents
 for verification
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

hi Simon,

On Sun, 8 Oct 2023 at 04:41, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 4 Oct 2023 at 05:27, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > The various fields of a generated capsule are currently verified
> > through hard-coded offsets. Use the dump-capsule feature for dumping
> > the capsule header contents and use those for capsule verification.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >  tools/binman/ftest.py | 95 ++++++++++++++++++++++++-------------------
> >  1 file changed, 54 insertions(+), 41 deletions(-)
>
> This looks good apart from a few nits below. However, the tests fail for me.

Can you please specify which tests fail, and the way to reproduce the
failures? I ran the tests before sending the patches, and they ran
fine, including the coverage which is 100%. Ci too did not complain.

>
> >
> > diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> > index 8e419645a6..2b8871ab7e 100644
> > --- a/tools/binman/ftest.py
> > +++ b/tools/binman/ftest.py
> > @@ -121,9 +121,11 @@ COMP_BINTOOLS = ['bzip2', 'gzip', 'lz4', 'lzma_alone', 'lzop', 'xz', 'zstd']
> >  TEE_ADDR = 0x5678
> >
> >  # Firmware Management Protocol(FMP) GUID
> > -FW_MGMT_GUID = 'edd5cb6d2de8444cbda17194199ad92a'
> > +FW_MGMT_GUID = '6DCBD5ED-E82D-4C44-BDA1-7194199AD92A'
> >  # Image GUID specified in the DTS
> > -CAPSULE_IMAGE_GUID = '52cfd7092007104791d108469b7fe9c8'
> > +CAPSULE_IMAGE_GUID = '09D7CF52-0720-4710-91D1-08469B7FE9C8'
> > +# Windows cert GUID
> > +WIN_CERT_TYPE_EFI_GUID = '4AAFD29D-68DF-49EE-8AA9-347D375665A7'
>
> Please use lower-case hex

Okay

>
> >
> >  class TestFunctional(unittest.TestCase):
> >      """Functional tests for binman
> > @@ -7223,52 +7225,63 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> >          self.assertRegex(err,
> >                           "Image 'image'.*missing bintools.*: bootgen")
> >
> > +    def _GetCapsuleHeaders(self, data):
>
> This should have a function comment so it is clear what it is doing, returning.

Will add

-sughosh

>
> > +        capsule_file = os.path.join(self._indir, 'test.capsule')
> > +        tools.write_file(capsule_file, data)
> > +
> > +        out = tools.run('mkeficapsule', '--dump-capsule', capsule_file)
> > +        lines = out.splitlines()
> > +
> > +        re_line = re.compile(r'^([^:\-\t]*)(?:\t*\s*:\s*(.*))?$')
> > +        vals = collections.defaultdict(list)
> > +        for line in lines:
> > +            mat = re_line.match(line)
> > +            if mat:
> > +                vals[mat.group(1)] = mat.group(2)
> > +
> > +        return vals
> > +
> [..]
>
> Regards,
> Simon
