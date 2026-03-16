Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC7AF53D65
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 15:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCFE38409B;
	Mon, 16 Mar 2026 16:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sO9rdXyF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BABB840A2; Mon, 16 Mar 2026 16:01:55 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 632F78409A
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 16:01:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b9789425fc5so310877366b.1
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 08:01:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773673313; cv=none;
 d=google.com; s=arc-20240605;
 b=eeUPLeGwXd1oVXGPMby/xYRDBEuQ6PphZrooTtYkMRDH6pnnPzRRSKe0/32b+pM7CF
 lKkI5+kjzeeHhEdHds5QsECoSNZAvsbUPVEQsUqaikeeDgougC5p3XR7Fq6nu1Jz8WaI
 mBciKaNFEPIpky2dXGzIJbc7Cp12WI5r49o+umvSEL60kao1NPaR+bPsWTHAB4nvbI5O
 Fdq/ValiuI6H8oTxP3LMY5Lo7fboLwB4t5JthvyQ54RCxMJpRU0ez9E4y5MOMfigtwUl
 ZXRSUqVW+Omt/9ANSd0/VUpdVvWlsnKIgElIG+GkvV3cWWcW/U+B1eriXYxWxYZ/Bti4
 unZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1iy7DweJhxM0TPX7zZXDuIeWhCEutSvwYBueQrPFsTg=;
 fh=9s1rxRGUwAVr+p9cFek0M1Jxe63lhdbGfXzUewJk5jU=;
 b=CwOfGxJUlHF9u5st50Fj/vADZOIrXUpcwmiNQbVizJF6b2RT6okw8o/tlINps8hFyQ
 xyrPJ9yI3PldausDfx3gr2ZdjGfVuY4lvqkLv79btxIBq7Nmz47Ve8ZQCoXV3jTsF09I
 JuDEKnEGJLtTx+FEhj7T+j3z/XJc5iPd8lOv3L0DYlbeq6r4Jg2B/Lu5PuubTXhrvK8H
 cuu3yYgfAa5qCVki763mwZorN7WiGXe7irLhtJxTqRMYMn1qE0XLvW/5duDv5sb9g8FV
 uF9TP3Cm90WxLDJ5XDogNPyvT57yAup6nj5ZMbK+7AT0JySWqNmD3YYZqRNwOb9tY9ts
 2mAg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773673313; x=1774278113;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1iy7DweJhxM0TPX7zZXDuIeWhCEutSvwYBueQrPFsTg=;
 b=sO9rdXyFYGxnjW5cW06t6LMOI0kCVsZtz1meiq5NMAVw3WFfIX5PH+mUlkrFycHV2U
 ejTWVWx6ozcc4y4sSQzYWJmzPepD4xt7mZstqNfyKEfoqWt3yiyPH7JXAVPagpGzKpKU
 Y8+7hYHL871j4gpllAAJilTnr3xvxdJKsSGJkqp1NEEcIeouFXu1JtYxc1HGnhDGYxuu
 MCXyvzNeAr8/WjfVFGlceFQm1z4ixBZPoS0Hc8hrUTq7pjO9lXdsJjx9O+2nFm2ov8tb
 HA3j78xxiczmLLENdorQd7DveGPvzDaJq+zPW8ONNlgjkAFJQyABJu/5TovbdrRMcaSl
 RQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773673313; x=1774278113;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1iy7DweJhxM0TPX7zZXDuIeWhCEutSvwYBueQrPFsTg=;
 b=GoYrNl7jriO9eDFRoNa/zDV6N36pXaPoCHr9+LZCvrpqNaCRWFys+pwsrtwGXgvVEE
 3YUvTqy4moz5BEZlJ8OimzNEbzT7nLx7ZqEUCxza2CE/1itx0r6g3QrrSOaQPKVncPlm
 wQk0p6vh6oA3S+xMXK3f5Y0GTU5oANW4Ld78eeDiz3RxZyH0ZEO070LgKnhLzOHeGP6U
 x9LyXahPRY74hugUxUbUiyrjeDy2+xL2N9R8lvgtX27Gj011XuSxCE/iFxC3etSwqVe3
 uWA9V7eLteNJ1x2QaY4/4zejg6SPIT4MgN3p+hokq9ZHpirAb+9fGD0WMT+3AOZBfwMG
 WbTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHpwWmGA4bmBKFtDEGUn0vQcn8KSuMCVv6hv+9ohHXOGpnbtTHvBnqdc9KIOfvflKDgLGr74A=@lists.denx.de
X-Gm-Message-State: AOJu0YxpI2JCGrcj35JgESJ7Y3AY0hNI0eSPcKxfBJ2dxSAKnVwgMdZT
 d4SEMJ1C2KL8solHLpscsc2PmjSXFyhZ7p5DskXulc5MbKKToELKy+vZ9y3jMcrOqwgsLkndQPJ
 kp5Lx+EUmkREkSgesXIyhPhi94dlSewDk8x8I37gmsA==
