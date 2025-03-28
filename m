Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710EEC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 14:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4AAD81273;
	Fri, 28 Mar 2025 15:38:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uYTkcFOJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 801C981273; Fri, 28 Mar 2025 15:38:56 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB744805C8
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 15:38:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ff797f8f1bso3547881a91.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743172732; x=1743777532; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vjXXFuYYTPmJDUbt7le0uxBKXlMs3TMFZjbXsLpErY0=;
 b=uYTkcFOJyZts06S900SRM1rGTwrX/jPtUTkrd+7f5Pm2K5u1ELiydk3m58Np/pTpCc
 Mgwf9yXfzC8Kyp1yaz5cLUW7f7TlMNN3pNvpMjSGW8HmeErwgp0p9Z9m/J0TLTmoAl49
 ohkaeYpaMVBVAzvwsPoKqp2SkTvS/vCIDqQ/V+vvDl8TN7sE/ErYjMLFvZ+wVq7X4xLo
 OPzlht1PTF0PTGx/pwEY7JUUa9vvtdLnhxE2I7GrwasK69k9r+Fa+7Fjy9QFlSXC3zk/
 T7Crslu17eyiMK1jtRx3ldbz6RX6DAbhKE2CLKhv2Xya0osMnPWhQs4JqkCQR6gHXfgN
 nb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743172732; x=1743777532;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vjXXFuYYTPmJDUbt7le0uxBKXlMs3TMFZjbXsLpErY0=;
 b=fZ/L7IUQYBlSzY8z+Xx+HotPa7emQ0bJMDC3APxEnl4G8L+m2XCSn2HLQTo1i02ejB
 5fLLRf0Dh8RrWuMG82mrBArf15T2ws5qUTy8z8jE1nb4gs3BSglU0mybDjvorkjK9n1/
 u8DioPBEp1WNd0BQAJpqyoe6zTLERHdOTRj4xXylYgOz4y5+QW8RYtoRl8DoAeCp/Jkv
 ic8+nlb1QvcqrvpMPZroS6MEGFnr0Na7d7G5P5OGMWYropGqMpqzPVWttke8JrKO0GtQ
 wvgGR9vh86iel+LL1JeF2bgk5yh+ZuoB48tP/4eWZ3jDPAZo3ehiUvIGTU5CrrvMzjiS
 WPLA==
X-Gm-Message-State: AOJu0Yyysg4kE95BVWYzbs+awPpBQg7826veKc/nsTrDir2uJ+i06zRi
 MV2/W4yf55/ucJHedGHKOoVqz0WnrvvTr5LLX0sZfYiju36/rRJbCgqVK1fxUYQSBc7SuGwfmmg
 rpWG/8c84cVYKMcVrwENbVPDQUk8YqkTl0eprHQ==
X-Gm-Gg: ASbGncvcs8PJQCUUS8eDvilLzakS2Ue3ivg/Lm5fTzXwxoNZhr5Gfl9F0UsuWhALMfe
 ts7/r/iqzIaIxWdRdae1xGEOPz95sszMiMuIhuXUR4G5CESHg/qtCkyYbtzDtrZhERlU8pFVdY+
 gGfrhzeBAOCeDIj3jgXOULKnT5+/PR
X-Google-Smtp-Source: AGHT+IEddxE08rnWiIoy34MePedHLz7lfk/rV6nsQ0T2HFrPtfMc+aiBZedNNpKkh87ZpratMv5EtgOWVwPGdyq22/w=
X-Received: by 2002:a17:90a:c88c:b0:2ff:58c7:a71f with SMTP id
 98e67ed59e1d1-303a9071c3dmr10164450a91.32.1743172732299; Fri, 28 Mar 2025
 07:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250327231318.2713201-1-raymond.mao@linaro.org>
 <CAFLszTjpbxH6_LEuv5mAyOjt812hXvTKL1nDpP42HMJXwMryWA@mail.gmail.com>
 <CAEfUkU+tYjjNQAmwv2=FWkPYxLZriAd3FdAVQQrdt7PTXK_xiQ@mail.gmail.com>
 <CAFLszTiwNM3=ZgFRU+rJN=nmQ9YuS8gkUf_jRNqhSJpuELi09g@mail.gmail.com>
In-Reply-To: <CAFLszTiwNM3=ZgFRU+rJN=nmQ9YuS8gkUf_jRNqhSJpuELi09g@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 28 Mar 2025 10:38:37 -0400
X-Gm-Features: AQ5f1JqdSIa6IZ9g0FkDwTiPEq6uOr_ndCktHGG4zhS72O70CLwQVRiI-K5wep8
Message-ID: <CAEfUkU+6O7z_FxuopJ0R8AnqXFPT5jThKn8AkDHLJqrUEi5g4w@mail.gmail.com>
Subject: Re: [PATCH 1/2] bloblist: fix the overriding of fdt from bloblist
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Tom Rini <trini@konsulko.com>, Ravi Minnikanti <rminnikanti@marvell.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthias Brugger <mbrugger@suse.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Simon,

On Fri, 28 Mar 2025 at 10:26, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Raymond,
>
> On Fri, 28 Mar 2025 at 08:17, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Fri, 28 Mar 2025 at 07:34, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Raymond,
> > >
> > > On Thu, 27 Mar 2025 at 17:13, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > >
> > > > When a bloblist is valid and contains fdt, it explicitly means
> > > > a previous boot stage is passing transfer list compliant with
> > > > Firmware Handoff specification, thus the fdt from bloblist should
> > > > not be overridden with the ones from board or env variables.
> > >
> > > Why is that? The board can choose to override it, if it wishes, but in
> > > general, if gd->fdt_blob is already set up, it should return -EEXIST
> > > from board_fdt_blob_setup().
> > >
> > First, if a board is running in a "stand-alone" mode, there should not
> > be a transfer list passed from the previous boot stage.
> > Secondly, overriding the transfer list with the env variables does not
> > make sense, since booti, bootm and bootefi are actually using the env
> > variables to get the fdt when launching to the kernel.
> > We need to do the opposite way - override the env variable with the
> > one pointing to the bloblist fdt (See my patch [2/2]), then all boot
> > commands can work with the transfer list.
>
> OK, but now we are going back to the OF_BLOBLIST thing that I did 18
> months ago and ended up being the major reason I had to create my own
> U-Boot tree just to get my boards working.
>
> Anyway, Tom has agreed to let me maintain bloblist (and maybe fdt?)
> again, so I am going to send a series to 'clean this up' as Ilias
> would say. Let's see if that passes muster, because I do agree with
> you that if the devicetree is in the bloblist, it should be
> definitive.
>
> Re your second point, do you know why we have fdt_addr? Is it just for
> the distro scripts? I'm wondering if we could restrict the use of
> fdt_addr to just the places that actually need to use environment
> variables.
>

I understand that there is a clean-up plan from you, so this time I am
just trying to minimize the changes (as you can see, just a few lines)
to make the transfer list work again.
I am also working on the OP-TEE repo project to enable qemu v8 build
with transfer list enabled, so users can just use a single command to
test the Firmware Handoff feature from TF-A to kernel.
But since 70fe23859437, it is broken in U-Boot due to the overriding
of the fdt, I made this hotfix in order to let us have the feature
work again before the upcoming release.

Regards,
Raymond


> Regards,
> SImon
