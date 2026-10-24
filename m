Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F90D606A31B
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 13:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZODtRjNS;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=eOJq9taG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E17B081842;
	Sat, 24 Oct 2026 13:03:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lra6wYWIjBpN; Sat, 24 Oct 2026 13:03:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 42D7080D49
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792847031;
	b=ChfJMa2S/JL8koVYgyDTC7UTJ2DPs66BsfcE42uhRY+IWcrv9G+TC4RVDT/MmLZsdQrR
	 n1RT5ye8bqL4rDweXOg9XiEtkZlLpTUsxls6OJzTqs2nPE3FwavAJ1lt2BSnrON7+orop
	 LqjMVZu1iHVV0+8qoy278Lbg6el+Slch7VCqWPRe/fd56MYMt9ld98rsCzl14RiFtllt5
	 QnVUgonmCHhucAXtSwRdB98pQd0JmPfV7GT2SVIzrzSM25lwHSqo2jfXAfxhP1UU8z+ip
	 KOXNi8a3f+UeWOPRq/H/pr2+diVKYOYVNGVFH6Wr3XGroNR2FXGFMmzG7JPWs3veLFg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792847031;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3Fn3pmbaMbNU3a3N5xfNHw9M6LK9Ej60IFrkgMie9QM=;
	b=Nzzn8U58Rpa/AlU03MHvM9HxilnVxMCTUR5ppdUv5TOliK1623QzjGca++HnM9w+SCQ5
	 Y2LCrPxt2G6sDzMUXHeh6R5hbCm+SyEEwkjqwvWO6vez1M0tT5qYp36opkcAjkO0OEAUJ
	 NNvQKwEjrL8jGvOKeviJhd/zZELtT0zb3jX92RF+tqezSAC+0CRq/eMJhSJheMP/JoIEG
	 GAoDX/yVaSlBvxe0p7fY//hc0eorg/bvvUxei44+5Y9SqF6cw8jY/GM1M0Ptu//4rD62Z
	 gf+m+ZLHuuFGWgvLENacgteosaBuS63slpSGo1VxJlZ8i5GZwGcZiO4GnKqmsnivQ0A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792847031;
	bh=3Fn3pmbaMbNU3a3N5xfNHw9M6LK9Ej60IFrkgMie9QM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZODtRjNSGbkVkW60Vts6qRUOpcn00toAUvg++bUl0k+h6Daf6fUzeRX7AbZUfFjBl
	 +JjlOqR1rlW4mEep0vdTZWTg1XENRvWS0nvje3OpJbKy39mwwWQ1WX+agEpQUFxxDw
	 u6Lb8YMr+rbIhoTOBbUVKNg4GfyDbwBYo5BbINBeWmE623viAA6i2Y0KssmeyXroKs
	 yYr62NRVaUm+2GYYSS8NNEEC+fgrrKDRiuplJ6jj4eEW2bXR2BuOAYbrBTAqSCnJGe
	 jF3Q7UkBGiYS2vQk4jPdX2r01cAyJ5HaghdGka+D7l6cR+HOk03JUi+Acg9AsYvZoB
	 xAmf/6ayho/VA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42D7080D49;
	Sat, 24 Oct 2026 13:03:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C9859356
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AF36E60A6F
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mt3-6gGg1psX for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 07:00:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B69DF60A59
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792825245;
 b=dtnI3mnNQ9pbFa2Vc1DW5epFcCE1mQ0gvqJS65E+jYwWM7SXr26c/Sx9TgyAQQYZad54
 9GmZk2+MB5YMmQ5J+qmv/6b5XyBwFVS3NZQx+VVfycppYAIDpqR+YDxtEdsI/jEQCQ09j
 lxOGRz3N6RwKcdQx+ZzIAbyBpB11WGHk679eYpidu+zXvkKC+gFyhOMZsPaKqCedFWqzd
 ZF8dwBQbRsgGEu53NHmnQ6+a38pFCr1fS9zyHDaMQ88kyJcOWmugP4Xn4Y4Z7G6mnZcmH
 +PkHi+Vqsl/b0mdJIbo5jX2KrFdG4Xwzkq8ydnXi5OhHrB9eG/g83O7PRcZAvbc1Zkw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792825245;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=3Fn3pmbaMbNU3a3N5xfNHw9M6LK9Ej60IFrkgMie9QM=;
 b=BucFSq8wRQVRSFIVJ7Qqs0iRspO6Bm+y9i+DwTW/gSA4WNSrC+aZBsMB52Ovb/2nW3Kb
 UlgZnjoxm6Wse/SIeV3DdpHZVDmzKVhLWBp8TYQoSnFaCXR87kNi8wtWwbjpPd34Ni+i/
 wCacZT1XVDG/LxbVnHoTB1NoHZMspt9V6J90p2rvMd5JHCO9k+QtlI4sTMeO2cI8kbkBW
 AEagSwtxCL5sqIUMHN2rXynKMOY87JZZzcy5iu3GjxcdsMP3aodTzYSTKa0FBAIVjZCD7
 7sGVT7Yy06sv+nvlEJ2WMWMb4FWshqkHQUgWkPUYAYv4mzq/S4WMM9ZxsHT8J5UwsUQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=eOJq9taG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=eOJq9taG
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B69DF60A59
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:44 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c4677aad67bso171315766b.0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:00:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792825242; cv=none;
 d=google.com; s=arc-20260327;
 b=nZbvP1bLbc989/fhIPLalOqITmSU/x1INrDeE+18YgV//qNYqDc9uSqLE4i0MI/zyK
 HOJJ2t1nFVf/0nLBdt60Q4X6ExDud23MF9y9/YyiYcGPyNugsEc9LzZg8Ks+iV9nnv97
 OBIWliSL+wxj376Y79jyj8rLVULVbBMTbCikTbIXY+GWd5g/k9MDfyFTJ3SZeoDbPyys
 rrHVH7yTrZeyvOuixofYVheM40gxRhKF1KRRZ3Ccv5ygL9bACkBL+bbOVrSM+YA4BOmC
 Ie2gpMLDGwq9w8JljqmgtASf5AmhlFTXPdSxjsx0OVCTBcyZteB/4ks8AwdM5MITi/+W
 t3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=3Fn3pmbaMbNU3a3N5xfNHw9M6LK9Ej60IFrkgMie9QM=;
 fh=K3qBHk2ExO+3ijmhm2JLE5PguYt4WNVvCbTK1y2ofoc=;
 b=OpPbgR73zYiaA0Q+Q7QEZbxHtyr4EZtq0q2DzPkVZSDs6Rl+hxUkdwYhbjaRe01l1q
 YP9EZyRNw7jPOjKB29/d6XYyuyq9nZ4sQykk0d0RIo9iAj+MRfisghRP/flF3AnuTBVK
 qr+Olp3qPEd9VBzW/CWicOYV5xTG52dYYnOk58jGo6qE+LgbN7XXyyNpeghf9tz9cZHC
 Sq85Yd7kbELSx7QoaTOFaHeLa0ze9U/VHKVwib7/EC3rNFGegj3uZfvvdJ1vrR8DUqI/
 u3cSJWsBgmOKXy4fJaiU4vp1nyrhRpWKumBqT/gW6nAQN2xPmAhzCCeLfEL84dNhfopq
 w7/Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792825242; x=1793430042;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3Fn3pmbaMbNU3a3N5xfNHw9M6LK9Ej60IFrkgMie9QM=;
 b=eOJq9taGcxh+WzMBJfqXhwX9P2sOxoPGp7l99k2ftn4dTum5xl9rlC0ydrAibh3Wm4
 3rxIA5CtAshrmQVisYVmhIdzPv+CdwGi2JHj6J0TY2pHKmyjVLMpRjhjM/QLq11Da5zS
 mP/hlO9RxqHcSFHVT5e18jfwUtxluwOCoVFoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825242; x=1793430042;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3Fn3pmbaMbNU3a3N5xfNHw9M6LK9Ej60IFrkgMie9QM=;
 b=0B1qj+lbkiA7rKciqLiBeN+3Qrar0fl93EC/chh/aOjaSrA5jwYlOBMRgrPkE9Ip1z
 P0FIemfsL4CMSw5z9Rhm/9ZS2fu6XaU72GAuIA+V3pp+pqcTE2PYzCu7RUugcfoGbP+p
 IAqx9r4MTbF9BEecgOhy234RdEv5M+ulkifHdW1ARUC3cZRwh5m4lYs3kcUY8+HSqEFs
 IcpPZzDsIbMO21ZI+pkJWHOH5zYLKadCCWZJvFI+/ITVT6dRcjJqV5/xu+vMRq+mDrwM
 GdrHeX8G49290nMoqSWKfedw8ZsSNUrnBr+2kID+LyU1inhrwJoPSObANSJbDNW3qL53
 f52Q==
