Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CB9C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 18:31:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6668D60604;
	Tue, 25 Aug 2026 18:31:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8CW6pycWEtj4; Tue, 25 Aug 2026 18:31:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787682687;
	bh=GapacilT8qpuL40zKfgVuPii41rK6fAoXipB1e8/R0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k3A4KVUdjHCp8XcKO8AQEcoOtQLx9hzvU8DQhmjjY7WWvOZg2qixlNjnALRxW6P4Y
	 GtF61zbniM+JcUVdd3wqRl9MB5LHVWLXCkItnxvfA7COXLdhvjWJzfW4InlbockF0M
	 3RwJJalzfWtx9a/o477CHXc1epevcNuWct5tnYhoRbbSpExRAbaLMfxCN3Sj+1tK/3
	 eILoeZMggdDAP0DDQE968Pvagg05mgZThJGy07OvKDA9dbOaNeCS8Mvdg1CxffLacI
	 zN5WB8K4T+vrJvyCMBIKpKZkpdS3qj3TYlCRKHUluYQ6inM66a/ZrrqzronWul0/s8
	 iwvGSUvy4Nvkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EF8C606E1;
	Tue, 25 Aug 2026 18:31:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 17C32105
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:31:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0973240068
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:31:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ueayh7284t1D for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 18:31:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::;
 helo=mail-oa2-x00.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=izmrZAj1
Received: from mail-oa2-x00.google.com (mail-oa2-x00.google.com
 [IPv6:2607:f8b0:4864:30::])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E30094004E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:31:24 +0000 (UTC)
Received: by mail-oa2-x00.google.com with SMTP id
 586e51a60fabf-451e22b4773so82238fac.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 11:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787682683; x=1788287483;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GapacilT8qpuL40zKfgVuPii41rK6fAoXipB1e8/R0Q=;
 b=izmrZAj1XOue31rlKjAelZcfdEPJgpKMX94IjvVx23ecAzHYQVgCK+2KI09deFBkTt
 hU6OK7b6eVzhCun7Vlcs2JhTPNRmvoy3Fdj/wGlPhjgSHHc/U00IORNKWDAYPYr7Kp+S
 2TqubZQ9i5fmj7VeGUWsPMktoG0MoQBBSyxdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787682683; x=1788287483;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GapacilT8qpuL40zKfgVuPii41rK6fAoXipB1e8/R0Q=;
 b=khbqC5KMlMLwPit4KOGcv531UMsRNW0zcIcTv+y13GUlQidjr6IyzRfSPlqURIF0mn
 UP593KPvrSXeiVu2lsAo5LCVGqxRmA3HxgHCbWtEKetz+LerGmuyNC/7JszLy5ClXzYR
 P2+93bLR7sD73yxq4OvwUz2oInSh8WX5cJbPo6Ie2VzmL/dGpUz6CQZUxh6KOkBAGXmI
 PJL1dYnM3qunI6zYLH1W0XY30c3tjmhGYxiGOgOiUWQ3a+sUX6sSJvvrbGp4dSEik2bj
 +v9ARz4JHfM4ZSlhP65U4+CGmWFc6Fh0ekf8pJXWs9NFfhmJ86U3qXoZczd5DxHtSCkn
 8y7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp5ZPPyV/O8IU5SvaZCN9gLkWdf6Xd9JZCjKABlD9DPQQAAlqqCiuxdBgoefuM6FUEt5qvAJw8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lFNxrRf7LZs6Rd0qh4LmBlDDIXHP0NcOKUYY3g/krGye2QnGok
 036vtdjWNFTAD2kws7L0RuzPoQMUnekjE9d+gvhHJ8s1S+bZ50tav9mVxi1/lU1y5p8=
X-Gm-Gg: AR+sD10TvrufnhBhIHuG6LX/EfKHhujYHPswKgDkkdoSiQR9wnhPFvWcPYg7zeuK4Eg
 qiaNNDFmRvGlxDyVDiOCDCI2/cGSSQSiHk5svDe+2AlEpWXMNDimTSYZms9GUhOUW7NItmeYk9E
 poWshsAd8Ro/DPHUrZOZ/Y0oYRiehf2+qPiJp+Bc21aPB4Yaixayr6NyqAucdDDVAsUmrXES877
 qoJhWk45Qrejx/WRZLH6k+XshAW17YUW/i8RVD1f61r+tV52RfKtoyGlvUAvZxgPYzS6lQtDg/c
 74o+QW/EJoIrbQwv0qn8dxxCXwit6DIfKY9NSh9x9tbI1sogVU0l4EU/di3olkwbqk/TjN9TXei
 ZHZNUMme0Rokd3S66CMDw5slg4/o08Ul79Pn7Q5avNbFeP4jEWhVZSbv+g52vr984aNGe2fJfMe
 hh012jK3clPUbMh6xQr7J5vvaK3f1vsBfN7Z2BjeTsId2OEGc0TW9JN98uj1AUxMhhhxdJaPtjm
 qb9kk3arBj9OwgIeTCTaCb3SSU9Mqse/W8dJiDj91WOyoW0U6udJ4SdfmtwFhAbWUSlJTuDD7vO
 tcxhENOIUw==
