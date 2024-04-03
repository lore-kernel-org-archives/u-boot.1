Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3C0CD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 15:51:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA6CA881E9;
	Wed,  3 Apr 2024 17:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q3uV1jB9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7274A8839B; Wed,  3 Apr 2024 17:51:13 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2137A881E9
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 17:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 141E6CE1C3B;
 Wed,  3 Apr 2024 15:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02930C433F1;
 Wed,  3 Apr 2024 15:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712159468;
 bh=I3tTMEgKsJp8bRFDEXnm0PZVNspMOI/PdlfibKZy7w0=;
 h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
 b=Q3uV1jB9BJ6ZbOqINAsCJaGaKazr3qkkVUgiueWfVGoagGXIIwsgIno5AQan7pX7c
 UYq+u/by+NWrywYs1jb0Wcph1KaInJQ3RL/Nkmu3VzyP53Nzdh+sYGUpjqHZCNbtIO
 zGS84rBbX92I5MctgBclPK7zvOftYLJl3NA5BZcBILcuzpkvLLz1TFjUb/k7yYOteW
 iKnbB3aJ+8PWuyAbxLvt1Fkbx2SQfxMBZUiPzcFKifpqUdbkCaz6pNIxEW9W1HChA8
 2K7dmWBa39sGDv+wTgSQlXPtUpwOnj6TXhuVjzml7GZhO65rSq6PywIf1BtKWudRpH
 E2semBvWum/wQ==
Content-Type: multipart/signed;
 boundary=d81ed4be38f8dfdd65370ed70e84a0fba32a0467b66ec5287132c2b756b2;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 03 Apr 2024 17:51:04 +0200
Message-Id: <D0ALVJNAVD8U.3UYSZULLZ6YG5@kernel.org>
Cc: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <bb@ti.com>, <nm@ti.com>,
 <sumit.garg@linaro.org>, <michal.simek@amd.com>, <marex@denx.de>,
 <neil.armstrong@linaro.org>, <afd@ti.com>, <vigneshr@ti.com>,
 <kamlesh@ti.com>, <u-kumar1@ti.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Manorit Chawdhry" <m-chawdhry@ti.com>, "Neha Malcom Francis"
 <n-francis@ti.com>
Subject: Re: [PATCH 3/4] arm: dts: k3-*-binman.dtsi: Clean up and templatize
 boot binaries
X-Mailer: aerc 0.16.0
References: <20240322131011.1029620-1-n-francis@ti.com>
 <20240322131011.1029620-4-n-francis@ti.com>
 <D03Q9AGO5ND9.1TJM3KSNA71WG@kernel.org>
 <83c6532a-e994-4bcd-bc48-9e22ecdec644@ti.com>
 <D04LUAJJ6LC7.1JVGVTJ0UCMVR@kernel.org>
 <062f7c42-7088-4813-a2d6-ecb7ab22b4ba@ti.com>
 <D05D4N00QDKO.2PJ7VW4BNGQ11@kernel.org>
 <2e817727-524e-47e5-9f5e-2ee13d99a9bb@ti.com>
 <20240403103458.mn2xkemiyymidipo@uda0497581>
In-Reply-To: <20240403103458.mn2xkemiyymidipo@uda0497581>
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

