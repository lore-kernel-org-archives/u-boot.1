Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989CFC44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 11:22:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81E726083A;
	Tue, 21 Jul 2026 11:22:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9aVcAbH5xgda; Tue, 21 Jul 2026 11:22:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1B7056081A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784632949;
	bh=IdAAxQyZLy6ZHTnP/2mDT3kHK7wRq0a7eofCCrrSWBw=;
	h=Date:Subject:Cc:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=P+Z86WsRMIQAnY8Nx2STnS3vvPfR8TVL0R1AWs4F8amyD0yuTjnoG2VzhJ6fzGRCT
	 NzFOsbE0FQZ4I6rE2yJ21f8Q4ZZ7C9aKxPO9NTznOTCKAV9z6FNuYzZCvmOwaweiBn
	 wu2FHJwOMIQHs+6XxUo6bElZ6zwX5CgmTx5ofQi8vhDyp79F8mHowR4MZgEfNMSVL4
	 CuzdKwV8Jgdl+A1OOp+EUF8W/iqghtivNl8vrtkvkJ00RAFLibOkNh1tdVEczTw6xc
	 3z7QzSClk02IZ780quRDnKmDMMej2PC61+BegZNkWHKLvovQN+WCdaBNUII5TWawf+
	 OUFOx49K82qCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B7056081A;
	Tue, 21 Jul 2026 11:22:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 03D54224
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 11:22:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E2F7540902
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 11:22:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bkbNKXWXsT9T for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 11:22:27 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1DD1C408DF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1DD1C408DF
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1DD1C408DF
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 11:22:25 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07E4F84659; Tue, 21 Jul 2026 13:22:24 +0200 (CEST)
Received: from mail-wm2-x09.google.com (mail-wm2-x09.google.com
 [IPv6:2a00:1450:4864:31::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A230C803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 13:22:21 +0200 (CEST)
Received: by mail-wm2-x09.google.com with SMTP id
 5b1f17b1804b1-493e55619a2so23410285e9.1
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 04:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784632941; x=1785237741;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IdAAxQyZLy6ZHTnP/2mDT3kHK7wRq0a7eofCCrrSWBw=;
 b=dOWVA+DIyy5rC58CdrzaYY02Z86pR2pbSoXC39DAJevIIRD476zXMuEQXrw+TpGalN
 b1lg3xuBT0ENDIRTJgI3sRPNd/1C24O38fid4ogMiMxQJs/PbQDVlyAWuP3r7vUlE1v+
 LusihzYxHuG+iq5nj2e2+Z+G59eisSjL4qsGlGo1til1I1Hs34oivB1nD4y3d4rF6BsY
 0FjwxBOPyuPalxbe2PLy0ZEFYz/FTctt8Lla/kdcdqZsYDuCViLoeDWHekM2XeIENXCT
 qhotfhr9H+GnWOHVWNEjVsgcJXW949HnrDER6yHVw19tlj8UERBLT0GRKi9sSa0ffFyh
 q9PQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpKwlBhcB6LFeAdJHeMKkE534YqQpCUosrPAfapGETPNB4To/LPMvxHiqqJMI6uhYdEZufhsMU=@lists.denx.de
X-Gm-Message-State: AOJu0YyoJGZwzse6i2PFvY1FQ0NvJGwDdm2MP3Ov7Fw+NqIVVS4arGG9
 m6KEQxIXx5Dqkt4K+jhZUPg7aXYcUb6oDhxJWaRzPGy2IRt+exgbUyyMRKtkJdM3bs8=
X-Gm-Gg: AfdE7ckT3yEPQ2P2mrqG+npzM6pleJdzMZKfK+dzxcULGRVPgQX0dhztmJBfEr66a5x
 aL/hfnmnTpt7E+e83Al1K3UhY0gfQ+LCMG3CGTQFl5J3olixJ2g0PFX4MXYRHzEL+Qo9e/6QrPy
 mt/Uduw7h6Rf9dlFWuuXyvzJIf3xnhWH1BxCCk/H0KLMOe5BXiJoPsBJT0urFNwvzB9Oq7djDhB
 xXSLylmdZFjwCXVGA92Iv2N9HQX4qD1ZsEh2+KsyzYE79Jxuw+s86f07FmvS3YgOUWOnSHj1y30
 SzFxL1+Z30XSqwYUiM1zVdy92lyF+ywh+z2D5d7kejYSfVg7N0YL/iZXte455nQFeMhfSNAwLoI
 44nlCHfbquTf4jQk+TajO5nAdiTyAivsIfMsiwIB0j2tTxzH5ZmZLMChjzcFnxBfa1U5LQhIacY
 WJ0BdwO51YwMTwOjfRll0qvE+JuD5cWjkq4axUPkBb2rIAGnREyshCrDE0
X-Received: by 2002:a05:600c:a42:b0:493:e983:806e with SMTP id
 5b1f17b1804b1-4954a3ee98emr218234975e9.3.1784632940652; 
 Tue, 21 Jul 2026 04:22:20 -0700 (PDT)
Received: from localhost (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653687b2sm72141525e9.1.2026.07.21.04.22.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 04:22:20 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 13:22:18 +0200
Message-Id: <DK47KU0R1WUG.1SFYMAO1PAA7B@baylibre.com>
Subject: Re: [PATCH 4/4] doc: board: mediatek: document Genio 700 SPL boot
Cc: "Ryder Lee" <ryder.lee@mediatek.com>, "Weijie Gao"
 <weijie.gao@mediatek.com>, "Chunfeng Yun" <chunfeng.yun@mediatek.com>,
 "Igor Belwon" <igor.belwon@mentallysanemainliners.org>, "Julien Stephan"
 <jstephan@baylibre.com>, "Macpaul Lin" <Macpaul.Lin@mediatek.com>, "Tom
 Rini" <trini@konsulko.com>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Julien Masson" <jmasson@baylibre.com>,
 "Johan Jonker" <jbx6244@gmail.com>, "Quentin Schulz" <u-boot@0leil.net>,
 "Marek Vasut" <marek.vasut+renesas@mailbox.org>, "Vitor Sato Eschholz"
 <vsatoes@baylibre.com>
To: "David Lechner" <dlechner@baylibre.com>, "Carlo Caione"
 <ccaione@baylibre.com>, "GSS_MTK_Uboot_upstream"
 <GSS_MTK_Uboot_upstream@mediatek.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0
References: <20260718-ccaione-upstream-mt8390-spl-v1-0-1256b6dfda3f@baylibre.com>
 <20260718-ccaione-upstream-mt8390-spl-v1-4-1256b6dfda3f@baylibre.com>
 <7ec5f838-e62c-4a35-afaa-8320901cd8d3@baylibre.com>
In-Reply-To: <7ec5f838-e62c-4a35-afaa-8320901cd8d3@baylibre.com>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784632941; x=1785237741; darn=lists.denx.de;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IdAAxQyZLy6ZHTnP/2mDT3kHK7wRq0a7eofCCrrSWBw=;
 b=S0zFwGTrXWyNJ7Iu4GyQPkSZFseCCIQF/NhTWwa06TBzru7NcwgwaseOdDmIWSc8FW
 hMizqykShaq06LY9Wk4ymFtCThPWEYcvP4H2BCGuCE0t9IycPUnQstF7I9A8V5nGXhpW
 rW2RvAvZcDQGP+IZaUDJNQiwhKnEObRIVV1YcRjvEKYxddvKx3EIKo++azA8Z+jWFd06
 U039/9JtRGtwEv0F21ElsgjjOTS/qpo6X3Xqy8iSiaXxgqETclLatoZIiIez/DXDRGY2
 8FOpWN/4OGypJqSw9Hy8X/M5RalPUedroZXS6Owzlay/yVLaq51J/PVKc+HH+u3/CFpu
 2nCA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=S0zFwGTr
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ccaione@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="S0zFwGTr"; 
 dkim-atps=neutral
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
From: Carlo Caione via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Carlo Caione <ccaione@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue Jul 21, 2026 at 2:38 AM CEST, David Lechner wrote:
> On 7/18/26 11:16 AM, Carlo Caione wrote:

[...]
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e5b2a2e373c..116a7fe3423 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -421,6 +421,7 @@ F:	arch/arm/dts/mt*
>>  F:	arch/arm/mach-mediatek/
>>  F:	arch/arm/include/asm/arch-mediatek/
>>  F:	board/mediatek/
>> +F:	doc/board/mediatek/
>
> This is no longer needed since [1].
>
> [1]: https://lore.kernel.org/u-boot/20260617024105.152655-1-marek.vasut+r=
enesas@mailbox.org/
>
> I can fix up when applying if nothing else comes up.

TIL. I'll fix it in V2 that I have to send anyway.

>> +The MediaTek Genio 700 EVK is based on the MT8390 product, which uses t=
he
>> +MT8188 SoC. The board is configured with
>
> This doesn't sound right. It is based on MT8390 SoC. It is DT compatible =
with
> MT8188, but I don't think that is worth mentioning here.

Agree, I'll remove it.

>> +``mt8390_genio_700_evk_defconfig``.
>> +
>> +Boot chain
>> +----------
>> +
>> +The normal eMMC boot chain is::
>> +
>> +   BootROM
>> +     -> external DDR loader
>
> What does "external" mean in this context? Proprietary?

It means that that it is built outside U-Boot and yes, it contains
proprietary code that we cannot redistribute here.

>> +``ddr-loader.bin``
>> +   The MediaTek DDR loader for the board. The input may be shorter than
>> +   ``0x4b000`` bytes; binman pads it with zeroes to the offset reserved=
 before
>> +   SPL. It must have been built with ``SPL_OFFSET=3D0x4b000``,
>
> Inconsistent formatting. Should be ...
>
> ``SPL``
>   It must ...
>
> ?

I don't think I follow. The phrase is '... before SPL', SPL is not an
external binary file, it should not be on its own line.

>> +   ``SPL_SIZE=3DCONFIG_SPL_MAX_SIZE`` and an SPL destination and entry =
address
>> +   matching ``CONFIG_SPL_TEXT_BASE``.
>> +
>> +``BL31``
>
> Why is this BL31 instead of TF-A?

Because BL31 is compiled (it is) TF-A, they are basically the same
thing. Is this a nomenclature problem?

>> +   The path to the TF-A BL31 binary built for MT8188/MT8390. It is load=
ed and
>> +   entered at ``0x54601000``.
>> +
>> +``TEE``
>> +   The path to the OP-TEE binary. A standard OP-TEE v1 ``tee.bin`` imag=
e is
>> +   supported. The FIT loads it at ``0x431fffe4`` and enters it at
>> +   ``0x43200000``.
>> +
>> +These binaries must match the board memory layout and its firmware secu=
rity
>> +policy. Place ``ddr-loader.bin`` in a directory which can be passed to =
binman
>> +with ``BINMAN_INDIRS``.
>> +
>> +Building
>> +--------
>> +
>> +For example, with the DDR loader in ``/path/to/firmware/ddr-loader.bin`=
`::
>> +
>> +   $ export CROSS_COMPILE=3Daarch64-linux-gnu-
>> +   $ export BL31=3D/path/to/bl31.bin
>> +   $ export TEE=3D/path/to/tee.bin
>> +   $ make O=3Dbuild TEE=3D"$TEE" mt8390_genio_700_evk_defconfig
>
> Isn't it redundant to have TEE=3D"$TEE" since it was exported above?

It is, thanks for spotting.

>> +   $ make O=3Dbuild BINMAN_INDIRS=3D/path/to/firmware \
>> +         BL31=3D"$BL31" TEE=3D"$TEE"
>
> Same here for BL31 and TEE.

Indeed.

>> +
>> +   $ make O=3Dbuild mt8390_genio_700_evk_defconfig
>> +   $ make O=3Dbuild u-boot.bin spl/u-boot-spl.bin
>
> Do we really need O=3Dbuild in all of the examples?

We don't, I'll remove it.

>> +The standalone binaries from such a build remain usable, but the packag=
ed
>> +images contain fake external blobs and must not be deployed.
>
> How is it usable if it can't be deployed?

I use it for testing mainly, I'll remove it.

>> +Using Genio Tools
>> +~~~~~~~~~~~~~~~~~
>
> Probably deserves an external link on where to get genio-tools and pre-bu=
ild
> images.

I'll add a link for the genio-tools. About the pre-build images there is
no place the user can download them from (for now), they are currently
compiled as part of the yocto image / distro.

Thanks,

--
Carlo Caione
