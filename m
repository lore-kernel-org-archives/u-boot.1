Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C143ACA100E
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 14:52:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEE2F86993;
	Wed,  6 Sep 2023 16:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EEVyB2Xu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEAB486963; Wed,  6 Sep 2023 16:52:38 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC039865A0
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 16:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3aa1446066aso2701535b6e.1
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 07:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694011954; x=1694616754; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kkn8fi4pjvUR6oSt46H4nHDHfWq8bCM8KWcQ/s/TBvI=;
 b=EEVyB2XuoKOGG5atjD2u/zzJbgEKtVqcU2lLSHBMNYle2N7aZy+rLseyI6ml802fBo
 JWUiTI1qLtAdYxu9iEOwR/0VFjTHbiQ+p143ciri3phxBWzi7Nl2W+7kPodsmvpBHcPU
 cjcFj1YPqaqBU4jvKOdFPDAvZIBRqjsCS6YCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694011954; x=1694616754;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kkn8fi4pjvUR6oSt46H4nHDHfWq8bCM8KWcQ/s/TBvI=;
 b=iByLz4gsPOZXP3J5q+FBNYOthPVDrErCYltYt20uhlw/BT4vKcrs2jwIf4BPn+waFV
 Lq4Io+RfzqfYzOXEgwm7HCdti7F7AlUJ50RM7tN+6dJ9NzFeJ34Iqv/TLTUJml7MYHLy
 xo12Zfv7yo7jiUDy1Eub6x0eBlogAYl9xx47sHlB/PICO23gUAyeGqyKpfWGzNiwLWRE
 ihCwTInKIzyh9PKxAejea2qJPu4qZJoVi2UxOKSzdgKERY7LPYp1NyTiZpYfhZsfVi2J
 DWbWo309mhlmiwF7r+3CyzHkeiv/dAargrnpnViFxjDMOZrJZkxlQeMDiq5FKMrqQUKM
 L6Dw==
X-Gm-Message-State: AOJu0YxiYZrZig1zwPxKjMqI71OFU1M7PX+wNTNCE5kDMpdFkFDaffj4
 dRooETSy77ObCzC29KTD6VFxsEy4aiRpF+fvZpllLg==
X-Google-Smtp-Source: AGHT+IHi2rZGvIyHdlV0Bj/eiP1Rb8TeHEE5qup4C4oxU2a6VCpzLf38n0mhCCULhR++1dDng81guA==
X-Received: by 2002:a05:6808:646:b0:3a7:94d3:43fe with SMTP id
 z6-20020a056808064600b003a794d343femr16000951oih.30.1694011954475; 
 Wed, 06 Sep 2023 07:52:34 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-06dc-de6d-386e-5d48.res6.spectrum.com.
 [2603:6081:7b00:6400:6dc:de6d:386e:5d48])
 by smtp.gmail.com with ESMTPSA id
 z5-20020a81aa45000000b00597e912e67esm3707773ywk.131.2023.09.06.07.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 07:52:34 -0700 (PDT)
Date: Wed, 6 Sep 2023 10:52:32 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-usb/master
Message-ID: <20230906145232.GB305624@bill-the-cat>
References: <20230905135054.15652-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YntrU0qEoL7lsfFP"
Content-Disposition: inline
In-Reply-To: <20230905135054.15652-1-marex@denx.de>
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


--YntrU0qEoL7lsfFP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2023 at 03:50:54PM +0200, Marek Vasut wrote:

> The following changes since commit 8999257f219d1e371c2fd66f255b8782897944=
d9:
>=20
>   Merge tag 'doc-2023-10-rc4-2' of https://source.denx.de/u-boot/custodia=
ns/u-boot-efi (2023-09-02 09:08:54 -0400)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de/u-boot-usb.git master
>=20
> for you to fetch changes up to 7f4b73fe6939761dd3891b96628efcab47a0570e:
>=20
>   usb: dwc3: Fix enabling USB_DR_MODE_HOST (2023-09-04 15:51:38 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--YntrU0qEoL7lsfFP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT4ki0ACgkQFHw5/5Y0
tyzFKQv/XBYdkq+NaoBOvzPoTcKfjdLGzTr/BKNmYqYIwz0wOQCON8wWysR7IjmV
xTEdSA3RfO24yLwkCntep3NRjl7FVlo8LPjME5S24SnVdG6kpSVEh9k6tQmN0gsF
eXKPCHqhzfLLH+AHm1BNMxYFr6ACWDP9sEmhoxRWq+oV+vr9QhYej0CdtQPUoTim
gnTLJaER+x//ziTkiW/8Zj3Fu+kUXN/+JBLyD8FuKUQOCTpBWF+XsoKl9BgeRhSo
O899f6Aua6n6WdtdUPDg00X1C2HwFt33YKRCz6Rdky+Uusr3XUANsUNi38LYuJzR
sPhzTXixTe5JDSkoW5fC72h19GWXpD/8IdWr4BvXwEabCW6oNwpEB3v7oP8nYmPP
yx55Wiy5UpBQf8YqcMtGIsJDRbZzgok2wdH1RA1ONUYOXpGLmbNeGve0XOAIUe8M
VgTt9luERnkEwTG2HukxPfS0WLiJ8b43tmaR3MdTC/gUAFIRfB/r+JkIkKN/CxTe
7zTFfS1w
=GxS3
-----END PGP SIGNATURE-----

--YntrU0qEoL7lsfFP--
