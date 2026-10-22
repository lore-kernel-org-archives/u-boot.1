Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D8E606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QUvU/vCv;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=KLb1Bans
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72802405A1;
	Thu, 22 Oct 2026 16:55:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ge3BnFMRI-U0; Thu, 22 Oct 2026 16:55:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B37FC406E7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792688143;
	b=e9FPH10F9P8YEWaOa5gFgrtbLk2YOZiqPP8gOXAlLcdPl2HofTugGEQza4vpn4ML2fxP
	 Gvdn3VpFUND7YDvXswDAGfNBuHBgRDsaJuMPfWyiZ18q8tt7QqtIp08pv9e2lrLjssGGK
	 DckuPozB43zszODfFdOdHhQyQHTHzwptxyv8IJpcGql4j4LA9y+nm3YjzRzj2XbduI5Cd
	 iYdng1kvnImSLThD58F0knOT29gz6+Ik7aQ6WZLBguFFJk/+WtKrm9M03SX07A2kxcYVx
	 xELVVaxC5RJ1or5m0ZSZMDRB2mU94ZLNbg8IPxovjK/4bNqHVFG9af7RnkyqzmzVdTg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792688143;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ue3d/PmdQcy71EDyjtlPD7NibjVPdIaN9uXIWrx/uY0=;
	b=AhYctmfPMwYzN8F7R8GmOSheGM13x2Q+yB+zKEFPBoDJcKhRaBsyV+lsGs/9elkKvLUu
	 wH1AlrgJiPvLfghM/b5MPr3lCb/Q2H0I3zxFGthKIvMNuHRNIX/hOvIIEn9QhC2Qmk7hw
	 WpUt8XTkTJ8AOmKNoV3aV61HJ2/Wb0K04bn21+qsAEiGibBm89EFkftJUkymUmQZ4TGzp
	 9BvaU36Z2McfX0dCkQrLSZ1t+M/6yaHb6U02/9tIGod0Ltojc/1Y11nqvXxTKYBfpdO8C
	 5BaPdgZ0xM/Gh38rpOgVqjboTsuIjLmvzaxyXf6vp0JqpAz/M2rj02ekmnnc8dPIFpw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792688143;
	bh=ue3d/PmdQcy71EDyjtlPD7NibjVPdIaN9uXIWrx/uY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QUvU/vCvxLu87owU8e3h2BhBGSItexBbKFaR6ymwqx3MaHoO5e1EYnwwNyV8EekJJ
	 Q4fQ7BgXYUqfBFPib6IjJ8lmwOzRVwri687x5w9eQ2+4+6fHVCtXM9p5ZST98j7wGP
	 OGd2FZNeJJqV9/mtbl1csS1Se5bXt/VyDnTS18gTOh3cc8TKdC0L/EAZ7BC3K43tRY
	 SeC403p2px0qLR6ufR4cG69Rv8X+W4FFpaVnLLrq+X8AlAIH9CHZCdoCEjwpntJkbK
	 AUdkmktl9cOkIqhjnSPY4ynRt0ZeIjsNlhvKijk3LVgSkH2lmpu8zhK9xBr1955k+8
	 ncUwhPp88GS4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B37FC406E7;
	Thu, 22 Oct 2026 16:55:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9AF263A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 814A96069C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:55:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Aj7Y9XunWAuC for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 16:55:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C6D1D6069A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792688142;
 b=KEdCCjx1yCqysTy+B4gNHbFxf9tqqSS3mmyHQdE6he4Z+NMbdt/WBf5JtSXw7tkl8PR5
 cQhId1JzEoMZyNY32/qGQmJ10pGDC/2W7jPOnUXDltHt3frG9Rof3s6VoO3f+bBpPRKA+
 e8J6nnFhOQNX7TQwUzHiKO2rX3OIj9PNys6yWz7Lcm9XVZ+l8KatJK5ZhyK/4Kf/36pyO
 DHIMiSUcCI+Y/xU0Otyq9gWemF5dzOYlCAR6Izhs4goRZrjgF44nJXpNLWqLm78alsUoL
 S0u/n7MqEM/mO3L+MJoy+KQ4GXfVEQdSJQinNL23E5/bubDYICKUT8LvXuWhgh899pg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792688142;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=ue3d/PmdQcy71EDyjtlPD7NibjVPdIaN9uXIWrx/uY0=;
 b=hjnj/AZtr0XBV5uT0/UDLOhJLiI6sZ7iDB5DR6Z0URDMHM29kNVfWjRH0WjH90ozJYZi
 ME0z1TGXkIsFjO09Vj0nXwROdwZncYBPrqELMeyhoFqp+9VYuuToNQX4SpJ4sGDX9T5aW
 WgHJUEhZwl6Egbzq6QHDM6N7Q2J38BsDcUAHVF83NmGcMorPCPu3dlE67u9IYlmfCKWDJ
 KcKLPlxxTeQ7maDPuUaXgwmOamZnWwt6jHmcADkt7akxVetuxVWFG+dilU2KnceiOw/kj
 CQXsVozEWKJdPsfFFkG+qPCPWI8AhMCI40bLdX66VL9sLaEqdIRJ3jq1PbHhmXWfMeQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=KLb1Bans; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=KLb1Bans
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C6D1D6069A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:55:41 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6aa9606ddadso14751eaf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792688140; x=1793292940;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ue3d/PmdQcy71EDyjtlPD7NibjVPdIaN9uXIWrx/uY0=;
 b=KLb1BansbWO1FH654lv1RxoXZCCYO0wd0Bi88hoc6CQqYVaOCSjZpZAksUoRX+wsz+
 g7d5tu2I1ZlYb0U5BTzCjQrcGPWYEB4BbQRYwpBMTgSnFYeVZeF0kYfFOJjj0DGxrIRO
 3Tn/I2aqkMTm5ZxX22VRLPlB2gWieDRe6P/ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792688140; x=1793292940;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ue3d/PmdQcy71EDyjtlPD7NibjVPdIaN9uXIWrx/uY0=;
 b=lupKuFVVj7JYK9U/UpbvuULqiBIl0EihrgaMLWs8SwafrRqESf3ltktTXdCwQqF66r
 QJbLtIHc+P1X/BGT2jkPJMYDc6qTQBnVUqLdYcFb98trEQz1/X0XU9PpWCefTazQXN+y
 LgHN6J9oWWS5pXo27ehWOWNrLI8J7ldNqNkWG2UDp9YmTlY09ykzz+Ql2jUdh2EPyMt0
 kQCcId1rvdSbB1/alKaMnibySdlJjCG/YSxIX/wfhlf1rnlECz6cI5GTe05p48f5pFUH
 qjOaKGxNT/bH1wKJ9ob3MFJfv23naVcLpLS8lb7y9up5NxH5aJOYnSRNpYUNjfEmBHph
 n7DA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9T020FwClB91GyYDz0eHJVrneJq60/9eJB00jXX+o2wQ8wuC9Ka6w3Pm3rPR6MBZ3jtFsW7w=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKjyxoBIVeuXQ/NTr4F7QV9nbKreuLCtOclgzNdhEUrBKeuyZxd
 m9qmTf4uKcLXbqCdk3RCtlDQXhjE5oSI8Bpv1g31g0ogTd1j7/OuLL0BOFI0g0QCClo=
