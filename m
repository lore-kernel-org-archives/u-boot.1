Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85274606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ShYaohMM;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=fny6Xxk0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F301E406C9;
	Thu,  5 Nov 2026 17:26:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rd2hnw1pm_34; Thu,  5 Nov 2026 17:26:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 11A5640515
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793899584;
	b=E1QgedfvCD/2a+3WbMuCNJrEgIAKeYNiup+DSCWXVCjliUxE9cEGKB3k22upz7SY8+pW
	 6b9CTveystTRWS+9CxKP4dRHol23Xw7D3gXNyrOZQ/2xtHaPQmUX/bVAZnEWSSWV1oPvv
	 AhjZ1QitNWgNeN3XtxN5dlWSxu84QBcmcd8P+qOoNuINDCPc5fFH/FPJuoLCC1MYF0DD6
	 raLMTYD6KFjc3T6uLRqEDIfZTe1Ih7RBsRmZr5bv7BuMqUGXQvcVjcIoT/PrH6Qok4hjx
	 oJGLbOlk2HRhFQ4AJ16cJquDMiah9TAMA0H+ys2gs4sj/paD9lFi8dYVEW8Z74doEdg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793899584;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=p6jyzzlOKSi4s0wkTMS4vER/YFh9JHKKxYqy6fMhIGY=;
	b=XS9MznlOWjdresvGxCwecZS2c8AjikDCAOVDbmIRLP7IOLjikjbA5zaruiuFJtpHZO8B
	 QsVGvW0l7hi3sJfL80m4Pii5sCaW8lJxK/sI2AkU5qvR/f0EIiY4KmT9NKHZpSvN/KUc9
	 srnC4s7fcE0zWGc1ZftJ2vLLTy12aTpUcQ/SnhLNfMtucA8cUDTbvhPkkHCVqNiOptaFb
	 shlfRuSDt1hBdJwp5M8ymlTbfnIRlp3AReLGq5CnnycfYT160jZGDxGAEViexPeQbP+4e
	 NFoJqLpk4loDYWkS80lGDhC23ZwSIVkJSSIqUJrwM8WdqZ8F7wka2CCRZ3/Kee06+/Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793899584;
	bh=p6jyzzlOKSi4s0wkTMS4vER/YFh9JHKKxYqy6fMhIGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ShYaohMMakfjmFp6bk4cPXUUEO2f76RQ5Ix52PbwN0TqQf5QgZ0a44Cr/IJa1iq4A
	 AGa13eFY/LQoS4yLWc+gpTcWa00WQ7gnTS1bYTR/n2O75XQBh+sW+rzaFeWXiSVDNU
	 KK0pZy0DbUp3OrTbYLbwlSKsBQqjwNp72c2XfTHmDTrULkipZBx5X/TG/e33UjZcI1
	 AXJTV3KhXXHGUIk49kl4xkIInmEIcshuQpcJNTDVOaOdgzhOeL+snBQsjqlQyV/FXH
	 li3uIbOOPSLx0rJPYKtkGvfUy6WefnIfo7TZNfw+DxjLHMK6BES5QaWOLilJhgKz/V
	 1n+7gt64YgoCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11A5640515;
	Thu,  5 Nov 2026 17:26:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 77F7237B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:26:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D57340363
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:26:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q9_EyCoMD0tb for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 17:26:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 743BA401E2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::34; helo=mail-oa1-x34.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=fny6Xxk0
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 743BA401E2
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:26:20 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-4a75a5fa32dso618016fac.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 09:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793899580; x=1794504380;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p6jyzzlOKSi4s0wkTMS4vER/YFh9JHKKxYqy6fMhIGY=;
 b=fny6Xxk0t7UmfxLnE/yV2u3WyJ7KFhc5AE41Y4LVuS/a6NlWU+gaxRUgxIYY8EvGW4
 PQkbkSZIafSLLKbOs3FienLyEMQHmcfnsadbspay4mFtoQxh3PQD0xY00s7+oP4HF1/k
 P1GsybMa8ut+4T34XVrw8OdY2SDRJpDQd2pv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793899580; x=1794504380;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p6jyzzlOKSi4s0wkTMS4vER/YFh9JHKKxYqy6fMhIGY=;
 b=W4Ib1joIHEbotFxNdYchkPcSzrpZdfHpzgYPoqI0dD8iC7p1XqubMMRs/DDF61qmbc
 C59EkSTRzCSzbTdrpDZFyBrYdFwsBOi/PIDa4iXD7pAXUbahCvHre3z+1qCFzOkSKVo2
 Truv1RnO77qxtvLL8ZOhrTDQwiMeiZkMXm6C2+9H2cPOWuFMjbsAzSxhdaFEivvGAV5M
 WD67v9kMmE9k5tQNx4tJOAj9wRbMR0ySsi0h0ZMOgkStmDFGSO3HYo+jPMgUoXyGaQ2w
 sV0kUtQksfprjHrUC00VOj/prJXkF4Vqpq+NJdsBCW6OFSFEWkrJS6PHpunKHBX2M6U6
 7qiw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOA6o0wwytXwbVuPcBk3TLj0hiZbY7qQlmcotfEgGg9g1F0n4pplRePiLXOufTaHghlPgjZJU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8vMk5+i5zr/h13iirih8NvsaZKKHjmbnV1GsPPEYIkFgULgKNX
 VmA2VFjD4VKqfS3i4KEBs3T0FJsKJnhJbMO4fcJwCstIid4Q/1kJDY02feoi6pnNAWM=
