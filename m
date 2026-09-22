Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891D3C982ED
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 00:53:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACABC407D3;
	Tue, 22 Sep 2026 00:53:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yNl3F7Bxmafi; Tue, 22 Sep 2026 00:53:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A3447407C4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790038380;
	b=Xol7nUmix0Y9LVSZVQIqji2tquY6ImajrSld7ffvHQwk+3bNpKKN3sAzzwoua0lfRtkc
	 Dqe+bLY1R1dcrz7MBpR83zzazd94s6cVMKI91tSZq0iSB0v7Xjm+p0/SqbYT4qrHu9/nQ
	 GzN0dJB7qp+nWThlBUB1/DqkDhPZfDRiofbyS0Nz9N5PxDSVoTK6twVC3F11sSX/pkRyM
	 xSKTFaYy0DcD1a/3beUETo2J1roZczpofnqKECd3HN7v9fGc+OgdRy52zV0xK4C6KX9II
	 1ovjbkSwls0LZV/mRP2sEvYmBo4a1TU0GQTcIXPsEhl8zloCkZeRFAAUMi88fXNykAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790038380;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=B+nORxVjGJIsxKZ9O8558yN5sn5WUe/q+6kIT2v5wDs=;
	b=YDIyMLVopQ2+73eF8KZ0reV3aGAme7z053EMLtJI8JOTGFD6jjDnEB+viy7JEkpdtQ+D
	 wjxpt2UnyWx44FBAer8xA3+8kRtxyYWnHdeMQd+KGL+aoQRmzNKmqCm8uYKqGhmMqewMK
	 bCX6BDRQH3gXaW1CXjQxbGI1xw74WZ0twA1THYkkMqboaPu/qRkPXjbdbqsN+52Bsv2LO
	 16XMst6M81Z+dCp9ZLOQ64xge1Mw5Ed0s8quh957QQGhuGqsIH+FjSh5/YXSW3dIRnGGb
	 gd63ScsysjbC61L8rP3Nv5/hF45iZ3EBFQdAwpCeOZQbc4GsNboPATWgYF/G3Qglmwg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790038380;
	bh=B+nORxVjGJIsxKZ9O8558yN5sn5WUe/q+6kIT2v5wDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kS0zceb2zb58jmMi8d/0Zv7DMtIk+UAby448KPdS7/oJI7g0uwV7gLgfrVPU/NB1c
	 RD8mCZob/hq0wSkYuH9Gpb8etqIPfky1QJDyHKwreR2e6a/sYbeA5xz0TfmGAuTelg
	 g0eG+oG3WESvMg6dqrZrlPkLWbrTIs3y9NMYBXkMNxbGMsCQKDxd5f+yqp/A3q10aZ
	 1humV/57ebSiwWPnjZiYetO+andB4C83qIxq5E028J4hYdkc55MHdErWLsgG4xRsT7
	 QbeqeInjcDGjmsF9Uf1WnNUsVGCWdfL373jmvjM5N10WjOTnHfgL5UGzmODTIz8Rik
	 xhr3oAGjbuxnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3447407C4;
	Tue, 22 Sep 2026 00:53:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E59535A
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 00:52:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6185F6069C
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 00:52:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0G9_NFrp_dLl for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 00:52:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6939A60685
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790038377;
 b=WXoNTYMBn6oMxvkqBnBHKF6HX9ZLDlfcScHBkW90PmmiKKzmCuRdFRN/x7Trbr+IMT0H
 Ej1221Aym0gwhKrtc66+JLEBGKaUmnuoxDRKiaOapvTmUXRjwKowrQKvdq7yX0alDWktY
 pQnndH1dgrGYHkiAe+wJKAu3n8adQF/YieQFfhcQ4bZrSliblI6ttDR68rP6jryQQYNue
 3Ld2oWDM0tInVN+i/tLqhBb7D07OC2tyHtLMuBi+KGXBLvNrKkl2bFqh6+YNPMyFPwSfY
 MjxcskHn/wb46IWlEqgdPFhUTLHsa/oUK8++7nmALGRsnIMlVf1urajiYjnp9AotTnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790038377;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=B+nORxVjGJIsxKZ9O8558yN5sn5WUe/q+6kIT2v5wDs=;
 b=m20THPuPICvJ+YcdmhgDffpA2tDV9aQ0TR30XE1VNI9G4QrNoye+SWIL/d4creBOEmvM
 +n3dymSSPg1jIjB+TQ7oNva1UvuWDyuKlHDucI0qTfAuIh0We2HQtct57EzHap9eFmYPW
 1HwbI3AfRQODqFzDQ4JvxGvLjMCLqzJZDoCs8KEbrYjaBwKqf6MMWssVOuNsF+7QQQepE
 xCfoGxdhXoBXSEu/l7D2Xe95XuPZ7jc2r4PxsXmzV/aVXqArW1DGzcTObUMwaz+h/WPr8
 lMigW7LYXs2Cwrim2PXbslX8SnP//EVRDiRpnx++jxIKeAIXOKPl5nI2EUtIPVapEyw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=XduwbAps; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::a"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::a;
 helo=mail-oi2-x0a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=XduwbAps
