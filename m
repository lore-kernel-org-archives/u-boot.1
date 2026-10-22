Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25EC606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 00:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KJy5nNwq;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ZHdy9XTy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B25126126F;
	Thu, 22 Oct 2026 00:27:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ARbsSIPWk-Zy; Thu, 22 Oct 2026 00:27:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E9BC661271
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792628878;
	b=W10wIRJe7Z53MXZAtrIEi2NjyhfBC8LwcHgkaA4PiKaSGnReXSMBkPTG7zzCKEy5zvvg
	 VP9sERDenIVP93f5llQiWkW8b93nhYaThOsFKH7tdtlEunNzU47q+L329o6HCxWwCokn9
	 c5+OKmMTZcGiNWU2RF3R54RVMimZQzGS1YQWi2v0e/kL1rvbw8oZcXPwiotz2BxDcT3f6
	 CLZIZa88Jkysd1IFQMfQSwmBSI4WGdrh38v0t9wl0l7MBzKAQBAid310fqXtPbfgBJHMP
	 mSto90bByMI+huBG5jXpx7vTtG9xFWLgo+tOwVniwpqpJsdDWtCf2QnFZwNIFHCV11w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792628878;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IxQwk0xJQZWI9yG9486UkRIszZkSoZEZIkPwJvcUM6Y=;
	b=lG5rSnlQtdZ8NB91Z3iDWKrhuNpZwVVLlHF5MYXRlGEqexPAArTyp3OU4pgRFSfVfvzJ
	 E9Aknh+Lr4Fk11DtBSIFRgvZmmc2CS2L7gAFcW0RFEMVZtwY407l2SukDjMSF27VttrOK
	 0gxXVfTo0hnlqTx3UsvJ97nGgFbJZfUVAvooVfZWgGM5diUsmOVESWEX8w2aAM7jEAGEp
	 +GVNrSUPF74m/DJ4zuVrdt85jxAsu0mx0SfMqYYZUIBQiErXMYYlojKQ0P2SZgj6wRjX5
	 zezTAut3HXG3IzO1IBLlTiY3M3gx3YXRZS8J2CNwUG4dFNP2RtTkYGuA0t9EvOp2hGA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792628878;
	bh=IxQwk0xJQZWI9yG9486UkRIszZkSoZEZIkPwJvcUM6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KJy5nNwqMgrrBktX8cubRqq5Rr4ZZkts0qm2g6SbcIaeEPn9MDHCFYnQ1xKgggWuJ
	 q2uZqzl2ypdRhwkkykPaUePm+etCMJbWyn85/5oYrJq2uR44EP4/OnbvojP1yAo0c/
	 7Oh0TUeckHOapNEIM/lz/mldA1X0ENv5jJB9/dlb1W31knEKXqX6yoZnh+krKaImNP
	 NwbMkBNFjeV71vcLHKUwcet80WwEvKdK9tRJskWpAopyxNuIuqreVWZb3/m7sDuwcE
	 0LqWYbri083xl15ydI7NUpcHjIzTN0TuqUyqq+gbP6v72AwndwfExlEBrSOL4TCJC0
	 MBiAmTFbHbRWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9BC661271;
	Thu, 22 Oct 2026 00:27:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BD8F3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 00:27:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 615E880B08
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 00:27:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O_QXJo4fEs3V for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 00:27:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9934B80AF9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792628875;
 b=ajTEEgNwZbqHKRrthxlfw/zfNm0Paxw7yOpyMTmZER2zAxPlGq6PRX4r+6dONN4ERYJ7
 RcwUnsDlQh0MLP9qQsGdg7y1tVlcOfGneZoSz3iMNAyXhca0rLKWnjnwl2B2YXwopogOS
 wb4p3pMAhiy7V23mh40IexnWH/Ue9Gp53Ec4DxIv7rR5RfI6n9jsXseaWqENskSUkyLBa
 o/PSrZj+Lg7yTm6AzJPLMaUh73TbwEi5QFH459LpUzrz92ZL3DyGxCtspt4VJ3r+BWHMU
 3J4Yq9ksW0hAyzbhqoe26eihZnvKEKnYurSL2HVo3Sq7dSj/rGbwWn7uuY0IX2tLyHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792628875;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=IxQwk0xJQZWI9yG9486UkRIszZkSoZEZIkPwJvcUM6Y=;
 b=Yz71ubxN8+30+I4lWUrN1xS3aaWzwuqpH+1q81TZNZ11tigAOGL0l1irx8AuMVnqS+Mu
 2+D04BdW7ayaiTTzWpv8fENaJezYf9O9hUlAHE/1LqP+CV7kSJc8pyyke+DnVLIU2/gQR
 EzWOgd5ySGKP2ZrSowGuDgvRdLqfnLuoQRKdvmvivsh1pwhoR4uNEay0fVXqm8IM7HDlh
 NytME8T3CZOnOJVT0lXItXb6JI80/GjJBy22e9PfzHDjrlnRF38iMsuUqSmn6QNuI2xXf
 gsg5mJwp4/PyC1x8jnib5HeiZOIMolCI74kjNwKsGlfpzd8IUQeVr5GOShlYN4lldpA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZHdy9XTy; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZHdy9XTy
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9934B80AF9
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 00:27:55 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6df0b02fe91so268245eaf.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792628874; x=1793233674;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IxQwk0xJQZWI9yG9486UkRIszZkSoZEZIkPwJvcUM6Y=;
 b=ZHdy9XTyJE/oh8/h46FAtziq7mrHX1mf6kccW9xETJo7+CGV02hcM49pbnqrhHwFGe
 6IFspvthtsI6wxXDRgkPqsEkjGmgdLP+x4kQGHnDHylZmVsZbYoRV2uwmWcVSX4+oHcO
 omzRzGXh+xnuwfDEXVfgxUkQMa2wYPfZU1lHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792628874; x=1793233674;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IxQwk0xJQZWI9yG9486UkRIszZkSoZEZIkPwJvcUM6Y=;
 b=popBdTWVdO5o4COb1onsmkX3AYmLWN6JeXA65kU6yMrcPbnIH7RuItB4p/5yipyV6u
 Rw0mMF2Ij4gqlnlrNeK0lAfVUuLy8Z4xPJ+xC7n5QS5sG9FJQb1fuU3oifuTm8QJBOvV
 cb7Tj9WdR9kWm+WAvN4zlJRWODtsDcH5618APMGzaw3GkDwdDMN4cGqTgOQm5lS37/Ev
 N7AyjVKk8cCgmXS9lcRJzJFzCAmTT3RN/DPJCq//+Zq+jV5DRVThntvhvLMa84F1/OnD
 jbDR/LmJj7qaivPkmFNQIMR98zwj79mLv6v0Z+dcvpccd04PpKlunzkseum1P816aipw
 V18g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwY0QHb+w/I4bCP1nq2jVC7OdAly8ok+CJZ9eZNUhFUjeuE+effH4hnKi5YRVi/yat4hlBKCC8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLpjrJOim/1VNkwMf82fcbxnbpOxZAwlrgE4qYDRKnYu/L+Klcd
 8jtl2jIeKegNT2S/aljKy+MXDVgu8x1tYs9CxfAMBY26OeOV181JB6c83x1eR7oth8U=
