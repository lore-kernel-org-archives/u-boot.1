Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA2CCD612E
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 19:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20513864A0;
	Mon,  9 Oct 2023 21:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ez66Um6Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED56A864A6; Mon,  9 Oct 2023 21:41:26 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF8A086489
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 21:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-534659061afso8169607a12.3
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 12:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696880484; x=1697485284; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QNiLXui5dwkhiHEQzQKi+HBOC0K0BFXTe/9eC14kpEs=;
 b=Ez66Um6YrlKz77sPlmNeEJn5TSl5IwS8/Gwa8diDxaOufDDgvM2GH8QAsd/plfdkVD
 o+IWyhrUv594hFtE7tXuTAvRLnL+wRAv4krk/GsJb5Y5veRfzSNf3t0Yk3v7WzpayQrI
 nbwHUFi8xaonVPoMq4uaB748/q/PW24gq3Ggq4t7LAy4tHglYEqEANkHn44940GwW3nK
 YEKpi7tgZ0JFjmnfEK4tkEXgVhhMTAHiSv1hZOWb43Zih7pI40NvybxQUDZ2GN6dpluA
 mPiHB4g5mvDk1wGABkKUAQjRvV1A+6DWORocPND7iugZn5x65M33d304hrtyQmglYFOq
 qGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696880484; x=1697485284;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QNiLXui5dwkhiHEQzQKi+HBOC0K0BFXTe/9eC14kpEs=;
 b=sFcgXhjaHpkacZ3G4bZK+TmfqXuQodPVtC/ib0e3gDr86SttsBJ9C10xsQAA4Ojsrk
 qvmWYEow5yzSVpP1Qny3tUeOYEnjFTZqR4nAvRLXqOOL50+pPb6ByKobFJ09uO/KInsc
 fJSQOGsVtLs7JducFUi92LhusmZavL7PtFzAoVgn0Rf7RPn14UblmE2jM/CgUT0jahu3
 jzz4UloEAo2JnH9/s+57P9sSxwgJDg6AUcNYUJJ1s1XiVQgu/ni/hIWWlaVtVrjeaWvp
 dsQn+0ZHFOz6RgHoEKFCx7DCsmLcdR56RuzZTQPRlmALzIcIF6ePmJ6vs0qR3aOTuBSN
 3udA==
X-Gm-Message-State: AOJu0Yycii8wCCWkBtF3KERjCXkhMBb1sxveSucQfIghUoSLeWi/fj/5
 Vq5j/3PWgjVKxo+zivFgDcHACb18bmtzRQuxX1gcsw==
X-Google-Smtp-Source: AGHT+IE+XC0i9zY8dpxqUzwZq4+8eL28SZL8IvwoSwV1f7d0O46u3VD8BrSQcaUVxM9SeyOVAVUFuYr/IeH+FDFd310=
X-Received: by 2002:aa7:c607:0:b0:530:7abf:3a84 with SMTP id
 h7-20020aa7c607000000b005307abf3a84mr13506565edq.25.1696880484403; Mon, 09
 Oct 2023 12:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231004112722.416877-1-sughosh.ganu@linaro.org>
 <20231004112722.416877-4-sughosh.ganu@linaro.org>
 <CAPnjgZ0_8FqJEarNvE6RN218PJWUGu1W0_f3iVjzBTibpQ1KFg@mail.gmail.com>
 <CADg8p97Xpc6MVs+oviNZ1NnKq4cvAuntb1HpO4K0PnJ7DULj9Q@mail.gmail.com>
 <CAPnjgZ0HocWeW9eNtXXjVPAyL1bu4YU=CE=iSKsXN5hg7u8Ysw@mail.gmail.com>
In-Reply-To: <CAPnjgZ0HocWeW9eNtXXjVPAyL1bu4YU=CE=iSKsXN5hg7u8Ysw@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 10 Oct 2023 01:11:13 +0530
Message-ID: <CADg8p97YLcGQk50aBwgpRnKc4GzM-rtY=2DzWZYGy9qx95r5hw@mail.gmail.com>
Subject: Re: [PATCH 3/5] binman: capsule: Use dumped capsule header contents
 for verification
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
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

