Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC12C55173
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 18:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D8E14113A;
	Fri, 31 Jul 2026 18:50:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xVPsjhA6mHZc; Fri, 31 Jul 2026 18:50:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9BABB406DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785523813;
	bh=71ASXgCw7pjitbehrdYUJHjJJAx9+NQR+OIo1UdM77I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=clPboS29VxXtJlej1kiYoMcFZFmy2vbtOWfjQCl6pNWC8XJxbQbHMzjENSlfuExCJ
	 6Uzj0Gdod0qeYONY44/P7wJmKopbPFSCxWe+B9QVqybYYLpew8OFea1ahSALBhF2vR
	 shu/gcaYqv/tJAqR7UiXS+Mt0+FqtVbDKRVJU6Oyx8KP5beEwJ2LwEvcQc3co+SDoD
	 CdTssH+tVyOiKgpk2MvG/GJDMN1U1uDWLEEd8htkdMb+rL+X3kL5N9FjbYul8ekxZl
	 E8YQHeI+Otb96BILpJiDSv6sRdGe/2O5JpNrJ4xvePDr50fTDk5J1Tq3sb0tP9xOCC
	 il6d0gBspgUHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9BABB406DB;
	Fri, 31 Jul 2026 18:50:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B17AD26F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 18:47:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A3ED940F28
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 18:47:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tjK6BgeV6gfK for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 18:47:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A1339407AC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A1339407AC
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A1339407AC
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 18:47:37 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6aae90e595fso557733eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 11:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785523656; x=1786128456;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=71ASXgCw7pjitbehrdYUJHjJJAx9+NQR+OIo1UdM77I=;
 b=h2pw5eAnfq8u9y11IJ4iaYHLGfJDUUNCQj/FPAB4P4dUSIq8Ck4dKIWzCYn+2u1pBr
 Tnycov9sI+2UTi2P9WD7eEIHrPuVnfzcLzAn1P7knsDZuPMrzVz/Jb40td2nF9ku6bKd
 YFYmKPXeqm/orGyL9ti6ApICIp5KFYcYFzxK7z6m1siUJWVgilWEvyFqyIr5CAodxSWj
 E8WVPC9dg//Vgv+UjsQ04CGdDZNXST6U/f/70rYRVuo7i3D52HhXbX0pXEHySHUuO7SI
 TJAtX91neDpfk8ACRDLoNgZhkS70SYCCP9hz2MEHJd6sQwv2un3+phZEWtXnmjvTqpjY
 WbtQ==
X-Gm-Message-State: AOJu0Yycx4GUY7H42XwzfVBQnPjfZzjZ34lwfOx4CV7p2Scgmei1TDZ3
 HzlW4BpNXj9prlGWaC+yhlH+hgWcWuiRebaCZOnH7JGUxFGTFcXgAWkCDB4xEQUfRCU=
X-Gm-Gg: AR+sD12s3pGqyRYMzrYWx7sEHzKY8IugyfZX71S8KQJOmuioO5dQlCIx7FQNJ3ACQrC
 VHhjK0IxR7l/PbKzOOoiTyfldwfhCLBanFEZrEc0/5twi9oFkucxcsNK+/dxYP4hs5eRABAsQQe
 6jcA8JbAmkJReNV4pTVoIdoLQh3Gmrf+lzXDjsu/TYtjUPD+NiX7DZfbqFHssfmDxq8nAQorYwR
 jlnr5juBlWkS2b4LaQOdpEzPdcseiPtNkb3ob/ThWIyulgEz8PRv40m1rFBkiKli95CUfEuX0Fy
 BowNQgHhJjqlstVAG7DFQJJ77ydkidm8ZSxkx7vlzOPQfYjGlXISsVIXUqJS1seQf+Sa6jqejAG
 py+zkj0RN6s/hf89HOd3MwdqC4fDdfrPJrt0xdLTiPnfN8Xi4ETAHbqEprBYmLXUH9NouMXuuqB
 CUdcKpvn7JWx4J7cwnmI8S65Eq88c+FO4TqLS7DQY7knUrKeKjhdjmqUSqAIDT8Q+53ljY/Sv2+
 UGJUOhvSoviV1tzYUMrOVkELKiTz6Ftk9jCTq4NPCVbfAx1qUOZx9YVjBytQgsGbg5jgLQKbKC2
 duQy3aeABw==
X-Received: by 2002:a05:6820:1a07:b0:6a1:47ad:d18e with SMTP id
 006d021491bc7-6ae431a45e4mr2167778eaf.2.1785523656411; 
 Fri, 31 Jul 2026 11:47:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6ae39928b6dsm1520435eaf.0.2026.07.31.11.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 11:47:34 -0700 (PDT)
