Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FA9EC1117
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 17:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1C2E8063E;
	Mon, 23 Feb 2026 18:52:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ifY+CoLO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C8D78063E; Mon, 23 Feb 2026 18:52:41 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1252283E13
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 18:52:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a79ded11a2so31101235ad.3
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 09:52:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771869157; cv=none;
 d=google.com; s=arc-20240605;
 b=ddfctVk129Vlox0Ao8DJUe/ZX87BZDQSblFar+6oJeRYANJrgu11DNEQ5vPX8NR7Fn
 GNTpwDzuQhRMS64XwfkqfwQRgvMIvVd9WwDOxlKexiWP4rkh4H0qqGOAvhWhi5jyPwMR
 MPuFXtqXqrGrcAs25tjG/H4uQD0w5l6Lsi5P98KGV1LYvFcmOgh8KP6B3WCjXdIJ3XZT
 nEZWsb6T92zpnvW9BDNMOElwEX60jOv+POuNjPT5njr/A1M4ec+cRWXtPKB7IPxoJARw
 Av6Zaym81W1zKEi9uVRat96jgPR1NMDHasoyvVuxM5lhpe+Ib/iHYb+y0F0STk7M7TjF
 q8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hqY4ALRlIokAIuu6NIgSe2VFnxkwXhpSEaAqEzyoJOg=;
 fh=89JGekwhSyYOPQOy2uyR8LelJwXS2WWWd2nllJCIfB4=;
 b=UfENoI1YJ3UkwNCEilctvXV7Gcw7H2ysEv+4wqlG2JNScQoYpQfhZ9fi6giQUmafO+
 OFPDlWKwdlp5Mu7lBIcCVpZf5PjX1tETjf8NZL++0jerDdW1ZWlbPr2TjjRe+YNuqGp0
 bEQDe0mptF9pkpOIQ06b/PbUe4WJ5Mh3el0h/WaDveeVh/9a2fMrNOAz1jg/PZgNPzSM
 J6rW2IvfPWf8tOg2s2W5HMxN7jXySfB1sSNRYR00Hw5SeKPniuXUdhQRWVPy4Y1l1cq2
 k5xVAn9mKr8EgtoKvWOa/lPTurCNFz7xsLJD8QPkTw5b4wl+jNcz0MwRnOZCdqAPiz33
 5GCg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771869157; x=1772473957; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hqY4ALRlIokAIuu6NIgSe2VFnxkwXhpSEaAqEzyoJOg=;
 b=ifY+CoLOAElzE2Cs+hw2l+oE/V303Mb7m8w3XMh9c1d/X2dufB8soNzW0z+V5YM6OO
 bwxHdAEMVzLnmCh3EhCL08F9BfspM7jEKcy87BlADblZnBRR+h8oGKM4dFnpjuYMqaLo
 LxACUW2ymLTjy7b1BKaSTtLYtXIwUz2FrDg2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771869157; x=1772473957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hqY4ALRlIokAIuu6NIgSe2VFnxkwXhpSEaAqEzyoJOg=;
 b=keCrvE4p+A9f8k32ulAAYkJQNXWZwemKpHSam7CvtzeJ2cl0/+9mMej2mINddxme3k
 J3dCAjYafiMWc5Q/hMlEKmfhedS1cF+8JKgmBM/tFqv8Iroe4D+V5nUytBVihOKO/fyl
 nDJUTf2HseJx2U1gCs/9mNKtespmmyzjtGQttIXEcECHkBYF06q9Mnb/q2XScL54AjT3
 53GWnnHVsgfQW9LejbIpIMbyQRs9XvSz4IJDR8xNpIs7sjxBsCym5Wz1GHPVpgxOdC4D
 vaax3vkAXhY1eQGPtlBUTnERuB5BeO6LhqXKkdhdDI71d0o81eV4zkyHK63SNBb1JyjW
 Qkkw==
X-Gm-Message-State: AOJu0YzWn+8voGsYR9mGvon3c44BHVADltHCStRKIbnYNqrA2zG1FbB/
 Mo111glQ2xsVlxIxVrbgaNGG0xdLoFqGzNnMwSODz4p8oQjmUb7WDozlDE6VbWcjXTHdpxfA4OJ
 6dq9/ZgL49yDK0Qp9ebqMH2xcng4XD5/chLlLKCUY
