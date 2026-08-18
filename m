Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C866C5DF7D
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 16:35:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2152606B3;
	Tue, 18 Aug 2026 16:35:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OH-9Mzgew5VH; Tue, 18 Aug 2026 16:35:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D2675608DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787070949;
	bh=DcDmmBOpFAaz/VLeMoCTFGCYuDvyCPpn7ppPX2BUL/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NN5XQk9ezWwcRqabojeSQ3uvNXjdC3tBZysPBNRTWgMPwyo2OniP6Dks4R6KO/is1
	 2SQ/AVHDtGaFG2vCe/g+KhJmLdB0fCJgtVaqeef5Gvv5dUHGMIt+qoV1zYBLQavnGW
	 Btd9cXnqjTCBv/ziHo2PmDHC9WPiJc9tdw9cXIkH0fhI21oSzmFOgG1YOWeLvIqtLq
	 6ZPHP81l433rqwC3b2qEvH1cdnB+dbAyfRd2y1xtIz/Tiv6eFz5B4gteOhp2Mm0bV6
	 qYOk/ckG0kRub8xNI4SmbO4iNRFsA/hLjcrE4FgnKGFXH/a9NmF2zPy7Y4zXJmk4ed
	 PRpB43xyTy0Yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2675608DD;
	Tue, 18 Aug 2026 16:35:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5854529B
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 16:35:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3E426810E2
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 16:35:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qh0ytgrG5HIg for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 16:35:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5106480CEE
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5106480CEE
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=JY0DvN1f
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5106480CEE
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 16:35:48 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6aca0f482e5so84976eaf.2
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787070947; x=1787675747;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DcDmmBOpFAaz/VLeMoCTFGCYuDvyCPpn7ppPX2BUL/M=;
 b=JY0DvN1fkqqRPuhhydyeWvyX+SMSuAuEeiywumiA58Qvj6oN9zsmywc0dtc+wpr+Mc
 pxhnorde69+RHljlq8T9M+SmfqUCZ+DqMnt0crapL2EGv65TbGer6nymKUQIkp5AJlIb
 2n86m7+XvH84P9eb3zDB4XDMCFQ2WtDPoye7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787070947; x=1787675747;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DcDmmBOpFAaz/VLeMoCTFGCYuDvyCPpn7ppPX2BUL/M=;
 b=I/p0Tx7DpgXKD17bUzfP+SimBlDM5OnMP5MeXxyPx+5QiqzN1vyR4wW4FxZ70Paj27
 JJufbAmTkySwvUA8e9L+Bm/wIGMgpXyasnGd+wtdVF0pymewg10J5A45nhZqRZkBqCAF
 PACZNT3Nm/ufpGdDkYyU7QLSVVm9UfSYR56NyEyL9+cqkYFdoL8XFxkStGHNdfg1ypaP
 dR7inq5GXxXGjn+96sFG2uIGf2VIEfGOOi+Q1k2MpA1jr9oI9IkaXu1Qo8erV245XDMw
 DNowShMP6rI/ZCT+do8wsy7nD4lJeb8fBtMPlKMrm/1fDuODA12kAHZsO889Xz/bVZYx
 GKFQ==
X-Gm-Message-State: AOJu0Yz9nRXqNyNFpA0uPixlP/gsNXW7FZnDMLaLmTm7OxHLNjw66XmC
 x6wJ55aYfNtsDYVP5TLQN7fQuf8xXH/50Zc9o/0gTCe0bMRQchkAz7KupYpPPpCKmkc=
