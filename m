Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4FA606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=k0cDE4Ei;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=sBmbTlOu
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3EE094089E;
	Thu,  5 Nov 2026 14:48:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C3otKJ6xOooa; Thu,  5 Nov 2026 14:48:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 89C144084F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793890123;
	b=Pg2YjzJwVNdeFJ2Lq3XAH5aQ1kL3jgpjZLAgII6khN9BUpGAIau5F/eQdTaXdVwcxvZM
	 Hk7JtuhAUtyzHTMN3VG/w/RwR2mQt4Q0QVzOw32FS6+yU72FWQTs6Gs9vZP1VxA3lRayt
	 YqPb6qEbYxCI6q9BRVDtIgZqpFKA1Katf1XTotpb0QsGK6lgL9m0wGxLduEdQxJPIJJO2
	 mAAcdB0KD/puWlFueP3L+A8y1XP3ADX7Jy6kwfSPQ+0y5lHXrU7B9aA6J3EVo4uTioKUc
	 MDRpgHX5yigP4f1du9lI4cSPQdFoR/Xmz5uRY0R5MktIhhytb6uTdlLGyXK3pYWL2QQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793890123;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fhWUT++5Rl/jUVs7zYurlPqbpJViafoBmd0JsgTSFD0=;
	b=g3n3s9Vupofx1rFCAMpaNgLzldIHFsEfNx6YfIDzMCHG7XmJLtF7hBAFgUeBJLvBytQB
	 kPLzSISfvPfaW+LuhkwUoxAs0I355fRKPOG4EBGCPwrqRBDucMVYfbXY/cBCEjY1ax4v7
	 KHVwICGDA3Y9+mdqNyfhPt1a/YqWTVrazR0fHVzsIkv6c6IoVcL+11RmaOCsjXrpT+ka2
	 Z+0oeaKEzqBO9n3CEN1IwTYM6GRlp45mHrj5ul4dlvXt2QyyVALua1BaDvvWau4HW0dQR
	 yhOuIXjMBBusUcuDPLpz6MxxLKO67p5gFRUuH97FFPZIF+6fq/QZAgIDNV2kBsKf2xg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793890123;
	bh=fhWUT++5Rl/jUVs7zYurlPqbpJViafoBmd0JsgTSFD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k0cDE4EicXo01MFo4hHhNaUPJXgPEs8A6BMa7e1MaIYtHTLiXyCM//ERlwsMhXsdV
	 DsEbNuiJS0xy+fgZfy1SbTRisLXrzRJ3vmM+TeCqQOI9DriHhID/BpTflfp7pBrA83
	 A6mtQuAyXFC2+WyKJkTokIl9zMpgooERXnTVBD4KZ1yHf9mRufB1TaTLZndMiUAxg3
	 cWQn25Cw06NH5X9AqH9WnI4kuSBcowuJCH/mpf8dDlhi4LjJiQddTbAFHFMZ/20TJt
	 Xsbnw3b54ksJeCmxsUhZ5iTodi6tzfe6+FoWnibvhK2kxLgDj5WUEuSV+QrE2QPYwJ
	 kBavH+HL6lfgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89C144084F;
	Thu,  5 Nov 2026 14:48:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A2781235
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:48:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9466860847
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:48:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BmWCf6JeB4TN for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 14:48:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D168E607D5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=sBmbTlOu
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D168E607D5
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:48:40 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-854b6e2e41fso1111516a34.3
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 06:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793890119; x=1794494919;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fhWUT++5Rl/jUVs7zYurlPqbpJViafoBmd0JsgTSFD0=;
 b=sBmbTlOuDQ4bYHUc1DszeLKp/8d6DAMo1OM3mhV4pcmdxONeKI8dCQJotQ5qzZiXhi
 eUz2xLPgDp1GLrVQ0ZLVfl/mg08M3Wp/Tw7bVCkX74fqHP3Zov4gA+KYQgjDYgQEh8dL
 0fYNrlhAS32BOToueJiExVaLG2Zocc/r7X3ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793890119; x=1794494919;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fhWUT++5Rl/jUVs7zYurlPqbpJViafoBmd0JsgTSFD0=;
 b=EEe/R5Vb6Kq8O0XH0Uzw9gNzWGcYvuwqOdbQgIdeS3NoU9oFjjjm2CdKn0Bu7Y7lbw
 eQEKvdH+UORUo9iL2j8J1WopjyT2tW4XhTvr9hF6/Soqp7MLAdnX6Id3anKcjpXR1sLD
 GsZmaryr9U6qOlvyLVGm2tKejqmAga8t/oRX4eCP3bd5mPOS+nBUyBR5dNNN/C2fYwoH
 48OQbHzOKOJujJS7urSaw9Y/NV368Ow5OJl79438uT2bK2ZdkS33SREzZq/TEO0TkYXq
 HHqo/hIsSzEeR5vK0XZP2No9nQgRzyCIAdHOldAx5zaElvulcgih95a/r96IihYaMGiu
 HZfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYkZgc5phQhe5JJ6H1w0PW4m/FXRgR58m1EOkobpMkLQY1HPy/MzmjweSAbcjyDx3mOJe3ZNM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9JILo62iBjkJZkHJWs/6F0AKNFof/2pjpoD6Hhn+pFBcfYLBZZ
 f5xUS6AQaMScm7Jf6mPwQxwEyLS/wA4hAxnC15nqH34gBDaSP0vbGkRiUy+1DjZLBKA=
