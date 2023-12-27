Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6DCC46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 15:52:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E88D878FA;
	Wed, 27 Dec 2023 16:52:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VPO+Z3B4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A20187956; Wed, 27 Dec 2023 16:52:07 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FE218744F
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 16:52:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6d9af1f12d5so2220616b3a.3
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 07:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703692323; x=1704297123; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h96ASafKryqnmFrCMvI18jBslhr8eEPrROgjSys/qV0=;
 b=VPO+Z3B40UwKz8/R7NdVAlirholT6Oq4fGws9mQ5W2BQnJX1yfcfW179VAhZb40+xd
 kQ3iMNwYRTK7U7+9jebQnHUhHWEPo/XmEEDHPcWu9013+Soj7jjPSKw2vL2C+Aepvbyt
 JLqTHJbaWL/VoHQoTQNesQoaLf+2X9fKHCnW1/efpT6iQaIiBiTzP06xiDNF8xkHP3yX
 e1saaVDDmKjYXxieHRl8ooCCmhJRwgcvmKcxeOyHyYqU80zKCMoaEYsJGtfHSSklDeqB
 URLchPKrVcPTaZET1o7FGSYrIGlVjrOVCo2F6yDqGV64iICEBPHxQ0PDeBqZjumPiXr2
 3JCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703692323; x=1704297123;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h96ASafKryqnmFrCMvI18jBslhr8eEPrROgjSys/qV0=;
 b=nlBu8/6ctmSQUiaSnrWAGo6Ox1R6MlG+S8ypsfIYg1VclQpnL+DJUVq/jaggeb9c63
 lAcLV3uJk7jSXuPmxKIM5CwQ/50Zq4EcU8mtonVdDK3YbL6ppvUE/CNL+0ImBEZeBSZ+
 nJWWcBmz+TNfxrq95puNLkcwcv6em9BfBp6rO+ZAf30OZgyl7yo8RKaq4j6QrQ2XJIxD
 v+kf+nAuEuueRCrmXr04holI4Ibu3afJA8W7TSjYgNrHzFApvLS6OP/BYQwBPfTTNNfX
 XOZq7N4guvFf3Ie94bc3nxx6sx2TjkDnq3PRFXy7l8XR9uqa1PzmXFuHNlCNO4LSJ5mo
 F6HQ==
X-Gm-Message-State: AOJu0YyyStQ/elzzL0K4iNz3UQT88/nmuS2SQyWJSz5hhfTVuMGahkLX
 +uCKiig4hBWNWxHeOKV8ZaEGNaWl/Zb7pJnbd4rQCDfS4fCu2Q==
X-Google-Smtp-Source: AGHT+IEk1eYtm9E5o8bsdQzWSnQJxjmxGQCwoG74Ar2Our8LLKYNZLGclXNLtLUW2yaDjaN9HlhubiVmkkMpEf6dy+k=
X-Received: by 2002:a05:6a00:22d6:b0:6d9:b5c1:1183 with SMTP id
 f22-20020a056a0022d600b006d9b5c11183mr6288289pfj.58.1703692323238; Wed, 27
 Dec 2023 07:52:03 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-5-raymond.mao@linaro.org>
 <CAFLszTgjj2+78qixAKQ5pK4PtLRTS4ckVLAptUZnV9+zFzaQ2A@mail.gmail.com>
In-Reply-To: <CAFLszTgjj2+78qixAKQ5pK4PtLRTS4ckVLAptUZnV9+zFzaQ2A@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 27 Dec 2023 10:51:52 -0500
Message-ID: <CAEfUkUJdB7eSoQRn2q3_6LwibkDZVM0oeU5nC2HbYMx74=M0_Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] arm: armv7: save boot arguments
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Qu Wenruo <wqu@suse.com>, 
 Sean Anderson <sean.anderson@seco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Simon,

On Tue, 26 Dec 2023 at 04:48, Simon Glass <sjg@chromium.org> wrote:

> Hi Raymond,
>
> On Fri, Dec 22, 2023 at 9:31=E2=80=AFPM Raymond Mao <raymond.mao@linaro.o=
rg>
> wrote:
> >
> > Save boot arguments r[0-3] into an array for handover of bloblist from
> > previous boot stage.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - New patch file created for v2.
> > Changes in v3
> > - Swap value of r0 with r2.
> >
> >  arch/arm/cpu/armv7/start.S | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
> > index 69e281b086..2ca63ca32c 100644
> > --- a/arch/arm/cpu/armv7/start.S
> > +++ b/arch/arm/cpu/armv7/start.S
> > @@ -152,9 +152,22 @@ ENDPROC(c_runtime_cpu_setup)
> >   *
> >
>  ************************************************************************=
*/
> >  WEAK(save_boot_params)
> > +#if (IS_ENABLED(CONFIG_OF_BOARD) && IS_ENABLED(CONFIG_BLOBLIST))
> > +       ldr r12, =3Dsaved_args
> > +       /* Intentionally swapping r0 with r2 */
> > +       stm r12, {r2, r1, r0, r3}
>
> I thought the instruction was a bitmap, so what does the 'swapping'
> actually change?
>
> The swapping is due to different register conventions between aarch32 and
aarch64.
Actually swapping here is to avoid the complexity of swapping this in C
code.
I will update the comments here.

[...]

Regards,
Raymond
