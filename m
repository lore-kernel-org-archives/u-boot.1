Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A758108B913
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 12:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6766C83CF5;
	Fri, 20 Mar 2026 13:38:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oCl2L7V7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5CF483D71; Fri, 20 Mar 2026 13:38:56 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D83583BC8
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b983ca059a1so61572566b.0
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 05:38:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774010334; cv=none;
 d=google.com; s=arc-20240605;
 b=X4bXEBsaZJrwynobnOvMQn9G+lMK58oAP9dJgy79Opiag52HMP5rf012D9ZQbohbZp
 PkXnmNW+PGXjpeU/GedpR4Rvhc5zY39QO7JqKsaFE2elsLjmI8VuhDClYmVYKBTjN/iE
 v7rLChEn+YLj6/K12WLDGi+PCQ6jzkaLaaPx0QMj1mdCS8c3UvulZrskyuRZU7QI3JYJ
 +NTVaV8XPnVvgfLGmTqwioSW1SpA/5NkuBLtzRCVods/96tSFY1McDVX4Yh92dWKnurg
 Mq6ZxV3Q3NkxQZ0x7Unphs+k8f71YI4UDV2yopPuj0BBeCeoGN3guRsX5g3BKF6OGI/T
 UW/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SpHfn5BmEA0LKn1TgDQTI+VAycrDf1e26PkKnZKFaoQ=;
 fh=GT8nDKBHVSrdlqnNwy39TqJWCYCY8oSDcdz5beFMNtw=;
 b=NX2W+QVN/ecz4ukVhyHWvNekANkJSegJ4XlC5TPCl/EEu4x4vhFYlM/Juk3OIsTya1
 XFla+35I9JCRs5SlXeGU7AR06eg+Ibj1492WzTC8RlI3enmlL+FvD1Gqkrws9NwDDTiP
 GwUrQnYhLJX2jxZ+H76XEOGyatA9vv60cJ5+cZ9gMK2sipFunrJCfdZIzxIAx/D+w9Vb
 NM6E4wURQ2rTMLbzy/y+gqyUQ71yldOMpS+NsQIqs95nqusyoLI0+2y2L8CqywhE3XhQ
 n+2lUSQ79ymgmI3zRI+M0nIdOj40Jw3kKTFvFsWk8VE/gLcXcbOUiKU5+KXUR2lXpSgc
 esjg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774010334; x=1774615134;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SpHfn5BmEA0LKn1TgDQTI+VAycrDf1e26PkKnZKFaoQ=;
 b=oCl2L7V7Z9E0GP6qrqVQ2OBh6USfZxnOGvPvopsuSdxR/akKESWnBTrlvCgevDczgF
 YaD4L5zjBl3sw2ob+wPEYPxsDLMr5W1ogxZGvdfyT1Ma6Gjg54/Fu6ATLoujfd6/vxHa
 okVH6Ngg6wqty/7SjV41GvKhNKOmVC1o6CruwMSP1rMOnPsfvKfIoV5Zr2BNPESPngjc
 h0pl7Dbb9DhI0F+/afz615J38uy/eLY50GWncwsFz/bXR4QgGb923FBVDTiNahfb4yTo
 X8vTqgTWd0TQOD8uV50Q+Y2d3nUNb7Tdm4l4MqQWBq8Jtw3H3VlCbRtlW+h7qToYj0kr
 6JSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774010334; x=1774615134;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SpHfn5BmEA0LKn1TgDQTI+VAycrDf1e26PkKnZKFaoQ=;
 b=WdVjGoYesGga6Q4aV/Bely5LZ/Dl2x4bOiTZ255eMKtRut/uKcbTS4YQBt1AovnDd9
 fdIAJaAg7eDh2i4Nf7S+R4KeqhW2jWDGddbqdj4qq/TsG3P7MWGpuiNh/ueTOplETszf
 qGgGHWDPq/WSe2y7II+ku6R4+oHXElySpa0MhCIHthn8Lg3jahTYu6bsKzza3p4/6oUa
 Xc1MNuI3MU2p8hDORaheshjM6sm+cAyhi8/5zMH/qb9y6ZobamgVWzszESWZ99igCUWF
 gXCOaF4hy7wtLQ+xC1W2mnIO5r9OlKm1qjxtJ8pRa4zEAbE9+In+mp1Q5gv/94azD1xu
 SZQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDsX1nKpVmAq2fLY7TFwB2RQYYNAgWRAtLNzwZiZ/oygaD5iAz+KdxSDHKQ5+Zd4k1E9H5UkQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwQjp5PRPg0b4dnwwGB39tRhxfZXJeJKht0yZRuEven36vd3u8z
 JPc8IkrkTmWtPab8AV7aC3VppNMtvC8s4TXkaU1ndAWMOVRQoGbCfkncTEkbcISs15Dgd+Skjuk
 DnBvy8r8v+SBgVIJdeS/r+KmNI/2uQj1hDTJ5BhOYWw==