X-Received: by 2002:a05:6820:340f:10b0:6b1:9f9d:7a00 with SMTP id
 006d021491bc7-6b1a03d51f2mr761167eaf.5.1787682683293; 
 Tue, 25 Aug 2026 11:31:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b1a02594e4sm217853eaf.9.2026.08.25.11.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 11:31:22 -0700 (PDT)
Date: Tue, 25 Aug 2026 12:31:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: mehmet.fide@gmail.com, Marek Vasut <marek.vasut+usb@mailbox.org>,
 u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: Re: [PATCH v3 1/2] dm: core: read the device tree into plat data
 after pinctrl
Message-ID: <20260825183120.GY523975@bill-the-cat>
References: <20260820102523.1076815-1-mehmet.fide@gmail.com>
 <20260820102523.1076815-2-mehmet.fide@gmail.com>
 <CAFLszTgoFUjBBPEx8hzYop-2MyJ9O9b=2t8jRQ=4_9AaoCkaCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bV6lmSBINvTyIEYi"
Content-Disposition: inline
In-Reply-To: <CAFLszTgoFUjBBPEx8hzYop-2MyJ9O9b=2t8jRQ=4_9AaoCkaCA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--bV6lmSBINvTyIEYi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 12:16:18PM -0600, Simon Glass wrote:
> Hi Mehmet,
>=20
> On 2026-08-20T10:25:21, Mehmet Fide <mehmet.fide@gmail.com> wrote:
> > dm: core: read the device tree into plat data after pinctrl
> >
> > device_probe() calls device_of_to_plat() before it applies the "default"
> > pinctrl state of the device, so a driver that acquires resources there
> > sees them undone by the pinctrl state that follows.
> >
> > It has not always been that way. When the pinctrl uclass arrived in
> > commit d90a5a30dec1 ("pinctrl: add pin control uclass support") the
> > state was selected before ->ofdata_to_platdata() was called, and it
> > stayed that way for four years. Commit 29f7d05a347a ("dm: core: Move
> > ofdata_to_platdata() call earlier") then moved the call up so that the
> > platform data would be read before the device is probed, which is
> > reasonable in itself, but it also moved it above the pinctrl state,
> > which nothing asked for.
> >
> > GPIOs are where this hurts. On most SoCs the direction of a pin lives in
> > the GPIO block, so a pinctrl state cannot disturb it, but on Vybrid the
> > output buffer enable is a bit of the pad register that pinctrl writes as
> > well. A fixed regulator asks for its enable GPIO in of_to_plat(), so the
> > pin is configured as an output and the pinctrl state of the same device
> > then turns it back into an input. The USB host VBUS regulator of a
> > Colibri VF50 is one of those: its pad reads 0x22ed once the regulator
> > has been probed, the value from the device tree, output buffer disabled,
> > and no USB device is ever powered.
> >
> > Move the call back below the pinctrl step. That is also the order Linux
> > uses, and the order the board code of these boards used before the
> > driver model: set the pin muxing up first, then take the pin. The
> > pinctrl step itself cannot move up instead, because it relies on
> > DM_FLAG_ACTIVATED having been set to break the recursion described above
> > it.
> >
> > Nothing between the two positions needs plat data: the parent probe, the
> > power domain and the pinctrl call all work off the device tree.
> > [...]
> >
> > drivers/core/device.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> Please check my comments on v1 when patchwork is back up:
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/20260819143543.427396-2-=
mehmet.fide@gmail.com/

As mentioned on the call, lore is up to date:
https://lore.kernel.org/r/20260819143543.427396-2-mehmet.fide@gmail.com/

--=20
Tom

--bV6lmSBINvTyIEYi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao3fdAAKCRAr4qD1Cr/k
ChjPAP4s1+MjSM8qFDhc0XeYZ8njqzhU5qT3ZknwZZEhpR3U+gD+JCSX/N4Qm01F
crIUM+7Y+Vtt6bwlFIanj7mZqRxv+ww=
=JftB
-----END PGP SIGNATURE-----

--bV6lmSBINvTyIEYi--