X-Gm-Message-State: AFq9FYKMBh+dDVVROFnqqb8KMO9sQL23V5mGUcfYUo86w7W/SmJjVbwx
 aAakwEnxp2vetua92RlFTYreIXvcK7lfCE63sRkqEM6X0n5IcsUFqcCiYSlsVwbLgXXWrVKu3cQ
 oRGQeYpUweLFaHGN+MKPBKgHTVENk+MjK9IDD5x+tWZYcEk5vM2bJig==
X-Gm-Gg: AYBFou0ZmB0QfTnHZAF9D09FDyp0fINrOTF8slaEPpURigSYd233fArkAg1oq6+AQ0Q
 9Vv44Fk6oyMYUVtCdKp3zuFnf1R3dbc6DBkGBY8Bp31PJaxT0GZikkPa44OxfPWavmCRAxvpUFq
 RN/pVF3X/oTW/smzyPPBi+gKQZszUgt28KUflqJBkH8IErrYIU7RNYQsqtJULzZzBKzc6B7Yaes
 G+7BxoVAo3X2DzR0KAE+jxM5sx8ZWMM+036xbrfjU3aZ/XwOtjokRIso3TKmDD0ZyLezStwkciV
 2xuW/8YRxSoCi3MM4CzKb9dxJujYcMky67Q9N2MfwJw/aY+SZPxO5byYGpunWJHn8laE/7KD5Ad
 Sj/lxeI8sh3rMem+uEnI1LJVZhY16aBpfVEDZWWWLpxzzMwI1GOMCy7Kq
