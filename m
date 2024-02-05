Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7FDC48295
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 13:52:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94AFF87C2F;
	Mon,  5 Feb 2024 14:51:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=northern.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=northern.tech header.i=@northern.tech header.b="WKxRoH8a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76676875E9; Mon,  5 Feb 2024 09:18:58 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6ADB876A7
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 09:18:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=northern.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ole.orhagen@northern.tech
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-51121637524so6188745e87.1
 for <u-boot@lists.denx.de>; Mon, 05 Feb 2024 00:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=northern.tech; s=google; t=1707121134; x=1707725934; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T5uASMsuYqJPfOhYVcAofMhkWstwmRZq9uvvhrkac4Y=;
 b=WKxRoH8amz3lLp+CW1SBBvrjwWupwcRZTNuwJKJL2E5Ujm5cEPsEwpyEM0yCHHVwHh
 xPJVeU+R9GpfYiJPSOw+0pM69250xIPs8IRUkt/U0P9h93uAcGlfnby3cSGmTE7XLW80
 xulk9yNytNp/3x4ICSv1ix/RCLy/ZvFr71Ki3dLruKTksL6ADBQgJZwGbHfSNHt7wgDg
 PzBdb7r0SnjymENMpKDeY169yXSQ7EsLtXtDccPATLqtxsK2VYuo1B4r/vangkRcJuAK
 aSt8EMQvv+uQq3ie0Tm9XJMDSegWSYirg2xE/O2XtoG3ROEcp3t6+CUF0R/2MlVKHfOR
 vcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707121134; x=1707725934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T5uASMsuYqJPfOhYVcAofMhkWstwmRZq9uvvhrkac4Y=;
 b=mp8T0JQcBzLXvl0uClZ4HMpBPt/MqE0fl3FWUZe8RATP2Vir7iKY6WEeEUjNJydYaS
 skt4CUnKhXcNAF2ofpwzcixuuYqQSAD7bKFzJV8rcWGfYz/JPiGAGQ5+kvQvISBUyqFY
 fUNku4PWJe5aIzU37J7NxqkSsMRzfmwn7A0+C0DvAkQ9wbU9cxGS9uq8dyes02CDhkvV
 hJuwivfWso6Va9qGaMCa8QKIkCsj6KAKfzqHPp0Ip+ixgiXa2Nvk/S05xaNeMLAZrorX
 7IOcrYKW5BlrOFN1AKdV3xQJNZhtFIBSNPO6F0No8yYvc4O/sffjgCQh1RVD3AruEaLg
 w1/w==
X-Gm-Message-State: AOJu0YyZIXvAHjN9fh9AHaK1DGirlc1htCmJhCdt7v4CGHYtwFoFLvQb
 o7u+vXLBlS1M2kuCzFecc21YgJDl4R84jqsvdwaptFDrb9Byd8EdIfKjCuD9a+Mx5yrKqzBWIGj
 q23EWJjqwqrfrD8V/ezszalFimIrspnqGGq/qvUgBcobrxA8W6yT03WEUkGb+Fbc34Q3/RrQplD
 P0nsUIwamVnFBf29w=
X-Google-Smtp-Source: AGHT+IFOntGaFU6LMxoswTkD/uFmr7VlKqBXES/Hlg1U3TzlzrMkiwneGF8rJEU31ap06VvTBP79j/DRFCSmtUzh7VU=
X-Received: by 2002:ac2:597a:0:b0:511:4fae:ff9 with SMTP id
 h26-20020ac2597a000000b005114fae0ff9mr1317645lfp.39.1707121133931; Mon, 05
 Feb 2024 00:18:53 -0800 (PST)
MIME-Version: 1.0
References: <20240126124801.1164892-1-ole.orhagen@northern.tech>
 <CACRpkdYLizF9Duy3ZCfqRsY-NMoLZJO8+TCyBHbQDqSOWuzonQ@mail.gmail.com>
 <CAD5A3Cuba_EchhDWBfej5HGHsP-T6smgL-L+C6SV_bONf6EqYA@mail.gmail.com>
 <ed02c9b9-5505-4aad-bc92-a2678607ff54@northern.tech>
 <CACRpkdaiYgmzjsX8SPMFOFo=iK19s2y8Uuaysc+46Ba7D1PFBg@mail.gmail.com>
In-Reply-To: <CACRpkdaiYgmzjsX8SPMFOFo=iK19s2y8Uuaysc+46Ba7D1PFBg@mail.gmail.com>
From: Ole Orhagen <ole.orhagen@northern.tech>
Date: Mon, 5 Feb 2024 09:18:42 +0100
Message-ID: <CAD5A3Csm_sx4TBHQaADSMFgSqoF=aBZD2jm4_cmzNaonZJqAoQ@mail.gmail.com>
Subject: Re: [PATCH v1] vexpress_ca9x4: Enable DM_SERIAL
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Kristian Amlie <kristian.amlie@northern.tech>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>, 
 Fabio Estevam <festevam@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Patryk Biel <pbiel7@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailman-Approved-At: Mon, 05 Feb 2024 14:51:45 +0100
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

On Mon, Jan 29, 2024 at 2:31=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org>
wrote:

> On Mon, Jan 29, 2024 at 12:54=E2=80=AFPM Kristian Amlie
> <kristian.amlie@northern.tech> wrote:
> > On 29/01/2024 12:41, Ole Orhagen wrote:
> > > On Fri, Jan 26, 2024 at 8:57=E2=80=AFPM Linus Walleij <
> linus.walleij@linaro.org
> > > <mailto:linus.walleij@linaro.org>> wrote:
>
> > >     Are you using the actual hardware, or QEMU?
> > >
> > >
> > > I only have QEMU available, unfortunately.
> >
> > Just providing some context, since I'm listed as maintainer: This board
> > was going to be removed some time ago, but was resurrected specifically
> > to work with QEMU. The "virt" board, at least at that time, did not
> > support some key ARM features that we need in our testing, such as SD
> > cards and Flash. Hence we opted to keep this board around. So
> > compatibility with hardware is not important to us at least, unless
> > someone else is requesting it.
>
> I actually have this hardware.
>
> Last time I tried to bring it up it had severe problems with caches,
> especially following the meltdown/spectre workarounds that start
> to really stress the cache, and probably the caches simply have to
> be disabled to make it work.
>
> But I will try to dust it off and test it again.
>

Did you get any results from the tests?


>
> Yours,
> Linus Walleij
>


--=20
*Ole P. Orhagen*
Software Engineer | Mender <https://mender.io>
Oslo, Norway
<https://www.linkedin.com/company/northern.tech>
<https://twitter.com/northerntechhq> <https://northern.tech> Northern.tech
<https://northern.tech> | Securing the world's connected devices
