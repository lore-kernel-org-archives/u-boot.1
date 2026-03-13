Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17960105F7B8
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 15:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 898EC84370;
	Fri, 13 Mar 2026 16:21:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OmR8IiAh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8569843A9; Fri, 13 Mar 2026 16:21:28 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF53F8436C
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 16:21:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-660be63279bso4731570a12.1
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 08:21:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773415286; cv=none;
 d=google.com; s=arc-20240605;
 b=fEiTg/RnB3iNJMXo0YuOFwtT+DDWKaKBghBhtDju/iDJCFjB+LmARVRsSMNslleeZO
 JaZqcuet8YhWOD16ztwCDkrG/luSSb4E9Qbk/IGPTtPwfchTUoVPwqZVwdPqmhoxaXg1
 /giij2pEf8jkOQRepS244ExejXOTZbdSZIekIRdNC4Akm+FIksb4oqznkp0ITheTUxQm
 uevDINrL1vlxSFz6Nn2QgExvI9aHVpN+56AHvLIp+0va7GSYAeFyFbxkJEIvceYB+UWP
 Ulm8unZ+zD48hI/shf7hJldLbU/3Iytg/g0SM9wFlBxlKXWd/V0fN4HcbeI0bCN3MeFK
 ariA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pcFfTQBQKEnNwF0e3ij35kEiF0iEervKuYjQbw0ZGeI=;
 fh=kL92CJkIUzZxHtQ+vZBVIxq5pltYXtiUqlhssUbETtM=;
 b=aNsu5E7JXfFFUbMo+eoLkTc0Njk3f+cDdb/3yAwPoFXdVghnzxXP4/A+saoDDZNvVp
 vs/bhGi6Ax9Jr71JpSNb52zPQfvLXkuweKx7sLZvJPI65Z1tMtaI/ChzngwXxRHQVpUR
 i2mAXqF5D2XbW6qhFmqGABvHS+Idy6OfHOWAWjF1hzz2XN9Ltnzb8PS1TR1oZ6AMcPTw
 7ItqqYuUkAMBmnkcSWtySYIycl//sX00zcQ5j9x1twYWT3kuNLyB1HVUY4pcoKARQZK3
 +fyeXyeeMp3X/seB7vlxsF46QMvsjDcJmJ/pCrKYU1fRKy9NZdp2hoV5zL6INZTPdhU7
 tMng==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773415286; x=1774020086;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pcFfTQBQKEnNwF0e3ij35kEiF0iEervKuYjQbw0ZGeI=;
 b=OmR8IiAh9MmWrkZCS97i5yc82Ija/b9dJftG+fvS743LHjgX6IdIrGy6TosKUhzE+T
 MQpOppPLOrUJPD/3YFUJ+sB1F6AWbeJ4RA6hWevuulE8wt7G+pP4Y+GYlqAZzeRbM+1O
 Y2rc/2URbSUg639PSTdeEggk/3HJzqQghAm/Y+gxL4kYW+VHTTxC5gmct+QuhMgdmzrg
 tjddiS1sgZzSWJtpI8oa+BXGc+gLUYkrllHrjPbiY3YSvHgbTNDnaAaxROQ4j0BVhvp8
 7PYREvnkff0L0KP1zGJz0RxhbRRweX/Z8L9e3cNouraXKhVO0UEW1HVUhelv0iBKrHOn
 erdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773415286; x=1774020086;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pcFfTQBQKEnNwF0e3ij35kEiF0iEervKuYjQbw0ZGeI=;
 b=A5N/Rg+82o6So9ltfFPqX7aIEvO5+7+YrJOdYtNGCwh9K3VfaSss5S5O73NIkGZWAf
 47VXe7zMCOX0QSfsQaZUiLCb7SZw7xGBsWeUCkaDszSBl8bWrjrdodl1EfFumPWYqIRZ
 j+chAdqFIJ2SVo8JnzUCTV1VDH5oiAjrJPxBNleh6fEf1nooaw4MssWDkRmCjNxMKgYT
 X9ID4rjSfRsq1kTreqcKc9sPGXdL+NmRljP2hNH3vv62D3FyNDe8/es7lW1QAZRcKQTA
 tzzXwbF0JINm3ibPtq0Lp0vcU4oKuYmeKOcPQ9TT1FSCL5Fk/smW39tA6eEFfh2gQizg
 /o0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd+H63MafMqCcvZgQM9/yAPcnXsY3A/9iCucdOaekDWOcogF9HVmmfFo11lH9GhZjjHwhHb/A=@lists.denx.de