X-Gm-Gg: ATEYQzx9RM9VjjXIm1etisc5CuAg4RsvO1PhyMOBsB6zbaLS0v3TYGfxbciwp9TMRHa
 MAJE9MbV7zEOILBoKEnVi9PZxlS7Oj/s+iGejq240m3049U/WRlTgWSrWPrgJ2javm/yAj+E7YS
 SznxEGyoayn9Zm08UxTyouFqwSfN/bc4AkpRiqTl6dnYyBuphnKNOlf2EOrb3U75XP4M8a8mG1t
 Iwbc0GF90Jq8bCdgJ+F0XfdrsuggOIwOu6xEMh+DJAeN3Nf5218O0btnkigj1Zk1eGGx/M2MpTy
 pBUrdnT09T6cxdM67E5t+NIJUDaVHRBsCg2ZYJ1Jmiuzw/oacZYqSKi+Gi5bI5ngzwI0jmhtVhs
 69xNWBil0eYIk1YdZETl1S6nInASEVX7tfPM8
X-Received: by 2002:a17:907:806:b0:b93:cbc9:85d6 with SMTP id
 a640c23a62f3a-b97636d82bemr843902366b.11.1773673312383; Mon, 16 Mar 2026
 08:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260310-mtk-mt8391-initial-support-v2-0-1dc862d58532@baylibre.com>
 <20260310-mtk-mt8391-initial-support-v2-6-1dc862d58532@baylibre.com>
 <CAEHHSvbduE9Naebb8hk3xu+0ZEwRuO8yuh_1GUM9QFOP=BA2vQ@mail.gmail.com>
 <38e5929d-4d95-45db-be93-28232a9de954@baylibre.com>
In-Reply-To: <38e5929d-4d95-45db-be93-28232a9de954@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 16 Mar 2026 16:01:45 +0100
X-Gm-Features: AaiRm53v1XadbVIQYe4QoEQvvpPMkWafYj_HEjVThHjuN8Gs-hebH7rLkXdTwac
Message-ID: <CAEHHSvY-NRQcLKHizS0S-++5CgXrvKdxjH4QUrsWP_LbW+AC-Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] board: mediatek: Add Genio 520/720 EVK defconfigs
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.denx.de, Chris-QJ Chen <chris-qj.chen@mediatek.com>
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

Le lun. 16 mars 2026 =C3=A0 15:34, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> On 3/16/26 7:38 AM, Julien Stephan wrote:
> > Le mer. 11 mars 2026 =C3=A0 01:17, David Lechner <dlechner@baylibre.com=
> a =C3=A9crit :
> >>
> >> From: Chris-QJ Chen <chris-qj.chen@mediatek.com>
> >>
> >> Add basic defconfigs for Genio 520 and 720 EVKs.
> >>
> >> Signed-off-by: Chris-QJ Chen <chris-qj.chen@mediatek.com>
> >> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >> ---
> >>  board/mediatek/MAINTAINERS             |  7 +++++++
> >>  configs/mt8189.config                  | 34 +++++++++++++++++++++++++=
+++++++++
> >>  configs/mt8371_genio_520_evk_defconfig |  4 ++++
> >>  configs/mt8391_genio_720_evk_defconfig |  4 ++++
> >>  4 files changed, 49 insertions(+)
> >>
> >> diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
> >> index 446a9e8e53c..4f371592059 100644
> >> --- a/board/mediatek/MAINTAINERS
> >> +++ b/board/mediatek/MAINTAINERS
> >> @@ -1,3 +1,10 @@
> >> +MT8189/MT8371/MT8391 EVK
> >
> > Hi David,
> > I would not put MT8189 here since there is no MT8189 EVK
> >
> >> +M:     Macpaul Lin <macpaul.lin@mediatek.com>
> >> +S:     Maintained
> >> +F:     configs/mt8189.config
> >> +F:     configs/mt8371_genio_520_evk_defconfig
> >> +F:     configs/mt8391_genio_720_evk_defconfig
> >
> > Any reason to have genio_520/genio720 in the defconfig name?
>
> The upstream devicetree name will have "genio-720" in the name, so
> find it strange to call the defconfig something that doesn't match
> the devicetree.
>
> If there is a (not Genio) MT8391 EVK I would expect it to have a
> different devicetree and therefore a different defconfig.
>
> > All other boards we are currently upstreaming don't specify it in
> > their defconfig name:
> > mt8365_evk_defconfig/mt8370_evk_defconfig/mt8390_evk_defconfig ...
> >

I get your point.. From my understanding, mt8371_evk IS genio_520, so
IMHO there will be no non genio MT8371_EVK.
But, I understand that it makes sense to have the name of the
defconfig matching the name of the device tree.. In that case should
we rename all other defconfigs for mt board?
(8365, 8370,8390,8395..)