X-Gm-Gg: AR+sD11vSAHaHhu742RGY0n+82seGFfo4gAgleboaY8wff/IFl8yAOdxpx2Pt+n8UZH
 qGozMST9fp9xwM8Q8CUhf2AOfqwfoXiJkoiyn5vjW/9fGNm4t6uhXYWyj7B0Yes9P+aVMf1/4Gf
 NniTV68pc7iYwI++jVz0SNyURt7E5/J25YaaXzbzJJ60vAfxq9WMJuaOog6oZtIO3b4baRRIrMp
 zUHy8KRlnEsNSO9jycI6H/uWwONr/SU1kCEHwChLnPa8FG4GlsFJoG9MmOxXCSrC9aRKYfihFpA
 S8DDQ3VarlAMFF5YuYKe+1Mb4MckDKaegoNNmKQD1BxwoH89QvMz/1SX8gmRJYB92Du+ziyO61z
 cUZHKeke2K1ofuchEfB6h6pfLAFTTpTXfvogiBQ47Bb5OCoLV+f5D/RqARmsYi+Mkt4yy9xnvvp
 N8rUfKnnrewqkUjydGrfMIAG4bKEYSOL6fhXZrFNYWTnTiNvtTqbKHrCSRQXYxyfXh20PcVq1Hi
 S/XFUIKDic6KnLUT0FwoSUOcPquf0885f4pEkM3OzgYx5ZYyPziKL0bohgNB93w/CJDtDEI3oFk
 pH/usV9NonighNaE3ygZ
X-Received: by 2002:a05:6820:220c:b0:6ac:b5ae:65cb with SMTP id
 006d021491bc7-6b0d618d1fdmr28831283eaf.14.1787070947219; 
 Tue, 18 Aug 2026 09:35:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b1166dbcf9sm5067706eaf.12.2026.08.18.09.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 09:35:46 -0700 (PDT)
Date: Tue, 18 Aug 2026 10:35:43 -0600
From: Tom Rini <trini@konsulko.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Brian Sune <briansune@gmail.com>, Tze Yee Ng <tzeyee.ng@altera.com>,
 Peng Fan <peng.fan@nxp.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Boon Khai Ng <boon.khai.ng@altera.com>
Subject: Re: [GIT PULL] SoCFPGA updates for next (2026-08-17)
Message-ID: <20260818163543.GB523975@bill-the-cat>
References: <cfa5d305-908e-4ab5-8725-47f287fb5e54@altera.com>
 <20260817182735.GQ3297518@bill-the-cat>
 <b1ccb10b-2e65-425f-a029-b443eaf6767c@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PaRzQRRJglmsCbUI"
Content-Disposition: inline
In-Reply-To: <b1ccb10b-2e65-425f-a029-b443eaf6767c@altera.com>
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


--PaRzQRRJglmsCbUI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 12:32:53AM +0800, Chee, Tien Fong wrote:
> Hi Tom,
>=20
> On 18/8/2026 2:27 am, Tom Rini wrote:
> > On Mon, Aug 17, 2026 at 11:29:50AM +0800, Chee, Tien Fong wrote:
> > > Hi Tom,
> > >=20
> > > Please pull the following SoCFPGA updates for next.
> > >=20
> > > The following changes since commit 527115ef6783cec49e5610c523c124b399=
011361:
> > >=20
> > >    pylibfdt: Replace removed SWIG Python 2 compatibility macros (2026=
-08-13
> > > 10:12:41 -0600)
> > >=20
> > > are available in the Git repository at:
> > >=20
> > >    https://source.denx.de/u-boot/custodians/u-boot-socfpga.git
> > > tags/u-boot-socfpga-next-20260817
> > Can you please put this on git.u-boot-project.org? The denx gitlab is
> > unresponsive at this point for me, thanks.
>=20
>=20
> The same tag is now on git.u-boot-project.org:
> https://git.u-boot-project.org/u-boot/custodians/u-boot-socfpga.git
> =A0 tags/u-boot-socfpga-next-20260817

I'm putting this through CI now, thanks. For the next PR, can you please
give a changelog as well?

--=20
Tom

--PaRzQRRJglmsCbUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoSJ2wAKCRAr4qD1Cr/k
CqfrAQDy1y53g4knsDoKK2GQfyOM3oy9Q39WDQRqHsIVkeZ/zgD/bRh0UryErRgN
FjoTvsVFl3McM4+/TflMoYQ4h21rTgc=
=n//s
-----END PGP SIGNATURE-----

--PaRzQRRJglmsCbUI--
