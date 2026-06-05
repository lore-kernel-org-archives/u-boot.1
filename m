Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE37CD6E7D
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 15:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFA7284979;
	Fri,  5 Jun 2026 17:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="k+sl4DXs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB6508497F; Fri,  5 Jun 2026 17:00:59 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2406584971
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 17:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4854166e1efso1922037b6e.3
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 08:00:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780671655; cv=none;
 d=google.com; s=arc-20240605;
 b=UtXtPk8p+p3feSb2GAgieS/0oaQj+r0QICfeAvgQLgrepmu+dvH2QEX5LQnRIfYAsG
 xZp1hna1wNmKfCDGSLf/R2+vvfLwGPG2ZGjnNNQkDZzVJBLm0lAEA667fDyFYpRuK7G1
 nZYifvZ41eC4HxmoKaFNzVsR79QQQtTOGB3/K9wFGYIM8c2/+l6VUAjdIZHoOoctE1do
 9CO+pzc5zw+AIdM4Xu6zTYQW+DYglMBo/67+nkNjRh/jAGj9LkGeWTvg4I5X0JxCRMmZ
 ttLpxdx95g09wOgvjCkEEULLec41EaBMXumcas0G4BNynU1mtAh2ct19YDtzIERD7hIT
 eL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JSBVwWBX+Jqljyz5TxY6CPYO+vyWtDV1c0UJHvBx+yg=;
 fh=Uq/KN9Y6xjfKMH2kg5LKPJXuLRYWI5NchBvZmJBe3ZE=;
 b=BPwFzSgGJRhjVESeuHBZGLE0j2gWVxR5lPhpJgTkEjUQSCcpkM8bAHf5Z3mDebBNKv
 AwA8YR7xagEHiI0hmIwcPx7Erj+HB3Wa9+jg45hgnERjCYFZhlggw47nZQUKy2arWdS4
 CXJ6HZHLhoFLWipvKjqH7YxfwZy3yvzR7tCCQO/D8jXN9wjl/U5dzkX6bcUvQn65E2ri
 sqRdBA0kYdbUuWgVmelAbEEKn5CGMk5g+tqshZJO+NfzLcB0ovEPNHQSY/2yEwD61VqS
 jlLmS0aRBsb1bySYUvA5kxpV/6mOQsyadtVIDoc/PhC2dPLqNo1xYjeJb1VFAb51gl66
 PZ/Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1780671655; x=1781276455; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JSBVwWBX+Jqljyz5TxY6CPYO+vyWtDV1c0UJHvBx+yg=;
 b=k+sl4DXsMpLsnQHQKLnBPLPyhdrXWMVK74F6iJHpkiKSIlHurg12cVp6lc4OrEkHxI
 Ucn8EDCVO2WPhgyCfnWryftayPb4SJ08Qo9/B3zAXcqi6b6I7DaGGJypLjZn6yD3TobG
 yt94mkZgmFsQy95UOyWjIgDANquHV7Nc6V5dH3Fy8bysaVmZ6p+r3j7aOJkPN9MwCOf7
 tt1eRrNhBRWjhMdpHxldy9SCnZ4UX9CSJ+Eumg+hZyXaLyh5lN0xLzmiNw/ClqOeZ8/R
 ULwHz2XQ5mKXWt4cXgZDsQQ/7UlDFqe9KQ4cyaNTjDdnrK8rq3HdQmefM6mqRV5dj6r4
 GT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780671655; x=1781276455;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JSBVwWBX+Jqljyz5TxY6CPYO+vyWtDV1c0UJHvBx+yg=;
 b=SyAO2bzMPN6t5txgFDLrhyWigMix2KFcgu174qGSL9Ue9KIEn0yR9c/mZBo+GzNjUO
 kHpHEn6R9UkSXdkvWlFVeskwgeBOJk6B2qhWqZNkMjLtNKJLSVtycDVxTbWRIv+WzUwu
 fD+AmECGIkEpWwSIyukmRFt4Ohe8oov6aG6Mjf2XjAz6SNzhnvrD5AFO+t4KRgp5MCvt
 MjlxhRBa/DhZm1aYXw1LL2QAQgFheri+zVvV8jeaDaUE+G2U9IrPVOg4pijoFctddiMS
 KTc+7t7WwWdLaObxiMj5wM6vxkKa/WKXYds5p9WZ2B+QfSacW8484/ZqTu9WaNrTt0pw
 hfpg==
X-Gm-Message-State: AOJu0Yy2RsPIjnWNnq6SF39dPWTcPg8VOsviM1fZFxRF2BVK4tmUELLq
 YcNxmqGpm1DdVIXpBfSS7IIshoS+F5Rb4JsRK1Dj+f9uDnZ+yeeKdmfpl+at+Pbl3BqOAkRv+k8
 Ug5aGG6B+TPvKnOfWHvFK0HY8IteivpXLOSt6xT4gmw==
X-Gm-Gg: Acq92OEyxlsEzHLPQBcA0mkQYlj0qcQC2Bp8vqIYtGqgS5V1WJjF7vXYWMJprxvVWRm
 HOjFBZCqeOQysd8DwMcs2yjTNhHPBb8c3gjIyU5ThK0w0Vgi6PmKGtsIE1Xc28YCOT25UEV84W2
 JjWIs8U290BynDPQ3M3aHgi/wA9cOeSEooOKrM88D99ACxIYT21ExmBZnf1BsRHeZOEOZVRVPjW
 MJDzDSMLUNfWdEugjkSP5mKfdT30Zy3XeSOal4IQCgkyOPN4PLvASq0ngXMlRTLluZNV/X7JmHR
 zNZShmXfhpowQw==
