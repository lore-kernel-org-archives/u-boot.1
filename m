Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F52CD6E79
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 14:48:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06DDB8495C;
	Fri,  5 Jun 2026 16:48:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="bSbV2Bat";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE0E68495E; Fri,  5 Jun 2026 16:48:20 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97DBC8495B
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 16:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-8ccedaf0b54so12291456d6.0
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 07:48:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780670897; cv=none;
 d=google.com; s=arc-20240605;
 b=QSTEWvfTE3W+2gK9leTwrBemttw+42qDyWNCA2pF5dnDl3QgEOK8MwV+T8DIBkwyFN
 pADLH373Icwt4BCU7B9JUQpJZdbBhLPyNkeivJqKa59kL8IQGFRxwyfuzcYpAhvVxTtH
 Ow31qMsyisPVCaNm95Tnm99221VcPvEcGFwMpRoVgdaGOxV1ucmoUQNJFys5T36vhxfa
 ccbwZPSpA4z/avVHyOcbq/lCdhHhh24cBqVSuCwYZL1QritS6VimOVJmHD7W7jkhnptn
 zIYp7DzPkyIXX2LAGD2mNf3yDHHv55H0SK7KAHBJrOWNt6GMpZgPbfq3nqZrjJZJssRY
 ihwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sB8mgW/wH+3ZIHJ+IJYlIN+6OYXMXk0/cKC8XLO4c+M=;
 fh=Uq/KN9Y6xjfKMH2kg5LKPJXuLRYWI5NchBvZmJBe3ZE=;
 b=UBo2C5oMCrDnoJwHyf52cYbWyiYA+MpVTJ2+T4FF4sE7B6h/5wqQc3RTmfgXlXdkt7
 AQrFh5i3lVJzm0G+ZS9LdgZ5RspA5mQ+8P6mNIh80k8BX6Owh+lkctMnA4WfqREnpAyy
 XTQCjh/AMb8wA3aQGP7G1RNI15VIuuKFTRESZy1HVA44jiyHrZqYNrfOHcfg7H8Ybw9x
 qUWDxV8+Sen9nKygJIkRuIHfpDkymJJC1A6kLniFAF2ZExOLpszr6vv7+srxdMqBIX8v
 rz6tgezr1wy+Dy7zn6OAmtJ9Q3g2/eqQjzExFVDbymBR81PX0qllKpToCp5FTq8VeCz1
 djSA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1780670897; x=1781275697; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sB8mgW/wH+3ZIHJ+IJYlIN+6OYXMXk0/cKC8XLO4c+M=;
 b=bSbV2Bat6JpktrQ7xWqrvqmiXbo934+3vyLKOm7DnC4gewmVyanafV/pb3r72PnEF6
 vgVR65R2K7pO7s23xHMusL34Dt3IAeaBu8gwdKER/Htl1msxS/I4fvU1CgezkgznjaME
 Ud3t62noIRIm0U9ba6Lo0Av/76TeBMHuxRr9ML6o4fxDcZIgkeQ9AqZjcd/IzWL2nunb
 hkrYVoYjQrpkNlI1/yTgHx9ztKkNuEI2OUl4VIAVy5Wg5lFmlT/D8z98J05xrq5ZqXG0
 lt5oGpeojBSNq1JkmpOe1o6AjL8vmytXnzaMmylf5Q3JrF/Nfzg6yyj3E6T+o2xEjutt
 z4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780670897; x=1781275697;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sB8mgW/wH+3ZIHJ+IJYlIN+6OYXMXk0/cKC8XLO4c+M=;
 b=S1nNdoJlLfRbxawScPFbroXYSoJuyRtInAs4LRhzl/j3Q9uYEa3ENMRxARxn61uwcc
 pZ6auKvCXGVlFngW3VfrDvOT78tv4DlqGj5JFZLS9OF4XRjzht+DaSLcjrwz2iFcr3+U
 NB71dqLkE/UDCzQDyVAVjtC9OWTkouox7a4dTCC11RbZ29vUKisMev/1o0xw4TrUSCdp
 HqPegcWdl0cKNPMubfAeKsLvr7PQ44Y8JeuQjTlQAIokbAixEvy0tsOHtHrC/eRF1Tn+
 PArsElB9TWd/YcVgnwjxDCWt8lUI7SLnJxMiCjm5iTfIY5Qy5wSluhs4OlNbJgBV2dcz
 xhMw==
X-Gm-Message-State: AOJu0YyLqgjOeH8tz0hkiI/9nuEW/+b6wgSWy0Ty6drXl3wtVyQONXBa
 9+MXyg8hRJ1b222KlMERX9BR6a+H+jnCJ0jqFPyVt6+H0yA6GOj+LjuNDeuj9XHDaAw2WIkXSPf
 BKHht6iqeW47Chul4V5HTJ5AgrqsgclxgDXvH6Vh+hA==
