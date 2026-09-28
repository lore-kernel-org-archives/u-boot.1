Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5C7CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 14:35:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 262F240688;
	Mon, 28 Sep 2026 14:35:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tkIeKQ8_2t4X; Mon, 28 Sep 2026 14:35:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EA1A040621
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790606157;
	b=RgMNl55Tm2VogVnI81zufMRhbvmAeju3kz32Ek3/ILEJF16nceJXtI+/xmgHOFZIR9Uo
	 JBF5jzNDZ60/sXrMJ2dfUjq7tVZmh+SmWmma1gE/rcc2E2wg7+Sdi9do24/qeEwEES68d
	 dmPLE1/yzOVUj53P30kqeU5pp7FgX5h4fEYkJs/esjpoR2AEJabaf8f8POwl8UGx5rh1s
	 5TGHTsuZhLXJ2nYhvB7WzTzAe+BvEmyMD0kSP1kqCbebin0eb4uj5T8xlGMgqvIMXqG7I
	 I0pNkQEFpMIQsUXUgM5/JMh29xNGbegPoztbEzEP08np+m6mCBJ0jegYcW3kecCcJeg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790606157;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HBS8A5rZUQX89/FWQwj6u1TRadONj1EOmPgB+lCQavU=;
	b=LipkG/E7K4siHk7F8af7Yv+RhhRHqMulMHWLFoKzaN/v6hqU3FS7MoEgC4l7XeIvv7pZ
	 4jd73dm4h+I2qvFqhkxJLnrwkBsUHCFjX5WrstzU8YFZvxa9wNMbtq1uThhxFZP15Kkhn
	 F7wj31q2NsqxBFlPsgCoX3RRo9w5oc8Lcig4SnhFpjr8d/mYGJCAzzk/VNNZYCnjq3jsN
	 agrWlwgkUVacUiJVmMq1cZvRmahy2Jki8i9iINFPxOku9oGHuM0L1Mgw1t4jxmDtmExYw
	 saxC/3URfUTyJQ+ngpJbht1lC47CSDnprhotTdy5IxZhscGC+7dnWppuu0c98Zs7PEQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=eM9ntBHd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790606157;
	bh=HBS8A5rZUQX89/FWQwj6u1TRadONj1EOmPgB+lCQavU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aWbUYgR+JIOMLleGF+kfmGEwvboeYEQId5RE/zW/3GcKp/aFK2CFelOZRlSf8mXGj
	 L/ZL9H51wXNwwYUpsFbrF6R5jjfG5xK821If8/WAS10Tdce4AEsr3qycEsKFa7Mggc
	 IR2n5CVDLTFJVIgyl/FYmW736grGRrqDwxCoIVRsWli+022lPiWxWbpOFrF7JAhtY5
	 60HC9Phbdc3u6HEa3ETg9LZ3ohvLS9ilDfnqbViu27xcCBEi/sJoiUI2mZ+j8p8U1S
	 bIoGbvTLJaftYz4aK14nrfXDG44iPAKvLqJf1nQsAxE7K5nwnRxAaDR7gKIk5TsMTw
	 etFGMD+5Pmqvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA1A040621;
	Mon, 28 Sep 2026 14:35:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8298A2B6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:35:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 736A540621
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:35:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xy3WwHOOLl_l for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 14:35:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3452D40613
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790606154;
 b=nHk7udbKxsSgQrVHACyEGuUIUr/uVpXDEcH0pq+hIPBngrSSVvAqtx1J8fdYwE9PoEN4
 lJMaATO3LrcQ9RVTW6jJ3wpfAJhH/ADDM/e0+KiEiBqI+NNsvy/RRk08h/ySx+HHVPtBr
 0jxQmG2z21VF+7FhkgZdyunVrjrABHpr0KmvVdZj7ASgiz2wvCQCDWHMgZ/dZFkNkkXGJ
 U7XMWTuPyHtvu8QgtRLqY6frFUnehq5ZwVFUzsTh7MCoTV18Yjnq2ppurzJNpjUL+R9zR
 jhaTkBOm5Osqa/2w+KiT90DuRrRuZ2nhRcWGJfd5RynzvkvUtV2hkQAKHvgRZDWGvNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790606154;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=HBS8A5rZUQX89/FWQwj6u1TRadONj1EOmPgB+lCQavU=;
 b=Wqbi5ptPOD5AQtWxVjOP/3PDhZOd1EnbqLfq6nkOQiybozCc23QawTzHDPfsxMSNnN3h
 r5CB7KJXIbpT8020YMxbk5JxDajyRGqe/AS9najmMgkNh4QgGWPVPy0Oj+MRV2SvONqgt
 52rMv81IhArYYt9ItGMKlaOCiwaRjMUkE3GjXaOYg7dhtr+It1lOIiftLA3TWX+1SpuMs
 sMONANT8KNeXsmTzzFTurmQl2s16L9olFqhl7aDFXWmtqaPcrnRvMF0D/3vuH0C3E414Z
 JTIoGWMfaAWB2YkukH3E6TyDpAoV6Z4t/xC1TxNLE2t6ggU15In6eQVMvcUQxRwyRig==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=eM9ntBHd; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::f;
 helo=mail-oo2-x0f.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=eM9ntBHd