--d81ed4be38f8dfdd65370ed70e84a0fba32a0467b66ec5287132c2b756b2
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> > > > > And on top of that, it will just be a base board and there will
> > > > > likely be some carrier device trees (overlay? I'm not sure yet).
> > > > >=20
> > > > > As far as I can tell, you've put the memory configuration into th=
e
> > > > > device tree, so I'll probably need to switch between them somehow=
.
> > > >=20
> > > > The "k3-<soc>-ddr.dtsi" file will be present in your k3-<board>r5.d=
ts
> > > > which makes sense, the memory configuration depends on the board.
> > >=20
> >=20
> > k3-<board>-ddr.dtsi* (e.g J721E EVM vs. SK boards consume different mem=
ory
> > configurations.

Right.

> > > And one board might have multiple configuration depending on the
> > > variant of the board. Typically, one board is available with
> > > different memory options. i.e. 1GiB, 4GiB and so on. The actual RAM
> > > chips can come from different manufacturers. So all all, I presume
> > > there will be different RAM settings, i.e. different
> > > k3-<soc>-ddr.dtsi. But I have to switch between the setting during
> > > runtime because there will be only one boot image for that board.
> >=20
> > This is a runtime dynamic DDR configuration support you are describing
> > correct? This means you would be including all the supported memory opt=
ion
> > DTSIs in your k3-<board>-r5.dts correct and probably do some board magi=
c
> > code in the SPL DDR driver to choose the DTB. How is this affecting the
> > packing of the final bootloader which will anyways pack the whole R5 DT=
B?

Correct, the DDR configuration should be chosen at runtime after
reading some board strappings. Unless, it will work with with the
same configuration which seems unlikely to me. But it is not an
unusual configuration I'd say.

I haven't looked into this in detail, but to me it seems not that
obvious how to do that in a generic/upstreamable way. Multiple
device nodes sounds wrong. Thus, I'd likely need different device
trees for the different memory configurations for the R5 SPL. Not
sure that is yet possible with u-boot, though. If you have any
better idea, I'm all ears.

> > > > > Also, regarding the board variants, I'll probably need to choose
> > > > > between multiple device trees. That is invisible to the user,
> > > > > because u-boot will choose the correct DTB according a board
> > > > > strapping, which btw. works really fine, see for example
> > > > > (boards/kontron/sl28/spl.c:board_fit_config_name_match).
> > > >=20
> > > > Again, this is assuming that there is some HW blown register availa=
ble
> > > > for the board to use (or in our earlier K3 case, the EEPROM) but th=
at is
> > > > not necessarily true every time.
> > >=20
> > > No, that is of course board dependent. It is just an example that
> > > there are boards with more than one DTB.
> > >=20
> > > Let's step back a bit. Right now, there is
> > >    k3-<soc>-<board>-binman.dtsi
> > > which is fine. But it seems, that TI is heading towards a common
> > >    k3-<soc>-binman.dtsi
> > > which is intended to be used by all the boards that are using that
> > > particular SoC, correct me if I'm wrong here. Now the problem with
> > > that is that you hardcode the FIT configuations which are really
> > > board dependent and assume that there will be exactly one DTB per
> > > board, i.e. your "#define SPL_BOARD_DTB" etc.
> > >=20
> >=20
> > Correct, but as I mentioned in the earlier message, if your board suppo=
rts
> > more than 1 FIT configuration, you can easily extend the image and add =
more
> > configurations.
> >=20
> > > Thus, what I was trying to say is that you should split all the
> > > board independent configuration (dt fragments) from the board
> > > specific configuration.
> > >=20
> > > And again, of course I could just ignore the k3-<soc>-binman.dtsi
> > > and just use a suitable copy "k3-<soc>-<myboard>-binman.dtsi" for my
> > > board. But as I said, I'm not sure, this is the way to go and I have
> > > a slight feeling I will be asked to reuse the "k3-<soc>-binman.dtsi"
> > > when I submit my board support.
> > >=20
> > > > >=20
> > > > > I don't think it makes much sense to hardcode your generic
> > > > > *-binman.dtsi to just one FIT configuration. I'd rather see a spl=
it
> > > > > between generic things which are shared across all boards and boa=
rd
> > > > > specifics, like the FIT configuration. I mean I could just copy a=
ll
> > > >=20
> > > > Correct me if I'm wrong, but my understanding is that you would wan=
t to
> > > > add more FDT blobs in the *-binman.dtsi correct? That is still poss=
ible,
> > > > adding another "fdt-1" and "conf-1" in the
> > > >=20
> > > > Something like this in your <board>-u-boot.dtsi,
> > > >=20
> > > > tispl {
> > > > 	insert-template =3D <&ti_spl>;
> > > > 	fit {
> > > > 		images {
> > > > 			fdt-1 {
> > > > 				...
> > > > 			};
> > > > 		};
> > > > 		configurations {
> > > > 			conf-1 {
> > > > 				...
> > > > 			};
> > > > 		};
> > > > 	};
> > > > };
> > >=20
> > > Then you have the information at two places. One being the "#define
> > > SPL_BOARD_DTB" stuff and the other one being in this additional DT
> > > fragment. That is really confusing.
> > >=20
> >=20
> > Hm... maybe. I personally don't see it as confusing. Even when picking
> > between multiple DTBs, you will have a default DTB in any case, marking=
 that
> > as a macro wouldn't be confusing right? We'll need to get a third opini=
on on
> > here then, I had seen your ping on IRC [1], putting it here for the oth=
ers
> > as well.
> >=20
>
> As I see it, it's not like we are making the fdt-0 non overridable, you
> can still override it in your configs to make it cleaner if you want for
> your board template, I don't think that -

Though it is not overriding but rather merging, correct? So one
would need to first erase the node just to create it again. Which
looks more like a workaround.

> tispl {
>  	insert-template =3D <&ti_spl>;
>  	fit {
>  		images {
>  			fdt-0 {
> 				...=20
> 			};
>  			fdt-1 {
>  				...
>  			};
>  		};
>  		configurations {
> 			conf-0 {
> 				...
> 			};
>  			conf-1 {
>  				...
>  			};
>  		};
>  	};
> };

>
> is not doable. It might be a bit duplicate but if I think about it but
> we are not losing out on extending the templates for multiple DTBs even
> with this design. I know it might not be what you want but I feel that
> for single DTB it's really convenient with the macro stuff and we don't
> have to override any of the other binman nodes.

I've raised my concern about stuffing board dependent stuff into the
now generic "k3-<soc>-binman.dtsi". I get it that it will work for
90% of the boards and that it is very convenient. I'd have rather
seen a split of lets say
  k3-<soc>-binman.dtsi
and
  k3-one-dtb-template-binman.dtsi

All the generic stuff goes into k3-soc-binman.dtsi whereas 90% of
the boards might still use the second dtsi with some define magic.
But it seems you've already made your mind up on that :)

-michael

--d81ed4be38f8dfdd65370ed70e84a0fba32a0467b66ec5287132c2b756b2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZg166RIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/j0FwF/eMJ6eyUsYjHUFGEHh3GpjJjovf7ERQ+Q
D1HDYkI9xVm5kmLSLhH13Id2w3ULJIF3AX4gE3HIFNHAjodzraxbAP2Hak+taNQ5
lIvRBdScTwvKwiEt9GMce0OYboa5NKzr9/o=
=GbOt
-----END PGP SIGNATURE-----

--d81ed4be38f8dfdd65370ed70e84a0fba32a0467b66ec5287132c2b756b2--