X-Gm-Gg: Acq92OHHlEG8FZdutlrLk1izhcahrYJJTzks7SBbo/5JM/MXy7YwMkTOqK/4FZQm6by
 N5mNOXOIf9RCeFrCYMc5tP1gc3NE9LC+y+953FJRUUlFqBKBIpJyBhdECKhmkpsfHpPp17tgjrt
 +jHppHswwCkWR/HS4divCVn/Pa7GoJtn2FSQbMGNxckaQt7qFLfsUeFN+j1d1+AdIJrjhB2wwYa
 jODItX/I7H1HVlJNKDE/2DiAkH1TgpAoNIuzJgER9GHS2SRaqx3H8ok9riKkRRAmxk5Jg71JWoF
 Cjq8tIaPhNOKVQ==
X-Received: by 2002:ad4:50c5:0:b0:8ce:c19a:3f03 with SMTP id
 6a1803df08f44-8cee5f9f8a6mr54852346d6.10.1780670897328; Fri, 05 Jun 2026
 07:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260602162233.2418471-1-rmandrad@gmail.com>
 <CAMknhBFeV8qio29t1zNhoBNdumbWh2ErOE99dQEphDKZN8GodQ@mail.gmail.com>
 <003e01dcf4ec$6a507830$3ef16890$@gmail.com>
 <CAMknhBFPN8rk35ijCQK8ACM=joV-tXuX1m6sYCVEFPYegMjXxA@mail.gmail.com>
In-Reply-To: <CAMknhBFPN8rk35ijCQK8ACM=joV-tXuX1m6sYCVEFPYegMjXxA@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 5 Jun 2026 16:48:05 +0200
X-Gm-Features: AVVi8CfRcRdfoJJbYf-tTtiH4OAW0z14Wfr9-qU8-oz5MfdmjUYrHi5pI2SuX4g
Message-ID: <CAMknhBGng1iVxs7+5cWPaAyjOxBs8Dbzp3fuHhHWHbi3eJs3fw@mail.gmail.com>
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

On Fri, Jun 5, 2026 at 4:30=E2=80=AFPM David Lechner <dlechner@baylibre.com=
> wrote:
>
> On Fri, Jun 5, 2026 at 3:07=E2=80=AFPM <rmandrad@gmail.com> wrote:
> > > On Tue, Jun 2, 2026 at 6:24=E2=80=AFPM Rudy Andram <rmandrad@gmail.co=
m> wrote:
> > > >
> > > > MT7988 detects the full installed DRAM in dram_init(), but after
> > > > commit bddd6bbef3dc ("arm: mediatek: mt7988: drop
> > > > dram_init_banksize()") it fell back to the generic dram_init_banksi=
ze() implementation.
> > > >
> > > > That generic path populates bd->bi_dram[0].size with
> > > > get_effective_memsize(), which is capped by CFG_MAX_MEM_MAPPED. On
> > > > MT7988 this limits the exported DRAM bank to 3 GiB even when 8 GiB =
is
> > > > installed.
> > >
> > > Can we just remove the #define CFG_MAX_MEM_MAPPED (and the header fil=
e that contains it)? Or is it used somewhere else?
> > >
> >
> > Not the header file as   TARGET_MT7988 sets SYS_CONFIG_NAME=3D"mt7988" =
in arch/arm/mach-mediatek/Kconfig
>
> We could drop that config too since the header will be empty.
>
> >
> > In the mt7988 I don't see CFG_MAX_MEM_MAPPED used elsewhere than just i=
n common/memsize.c where it limits get_effective_memsize()
> >
> > Unsetting/removing CFG_MAX_MEM_MAPPED would take u-boot above 4gb... So=
me MediaTek ARM64 ports may keep U-Boot below 4 GiB because peripherals suc=
h as MMC need DMA buffers below 4 GiB ... so, it may work on my setup but n=
ot others. Also, not an expert on u-boot  I would suggest for others to com=
ment/review
> >
>
> What I've done on the other MediaTek platforms for now is add this to
> init.c to take care of the 4GB DMA limit.
>
> phys_size_t get_effective_memsize(void)
> {
>        /*
>         * Limit gd->ram_top not exceeding SZ_4G. Because some peripherals=
 like
>         * MMC requires DMA buffer allocated below SZ_4G.
>         */
>         return min(SZ_4G - gd->ram_base, gd->ram_size);
> }

Meh... I've just realized that this probably doesn't fix the issue as
it does basically the same thing as CFG_MAX_MEM_MAPPED. I will have to
come back to this next week when I have more time.

>
> There has been some ongoing discussion of a better way to handle this
> in general though, the last few weeks. I need to check the mailing
> list to see if any progress was made since then.
>
> If there isn't something yet, I would still propose to drop
> CFG_MAX_MEM_MAPPED and add this function so that everything is the
> same.
