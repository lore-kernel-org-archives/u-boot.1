Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EB9C43458
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 02:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 718BE84AC3;
	Sat, 11 Jul 2026 04:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B+5W4WAL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6C7E84AD9; Sat, 11 Jul 2026 03:06:21 +0200 (CEST)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ECC284AC3
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 03:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-5bfc5b77c02so77335e0c.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 18:06:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783731978; cv=none;
 d=google.com; s=arc-20260327;
 b=P1RqVM5Y39s8goc3YVLDLmSyUr7eWt5zA6uakwAHUHAJbS5e0MMj7gzl5K5LtVCSPt
 gMvD3j+UblRrJ4YDJTa2iUcokCLS2Gayi6Umo8vzpxtuUBZZFPdgt0wJPawBjWJGgcJe
 pVoBwJPhhs1B7p1xi8Iqs6ACM+hAImbsvEYfxN9QTbm/c2TL1Cku1pxTBISyAKX7/phW
 3hrulL8cAznXui6+5NMTKkqzjGsFCkTgwwrwgPOnO0dYK1CNQdeY/xtheLLS6gBAmNbX
 JRiiujGR1y2EccOF76l5CyC0xbnJklcC1hX82Fz81hg5MNyMz9RMHvJcwu8Z/Atoe0vP
 AHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BhmbDecceuYBK3PVPocYVRxnYLVZjSjm2QL2mhkXsuE=;
 fh=ZCWhH2JLpVPu/XyBFkIWo50SGo1bf+GllOzJv1hfwlk=;
 b=gByYQKnyfKbsuBWzzv2imnWNKyIAQPBixYqlXuEPg9J+5tXHQvafNkKnpf/ARt0g4V
 QtAY8lCUSadNw9jTyIg1IfoDU+SZkGEvLXYmpRthBBIpzi1vzGyS6WOR6DhTZ+36s/BU
 RK5HhThe20HveyXL+tGI5qN/kQ0iHvTokHAlieEnjVtSvDZR+tdtlCwJd+xRnLVAO+fv
 Bpzf7ALXEib07xUboKTlDNFxz6qnxSub9q07e40lblFECJD/eh/r5gUAv/oxrUHSaade
 jTgGlkIoyxNKpwaMOcFHejesm7fHX07cMaY+45oU7cigoTzaeEibJvWxwcWQ1n7+Ttbo
 bI6w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783731978; x=1784336778; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BhmbDecceuYBK3PVPocYVRxnYLVZjSjm2QL2mhkXsuE=;
 b=B+5W4WALn4I3WXiJyFcciaFdLfVPiXUSXrkAp0Solh5lksbNc1t7VPJz2I2To0Ajk6
 xsuSxL8Jer3nv0Rbh5oz10i+74BqvxcvVfOccSutfi9LyLPKyQ6YQMMJEYInbIBh5JTs
 TCIaxJJ9bAM0ZIjI7Jf1JcMMpz2MLgZva5+eQRnYbPmC4sSXDQPE4IoVXxD7TDyWCcAR
 lRcQAosJfxqmkcGZdL8NDEUYIAHwYlvWDH6YwHdf8obxzqLB/B52LxFo6JoprMd2214v
 7UJJL2Ml4z7TTW7FHWLFRD88CiW9RARHlWkn6g+ukSIUvmHayIeNrBIkgteiWwdyCiUA
 ptfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783731978; x=1784336778;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BhmbDecceuYBK3PVPocYVRxnYLVZjSjm2QL2mhkXsuE=;
 b=GrCxA5f3cbA/SiIdeCkN5Yqs9w1uTPSyyBW7Ai3jH1xtmgzx4tk+MXQ4YwRWPt/0Of
 lamSjP88cnJxoXMBnwXcivIBEjflaCCKtmX/XGl8ACENWXmmSPZKH/JdWHagqUy8TiWH
 8Pp0OoBI2aGBn7JUSZF1jPD0vmIqagEBgAXa2b+ZXwUo6l0DjzAKoQ0zYJK++V89cnMr
 iz/3Zchdu1b5yFrejnFbdgQleUHdT/k188gSLUmYs7tjNfM59OG24NgNpOsM3y4ry+nk
 BJtG8JE8QJzt411jalw6h2VjI3jlT1rDAzfOevhoxbNzRXCyZf/doZ4Lpmy3mGzAKwU7
 vzcw==
X-Gm-Message-State: AOJu0Yybf3ow1OigDPANucYlm2v4Rl9H3hBlAEFfPv5fjGSk4UrRBtxc
 FRx70EwoGKE+Zov43W73O81QBoGFIIpWjgIk/TVQbCHoo/KUxFgNclE7dNe9bq9MeY66ZalRlLJ
 HEROfb1cFZZpBYwWkPOwEPnWj3h5zf5k=
X-Gm-Gg: AfdE7cnGxHOcbitiNtOil15O1bQ921LMM/v976lzTivAbO7jez3wnpyN1J1am87RpHu
 HpogrPNaj/MnGV2VIK/1ZdARSULdyTZ4RIWrbxG5RDLAoMaYX0kOnx3oAprbpsUfwr6DrMZ2bBW
 1BGPMVO3NHydMZk7QpKFZNK/yRFIz15mV+SVWGu9NO3LpvxcLyI7ORW4va5dUlNifgJQsshZAQ9
 8bUIkCRseQFuK/jyIAbWL3k2YskHsvMdA6DWf4vfS15pds3IgCBubeF43SXb2Bzb70LIG3ecT7Q
 FTezTRDspPIqtbN5n0XYyo6LfAfbhAAVOeoZh4RpuiYXBA1bGvUIQTz6iHXN5zxFr/b/SJak3fM
 Url6kFKViZb+V+0ZoPqKbow==
