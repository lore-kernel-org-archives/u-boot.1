Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D33FC982D4
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 15:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70FA78309A;
	Fri, 16 Jan 2026 16:57:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZJ3BjYJv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0945C833C6; Fri, 16 Jan 2026 16:57:42 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D490083015
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 16:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7cfda2de4efso1589572a34.3
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 07:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768579058; x=1769183858; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b1ZgmBydx6Rwz9k+36JWFJC3rgTGx/nEDpN7TO5s/Qo=;
 b=ZJ3BjYJvCAraAUKizZxK3LvhlvML+faKxI5kw4nVoCcCy7ZgtTO/ZB0KVU87HKvIVO
 Xhyty8DdwBTd6+cTWwK4fo84hg4/UMY7e0/4mMa14snBaS4FmN41Fp5rlUVSFpf6zB8V
 Sqm7T8uvG0UeelAEvYLo1D8+yE0FPD6w5Iq4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768579058; x=1769183858;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b1ZgmBydx6Rwz9k+36JWFJC3rgTGx/nEDpN7TO5s/Qo=;
 b=gw/FVty1PNJxwl8BBepISf/NBA+vwdhRj5GFv0RYxv4WO20sxIne4r0cqgvRviMBAj
 ljOdTTEkdlhOvxaPMhRnnzyeHuVUq38GX6t2+OsX01L0ecpvZxowCqyixtco+ehixtnB
 v3jfyzWi9zy/6pBM/cGxGwZcmXQgtB13g8u+5jlvfAG8/xtB+H+7d8qmQ5EN5YcjYBZY
 IT3wKqawLMo3vY3hsLrh+L8s0mTQJ3gVwpJ30+FgFnV1UPOVkL9VtZXWsLDmkPs3ziYj
 P1K9bNPQ9xg5Qivmt4BBU3Kwsp+zegZil0/o/sU1+JNxaEG99C7N6ohS00tqW6QrwbH+
 24zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJRHPnHgFrzJ3f9kb+BCtRWKBeqLZqRKJKYVf18GZ1hW9Q1QM1HpoZmB2f2UxbfUEDOVGrE3c=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6NWmMfRzUWRm6SvONE5p4P0RZBpkGg0yDwy39sxwpp2GsZSFA
 OYjVPW5PoZ1bkpD1jvNELgrKvB4GqZLzkoZGC1p8PmW4K/UULJPHJR00n05Ai4MbmV8=
X-Gm-Gg: AY/fxX6/jY+H046OOndIU89P40cUFn4Jm+Mp3fs3cUQXKSp76IU8Q1ESp/21rwVJo3K
 BEEINTypzftIcdG9o4JjJP5u6ZZisS9Yf5mXSs0eqnX1Z3C9uHitRWCiuWD4+EBe3T++bHi3BsV
 mTEjoJHI5jhMIrWqxo06oLeqaSlXPJ+npa1MWooWkN8YUAwjQaLNjDQthU1mpkcQ+9UM54CKdTm
 b8XMbXG4g8aSoUZ12g/Z+m9Ud5u5LPnZleYNBvGGPi0/77KhAcTvWoS/fUqGDcn84qVHLOHv8IR
 6ijuZd9B6zyZbkm124vEHwcaCf55qd/FeDWHuCEtU3JlDbqF7sfet0Rmnei0dJISQ2V305dFGt/
 lgy7lEi2Wiz28HD5jllecIGhym6/h06MP38z1h3XMm1Ipq0Yq/UAeeU+T0yndQtzCN6v3kQYQfj
 jssrOPLPLCrM+c/66OlTZI8SiNxZEmNUrhvRIwFFIg+um+0UkoX60lPG0pgrPjNL9zWm918U87I
 CciMRMu5rTvECgbVoDzMokgwqkcS7NHTevlO8c=
X-Received: by 2002:a05:6830:6507:b0:7cf:d0f6:135f with SMTP id
 46e09a7af769-7cfded34512mr1664481a34.2.1768579058492; 
 Fri, 16 Jan 2026 07:57:38 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf2b57e2sm1882803a34.27.2026.01.16.07.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 07:57:37 -0800 (PST)
Date: Fri, 16 Jan 2026 09:57:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: neil.armstrong@linaro.org, casey.connolly@linaro.org,
 quic_varada@quicinc.com, bmeng.cn@gmail.com,
 andrew.goodbody@linaro.org, u-boot@lists.denx.de,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH v1] scsi: Enable FUA bit and remove per-write SYNC_CACHE
 operations
Message-ID: <20260116155735.GA4063961@bill-the-cat>
References: <20260105052526.593017-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aRtSFPo3K4VOfLrX"
Content-Disposition: inline
In-Reply-To: <20260105052526.593017-1-balaji.selvanathan@oss.qualcomm.com>
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


--aRtSFPo3K4VOfLrX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 05, 2026 at 10:55:26AM +0530, Balaji Selvanathan wrote:

> Enable the Force Unit Access (FUA) bit in SCSI WRITE10 commands to
> ensure writes bypass the device's volatile cache and go directly to
> non-volatile storage. This provides write-through behavior without
> requiring explicit cache flushes after each write operation.
>=20
> Remove the SYNC_CACHE command that was being issued after every
> scsi_write() call, as it is redundant when FUA is enabled and was
> causing system hangs during large sparse image flashing operations.
>=20
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

This introduces failure to build on xilinx_zynqmp_virt and others:
drivers/scsi/scsi.c:85:13: error: 'scsi_setup_sync_cache' defined but not u=
sed [-Werror=3Dunused-function]

--=20
Tom

--aRtSFPo3K4VOfLrX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWpf6wAKCRAr4qD1Cr/k
CojtAP4r4ZBLbJ8OUPrjPEJ6iJvnwMyZg3UK7fCP3VnxOo2ELwD/Zx7QbQNdd5xo
VwJTIRkv3hTFCttqaOh7NZqgra0zNQw=
=X1m4
-----END PGP SIGNATURE-----

--aRtSFPo3K4VOfLrX--
