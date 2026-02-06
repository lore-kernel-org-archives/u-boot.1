Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB27EE20A6
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 15:52:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4770D836D3;
	Fri,  6 Feb 2026 16:52:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZLsO/CCv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 885B0838FA; Fri,  6 Feb 2026 16:52:40 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 853ED8352B
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 16:52:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-65956402da9so1758262a12.1
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 07:52:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770393158; cv=none;
 d=google.com; s=arc-20240605;
 b=MsNyh+SY3UPT2mvRRd/oSN9jhhPtoB6kvSdl3qzt4LlqXvPxvzrM32Bu5s285uHu6z
 vJZq8YihOuTPMm9+YU6DyqIIjWmu4u95Gv60NopTCnKvEhanxr9WaE+RILgAsZBNbrWJ
 zSmsPGKg0oWtO/LM4GIbVzF3plavufSOCalmWDr0qqHKpzs+8XqeH6BvxgV3tc/x/NJ3
 raUfCvPOopY+6iC9FvA1MNniEnqaDWFmU9rcqslslyseT606bjtvJ9IrIf5D9N0W1stz
 FoUANw0qhoc5SlFogyqGQjxUHNI+W0isanA0KxDcyOtvvLOr4inxQ9V/ThHXQ6licxcZ
 RFew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LBVnKPczzoGo/1a3AE/TkBdFwfN7tIKJLDAK2Mbo76c=;
 fh=zu1A2k2A5hC/jKmwxLG0gpgJz8/cKlQuBWQfjIWO9w4=;
 b=PcHOOYyBqTjLvFj3oUDTY1doU8Wy/AGGR/BaKi/WA/Vtv9izaKH5PV5ISIcx9HYafs
 Vst+egucN+82vNq/stiwvhUW+LNEoqwniXlDOD0e+Y8VtxWfUKQVfpDNqLXQOStan82p
 8ZznI9YLPdV7tG86D+5l/gkhNptK2mfEwNbrI7O9lWYETCyau/6idNpVa1kh7kKR0HCa
 ZohPQVlSNjdepqdc1cNxFWoUt4JBYnXyU/2EIp89yFjh49a3j2DX2nLEE5Yub+IRMK4l
 lgHWkB2q/l166EO8J1eHwYOdgAy5F+oFh5jykhisd3JbOLUxrv/nw9mXwXvqXMfxGyau
 HsNw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770393158; x=1770997958;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LBVnKPczzoGo/1a3AE/TkBdFwfN7tIKJLDAK2Mbo76c=;
 b=ZLsO/CCvrpVzi1qJcTyfaZZoHk7pebm3N747aaH79C7Hd1EXmSdfpx2OJ2MGJoA9Ve
 fhttzXfFHKEGVqBgnEUEf1W7WxFT8WKcRE2KsWPv95Jh/TOG560cWX4Q/o1dFQCz7/so
 96+6mgG49Wet39uK4jQo+E6R2I5iEIEvOxDPKKtaMFUp4m5nBpm9S0aXgYZsHwf8g8c8
 d54dRO2s7X2bIxz+AJ7KV4h9etcZsRrLOOeCR97hUAvXXR/tRSDiAmpKl9oxsieNRFU/
 knOnShsAdm40QwdcszfHeLTanipcNDXHgphphk5ehu4I0SZ8aea6iSvrvb5GwmDcNvN1
 4grQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770393158; x=1770997958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LBVnKPczzoGo/1a3AE/TkBdFwfN7tIKJLDAK2Mbo76c=;
 b=isI0o7YR4xta0qXzaYXSj7DOA7j0zidBtoyeT8vCzv/8hnC8u9zzY8jReYFyjyvDFf
 nOzVV9pg94VeQK97C3KxFp3PmAr3IGpVI4Eqp8u+bVX/B4AoJbMUBxXX5uyk6PalYxTC
 KtQYhTjkPCSoKMdCE+BP6PieP4UnIOcLW+6HxES1UTu3hyPF6Ag8VnVIaUlUDqiOuEUP
 PAzoYhWqmZoKo7ZTZBafgEp2Dbj4hyJKNwrmfGRdW4a9c4Fpu/CP0+T011m2ovq7d90u
 VEcaRNzH9q+jW5/0fHYml/fmrcM7TsxedBuCji//VSr7HgmyUIWT/AHAb6T1Lx8CDDGK
 NuoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK90qW6q5jgAdG/E/7OIP9PDqOuBtgg1sfuJXI5guTrNggXwEw7f4vGSMDjNicvoKuaQIZBu4=@lists.denx.de
X-Gm-Message-State: AOJu0YyoAYGOX395NDkb0EM0ZplX6Sb6L9t0cDc4tLC6dEqyyRmaOHZI
 RG8y9MCdbKN/QvmB4j2SFq7sXw8dsZK6ik9MWkKOCAeT0YZ7Hz0X6DkmkAeNwqEWRk1H3huF7Ox
 e6MzhyZnilGS7t2zDsbfiB/DiEmN+Uo6gajdaQx0olBMgUPTRfts/iFE=