X-Gm-Gg: ATEYQzzIu7IbGEBdesuLDIaM+cUiSqUG1aqd4+4OkL7PvdZ9yHgUEm3GcZ8mE+1THF0
 Q3WSUXk7hClFVFNTVJmAFu6DT1NNboPOIR4vqGc3J9N+mPeohrKMcoEt1nHImc3SrIP48+iTHIO
 dJFBCIO8fFeY8c7+0QktimaJiaackEnm2++VGOAHLXmNYsnH88NvdASymaAeG8W1NHZKPIEobMG
 xhzAD451urwVow/z9s/srtUAYGNxTAgEEltDhlgVVhmB80WCc8yp6YXb/dqR5MEp5DwIDhOlKTb
 DIsQdcD4dUqI6a+Q30HvoMG0H2SnIay9S01+qkf7a7X5NBHyExWt5Ska4zQOEF8SXKC5XDA+V3I
 01+Krxa8UbpMBSr0jo1WdEkBSUA==
X-Received: by 2002:a17:907:c8a7:b0:b98:155e:603 with SMTP id
 a640c23a62f3a-b982f3a3b43mr184960066b.31.1774010333743; Fri, 20 Mar 2026
 05:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
In-Reply-To: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 20 Mar 2026 13:38:46 +0100
X-Gm-Features: AaiRm50C3dJ61Z6ARS7xjUzLRatDG1RJwKpmKRKJk9gaRvldRcxXFo-gpKsH9o4
Message-ID: <CAEHHSvbkFGC=gyRFN4jh3nF-rFZ5W+sdKtDMXZqo9Xm5VzQZbg@mail.gmail.com>
Subject: Re: [PATCH 00/17] arm: mediatek: clean up init code
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de
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

Le jeu. 19 mars 2026 =C3=A0 21:02, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> While debugging an issue for Genio 520 EVK support [1], we found some
> issue with the various init functions that have clearly been copy-pasted
> between the different MediaTek SoCs. Most of this is cleaning up
> duplicate or dead code.
>
> The "fix gd->ram_top limit" patches are fixing actual bugs on a couple
> of platforms that were introduced during this development cycle. It
> turns out that this was the root cause of DMA not working on MCC on
> on those platforms, so we should not need [2] after all.
>
> [1]: https://lore.kernel.org/u-boot/f2545bf9-3709-40fd-8d0b-b68f4d841d02@=
baylibre.com/
> [2]: https://lore.kernel.org/u-boot/20260317-mt8188-mt8195-disable-mmc-di=
sable-dma-v1-1-220da4144920@baylibre.com/
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> David Lechner (17):
>       arm: mediatek: mt7987: drop dram_init_banksize()
>       arm: mediatek: mt7988: drop dram_init_banksize()
>       arm: mediatek: mt8183: drop dram_init_banksize()
>       arm: mediatek: mt8183: remove call to fdtdec_setup_memory_banksize(=
)
>       arm: mediatek: mt8188: drop dram_init_banksize()
>       arm: mediatek: mt8188: check return value of fdtdec_setup_mem_size_=
base()
>       arm: mediatek: mt8188: remove call to fdtdec_setup_memory_banksize(=
)
>       arm: mediatek: mt8188: fix gd->ram_top limit
>       arm: mediatek: mt8195: drop dram_init_banksize()
>       arm: mediatek: mt8195: check return value of fdtdec_setup_mem_size_=
base()
>       arm: mediatek: mt8195: remove call to fdtdec_setup_memory_banksize(=
)
>       arm: mediatek: mt8195: fix gd->ram_top limit
>       arm: mediatek: mt8365: drop dram_init_banksize()
>       arm: mediatek: mt8512: drop dram_init_banksize()
>       arm: mediatek: mt8516: drop dram_init_banksize()
>       arm: mediatek: mt8518: drop dram_init_banksize()
>       arm: mediatek: mt8518: remove call to fdtdec_setup_memory_banksize(=
)
>
>  arch/arm/mach-mediatek/mt7987/init.c |  8 --------
>  arch/arm/mach-mediatek/mt7988/init.c |  8 --------
>  arch/arm/mach-mediatek/mt8183/init.c | 14 --------------
>  arch/arm/mach-mediatek/mt8188/init.c | 32 ++++++++----------------------=
--
>  arch/arm/mach-mediatek/mt8195/init.c | 32 ++++++++----------------------=
--
>  arch/arm/mach-mediatek/mt8365/init.c |  8 --------
>  arch/arm/mach-mediatek/mt8512/init.c |  8 --------
>  arch/arm/mach-mediatek/mt8516/init.c |  8 --------
>  arch/arm/mach-mediatek/mt8518/init.c | 14 --------------
>  9 files changed, 16 insertions(+), 116 deletions(-)
> ---
> base-commit: a27980786cfb3c430aa1c05da8e79180c584d221
> change-id: 20260319-mtk-init-fix-dram-51bd6157bb63
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Thank you David for this!
I tested on genio-510, genio-700 and genio-1200 and it fixex the dma
issue on these platforms.

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
Tested-by: Julien Stephan <jstephan@baylibre.com>
