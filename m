Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A5F606A325
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oWUzyY9z;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Hprbg6aG
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF69E4094A;
	Tue, 10 Nov 2026 18:25:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u5Uqil8t3YKh; Tue, 10 Nov 2026 18:25:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 079204095C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794335135;
	b=oXafKToa3CWWUcGV0JJ2x6trX9wR36epMT/LUxAvsnhkLuV4UuUofDuD/JvKRxtYuGTv
	 U9CRs8DmfUDGrh+MZJzA1TcYpWXUTpvLZPiKjyY9tuqHk7I5zq25PhqVjNmI6d9QwA79K
	 Z1Tyoc/Jsuzek4NZ8RQbvKipZh9Bqujp23WS204jfQhuUF4ycBHhIDUB62MEhPlzzIcCX
	 eSEVXbgvMeIKb5OUvmVcf5jno5DXJT4pJFDfv3L8W02EwpaJM/cZSRms3BomwDyoKCi47
	 m1dL/fn88U3+w4E9DCPKnXy+9aiSHYokTSlZio5/bmzgyv1Y4Ju9ofrSA72MmED0ZSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794335135;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=AGACt8zzRRgoPG40rtkymMKuPU0CfvAHwbT5+w6y1k4=;
	b=ZxN8etWwdp+cRxGI8Li8PmazPqbLmifRgANqmXFkApoOVXqjE5jVEn1r8twDLJwen7SS
	 Qa3aJVsRfJd7z1lFTpnPcQHaZsCqrgF/uL/ESRmxc0thWu9nYElJcPnjJd/iL3/JfPpgZ
	 kuvRJev1owoooMM5zs5a4pGcazY+5F+Jcu5N+Xpcr+or9WOe7fLRQM6fiUDRXlbyP0hsy
	 2YW9seqYDUUrF7HJ8fJBBxKrp3PLzjJX6MFSeJ6lr2u5kH9Fx+CCIGaEMGYRU1e7IemIW
	 ZFgYLIk8UeMOcZIL2/I4UsizLrr/hJ3Z6zBdgY0HDRA+8zSNJSvmeBjhQdP/gdOSPbQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794335135;
	bh=AGACt8zzRRgoPG40rtkymMKuPU0CfvAHwbT5+w6y1k4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oWUzyY9zao7cmz/FjTMCrkWxx85njKtRhg4Y0MY+LvVE0Jh1B/hyiOK8Rp49a1uR1
	 KkjI74jQQOgIve22StRIjEcumKbqRKtEbN6/oQeg73kldM7h+Z0zQz1V7jthEjSVK5
	 UvFYlXii3gVF/gEbQLTepe51NeosWHfbwqC2ApgIkRZ+90C6PyKt7FWhZhyIjsHYGR
	 R7s2dcRT53SXUWfmVsuv3yPE0osdvzaBm1zbC4W8ONk+6pswkmzwYQu4ESQUxZVqSH
	 Etp0myrnMSKjy0rkNJ7B513jbBw6r/D+8ZrJw5x/j464ZxyrfHxyes4TqWkKWIHlRK
	 Lud51IjqkU/bw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 079204095C;
	Tue, 10 Nov 2026 18:25:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D63D28C
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 18:25:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7EDAB812CE
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 18:25:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 03qkZhnOLaAo for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 18:25:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 82A7D81259
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::3"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::3;
 helo=mail-oo2-x03.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Hprbg6aG
