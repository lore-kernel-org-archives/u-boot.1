Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04350C54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 14:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F0A983095;
	Thu, 22 May 2025 16:31:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GL03aSFO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03471830B4; Thu, 22 May 2025 16:31:09 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07EC283082
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 16:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3fbaa18b810so2563473b6e.2
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 07:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747924265; x=1748529065; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9UQKezmWIOt22DTyJ459uVQjjjWY4Y5tAMwBWEaXbhk=;
 b=GL03aSFOUV6ulYL6lqEdHSr6PcMakEvavP5BV+EaCZ/WrMRZhWpNN0RadHiwRZvrcW
 M0ddwoF6jYOmYxscIUXvHHnOQ1NRnNy4FCgD86ktXdYCxL87Ib9StMMDsuIWYrfrzRuL
 3XPRgXiu+9Z9L9wNGm19aAenDR35yTfzaq6KU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747924265; x=1748529065;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9UQKezmWIOt22DTyJ459uVQjjjWY4Y5tAMwBWEaXbhk=;
 b=K/pSddNoovgtVQXFZNthNYxzAIcfmXuRPw1Mr6EsHu/LafKxsC9v/Zc36xHFQy4uR6
 SfcqVR5WKWaB9QWM6/98MrBQlnIE8h7X1jIjQ24mde1ahhdNoQHBqn8+/vtKtPgAK5Wg
 GAxW7Yc92Dx+qEEZ+l/zgu5gzKlx795ahHLXEwHiwSiUsGsFChMdHfcWXwCjzCcLKyuz
 BhxYFx3XOMDOsCxp6Ps2dCjtNbrlfZrAsv3/yTitK1D71Gtr1F1Hdn7IyQjyIFWchAza
 xj0/v9ruqfgtTMrPL4C48sVwDgGe2flQ64mLDtCktKVQAsBUhEsZgDkRE7Nw7Lgf6QTO
 jpDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtTc1jwjqZvStwus9injDClP1i/dmSyVRbu1B4PKFbpPabyRMkjUg8pkAtH3h2G8P7No21+KA=@lists.denx.de
X-Gm-Message-State: AOJu0YyoAsfc7JlGRAwlLluJAZK3GW5n1FYFz9++Yq9CQ/ubeLKCEjCx
 Zn3pSk7hHKTTYmA29B+uqiWYhP4/FaFL2nJ0GGoaXXelEpk8WK0PKucdw7ZVtLMYSl5LGPA8QJP
 mwZYqeh0=
X-Gm-Gg: ASbGncsTu88OnJ38YE7eLxVn4cv0aQmMUcHhUs3aNiDd3rr87xxYhyrZaYPuz5m0OLn
 ZE+IslAxIBj1vUwl93kL5ozLkn/XNm02mepfClDIcuw9wKdRx8vCBmbQMDBQb6iQYLhg1GsySx0
 MqbWAkg8zg0OUJrz78tA0WLddlMbf9pf63I3CNWq8oCUDoBr+d2LtcSfTdwF8PcAoEGbcHkVRyv
 bC1zWdoM2sV9wxOuhnCmBtLuV3hMm+y4G5NBlE/jcDRD7VyQL6OTnqgRW+v6fowVWBtLKnJgYDZ
 6S2/JWs1oRfX7OUjM80cSh7cvRLNqcd3dg7iCOlcXH2oRfUu4ajbrwtAGk3Yi6cQJlW933Ljsad
 MDrxuWT2Hk5AEfDN8RR+LpRk=
X-Google-Smtp-Source: AGHT+IFTj/IwTIYGJmcX5C2tjJPxG1J/EzNvcVVbt6i8WzvV/G9YJ8hXZzknKqG5hJOK+WcI5q1g2A==
X-Received: by 2002:a05:6808:228c:b0:3f6:a476:f7d3 with SMTP id
 5614622812f47-404da73450amr16449864b6e.9.1747924247255; 
 Thu, 22 May 2025 07:30:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-404eacec299sm1979776b6e.26.2025.05.22.07.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 07:30:46 -0700 (PDT)
Date: Thu, 22 May 2025 08:30:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Dmitrii Merkurev <dimorinny@google.com>
Subject: Re: [PATCH RFT v3 0/3] fastboot: add support for generic block
 flashing
Message-ID: <20250522143043.GH100073@bill-the-cat>
References: <20250506-topic-fastboot-blk-v3-0-d94be5829f46@linaro.org>
 <174774092427.332438.8643753165301653831.b4-ty@kernel.org>
 <87zff6nhmo.fsf@kernel.org> <20250521151236.GC100073@bill-the-cat>
 <87wma9okxy.fsf@kernel.org> <20250521190347.GF100073@bill-the-cat>
 <87a575gmid.fsf@kernel.org>
 <70222dab-ffc6-4065-9b11-234a63a9b738@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GmX8gAHA+/OqrWhm"
Content-Disposition: inline
In-Reply-To: <70222dab-ffc6-4065-9b11-234a63a9b738@linaro.org>
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