Date: Fri, 31 Jul 2026 12:47:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ronald Wahl <ronald.wahl@legrand.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>
Subject: Re: [PATCH v2 02/10] spl: atf: support Linux as BL33 with TFA
Message-ID: <20260731184730.GO1773261@bill-the-cat>
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-2-acb97c172993@flipper.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3egkipfE8SzrBsL4"
Content-Disposition: inline
In-Reply-To: <20260731-atf-falcon-v2-2-acb97c172993@flipper.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Fri, 31 Jul 2026 18:50:12 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785523656; x=1786128456;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=71ASXgCw7pjitbehrdYUJHjJJAx9+NQR+OIo1UdM77I=;
 b=e4SNC76Oe9tpBli15tEIGsGXW43GTb7dysFYwqw34JV/K0JFAvccOf5YDg21UBf39O
 hzMV0fz5jTIom5PxMLIBGsv+Svv+NV11iSAeyseCHfRd3t6gwlJh4nzEjIquxGn/MXUT
 G5oBA/BUFQDpMXeaICAoYpKJgjpbinWp8avv0=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=e4SNC76O
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


--3egkipfE8SzrBsL4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 09:10:46PM +0400, Alexey Charkov wrote:
> Modern SoCs such as Rockchip RK3576 need TFA to be running to provide
> firmware services to the OS.
>=20
> Enable the TFA boot flow to allow using Linux as BL33 (including its
> calling convention) to facilitate Falcon mode boot on such SoCs.
>=20
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  common/spl/Kconfig   | 22 ++++++++++++++++++++--
>  common/spl/spl_atf.c | 49 +++++++++++++++++++++++++++++++++-------------=
---
>  2 files changed, 53 insertions(+), 18 deletions(-)
>=20
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 0618f42c9410..7c639ed8f763 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1230,22 +1230,40 @@ config SPL_BOOTZ
>  	help
>  	  Boot a linux zimage from memory in falcon boot.
> =20
> +	  This provides an entry path which is unused when the OS is entered
> +	  through TF-A, since SPL then only places the kernel in memory and
> +	  BL31 is what enters it. It remains selectable: SPL can still enter
> +	  a kernel itself on such a platform, dropping to EL2 without TF-A
> +	  resident, just without any firmware services being available to the
> +	  OS afterwards.
> +
>  config SPL_BOOTI
>  	bool "Allow booting an Image style Linux kernel from SPL"
>  	depends on SPL_OS_BOOT && !SPL_OS_BOOT_SECURE
> -	default y if ARM64 || RISCV
> +	default y if (ARM64 || RISCV) && !SPL_ATF
>  	select SPL_LIB_BOOTI
>  	help
>  	  Boot an uncompressed linux kernel image from memory in falcon boot.
> =20
> +	  This provides an entry path which is unused when the OS is entered
> +	  through TF-A, since SPL then only places the kernel in memory and
> +	  BL31 is what enters it, so it does not default to y in that case. It
> +	  remains selectable: SPL can still enter a kernel itself on such a
> +	  platform, dropping to EL2 without TF-A resident, just without any
> +	  firmware services being available to the OS afterwards.
> +
>  config SPL_OS_BOOT_ARGS
>  	bool "Allow SPL to load args for kernel in falcon mode"
>  	depends on (SPL_OS_BOOT || SPL_LOAD_FIT_OPENSBI_OS_BOOT) && !SPL_OS_BOO=
T_SECURE
> -	default y if !SPL_OS_BOOT_SECURE
> +	default y if !SPL_OS_BOOT_SECURE && !SPL_ATF
>  	help
>  	  This option enables the SPL to load an args file (usually the FDT)
>  	  alongside the kernel image in falcon boot mode.
> =20
> +	  This is not needed when the OS is entered through TF-A, since the
> +	  device tree is then taken from the same FIT as the kernel, which is
> +	  why it does not default to y in that case.
> +
>  config SPL_PAYLOAD_ARGS_ADDR
>  	hex "Address in memory to load 'args' file for Falcon Mode to"
>  	depends on SPL_OS_BOOT_ARGS

Expanding on the help text is good. I'm not immediately sure on changing
the default statements however. Maybe the changes are fine but just need
a bit of a rewording to be a tiny bit more concise, the "which is why it
does not default to y in that case" can probably be dropped and you just
add text explaining when it's not appropriate to enable.

--=20
Tom

--3egkipfE8SzrBsL4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCamztvwAKCRAr4qD1Cr/k
CrWyAP9xq5mFOy/aqQds0kNcMwLjf5m8NbeLwFNqndGIdizRngEAyQ/nXiWPu6Wr
U1AdXIpJaVmKF4UTbp1i+V79hNxlmAQ=
=/nPV
-----END PGP SIGNATURE-----

--3egkipfE8SzrBsL4--
