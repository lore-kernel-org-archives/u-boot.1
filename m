Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E20CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 08:04:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B36EA88380;
	Thu,  4 Apr 2024 10:04:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="dYmvuG+X";
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="XVfVkrp8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23B738825A; Thu,  4 Apr 2024 10:04:51 +0200 (CEST)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D5A588380
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 10:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=matthias.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1712217888; x=1743753888;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=y6e1MRKMRbrOH6y0UwEiBSuLq76Q3Eq85u9JbqnzIII=;
 b=dYmvuG+XctecCnLzMI9ba4hX6ZiRItX9mbkDHlLcoA1LHiH4QzhG5zhC
 7hGP2uM+J1AMQyiKDeYo0t78OKm7T83FtCrIWBKpa18zRZ+EIe4shtNw2
 m11oCqqyxS7Ofz6632+N+PteZgZtIWj+gqvEyF8NtUy/91WSFjI3Msyyz
 0Wo3jmzpMUYlZ07sBC82ocIgneNhPGkW3zrtdV1pQYG7ql0UweC4SklG6
 GNysQOAt9Ykey3BjyFDhhCC7hgAonw70+rqmuNgzF5Gosxt1ftghl0NwC
 MlXPuUicNja1Bv6Nww6uijtnzQPZVuf8A19pD19RGR8eNQoWLjy+1KikZ g==;
X-IronPort-AV: E=Sophos;i="6.07,178,1708383600"; d="scan'208";a="36243843"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
 by mx1.tq-group.com with ESMTP; 04 Apr 2024 10:04:47 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3C830173C9A; Thu,  4 Apr 2024 10:04:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
 s=dkim; t=1712217883;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=y6e1MRKMRbrOH6y0UwEiBSuLq76Q3Eq85u9JbqnzIII=;
 b=XVfVkrp8EZGFJaEILGPdtZVEaIboFzROLBCCPN2GzUjEPdWbPmRlSGP787NwH+kSgRF0i6
 4PpioQmWMygdlW29+yF24EQ2hWltRuvLRToMl3EljEcDKtluXb5taxEcfT9vjr2PtUzxyi
 imaFnTG2XuHc/0XJ5k3OoIegvz0BONHeLNntupiLg4Gh6olHty6uvW8UF6NkasPHrUODr7
 Xu+N6RKmhCut3Iqtq0uMr1xxNEiQQ7TvaHQ7N+tUhjimBCLx/MU2nW4UDwJmbSap9asdXy
 k3y2gzwXTcVCycNgjEvXL4tXofX7iLlPhlIU6zm2ZKeZTziu/KmYOfiXg11tzQ==
Message-ID: <d23bdaec46343155c752fcfb5287d9b39ac44918.camel@ew.tq-group.com>
Subject: Re: [PATCH 3/4] arm: dts: k3-*-binman.dtsi: Clean up and templatize
 boot binaries
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Michael Walle <mwalle@kernel.org>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 alpernebiyasak@gmail.com, bb@ti.com, nm@ti.com, sumit.garg@linaro.org, 
 michal.simek@amd.com, marex@denx.de, neil.armstrong@linaro.org, afd@ti.com,
 vigneshr@ti.com, kamlesh@ti.com, u-kumar1@ti.com
Date: Thu, 04 Apr 2024 10:04:41 +0200
In-Reply-To: <D0ALVJNAVD8U.3UYSZULLZ6YG5@kernel.org>
References: <20240322131011.1029620-1-n-francis@ti.com>
 <20240322131011.1029620-4-n-francis@ti.com>
 <D03Q9AGO5ND9.1TJM3KSNA71WG@kernel.org>
 <83c6532a-e994-4bcd-bc48-9e22ecdec644@ti.com>
 <D04LUAJJ6LC7.1JVGVTJ0UCMVR@kernel.org>
 <062f7c42-7088-4813-a2d6-ecb7ab22b4ba@ti.com>
 <D05D4N00QDKO.2PJ7VW4BNGQ11@kernel.org>
 <2e817727-524e-47e5-9f5e-2ee13d99a9bb@ti.com>
 <20240403103458.mn2xkemiyymidipo@uda0497581>
 <D0ALVJNAVD8U.3UYSZULLZ6YG5@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
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

