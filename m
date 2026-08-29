Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBE3C61DD9
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 15:53:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC7C960617;
	Sat, 29 Aug 2026 15:53:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N1571QhnwRx0; Sat, 29 Aug 2026 15:53:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788018800;
	bh=OHBDr4sWkUvZo7/gJA71dlCB41FkOT83VUJ1fEM+OlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jb3XEWHv6/vpa13+VyImWTxaoowlpSjZyuOH8EMdLkxeoJvikJX8MIBiqQjra0a1i
	 qVu62/pNofboKQ7HbQjU/a5R2uqXxkWyRw3uOZhy89zLUAfgq5/nxaWNKWggz4Syk1
	 w8MVa1leD/uf96XC+3VwZfLf0WCL+fEvJpA9ZnHrxDjhOOtCnbojlFDek86sDpxkFs
	 iYLOtpGGSZjJ2ZrkGD83+6zanl2PyFK6VotqRbLI5Gu7Y27h9w7f7bfGpR9Ja+nJn4
	 yOYYZcBormeZMI4dXwUIxIzyGq0mqrTi9FGwjYCHuk+Os8aLVWbvb8sWgH3u9eb+eH
	 Cb5MpYpv5Z+9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6245160609;
	Sat, 29 Aug 2026 15:53:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1EA36118
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 15:53:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1C4CF40586
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 15:53:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JVClBJE0VXKK for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 15:53:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::3;
 helo=mail-oi2-x03.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=pDgTorFc
Received: from mail-oi2-x03.google.com (mail-oi2-x03.google.com
 [IPv6:2607:f8b0:4864:32::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B0D240574
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 15:53:17 +0000 (UTC)
Received: by mail-oi2-x03.google.com with SMTP id
 006d021491bc7-6b1bebb3ae8so177659eaf.1
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 08:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788018796; x=1788623596;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OHBDr4sWkUvZo7/gJA71dlCB41FkOT83VUJ1fEM+OlA=;
 b=pDgTorFc93h16q3ooErnBescgckbsy0m8rdUPO7bNne01/vAMRcHbnQ2b0IZAy6neR
 1Kgh1Ywj10ztbFjLnkBEk3BLdC1jRFnlxYPuZXZxN7ni8P29hjqk7HQTptKlFnVzUQxa
 cSNy73aVSf8yzRJbDls/P2bykU5xEGNQ+bFAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788018796; x=1788623596;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OHBDr4sWkUvZo7/gJA71dlCB41FkOT83VUJ1fEM+OlA=;
 b=CBdBhW5RLAkg53HG0lsOW1wieVR6ugUOfADX0z8lkhalOgYrNMhVux45LIAHxtNdSJ
 lX9HI9oxdsS3NkggLx/2Weqe6OB4wIhGQFvv8FFXDTOFPe5ulb19MvaoR5W5kaXISa8h
 E7pBkY9pnHRop/A1rvy56Diu09pa8foUAzdHftIYItERVuzP3fh/0Kt2rYDWzIeYKCMe
 OMs2tJTQF2QSqwCK3nb8qAk8U5L+36a2HtJbycKr5bvUjBOwirYH83WYQHeJeUDPGxKC
 yYznnhAIUtUUSIAZbN3U7U+lV1YeqTQctzyXZxjQJ2nK2eg/mloywdS8w1gQqcbngJn6
 MWNg==
X-Gm-Message-State: AFuF++nMhbCy0KPqsSA0umpT1wFxohg8w8VqwPkM2VkzNmmwQIi8lwLv
 rcGZ3Rb07VjXF6H/qq9c1dnsxi75Ve0Dvr9LM2BACfAvr9d31SNM/UCsTKQoHxjNaL19qn91IvF
 8jTnl3NAmhc2SkI0=
X-Gm-Gg: AR+sD11lZ0T5xPcEVm46YPXsj5GiVfRsGpM+hEW0Bd1y/4PUuscfFDuvD6W+0VWMrFp
 +CF80AJ2WaGCPqsbyvvit0xJewrcmXFtcTlAiTnpn+QtNrzWbsNXp7/bsGoy/hHjfWFr+KYJ4J1
 WcPsz0i0KR1W9icB7UljWDOCsVtQZBHrgfTkE8sU1GCuac04g8OSnvinXucEKQpW5bV4a7GBZWU
 pA/fiomV+G2JvP31BaHSJ7pVQi9BdKChGxnq8ogZCFNRSRKkghb5vnYI+/GrrgA9wSuYH/pQcrs
 Kg/wM614BhaAB1O8Hc3e/XII0SA9WuXJJ+gxxIZYUTlR9JWuMrJU0xhxgVm0/6pniOb5IiHN37F
 MBV1BSzfvZ2gzoc0xXO7Tphi580GmPWA6k9cj2WzggH2qU3X7ZNYl39ze5QtmMWCLjmhgM3zhrR
 hrl4+3+C/AjA+jyC+QJh0IP7dGxCT3pznxXKZktwKrZB+vGeiGPqGpASbfqpId9STamRQAgC84J
 c5kZG56ggcycJaD/8z2uQtIJ4D48N04/2mkAPcPYyK2Py+bqTD7SVaA3xNVWRVnNRYVhtRhMr7X
 gVz9nqJkKYk4HIGeyURq
X-Received: by 2002:a4a:ea56:0:b0:6aa:fac5:a3af with SMTP id
 006d021491bc7-6b1c65f7463mr10721236eaf.16.1788018796254; 
 Sat, 29 Aug 2026 08:53:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b1ce3c487fsm4793811eaf.15.2026.08.29.08.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 08:53:15 -0700 (PDT)
Date: Sat, 29 Aug 2026 09:53:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.u-boot-project.org, Vignesh Raghavendra <vigneshr@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Apurva Nandan <a-nandan@ti.com>
Subject: Re: [PATCH 00/14] board: ti: update and correct files MAINTAINERS
 entries
Message-ID: <20260829155313.GN3959812@bill-the-cat>
References: <20260829-maintainer-fixes-v1-0-e4e03971e14c@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lZz7fh+hOy+hndZi"
Content-Disposition: inline
In-Reply-To: <20260829-maintainer-fixes-v1-0-e4e03971e14c@ti.com>
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


--lZz7fh+hOy+hndZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 09:34:18AM -0500, Bryan Brattlof wrote:

> Hello Everyone!
>=20
> While updating the check_maintainers_files.sh it was noticed many of the=
=20
> MAINTAINERS entries in board/ti/ are out of date[0].
>=20
> So this series aims as trying to update all entries by splitting each=20
> board into their own block, sorting the F: entries, correcting any file=
=20
> names, and finally adding any missing files I noticed.
>=20
> Happy Hacking
> ~Bryan
>=20
> [0] https://lore.kernel.org/all/cover.1787555916.git.michal.simek@amd.com/
>=20
> Signed-off-by: Bryan Brattlof <bb@ti.com>

Thanks for doing this, I'll drop the boards/ti/ parts of the series I
just posted.

--=20
Tom

--lZz7fh+hOy+hndZi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapMAZQAKCRAr4qD1Cr/k
Co20AP9jZuq/JKRXVTP7K0NIt19hV/4V6Vcz70RUWZs/N32x5AD/bW2pdV3TxXkz
rpf6pP2eTCH7fNIk6dsvE4mlKR0qWAE=
=NbEb
-----END PGP SIGNATURE-----

--lZz7fh+hOy+hndZi--
