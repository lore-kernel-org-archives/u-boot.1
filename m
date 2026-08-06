Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27CEC56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 20:02:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C3946065E;
	Thu,  6 Aug 2026 20:02:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qvurfUKkf84H; Thu,  6 Aug 2026 20:02:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B3B2607B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786046521;
	bh=SqBxM+KG9OKz59Y/658GHxWhR0BeBAByoQ3Khdgwb8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xou9OjpjP9X0d4z1hGWoi7E0NEGNfzL3s5K3bDhMPRkLWDk6ozj5IPNpWm0ttBD3F
	 0ngW+f3UOwQYv7uPKh1w5+i/CnBm6U1tSK4Q1BI/OQmTC/riGjYMjeiDc0LveF8L8+
	 JTt9pUTOftOsYdJpf+YtNf7cUmgEh3sGqDcugSKAMrKA5ihYmTNbAHKhPatZ8GRF59
	 5Tof8yBKyPVh8jzqYaG2WTBmuKCRvlq8TS5+6xBylMUZhJW9khXo/kIyyHFPXN9z3R
	 H6IW/U8v/U2JPXi7JglVqIluQ0c8P3O1t3Rt2fHKjk5JhuIEIBZerYYVv9ZfyYNuyX
	 H9dtRhif0q9sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B3B2607B4;
	Thu,  6 Aug 2026 20:02:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A25523F
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 20:02:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 43AE680D88
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 20:02:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RDfpNW-kKlF3 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 20:01:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::35; helo=mail-oa1-x35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 39E7080D83
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 39E7080D83
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 39E7080D83
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 20:01:59 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-451d8064238so1658660fac.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 13:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786046518; x=1786651318;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SqBxM+KG9OKz59Y/658GHxWhR0BeBAByoQ3Khdgwb8w=;
 b=RawGgPxj2kx+G2VCzyGs771l40WMbwTgc6UPM5iRZnedSKKAyJSxKELP3rgK/u7AJX
 tWaL2TjSmxMzKue+WOkZAxeAOTpNfLhZ8+6cHtmfH8213p5XqfcAPLoribIvKncMASZl
 /1zj0Kp/uasnWIY67dcgE3nZwyj4Ix0GySoiHa3oIGSDNcN0ep7atzFocYAgUxVXHrP1
 ZdOoeyPptZEwPWtRKAwI8ysEPtQHu+TrbgJ7ioOIt/95A0Pp+arX1XXhYDcidBfx9AmI
 HGP840GYkD6/+EZf/aFxT326k6yTczAbFMlPB40n9HxahH5dSbPumO/8GRtpW+mOqA2G
 W5Nw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqpdphTf7ke3WGfywceh/0QpKVLCBWMf6fjjnvUmco36S81+OdSKODpOn71yVExIAHvdcZMRr8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyncoPpBr5+47UhW+Js8Y0evzItSCixsBfNfvn+G+PY+sHjslt0
 LPR12b2VwsoXkgJfbUH1G81ERN8eij91wRby/F7rnCKsN3Sdt9ILXpPrMwkpSGKyI94=
X-Gm-Gg: AR+sD12uOU2UBQK/wHUUbRhNZcG+GWfMeS8+HZX6GOTrSx5xHzOGkaJpCWz/VrEuWC9
 f79aPU3vCFylQlponCkMCPvCnE+ffGUqD//Z4YJCbJIqWkOrqeUA8m2Bqr2cYUJQ9VRxwvO9Yr/
 HiR8USnjnNg2TNXQsWhj5rgxBLrK7gLsp4yYqQ8kWrguVmlIOMQ30jV7quLHHzr9253WkU7Hkzx
 Crra5HBFuwkY/i4r+JiLO4X1V/ttXS9lC3M6fjRg3Z97dCljnFr9gu0dUfJrauPU3aybhJo1jRu
 5iJC17QwezoGNa7bMmq4/QjzaOgPfPKsusXwdh/nD0zVkojVqLugklUEVR+D2eJ+bQNrd3etpi4
 UHxJRGdtlGQHLs64/8krmzoq1JDJwLVGvvEWmLlMp54tBVG7tN9iR5C8PPxuea2sLpeR4WO5/Mu
 rmz802evk5QLL6ZJxuPhGo8rwyr1TnqLFSYXWtyORX+QWSh3TsRwWAr/1SvKEeHkrFzwELBz2hk
 nvCu7WOuc+A1M3+4niIUinu2Ewou7y/Yd7OoC2bnI/ADv4cGQf6mfFsuv1c1oFdjVw+EGK08o1g
 1mYj6FZsDw==
X-Received: by 2002:a05:6820:4c83:b0:6aa:2fbf:bf5b with SMTP id
 006d021491bc7-6ae9709a761mr9910533eaf.35.1786046518044; 
 Thu, 06 Aug 2026 13:01:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02be8ede0sm357340eaf.12.2026.08.06.13.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 13:01:56 -0700 (PDT)
Date: Thu, 6 Aug 2026 14:01:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: Simon Glass <sjg@chromium.org>, Raymond Mao <raymondmaoca@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: merge software ecdsa support
Message-ID: <20260806200154.GA165443@bill-the-cat>
References: <02ea1132-9adb-4f07-b14f-9648a61a8021@softathome.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gN0XEWBFOb7B07fu"
Content-Disposition: inline
In-Reply-To: <02ea1132-9adb-4f07-b14f-9648a61a8021@softathome.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786046518; x=1786651318;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SqBxM+KG9OKz59Y/658GHxWhR0BeBAByoQ3Khdgwb8w=;
 b=hB1XLoSWuRDJh3GW8F/V3UUl58pYwhNGfJ0yIh2LvJvEQ+gvSJwY2TbYiAHk8QxZyP
 hdevLtJ4TVD5Cr2/qRlxTV4GCFEFZeDiX7EKvovNaERyQTd5j1s5x2PWSAiZOyhImZMp
 Z3W3JOs3D6GFDhLFTL4xSRRzFcjVTT2SZ8ieo=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=hB1XLoSW
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


--gN0XEWBFOb7B07fu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 04, 2026 at 04:29:47PM +0200, Philippe Reynes wrote:

> Hi Tom, Simon and Raymond,
>=20
> Do you think the support of software ecdsa may be integrated in the next
> release 2026.10 please ?
> https://patchwork.ozlabs.org/project/uboot/cover/20260601134310.2452454-1=
-philippe.reynes@softathome.com/

At a glance, it looks like the feedback I gave a while ago about having
it be enabled by default in some config (likely sandbox) so that it's
actively tested and compiled hasn't been addressed yet?

--=20
Tom

--gN0XEWBFOb7B07fu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCanToLgAKCRAr4qD1Cr/k
CgNnAP0TZsD7feErrI121d9JvQWcL416mdMxoILdjQdE7l+BbQD/VmdAxW/vTKdZ
DBVIHdfBieGoKUxpjq8oad+T1Z8Rhws=
=6KsH
-----END PGP SIGNATURE-----

--gN0XEWBFOb7B07fu--
