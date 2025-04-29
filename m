Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FB2C3ABA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 21:09:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA7C082ACC;
	Tue, 29 Apr 2025 23:09:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hnpVuqEN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA01182AA8; Tue, 29 Apr 2025 23:09:29 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0447D8272A
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 23:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72b82c8230aso1722610a34.2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 14:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745960965; x=1746565765; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DYt6/3RiUejJu2SToBnkXo8ijokImdbOXjUFrGrmd1I=;
 b=hnpVuqENHXBO29WtisZBUpkruzWajz909RdYJHM27DMCtZEDdQKH1XiuqbXbREOGPR
 I0Z+P35aavsj3AYrSppycRvzZNLJA11JS/tjfuYO+V2q+Wcc6LjY96Mt04Kr6wX3AZtk
 u30QMedkjs/0XLmjZRSOm4VvmnLvyjV7jqolg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745960965; x=1746565765;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DYt6/3RiUejJu2SToBnkXo8ijokImdbOXjUFrGrmd1I=;
 b=e883QSBgCf5OFzAc5oWVvj7QQ27hVQfBU4az14wgY+wqovpJEJyp6htRQ/a5N5FnMN
 Yi4NIB/3WAqGj9O8w2pc7enzZwrtLDaLc7H7e1QxfBfU6hYIRQpfjIg3tjbMDEKg2B4h
 sZTANl/kw+res5u646gl4kVRPqFNpL4B3+a+asuYs/KQRs/Qx0kVf/Aedlcvm9eJ4/M+
 KXgu5B6XCKqB+uOUncJUO/l9HRaXuaWIepzdXMIL5Vwtu5LK/gxmObpBpp2rQ/AZnmxw
 eo300j2Vb8pV4C/zDlWF/HV5qjW4fKMThrhbON76Ehg3BHWp+CWzb2EdDocDZ4SrAnSL
 H2qA==
X-Gm-Message-State: AOJu0YzXHWoVN1R57xsU5FXh4x8e9i6Y7p2vXHZuufP5gsywI4MfZEWe
 oiLGKoUb8xD+s0M6kz91TokmuYAiWF0z59H9PflxmlAeMjCBkrUUTZv05oBszzEBBuTSdWbtblY
 f
X-Gm-Gg: ASbGncuSS8S+891LTZZYsJ971NgpLdUGeorKqzpxTLuga8RzmfMTywj+S2XCmg/1dHR
 khW2dgjav+NLlmDegZ38okIHL4X9PFLjXFbkx2ZaFH12Xk+g6FybSyXhu6/TbsNXzgulVRgQZ6N
 YOwHnn3hx5MByVWApOCeStCbrkRo3C2lD3bzQtOPo+uSoPQQQw8WB9E6GE+M/2czbVTnxmAbB6I
 m43HzvtyecSc6DIC+t7iC0q8KG57BWDfi8ebG9XyiIoCdkxH6SENmRJnsSFKeHyRCoje8pBsr/u
 QQLCmZCrOIe95vyFBb/B8Ul5T9WnHTBVwG2ZDh0CLsNMAlREjyL88jvvB85WBqIUenWRAWGZsPV
 C8g==
X-Google-Smtp-Source: AGHT+IENZARZLsUaA79wBdWjfJfQFIanV+mx1dZjCLCP7KJLaPYpURbobJCTHOPXYzfu/pSj7dMrnA==
X-Received: by 2002:a05:6871:3a12:b0:2da:462f:ead4 with SMTP id
 586e51a60fabf-2da6a36d920mr329646fac.38.1745960964547; 
 Tue, 29 Apr 2025 14:09:24 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2da6e4f7cc1sm7126fac.39.2025.04.29.14.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 14:09:23 -0700 (PDT)
Date: Tue, 29 Apr 2025 15:09:21 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2025.07-rc1 released
Message-ID: <20250429210921.GM1261075@bill-the-cat>
References: <20250428214032.GG5495@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vUP7NYUtwdfNciRs"
Content-Disposition: inline
In-Reply-To: <20250428214032.GG5495@bill-the-cat>
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


--vUP7NYUtwdfNciRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 03:40:32PM -0600, Tom Rini wrote:

