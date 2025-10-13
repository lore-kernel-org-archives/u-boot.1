Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53660CCD183
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 14:45:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9B2F836EE;
	Mon, 13 Oct 2025 16:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CrmB/GBQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0383C836EE; Mon, 13 Oct 2025 16:45:04 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C066835A2
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 16:45:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7b00927607eso3156320a34.0
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 07:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760366700; x=1760971500; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0rmu+ifciPCKyNk2saaVSgaYbmQ5U76fqT3XRSZnhpo=;
 b=CrmB/GBQIoeE88+JS6ZEdhvDv46ZQgd4dMEef2I2CDed+V5a3Z9kb+l1q0+S6N7eoa
 2cHd5nDCX+fN6CiXWIhfBurmTuwe3IIs4wIvg1eTuF897TukUfle0EEYagFV+2GuIMjg
 EhEYa+utlwCHIAo13++iD0xIE/KVwJYeyHeQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760366700; x=1760971500;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0rmu+ifciPCKyNk2saaVSgaYbmQ5U76fqT3XRSZnhpo=;
 b=rCd4JVE9xfakZ02nSAGM/u5tO/xG9EHnCJ1541qTxHx+2nE8iN+I7IuSUz8EdmWRzh
 6lQBFoGw+UFxamTM3ZLOl63m9d8EaWo0F/W9SjFhNU5M/OlKnFSveR/ggIrP/txiDGfO
 lVMrkLPPVtulaVk91B+k1jH2/XRwg8Xbxev4+B8DmTfb06ggwaVykcOt3Sr5RiXy7xhh
 tqEdridwhq/lFPMc9lTdzThVc+mSXxaq2ARHKRfPpqh+FeIBm8dOl8V+o2vmFusAEOVP
 0ms0LtnE5zud8OQ2+un+QNZtYAYI+KKJoCPnMWKo6QkXD2MwRkBIg/yV6e9NbXYNskyT
 caWw==
X-Gm-Message-State: AOJu0YyPMFpUBn+9+9GRWZ5Hf3nEjU/odx2evAr5/xW7rDa+ddeR+VC/
 /7rKwXWyyG/UR72FWeSDQMdAI3czCEh+MvYUWZqV1jhVlFaCQ34y5d0lKBJoH1guvtE=
X-Gm-Gg: ASbGnctiPG1qZTfPCailIGbwPU1D3XBQQQLultfe4i9+AYTwwM1Uj7H6lLl3jyoX2aQ
 XNQVFaKi3shWogNi6v8jC6wOkP9jQBSjV2wvyl7sHgl94+CtOHHsrBC/4tiibEjeeELW2CSSkLY
 AYPgwe5npCL80JNMeAjgB+MUnG9JQ4jNew27vJZMrMbTl9nH/VivJDRL94VmOJ6L5u3j6ctXhDp
 AxO4Zu56AkJSSliidsuY8INMN4Zel2Dlm4mxFtOB1PQwm7JKw9fERGw0GuBCdgp9YCxpt87OljW
 wGbE6ouPTrrHQqAfmkAhnS5YQFFlDAab04aimU4LBd/U7lxDHgGx6yJww8JpTMwzfz333QqoeA5
 4bV6CR8RUUhvLz6Qj37YyBX1j9V9FvNnnuju+m3As28BJHWqpFBRovvPtY1Y9ubXxXVqN0DV3ot
 klC/DY
X-Google-Smtp-Source: AGHT+IHWpxjTFWVfpnehwQrt++V3KcTCH7A+7v/AvDSW4hkK0+jjUAAiBY+oWdhWNa/I4diYQ1lBHw==
X-Received: by 2002:a05:6808:13cc:b0:441:8f74:fce with SMTP id
 5614622812f47-4418f74201amr6403762b6e.59.1760366700190; 
 Mon, 13 Oct 2025 07:45:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-441cbabde5esm1298432b6e.7.2025.10.13.07.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 07:44:59 -0700 (PDT)
Date: Mon, 13 Oct 2025 08:44:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: gitignore for mkimage files
Message-ID: <20251013144457.GH6113@bill-the-cat>
References: <CAGm1_kvA1GohbO-=+oC6q0p3bnEznvSZ+ubFGmWz_c5prMSWPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9RcnwB3i8RYoxV1M"
Content-Disposition: inline
In-Reply-To: <CAGm1_kvA1GohbO-=+oC6q0p3bnEznvSZ+ubFGmWz_c5prMSWPg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--9RcnwB3i8RYoxV1M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 02:02:36PM +0200, Yegor Yefremov wrote:
> Hi All,
>=20
> after building an image via stm32mp15_dhcom_basic_defconfig, I got two
> files that were not covered by .gitignore:
>=20
> mkimage-out.spl-stm32.mkimage
> mkimage.spl-stm32.mkimage
>=20
> So far, I found only the following entry in the .gitignore file:
>=20
> /mkimage-in-simple-bin*
>=20
> What about adding such an entry?
>=20
> /mkimage*mkimage

Sounds reasonable.

--=20
Tom

--9RcnwB3i8RYoxV1M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaO0QaQAKCRAr4qD1Cr/k
ClUFAPsHb9u3eFWybczhIyaFFbjue1yC5n71neopd3BeeGdEjwEAtJOgFsZ7joL9
NMTxSFq/xEQlTeobuU/SO+EODQS8UQw=
=RwqG
-----END PGP SIGNATURE-----

--9RcnwB3i8RYoxV1M--