X-Received: by 2002:a17:907:9345:b0:c2e:7e0a:572f with SMTP id
 a640c23a62f3a-c46bdde4623mr100099366b.21.1792825242328; Sat, 24 Oct 2026
 00:00:42 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 00:00:40 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 14:16:36 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-spl-fit-compression-v3-16-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-16-6647aa23ade5@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 Oct 2026 00:00:40 -0700
X-Gm-Features: AclHuK88UPYGaz5Dfbvd7awMG2c5Sxym09u8-aBUUdhh-Oy1OLCDNts-9ZflBqc
Message-ID: <CAFLszTgn8goEGvxYrsd6tL5+S4d-CQ2sazhud6xBsO+FjKkRmA@mail.gmail.com>
Subject: Re: [PATCH v3 16/23] test: spl: Cover compressed FITs read in whole
 blocks
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Max Merchel <max.merchel@ew.tq-group.com>, u-boot@ew.tq-group.com, 
 Petr Hodina <petr.hodina@protonmail.com>, Bruno Banelli <bbanelli@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 24 Oct 2026 13:03:24 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexey,

On 2026-10-20T16:40:47, Alexey Charkov <alchark@flipper.net> wrote:
> test: spl: Cover compressed FITs read in whole blocks
>
> The loader tests which decompress all read single bytes, so external data
> always starts at the very beginning of the buffer it is staged in. A
> loader reading whole blocks stages it from the start of the block holding
> it, which leaves the compressed data part way into the buffer, and none
> of them covers that.
>
> Load each compressed external FIT with a block size of 512 bytes, so that
> the data starts part way into a block and has to be found past the start
> of the staging buffer.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
>  test/image/spl_load.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)

> diff --git a/test/image/spl_load.c b/test/image/spl_load.c
> @@ -1590,3 +1590,50 @@ int do_spl_test_load(struct unit_test_state *uts, const char *test_name,
> +	spl_load_init(&load, spl_test_read, img, 512);

This only works because SPL_UT_LOAD_OS happens to select
SPL_LOAD_BLOCK. Without it, spl_set_bl_len() panics rather than the
test skipping, yet this test has nothing to do with the OS loader.
Please can you return -EAGAIN when CONFIG_SPL_LOAD_BLOCK is not
enabled, as sandbox_spl_load_fit() does before picking 512?

> diff --git a/test/image/spl_load.c b/test/image/spl_load.c
> @@ -1590,3 +1590,50 @@ int do_spl_test_load(struct unit_test_state *uts, const char *test_name,
> +	ut_assertok(spl_load_simple_fit(&info_read, &load, 0, img));
> +	ut_asserteq(plain_size, info_read.size);

The other tests call check_image_info() here, which also checks the
load address, entry point and OS. It would be worth doing the same.

Regards,
Simon