On Mon, 9 Oct 2023 at 23:27, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Mon, 9 Oct 2023 at 01:46, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > hi Simon,
> >
> > On Sun, 8 Oct 2023 at 04:41, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Wed, 4 Oct 2023 at 05:27, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > The various fields of a generated capsule are currently verified
> > > > through hard-coded offsets. Use the dump-capsule feature for dumping
> > > > the capsule header contents and use those for capsule verification.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > >  tools/binman/ftest.py | 95 ++++++++++++++++++++++++-------------------
> > > >  1 file changed, 54 insertions(+), 41 deletions(-)
> > >
> > > This looks good apart from a few nits below. However, the tests fail for me.
> >
> > Can you please specify which tests fail, and the way to reproduce the
> > failures? I ran the tests before sending the patches, and they ran
> > fine, including the coverage which is 100%. Ci too did not complain.
>
> Sure, for example:
>
> $ binman test testCapsuleGen
> ======================== Running binman tests ========================
> /usr/lib/python3.10/os.py:1030: RuntimeWarning: line buffering (buffering=1) isn't supported in binary mode, the default buffer size will be used
>   return io.open(fd, mode, buffering, encoding, *args, **kwargs)
> /usr/lib/python3.10/os.py:1030: RuntimeWarning: line buffering (buffering=1) isn't supported in binary mode, the default buffer size will be used
>   return io.open(fd, mode, buffering, encoding, *args, **kwargs)
> F
> ======================================================================
> FAIL: binman.ftest.TestFunctional.testCapsuleGen (subunit.RemotedTestCase)
> binman.ftest.TestFunctional.testCapsuleGen
> ----------------------------------------------------------------------
> testtools.testresult.real._StringException: Traceback (most recent call last):
> AssertionError: '6DCBD5ED-E82D-4C44-BDA1-7194199AD92A' != []
>
>
> ----------------------------------------------------------------------
> Ran 1 test in 0.147s
>
> FAILED (failures=1)

That is interesting. When I run the tests, they run just fine. I had
tested them before sending the patches. For e.g.

./tools/binman/binman test testCapsuleGen
======================== Running binman tests ========================
.
----------------------------------------------------------------------
Ran 1 test in 0.375s

OK

-sughosh

>
>
> >
> > >
> > > >
> > > > diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> > > > index 8e419645a6..2b8871ab7e 100644
> > > > --- a/tools/binman/ftest.py
> > > > +++ b/tools/binman/ftest.py
> > > > @@ -121,9 +121,11 @@ COMP_BINTOOLS = ['bzip2', 'gzip', 'lz4', 'lzma_alone', 'lzop', 'xz', 'zstd']
> > > >  TEE_ADDR = 0x5678
> > > >
> > > >  # Firmware Management Protocol(FMP) GUID
> > > > -FW_MGMT_GUID = 'edd5cb6d2de8444cbda17194199ad92a'
> > > > +FW_MGMT_GUID = '6DCBD5ED-E82D-4C44-BDA1-7194199AD92A'
> > > >  # Image GUID specified in the DTS
> > > > -CAPSULE_IMAGE_GUID = '52cfd7092007104791d108469b7fe9c8'
> > > > +CAPSULE_IMAGE_GUID = '09D7CF52-0720-4710-91D1-08469B7FE9C8'
> > > > +# Windows cert GUID
> > > > +WIN_CERT_TYPE_EFI_GUID = '4AAFD29D-68DF-49EE-8AA9-347D375665A7'
> > >
> > > Please use lower-case hex
> >
> > Okay
> >
> > >
> > > >
> > > >  class TestFunctional(unittest.TestCase):
> > > >      """Functional tests for binman
> > > > @@ -7223,52 +7225,63 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> > > >          self.assertRegex(err,
> > > >                           "Image 'image'.*missing bintools.*: bootgen")
> > > >
> > > > +    def _GetCapsuleHeaders(self, data):
> > >
> > > This should have a function comment so it is clear what it is doing, returning.
> >
> > Will add
> >
> > -sughosh
> >
> > >
> > > > +        capsule_file = os.path.join(self._indir, 'test.capsule')
> > > > +        tools.write_file(capsule_file, data)
> > > > +
> > > > +        out = tools.run('mkeficapsule', '--dump-capsule', capsule_file)
> > > > +        lines = out.splitlines()
> > > > +
> > > > +        re_line = re.compile(r'^([^:\-\t]*)(?:\t*\s*:\s*(.*))?$')
> > > > +        vals = collections.defaultdict(list)
> > > > +        for line in lines:
> > > > +            mat = re_line.match(line)
> > > > +            if mat:
> > > > +                vals[mat.group(1)] = mat.group(2)
> > > > +
> > > > +        return vals
> > > > +
> > > [..]
> > >
> > > Regards,
> > > Simon
>
> Regards,
> SImon