X-Gm-Message-State: AOJu0YxJrUQQS+nUOO2CrHnpUZkvrV67m+Ymtt3YQQ+dn3LePRmdpnUC
 P11MaYwQN2zhlpl4zA6lKlDpoSbZT81ZIqlFSAy31uobqagHoYjsrkGTiegWSEOltCBwJECVzAx
 crFk5mQlKVWFvhSyRGpFI3BfraVisdhbTMI8lbDqdtg==
X-Gm-Gg: ATEYQzwDPGPGXgLm7+eyDAuYO42I1LtFIf6XMiZ4NCbc8uYfAdc7G0L0c6yLy0wk+9W
 DVsZZht0ClYTZMsGVMM5XevEi6QlslpEqNp1fOVawe4Ao7ibU8tLx1USMXpvBPcWEqE0KzhjFWe
 h1p87JJndbb8Ag4HH84S55NyXgIzrxg0CW/LRupfKwPdsSLreIK+dt5xNFrHZ6jPg3L/2zrtRz8
 PIR2kHTUf0s0xKBftQOX7pyvK2AKpMcZbJ6GPduoAyCV64UIpjQwB7GgNZC3tGZrJ1NHaYAIqnj
 fYT9nzVzLsBm8JV9/BXGZVNDomvOkX+nZwl7Sb8pxHZwagOzb101HN8bHJVMdEsslsLztO5keKt
 0hfRWrT14zb2enW8TyTtHBSXwzg==
X-Received: by 2002:a17:906:fa14:b0:b93:5ef5:904f with SMTP id
 a640c23a62f3a-b9763a2a5c1mr178017966b.26.1773415286324; Fri, 13 Mar 2026
 08:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
 <20260303-mtk-mt8189-clocks-v4-1-ee85f8dd2f0d@baylibre.com>
 <CAEHHSvYMiCZ4jAXp6jEhg6AhZ5Dv3_Ak-8H1mT7S2FPD3_X7dw@mail.gmail.com>
 <ae3517d6-fb57-489c-8029-f536ef68fdba@baylibre.com>
In-Reply-To: <ae3517d6-fb57-489c-8029-f536ef68fdba@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 13 Mar 2026 16:21:18 +0100
X-Gm-Features: AaiRm53gmym19Db0jKr89GqWaHLUAi1CgV1QQOLNvjThVcAyb3fh4hlMAeYCKJU
Message-ID: <CAEHHSva2gHP6MDF_FxMJ-EpOz6dLOGZXfSbCZfxnC7pzD-Jsdw@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] clk: mediatek: use correct struct type for
 infrasys clocks
To: David Lechner <dlechner@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Le ven. 13 mars 2026 =C3=A0 15:26, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> On 3/13/26 7:53 AM, Julien Stephan wrote:
> > Le mar. 3 mars 2026 =C3=A0 20:55, David Lechner <dlechner@baylibre.com>=
 a =C3=A9crit :
> >>
> >> Fix the private data type struct type in a couple of infrasys clock
> >> functions.
> >>
> >> struct mtk_cg_priv is a superset of struct mtk_clk_priv and has the sa=
me
> >> layout at the beginning so there was no compile errors or runtime bugs=
.
> >> This could only be found by inspecting the code.
> >>
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >> ---
> >>  drivers/clk/mediatek/clk-mtk.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk=
-mtk.c
> >> index b4de38719e1..b3f05bf5a21 100644
> >> --- a/drivers/clk/mediatek/clk-mtk.c
> >> +++ b/drivers/clk/mediatek/clk-mtk.c
> >> @@ -933,7 +933,7 @@ static const int mtk_infrasys_of_xlate(struct clk =
*clk,
> >>
> >>  static int mtk_clk_infrasys_enable(struct clk *clk)
> >>  {
> >> -       struct mtk_cg_priv *priv =3D dev_get_priv(clk->dev);
> >> +       struct mtk_clk_priv *priv =3D dev_get_priv(clk->dev);
> >>         const struct mtk_gate *gate;
> >>
> >>         /* MUX handling */
> >> @@ -946,7 +946,7 @@ static int mtk_clk_infrasys_enable(struct clk *clk=
)
> >>
> >>  static int mtk_clk_infrasys_disable(struct clk *clk)
> >>  {
> >> -       struct mtk_cg_priv *priv =3D dev_get_priv(clk->dev);
> >> +       struct mtk_clk_priv *priv =3D dev_get_priv(clk->dev);
> >>         const struct mtk_gate *gate;
> >>
> >
> > Hi David,
> >
> > I guess we should also update priv_auto definition of mtk_clk_pericfg
> > in clk-mt7623.c ?
>
> Good catch. I think that is something for a separate path though.
>

Since you already sent another patch for this fix, for the whole series

Reviewed-by: Julien Stephan <jstephan@baylibre.com>


> >
> > Julien
> >
> >>         /* MUX handling */
> >>
> >> --
> >> 2.43.0
> >>
>