X-Gm-Gg: AYBFou3VvnIRCmdsu1NkHNh17DdZfJW645iIKUxh5ZKD5AaNVnFwvMegANYqX/IEgx/
 fhQo4/v3SfaQlGRoHl/jFhZre0B3eeTRnq3btVMoU7buSZ3nSYxCk01H9+6UlEwEKfoyg9CB9K+
 AG6J9T4rj67aQJ/GGI3a+WVMMq7wM2VwEpeP0qH9Pt2gzDrmwUzPt3uDqHmx1mKJ8HncxvnI1pb
 66vhzXy0asnOykP12sXUEWzdAurAjx9WHvBQzE/IpCjCYaGvdi8gquRQiOTG9wp/e54gzSkcew4
 2971oAj7wxPZ4YWo1BXEdS3xsBI5NSrrWbd0OAeY0XthbqokMoyR68UltrH9O7L5qHc/2LQnwSv
 EMPw2adoyQ7OiUXafTFkEvewJtelkd8WI/H0G2RAxKSc53lSh+1v3JmgSn8lXXiQGWj81n4KDgB
 uny9mDafTV8OhsRcXihT5o2Kil4EHtMO/sr+/qx28O2NVG7x37FQQgdpbAFdbfthnEOFXTEdUPg
 ldSi2BrgMg6y2q2pnpJIsh2CRZVObfZtJ5pA1/kL0CONF1xfIifZmLBJzKQyK7FcCjVWARaM2sO
 i7NrocVc6ukoYc5PsY3l8JvFRZLgEqdyM1D2zhMI/fpgBMAdP2zph4juLqY9Q9JPrmmz6pV4ltH
 sfuEmp0XTld8GxVbz+WV0Ho0=
X-Received: by 2002:a05:6820:2006:b0:6f9:f85:aea4 with SMTP id
 006d021491bc7-70a7f203e77mr552924eaf.33.1792628874245; 
 Wed, 21 Oct 2026 17:27:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cbd2d04b5sm3894800a34.14.2026.10.21.17.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 17:27:53 -0700 (PDT)
