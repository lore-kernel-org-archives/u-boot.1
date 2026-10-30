Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B7F606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pwtNFS0j;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=lVo5gH/M
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00B58406A1;
	Fri, 30 Oct 2026 17:56:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HaA8ADeZSps7; Fri, 30 Oct 2026 17:56:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 00985405F6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793382969;
	b=a/FDCRltPmt7Y9TTXFtDvu1Z6Rp5zQlmIB5vLZnfbBlPVaQTYnAcZmsgfPsqrpBcrAu6
	 Mxv/zm67+8Ar7asJABMIzVQ2w5BpLiTHjsFCtU18zeXSd093XBzy2AbtLoU1jjKoOArr7
	 kJgiQISF3zL5E8HmobnEZY8oY7PS8sy5fs9EgSV2nwSF21oPf+TsBiSrLx2TFfKtLuOt5
	 lUXPGMBkMCaSN5ofNh8ieAuMLeST3+kmXXhPsHapAPuU0SOx1eOuSFgU8HGMomYCfXmIP
	 Ks9t5jTgp0HwUn9ZkusMd/YTg8zjK4qaLEUioxzMZUnfXaMank7qTl9MoOcNxnP4j5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793382969;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=WCRF2ThWyxQKPqTULRI5lKCmO3tL3gu2Gfs4OR6DbuI=;
	b=eG0UJZMv5Ey7ucN9vcILH9m6UIH+gfXtzbnPxMnTYAPTBQ2Bd2+uMHzWuXNBwIAcUncS
	 LLCRQZuJkOpqcKbsfrmGdw7HOZSxBAJuMqDeqpL4jtJ4pzIR7OEbNpmHkFzZAEZyzd+F0
	 02abkA3imFMIYL6slkHxlcth8WPNzQPrkUXv4MVAnAPp9L3t8ZlZbCqvbv+ik/77Ctga4
	 N0uR+uX/36w2DNpB0aZ2shOOmuqovjbRVXYtm/CskdpmZ9MFganwZN49sZqO486f2wEwx
	 /uvqBRxjw8GmPD9ty2G6/f7qUzVnaw0DOJ+VW/TtdpsFItUHVAG5TpE+1hHCPnvVFLw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793382969;
	bh=WCRF2ThWyxQKPqTULRI5lKCmO3tL3gu2Gfs4OR6DbuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pwtNFS0jKnntr3Tb7P0DKx2TcZDXEHIiJw3i4XVEJkg6VVpH3ClX4EUCvhd/KmL5k
	 XNSZUaZh622qm5CjtRS7WHB5NFcDo780xSRs77seJMAdpLuhAMPf3KIZqGvrikwxMH
	 5sUGf0GLF7mrVAyDeAEnVsGjfVbX/JdnyMKH0tgytCstEYdmCUJpxdn1UEDgzCRuYY
	 BbLTZ5EDQBWMAkqyl7oK/TeySL+q2ejTErpXnvPfD4sFFIfkFjnMbDrEL+Ct1fwxcV
	 54ZCyu7Q4KkKQDMqpgY1GzXnSzNApoK7m9We/wLRPPd2OvOAkMYT9ngM0wdBds0YmG
	 fbO9ghkMzYSjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00985405F6;
	Fri, 30 Oct 2026 17:56:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B0722235
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A2437400AF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:56:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fm3lH27Hyl3D for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 17:56:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B4CEB40083
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793382966;
 b=qLMcL1J9L+Z+64oKdCdEI37/4rM+B2/mjagat86X2UnT6H/GYNBTDoSAAW1PW4J6LUyB
 8rlJt1fkAacVruKlN63G04YJJGNiN+4vBYCCIyYkqHcTa3J9THbx7sXDaeptxdcQ2294C
 eTB1yj3L2SIqqGLqCxGfOjEBXOx3Yyz3SdkWXFtL5289E3TgtZTNk9YCnHbTHFIr+NudX
 G4DQ0UHXPJBiZhbMHp4+jxl+v0p0EsDIT/ygCLbCTmoJ5btoXAKIISqVHhuzsrP+ujpXr
 n/cSz/yYnXTuSrY0nX4hqGFj6aom2Cg8fg2rOwUpakOjY3Yd0+/ZZbaO1kJbapgzUAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793382966;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=WCRF2ThWyxQKPqTULRI5lKCmO3tL3gu2Gfs4OR6DbuI=;
 b=WM7c7sr27qppyziCWLSgYzIxRuCUwsAi+52afWcsI8Q75+eUtLjiR8CiyARFrwdBC4TM
 6WvFEnLlfUCPRn/bUIM/Gstn2fur0ZwDW9eNI08llVkUWq0KXSCQkDkMvoW+W9GonCj3h
 ZlFxCQhg1krzlDUKxMshXZ507hpMW9g/Or7LYu+RYWFdlvl621FapTx7OKmTUfXO75418
 hEziVFft7PdxR4ldNjGF5Ltm0rcyCNpFrtGrXCjKhEZAhqTUUjWvQC518verf/iQCMnnS
 LfMB8WMfUKdrnFYkTDv0LEwQiILrKoKk+b7GQzAAOK+gmRTuEZHiDnK6Z8v34Zud3ow==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="lVo5gH/M"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lVo5gH/M
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B4CEB40083
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:56:06 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-704597ef1d8so395713eaf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 10:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793382965; x=1793987765;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WCRF2ThWyxQKPqTULRI5lKCmO3tL3gu2Gfs4OR6DbuI=;
 b=lVo5gH/MUFZ00qyRsaCOAD3/A/a2fqlvSedkQ4BgzCypLPBwRcBgDaEdNJe1wEXk4U
 QV7vvHB4HEB3kE86D2SHhd8GemSqG9SbJiItydN21nsn1NPXUrGIYV5DRldef1HG0ayG
 pI/AdSu1jcUjJptc4gwV1JzKiERyC4JDpglk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382965; x=1793987765;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WCRF2ThWyxQKPqTULRI5lKCmO3tL3gu2Gfs4OR6DbuI=;
 b=wbNC+YK8OHbmQboHx12f44ojk98nJdgxqJZK9qAiMyKWfz/YxDjKHeaKSJj3fXZv5v
 RUyJdGlITNJI1tZrR4SQtofcCKBqbSeHnNc9Tx51I376DhVrs9HmuX6V4qlOMKKN8i9i
 nL7dHi2O57qpGkyKunKG0PnG7Y5R5C7auo82jVUv6ZVeskUc0I5I0fruDNePliZlAo2H
 k6mX5hSnOoCjTerKxQYqwIeMe8G7So43n//966ufwtWI0wFYJqCwd8WTKWbIeZudLNBn
 +VHuCMHVat+zvHDR5f20O3ffKxkn1VhSJrfkVDhK6Sz0WFdArh60NcNbixAnvwDmyhOm
 s31A==