X-Gm-Gg: AYBFou0r5biTeM5Q7r/UbdZtUERhwUgZqk8Z3sEr8WRsfdvdvEK7gVOGYwYguSoOP2X
 ZKd182T/hXcAi3xlY+qbI3/Uw5cPn+vMMIfQkrGRrN4Dc23vQXfe1wPL9F1ffDiOK5ItEIN/hAD
 Z5xOY6WBGmMBjlX6xiqi//3ui32yo5zpKSZnPzFCbvMRDc1nANJyZEAgPZDu65rwcnQ6nVPHOdS
 vUZIgjCnZ3Ya5VAtkPJX7Tu0P8m8s5y/dw8W5dFat8PY7XKycGO1aTiXlBfPz3/+NvgT6LzAYnX
 V5AZht12Ohg8j56ILo+xTUoJgDX8F/SrO/+I2AtGu2YdfpxsDBKAlbzOW3C/UA4teTVDdTH8pYS
 H9ZDb5xPIIX8wHWcOI7EiBkrhso0Wp56tFqvjOj1b1egQ3ubm7XKyH29NTeP9hT8Kz2MSxP51EQ
 D+tdYgrd0+HOyZTC/wxpgGH/ufs6WQrZjQuhbUckt9uN7Dlb2JmqdIYItaBuDs2c/gVdFeemeCL
 rKIJjsPusrT/Up4W4eHRV+G+R+3dBVE8CehbYiSHG2nTSavBk/n25vdOqH+xvkk2iKXvSfU3bn6
 OBsYLz92D607pWo0IFy2ajy1fwAvi6bnloBtbbTAtw59+nuQYEUTpLGcNeOq+QA/Vx/goaWk3D1
 scSCCArpQvn/U2Xnk/mU0Ly+mU7/KNKFK5F9WbuMxcTuz7GYVnQDUlrAghsDrEv0AEpBiIZ4Kei
 WjHGMgU464PQbZzOLQj7KpQoeZZ1kRbw==
X-Received: by 2002:a05:6808:6508:b0:55c:6aa:14f7 with SMTP id
 5614622812f47-5640dcea008mr14713953b6e.21.1793899579606; 
 Thu, 05 Nov 2026 09:26:19 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ad6840797dsm2886615fac.9.2026.11.05.09.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:26:19 -0800 (PST)
Date: Thu, 5 Nov 2026 11:26:16 -0600
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
Message-ID: <20261105172616.GN1164024@bill-the-cat>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
 <20261104192118.GD1164024@bill-the-cat>
 <CABGWkvqisJBzV=tRQrhZ87evgF6mTff+dJvO1LVwVQC-YX=DpA@mail.gmail.com>
 <20261105144835.GM1164024@bill-the-cat>
 <CABGWkvqoNBvjynykG-Y7V8BP5OTP4TOq4zwkAwSQ_P+e8-6JPQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TKY9je7j+qWGQc/E"
