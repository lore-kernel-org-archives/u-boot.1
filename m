Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3492EEC1113
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 17:42:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0D0E83C6E;
	Mon, 23 Feb 2026 18:42:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KZgtp7Sd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CF9983D0F; Mon, 23 Feb 2026 18:42:08 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E4C683935
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 18:42:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-65a36583ef9so37921a12.0
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 09:42:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771868526; cv=none;
 d=google.com; s=arc-20240605;
 b=Gi5g4vZCZZN4nhukm3x51e+IPVs5CcNerJoHRZfdWYXYh1tVmzBFxhz/8m55kWF/Mi
 CNA9LXAiCtpt/Z/qzL5Ap/qnRLe+LkGZWMGollzeuCB+NuUArgItz+Uy5BXCjN9LIkP8
 lONVasAsKD8p9YHiysK1Yts97yS6YABtUCr/kMW+rTPERH6fkENlyYMOjYSWSjzaqy+N
 +CFfXxG8Pl3XccxYR2pNuYWrlbXiiIS0tVaPtQkdxFp6Bikj4nXXyG3tpXjVR6V+S0Qh
 erpolNrlme8eSvOTaE7SVZxJ15zoWZ8nuiOQ5+KszuTpyBgBA2lT4+P+mOZM8ihE/kUg
 uw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aIayxqNX4lcDhsNZVVKmIgwO5SWy86V/FKs9O41znUQ=;
 fh=RPgTYJ68neRIQTFm+6R4eja2dl/YuQ9PskF80fCLAcE=;
 b=k+i+f3H0UvSIIc8MMW+LQzg0mNR425ca8d7lv61zk8/0l3c2gpItFGTA+GV4NL4o93
 65k+0JqwjoEiaGwZ0t44rRPhfrQTH2ySd5WLT6OS9qHJ/iRdEvmW+q5zyL9jz0pyfZ7Q
 0guLNeFeU6E4lTFPDd4D0FaJ6vU3agSGNWNwfk8gAKshYt210QaaCQEFwh+t1k7J/BkA
 KhOCG3dFGOBqmaDsEFhKJeXtYvPSEcH80/aauuFOeEa6xmvhUDMDX0Pa+Xo+ryEMsim4
 /Er1dhVwD6GZ9Y/hllRe/efYudMx2eE955oEtISk0GG2i4pnpfEhvGM1hm/G3H6hDotu
 tLxw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771868526; x=1772473326; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aIayxqNX4lcDhsNZVVKmIgwO5SWy86V/FKs9O41znUQ=;
 b=KZgtp7Sd6FZzsDF1bP4SLnKecQxeU1Cb6wty4hMIZZkK2B2rQgClET7q9CTjYzbyzU
 hZmF8QiY1Gp47YZ8wkCvzYNwRX9LDrjfvlUuC0YUHTnIOeKg/H9Pcv/A3rGsIWH8EoHW
 MlzxRtzG4j9hDoyLLdYjM+QtXysNSwd2E1erU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771868526; x=1772473326;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aIayxqNX4lcDhsNZVVKmIgwO5SWy86V/FKs9O41znUQ=;
 b=Yn2jizqyHOqEM0LKr2pSObF8hJ1d9YS3CFyvp9tMNVhYfxgcJqCpic4LyGoJoVNH1U
 k+RUJUGLdrpdJUmUbzfQBLHPH1FnumnvE8OI3t1/keACACpHPEFpUMAm4hxGwxF6yn8e
 sK2IbY/QbKY01dEH1MFF78lnVthWJbxqliyfqllQjVYg1PrwWwcenbApd3BLpvt5A4Ky
 2vnqqLoLZFQc+aGgHICRkjGN2VdZd/xccVL/np3Zgc1Sf1KyHAXxkiWDDr5jsC8aNLJD
 UJhlBEkhC0PUouMBQVEehUzvJVPD/fx6z43jbEKTT7bfJ0SNOgp7jqxJ+u99xsIKzGrw
 TMxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcDUSKHBocokTG+EtZhNs3O22KH/DFTE/+FhgbqFmbvsLS5GVLSmvyK7KVmrUJfbQQpPSE1/E=@lists.denx.de