X-Gm-Message-State: AFq9FYJDyEUpTTV2Itat/vGWxNwJHCQr6iZkfgiGASsXBK0A3HLMFvr3
 eXLF6EMekHnoAJf3gqjyvjU55JhTEqJESXNoTO6jIwirSQeS0MIacA4RObG4AlkCt/9FXAtwJKk
 /rP+qmf0rLzhH
X-Gm-Gg: AYBFou3aYIIPJDaHpzbywf3vIV57ccyF3wXqkzhPkPbC+wM1PFV3kC81EJC4CwFS+UW
 qvCg0VuF2I5ZXpqIKtAx+cF3RfbgR+6si4ggIA1UBHlIWIjp04vNmHSBQVKeZncGuK5KdXCkFDz
 i2nfnrvUW6XkdYdMQ3KeD+Gcl5dfzxthkNTHE2IcE1rBASry0mJaLQZbr3PUexUD4of392u73Ul
 pavoc0/SnzSbKoa08uf+L2BScrmIFGyKAnZvDUoB1m/CqvuzJM2n8zNNwSpo3nrJZU+9t0mV3LG
 stikFXDyHEUzNQYXDFjxrOChxfJN0p9SmCZ4aUkx8UOWwqO3OkgKy02RjckaTKW9A2SFW1i23+3
 F3s3jIELU86PlNj3AQPi3bta07qFJCzZTMcy/JXRvUwYRKPEGmat7nkUNdvRrtFYc77h06Vi1V2
 PZADrAKRLgOZPN2x+nc4KrICyUpzRGzH55FjY5B+zm6iZXDIhRJH7e/U8JiU2OE8SHrZlTVGEk8
 bJeIo4TTBcHpTpwvKx09OAU8bjHZhtL3Df8QAiv39oQYag4hYm2MyE17NqeM2+1zMHVlNPvO3ev
 sI8KLAcYfRDtZlfqQuDDCj6F5Lb13NpTk2bZBGUTEoGD3SmOY9X2gDmONe9GrAcdw8OSR93Ctxa
 2KyYjnw4Zb5vyEIAps6Hesz/CIN4wFrLTJXgCTQFFRQZGjuFRaTTEOsStHtf26laj1sAz9yo06U
 c1oI31VVTN0WEl+HxCJdsC/kTRExpoTIvvgU5cSBhpmy1E3ARK0+P0
