Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559B4CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 16:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97A1686EA8;
	Fri, 13 Oct 2023 18:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EYQZ8uqa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCC9686EA8; Fri, 13 Oct 2023 18:52:56 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6951986EE7
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 18:52:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3af609b9264so1462098b6e.2
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697215972; x=1697820772; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5Ow2rgZRkPiARbIgCYNrqyLYauvms/b8W6azjWBeh/M=;
 b=EYQZ8uqakb1rZ6aen701C1kxIU9BqXSF4/LBzB+ZiaEeoTg4arXCaDyrNz6wysisDC
 WgW3XCkHE9jBqvVeF+B0tQwBERVg1LhZRwB3j8JopYT+FyNDfp0lUNi4ocBOfETeaZt1
 GUEDZT+2oTeudaeI2n3ycoMiKwLam6Z1/ECTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697215972; x=1697820772;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Ow2rgZRkPiARbIgCYNrqyLYauvms/b8W6azjWBeh/M=;
 b=PD/2SHlVK7yh2jfOKiiKbOiuvBIIRMTrcTKQvh2g9gAPylXlKByf9ni4rt0Fsj7sTJ
 uZPokLpuFEUdEOIV7bnQt9CXT/oS60lu4MsL/1Eotlfv74RstG75RdUm5J9+9j5JZyBC
 hJMTwG/Y6ftR25vHBogn+pjJotkylR3Q9Z+GQBtD5cmlmXka3ssCEy3rK/Fp670don32
 Bpk7LwBJKNSIlLfpvg9tjEdN3IQFEyZnSmYRoqIB6HB0RKvie9VBQq58TjF01cwRf3q6
 avrz51y5xMcmaaB3vMP8+Pt9Mvp7sSEyXsr4sNPriDbzxSOxO7R30PvEY8iungncrf1+
 39Ug==
X-Gm-Message-State: AOJu0YyYWI2h/NYMSgBO1N19z6NFMk8FQkeKwKd4HKCG+zQ4v2f5Thks
 rKWT21y5JN3YHFZTDrR9jx+oPCkWeUrNNFnbSAW6Vw==
X-Google-Smtp-Source: AGHT+IHUzR+4d5r/pRTk+PNTgyhLeKMT+GxMCmqb7X2zPd9GoI9CHoL5rDlxfou97KG/1ZhbfWMBWQ==
X-Received: by 2002:a05:6808:989:b0:3ae:1031:594 with SMTP id
 a9-20020a056808098900b003ae10310594mr28507676oic.34.1697215972039; 
 Fri, 13 Oct 2023 09:52:52 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b33e-4d05-2330-607e.res6.spectrum.com.
 [2603:6081:7b00:6400:b33e:4d05:2330:607e])
 by smtp.gmail.com with ESMTPSA id
 c3-20020ac84e03000000b004199f47ccdbsm742189qtw.51.2023.10.13.09.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 09:52:51 -0700 (PDT)
Date: Fri, 13 Oct 2023 12:52:49 -0400
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <monstr@monstr.eu>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [GIT PULL] xilinx patches for v2024.01-rc1 v3
Message-ID: <20231013165249.GO3119521@bill-the-cat>
References: <c0186a3f-1654-4a51-b6e5-1aafe174b587@monstr.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+pPTNu3vhPTnlPpE"
Content-Disposition: inline
In-Reply-To: <c0186a3f-1654-4a51-b6e5-1aafe174b587@monstr.eu>
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


--+pPTNu3vhPTnlPpE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 02:44:49PM +0200, Michal Simek wrote:

> Hi Tom,
>=20
> please apply to following patches to your tree. The most of them are DT
> chagnes are coming from Linux dt schema validation, fixing DT warnings W=
=3D1,
> sync it with upstream kernel
> and adding missing pieces. Also new DTSes are added to described other
> boards. It most interesting are adding support for new Kria SOM Kd240 boa=
rd
> and descriptions related to System Controllers which
> are ZynqMP based SOCs available on Versal/Versal NET evaluation boards wh=
ich
> are handling DUT resources.
>=20
> There are other changes sent but I want to clean my queue to enable testi=
ng for it.
>=20
> Thanks,
> Michal
>=20
> The following changes since commit 83aa0ed1e93e1ffac24888d98d37a5b04ed3fb=
07:
>=20
>   Merge branch '2023-10-06-spl-prepare-for-universal-payload' (2023-10-06
> 17:23:47 -0400)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git
> tags/xilinx-for-v2024.01-rc1-v3
>=20
> for you to fetch changes up to 7a82bfff5ea7089905dff14e65436d23c1e5adc4:
>=20
>   test/py: net: Add a test for 'pxe get' command (2023-10-10 14:57:29 +02=
00)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--+pPTNu3vhPTnlPpE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUpdeEACgkQFHw5/5Y0
tywKYgv9HiwZJDxit98q5p7QISpY+ZQ1cqPKXYSdL0IBCALRQ8DkZwYi9KvRgtk+
2XiCYwA5d0OA6i+Wgomt1vDaQPZFyi+2Lm5DdkT/vs2Xg4e59xODa10QF77Drr8N
Iiw3lHI7xZYjW9R+NzcoKhOTo4dKU3KiYTm2Qw3Q3KsMynRdcv9CqoYqqdxa0CaX
jpS/zcwxlTmM4o4+7gOzuhY8Ll2fs0SHcUVlbrUrWzHDfv60DiHKiswIEhLWfSRx
K65tyd9/+zFvMi2gqmwo1dkXz2KATPlywJ011x8GiyB+R/fqnVGX7OEjcm8+gqt8
tP7p9F22WCpQcTz2TJOq+f2FsawA3hbyOZXHaMz8NDKQb3tiT3fMtcMQrcSkmDkb
Z44x4vlGBmdJsJDx1OiRMZJzGCCwCMoJqLlEAvEpZknvmRcpx0kaNnILCUMK51jF
v9nVS1CavpyVdlWLngVVu42PREgIUreXsG+dfWGBKifkgEk6RpK6AqkPrC3WlxSk
Up+xd2cn
=9oJI
-----END PGP SIGNATURE-----

--+pPTNu3vhPTnlPpE--