X-Gm-Gg: AYBFou1+KQXNFa9QZAUbWojwBXPh7oEtff5cAFk7nDtKjSOitI5vq+IZQ0wNvcaGOLC
 jpzAnBm2//jw1wHSgfJzz2b1D2/FB1QE+P1ObH6rrgA28FyMpPSmkzVRAHzsRZHHaTpSV2klzLw
 h3pQU2XEsbkoMiz6mc+ClvD8RHZn3scxa38KA7NBCHkjgsxv9mAnt/myoYkRZglMCFxjrFX6LYo
 r8pSTD7tjPN9MLK2dIq6oTdRtF/7H9ro/mvrw1qroGxOldKslbH+KmaKO9skoZgPcYlH0Kq29vx
 KleV+8sClZWYM7liYr6ZzE8NNK2Vwqlfa6TM4szaT1XxvxjwDCflcZmFguDLqZXws54uooCfsow
 EkIrTjopF/MnUcsYHOCHRkfo9hHa2T8HozeON4D49RMnTXE2OG5Hw/SZ+GvKjq8nn7hlDEVTZ5B
 VFCrw6h/6s0TAObud2VRMM8zegiCnQTBF0WWwuYr/Z2b0cwrDGcBG0Lv/FtkMdGmRMGjsVSKqHZ
 2GVdtKQRP4afQqL+VJQg/Eql7yxn0g6gNqi/g1sq1NwsH98rHF80zBE6hBkR1U0P1RPI+eW4wNV
 biFLlDSM3I/4fEZgq+EHVPa5p7imBI6yc6EC8HCAz4aaw4OmjmdwO4Oix9OMIe207e9dnvONtMM
 rRg==
