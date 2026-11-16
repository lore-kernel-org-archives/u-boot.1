Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B81606A334
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l7tRsYBO;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=bTbocRIC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C42D405B1;
	Mon, 16 Nov 2026 18:44:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PA1oGti4Ifup; Mon, 16 Nov 2026 18:44:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 18E7740577
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794854680;
	b=ZUutSULRwH+V+tML2BNa7bv+mnfx9+f7Xe7pvL3Nd0zogdKv8JW4Y4gJD60zBBbgxkMc
	 4FLMedr8SxASzfoy6dOLbeUrkqBQub68LC7G1qqYBSjdZB+Ucx4OQPPA3ArQw/CWI0g6V
	 smtV/bwqfnJvkz59ATzsbKeYF84dNXhDb93deMyb8ireGv6dL1OL9FYZUeDRJJ3/DmoFo
	 jhjZitFDjin21jDWqgd8Wa0zDBBlrnBb70468HtV5RtQ4fyJV/+sHoWdZRfwPYgdHRn+W
	 U5Qjq3vikTSzWdZg2E7XdIg07rMwADf8nq04KKgCBIPOgp3/o5Z4tWn9EaQEWBJ01Ag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794854680;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wx1iU2eroepVCFtvneQNVEbPRwgDagis/DJeZ6JWphk=;
	b=HnOZzN2GWrOkVmedtvNAdkCe/bpXXV/P2FW28TQHMUWTy3fHt+Jd/ppFNuAXY75H86DC
	 qTrQRdrPeKf5bsu1hu//YxWDy9aJ9dIYowH8p0EwvN9wBHPEcBEfL5V77b6GsCfWPSzVL
	 Yz9YgrPdjxM4ZoYVXFuoxQZR0wGWFRnjhMvtcN4zDjFV0bVxYa0R1QZ3uxQ+UlkOVkfqW
	 CfeYA0HDN2cbJfkx6+W/h1o6K5Fg/XzUy8p23Ke8szFheAc01XV6vqNOggsiUNrosg1v4
	 U2VhwctAoLULIo17NRXL0VBq4mZ/4dYLH8WVkZ7mPDf7a9JNXpfetSefvkcihZzD9ng==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794854680;
	bh=wx1iU2eroepVCFtvneQNVEbPRwgDagis/DJeZ6JWphk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l7tRsYBOrMvg4g3fEfP9hyheknl9T6wCE8K65LwcpS58fHWeoajex8vW648Dpi95q
	 F4JWDLuuvqgvT5yxTtJtiMET5yr0Cj1eFlMS/IEF4zFkIH4tYtGlHPxL3uqm2xa+LZ
	 G5UYFhjgB+cbg4nGXOTxlRMhyWRZTqr5sXq2I+7e8CY9EnWe5QaqzTc0J90YnPAiZz
	 SyzGd9Vim6ZEabXOMionHqyUDc3Z5TcL9MhxMC8KlduCXjFc6VqZ+PaUYYrOQ52wWj
	 ssuoUNtmg2Gcsudr+e68FOMosetUqCfN/HVeGdI02KizB2e2+KoAd/5op8ElnbWcQZ
	 Gkm8LK273WUyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18E7740577;
	Mon, 16 Nov 2026 18:44:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BA5D28C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:44:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D8BE80C50
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:44:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BMKlQd8XfETZ for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 18:44:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 478AB80C43
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::35; helo=mail-oa1-x35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bTbocRIC
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 478AB80C43
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:44:36 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-4adba7b3399so1238117fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794854676; x=1795459476;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wx1iU2eroepVCFtvneQNVEbPRwgDagis/DJeZ6JWphk=;
 b=bTbocRICQ/RGL2iL/FrCtJ69NOM8AxIet6BlIg+W+kqlmBbOP/lDaOfR62FpFsxba2
 n18bF7uryOlUNBaFP0A6PQ6Krg3NE/m0vFh2odXqNnQ6jJwWAP4khXJLiKGoxI/4oIOC
 PT9OMjkYbNYVFcFdkdHSH9XiH6TOvWdQwUV/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794854676; x=1795459476;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wx1iU2eroepVCFtvneQNVEbPRwgDagis/DJeZ6JWphk=;
 b=eidARotdorw0AI/Rgh9yGG6TY9FnW8f4ENyjIMdXT0wEtXLAs8uCPnCr4PEno1MnSs
 QWPBVmH3ZugvT8deM61X2TZUqYe1+BTTRLozjJj2cqQLNbgHLza76+OCrMzzS15gLc0J
 D3MIm3yQuOmZp52mJDEQrNiiYKwZ9s+yVWhce7+QFl8DNaoevoXTycUVAGB/r1GR9KxW
 8uVi/JGRARRyBFWjSWz/WOQJZft0HG2PhWzuPFctOhB7YjpHbcq4sVj5f540bMkXRgOO
 nfsa1CwKcDaiBKYd3EkJ95jqwG6JW+KzF0EOn0qEeVRgMVTFULN9aHJYUCtzRDPLbRlr
 BzFA==
