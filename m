Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BB8C3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 16:57:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D10A6889A4;
	Fri,  5 Jul 2024 18:57:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iRWClesA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E2F588168; Fri,  5 Jul 2024 18:57:16 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2A8B8899F
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 18:57:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7035b717880so225934a34.1
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 09:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720198633; x=1720803433; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tv+bXqRylwPoK8JlZ11Hlo+0KNfMkJDRaJnTeTcnHfw=;
 b=iRWClesAS6kcZAD7DA18Nn8tI+8GvOx9rtw3anro/xuaD7tMyaC64livadSsfiuR5Q
 JZq7S+ghSrKiwSC/HQ1I4g9jLzTmRm5UrTrCd3Kifr/pfGSMzTE8T9wCPUTTz3qRgGu0
 bETzk4xjbIkdWkZuleT1oEuajRQ1hvmypqgQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720198633; x=1720803433;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tv+bXqRylwPoK8JlZ11Hlo+0KNfMkJDRaJnTeTcnHfw=;
 b=gSrlSqw6A3WWf6U5g3RWgvTnfcDH8J7VgYwhM6MZbl3sU+S8jovlJ6YokuE4Vfd2Gs
 0kao8w+5dbhCz0lSitV76IR7RXQoZMTztGQhw4g19dhlZ+zMGjNGeSC9sBns9907bvp0
 7suFyFUczrxS5Y1jBYfuCWFPMoG19gv121bZvUguVGPJBMOJR2I2Rfbz8XvDpKUqJCkv
 Ni8L+soLqUyjJ9ABIg+PruCgnIQrE2hdoHtL7XYPWZlozqChW8qQeZC8/3P4w1wUYnLS
 MebHL68c0LBkMRB8KfNgadnWLlIzaXQJaWZIdvJeQH3la62XutgHE3dqQAVHJ5VoUng8
 zbcA==
X-Gm-Message-State: AOJu0YwK0E4HkNRX9FY9wK94o5ZvJ979KYlKS9bcNqbKvZzqo0YNhaoI
 d2q3B7GZAVCUswwvXpRcs9zvNVVTiMGy8BmaYzDDYMOL7vvDX/IEWVgjdMRGBpU=
X-Google-Smtp-Source: AGHT+IFJsQNMfQbCXOMBOLXoexVZ+Qbgza1KXbARqBediKW3VsQnKVcZz9un6XoUeJz4aXSLB18OBA==
X-Received: by 2002:a9d:7643:0:b0:700:cd0f:6cc5 with SMTP id
 46e09a7af769-7034b99fb14mr2216739a34.7.1720198632686; 
 Fri, 05 Jul 2024 09:57:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-701f7a99a3fsm2662439a34.16.2024.07.05.09.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 09:57:12 -0700 (PDT)
Date: Fri, 5 Jul 2024 10:57:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Please pull u-boot-tegra staging
Message-ID: <20240705165710.GL38804@bill-the-cat>
References: <20240705131541.4434-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CI3zF9+TzZn/WptW"
Content-Disposition: inline
In-Reply-To: <20240705131541.4434-1-clamor95@gmail.com>
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


--CI3zF9+TzZn/WptW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 04:15:40PM +0300, Svyatoslav Ryhel wrote:

> Dear Tom,
>=20
> The following changes since commit 7c9c5c0562347dccb8ac89148784a34de402ea=
9e:
>=20
>   Merge patch series "xtensa: Enable qemu-xtensa board" (2024-07-04 16:11=
:08 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging
>=20
> for you to fetch changes up to f6fb6b2608214b3ee2aef955ec18cf97c14f562e:
>=20
>   board: lenovo: ideapad-yoga-11: add Lenovo Ideapad Yoga 11 support (202=
4-07-05 10:18:36 +0300)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--CI3zF9+TzZn/WptW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaIJeMACgkQFHw5/5Y0
tyy4fwv/T+r6SO5B8qI4SkR4xvJYOhQEsZpjQTEGqmLIS5xb60kew/NnsaTR2pE9
/919LK8rpo+82qob5C+yg/mlbD8blvCK/y48TM49eqMb/4wq8mvL5RgIouyxnRCg
bklwSkXdp1PuqOWXveWlq0tMxWzPpewwRuqwpGIRjdb/buIqO4HN0IaJtkNlBJZ9
w7HbyahKb/Im0tKgTK9U/4yBKJ3E2unkUcehLRmhpaUKWTp+IEXTE7EI33+7U2sO
4Xf2FpSxgUEKRV1uGvpGEkZ8v/wbabtJYST/lF29CFrt/9TXKRpSfFstJCeJPqUf
9mIZ2dNBP3Y21d2Y08HrmKtvIhktIez3JQHwhPhziOQ1vC9HcqsL8xoFPeJZzMYg
4pzYqoW+8aqdINQUCwI0VxpuCGpH8Z8Rrvk0NEr2XhtRh4IyhCARW5ZJwvnVBSoT
sM+9Claq0SJvWfzN7ROfAb9AxJD7Z2oTWiSLjDA/7GKOX+wV47QGZm5Diu8tFhjH
a0MAhGOF
=YsJb
-----END PGP SIGNATURE-----

--CI3zF9+TzZn/WptW--