X-Received: by 2002:a05:6820:1987:b0:6b7:8415:d790 with SMTP id
 006d021491bc7-70941c7d155mr3616394eaf.59.1792688140442; 
 Thu, 22 Oct 2026 09:55:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70a49e2e00fsm3019128eaf.2.2026.10.22.09.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 09:55:39 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:55:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 william.bright@imd-tec.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, nathbappai@gmail.com,
 macpaul.lin@mediatek.com, jbx6244@gmail.com, dlechner@baylibre.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v4 09/12] configs: add shikra defconfig for IQS board
Message-ID: <20261022165536.GD3621697@bill-the-cat>
References: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
 <20261021160916.3894471-10-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J415NQB/bMBIF+01"
Content-Disposition: inline
In-Reply-To: <20261021160916.3894471-10-aswin.murugan@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--J415NQB/bMBIF+01
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 09:39:13PM +0530, Aswin Murugan wrote:

> Introduce a defconfig for Shikra IQS board.
>=20
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  configs/qcom_shikra_iqs_defconfig | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 configs/qcom_shikra_iqs_defconfig

Aside from "should be with the board" comment:

> +# Address where U-Boot will be loaded
> +CONFIG_TEXT_BASE=3D0x9f400000

Is POSITION_INDEPENDENT not needed here, or not working or what?

> +# Shikra has eMMC only, not UFS/SCSI - override qcom_defconfig settings
> +CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME=3D"mmc"
> +CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=3D0
> +
> +# CONFIG_SCSI is not set
> +
> +# Environment stored in eMMC logfs partition
> +CONFIG_ENV_IS_IN_MMC=3Dy
> +CONFIG_ENV_MMC_USE_SW_PARTITION=3Dy
> +CONFIG_ENV_MMC_SW_PARTITION=3D"logfs"
> +CONFIG_ENV_OFFSET=3D0x0
> +CONFIG_ENV_SIZE=3D0x4000

These kind of changes being made repeatedly tells me that qcom_defconfig
needs to be split up in to a fragment of the really common qcom things
and then a defconfig which works on a wide variety of qcom platforms. A
general enhancement would be to make it easier / possible at run-time to
determine that you need to use mmc device 0 and not UFS, and so forth.

There's also quite likely a number of things which should move to the
Kconfig files themselves as select / imply, rather than be in a
defconfig itself.

--=20
Tom

--J415NQB/bMBIF+01
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatpACAAKCRAr4qD1Cr/k
CtWqAQCMRN8mX1FGrh97LKMTLAFjzXc8moGE2OydAi5NLCbt7AEAq12i+5ILHuIF
S98GC4oRYR0AyBj5ilDaXaSArXqigwU=
=weKu
-----END PGP SIGNATURE-----

--J415NQB/bMBIF+01--
