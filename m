Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41900E7849A
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 11:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47F9286DC6;
	Mon,  2 Oct 2023 13:23:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aOlH+5R1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70C9886DCE; Mon,  2 Oct 2023 13:23:33 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0655486D82
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 13:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-405497850dbso144119425e9.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 04:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696245810; x=1696850610; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EgAnEeh0JrxN7me9rdEP2ymjW4STXN5HF8Yu/efl6/s=;
 b=aOlH+5R1civ2vJdQ5DEHV8Ph9VozmIv8oyp3GrzTvAjNYf0Aj2Rp1PgQlW0t9WA8Wy
 VGcvVsUyMUZJ11yJYB3C8A18OdswrEaJsCTRnbAiU0REiHh7SCmsNMju4nFehwibktjd
 5fr+VqLFOg9WFDxE/BBpM1IXbULUdXDoYIuKAOg9hmzJYneDffdtED3sBRr+Vgxq3DIW
 2i81Jk3sTMIUYUCuONaXjSN/w7MO40vo9ogxvFa9zXlbjzsMsqaRYvVphU3nJsvB+uD4
 poTf8IBgIGwa8wXkXiAWKTRN1Po2e6/aarpW9lLu8m+MWNFIesTJyGt78Yqrz5S1jK1i
 A7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696245810; x=1696850610;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EgAnEeh0JrxN7me9rdEP2ymjW4STXN5HF8Yu/efl6/s=;
 b=UmBQ6NxqVg/uE8C7Wzdu8Tf1ooxtdQKwNdkecW2QcOjxTNBfP1sxDOsct6ZUZ+uHiU
 O9qLSYXWK6gFBVvGsePJNUvWAcT+cIGBuGAnljhCcSYO9Sh5XjrnQYh2BzznAw9sqZTy
 5uoI+7rWJSOxnXQRnqpM/w2dLrlSd572lIfs0Abt23kCsTen9VV99IxwV8uaetBhYqhw
 jV5I3Fldw4dTe3Y39w89aaCmdjlm7VPDxUZoMFCSvfjRPGW72BF/wzMLWSUd3Epd/M/i
 6LXLV4Xjdqndx9eCrEZ6dxOGi7Bk5baCcIbXKZffbc9P0kUlL0DATbBv3TzNlbdsEN45
 /48A==
X-Gm-Message-State: AOJu0Yz3bxdODM3Vli4/f/Iw/ZtnL8CKiFCZSXacA3GvGiQIcLkErKAz
 BWtlsxhLjTgPP0p8u2cLqKxMr/+ptzEW443sxpz48A==
X-Google-Smtp-Source: AGHT+IFdqkIrFV2JZH2/TXD4iC5oBPzWbtD4fXCFMwzwnZkftmdmSy5IqNEreXwud2PTzcY8YnLpFlwMCz890jfy2pM=
X-Received: by 2002:adf:ead0:0:b0:31f:f9aa:a456 with SMTP id
 o16-20020adfead0000000b0031ff9aaa456mr10216545wrn.2.1696245810132; Mon, 02
 Oct 2023 04:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
 <20230926094124.7024-2-maxim.uvarov@linaro.org>
 <CAPnjgZ2OV8ug3+3ji8nEnK7cwONu7KFa2zSyP5urKWUkQvMqJA@mail.gmail.com>
 <20230926134149.GS305624@bill-the-cat>
 <CAPnjgZ1iAG8Rw3jVZvFs16AvnGkO=gCsCM3dF1c30biFk4t2xw@mail.gmail.com>
 <20230926141936.GW305624@bill-the-cat>
 <CAD8XO3aifH+f_NZ1g_nJrxKu_tDmuW9H=Pk2o4v8yTAAn1nfdQ@mail.gmail.com>
In-Reply-To: <CAD8XO3aifH+f_NZ1g_nJrxKu_tDmuW9H=Pk2o4v8yTAAn1nfdQ@mail.gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Mon, 2 Oct 2023 17:23:18 +0600
Message-ID: <CAD8XO3Yy1ppSgvUQ3ZZOmVzK2puxruHu2Q4UiCDPUzsWuKA8Vw@mail.gmail.com>
Subject: Re: [PATCHv10 01/15] submodule: add lwIP as git submodule
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@google.com>, u-boot@lists.denx.de, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 goldsimon@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

I found what was missing. (reproduced with CI docker.)

On Mon, 2 Oct 2023 at 12:34, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:

> Can somebody help me to understand and reproduce CI errors?  I can run
> locally 'make check' which runs a bunch of local builds with binman and all
> of them are fine.
> It looks like some dependency is missing or addition 'git config --global
> --add safe.directory <path>/net/lwip/lwip-external'  is required for the
> submodule directory.
>
> https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/17916
>
> Building current source for 1 boards (0 threads, 24 jobs per thread)
>    sandbox:  +   sandbox_spl
> +fatal: not a git repository (or any of the parent directories): .git
> +make[1]: *** [Makefile:1875: initsubmodules] Error 128
> +make: *** [Makefile:177: sub-make] Error 2
>     0    0    1 /1              sandbox_spl
> Completed: 1 total built, 1 newly), duration 0:00:06, rate 0.17
> Traceback (most recent call last):
>   File "/builds/u-boot/custodians/u-boot-tpm/./tools/binman/binman", line
> 45, in <module>
>     from binman import cmdline
>   File "/builds/u-boot/custodians/u-boot-tpm/tools/binman/cmdline.py",
> line 11, in <module>
>     from binman import state
>   File "/builds/u-boot/custodians/u-boot-tpm/tools/binman/state.py", line
> 14, in <module>
>     from dtoc import fdt
>   File "/builds/u-boot/custodians/u-boot-tpm/tools/dtoc/fdt.py", line 14,
> in <module>
>     from libfdt import QUIET_NOTFOUND
> ImportError: cannot import name 'QUIET_NOTFOUND' from 'libfdt' (unknown
> location)
>
> On Tue, 26 Sept 2023 at 20:19, Tom Rini <trini@konsulko.com> wrote:
>
>> On Tue, Sep 26, 2023 at 08:16:35AM -0600, Simon Glass wrote:
>> > Hi Tom,
>> >
>> > On Tue, 26 Sept 2023 at 07:41, Tom Rini <trini@konsulko.com> wrote:
>> > >
>> > > On Tue, Sep 26, 2023 at 05:37:25AM -0600, Simon Glass wrote:
>> > > > Hi Maxim,
>> > > >
>> > > > On Tue, 26 Sept 2023 at 03:43, Maxim Uvarov <
>> maxim.uvarov@linaro.org> wrote:
>> > > > >
>> > > > > add external lwIP library as a git submodule.
>> > > > > Use STABLE-2_2_0_RELEASE tag.
>> > > > >
>> > > > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
>> > > > > ---
>> > > > >  .gitmodules            | 3 +++
>> > > > >  net/lwip/lwip-external | 1 +
>> > > > >  2 files changed, 4 insertions(+)
>> > > > >  create mode 100644 .gitmodules
>> > > > >  create mode 160000 net/lwip/lwip-external
>> > >
>> > > Do you have comments on the rest of the series?
>> >
>> > Not yet, but I should be able to review the rest in a few days. My
>> > main comments before were minor - return codes, tests, error checking.
>>
>> OK, thanks.  I don't know how exactly I want to proceed with the core of
>> lwip itself, but that doesn't block reviewing and testing the rest of it
>> as we'll move forward with it one way or another.
>>
>> --
>> Tom
>>
>