X-Gm-Gg: AZuq6aLOTwdVuZhmp6QTE9QN1ZqRR/chn0WMBvF4QTMEMRXmjRqUiA0s12t85UY3f0v
 AsLSiTNf4+Hf3cx829A7r1S4LqEnqosf4K+aG0KHYymn9G7txROzXLICac4UT7t2aU8h3Z4CpYy
 G6xjLcGV/1CTm6lUdUqNq50wxidz8DFvMAGkSEf9GuKvQ6qjnR+yJ6xeKCnnQBxWVuOhN2DY1Fy
 dsiVjQx2jhMX0R6wtGdqDwSBjNmqzuodS++N40t7oWM5xWL8y2pwpdxF4Vzp5ZuV+wi2WeoNKU1
 5+BO5N+o80nCOnenFq6pK6wJCrusr+w7k/swuTU=
X-Received: by 2002:a17:907:86a3:b0:b8e:3877:d1b2 with SMTP id
 a640c23a62f3a-b8edf1b0fbfmr178314166b.16.1770393157732; Fri, 06 Feb 2026
 07:52:37 -0800 (PST)
MIME-Version: 1.0
References: <20260205-mtk-mach-clean-up-duplicates-v1-0-b7d4a43c18eb@baylibre.com>
 <20260205-mtk-mach-clean-up-duplicates-v1-5-b7d4a43c18eb@baylibre.com>
 <CAEHHSvasBSDP8S+v5qbiAgJdNH9bvLcogi3oh8FJMgpfQ9VAOg@mail.gmail.com>
 <CAEHHSvZ2bQy+b7kjO0jZyFEo0e2pYsfA9YxBk2m3DCOrcRu2Gg@mail.gmail.com>
 <1caea259-b900-48e5-a3c0-89645f312b52@baylibre.com>
In-Reply-To: <1caea259-b900-48e5-a3c0-89645f312b52@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 6 Feb 2026 16:52:25 +0100
X-Gm-Features: AZwV_QiWeZFwstjpuQNQVDjAYsjCAH4mNu5v42RdR8Tas4xy8AkmWnLIx2Ajebo
Message-ID: <CAEHHSvbN2YdsQwO-CgQSZ4wADDWK4ca6xh=WHAywUFw9EPaVpQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm: mediatek: consolidate ARMv8 memory maps
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

Le ven. 6 f=C3=A9vr. 2026 =C3=A0 16:07, David Lechner <dlechner@baylibre.co=
m> a =C3=A9crit :
>
> On 2/6/26 6:48 AM, Julien Stephan wrote:
> > Le ven. 6 f=C3=A9vr. 2026 =C3=A0 11:07, Julien Stephan <jstephan@baylib=
re.com> a =C3=A9crit :
> >>
> >> Le ven. 6 f=C3=A9vr. 2026 =C3=A0 00:52, David Lechner <dlechner@baylib=
re.com> a =C3=A9crit :
> >>>
> >>> Consolidate all mem_map definitions for MediaTek ARMv8 platforms into=
 a
> >>> single file. The size of the DDR and MMIO regions can vary, so Kconfi=
g
> >>> options are added to configure them by target.
> >>>
> >>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >>> ---
>
> ...
>
> >>> diff --git a/board/mediatek/mt8365_evk/MAINTAINERS b/board/mediatek/m=
t8365_evk/MAINTAINERS
> >>> deleted file mode 100644
> >>> index e0d65efe812..00000000000
> >>> --- a/board/mediatek/mt8365_evk/MAINTAINERS
> >>> +++ /dev/null
> >>
> >> Hi David,
> >>
> >> You are removing board/mediatek/mt8365_evk directory (and mt8390_evk
> >> below), so you left mt8365_evk_defconfig (and mt8365_evk_defconfig)
> >> without any entries in MAINTAINERS files.
> >> So maybe we should add them to the MAINTAINERS file at the root direct=
ory?
> >>
> >> Also, if there is no more board directory for these boards, I think we
> >> should remove CONFIG_SYS_BOARD=3D"mt8365_evk" and
> >> CONFIG_SYS_BOARD=3D"mt8390_evk"  from their respective defconfig file,
> >> as it should be empty if no board directory exist.
> >
> > I forgot but we should also unset CONFIG_BOARD_INIT in defconfig for
> > these boards, otherwise we end up with undefined reference to
> > `board_init'
> >
> I did this already for mt8390 in "board: mediatek: mt8390_evk: remove
> empty board_init()". And I used buildman to compile test everything.
> Did I still miss one?

No, my bad, I missed it in the other patch
>
