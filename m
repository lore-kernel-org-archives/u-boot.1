Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE5FD24477
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 18:37:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD4A7840CF;
	Thu,  4 Dec 2025 19:36:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qwqlQI7X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AB71840FB; Thu,  4 Dec 2025 19:36:55 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 659888409C
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 19:36:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c7660192b0so1126777a34.0
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 10:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764873412; x=1765478212; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7mKZB1ceN6+enT3P3guJjt0Iydcw/vbMeUTSpPgdxYM=;
 b=qwqlQI7Xk9HQGWfskBBq5fDso2GGPg1daILgmUze1ODqorlwv2T+Hjs0c0PbVwkHDQ
 oZrHbhcLqEHf5ozlOi+rTAu74Ik51Rl7cCtAxDRUUUC/8bGTxaPHGKcrMtKgjiSU3/sc
 ze8SsI4p7W3ZJoJno3UQz5DrmQJJ/wSV9kzoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764873412; x=1765478212;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7mKZB1ceN6+enT3P3guJjt0Iydcw/vbMeUTSpPgdxYM=;
 b=I7WZUzr7M3+EQZOp1Pxb9kWr7KLOoPWkFJt7ymzM/ww5brGhjawgcvASjoEyjz0pLS
 Ksgl6U0FzNBA73V7xUkqRkcQ0pjQxNzJmbreZBrgoltEIcTjJ2F43ZATxEf5Rmj5hcBn
 4onSst7uITpwCoyP0QqdZuepd/0BfwGOxbUEV4khPiYuKkQ1yhZBWQrke9CKctekAs4o
 fx9XnmSHQecic8HFp1fHb2RBj4ea3fsPbV6caSq33AhH6KW44EbAZgTRDMfN6uCxNrrV
 gHkkQCr/FKod+s4+PfMti9X/PG9GVMKAFEmb1wR9YQdTTgDwbao/B8TJoj/aLmT9DAjO
 avxA==
X-Gm-Message-State: AOJu0Ywvmce6UgC7pgKbWX1NUWBdnIo72y4Prfce2/fgmdSbswUnYleN
 ijnupQEfmcgAX6tV2DfDcMhvgDqD76cMj5fMJEhubdlnZAmylIorE3aaXnZrlKlCPE8=
X-Gm-Gg: ASbGncuGBmL2VNQLmGt4A/92UCuiM8mK1yQvAoWfu22lAYw2t718t61W/75uD5l11ky
 LK7cQA+DIXE6Cxtzbzk6ua4kG7kml1bZL6kRfcdYfJHL4tseIHuCRaA9ahe6IwkydVxGMw7FSw9
 yTpbx0OFaNAiryV81UxyOr/zp9WPvbEyBgdfQZ+0H1zvMN8tccEpCoWUyg5OxnHImQkhc3/9cIl
 jyGIf1pVyHqymL8TZzCAe6bc0i9r9CPl+KAMxD4xEkM2U63+xyIiZj06Gj1E2eT2/eq1kJzBtDT
 TFVuupwQOOGcHMOhnbfmrhEcrFzGgoIj3MCAbX6bQ//2YImnxRS8hLgjqx1obT9nGIfpcJpc6cz
 n8+YKGrCP/Xdi53fyvbBpLYVh6NMN4TIB3xaBwHYZaT0Q36ihMRLAXf8GxT5zeNPeSjIU4Pjs+u
 RGZ4MVoei3hUqHB98RCvmO60srJkLhYpXZ6apuou3YW9DmRXNafaXNigUfmfSC
X-Google-Smtp-Source: AGHT+IGtR8QkZGs3X2DreaDjWl38l6cAaSsuw9b85d9YUJtKgzFcFG9tGqh6WwdhNVtmQy0cWHu1jw==
X-Received: by 2002:a05:6830:6d83:b0:7c7:6cf2:b72 with SMTP id
 46e09a7af769-7c94da2cda9mr4292175a34.10.1764873411891; 
 Thu, 04 Dec 2025 10:36:51 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95a91d96bsm1961765a34.8.2025.12.04.10.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 10:36:51 -0800 (PST)
Date: Thu, 4 Dec 2025 12:36:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Gaynor <boundary@simong.net>
Cc: U-BOOT Mailing List <u-boot@lists.denx.de>,
 Simon Gaynor <simon.gaynor@ezurio.com>
Subject: Re: [PATCH] nitrogen6x: change maintainer
Message-ID: <20251204183649.GB303283@bill-the-cat>
References: <202512032047.5B3KlGos008394@simong.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P2Vc3ebxYWT7WP5N"
Content-Disposition: inline
In-Reply-To: <202512032047.5B3KlGos008394@simong.net>
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


--P2Vc3ebxYWT7WP5N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 03, 2025 at 12:45:27PM -0800, Simon Gaynor wrote:

> Simon Gaynor shall be maintaining the new maintainer

Can you please rephrase that? It feels like you changed your thought
mid-sentence.

> Signed-off-by: Simon Gaynor <simon.gaynor@ezurio.com>
>=20
> diff --git a/board/boundary/nitrogen6x/MAINTAINERS b/board/boundary/nitro=
gen6x/MAINTAINERS
> index 17018d69f64..c7355b0e40e 100644
> --- a/board/boundary/nitrogen6x/MAINTAINERS
> +++ b/board/boundary/nitrogen6x/MAINTAINERS
> @@ -1,5 +1,5 @@
>  NITROGEN6X BOARD
> -M:	Troy Kisky <troy.kisky@boundarydevices.com>
> +M:	Simon Gaynor <simon.gaynor@ezurio.com>
>  S:	Maintained
>  F:	arch/arm/dts/imx6dl-nitrogen6x.dts
>  F:	arch/arm/dts/imx6q-nitrogen6x.dts

For the record, I reached out here because boundary devices is now part
of ezurio and this platform needs a new maintainer.

--=20
Tom

--P2Vc3ebxYWT7WP5N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTHUvQAKCRAr4qD1Cr/k
CtsLAP9JOamhei5jHHhTdphj5bFuNodihvgq1sEfXMrFOfeHGQEAymZDg+uGf6un
FMUFgmzZjzfoIzcQ9/v8aNgKm5hSMAI=
=kFIr
-----END PGP SIGNATURE-----

--P2Vc3ebxYWT7WP5N--