X-Received: by 2002:a05:6102:5a95:b0:740:2654:b49b with SMTP id
 ada2fe7eead31-74533e19c11mr947379137.21.1783731978066; Fri, 10 Jul 2026
 18:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260709-submit-ce-series-v2-v3-0-5017da8c9bef@gmail.com>
 <eefb2d2b-1f2e-451e-a20a-093964e9e138@arm.com>
In-Reply-To: <eefb2d2b-1f2e-451e-a20a-093964e9e138@arm.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 10 Jul 2026 19:06:06 -0600
X-Gm-Features: AUfX_mwzTlzkrdx981A6-4qYp0z50tbMUmEN_6HTrxqHaIj8zqccz5K6Si_PMok
Message-ID: <CADvTj4oFVuSP0SarXO_80=22Us6DkKJ_VGfNi0WVg8PBuZbbYA@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] crypto: allwinner: enable sun8i-ce FIT crypto
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Svyatoslav Ryhel <clamor95@gmail.com>,
 Ion Agorria <ion@agorria.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Randolph Sapp <rs@ti.com>, Heiko Schocher <hs@nabladev.com>,
 Alexey Charkov <alchark@gmail.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, Michael Walle <mwalle@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Lukasz Majewski <lukma@denx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, E Shattow <e@freeshell.de>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Lucas Dietrich <ld.adecy@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Thierry Reding <treding@nvidia.com>, 
 Francois Berder <fberder@outlook.fr>, Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 11 Jul 2026 04:28:37 +0200
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

On Fri, Jul 10, 2026 at 4:05=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> Hi James,
>
> On 7/10/26 00:46, James Hilliard wrote:
> > This series enables Allwinner Crypto Engine backed FIT decryption and
> > FIT signature/hash validation for secure-boot flows on H6/H616-class
> > boards, covering both SPL and U-Boot proper.
> >
> > The purpose is to use CE-backed AES for encrypted FIT payloads on H6/H6=
16
> > and CE-backed ECDSA validation where the CE ECC engine is available,
> > currently H616, instead of relying only on software crypto paths.
>
> May I ask: why? In general those proprietary vendor crypto offload
> engines are somewhat frowned upon, and especially in the Allwinner case
> I am not even sure if someone has tried to validate the hardware.

Validate the hardware in what sense? While developing this I've
validated the various crypto operations against the expected outputs
and everything seems fine.

> So what is wrong with using a reviewable (and reviewed) and tested
> software implementation? Do you have data that shows any advantage here?

I did some more benchmarking and optimization of the aes decryption
operations and managed to get it over 4 times faster than this v3
implementation.

The CE aes decryption after my latest round of optimizations is well
over 100x faster than the existing uboot software aes implementation.

Here's a few benchmarks I did with a 64 MiB in-place AES-256-CBC
Buffer Decryption:
U-Boot's existing AES C software implementation: 3.72 MiB/s
OpenSSL Generic in Linux userspace: 24.18 MiB/s
OpenSSL NEON instructions in Linux userspace: 34.98 MiB/s
OpenSSL ARMv8 AES instructions in Linux userspace: 533.60 MiB/s
Optimized dual channel CE AES implementation in U-Boot: 568.0 MiB/s

> Just from a high level point of view: the CE uses uncached DMA
> operations, and runs at 24 MHz, if I see this correctly.

The manual documents it as running at 300MHz for the h616, there's
actually a bug in my v3 implementation that was only clocking it to
150MHz, fixing that bug doubled the speed roughly.

> I am pretty
> sure the AES instructions in the Cortex-A53 beat this easily, I guess
> even a NEON-optimised pure software implementation would be faster.

I managed to beat both, so I don't think that's the case.

> So what I see here is just a lot of code added, but with little (read:
> no) improvement.
> In the BROM the rationale is a bit different, so I see why it uses the
> CE there, but IIRC there is even a chicken bit in the fuses to not use
> the CE, so they might even have a software fallback?

Well performance wise at least a CE AES decryption operation does
seem to beat even OpenSSL's AES instruction optimized
implementation by a measurable margin.

The chicken-bit fuse documented in the wiki doesn't appear
to be present in the h616 SBROM at all from my analysis.

If you look at the h616 cryptoengine block diagram in the manual you'll
notice it actually has 4 CE channels that can operate in parallel. For
the AES-256 CBC decryption case I noticed we can use two channels
(Symm/Raes) simultaneously which yielded a ~2x performance increase
compared to single channel AES decryption.

My v4(not sent yet) which is what the above benchmarks were against
will be over 4x faster than my v3 for AES decryption due to this dual
channel decryption optimization and the CE clock frequency fix.

Since the CE Hash channel can operate in parallel with the two AES
decryption channels we should also in theory be able to hash and
decrypt a FIT image item in a single pass, although this may require
some refactoring.

The Asymm CE channel can probably also be fed the signature
for validation while the other 3 engines decrypt/hash the FIT
image item buffer in theory.

I still need to compare the ecdsa and hash performance but I'm
thinking it's likely those can also beat even an optimized software
implementation.