Received: from mail-oi2-x0a.google.com (mail-oi2-x0a.google.com
 [IPv6:2607:f8b0:4864:32::a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6939A60685
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 00:52:56 +0000 (UTC)
Received: by mail-oi2-x0a.google.com with SMTP id
 5614622812f47-4c1e3be1093so1304844b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 17:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790038375; x=1790643175;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B+nORxVjGJIsxKZ9O8558yN5sn5WUe/q+6kIT2v5wDs=;
 b=XduwbApsVhRDBSQXMcLXy07S0z2YdxgI7U/WDPpwgIqXLU4Zxf6M1V/+62i/Fwl+sO
 j+tRcZB7dMJaeJAcJZkFSEVrYwsuYPQUATU6FeyRVrh5VDf47B/iEpa6baZYl3KR1DxI
 YReUnQearI1JccgYCFcUs4hPuOuWThVRaOeJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790038375; x=1790643175;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B+nORxVjGJIsxKZ9O8558yN5sn5WUe/q+6kIT2v5wDs=;
 b=tp+pOJSUXNU5BYZHcEfj9MB0jSSW4V71csLwe33Um3ngHF2sIkTd3nREHoWu7wXgkI
 YXwQgoe3WCbGNzcNRFf2WbQLHyglGfbT8AXhK9ZfH4ZNppBX5N0AfHSiCGXVC1tOEEQf
 Rn6eyP4Y7GmguYXHiwxvSiM0yq5b57Meyooskl7RZngr79zAOMl8PcX0+SjwG1g4kcSe
 h40Kg4BnNId95lvFqVElksIez32eURpw6kikHTke/1LOOCJPOIhXBdosDi3vms2ZIQc/
 my/JDvbc+/2WQpMtuj/LID/Sx5NcQ2mzhhegje3jzjRPEHnKaJUOD7DHObnqG3kmFKps
 F20w==
X-Gm-Message-State: AFuF++kZkxTSTe2CvnKXG5czq4HmdpoA0RDbEBpdk2wMcvuzO63Z6B8V
 rdoCxl8C1dYTl3BW4WwUwmfPQjWyEvosDpQJjOvsxdV1rI/LIqHVQi7BS067vOXgZR0=
X-Gm-Gg: AYBFou0lolfJrQ2rbQCD7oQyzcuehRizn6YpSUDRLEFSNWa3WlHMqgSWN50Pnb6EjIt
 wUZ0we34Vi9IYA67QH0faoraJ4Z35CoPSHbIIVBBVY7ED/7NIuNt6cDM6hKhV0MkllAsD2aVskF
 GFbuNqMbXsk59HwtGbTiOZfzsYVKseFw1CTbCCK2ELg9mskYwupefFwrBiDmo0nNdib8Enm8mje
 dd7pOwH07/VnxyCFwf1uk+j5IyCrb5on4rZl9kKmt1vzNPn4cPquIMLi5+mJtbKSy82NL3Akhb+
 WI5ygA1iUa/ILBM1O1coMPFpkvsVG6+xrqIXEsk4bKqk01MELoC7MlabVa6sDTp2GuHE+WHH4Ve
 MBMX94YUpGOXp5DqzvwUgMVUFwFYwJVzX10vFIh4UncYg7P76ovW3ah+rbzXbTDRmO79M03iFF9
 nWWiSF0OyRC/WVLtbRNrBpUFSsbLmIALYNITzClotIDyHCO6gqtKtRCKTRvA67aYUj0Mw79QHhk
 HAqmxnRUHONBZo/J/MI0KUDPcUoUc6OmL+YA623pWpFNZCLWGO4W6h5OVG5g0BuBHGwYWhRlhDc
 lasL7yGoaIsf09GO8vA=
X-Received: by 2002:a05:6808:4f4d:b0:4cb:f21c:a794 with SMTP id
 5614622812f47-4ccf893b991mr15339546b6e.28.1790038375637; 
 Mon, 21 Sep 2026 17:52:55 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4d4c13d6979sm24389b6e.11.2026.09.21.17.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 17:52:54 -0700 (PDT)
Date: Mon, 21 Sep 2026 18:52:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.u-boot-project.org,
 u-boot-custodians@lists.u-boot-project.org,
 u-boot-board-maintainers@lists.u-boot-project.org
Subject: Re: [ANN] U-Boot v2026.10-rc5 released
Message-ID: <20260922005252.GG858934@bill-the-cat>
References: <20260921221325.GF858934@bill-the-cat>
 <arHJzfAsy1mK8RDC@pie>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uV9ZOs81LzrHlmzg"
Content-Disposition: inline
In-Reply-To: <arHJzfAsy1mK8RDC@pie>
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


--uV9ZOs81LzrHlmzg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 12:20:29AM +0000, Yao Zi wrote:
> On Mon, Sep 21, 2026 at 04:13:25PM -0600, Tom Rini wrote:
> > Hey all,
> >=20
> > Once again  it's release day and I have tagged and pushed things out.
> >=20
> > Things seem to be working well on our new infrastructure but if anyone
> > has found issues please bring them up.
>=20
> I've found a nit on the lore.kernel.org/u-boot/ page, though it archives
> the latest mails, it's titled as "u-boot.lists.denx.de archive" lol.
>=20
> > I believe overall things are looking on track for the v2026.10 release
> > itself, and things are moving along in the next branch at the moment.
> >=20
> > So, the git tag has been pushed to
> > https://git.u-boot-project.org/u-boot/u-boot and the release itself is
> > also under https://git.u-boot-project.org/u-boot/u-boot/-/releases/
> >=20
> > We're continuing with a community meeting following the release and the
> > calendar link is
> > https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DZ2=
IwbHR2NjZhMzZkOThqNHJoc2sxZG04MzJfMjAyNjA3MjhUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZ=
WMwNmE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsr=
c=3D89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40grou=
p.calendar.google.com&scp=3DALL
> > and once again this is the same time as the previous meeting. The
> > meeting details itself are:
> > https://meet.google.com/jwj-pqka-bnj
> > September 22nd, 2026. 9am (GMT -06:00)
> >=20
> > To join by phone:
> > Or dial: (US) +1 929-277-5781 PIN: 115 674 167
> > More phone numbers: https://tel.meet/jwj-pqka-bnj?pin=3D2145803234090
> >=20
> > In terms of a rough changelog:
> > - Platform updates for Renesas R-Carand STM32
> > - Fixes in our NVMe, PCI, networking and DFU subsystems / drivers.
> > - A few other assorted bug fixes / hardenings.
> >=20
> > We should have one final rc release in two week, prior to the final
> > release on 05 October 2026.
>=20
> And I think rc5 is expected to be the final rc release?

Yes, whoops, forgot to fix that when editing, thanks.

--=20
Tom

--uV9ZOs81LzrHlmzg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarHRYAAKCRAr4qD1Cr/k
CgfgAQDIdkID7Fhq+G5XGYld2Pk6UIPrAu6VYU9r6ILRkFbSZAEAyCCSGaZ0axX2
/eKvUHx9aZKB9bQ8HmRjFmMRqB7MnQM=
=M7G8
-----END PGP SIGNATURE-----

--uV9ZOs81LzrHlmzg--
