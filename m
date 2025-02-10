Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CD8C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 19:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6E4D803CC;
	Mon, 10 Feb 2025 20:38:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nc4o76YY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A69028043C; Mon, 10 Feb 2025 20:38:06 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EA7E800B6
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 20:38:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d9837f201aso11310913a12.0
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 11:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739216283; x=1739821083; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qg3BObTCVWlj1QSnI7AnG8zIsLaDGGY7cbchxFF2IoQ=;
 b=nc4o76YY5MlY8nLcRqBPJlSDNmXgBf55ayFCx01gYKDIpIfORj9fEl36TxPWa/B9wp
 O+YKJkuG3dOAxSOHa9K3fAodRkM+KF2qh9q+G+yej2hCain8uJq7OMqt43Ppe9995fTh
 kU4l8CjjO2eTfE9MwQS2L7p5Ev4dSocXXhuZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739216283; x=1739821083;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qg3BObTCVWlj1QSnI7AnG8zIsLaDGGY7cbchxFF2IoQ=;
 b=QPGiFKcievX6xHQfIstCiSfzvsRZXtpAEeLDaGQR2zfhsPj0vmtvpgUvyks/Qlbw9P
 OYC/4T+qYtVHdAEqhZ4J5QYc3OlwfoDVxScvoAcJ4ulTxcPBHOq7NPAPqHOoNfj6kbcR
 DNYH+GTdaZZA08V9h0RKHUD/T1MMfEluH/Fa2MV/DLHxnk/d/2s7DQVKXqkqwGBO+juo
 Ej3lzGf5yb9C/Lh17niXPoYA3KVEKivfCpoQ9H+Z7lYH5xlWSDcCAV5vUDd/5KjAnAlU
 w1BIlLVJejpKag3YqUiCq5cOK+psmFz67uqsZrayzkZW94uQHwrc2ypfNSxd8LBYXFE/
 O2ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXK30Xt1Owf8jraCO+cPonTXB8RCYauy/+MhPTY8DzT1ZS0UvR3Rk5ttqQZfH+ICQIOzZG1Ok=@lists.denx.de
X-Gm-Message-State: AOJu0Ywl6z8MKrs66054BB83wLClGkfTaW2G70PF0KGz1HBffnT2S/Hc
 FKSf0DPqPillM/lchh9GnA6D4lHVbvJ8TEgE43QGKM0b4EP7ZYVmYFMOnzUg5xGpwCPiTJkpQV6
 sseZndnRPeOna/d1OeijFVmvxLeXanv5BKvsQ
X-Gm-Gg: ASbGncs3khlemjbfIaZI8FHzy3TLVrISje1vEVfP6hKlqdHLW7sW2BW7AUb4yZBnRS2
 Q7y9Xtc6ZK902prnOfrvgxf/tSnN/of7mPkDWKOkHQmFD8aR6ZwKUG7xDF5OAe+uwNAIlpotqMt
 YiRQq9OkYbtZ0=
X-Google-Smtp-Source: AGHT+IHKDOC/uqrWZfLO1Jfi9u6WIrF+zBeRGctoh+TxYs8crsDV24jsY9V3n40Gl5k9vQ98MwepFlElMuVu2ggvZcM=
X-Received: by 2002:a17:907:c10:b0:ab7:5983:13b5 with SMTP id
 a640c23a62f3a-ab7dafc1766mr47163066b.20.1739216283636; Mon, 10 Feb 2025
 11:38:03 -0800 (PST)
MIME-Version: 1.0
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <20241212235735.164272-7-jonas@kwiboo.se>
 <8a6bb542-aeda-4d74-bdcc-8eace71eaf62@cherry.de>
 <c3cd2190-096b-4f5d-a5cc-481cc44fa11c@kwiboo.se>
 <CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com>
 <20250209164945.GN1233568@bill-the-cat>
 <CAFLszTjFDzM18Nzacj+z7E+PaGwmF5+PcP=T2vFA=Eg1+AdpsA@mail.gmail.com>
 <20250210143504.GC1233568@bill-the-cat>