X-Forwarded-Encrypted: i=1;
 AL+hErHddQ2qo90yr3wnJac/23uklZ2wka1B7G//GCYzu90w+yerQrscMG5+ramP4ploC2LQ2l7VKm8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+kDkqiHQeFmmQieTrwt+Kv1xScJqjrUKGsg7aySi7twgkSbNe1
 3e/9kB4Ax8rJXNmi8+mc+J/dkIl8/M1L/I2EyaGhbjsy5CKYCc1GdyfXVwQqbSVhO2o=
X-Gm-Gg: AYBFou2pM4D4pKrxJsFQKilxy0EMhpbDGhGckAxEV8QkZ8GiVyWX7XpOeBgLcU4GDjQ
 eKhu20pY+QhQmafRb7lrcXVk4xjY0G5bC9o6xrEpP54Z/8gaQz4hVieLJvevdTOPncOOR7hquE6
 jv87hB8L9CA4pepg1LqJvgQBgvDehBKzcB0SH64Dxbe6klkzjxdahjYswwmN8vMC/3G2qx4aj9u
 d90Mkf4DX40edZPQCaUHC/Nz9YZNFjLlV+XzhUXKn26FuWYETG1M1FGJX0ZYlFQX8iY5CcF9sKw
 gtl8akjCwdxZ57MwX+f8J7xnaani+QXvx8VVWxKVFru5hiI79alsmY87GGjIvZHMH1iSQInvVsp
 gUDd7iX1AvUOWhNGNXG+R3/HyQPct3VFikqVtfMd+zocz+27FoweihchqRfc8LslDR2P8pi/pDx
 TQ5Ngj6u0S+HEfKVlz7+EBALUc7+MWkU9qZHdEUsnf5VDUKAbptF4KSO/iFwgGVp4wRFUVZy+rC
 hHiG5S4FtyiorNlrnzioVO734MpSkSiVtXTZAC3VXsvy5fhQLTU8EhUC1wxEgwspaESO5hyZRHK
 Cp0j0H5d7S+QR/fyEzaEwTLnj9DYCz4TX9kH6jNPiDFrebVxmeMGT5cRvZaadwnkyBLwnKqBW9t
 XygVKP23jVotRL9n5xihiDfc8Dxc0dg5AiZAuwiCIPxtNGG2WVuMtzRXQTGFiadWC8nMoodChcm
 qg5KmfdFMZn5/LGZCkL4Z3IrOBbGUdqAkZl5RTJuQy52RyJ6JXZ3su
X-Received: by 2002:a05:6870:c10d:b0:48f:e137:dc81 with SMTP id
 586e51a60fabf-4afdf4e1f91mr9294816fac.58.1794854675796; 
 Mon, 16 Nov 2026 10:44:35 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4afe22f8a17sm7277962fac.15.2026.11.16.10.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 10:44:34 -0800 (PST)
Date: Mon, 16 Nov 2026 12:44:31 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>
Subject: Re: [PATCH 00/10] binman: support separate binman devicetree from
 control devicetree
Message-ID: <20261116184431.GG554944@bill-the-cat>
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
 <20261113174852.GN554944@bill-the-cat>
 <CALeDE9PvZgwiAUxdX=-tN1fgDveNOkeM__xCCJeZrK3Di0WxjA@mail.gmail.com>
 <1b9f2a45-4ceb-48d0-afdb-b406404d98bb@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GmFL/CD4eta5Z5ng"