Date: Wed, 21 Oct 2026 18:27:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 u-boot@lists.u-boot-project.org, Vignesh R <vigneshr@ti.com>,
 Ssunk <ssunkkan@gmail.com>, Jeffrey Yu <jeyu@issi.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Flaviu Nistor <flaviu.nistor@gmail.com>
Subject: Re: [PATCH 2/2] spi: dw: Add supports_op function to reject
 unsupported transfer modes
Message-ID: <20261022002750.GM3275858@bill-the-cat>
References: <20260803-spi_fixes-v1-0-33f36e764104@oss.tenstorrent.com>
 <20260803-spi_fixes-v1-2-33f36e764104@oss.tenstorrent.com>
 <20261021205719.GA3366009@bill-the-cat>
 <CAEev2e-afN=ryWtttsRL7UYWqawRggTPA3jrn87Ux6h2YycTfQ@mail.gmail.com>
 <20261021220037.GJ3275858@bill-the-cat>
 <CAEev2e8o97gL=6tud=yYcadSNbJjM8aN5eqY7wx235t94E0WXQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="20K782bQn1R066Sn"
Content-Disposition: inline
In-Reply-To: <CAEev2e8o97gL=6tud=yYcadSNbJjM8aN5eqY7wx235t94E0WXQ@mail.gmail.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--20K782bQn1R066Sn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 05:29:26PM -0500, Anirudh Srinivasan wrote:
> Hi Tom,
>=20
> On Wed, Oct 21, 2026 at 5:00=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Wed, Oct 21, 2026 at 04:14:42PM -0500, Anirudh Srinivasan wrote:
> > > Hello Tom,
> > >
> > > On Wed, Oct 21, 2026 at 3:57=E2=80=AFPM Tom Rini <trini@konsulko.com>=
 wrote:
> > > >
> > > > On Mon, Aug 03, 2026 at 02:00:35PM -0500, Anirudh Srinivasan via U-=
Boot wrote:
> > > >
> > > > > The designware spi driver doesn't support dual/quad/octal modes, =
but
> > > > > the driver still tries using these modes when it sees a capable f=
lash
> > > > > chip in the devicetree. Add a supports_op function to this driver=
 to
> > > > > prevent this from happening and force single lane operation.
> > > > >
> > > > > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.co=
m>
> > > >
> > > > This introduces a failure to build:
> > > > +(socfpga_secu1) arm-linux-gnueabi-ld: drivers/spi/designware_spi.o=
: in function `dw_spi_supports_op':
> > > > +(socfpga_secu1) drivers/spi/designware_spi.c:707:(.text.dw_spi_sup=
ports_op+0x18): undefined reference to `spi_mem_default_supports_op'
> > > > +(socfpga_secu1) make[1]: *** [Makefile:2131: u-boot] Error 1
> > > > +(socfpga_secu1) make: *** [Makefile:189: __sub-make] Error 2
> > >
> > > Thanks for catching this. I think the solution would be for
> > > DESIGNWARE_SPI to select SPI_MEM. Other spi drivers that call this
> > > function also do this (nxp_xspi, spi-aspeed-smc, cadence_qspi....).
> > >
> > > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> > > index cfbedd64c4c..a5623a2cec6 100644
> > > --- a/drivers/spi/Kconfig
> > > +++ b/drivers/spi/Kconfig
> > > @@ -222,6 +222,7 @@ config DAVINCI_SPI
> > >
> > >  config DESIGNWARE_SPI
> > >         bool "Designware SPI driver"
> > > +       select SPI_MEM
> > >         help
> > >           Enable the Designware SPI driver. This driver can be used to
> > >           access the SPI NOR flash on platforms embedding this Design=
ware
> > >
> > >
> > > I will send a v2 with this fixed.
> >
> > Yes, and please have that in its own patch as a bugfix. Thanks!
>=20
> Is a bugfix required here? The designware spi driver currently doesn't
> rely on any of the symbols provided by CONFIG_SPI_MEM. So it doesn't
> need to select SPI_MEM currently, right? It's needed only because my
> patch introduces a dependency on that symbol (so it should be selected
> in my patch only).
>=20
> If there is something else I'm missing, please let me know.

Ah, I misunderstood your report, nevermind.

--=20
Tom

--20K782bQn1R066Sn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatlYgwAKCRAr4qD1Cr/k
Ctv9AP4xfI2xkc3jnlGcxp/UGulTm47gRPRC2NgynfxE9LyyXwEA3qc6la9AQNu5
bRtb8QrPouUlZRTzJVV14w/jTZc7PQE=
=OSAE
-----END PGP SIGNATURE-----

--20K782bQn1R066Sn--
