Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76086C55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:57:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 372B480D74;
	Thu, 30 Jul 2026 13:57:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oEmknmC4poxk; Thu, 30 Jul 2026 13:57:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 206CA80F2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785419875;
	bh=OXye1rBuTLJZBwgPImHQ8bZjxo0lobp18ZOZ0cL+t1k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yHsLgm7rqoDaMRqh4W5NKDkt+yUpMtbZ0EYi0ra2peZG6jPU9/lEUnO0NK2CluDQB
	 oKPQ16cxKS6lbXltKuoVfcFStzLLGbiPJyE0wugzdJ99pbHtrqYOKqEOgyouzFIGi6
	 50h2H6AqZYY70bF6dOIPc4GERYTQMolCXYQk9eLn6/eqB98f32V0xhbDJXkYiphAAN
	 UWw6+l8bc3Ww3x/BJMVFDiLFFF+TGJcyC4iOg/17Naomb00jjRmP/JoPUpngpc2xaW
	 n7TOg97dbHoZ6No85sySBQMx2vUBzixgBG0LlEpvyjwqvRlouLE26omZhDLCmuASFX
	 8uItCvV20j2GQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 206CA80F2B;
	Thu, 30 Jul 2026 13:57:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 74D4827C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:57:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5AEEF6085F
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:57:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ld2c6WBL-FMV for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 13:57:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1067D60896
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1067D60896
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1067D60896
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:57:51 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c1fbe461f59so9406066b.2
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:57:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785419870; cv=none;
 d=google.com; s=arc-20260327;
 b=PLXLkj2ydLbR2rMdSw6qfjnV5Vkd7rf/Au7UaoUArdI8ipWjip3izrR9Ej6w5xSXkh
 IH7/uBD7InwVi2+2hcDDRFjD1jGIgd4nMuBCMFq97k6YaV9umuVKk0lH4M4IxoLvxpiJ
 9SQCjaDsplyGBvDS7wGUBagM5H7Yny3fhYHAI+wV9tt/dYGB0Rxh0ZIWri6bwOoPCfoD
 aGc4iehFw+6IU3D++sYwEhVfhfMzqOoYyjTM5NcqCwD61lbaVlgd2Eoye/MI0KXEP39O
 QSBoedkXF939ngAOGVL1m/KAapuRcMNd5n2wt7jKcw0SwsIweIl2EvD3wTP6/OPviBPl
 tKlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OXye1rBuTLJZBwgPImHQ8bZjxo0lobp18ZOZ0cL+t1k=;
 fh=Q0V+BjWEM4ruOf+2Dsg2x3hVaHaPJ14gchdz3PvMfHQ=;
 b=JatGTzOl11u68d36fBP20jb+U3ctSD6Pdsfk6xSEUDzVs2INkKhaqyh6+BYB7D8mkZ
 Vt28WLHNYHIOObbucrIagNPmCLJchEN5pfUSOumEgvuDA2eyPSvzZEdsn9RMZ3MuIo8o
 pwEquC8M2LznPwTkKlPZ7c3Hcf79cubrh8ukHsycbPkbmC5ck+l7/9CdKxhB2tcl9bfp
 j8X7HSEPxlPhZ+QVlXnt1OYCEW885dtikDIoDUOPII3AteUDj8bbx761iodqYMIpS1PC
 v0CoWxuViPHsiEgCkRANlsRhVpNrlIQB+vKYhIwXGWo5lTFg2ZcGNJbgmKDVNX2C93+u
 xE/w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785419870; x=1786024670;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OXye1rBuTLJZBwgPImHQ8bZjxo0lobp18ZOZ0cL+t1k=;
 b=DRr3T6gHv6Iwg1naFyavS2lrER7EVRnpo/RaaGgZtBUG1eyhyXiYd9G3Fdr39vfv1e
 zQ8yZyW7AUvYRdkvQB7Xc5oq9/48+5yviONFayHleSr1RbgdnMkv8YseJ7JUXQkOJ/FV
 Rq+ow7fnCxjOfRUmeqk39CH/qMvf4ltLpnGHrRwMkXNVphsnpdHqOSrRxPDC8jIym+wV
 JyIO+RDH4DmVYA4BSU56TmS0LoJ8gVefVKqx5le/e+Bv38vozxX9dqzRz6Je0EYJcjRA
 GURI+5JhV5/LJ1sLBKlVA98r1g6oQLKPhVzFzlTpqzLGCZUHGgobJzzvEq7Y59QkbQTF
 +dOQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGlq61uwL4EulXMpIY9064pOwWBcODf5G9ArH4iWh7sj1kYvnjnylPzRTVay8l7yLQ8lc9HoI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyOVVZ5xdnH1AmVbLW4L5sZ5qd2auUEHRt4Xo3OFrmMdNVBVdwK
 gS6jA/sOA0khIfWPQTk24QsaEOOuH5cKuaf/EtpVDO535LRBYe6zPaF4Bvepk9WSJvf6OZmKOgt
 Ko5aPxPGhqIB/SQMdV0UtiVnhy9V4NAm5x0QVDaSmjHK/Eh8W0QQkUEsKZQ==