X-Gm-Gg: AYBFou0d0ro0TCnh3k5UF+JZGicPMrko9Nc4aXZDIb2rRCrTtfx7MFdJ9VFzfZgeqS/
 3ZtJpO3MjJE8t/23zkV3AGJuPF0YI3ifKo/53lx6mvUJg7MkbA3XsVdAvWiKECtbgvZYQylA5Kg
 bQOko6UMgvFr74hlE2i3AnMTxnU6F209JHcaO8Uzb5Z8x2AAx1hDz6im6kwTIXP5cH2MZaeUbVZ
 FhjTL+CL/fnYk63wgUlCxEzY2jgxZw3iME1oxZPDnXH9xBIrelEk2NLy68TRsNZ9O+nUs+Ntyip
 +tUzi/xYX8b0zJ4Xwdjv5ewmyVIeBKmiwz7OUEV8Y7Yf6iJsM66y3ALHRegGOkxpiZx1jCAOjg7
 NlN1NhmDbKdZsm/gIokr2FJ7VpTFI4UOeoCsOf/WM5KfMTcY6ujE2MRnQ1YHOGEx/laSlyabw0H
 OFjVmulWHE0wL4uZO7HEKzTRH3o/zTUTkcpFomUec+RLyWk7g2xkYOHVHyUEhqrWZ+8Wb8oyYHS
 xIkXnHNvCbdekrUZFLqHsdY/lUkYzpgFVmormFi7yaDlJOFu6eSqrNtsQOemtvhlTTZup4fb0K5
 kVrDkslQSJie5HX03Sk749k980Du3UwumqM7R3+/PyG6le/cVXq3RqGnrppswlri6s3vnIH+Js7
 sRLenLziAHsCYv+P7KVdbxpBWmhcdhJ+whj/p+tJKZ/ldmz1VRqJPTIG5AxVmsaFoIlqytNg0Ue
 W6dvr1xpukBGKFHrEd5WFMykIbZOnuyg==
X-Received: by 2002:a05:6830:4120:b0:81e:abb6:7498 with SMTP id
 46e09a7af769-85d365df1b4mr16150326a34.23.1793890119249; 
 Thu, 05 Nov 2026 06:48:39 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85ef3e1f2e4sm4688039a34.16.2026.11.05.06.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 06:48:38 -0800 (PST)
Date: Thu, 5 Nov 2026 08:48:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 David Lechner <dlechner@baylibre.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Yannick Fertre <yannick.fertre@foss.st.com>, u-boot@lists.denx.de,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 00/33] Add Engicam MicroGEA-STM32MP257D-RMM board support
Message-ID: <20261105144835.GM1164024@bill-the-cat>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
 <20261104192118.GD1164024@bill-the-cat>
 <CABGWkvqisJBzV=tRQrhZ87evgF6mTff+dJvO1LVwVQC-YX=DpA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BmiASaNPb0wOAQMk"
Content-Disposition: inline
In-Reply-To: <CABGWkvqisJBzV=tRQrhZ87evgF6mTff+dJvO1LVwVQC-YX=DpA@mail.gmail.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--BmiASaNPb0wOAQMk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2026 at 08:12:07AM +0100, Dario Binacchi wrote:
> Hi Tom,
>=20
> On Wed, Nov 4, 2026 at 8:21=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
> >
> > On Wed, Nov 04, 2026 at 09:49:33AM +0100, Dario Binacchi wrote:
> >
> > > This series adds support for the Engicam MicroGEA-STM32MP257D-RMM
> > > board, with its RGB and LVDS displays and the FWU A/B update.
> > >
> > > The first patches pick the board devicetrees, merged for Linux v7.4,
> > > from devicetree-rebasing. They can be dropped if dts/upstream is sync=
ed
> > > with v7.4-dts first. Then come the fixes, the refactors moving the
> > > STM32MP2 environment and FWU support to the SoC code, and the board
> > > support.
> >
> > What's the status on upstreaming all of the changes you're putting in
> > the -u-boot.dtsi files? Thanks.
>=20
> The -u-boot.dtsi contains:
>=20
> - U-Boot specific nodes and properties: the environment partition, the
>   FWU metadata and the bootph-all properties.

bootph is to be upstreamed,  I don't recall where the FWU stuff ended
up, and I'd need to double check the specific environment binding you're
referring to.

> - The RGB and LVDS panels, with the LTDC and LVDS endpoints. These are
>   already upstream in Linux, but in two devicetree overlays, one per
>   display. Since the display is selected by the "display" environment
>   variable, which is stored in the eMMC/SD and is not available yet
>   when the U-Boot control devicetree is set up, both displays are
>   described here and the board code keeps only the selected one.

You can't detect and apply the overlay instead?

> - The LTDC "lcd" clock for the RGB output. This is not upstream yet:
>   I sent it in an RFC series [1], and Gabriel is reworking the STM32MP25
>   SYSCFG pixel clock support, which should cover it. I will drop it once
>   it is merged in Linux.

OK, thanks.

--=20
Tom

--BmiASaNPb0wOAQMk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauyXQwAKCRAr4qD1Cr/k
CtWcAQDipItK9tSGnboue0ch1agOJAsLmTbVCbtKcXKSPAxi0AD5AUyirEUz7DWn
P17DNACZD2S6MXwW42E7LMNVID2dEg4=
=IKS5
-----END PGP SIGNATURE-----

--BmiASaNPb0wOAQMk--