Received: from mail-oo2-x0f.google.com (mail-oo2-x0f.google.com
 [IPv6:2607:f8b0:4864:31::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3452D40613
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:35:53 +0000 (UTC)
Received: by mail-oo2-x0f.google.com with SMTP id
 46e09a7af769-81b36a8d5b5so923962a34.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790606153; x=1791210953;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HBS8A5rZUQX89/FWQwj6u1TRadONj1EOmPgB+lCQavU=;
 b=eM9ntBHdij4/UWHztp5mdLU1aOA1eAYQIAIQnBXtUVUs/l0ZdOnEXHWv/GxEHAkCQz
 jtK3ib5RhMuqpo8jxmSkj3yO0++UF36WVxqKc6O3xZGvqbbsXsGZ2hsEIZohxfG0CoN4
 T5EZ2b4yrMIovqRL8ky7nJiyl8G9NKv80au/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790606153; x=1791210953;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HBS8A5rZUQX89/FWQwj6u1TRadONj1EOmPgB+lCQavU=;
 b=qjUxN11rTzqUG+6rKs/xWCfaZD1maQ5wFkmAD3zvePnCwXmACMI+MtTg0joAMsgOl+
 D5xvCpCk5BA+sdUMLjGODPXf4OnyswIF+1Hn0j7n+/N+vBCVX02g6w2wPmEvM8V8yNhN
 RHoIV/LXtnRfy0V7IgNqQ6bl7iILOWa822bZhVbxeM6dwuI8ZhfJLtuAP3x8kb6PfhC/
 P80kh4o/GmNQu42I9bt70ZNiMVVE4TFiIlxugxNsrcawElk+1bYI+vnudYD81Vk0WBqL
 452lIu8LpMAExz4VERCSjSpYDDhqsITQr5VRrAlnSFFbuWO1Q7enJGOWTbiApdm9Wx/j
 7nJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBypHrC8mZIAHn0O90wZ7XWJL6+aMatRs+yx5g9zoqGc8Jby4o8zeIxxCTa/Lk3pW5kSx0YnnxU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lJLqiREdycb8Bha2O40mnbPm7a79APlsmJu3S1amJOISjKK07y
 NJ0GQKy2GimGrQIcnzNpISWzVCUAzUZNbcU2dpW/7JpVbUb44kIiGycavKeC4unerqw=
X-Gm-Gg: AYBFou2t7iSmnDThtJ2EgN3tj+TcrQZFIL4uLwCWQlTxzvf6qIFJZPFFssn+B7PrwJW
 u5AB5+F36HHCHDdYUIx6TfqOriNRonAOb2Nzh/SoCfL3eGCMqFNt12+d0VqVU55xhzWHpWBb5/f
 xOifvNQeW6iLuFWJvzRuoWSQpryxyg5V9sOWTGrmFCF1Qk99Pkv9Pa9F0rud7AWSKWGozsQWN6T
 gvxAWIPX2ZTf+Lo0uPdSb4DLL+udwaoh3eASMaGuI298wZOVDg9u1/i9/a+4LkKXbNDuGgDI5QJ
 KcRyoWjIsGV3bUzJPjy3I9/Xsr1IOeb+15fbXC3sBk4kecZzQzOYOnLLdl8b3qowJRsBOP3qdd3
 ovq3bQo7xxGkj1mzaK/E1YktxswUJmBwGCwIRIvBcyJYvImuePB8XErPdtIHc1HUphv0pB/TYHP
 e2Oq0FVKuGrAeifYWmLIZBJxOZ3nsLebHtkykWmPhNoICUVHaG+Pg0Mg33uUPHiDwxQLFkwrWQ1
 B84eTG1i5EYkt0sncHamFhS0dURT1twdSt24ch/Jf0pCr+KrMICPIg+cdn2F67LXynpstzYRSsO
 9xoylE/0A0zpvQp9AW4=
X-Received: by 2002:a05:6820:6ad0:b0:6d9:ec:2373 with SMTP id
 006d021491bc7-6d900fb6a53mr2914033eaf.51.1790606152693; 
 Mon, 28 Sep 2026 07:35:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d883395632sm4884691eaf.12.2026.09.28.07.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 07:35:51 -0700 (PDT)
Date: Mon, 28 Sep 2026 08:35:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Vignesh Raghanvendra <vigneshr@ti.com>, danishanwar@ti.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/2] Enable NET_RANDOM_ETHADDR config options for
Message-ID: <20260928143549.GK858934@bill-the-cat>
References: <20260925110758.843871-1-c-vankar@ti.com>
 <27a0c3d5-0537-45fe-856a-5f685c2f68d3@ti.com>
 <8a2e1e6e-28af-420a-8bf0-954d9bb6f9e8@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LtuLjwr79AXEQHa6"
Content-Disposition: inline
In-Reply-To: <8a2e1e6e-28af-420a-8bf0-954d9bb6f9e8@ti.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--LtuLjwr79AXEQHa6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 04:13:06PM +0530, Chintan Vankar wrote:
> Hello Vignesh,
>=20
> On 25/09/26 21:19, Vignesh Raghanvendra wrote:
> >=20
> >=20
> > On 25/09/26 4:37 pm, Chintan Vankar wrote:
> > > SK-AM64 supports Ethernet boot, to get the MAC address during R5 and =
A53
> > > stage enable NET_RANDOM_ETHADDR config options.
> > >=20
> > > This series is based on commit '9e002445cd0d' of origin/next branch of
> > > u-boot.
> > >=20
> >=20
> > Why not use the actual address allocated for the device via
> > CTRLMMR_MAC_IDx registers? I guess thats what ROM uses for downloading
> > the initial bootloader?
> >=20
>=20
> The way to configure CTRLMMR MAC in AM64 for later stages is by configuri=
ng
> "ti,syscon-efuse" property in CPSW port. We are using CPSW
> port 2 for Ethernet boot, and "ti,syscon-efuse" is configured for cpsw
> port 1. I believe we can't configure it for two ports simultaneously.

There's not enough MACs on fuses for all of the ethernet ports on the
hardware? That would be an odd functional regression on TI parts to
me...

--=20
Tom

--LtuLjwr79AXEQHa6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarp7QgAKCRAr4qD1Cr/k
CsYPAQCyPzwtEH7tb0spJAkcLcn1lh7JnayBjtSNtQOS7fXoJQD+PdvFfr8yNk76
41GEIQcHouHDKkhFxTFbFGb8J0Y4xwY=
=98kS
-----END PGP SIGNATURE-----

--LtuLjwr79AXEQHa6--