X-Received: by 2002:a05:6820:a659:20b0:6df:961a:af2f with SMTP id
 006d021491bc7-714f2ac5bd4mr1325316eaf.85.1793382965139; 
 Fri, 30 Oct 2026 10:56:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-714f3081097sm2353124eaf.13.2026.10.30.10.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 10:56:04 -0700 (PDT)
Date: Fri, 30 Oct 2026 11:56:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/9] rockchip: Remove unneeded syscon driver for RK35xx
Message-ID: <20261030175602.GH3309461@bill-the-cat>
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <CAFLszTjBiTtKmjgknvXGFBrphh6kpBzRg8iroWjFQ0EDvuXTyQ@mail.gmail.com>
 <c00fd65c-338a-428f-bf4e-eb28e463d914@kwiboo.se>
 <CAFLszTjKMRjF7hmEt6_bbnsRpi9Q=NHidRQC8zv4ToUEpqBarA@mail.gmail.com>
 <582f30f6-7d5f-4dd5-a8c6-60d027806786@0leil.net>
 <CAFLszTj=yHHYYojiX7TGAiFZun7qWsu7zO6awfLdWwYF8HkQmg@mail.gmail.com>
 <20261027162712.GD2177077@bill-the-cat>
 <CAFLszTgng+4ERbALFKRkXRoT+q=GLJthX6B7+bvq2F0ehWNO+Q@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bXgievqZQbpyuJ2k"
Content-Disposition: inline
In-Reply-To: <CAFLszTgng+4ERbALFKRkXRoT+q=GLJthX6B7+bvq2F0ehWNO+Q@mail.gmail.com>
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


--bXgievqZQbpyuJ2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 05:27:33PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 27 Oct 2026 at 16:27, Tom Rini <trini@konsulko.com> wrote:
> >
> > [Big trim of the CC list]
> >
> > On Tue, Oct 27, 2026 at 09:06:00AM +0000, Simon Glass wrote:
> > > Hi Quentin,
> > >
> > > On Thu, 8 Oct 2026 at 23:53, Quentin Schulz <u-boot@0leil.net> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On 8/7/26 9:46 PM, Simon Glass wrote:
> > > > > Hi Jonas,
> > > > >
> > > > > On Tue, 4 Aug 2026 at 13:57, Jonas Karlman <jonas@kwiboo.se> wrot=
e:
> > > > >>
> > > > >> Hi Simon,
> > > > >>
> > > > >> On 8/4/2026 9:19 PM, Simon Glass wrote:
> > > > >>> Hi Jonas,
> > > > >>>
> > > > >>> On Tue, 4 Aug 2026 at 04:57, Jonas Karlman <jonas@kwiboo.se> wr=
ote:
> > > > >>>>
> > > > >>>> This series takes the initial steps required to try and remove=
 use of
> > > > >>>> syscon_get_first_range() or syscon_get_regmap_by_driver_data()=
 to get
> > > > >>>> GRF base addresses at runtime for the Rockchip platform.
> > > > >>>>
> > > > >>>> The GRF base addresses are fixed and known at compile time, ye=
t drivers
> > > > >>>> keep trying to resolve them at runtime delaying some operation=
s by
> > > > >>>> several ms.
> > > > >>>
> > > > >>> I suppose all addresses are known at compile-time, if you have a
> > > > >>> single device tree. I have always hoped that we might end up wi=
th a
> > > > >>> generic U-Boot for rockchip.
> > > > >>
> > > > >> I do not understand how removing these unneeded syscon drivers a=
nd
> > > > >> helpers would stop such goals or make that any harder. From my p=
oint of
> > > > >> view, they are currently making such things harder and only adds=
 extra
> > > > >> code, runtime and energy waste. E.g. around 227 ms was wasted re=
solving
> > > > >> fixed known base addresses for RK3399 last time I measured it, s=
ee [1].
> > > > >>
> > > > >> Most drivers or any SoC specific code is already identified usin=
g a
> > > > >> compatible that is SoC specific, i.e. the RAM or CLK drivers are=
 matched
> > > > >> using a SoC specific compatible and seeing how all GRF variants =
are
> > > > >> unique there will always need to be SoC specific code to handle =
the GRFs
> > > > >> base address and reg offsets.
> > > > >>
> > > > >> And for drivers that are more dynamic in nature the DT typically=
 have a