X-Received: by 2002:a05:6808:f86:b0:486:560d:aa84 with SMTP id
 5614622812f47-4868dd22818mr2141420b6e.16.1780671653908; Fri, 05 Jun 2026
 08:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260602162233.2418471-1-rmandrad@gmail.com>
 <CAMknhBFeV8qio29t1zNhoBNdumbWh2ErOE99dQEphDKZN8GodQ@mail.gmail.com>
 <003e01dcf4ec$6a507830$3ef16890$@gmail.com>
 <CAMknhBFPN8rk35ijCQK8ACM=joV-tXuX1m6sYCVEFPYegMjXxA@mail.gmail.com>
 <CAMknhBGng1iVxs7+5cWPaAyjOxBs8Dbzp3fuHhHWHbi3eJs3fw@mail.gmail.com>
 <000a01dcf4fb$3ba10810$b2e31830$@gmail.com>
In-Reply-To: <000a01dcf4fb$3ba10810$b2e31830$@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 5 Jun 2026 17:00:42 +0200
X-Gm-Features: AVVi8CfHGC2rY7k58IQpYJlyK4mJ63p1stHyNuEVhXtqBqZAozuVjt1H20bC8pU
Message-ID: <CAMknhBFHpn3ZQSdvNABfSqumk8PqUU6BBxSErN8fpaQ=HT29Kg@mail.gmail.com>
Subject: Re: [PATCH] arm: mediatek: mt7988: restore full DRAM bank reporting
To: rmandrad@gmail.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, ryder.lee@mediatek.com, 
 weijie.gao@mediatek.com, chunfeng.yun@mediatek.com, 
 igor.belwon@mentallysanemainliners.org, jstephan@baylibre.com, 
 GSS_MTK_Uboot_upstream@mediatek.com, emanuele.ghidoli@toradex.com
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

> On Fri, Jun 5, 2026 at 4:30=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
> >
> > On Fri, Jun 5, 2026 at 3:07=E2=80=AFPM <rmandrad@gmail.com> wrote:
> > > > On Tue, Jun 2, 2026 at 6:24=E2=80=AFPM Rudy Andram <rmandrad@gmail.=
com> wrote:
> > > > >
> > > > > MT7988 detects the full installed DRAM in dram_init(), but after
> > > > > commit bddd6bbef3dc ("arm: mediatek: mt7988: drop
> > > > > dram_init_banksize()") it fell back to the generic dram_init_bank=
size() implementation.
> > > > >
> > > > > That generic path populates bd->bi_dram[0].size with
> > > > > get_effective_memsize(), which is capped by CFG_MAX_MEM_MAPPED.
> > > > > On
> > > > > MT7988 this limits the exported DRAM bank to 3 GiB even when 8
> > > > > GiB is installed.
> > > >
> > > > Can we just remove the #define CFG_MAX_MEM_MAPPED (and the header f=
ile that contains it)? Or is it used somewhere else?
> > > >
> > >
> > > Not the header file as   TARGET_MT7988 sets SYS_CONFIG_NAME=3D"mt7988=
" in arch/arm/mach-mediatek/Kconfig
> >
> > We could drop that config too since the header will be empty.
> >
> > >
> > > In the mt7988 I don't see CFG_MAX_MEM_MAPPED used elsewhere than
> > > just in common/memsize.c where it limits get_effective_memsize()
> > >
> > > Unsetting/removing CFG_MAX_MEM_MAPPED would take u-boot above 4gb...
> > > Some MediaTek ARM64 ports may keep U-Boot below 4 GiB because
> > > peripherals such as MMC need DMA buffers below 4 GiB ... so, it may
> > > work on my setup but not others. Also, not an expert on u-boot  I
> > > would suggest for others to comment/review
> > >
> >
> > What I've done on the other MediaTek platforms for now is add this to
> > init.c to take care of the 4GB DMA limit.
> >
> > phys_size_t get_effective_memsize(void) {
> >        /*
> >         * Limit gd->ram_top not exceeding SZ_4G. Because some periphera=
ls like
> >         * MMC requires DMA buffer allocated below SZ_4G.
> >         */
> >         return min(SZ_4G - gd->ram_base, gd->ram_size); }
>
> Meh... I've just realized that this probably doesn't fix the issue as it =
does basically the same thing as CFG_MAX_MEM_MAPPED. I will have to come ba=
ck to this next week when I have more time.
>
> >
> > There has been some ongoing discussion of a better way to handle this
> > in general though, the last few weeks. I need to check the mailing
> > list to see if any progress was made since then.
> >
> > If there isn't something yet, I would still propose to drop
> > CFG_MAX_MEM_MAPPED and add this function so that everything is the
> > same.
>



On Fri, Jun 5, 2026 at 4:53=E2=80=AFPM <rmandrad@gmail.com> wrote:
>
> Was just about to reply on that... happy to drop this patch and let you w=
ork on a solution just thought to report my findings but would suggest in t=
he meantime to revert
> bddd6bbef3dc ("arm: mediatek: mt7988: drop dram_init_banksize()")

I just saw [1] that has a new config option to address the DMA address
limit and [2] that renames the config option. [1] has already been
applied to master, so perhaps we could still drop CFG_MAX_MEM_MAPPED
and use this new option instead? Otherwise, yes, I will consider the
revert.

[1]: https://lore.kernel.org/u-boot/20260603141814.12672-1-marek.vasut+rene=
sas@mailbox.org/
[2]: https://lore.kernel.org/u-boot/20260604173330.8586-1-marek.vasut+renes=
as@mailbox.org/