In-Reply-To: <20250210143504.GC1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 10 Feb 2025 12:37:49 -0700
X-Gm-Features: AWEUYZmbpEP74wTIJpPY3Ua-Vsx5ipE8kPtZOjgFVo0H2Kz_59xQU8xKine6avQ
Message-ID: <CAFLszThVOJikY8NqDvZFBi9n1Wgq6PtwLkuXXigO9kzk+Fqc7w@mail.gmail.com>
Subject: Re: [PATCH 06/12] rockchip: rk3399-gru: Include binman generated FIT
 in u-boot.rom image
To: Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de
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

Hi Tom,

On Mon, 10 Feb 2025 at 07:35, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Feb 09, 2025 at 01:14:29PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sun, 9 Feb 2025 at 09:49, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Feb 09, 2025 at 07:27:37AM -0700, Simon Glass wrote:
> > > > Hi Jonas,
> > > >
> > > > On Fri, 20 Dec 2024 at 09:50, Jonas Karlman <jonas@kwiboo.se> wrote:
> > > > >
> > > > > Hi Quentin and Simon,
> > > > >
> > > > > On 2024-12-13 15:30, Quentin Schulz wrote:
> > > > > > Hi Jonas,
> > > > > >
> > > > > > On 12/13/24 12:57 AM, Jonas Karlman wrote:
> > > > > >> The u-boot.rom image contain u-boot.img FIT instead of the FIT generated
> > > > > >> by binman for the u-boot-rockchip.bin image.
> > > > > >>
> > > > > >> Change to include the binman generated FIT for the u-boot.rom image.
> > > > > >>
> > > > > >> This change result in TF-A being included and the use sha256 instead of
> > > > > >> crc32 checksum in the u-boot.rom FIT.
> > > > > >>
> > > > > >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > > > > >
> > > > > > IIRC Simon was fine with removing u-boot.rom support for RK3399 when I
> > > > > > asked months (probably years?) ago, if that hasn't changed, maybe we
> > > > > > should now.
> > > > >
> > > > > Good to know and fully agree, we should try to remove it now.
> > > > >
> > > > > I did a compare between u-boot-rockchip-spi.bin and u-boot.rom and after
> > > > > this series they are now identical for the full size of
> > > > > u-boot-rockchip-spi.bin.
> > > > >
> > > > > However, the u-boot.rom also has a copy of ~u-boot.bin and a fdtmap
> > > > > starting at 0x300000. I have no idea if they are used for anything,
> > > > > if they are it is probably not for bare metal booting (TPL+SPL).
> > > >
> > > > I'm not sure about the extra u-boot.bin, but the fdtmap is so that
> > > > 'binman ls -i xxx' works.
> > > >
> > > > >
> > > > > Regards,
> > > > > Jonas
> > > > >
> > > > > >
> > > > > > Especially since the only RK3399 with CONGIG_HAS_ROM set are Bob and Kevin.
> > > > > >
> > > > > > @Simon, you said you tested the patch series on them, with which image
> > > > > > did you do that? Are you still fine with removing the u-boot.rom for RK3399?
> > > >
> > > > Yes that's fine.
> > > >
> > > > Basically all my testing is in my lab now, which you should be able to
> > > > use with gitlab.
> > >
> > > I really wish you would use the community gitlab instance and not
> > > encourage people to use your personal instance instead.
> >
> > I wish I didn't need one and anyway, that wasn't what I said. Jonas
> > has u-boot-rockchip, I believe, so should be able to push things and
> > run on my lab.
>
> I don't know why you think you need your own gitlab instance, no one
> else does.
>
> > Perhaps the problem is that it's too complicated? If you could find a
> > way to allow this change in, people could just click the button and
> > may be more likely to use it?
> >
> > .lab_template: &lab_dfn
> >   stage: sjg-lab
> >   rules:
> >     - if: $SJG_LAB == "1"
> >       when: always
> >     - if: $SJG_LAB != "1"
> >       when: manual
> >       allow_failure: true
> >   tags: [ 'lab' ]
>
> And I don't know what that's for. You can already click a button and run
> a pipeline that includes your lab.

Then please can you help Heinrich who is struggling on how to do this.

Regards,
Simon