> Hey all,
>=20
> So it's release day and I have tagged and pushed things out. Looking at
> my own TODO list, I think it's in reasonable shape. I do think there's a
> few other pull requests that need to happen still and I am optimistic
> will come shortly (but I've not reached out to anyone in particular). If
> there's anything big that people see missing, please speak up.
>=20
> We're continuing with a community meeting following the release and the
> calendar link is
> https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DN280=
N2tlcXE3aDVtbjlicnNkcm82YnA1bDAgODliZTdiODEzMTM2YmVjMDZhODNkZTRkYTU5NzQ1ZjB=
hYmQxMWMxYjgzNjA2MWFlMDZjMWM3ZGJjZDE4ZGY0MUBn&tmsrc=3D89be7b813136bec06a83d=
e4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.calendar.google.com
> and once again this is the same time as the previous meeting. The
> meeting details itself are:
> https://meet.google.com/btj-wgcg-euw
> April 29th, 2025. 9am (GMT -06:00)
>=20
> To join by phone:
> https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

And here are the notes I took on the call.

- I noted that rc1 is out, I think my queue looks good and while most of
  the PRs I expected have come in, a few haven't yet. And I may need to
  look at the SPI/NAND/NOR queue myself.
- Heinrich asked about updating QEMU in CI and the two platform failures
  that updating has shown. I've not had time to look at the
  vexpress_ca9x4 failure to see if this is a regression in QEMU or
  exposing a U-Boot bug. Heinrich has not had time to look at the RISC-V
  failure of sifive_unleashed. He will try and boot -rc1 on an Icicle
  platform which is the same cores at least as the unleashed. As part of
  this we had a short general discussion of some of the RISC-V platforms
  and cores they utilize.
- Heinrich noted E Shattow's issue that was brought up on IRC, of having
  RISC-V platforms that read the EEPROM in SPL to determine what the
  platform is and then load the proper device tree, but that they need
  to do this again in full U-Boot in order to set fdtfile in the
  environment. Is there a better way of doing this to avoid the
  double-read? Heinrich thinks there might be some mechanism to copy
  some properties today, but not everything. Simon noted bloblist could
  be an option. Further discussion about fdtfile was had. I suggested
  looking at board/ti/common/ as they also have this problem and have
  been doing something at least for a number of years. Simon noted
  SPL_HANDOFFF may be another option here.
- Heinrich noted there's many bootm stages and states are not well
  documented. Wondered who has a good understanding these days of the
  states and stages and who could describe it. Simon knows much of it,
  but it's not comprehensive. Simon has been trying to make it so you
  can work without CMDLINE, which means having function calls to go
  through the states. Simon can start by describing the constants better
  at least.
- Heinrich brought up his RFC for efi boot manager + bootstd he posted.
  Wanted to know if Simon had looked in to the rest of the patches.
  Simon is OK enough with the approach. Simon thinks that boot manager
  should be more iterative, but a discussion for later. Heinrich noted
  that for background at least, the spec requires certain behaviors to
  be done.
- Andre noted that Heinrich said Ubuntu uses fdtfile, does that mean it
  always ignores the U-Boot tree? sunxi takes the running tree and
  modifies it in tf-a/u-boot and that's the right one for the OS. This
  lead to a fairly long discussion of how Ubuntu does and doesn't work
  today, but at the end of the day U-Boot can and does support the
  various contrasting approaches used here.
- Andre asked who pays for CI (Gitlba), I noted it's all donated and use
  as much as you like as the jobs are split such that aside from
  bottlenecks on the high end machines no one else should get overly
  blocked. Simon asked if Andre can setup a lab of his HW visible to
  Gitlab. Andre will see what if anything can be done, but the sunxi
  stuff is his personal project.
- Heinrich asked of sunxi has newer hardware for example and Andre gave
  a short general update.
- Simon wanted to talk about standard passage. Heinrich asked for a
  brief overview. I asked that we not go over it without other people
  that use the code on the call. I noted the vexpress_fvp option and
  will enable it in CI later today.
- Simon asked about the Python patches he posted earlier in the day and
  I reiterated that all patches for mainline need to be against mainline
  and not some other tree.

--=20
Tom

--vUP7NYUtwdfNciRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgRP/kACgkQFHw5/5Y0
tywcRgv9E+IrT6IudJl1rL0Vxi++20vn2C+tJTcFGi7D5jYbn8ZWgI+Sl7j6thTA
QD8te813xPNgk85qkSZSOepVfhoBczrj5HtTs1ZWxfScXegO5VaRqtvrWJ2uGB6R
7AvGF4s+9TgSid/Sf3xfk2xJIsiJhRO9Gt3/AQF5407Alh96xWU2b9Sr+cfvBY9s
5rm0I344faKAvzX7nOWYptnodBaS0XSSASo9icFoQzWliHLMqY6jkor1QZ3phhTj
J9tDfeg/Vpwll/F3Dug+nesKDvjaW3TnvI+gSYb28jek29sqyvEr6dTc7ChE3hZ2
I7gTNhb4v6F2d8nsrBrAQSSJLlR4qf96grJV/slOaPnHlXojStkxy9jKkzHeiW+9
tqL1m5yZEPfdYNLSHsccsbanEwodIQi9atx7bjJAm80giSs06c6bsg/Q81e72HrG
Pk81oNg9DFcgDa4ss/RWXTcr8f7gWBxvUXzfhmkcu1N3tipDtWfSUVJdfuT44k1H
qBoFkPLr
=41bC
-----END PGP SIGNATURE-----

--vUP7NYUtwdfNciRs--