On Wed, 2024-04-03 at 17:51 +0200, Michael Walle wrote:
> Hi,
>=20
> > > > > > And on top of that, it will just be a base board and there will
> > > > > > likely be some carrier device trees (overlay? I'm not sure yet)=
.
> > > > > >=20
> > > > > > As far as I can tell, you've put the memory configuration into =
the
> > > > > > device tree, so I'll probably need to switch between them someh=
ow.
> > > > >=20
> > > > > The "k3-<soc>-ddr.dtsi" file will be present in your k3-<board>r5=
.dts
> > > > > which makes sense, the memory configuration depends on the board.
> > > >=20
> > >=20
> > > k3-<board>-ddr.dtsi* (e.g J721E EVM vs. SK boards consume different m=
emory
> > > configurations.
>=20
> Right.
>=20
> > > > And one board might have multiple configuration depending on the
> > > > variant of the board. Typically, one board is available with
> > > > different memory options. i.e. 1GiB, 4GiB and so on. The actual RAM
> > > > chips can come from different manufacturers. So all all, I presume
> > > > there will be different RAM settings, i.e. different
> > > > k3-<soc>-ddr.dtsi. But I have to switch between the setting during
> > > > runtime because there will be only one boot image for that board.
> > >=20
> > > This is a runtime dynamic DDR configuration support you are describin=
g
> > > correct? This means you would be including all the supported memory o=
ption
> > > DTSIs in your k3-<board>-r5.dts correct and probably do some board ma=
gic
> > > code in the SPL DDR driver to choose the DTB. How is this affecting t=
he
> > > packing of the final bootloader which will anyways pack the whole R5 =
DTB?
>=20
> Correct, the DDR configuration should be chosen at runtime after
> reading some board strappings. Unless, it will work with with the
> same configuration which seems unlikely to me. But it is not an
> unusual configuration I'd say.
>=20
> I haven't looked into this in detail, but to me it seems not that
> obvious how to do that in a generic/upstreamable way. Multiple
> device nodes sounds wrong. Thus, I'd likely need different device
> trees for the different memory configurations for the R5 SPL. Not
> sure that is yet possible with u-boot, though. If you have any
> better idea, I'm all ears.
>=20
> > > > > > Also, regarding the board variants, I'll probably need to choos=
e
> > > > > > between multiple device trees. That is invisible to the user,
> > > > > > because u-boot will choose the correct DTB according a board
> > > > > > strapping, which btw. works really fine, see for example
> > > > > > (boards/kontron/sl28/spl.c:board_fit_config_name_match).
> > > > >=20
> > > > > Again, this is assuming that there is some HW blown register avai=
lable
> > > > > for the board to use (or in our earlier K3 case, the EEPROM) but =
that is
> > > > > not necessarily true every time.
> > > >=20
> > > > No, that is of course board dependent. It is just an example that
> > > > there are boards with more than one DTB.
> > > >=20
> > > > Let's step back a bit. Right now, there is
> > > >    k3-<soc>-<board>-binman.dtsi
> > > > which is fine. But it seems, that TI is heading towards a common
> > > >    k3-<soc>-binman.dtsi
> > > > which is intended to be used by all the boards that are using that
> > > > particular SoC, correct me if I'm wrong here. Now the problem with
> > > > that is that you hardcode the FIT configuations which are really
> > > > board dependent and assume that there will be exactly one DTB per
> > > > board, i.e. your "#define SPL_BOARD_DTB" etc.
> > > >=20
> > >=20
> > > Correct, but as I mentioned in the earlier message, if your board sup=
ports
> > > more than 1 FIT configuration, you can easily extend the image and ad=
d more
> > > configurations.
> > >=20
> > > > Thus, what I was trying to say is that you should split all the
> > > > board independent configuration (dt fragments) from the board
> > > > specific configuration.
> > > >=20
> > > > And again, of course I could just ignore the k3-<soc>-binman.dtsi
> > > > and just use a suitable copy "k3-<soc>-<myboard>-binman.dtsi" for m=
y
> > > > board. But as I said, I'm not sure, this is the way to go and I hav=
e
> > > > a slight feeling I will be asked to reuse the "k3-<soc>-binman.dtsi=
"
> > > > when I submit my board support.
> > > >=20
> > > > > >=20
> > > > > > I don't think it makes much sense to hardcode your generic
> > > > > > *-binman.dtsi to just one FIT configuration. I'd rather see a s=
plit
> > > > > > between generic things which are shared across all boards and b=
oard
> > > > > > specifics, like the FIT configuration. I mean I could just copy=
 all
> > > > >=20
> > > > > Correct me if I'm wrong, but my understanding is that you would w=
ant to
> > > > > add more FDT blobs in the *-binman.dtsi correct? That is still po=
ssible,
> > > > > adding another "fdt-1" and "conf-1" in the
> > > > >=20
> > > > > Something like this in your <board>-u-boot.dtsi,
> > > > >=20
> > > > > tispl {
> > > > > 	insert-template =3D <&ti_spl>;
> > > > > 	fit {
> > > > > 		images {
> > > > > 			fdt-1 {
> > > > > 				...
> > > > > 			};
> > > > > 		};
> > > > > 		configurations {
> > > > > 			conf-1 {
> > > > > 				...
> > > > > 			};
> > > > > 		};
> > > > > 	};
> > > > > };
> > > >=20
> > > > Then you have the information at two places. One being the "#define
> > > > SPL_BOARD_DTB" stuff and the other one being in this additional DT
> > > > fragment. That is really confusing.
> > > >=20
> > >=20
> > > Hm... maybe. I personally don't see it as confusing. Even when pickin=
g
> > > between multiple DTBs, you will have a default DTB in any case, marki=
ng that
> > > as a macro wouldn't be confusing right? We'll need to get a third opi=
nion on
> > > here then, I had seen your ping on IRC [1], putting it here for the o=
thers
> > > as well.
> > >=20
> >=20
> > As I see it, it's not like we are making the fdt-0 non overridable, you
> > can still override it in your configs to make it cleaner if you want fo=
r
> > your board template, I don't think that -
>=20
> Though it is not overriding but rather merging, correct? So one
> would need to first erase the node just to create it again. Which
> looks more like a workaround.
>=20
> > tispl {
> >  	insert-template =3D <&ti_spl>;
> >  	fit {
> >  		images {
> >  			fdt-0 {
> > 				...=20
> > 			};
> >  			fdt-1 {
> >  				...
> >  			};
> >  		};
> >  		configurations {
> > 			conf-0 {
> > 				...
> > 			};
> >  			conf-1 {
> >  				...
> >  			};
> >  		};
> >  	};
> > };
>=20
> >=20
> > is not doable. It might be a bit duplicate but if I think about it but
> > we are not losing out on extending the templates for multiple DTBs even
> > with this design. I know it might not be what you want but I feel that
> > for single DTB it's really convenient with the macro stuff and we don't
> > have to override any of the other binman nodes.
>=20
> I've raised my concern about stuffing board dependent stuff into the
> now generic "k3-<soc>-binman.dtsi". I get it that it will work for
> 90% of the boards and that it is very convenient. I'd have rather
> seen a split of lets say
>   k3-<soc>-binman.dtsi
> and
>   k3-one-dtb-template-binman.dtsi
>=20
> All the generic stuff goes into k3-soc-binman.dtsi whereas 90% of
> the boards might still use the second dtsi with some define magic.
> But it seems you've already made your mind up on that :)
>=20
> -michael
>=20

My hope would be that we can get rid of board-specific binman configuration=
 in the common case
altogether for the K3 SoC families, using @fdt-SEQ etc. generator sections =
that will just include
all FDTs configured in Kconfig.=C2=A0

A while ago [1], this was blocked on ti-secure signing not working with gen=
erator sections, and
according to my experiments, this is still the case in U-Boot 2024.01 (and =
looking at the Git log,
also 2024.04/master/next). Are there still plans to make this work? Are the=
re any other blockers?

Best regards,
Matthias


[1] https://lists.denx.de/pipermail/u-boot/2023-July/525095.html


>=20
> =C2=A0