--GmX8gAHA+/OqrWhm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 09:52:30AM +0200, neil.armstrong@linaro.org wrote:
> On 22/05/2025 08:58, Mattijs Korpershoek wrote:
> > Hi Tom,
> >=20
> > On mer., mai 21, 2025 at 13:03, Tom Rini <trini@konsulko.com> wrote:
> >=20
> > > On Wed, May 21, 2025 at 08:52:41PM +0200, Mattijs Korpershoek wrote:
> > > > Hi Tom,
> > > >=20
> > > > On mer., mai 21, 2025 at 09:12, Tom Rini <trini@konsulko.com> wrote:
> > > >=20
> > > > > On Wed, May 21, 2025 at 04:49:35PM +0200, Mattijs Korpershoek wro=
te:
> > > > > > Hi Neil,
> > > > > >=20
> > > > > > On mar., mai 20, 2025 at 13:35, Mattijs Korpershoek <mkorpersho=
ek@kernel.org> wrote:
> > > > > >=20
> > > > > > > Hi,
> > > > > > >=20
> > > > > > > On Tue, 06 May 2025 18:10:06 +0200, neil.armstrong@linaro.org=
 wrote:
> > > > > > > > This serie permits using any block device as target
> > > > > > > > for fastboot by moving the generic block logic into
> > > > > > > > a common set of helpers and also use them as generic
> > > > > > > > backend.
> > > > > > > >=20
> > > > > > > > The erase logic has been extended to support software
> > > > > > > > erase since only 2 block drivers exposes the erase
> > > > > > > > operation.
> > > > > > > >=20
> > > > > > > > [...]
> > > > > > >=20
> > > > > > > Thanks, Applied to https://source.denx.de/u-boot/custodians/u=
-boot-dfu (u-boot-dfu-next)
> > > > > > >=20
> > > > > > > [1/3] fastboot: blk: introduce fastboot block flashing support
> > > > > > >        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/=
commit/88239b5bb04bea2b58f7bf4c3ea72cf832de818c
> > > > > > > [2/3] fastboot: blk: switch emmc to use the block helpers
> > > > > > >        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/=
commit/25ab5c32c28b9f25fb193f726f239d75af3c365a
> > > > > > > [3/3] fastboot: integrate block flashing back-end
> > > > > > >        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/=
commit/a885bd8c969e25d03bf406207d89b1145c9490fb
> > > > > >=20
> > > > > > It seems this series cause CI to fail:
> > > > > > https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines=
/26238
> > > > > >=20
> > > > > > Without the patches applied, it passes:
> > > > > > https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines=
/26235
> > > > > >=20
> > > > > > Do you have any idea what is going wrong?
> > > > > > I could not find anything obvious by skimming through the logs.
> > > > >=20
> > > > > It's a Kconfig problem then. Some platform is prompting for a val=
ue (not
> > > > > a y/n) and there's no default.
> > > >=20
> > > > You are correct. Thank you for the suggestion.
> > > >=20
> > > > I've applied the following diff to 3/3:
> > > > diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> > > > index 68967abb751e..fdf34a6abe1e 100644
> > > > --- a/drivers/fastboot/Kconfig
> > > > +++ b/drivers/fastboot/Kconfig
> > > > @@ -200,6 +200,7 @@ config FASTBOOT_MMC_USER_NAME
> > > >   config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
> > > >          string "Define FASTBOOT block interface name"
> > > >          depends on FASTBOOT_FLASH_BLOCK
> > > > +       default "none"
> > > >          help
> > > >            The fastboot "flash" and "erase" commands support operat=
ions
> > > >            on any Block device, this should specify the block devic=
e name
> > >=20
> > > Assuming that the code will see "none" and handle the error correctly,
> > > OK. But we really should have a configured true value here, yes?
> >=20
> > The code does not handle any special cases.
> > If FASTBOOT_FLASH_BLOCK_INTERFACE_NAME is "none", we will call:
> >=20
> > blk_get_dev("none", 0);
> >=20
> > Which will then be handled via:
> >=20
> > 	if (!dev_desc) {
> > 		fastboot_fail("no such device", response);
> > 		return -ENODEV;
> > 	}
>=20
> It could be "" aswell ?

I really do not like putting in invalid defaults in order to allow "make
oldconfig" and so forth to not get stuck. If a board needs to set a
value to compile, it needs to put in a valid value. Putting in unusable
defaults to Kconfig leads to runtime problems later (this is more clear
with "" and *much* less clear with a maybe-valid 0). My preference here
would be to update whatever the stuck platform is to either disable the
feature or set correct values.

--=20
Tom

--GmX8gAHA+/OqrWhm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgvNQ8ACgkQFHw5/5Y0
tywEngwAs7zo7LAHV3QNGIT41iiEMy8e7hCgUhhKs6EtiOvxaUyMWn4ocjbBeL7J
H1t95Ez4fwL5ihuFAo0OUv8nLmB32epe/Af2GDr1RfXFgv1Wcqb6wvbM9xMHFmp+
jJz66qC+6saglSxrRUUrRWhHWLPeE6ZfjxIV2M3I/yWlTu8MZU3NHCaX53Nyzloo
aujCcopLBnPsHHndgMWjFW6mV7EijKA5hVCxab4L1fmoxLEdv3PBo4xDpghfhsgO
K61vhn2YNbGKOlHwz7wtME9zn5UMSHjJRZsPcltONNPV5gx1gy0WeNz2FnX0VXf8
lnZNd4UJ2avRWyXQd/vycYIAyToCAjDx4qvLqvsvQE/EmnvT23ZNjGdRgFC+ZxdH
pYmdZCUunBLbGqp4qDoByxdCFE/5rV3OBA/ddmGoBZTV9Aaejwm/12v28tD8pDow
h/mvMqR6umE3YtnY7CndTPe7l1i5oITB/HojHY4kR3CINR6xPFj2CXgNQhkqCCSi
uZWWIoGK
=Qitx
-----END PGP SIGNATURE-----

--GmX8gAHA+/OqrWhm--