Received: from mail-oo2-x03.google.com (mail-oo2-x03.google.com
 [IPv6:2607:f8b0:4864:31::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 82A7D81259
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 18:25:31 +0000 (UTC)
Received: by mail-oo2-x03.google.com with SMTP id
 46e09a7af769-8459f7bc7c0so1076727a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 10:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794335131; x=1794939931;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AGACt8zzRRgoPG40rtkymMKuPU0CfvAHwbT5+w6y1k4=;
 b=Hprbg6aG9cHWQ6GP3Z2hhr2hMW3zEKrV0llQZq9pGqy9i2+yMdb+DSVip9p6OjyHZw
 BYNDKW1xdpZs9VES4+2t8vLrqzdcXcm/6+vtGGmw0XBq3qJgb8NpsCPAyU7ZITZvY7BW
 BzAYLA7A2T92KBpKbKklCfHlPjwOKNeEXVQls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794335131; x=1794939931;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AGACt8zzRRgoPG40rtkymMKuPU0CfvAHwbT5+w6y1k4=;
 b=la49iqYE7k4g9mvCK5HvunhxtYoeVd9gTLWSvmmvc1Kni4K9Z28Z6FsFf4LypsCKe1
 LPEiWFl1HLeiN5Qpc4rqA0zdTm9M+R7hXcQrNKeiF1pz8bMJmrDpHj0UqCzDwrTXQYL1
 O/eV7l+CNUIINO9fxj2FFTcZbu0j/CQay7Okl7GHsNLvKqJtVmKKxEk1mPIBBxOntMzw
 Xn8L/sNdm8ZWYKqZg/TXH8k7eWkfd6cZDGPp7TelZ+04JbtrB/Gt0Sc5OJV2baaTu8K+
 SgJsqbT11XS3EDT9sb/iucU0q/2A3bf4zm97FLnIkCO2IUGO5IjIpy/Ni2FXPIa2Zaen
 r08Q==
X-Gm-Message-State: APuU4Z9PNNF0bcjzht1gaXu63NePf2IcCQrZf5LWWKmlKzxDB8R2wH8j
 elX3jiip85IZCcVmTXz5QFZqzx9tSD3awT2tXVikvAOLasDEjdbizrPNZtyeD0rFD7k=
X-Gm-Gg: AYBFou0BNvE02uLJlCRC7/sTdopaaVWswUHEc1jMJuYuJf0MymEg0RczRQupPqnVixA
 4TnSWsXnYwM7lKQI5LkWfmv+KhA0LCpt3q3V4ZUjaJDWOYWbWp4oI8UYHKDpp1HSRSu8j6YCc9D
 YAf7YlilLNxboVUFNVvpQonUst1zpHPExpD61hhSiDJtXaYOdoAyAXqUspIi/MZ/qd46HccKxon
 CCq7LhizuonhkF5jdPJBUIVEXo2OXffn/3/4DgN1K6WjH+bAxo9SEmLnC+w4Y4ounRL3ebD/yGp
 d2PgaXnuUg08RW53pYpm/miN9TIchCu8YDyDjopUup1eIb8/UTu+S3QKnDg/S5NCqtaju4Akg6a
 nerhx88iiYG/9zpxnU3fu+oXfHmt2coARQ3S58omouc6ya3n0HgBBj/QhHBKpR9Gi3cGrddgY50
 GTzABILS5ARySJIb+zTV+SUjiNKHWo6N1+ERy9wOgd3nEIUaqKtD4bcjWH75AC5b5lZOPCIO7mM
 La3s0wnCZFtoRQ5Mmsg3RnuK9fLxnG+o74Io2MQrRMs6n4PVGS0gyvd+2928pdv4vATSTZs3cw/
 fao+JteN9kXAcLHUCH05Asg41g89hrZhTrBCXAeN+2xjv2G6cNlOEfjlPbUb+jwdJNldokKq7yr
 XeovIqpK5M00FdG7FAbcoI5Dg597xH5pcOdEhwMs5JOTbhY17+imfLtaI4tj3EZh7TiuQthPfk2
 FlvL6Ml3DctchlVS82zaz4M87FcRpVBaNW
X-Received: by 2002:a05:6808:67c3:b0:4f4:d914:8603 with SMTP id
 5614622812f47-5683c946635mr2746897b6e.15.1794335130815; 
 Tue, 10 Nov 2026 10:25:30 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5690504e7dasm2723656b6e.5.2026.11.10.10.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 10:25:30 -0800 (PST)
Date: Tue, 10 Nov 2026 12:25:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@nabladev.com>,
 Dan Tran <Dan.Tran1@synopsys.com>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Guillaume La Roque <glaroque@baylibre.com>
Subject: Re: Please pull u-boot-dfu-20261110 into main
Message-ID: <20261110182528.GH3741582@bill-the-cat>
References: <xhkdb7bikx19l.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f3GBDv1YG1Wnl7rq"
Content-Disposition: inline
In-Reply-To: <xhkdb7bikx19l.fsf@mkorpers-koolstof.csb>
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
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--f3GBDv1YG1Wnl7rq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 02:29:58PM +0100, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Sorry for the late PR. If possible, I'd like this to be included for
> main especially the SuperSpeed patches from Dan.
>=20
> If you prefer that I split this out, let me know, I'll do a separate PR
> with just Dan's patches.
>=20
> Changelog:
> Android/AVB:
> - Add Guillaume La Roque to Reviewers
> - Update libavb to AOSP 1.4.0
> - Use U-Boot's SHA libraries in libavb
>=20
> Usb Gadget:
> - mass storage: Add SuperSpeed descriptor support
> - dfu: Add SuperSpeed descriptor support
> - dwc3: Make Set Endpoint Configuration macros safe
>=20
> CI job:
> https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/pipelines/1=
985
>=20
> Thanks
> Mattijs
>=20
> The following changes since commit 709a97a05df66e394f40d249105d0baade46f1=
07:
>=20
>   Merge tag 'efi-2027-01-rc2' of https://git.u-boot-project.org/u-boot/cu=
stodians/u-boot-efi (2026-11-05 07:58:42 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git tags/u-=
boot-dfu-20261110
>=20
> for you to fetch changes up to 0e3fb22a5b2e330bd73014f0ced13f5df259d087:
>=20
>   usb: gadget: dfu: add SuperSpeed descriptor support (2026-11-10 10:00:1=
7 +0100)
>=20

I don't know why, but b4 pr did not like how this was formatted.
Patchwork is fine, however. Applied to u-boot/main, thanks!

--=20
Tom

--f3GBDv1YG1Wnl7rq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavNhmAAKCRAr4qD1Cr/k
Cm50AQC/m5o8Re6fM6FTekH/Ts+XPEQB+KAOCkHHg1x0wJz65QD/TR85r2Tz4LU4
roj9/tR0OUBPec59bPvCRL+Tx9HlLgM=
=SACr
-----END PGP SIGNATURE-----

--f3GBDv1YG1Wnl7rq--