X-Gm-Gg: ATEYQzyO28pzpyyewSn2KzfN+aSSZdTFjPksSoWa3+YGswj4yfCS/t6YC10SJ350iCu
 HcO79Wd59tsNW4zEFnedxX9909BcyyJbKuAU/QERF5hiuYTYVaEE8N12D3h7jZqa7KIgAzifepz
 5WhmC0pP6aEuSDKtfXarzQT5O4YHuN2Jvxm34zjmabAdGCDehy9wTN75bL52ukf36YerwXk+2ac
 +TiiEJpXrj7F2pfZvxpt9hrmEgE7iEtOMas8sWlql1rRuiBsASWKFlSCLnhoV+RudMHtr15R5QX
 CKdGmQ==
X-Received: by 2002:a17:902:db02:b0:2a7:3db0:6efe with SMTP id
 d9443c01a7336-2ad743ffd1cmr83409355ad.12.1771869157377; Mon, 23 Feb 2026
 09:52:37 -0800 (PST)
MIME-Version: 1.0
References: <20260217115333.503359-1-Wojciech.Dubowik@mt.com>
 <20260217115333.503359-5-Wojciech.Dubowik@mt.com>
 <CAFLszThD4sb6dDOq_8-XJ-QapoxbuHOZJt0rRJBeydpr6fhFJw@mail.gmail.com>
 <aZcq99-dMBpCNqzv@mt.com>
In-Reply-To: <aZcq99-dMBpCNqzv@mt.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Feb 2026 10:51:22 -0700
X-Gm-Features: AaiRm53RMb3GEJGKDivqRsNbmC4cEgbix1ROvaL2XNJgjNmcAWWBzXbeoqhO5u0
Message-ID: <CAFLszTjb0aWy=8_+fc+Rgyf1Q80rbbsMO_N2b7h+PAv_ih11WQ@mail.gmail.com>
Subject: Re: EXTERNAL - [PATCH v6 4/6] binman: Add dump signature option to
 mkeficapsule
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, trini@konsulko.com, 
 simon.glass@canonical.com, quentin.schulz@cherry.de
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

Hi Wojciech,

On Thu, 19 Feb 2026 at 08:23, Wojciech Dubowik <Wojciech.Dubowik@mt.com> wrote:
>
> On Thu, Feb 19, 2026 at 07:31:08AM -0700, Simon Glass wrote:
> Hi Simon,
>
> > Hi Wojciech,
> >
> > On Tue, 17 Feb 2026 at 04:54, Wojciech Dubowik <Wojciech.Dubowik@mt.com> wrote:
> > >
> > > It will be used to capsule signature verification.
> > >
> > > Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > > ---
> > >  tools/binman/btool/mkeficapsule.py | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/binman/btool/mkeficapsule.py b/tools/binman/btool/mkeficapsule.py
> > > index f2ac654db81e..7638c941a8ee 100644
> > > --- a/tools/binman/btool/mkeficapsule.py
> > > +++ b/tools/binman/btool/mkeficapsule.py
> > > @@ -38,7 +38,8 @@ class Bintoolmkeficapsule(bintool.Bintool):
> > >
> > >      def generate_capsule(self, image_index, image_guid, hardware_instance,
> > >                           payload, output_fname, priv_key, pub_key,
> > > -                         monotonic_count=0, version=0, oemflags=0):
> > > +                         monotonic_count=0, version=0, oemflags=0,
> > > +                         dump_sig=False):
> > >          """Generate a capsule through commandline-provided parameters
> > >
> > >          Args:
> > > @@ -53,6 +54,7 @@ class Bintoolmkeficapsule(bintool.Bintool):
> > >              monotonic_count (int): Count used when signing an image
> > >              version (int): Image version (Optional)
> > >              oemflags (int): Optional 16 bit OEM flags
> > > +            dump_sig (bool): Dump signature to a file (Optional). Default no.
> > >
> > >          Returns:
> > >              str: Tool output
> > > @@ -73,6 +75,8 @@ class Bintoolmkeficapsule(bintool.Bintool):
> > >                  f'--private-key={priv_key}',
> > >                  f'--certificate={pub_key}'
> > >              ]
> > > +        if dump_sig:
> > > +            args += [f'--dump-sig']
> > >
> > >          args += [
> > >              payload,
> > > --
> > > 2.47.3
> > >
> >
> > It looks like there are still two problems with test coverage:
> >
> > tools/binman/etype/efi_capsule.py                          65      2    97%
>
> Do you know what the second one is? I see on my setup only one:
>            if 'pkcs11:' in self.public_key_cert:
> ***            public_key_cert = self.public_key_cert

It looks like you have fixed both, in v7!


>
> Regards,
> Wojtek
>
> > tools/binman/etype/fit.py                                 358      1    99%

Regards,
Simon
