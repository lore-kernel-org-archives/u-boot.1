Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3546C5AD55
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 22:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07040607AB;
	Mon, 10 Aug 2026 22:01:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HlGnwovH78FT; Mon, 10 Aug 2026 22:01:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B69F6078A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786399298;
	bh=1V50HGzzLjRcRp1e/mpAcWrokpAiPVCVnoyAcjii6QA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KibFDx4HP2yeTYlQWhhvzZsDSlMbJ9iEIBApNNivMfAU5UWZDPQZ6m9jh/2ckn/kg
	 aBvE6DhhUH5EKOd5ZYm1QpP/Hy7rXyyL8F7hOszI84C4oyftgFULFjc6B9daag51+5
	 8aP1IJdhyLksRTZRHdBlUaynZBqctu3DaRN1OPsCrek7tWCe/q4B93IRAbD5lZIqTJ
	 pN5e7rUnp+o24218xUIWqlxjMhdqIvX1AXjowZvTdx2I7wVGv/ZHUfGUY6XWENzEyZ
	 DsbMg1emlU/iMEHpuVV3d1wWLFFSSGOcKXi+ffNrzyroxQSaHS0FKjsO9VsDwgGFhB
	 s9g8KBUswCnCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B69F6078A;
	Mon, 10 Aug 2026 22:01:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B597F198
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:01:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9F55780F05
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:01:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 33d-NtEPeOOo for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 22:01:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D604180F03
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D604180F03
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D604180F03
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:01:35 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7eb63dbd229so268140a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 15:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786399294; x=1787004094;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1V50HGzzLjRcRp1e/mpAcWrokpAiPVCVnoyAcjii6QA=;
 b=n6/eyURWcZNojjIHBpsOHnB8sjFX4gLKHS+l6n71BQUbYD98NDPMuu4kAM70KNdahk
 aEAVcX7134a+I8VQkzjNJJb1K6ZTdC1nfacs226R41QfRScrRgXod7GWzgkyGtKqNo0Y
 gcRN9iDhw462gKfdVZ2qnfy7uKhg5dkfCrBEtGESjYcPBfVVY/99pmAaUeUR+mnvQlu1
 KJZjiKfyFAbsMa3y7O1nORDDrWMf5ZdThij1BAVCvgwNv59Uu4MVDJDIyRHDf8R0PIk3
 7ceaA2Uo150OQ0yAdPVDoStt2iLaSe2vv7BxQkv9FB8iMMJKRjNgnwOu2Q2LJGFYvVDO
 IXZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYE3/4gpzrKzH1E14rMTwgvlyAJ2FHwM7CDAv7rAU/j6oC0GazhZxYOF3AcKug8nwEvWF06p4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxYoOlCpcVmVvR2LhSsY3TN0jbNOzr84pcXg1US3DEbfBx7DDdJ
 SQfKna3uSGA1qgC/S/UxeTzgc+PLKwZPPty1CqNBKECUJIZmhB9R6Pc8j66LbLvvpc6VWLuG9IF
 doLQB9S8=
X-Gm-Gg: AR+sD13M3T1Q/jC3uZvIKMYsuAAxiFrzyi2KxkqpqA5yRgzLOiGxSqbe/BYyUS3JsCc
 792CqFdT2IaJjaKlBNhdGIuycV1Sr8fquTPSWpY+z3V1K2IY4EA9NFtGiVzDugbyLFn9Sm0IWI1
 YBfXdTNQsqX0j3PIxQLJojRNgVpU4xEiHRCYSNfmRp2/ANi+kp19RaN1GVzoWgXLbY8I86hq5KR
 bqApMKoZChTofwVgvAGTa/DkC6BDrYbSiZfxb++fzdzxy8RBPw96rQImStQwkm/V3iZ9XL1F0Be
 XTXWIdKxCQeKACk5EV9oVuQbswg/I8zBLgvWxf29pJCkIIt48ZTYPc+PsL/yl3UE7zQ0t1EUVn7
 ThvMSWZa9ynxknLZ8kKOo9gKPbn7XWiCVwl7xMPfkmHsvCQkRWDlv4ESrU0AQl9olQgQk00SIXi
 +ywlXrgy/8809aXZaiaLFgh+6o+nEgMR2gLdhylRWAbXWHrWe/LxL63lI5iGzW3Pj74k9cO8WKR
 C4GZfxr+Au7+JlJaow2xtZTGxFwfOUJUIVG6xNW99kjoudvTf3Dw+Dc5qMEyHYy7WckOcE4ZjJX
 NxRMp7etmg==
X-Received: by 2002:a05:6830:6d9e:b0:7ed:ce16:7d72 with SMTP id
 46e09a7af769-7f3a11eb128mr414448a34.5.1786399294630; 
 Mon, 10 Aug 2026 15:01:34 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f35b76ff85sm7904035a34.13.2026.08.10.15.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 15:01:33 -0700 (PDT)
Date: Mon, 10 Aug 2026 16:01:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] global_data: Only include driver model fields when DM is
 enabled
Message-ID: <20260810220131.GF1160436@bill-the-cat>
References: <20260810204828.2836359-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CGD0+OFWWcw9P0+R"
Content-Disposition: inline
In-Reply-To: <20260810204828.2836359-1-jonas@kwiboo.se>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786399294; x=1787004094;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1V50HGzzLjRcRp1e/mpAcWrokpAiPVCVnoyAcjii6QA=;
 b=Xm9skoNLbHsWIq1vGse9xHtieNO1cHvG1GfsSv6eMu52+7kYdQhAwAtQUx2pDgW5WS
 ZXBYOXW4yKLljbpnGAx3H+u0c8mNbh0l+re2o9vCEjo22Vn+x82CMPNFgOgDb7k6m9gN
 5MUh+xQyhpVF1AuPfRAEeVnSEvRig8Ia24fhc=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Xm9skoNL
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


--CGD0+OFWWcw9P0+R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 08:48:28PM +0000, Jonas Karlman wrote:

> The struct list_head dmtag_list, struct udevice *dm_root, struct
> list_head uclass_root_s and struct list_head *uclass_root fields in
> struct global_data takes up 24/48 bytes of memory on ARMv7/AArch64.
> However, these fields are only used when $(PHASE_)DM is enabled.
>=20
> Guard driver model related fields using CONFIG_IS_ENABLED(DM) to save
> memory space when U-Boot proper is built with DM=3Dy and xPL is built
> without xPL_DM.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--CGD0+OFWWcw9P0+R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCanpKMgAKCRAr4qD1Cr/k
CqueAQDL1aNYs3keW4GZSaJfJRFYNArwD0UVBgZ5uePuKvwkkwD8DMwgiiV4Cry4
dgJuAVpdgIrPVCTvPBOudQbWnbY2Sw4=
=vW+2
-----END PGP SIGNATURE-----

--CGD0+OFWWcw9P0+R--