Content-Disposition: inline
In-Reply-To: <1b9f2a45-4ceb-48d0-afdb-b406404d98bb@baylibre.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--GmFL/CD4eta5Z5ng
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 11:17:52AM -0600, David Lechner wrote:
> On 11/14/26 3:16 AM, Peter Robinson wrote:
> > Hi David,
> >=20
> >     > Anyone who has worked on hardware that uses a devicetree for the
> >     > hardware description should know the mantra "the devicetree descr=
ibes
> >     > the hardware, not the configuration"
> >=20
> >=20
> > Thank you for this, I never agreed with describing these in the DT at a=
ll.
> > =A0
> >=20
> >     > Binman is describing configuration and not the hardware itself,
> >     > therefore it doesn't belong in the control devicetree that descri=
bes
> >     > the hardware. So we propose encouraging the separation of these t=
wo
> >     > descriptions into separate devicetree files. In most cases, binman
> >     > info is not needed at runtime anyway, so combining it with the co=
ntrol
> >     > devicetree is unnecessary, takes up space, and causes DTS validat=
ion
> >     > to fail because binman is not part of any standard devicetree sch=
ema.
> >=20
> >=20
> > This is great, and I look forward to this landing.
> >=20
> > Forward looking and just a little thinking out loud here, forward looki=
ng is the device tree format the most straight forward way to describe the =
requirements for this? I wonder whether something like toml or even the in =
tree env format [1] might be better suited?
>=20
> I was having these same thoughts. And if we were starting from scratch, y=
es
> I would have advocated for a different source file format as well. Changi=
ng
> it now though would be quite disruptive to those depending on it. I think=
 we
> would need some motivation more than "devicetree is not the best choice" =
to
> justify changing it at this point. And even then the devicetree format wo=
uld
> need a long phase-out period to give people time to adapt.
>=20
> At the very least though, it could be nice to eventually move the binman =
dts
> source files out of the arch dts folders to make the separation more clea=
r.
>=20
> >=20
> > To be absolutely clear here, I think this series should proceed and I'm=
 not necessarily asking you to do it, more just gathering ideas/opinions.
> >=20
> > Peter
> >=20
> > [1]=A0https://git.u-boot-project.org/u-boot/u-boot/-/blob/main/board/ra=
spberrypi/rpi/rpi.env?ref_type=3Dheads <https://git.u-boot-project.org/u-bo=
ot/u-boot/-/blob/main/board/raspberrypi/rpi/rpi.env?ref_type=3Dheads>
> > =A0
> >=20
> >     > Currently, only Xilinx is doing this kind of separation. This ser=
ies
> >     > makes it possible for more platforms to adopt this separation. Th=
e first
> >     > patches fix binman so that the image gets the U-Boot control devi=
cetree
> >     > rather than the binman one when the two are separate binaries. An=
d they
> >     > make BINMAN_DTB work with OF_UPSTREAM, and document the recommend=
ation.
> >     > The remaining patches update the MediaTek Genio targets to make u=
se of
> >     > all of this.
> >     >
> >     > Signed-off-by: David Lechner <dlechner@baylibre.com <mailto:dlech=
ner@baylibre.com>>
> >=20
> >     My more direct concern with this series is, who has some review cyc=
les
> >     to step up and co-maintain this tool? It's already been privately
> >     suggested to me that we could drop the lofty "one tool for every pr=
oject
> >     to rely on" goal since most projects continued to develop their own=
 tool
> >     for assembling binaries anyhow. And that in turn reduces the scope.=
 But
> >     it's still an important part of the project and so needs some people
> >     looking after it with a more global eye.
>=20
> I might regret this as I am as overwhelmed as anyone else with reviews th=
ese
> days. And this is my first time touching/using the binman code so I don't
> know much about it yet. But it seems like this is relatively low volume a=
nd
> I know Python very well and this seems like pure software so I don't need
> any specific hardware to validate it. So I could try to help here for the
> time being.
>=20
> As a fair warning, I do tend to want to be a bit heavy-handed with my own
> changes when I am the maintainer. The current binman code looks to me like
> Java written in Python 2, which I find a bit painful to read. I would want
> to "clean it up" with modern automatic code formatters and linters as well
> as add type hints to make it easier for me to read and understand so that=
 I
> could maintain it with less effort and also to find latent bugs.
>=20
> I also see there is an active fork of binman at [1]. So I would be in fav=
or
> of letting that be the ambitious project and trimming down the in-tree co=
de
> to only what U-Boot needs.=20
>=20
> [1]: https://github.com/deinde-dev/binman

I've said a few times that I think we need to figure out how to handle
some of our python tools in more traditional (and so friendly to Python
developers) ways. And yes, this code was originally developed with
Python 2 and I'm sure could use some real refactoring for modern best
practices. So I would be very happy to hear someone who is a Python
developer (which is not me, my Python looks like C, which is close
enough to Java for this ;)) propose how to do it all better.

--=20
Tom

--GmFL/CD4eta5Z5ng
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavtPDwAKCRAr4qD1Cr/k
CqdEAQCD/fwzd4UcaE9XlYg80f6/pwVSraIRnXt54P7AGFJ+gAEA4l41+2G9FfgA
R6BzYk4adHwdx1/NljIy6/o1Wap/KAM=
=V0i/
-----END PGP SIGNATURE-----

--GmFL/CD4eta5Z5ng--