Content-Disposition: inline
In-Reply-To: <CABGWkvqoNBvjynykG-Y7V8BP5OTP4TOq4zwkAwSQ_P+e8-6JPQ@mail.gmail.com>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--TKY9je7j+qWGQc/E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2026 at 04:39:17PM +0100, Dario Binacchi wrote:
> Hi Tom,
>=20
> On Thu, Nov 5, 2026 at 3:48=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
> >
> > On Thu, Nov 05, 2026 at 08:12:07AM +0100, Dario Binacchi wrote:
> > > Hi Tom,
> > >
> > > On Wed, Nov 4, 2026 at 8:21=E2=80=AFPM Tom Rini <trini@konsulko.com> =
wrote:
> > > >
> > > > On Wed, Nov 04, 2026 at 09:49:33AM +0100, Dario Binacchi wrote:
> > > >
> > > > > This series adds support for the Engicam MicroGEA-STM32MP257D-RMM
> > > > > board, with its RGB and LVDS displays and the FWU A/B update.
> > > > >
> > > > > The first patches pick the board devicetrees, merged for Linux v7=
=2E4,
> > > > > from devicetree-rebasing. They can be dropped if dts/upstream is =
synced
> > > > > with v7.4-dts first. Then come the fixes, the refactors moving the
> > > > > STM32MP2 environment and FWU support to the SoC code, and the boa=
rd
> > > > > support.
> > > >
> > > > What's the status on upstreaming all of the changes you're putting =
in
> > > > the -u-boot.dtsi files? Thanks.
> > >
> > > The -u-boot.dtsi contains:
> > >
> > > - U-Boot specific nodes and properties: the environment partition, the
> > >   FWU metadata and the bootph-all properties.
> >
> > bootph is to be upstreamed,  I don't recall where the FWU stuff ended
> > up, and I'd need to double check the specific environment binding you're
> > referring to.
>=20
> I added the bootph-all properties to the -u-boot.dtsi because I saw
> the same in the other STM32MP25 boards, e.g. the stm32mp257f-ev1. If
> they should go to Linux instead, I will send them for this board.

Yes, there's many examples of needing to upstream this still.

> The FWU metadata node and the environment partition use bindings which
> are only in U-Boot: doc/device-tree-bindings/firmware/fwu-mdata-gpt.yaml
> and u-boot,mmc-env-partition in doc/device-tree-bindings/config.txt.
> They are not in dt-schema yet. Both are also used in the -u-boot.dtsi
> of the other STM32MP boards.

OK, thanks.

> > > - The RGB and LVDS panels, with the LTDC and LVDS endpoints. These are
> > >   already upstream in Linux, but in two devicetree overlays, one per
> > >   display. Since the display is selected by the "display" environment
> > >   variable, which is stored in the eMMC/SD and is not available yet
> > >   when the U-Boot control devicetree is set up, both displays are
> > >   described here and the board code keeps only the selected one.
> >
> > You can't detect and apply the overlay instead?
>=20
> No, the displays can't be detected. There is no EEPROM or other ID on
> the board or on the displays indicating which one is connected. That is
> why the selection is left to the user, by the "display" environment
> variable. Since the environment is in the eMMC/SD, it is only loaded
> after relocation, when the devices are already bound. Is there a way
> to apply an overlay to the control devicetree at that point that I
> missed?

Maybe? How far down the path did you try going for using overlays here?
And then also, since both of the overlays are upstream, is there a real
penalty in applying both and then doing the fixup you do to remove the
unused one?

--=20
Tom

--TKY9je7j+qWGQc/E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauy8NAAKCRAr4qD1Cr/k
CkH1AQD0/WbgZ5WrOLZ6d7bs546Y13MV8cW9HeKbEorKV78EZwEAlZqTPt1AEjrk
RuvU4shTxK8OGkKcZnPYOizChonEZAs=
=3TbK
-----END PGP SIGNATURE-----

--TKY9je7j+qWGQc/E--