X-Gm-Message-State: AOJu0YwKPvtMNQEbgMoZaNyDnezjc0JHlIsFxDM/FwhBN0GGfI8X27Pz
 PvQit9jr0fUnXa5iT3UhzeYDs2OgrthX/jC8FVpYTpa/V2fboEM7oa4M8cCiLEDmEXCoSPdstnE
 PcVn9K3uxhykyDJKBtp2LXD6TFAwui5jn7JfFOGFi
X-Gm-Gg: ATEYQzy2aJjdUseSg8rFXtAgH6hcq+3uH8d2trQYkNinVz2IppbNkNBu2E3ow7qtv+J
 zSn9433kSr8A5MossILN6z0hMs6GgbpirJX2HU0H9cxX5BpW47eTSWCD/WpuO0QEfoODDsFGMKE
 HLXPaE/X3rPebWKLZGpS9el6zPB0qoHvP1YS/7QhjEG/gKYK8h8oQQH0ZE06ARIstBuehhkHZ3g
 ibLcoKOVQwNZTLmyFCsfUdUa3WCJ8O6JiIMiR30opwOHrWs7l+dA0TUVAAV/2KPzJ37SW7lhEyg
 b4rEUw==
X-Received: by 2002:a05:6402:1e90:b0:65b:ffe3:c588 with SMTP id
 4fb4d7f45d1cf-65ea4e76080mr5412126a12.7.1771868526012; Mon, 23 Feb 2026
 09:42:06 -0800 (PST)
MIME-Version: 1.0
References: <20260219003351.388722-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTj42WZF3DTOt4HxskNW3qyZJ5_pQ66RsBNdbr13rXTFeg@mail.gmail.com>
 <2acea5e6-5760-40b3-b8e7-952fc355e621@mailbox.org>
In-Reply-To: <2acea5e6-5760-40b3-b8e7-952fc355e621@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Feb 2026 10:41:53 -0700
X-Gm-Features: AaiRm51NbH7Uf20BeipTeT8V_2YVCRaxMToFCAZTJLsam8ry-t3qJFq9I6NswCM
Message-ID: <CAFLszTjRjpFRxxQJt2hNXzuMn9O3Kgcwrh10XpAMXqczK146NQ@mail.gmail.com>
Subject: Re: [PATCH v2] gunzip: Implement chunked decompression
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Alexander Graf <agraf@csgraf.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Tom Rini <trini@konsulko.com>, Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
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

Hi Marek,

On Sun, 22 Feb 2026 at 20:12, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 2/19/26 2:09 PM, Simon Glass wrote:
>
> Hello Simon,
>
> >> +       /*
> >> +        * Allow runtime configuration of decompression chunk on
> >> +        * sandbox to better cover the chunked decompression
> >> +        * functionality without having to use > 4 GiB files.
> >> +        */
> >> +       const ulong minchunk = 0x400;
> >> +       const ulong maxchunk = SZ_4G - minchunk;
> >> +       const ulong chunk =
> >> +               CONFIG_IS_ENABLED(SANDBOX,
> >> +                                 (clamp(env_get_ulong("gzwrite_chunk", 10, maxchunk),
> >> +                                        minchunk, maxchunk)),
> >> +                                 (maxchunk));
> >>
> >
> > As you mentioned in the last version, there is a compression test in
> > compression.c - could you add a version of this function that takes
> > maxchunk as an argument and call it from that test? Reading an
> > environment variable to avoid passing a parameter seems pretty odd to
> > me :-)
> Do we not want to test the command line interface ?

Yes it is a good idea to test it, although we don't need to
exhaustively test each compression case. I suggest using the dedicated
compression/decompression tests to check detailed features, with the
cmdline tests just checking for basic functionality.

Regards,
Simon
