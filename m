Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7C4C4167B
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 21:33:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F96C87691;
	Thu,  9 Nov 2023 22:33:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EFNzZnLX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25328876A2; Thu,  9 Nov 2023 22:33:55 +0100 (CET)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEB7B87692
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 22:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7b9ff6d89e6so566734241.3
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 13:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699565631; x=1700170431; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gginIYiiImSPvPofNfGz8EtssxQrFmHHeZoGWsd0aFI=;
 b=EFNzZnLXy3e6N2Tv8dyv+sG2L7rIoCdNCElxEPNzB756UBO3/nxEpmtj+4vHWwwLYY
 zsHgccbgmm/CLmRHfAeg0gCuCqhEMAErwZ+FwvKY4WDJ2nfFXyvk3Dw31weeNvjRXr/T
 VUoMFd0Qmbo3AqMMUZeiQTH3dpYdoyPdPGTyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699565631; x=1700170431;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gginIYiiImSPvPofNfGz8EtssxQrFmHHeZoGWsd0aFI=;
 b=B8J53iq3aR6W+eaauNto6e6RNXzbazdETNyOfkA9btHt1duYYtmkIvenHtXiNXJ0cK
 XB+A16GeLYQB/ddE72z/PwvfQFR9afL60UzeiZ83/NSLWI7w2fYRaT6U+fK3SGlKMtg6
 fpuPDVA/blF51IYGQqkaPl5WgosWM94uaBLRoPCeKiXynJcZTuuMt/Jn12oVnDOEvk7K
 Jvi+a0/g+ZFhV+1E+Mpnnn2F7bGl0n+ebuFWQGn11OvdfeRo09ejEQq2X4sLYghadtVe
 +P9sxWBzE7T8B4PphVZEV2LD/pI/UDR1DpPR5FDeKUyjgsZ0OhMCLDDnDQOQVM22cp/f
 ThXA==
X-Gm-Message-State: AOJu0Yxczmb6uCquNhTjSRTnqzeLZLvUbVfN4tHLv5lwbiMFJ96dmJm6
 qhdgfXKYEn59Ea0R11Sq0KA6fg==
X-Google-Smtp-Source: AGHT+IEqZ7f4ZQsCdC5MNwgLr42zQRIzRVW0Fstu11HA0t43ctUJCT89gGKLouBk0fRWWs5Faiy05g==
X-Received: by 2002:a05:6102:1048:b0:45d:9d27:215c with SMTP id
 h8-20020a056102104800b0045d9d27215cmr6022045vsq.1.1699565631317; 
 Thu, 09 Nov 2023 13:33:51 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-58a3-ea36-c2a1-60cb.res6.spectrum.com.
 [2603:6081:7b00:6400:58a3:ea36:c2a1:60cb])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a056214108b00b0067095b0c473sm2423849qvr.11.2023.11.09.13.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 13:33:50 -0800 (PST)
Date: Thu, 9 Nov 2023 16:33:48 -0500
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?Pierre-Cl=E9ment?= Tosi <ptosi@google.com>
Cc: Chris Packham <judge.packham@gmail.com>, u-boot@lists.denx.de,
 Bin Meng <bmeng.cn@gmail.com>, Marc Zyngier <maz@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Will Deacon <willdeacon@google.com>, Ye Li <ye.li@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 meitao <meitaogao@asrmicro.com>, Alistair Delva <adelva@google.com>
Subject: Re: [PATCH 0/3] Revert HAFDBS changes
Message-ID: <20231109213348.GP6601@bill-the-cat>
References: <20231027002409.430285-1-judge.packham@gmail.com>
 <20231027094947.bhtwngq26e3loya5@google.com>
 <20231027172237.GB496310@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S1dLDTc1TMY+O52+"
Content-Disposition: inline
In-Reply-To: <20231027172237.GB496310@bill-the-cat>
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


--S1dLDTc1TMY+O52+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 01:22:37PM -0400, Tom Rini wrote:
> On Fri, Oct 27, 2023 at 10:49:47AM +0100, Pierre-Cl=E9ment Tosi wrote:
> > Hi Chris,
> >=20
> > On Fri, Oct 27, 2023 at 01:23:51PM +1300, Chris Packham wrote:
> > > As discussed this series reverts the HAFDBS changes that caused an is=
sue
> > > on AC5/AC5X. I think there are some improvements that can be made to =
the
> > > initial memory map for the AC5/AC5X but so far nothing I've found mak=
es
> > > it compatible with the HAFDBS changes.
> >=20
> > Would you mind briefly explaining what those issues are and/or point me=
 to the
> > discussion where it was decided to revert these patches?
> >=20
> > The feature is quite useful for users of CONFIG_CMO_BY_VA_ONLY, to spee=
d up the
> > boot sequence: instead of reverting these patches altogether, would a r=
easonable
> > alternative be to put them behind a build option?
> >=20
> > Also, could you confirm that the "initial memory map" you are referring=
 to above
> > only describes actual memory as, IIRC, some boards were using mappings =
**much**
> > larger than their DRAM address space?
>=20
> The most details are in this thread:
> https://lore.kernel.org/u-boot/CAFOYHZC_Dveax85n0fLr5BFyZcLqsvUssn=3DJ0oH=
yvN75bTaCUw@mail.gmail.com/
> with some follow-up in:
> https://lore.kernel.org/u-boot/CAFOYHZB7jJWwD24oWzx6u55w2whHYjK56f=3DQyN0=
LWU4Z8dSP+Q@mail.gmail.com/

Checking to see if you have any feedback for these platforms? I would
like to have them working again one way or another in v2024.01, thanks.

--=20
Tom

--S1dLDTc1TMY+O52+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVNUDwACgkQFHw5/5Y0
tyyiFAwAtNaEjfBdxKo1JC8mrUiajQSl1Y5Y5RWs3frU/2jEF4MXPoV0B5tv71Gv
CqLT9tH1fJs5TsTMdW/FoXYfSPiAJYtAs16xVoy4KFyDxlbZOdeANcIUw0Mm0KYD
9CD3bS/MQV01py9uwE7cySUV1I+dip2aSqy/C4k2V/b4Q7VUqH6q+mOnmKIPTKxd
z/fTQnLTFSll1qVj48y2UGw1dfvlUWAfLLL6qtz69D3RiTA5YnEoMS5IOjuZap7e
3GrZjxq2PKuFU0qPJY9p25oQwLBeESQGAcNQEXTaiTtdD8hsiBx0gP05R5EQ5rJR
RbgsFTPq/quLssgMy+7+3S1vgMJXOf/IQ2k1C5+4NcBlTC1eI8WGB+vgqmSD4HY2
1Cot41r0KKhMq1K5NbtghnzPsYxMRmjo6vzYS09+BZUeAvmkLMZq8zvGBko/9vAP
Zvf/hLxW80Kv8meXJwY75WKArgfJbp01Ydi9s54P9HhohIPxBQe1gKS93w4ISBkJ
4+jgSpnM
=I7zi
-----END PGP SIGNATURE-----

--S1dLDTc1TMY+O52+--