> > > > >> phandle to the GRF syscon node anyway, so getting it from the ph=
andle
> > > > >> will be a better option and closer matches how Linux handles sim=
ilar
> > > > >> references.
> > > > >>
> > > > >> The biggest current blocker for a more generic U-Boot proper on =
Rockchip
> > > > >> platform is rockchip_get_cru() and how it currently makes it imp=
ossible
> > > > >> to support multiple SoCs in one build due to how it is used in t=
he
> > > > >> sysreset driver. Fortunately, I have a pending series that also =
cleans
> > > > >> up the unneeded rockchip_get_cru/clk() related helpers.
> > > > >>
> > > > >>>
> > > > >>> I wonder if there is another way to do this, perhaps reading the
> > > > >>> address once and caching it?
> > > > >>
> > > > >> I really do not see the need for that; it would only make things=
 more
> > > > >> complex than it really needs to be. We should use constants where
> > > > >> appropriate, e.g. soc specific drivers/code and use generic phan=
dle
> > > > >> lookups elsewhere.
> > > > >>
> > > > >> At least that is my end goal with this and pending follow-up ser=
ies.
> > > > >
> > > > > Long delay while I took some time to look at this area in detail.
> > > > >
> > > > > Pre-relocation is an area which I sort-of glossed over with the d=
river
> > > > > model implementation. There was talk about keeping the pre-reloca=
tion
> > > > > devices around rather than recreating them. We also looked at
> > > > > providing post-relocation devices access to the pre-relocation in=
fo.
> > > > > Over the years we have had discussions about having 'simple' vers=
ions
> > > > > of drivers (that don't go through driver model and perhaps don't =
use
> > > > > device tree) but no one has made the effort to implement this.
> > > > >
> > > > > Anyway, after a few days of hacking I've come up with some
> > > > > improvements to the existing code, at the cost of about 500 bytes=
 of
> > > > > size increase. It works by using slightly better algorithms for f=
our
> > > > > key functions - fdt_parent_offset(), __of_translate_address(),
> > > > > ofnode_pre_reloc() and lists_bind_fdt(). The result is saving on
> > > > > firefly-rk3399 of 230ms, about what you are getting. Note that I =
have
> > > > > made no attempt to enable the relevant options in TPL/SPL (it only
> > > > > saves another 13ms), so your work is mostly complimentary.
> > > > >
> > > > > The key difference is that this should help all boards, not just
> > > > > Rockchip, plus it still uses DT for everything. Tom doesn't want =
me to
> > > > > send patches at present but I did write up a post about it as a w=
ay of
> > > > > providing the comparison. [2]
> > > > >
> > > >
> > > > Please refrain from pointing contributors to patches that are
> > > > written/assisted by AI/LLMs as those aren't currently welcome in the
> > > > project.
> > >
> > > Do you have any update on the VBE series I sent? [3] It was written
> > > before the AI era. I believe it was originally sent 18 months ago. It
> > > is the final thing to get VBE running on a real board in mainline.
> >
> > Your use of AI is not the reason your patches haven't been welcome.
>=20
> OK good, that's progress and I've noticed you have been softer on
> AI-assisted contribution on the list recently.

I mean, I'm not blind to the various contributors that aren't disclosing
that they're using LLMs. I'm also frankly unhappy with one group that's
both doing it and needs to fix their internal process to review stuff a
whole lot harder before posting it. That doesn't change the fact that
older former-frontier models produced a lot more garbage than useful
stuff (and so older stuff is best thrown out and started over). Nor does
it change that todays frontier models make garbage without careful
guidance. And checking my own notes, I'm personally at 6 days since the
last Big Name AI just made up a number in translation, so I don't trust
them to not make mistakes when taking a data sheet and using it.

So yes, people are fixing real bugs, and other people are willing to
review it. People are also submitting poor quality work. We're also
getting some stuff that's Fine (but also didn't require complex AI to
make to start with).

We rely on the linux kernel, and device tree compiler, so No AI was
never a possibility. And if you have to set aside ethical and moral
questions before using a tech, that's not really a great argument for
using something.

--=20
Tom

--bXgievqZQbpyuJ2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauTaLgAKCRAr4qD1Cr/k
ClVsAP44vwLqhkMnPN5bH47Pyur5qc0FT76D9532nZMVH/BD3AD/dydFJpt7xLn4
+9oRTgGDWvXIDmvkknXiaebrbqnY5gc=
=5ljX
-----END PGP SIGNATURE-----

--bXgievqZQbpyuJ2k--
