Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870F8C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 13:01:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23BF387091;
	Mon, 13 Nov 2023 14:01:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bl6HBiNh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F7F78708B; Mon, 13 Nov 2023 14:01:13 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A187F8709A
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 14:01:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9be02fcf268so664829066b.3
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 05:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699880470; x=1700485270; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uaYqtWMUgwYjEvQp7rhc0fj7ws2OmpxDbB8REDZ+Hdw=;
 b=Bl6HBiNhrdctUtXab3MYhzoIcirtFOkD+ZzUqScVUXqkpzyRbX0WGqmpQfoYrf6EWm
 TmYc3CsvZcd7z1TvC8P0sDaoi2/cC/uyxl0W4FGu9GPzPo+UeHPyfCGcl/Raekl2Unjb
 P/kwGEA244DkVYigsJiP3/UTfODvdglbUZxx7sNVueN7mSxScow+BNdogBsepYpcl2gC
 Ds50XN+PTlfscKmI3FDQB2T4uOu6jKweIGQoPBxFvY4S/CR2Xd3b7xpcYNFzDsx2HBcB
 bj/2DucaXN02XQq7afNvxxfbzBjOiHwDrry18VPYC12LIlclS7OK8uFjtvi607gafv4i
 fMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699880470; x=1700485270;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uaYqtWMUgwYjEvQp7rhc0fj7ws2OmpxDbB8REDZ+Hdw=;
 b=WU5qThyyw3VmtoIplAtFso46i0AwS68dtblnBQvVzcg9mr4gPX6q3Qmowj8Uhx2iYi
 TrkZrLTneobNAgfs6NFk+Ti228Fv+p2V7ryXV1UjXwojUu55p7HlYB+dQXwofiMUgXsc
 by502NjesG1MFQ3qukExL9BFHP8j8Bg9hwZuMR6R94ke6SS592nmLVjC3XpTsv3Ig+y8
 SK/r3sf+JG54LPbZeoqS1Zt27M+sKb6x7iVAV+K/v9rHNOmterTfvSu+H5pJkFJ+Xpj+
 laVCGw3K8GrtE8croSQHZhKNNsoyzhizSM18GHl+qjr6OssS2xS5i/qtWj5JpSf4KGPF
 dkjg==
X-Gm-Message-State: AOJu0Yz1JSBhQpJwZRdLA1V4GUENlKlEM1ILIbzEV0HGtQmulyWcUvnN
 INf1mIe63fq/oCF/f+Y0ohfHepPiOjLsmlnzi2g=
X-Google-Smtp-Source: AGHT+IG7T39z5lFn12ZntpVnBQ42yU5AZqFnwHYS1dfiqHVIJhRrMwobgrzUY2tX/ci1iQxGtjS12ZO3tNGHOCP/eQw=
X-Received: by 2002:a17:906:26cb:b0:9d4:2042:775b with SMTP id
 u11-20020a17090626cb00b009d42042775bmr5025237ejc.30.1699880469800; Mon, 13
 Nov 2023 05:01:09 -0800 (PST)
MIME-Version: 1.0
References: <20231002011450.462468-1-sjg@chromium.org>
 <20231002011450.462468-5-sjg@chromium.org>
 <CAEUhbmWi9phnvS1U=z1O+8t7kK5mV=JLw8=YJ4A_u3tcrPSXGw@mail.gmail.com>
 <CAPnjgZ1CsWJa2Ta8fgbGmXZsvpg_BMFDRJmjqPqu6d+7z-TXxg@mail.gmail.com>
 <CAEUhbmUD9E+DkA4jq1tLMSi2ZmBLmOnB8x7jU74fL=J3YYNk-A@mail.gmail.com>
 <20231106153631.GI496310@bill-the-cat>
 <CAPnjgZ1Zp0kjW4zUunopGrUEhbWAtkZ3xwuHYxgo50K9GdFtSA@mail.gmail.com>
In-Reply-To: <CAPnjgZ1Zp0kjW4zUunopGrUEhbWAtkZ3xwuHYxgo50K9GdFtSA@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 13 Nov 2023 21:01:02 +0800
Message-ID: <CAEUhbmUvfD5AOouDXivzrzMQFgirgicsJwBJKW_zMOPL+k7PMw@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] x86: Enable SSE in 64-bit mode
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Nov 13, 2023 at 4:02=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Bin,
>
> On Mon, 6 Nov 2023 at 08:36, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Nov 06, 2023 at 06:26:15PM +0800, Bin Meng wrote:
> > > + Tom,
> > >
> > > Hi Simon,
> > >
> > > On Mon, Nov 6, 2023 at 12:29=E2=80=AFAM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi Bin,
> > > >
> > > > On Sun, 5 Nov 2023 at 14:05, Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Mon, Oct 2, 2023 at 9:15=E2=80=AFAM Simon Glass <sjg@chromium.=
org> wrote:
> > > > > >
> > > > > > This is needed to support Truetype fonts. In any case, the comp=
iler
> > > > > > expects SSE to be available in 64-bit mode. Enable it.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> > > > > > ---
> > > > > >
> > > > > > (no changes since v1)
> > > > > >
> > > > > >  arch/x86/config.mk        |  1 -
> > > > > >  arch/x86/cpu/x86_64/cpu.c | 11 +++++++++++
> > > > > >  2 files changed, 11 insertions(+), 1 deletion(-)
> > > > > >
> > > > >
> > > > > I didn't suggest we enable SSE for x86. This is the wrong approac=
h.
> > > > >
> > > > > We should rewrite the Truetype support codes to avoid using float=
/double types.
> > > > >
> > > > > This way the Truetype codes can be used on any other architecture=
s
> > > > > without the need for the compiler to emit explicit floating
> > > > > instructions.
> > > >
> > > > I am not aware of any such library. At present, enabling truetype o=
n
> > > > coreboot64 causes a hang.
> > > >
> > >
> > > If that's the case, we will have to either:
> > >
> > > - Switch all U-Boot builds' to use software float (e.g. -msoft-float)
> > > which unfortunately depends on the compiler runtime intrinsics.
> > > - Introduce a Kconfig option for hard float enabling and let each
> > > architecture to decide whether it implements it or not, and update
> > > Truetype to depend on the hard float.
> >
> > We generally do -msoft-float already, so introducing that for x86, and
> > some Kconfig logic to ensure that no one else steps on this particular
> > bug sounds reasonable.
>
> Yes soft float seems to be not-much-used on x86. For 64-bit chips the
> compiler seems to assume that hardfp is available.

We have compiler flags to ensure the compiler does not generate SSE
instructions. Yes, I know SSE is in almost every x86 processor we see
nowadays.

>
> So perhaps the best thing is to introduce a HARDFP option to x86 only.

This option should be global as some other arches also don't have
hardware fp, like RISC-V whose fp extension is optional.

Regards,
Bin