X-Gm-Gg: AR+sD11KBAingshdbMUl3Sa/XPf5bEvPkXEbLihfwGbSeSM8YMY3YfoyiRcA6TPIitO
 YIo9exGJjKOk7EILe8mijCi/sNadkEBVafDPnvhD29+ikm6vY9z78bMEc7rYidkLK1cZ6u+AI5u
 DkxlQTv2XGBSUqv64/+zpQR6vSRp7bO4fM8j1uA1627Ql+5p3bzItGKUZ/4DS3AotqeqwuDRaAW
 +1lXJzfFgZUN3pce6YGNPvzWfh6duY6Cl++cpC1GltKhui6rlzSeH4Fj73pDSLnCPJXyaxA2KaZ
 dLJj+xHlZ/zatNkA94F5wDAchNDyee41tC5uGhiCGRCzT9X2BTXFbQpFk/mlxqk97g5p8k7nOh2
 nG78Uh+ZWeWM=
X-Received: by 2002:a17:907:3f8c:b0:bef:90af:6ff1 with SMTP id
 a640c23a62f3a-c1fa575323emr178856966b.31.1785419870048; Thu, 30 Jul 2026
 06:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-rk3588-fracpll-v2-0-382d113f3a80@flipper.net>
 <20260723-rk3588-fracpll-v2-2-382d113f3a80@flipper.net>
 <b258fdf7-16e2-49ae-b016-a54e710c4ae1@kwiboo.se>
 <CAKTNdwEHeTHU1RPQrKVu4JEvxv0pnsa04m+kxT=5BOAEMZ3j7g@mail.gmail.com>
 <08f496c4-1593-4575-a55b-fc6985960456@0leil.net>
In-Reply-To: <08f496c4-1593-4575-a55b-fc6985960456@0leil.net>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 30 Jul 2026 17:57:38 +0400
X-Gm-Features: AUfX_mzcGzGERI-UueY5ElmOn97rzjyoOV2gW7wESNgbQ33VJ-iK6cRxnTgGdJ0
Message-ID: <CAKTNdwFA97M+DC1UCS6E6BL-1qQ-X7yhPR3UMZr_48fEiM4NbQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] clk: rockchip: pll: fix rounding of negative k in
 RK3588 frac PLL
To: Quentin Schulz <u-boot@0leil.net>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.u-boot-project.org, 
 Elaine Zhang <zhangqing@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>, 
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Finley Xiao <finley.xiao@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785419870; x=1786024670;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OXye1rBuTLJZBwgPImHQ8bZjxo0lobp18ZOZ0cL+t1k=;
 b=W4f6E6DpswhqbaI+veMJfgB/3TLfw8hK45FXd6CzSOQTmfIRqphW23irFq71B2Y1dY
 FJgWccTbbzIhzUKoQbDxeXD+rjxnTttrrJ34x0SIFRqH+qb//LCWhzv1yaD5m3IfmB5N
 AMyeQYIO+nG5IgC0U16N1lVVyUq7JivZFHUJj67sSBN8n8WUgvq86XQh98JVJW7MbxWc
 6SXOXjIPz8oTXuBCh9XtyP4lWSbYThzVo27JOV8c4sQ85ryrtFjZ70YEkjg9Eg9D7dZ/
 33v6sDZdXStq5gKWAZ+nN7mlrL5mKvD5qlf4LmYgPY97VGPH1DGRMhgrYFve2YlPirxu
 j7vw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=W4f6E6Dp
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Quentin,

On Thu, Jul 30, 2026 at 4:56=E2=80=AFPM Quentin Schulz <u-boot@0leil.net> w=
rote:
>
> Hi Alexey,
>
> On 7/30/26 2:25 PM, Alexey Charkov wrote:
> > Hi Jonas,
> >
> > On Thu, Jul 30, 2026 at 4:16=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se>=
 wrote:
> >>
> >> Hi Alexey,
> >>
> >> On 7/23/2026 5:04 PM, Alexey Charkov wrote:
> >>> Current code uses magical constants when rounding up the magnitude of
> >>> negative fractional PLL component k. This leads to overshooting the
> >>> requested rate when the calculated fractional part has less than 0.3 =
in
> >>> its decimal part due to failure to round up the fractional part.
> >>>
> >>> Use a proper rounding up function to avoid overshooting the requested
> >>> rate and make the calculation more readable.
> >>>
> >>> Fixes: 6bfb37e70209 ("clk: rockchip: rk3588: fix up the frac pll calc=
ulation")
> >>> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> >>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >>> ---
> >>>   drivers/clk/rockchip/clk_pll.c | 6 +++++-
> >>>   1 file changed, 5 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/cl=
k_pll.c
> >>> index d0df3b8fb49d..69d2d182dcb5 100644
> >>> --- a/drivers/clk/rockchip/clk_pll.c
> >>> +++ b/drivers/clk/rockchip/clk_pll.c
> >>> @@ -11,6 +11,7 @@
> >>>   #include <asm/arch-rockchip/hardware.h>
> >>>   #include <div64.h>
> >>>   #include <linux/delay.h>
> >>> +#include <linux/math64.h>
> >>>
> >>>   static struct rockchip_pll_rate_table rockchip_auto_table;
> >>>
> >>> @@ -177,7 +178,10 @@ rockchip_rk3588_pll_k_get(u32 m, u32 p, u32 s, u=
64 fin_hz, u64 fvco)
> >>>        k =3D ffrac * 65536 / fref;
> >>>        if (k > 32767) {
> >>>                ffrac =3D ((m + 1) * fref) - fvco;
> >>> -             k =3D ((ffrac * 65536 * 10 / fref) + 7) / 10;
> >>> +             /*
> >>> +              * Round up to avoid overshooting requested rate for ne=
gative k
> >>> +              */
> >>> +             k =3D DIV64_U64_ROUND_UP(ffrac * 65536, fref);
> >>
> >> Use of DIV64_U64_ROUND_UP() seem to cause build errors for Rockchip 32=
-bit
> >> tagets, see CI job at [1].
> >>
> >> [1] https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Fgit.u-boot-project.org%2Fu-boot%2Fcontributors%2Fkwiboo%2Fu-boot%2F-%2Fjo=
bs%2F54629%23L4016&data=3D05%7C02%7Cquentin.schulz%40cherry.de%7C74dcb2010c=
7c473b440708deee35b6c5%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C6392101=
11643377177%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDA=
wMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D=
inNBaFIDx51MBU4%2Fefh2jPAQ49esWECfkahMG%2FWC1HI%3D&reserved=3D0
> >
> > Weirdly, the macro is only defined for 64bit [2], even though the
> > function it wraps around also exists for other word sizes.
> > This calls for a separate fix to take the macro definition to the
> > bottom of the header, like Linux does [3].
> >
> > [2] https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Felixir.bootlin.com%2Fu-boot%2Fv2026.07%2Fsource%2Finclude%2Flinux%2Fmath64=
.h%23L51-L53&data=3D05%7C02%7Cquentin.schulz%40cherry.de%7C74dcb2010c7c473b=
440708deee35b6c5%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C6392101116434=
13367%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsI=
lAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DJ4lUnt=
NUU4AFPi%2Bd%2BnoP0QKyBHTsEqYj9wQeMluOpxA%3D&reserved=3D0
> > [3] https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Felixir.bootlin.com%2Flinux%2Fv7.2-rc3%2Fsource%2Finclude%2Flinux%2Fmath64.=
h%23L344-L355&data=3D05%7C02%7Cquentin.schulz%40cherry.de%7C74dcb2010c7c473=
b440708deee35b6c5%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639210111643=
448158%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIs=
IlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DHJuaz=
Qjmgof5qWRnTLjY%2Fy2XSkImAm11%2BFb3HPCL8i8%3D&reserved=3D0
> >
> > Thanks for spotting this!
> >
>
> If possible, please simply synchronize with Linux. I'm guessing we need
> include/linux/math.h and include/linux/math64.h? Ideally, use a release
> tag (not -rc, and *definitely* not a random sha :) ).

Just checked v7.1 in greater detail. We won't need <linux/math.h>
because the only thing we need out of there for this header is abs64()
which lives in U-Boot's <linux/kernel.h>. Nor the vdso include (I can
instead inline __iter_div_u64_rem into its only user, which is in turn
never used in current mainline U-Boot but might be good to keep for
API consistency vs. Linux).

Some precursor fixups will be necessary, so let me take a stab at it
and send as a proper series.

Best regards,
Alexey
