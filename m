Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F02C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 18:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D843E8033D;
	Wed, 15 Jan 2025 19:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BP4I9+3T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EEEA80657; Wed, 15 Jan 2025 19:29:06 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C75E880214
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 19:29:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b6edb82f85so739485a.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 10:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736965742; x=1737570542; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3c4yYZa/hfH09UQVyq1tSeQtALb5nLAi9hdezjC2PEU=;
 b=BP4I9+3TtQB7HyK4jZdZ/hoB9Zc/osJMoQOu+JJ3n11ZA0SS1b957YyYi5P2yjX3QU
 eLor0OmtL6SdJGSCE/VBo3pmP62xxG8IzIXojZ1YhpF5lgOFlaLb5dO5WwEjfQle6SuH
 uD1D+JmAiK4eUwhnw8rK0cUBuJ4KQ6FbV8nNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736965742; x=1737570542;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3c4yYZa/hfH09UQVyq1tSeQtALb5nLAi9hdezjC2PEU=;
 b=qmLpq5AZh/e1mGzPv2OkarsH/0hxbvZScCSGRCVSNSSaslgWr81wFa+1jPl64n92Vz
 Sf21IwfVk3twTbsj9q7XtAHZb0+rc5POSxzrU3rQNVXZOxVtQhnlEw9bB6zYzjkNgqXZ
 GS6Uplqb4ag9tD0hJWOwR4nOwdBUo+bSP2DELZf1no2Ft9hMeUX9H3FEBonBqC3dPqaG
 rzyulh6PbauVT54vak3y/bQrGOPSUmoRecnjBkJsydJwReuOUO06Zggj7aDrY1u8NzN6
 A78iTRTDa7/nMOpTr43mSxIuGhZuWLOFciWANT4niAbPGM4SBJW5xnJ/Tlbhv9Rxyn0H
 E7ZQ==
X-Gm-Message-State: AOJu0Yx3HAysP9bmd5qKC+Owu0Fg5kIsZnZ+zpVCkvY+bD44jTXVPQfg
 BU47mkJG6jn6mEl8l0O6bkux0ZG3H+clep6k0qg65kXO+BXAncVPn5KFlqrdKA0=
X-Gm-Gg: ASbGncsrxDtqFp6gVa1sWeOeK/6i90mDdPMN0rKUIfr/nSgY9RfKe18MaQEaXHYz2dc
 oUcxenjUPGpc8XxzUEMkQjL1hiHfnXwx5IF5J2suRVakL0pHQ7/PcyKcETa1+oHnbBqamuussxL
 x9XnQt7wR06aoZf5+Gd8HhDPTrO+m9uDZNyg/stcRG8SYyuvNrN2n2178qIzxp+dsVNzFSJojR/
 eCWL3xME4DpoFcOFwsku8VezDpQRpf3U9snmZlQVDdweQy2ik/m3g==
X-Google-Smtp-Source: AGHT+IHcq3tTh4nTKudQSvc19PFwC66m5OSHBhSj7SglYzvch8db9+T0UPt8kO95Y7CEnAd2L0JgkA==
X-Received: by 2002:a05:620a:1914:b0:7b6:d76d:3bf8 with SMTP id
 af79cd13be357-7bcd972908cmr4215757085a.11.1736965742669; 
 Wed, 15 Jan 2025 10:29:02 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad9aec1bsm67047146d6.55.2025.01.15.10.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:29:01 -0800 (PST)
Date: Wed, 15 Jan 2025 12:28:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCHv2 4/6] blk: Make block subsystems select BLK
Message-ID: <20250115182858.GB3476@bill-the-cat>
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20250115012322.215243-1-trini@konsulko.com>
 <20250115012322.215243-5-trini@konsulko.com>
 <8d0713c8-06bb-48ca-badc-2bd752605190@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9UL+fkT7LijOCcQS"
Content-Disposition: inline
In-Reply-To: <8d0713c8-06bb-48ca-badc-2bd752605190@cherry.de>
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


--9UL+fkT7LijOCcQS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 06:51:28PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 1/15/25 2:22 AM, Tom Rini wrote:
> > The BLK symbol has a few meanings, one of which is that it controls the
> > driver model portion of a "block device". Rather than having this hidden
> > symbol be "default y if ..." it should be select'd by the various block
> > subsystems.
> >=20
>=20
> As just replied on v1, I would have liked an explicit mention that yes, t=
his
> diff doesn't include a change to PVBLOCK symbol, because it already does =
the
> right thing.

I thought there was another symbol or two that was correct. I'll add
something to the effect of "Symbols such as PVBLOCK which already
select'd BLK are unchanged".

--=20
Tom

--9UL+fkT7LijOCcQS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeH/mcACgkQFHw5/5Y0
tywpRwv/RMzF4qWTCRKJvGMz+/eM+7YzMAmKHJdhJBIdGEIFBnmocYON2QqN4rsN
M3lud4KMIh/57g6Ycg8K9WPVyFJv7FCM66cq2a0P/mcGOzWfKCCoPn8Msnv5XVXP
dnQoL9LGObQ/tuYhviAaJz2q6iTqRg6MNXJpVXlKtf0jpUG7Ty+ag11r74aw9S26
Lm5ZBolo9SMMmM6i6F3B4HKAvyiv96913HPzwLjUyfBxVPhBM4ll+Qsv4NYn+VZL
UWZzYu2/KSvLlxvlW3fzCoh8BQfHfdeNJFSzD3lv8nECusWM+9/bRkB8Gep8h23w
2ft82yqAR/FZx4zuB9RGgnhrviTeFfxGe6jML50sdT67S//+Wg5Q7uZ4PvnIU5I8
W9ORO86uGW2c48zu5usaodcW952NSY3HLQTQZoUMLWCPYS1lmu0X3kyRri2v1imi
6o3FsEFtTm3gVNNx1pJ9p3NNd5mHixfj3dl4UKcQ6mdUEB25nM2dBN6XQD5gbtkU
Ivx8De9D
=rOnr
-----END PGP SIGNATURE-----

--9UL+fkT7LijOCcQS--
