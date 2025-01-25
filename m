Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76526C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 17:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E425D80F10;
	Sat, 25 Jan 2025 18:11:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oF7ZRYvm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4897E80EFB; Sat, 25 Jan 2025 18:11:42 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33ED280ECD
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 18:11:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d3d0205bd5so4655925a12.3
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 09:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737825099; x=1738429899; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DZYrRDRUYCihgWhb0WTyDDfC3nsfZmCKXdpcih/bl2c=;
 b=oF7ZRYvm4Xv1aj8HjELhveBBf5ayf9pm74f4B1dki6ZbZn+X+xUZMnaOm/Jwgx6iMm
 UEdqOe+4Jt+mKWT2kvzt9NVb6gO3gvKMAtKfwq+JBC9w6/SoTW08TsWNaG2n7JyFMQu9
 1f7vTn3fg4+R8/czvZR/c979D7eRvKwTLj4Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737825099; x=1738429899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DZYrRDRUYCihgWhb0WTyDDfC3nsfZmCKXdpcih/bl2c=;
 b=HWZoADmrssUDBdqm86X2qC4Ze3KnsvYs/cgG9U6iNpfydmpVcKNq2zMSRbiKmaVt/L
 1RsMvXzNYlG5Syzl3uFex1NS3/8lPvcl7c30yYAHvPhQUunM/w5slsfWGZ7ynoQr9qni
 TO1/ZJ0rp25YZ36fd/raM1S7DNR7gLTK07RE9wN+3txcH3VpATLsQMHKYiMJXYAFwPJi
 jNyM8shTZyB++UmQAjtU1jl5ygz8pX9c5GNVMuCgbD9/voJdnggyAugoG52bXxdtOc0l
 x0Tf6i2msK1cpl/Z0wix8z1sq+QeAY7/14nQw/J9RDvXkdJL0O47Vd2MIGX8tc/dAbW+
 JT0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbGiLxioIpKiKxRKwJ3/o1DP0PpUAzaAgQfmqGkPG4906DIqbRBD3SHpzdPj02Auo4YPTgEKs=@lists.denx.de
X-Gm-Message-State: AOJu0YwG+PlCM5KTUULynccnuDtG2uCmrBZ3ZFOCllAHFMp7rmVFUus9
 WRkmZo1OJrlM46+PxihlcluJHTTSXpAJfS0nJDb9p1aCWYocf6yzuq4HR8JqXo68kmnnI0FV4pD
 hNLhLiB3Yuk0rhrHU/rDL7GuZJhStHxXGBt9YseQX6G9VzNs=
X-Gm-Gg: ASbGncuZjYi7o2LoT60xGLusQ8w3KBJYTx0vhfE83vaJ3ojeno9IxjGxEKhsnhatyQ5
 9J6mM+8hTXeHbVLO9TQx72+HQe/fSKgDac8sH/s7DIeCuEBwSKco3JtjnTcM/9OY=
X-Google-Smtp-Source: AGHT+IHZjronj+30PS7jhOeqrwzKrmsOnSr3E5rkujZROL/VYZ7QBJLEi1gnlGSUef3Y1FV5Isz6SkAaMvlOdNI5lDE=
X-Received: by 2002:a05:6402:2549:b0:5d9:84e8:6152 with SMTP id
 4fb4d7f45d1cf-5db7db2e31emr29474396a12.32.1737825099211; Sat, 25 Jan 2025
 09:11:39 -0800 (PST)
MIME-Version: 1.0
References: <VI1PR07MB9972394B8A364AC9A18495F6F7192@VI1PR07MB9972.eurprd07.prod.outlook.com>
 <VI1PR07MB9972E22550B1514AD604D399F7192@VI1PR07MB9972.eurprd07.prod.outlook.com>
 <VI1PR07MB9972D12CDEDF3ADFF7D81B2AF7E72@VI1PR07MB9972.eurprd07.prod.outlook.com>
 <878qr4wm5o.fsf@prevas.dk>
 <VI1PR07MB997209D177C705DD5371F0D6F7E12@VI1PR07MB9972.eurprd07.prod.outlook.com>
 <87v7u6v38k.fsf@prevas.dk>
In-Reply-To: <87v7u6v38k.fsf@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 25 Jan 2025 10:11:25 -0700
X-Gm-Features: AWEUYZkOLxoL4igeXlU9hTA5lYom-wlggnzemWjVG77M4BqGIEx3pW5Mv-OLJ-Y
Message-ID: <CAFLszTjNX23b9-_7AYrrJ7uu9fYeEuReb+TEDy9SQYss66E1Rw@mail.gmail.com>
Subject: Re: AW: secure boot, mkimage with external signing server
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: "Rosenschild, Klaus" <Klaus.Rosenschild@hilti.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Rasmus,

On Wed, 22 Jan 2025 at 16:27, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> On Wed, Jan 22 2025, "Rosenschild, Klaus" <Klaus.Rosenschild@hilti.com> wrote:
>
> > Hi Rasmus,
> > thank you for pointing to this solution.
> > I think this is the best way to do this.
> >
> > However, our signing server is very well protected and making changes there is a long and complex process.
> > Right now, it only provides the following two functions:
> >
> >   1.
> > generation of a signature of a sha256 hash using the private key
> >   2.
> > providing the public key, the pure key, not the certificate
> >
> > I found a workaround to determine the hash that mkimage uses to create the signature of the configuration without re-implementing the internal algorithm that mkimage uses:
> >
> >   1.
> > create a temporary rsa private and public key
> >   2.
> > run mkimage to create a FIT image with signature: mkimage -k keys-f fitImage-sign-orig.its -r fitImage-sign
> >   3.
> > extract the signature from the FIT image
> >   4.
> > re-generate the hash from the signature and the public key: openssl pkeyutl -verifyrecover -in signFile.hash.sign.bin -pubin -inkey ../keys/build.pub -asn1parse
> >   5.
> > now, I can send the hash to the signing server, get the correct signature back and re-enter it into the FIT image (e.g. via python libfdt)
> >
>
> Urgh, it shouldn't be that complicated, and I would consider it quite
> reasonable if mkimage could be instructed to emit the hash it actually
> signs along with the signature.

Yes that sounds useful.

>
> But, I do think you should be able to create a pkcs#11 module which
> simply takes that sha256 as input from the higher layers and does
> whatever it needs to do to talk to the server, getting the signature
> back.
>
> > However, there is now another problem. I also need to put the public key into the device tree file. So, I have to run a slightly different mkimage command (with  -K option):
> > mkimage -k keys -f fitImage-sign-orig.its -r -K bcm2711-rpi-4-b.dtb fitImage-sign

Note also that you don't need the original source. You can use the -F option.

> >
> > However, the -K options requires a certificate and not just the
> > public.
>
> Yeah, that is a fundamental design flaw of mkimage; one shouldn't need
> to sign any image in order to get the public key data embedded in
> u-boot's control dtb.

It would be nice to have a way to generate an instructions file, which
contains the hash to be signed, then a way to read the result file,
loading the private/public keys in as needed. In other words, split
the operations of mkgimag into two.

>
> Fortunately, you can ignore what most tutorials tell you about that -K
> option. There is a simple script in the u-boot repo, tools/key2dtsi.py,
> which you can apply to just the public key, and you get a .dtsi fragment
> that you can include when you build u-boot's control dtb. Either you can
> use the CONFIG_DEVICE_TREE_INCLUDES mechanism for making sure that .dtsi
> gets picked up during build, or you can simply copy-paste the contents
> into your board's .dts file.
>
> Rasmus

Regards,
Simon
