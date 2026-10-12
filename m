Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85FDCA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:38:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB03580DBA;
	Mon, 12 Oct 2026 14:38:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zNrqO8nlDAzZ; Mon, 12 Oct 2026 14:38:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DF8FC80A50
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791815923;
	b=TvSm4OLSsajqCQIF7rTLJgRDKoSNS1zhyLU36n+z1qGxDnFmRjv3MH7wHPlEPaCw/1cd
	 wSI0q71zrVfAcMwapejWOWX9ejhvLchDStq80Ixbchbr5AMp1rZFdsdcsRuSK4GbdJikv
	 IFnngWnZ1Z1G8sq0aex7H0uJMSLolx2Qun5ooxYRSLYa8NoBPpplW06b2zXM93mryh+2Z
	 Y5TXEB1YojH79Lw607GwxLmpFuOmfH8SNguKL06HQx63le0WkwByEUWEh/Cftku3S0T9z
	 EgoJOQwievIzeMVKsVh71aNHBfmsDcje3owBIVlRF52H55VCBqT/DnPn7Y85CnFtUJA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791815923;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZXRxdPhUWPX6wNnesA9f6BkSL7PdB11EUWtCfs6Xc68=;
	b=BCLDS36dQGx8vqWALRQpdVydE3KghkxVN9damuIga70qdnaR1Iae832n5ZZBMXRGi6vr
	 R1EcbS5uA9IXoyzmXatBfY3domo0zzniVe1H+2e/rGinWOQr2K71g82ezLjtkOF1d4MSG
	 xY4F/FrZ2lolhSVfztoK8qaph4hbTbwt4hrJPlacCIBvU8E/dR76rpziv6gvtdb2rhwu/
	 vi6Trw3/75Z2oq+rkbsvPg2tQURSIztZHxI/rbUXC8ZJstq+lGB8E3mmPHs2Z2fxMri0t
	 rGZNCOv7DkJ/EApF44u8WojBicBExIIYAjcyiXU+ehvi+ugL3X9ON00r0C9Pnk1wZfg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791815923;
	bh=ZXRxdPhUWPX6wNnesA9f6BkSL7PdB11EUWtCfs6Xc68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kowJPjC8Kmoo3IR9Fw5tD9OQsaBA01GLyv7105KznwpbtNUBDgPAPOtxiIgRosgbX
	 hBp1/m4vFErk2iOwXAo3umpe8tMtl7AMni+fzz7kW5nNocKQ7ABDF0krJfC8ClpBBn
	 bP6DVWnrE2ccaYfhG0fir4AingZx040IjR9XhMeqpbkshL4mrcomEZos9cR7E1UkPN
	 OGMKeagqUMP1YVjcnTa+JgkLH73Ip40o7Gqjp1taEZAtlRR4N8+B4mNgqF98AiLI2q
	 2b4WhkTpbNDXItUvPsEGLlRGNZka6T5DuzGe+ri2m0Cm9FWxxmle76OHKBA5e+2ooV
	 HONXmqaRizprQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF8FC80A50;
	Mon, 12 Oct 2026 14:38:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CA2A3194
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:38:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BB19860665
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:38:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BJRSuV8ts9kP for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:38:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E4F4C605F4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791815921;
 b=kzQq3NQt7NQu6NUIEG0OKeiiiAEAryp+SdA930utQSsa6JPTcx7makRK35WXjU0PBWvY
 rDek3GYthiHMJzrBrK/WKcMqsMl4XItnT1aZxXKp/Hf65zYsaSSWmfo4qQ8Ui8vCr7v8p
 R+C539TLo48a0k+rFtZMlwYJc2YACmhlzhHCy0lJ0IpHLoikD1GutWOGHjk2Mpu22P7qN
 EtcFFUrRecYJZGikB0l9BZibLYJxTWWgYAiJg/Qb0r92qeTazX73aVfZw34xeqGTYs1Jw
 FJZ8NPBhFpjX/GGj2xJ6S/K7RRsmMgvE7fzPSO7QE1MjZ+eoXclX6eHlgJ5FcSurUbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791815921;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=ZXRxdPhUWPX6wNnesA9f6BkSL7PdB11EUWtCfs6Xc68=;
 b=OeIwheA5rY7Vh6OsEGyaqlC9V+ypC5JMgedIuNkklu7h5aqfNre9JS8JuzSvY08DyT0U
 3DmDf0zNJAIgZhQ/vGdK1OcxQmxSieJJbH0mNBFSsyvDl8oCKsleR2eEBLH4+JllZxNZa
 rEbaovN+Kidj/1PYMXjfD0S66Ttety2tpPXyKcVvxc30rYpMJQuoIYW7kw9LXsWhneCjh
 JzzbKdSwYrAeh2QyJBIGrUdv7a5Ms/S25sTlXzHhEL3Wi4Vw8jFEwQI375YT0vE/YwRfb
 +E8jUK5wd4UEfUjo7wHvVBctC4SChycnV7BpKB9xz3Luj7zVnnbsCfodwlZbMzcmS+g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="K4nP/4EF"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=K4nP/4EF
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E4F4C605F4
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:38:40 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-833e671ee9fso1456932a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791815919; x=1792420719;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZXRxdPhUWPX6wNnesA9f6BkSL7PdB11EUWtCfs6Xc68=;
 b=K4nP/4EFGBUZApin4dY7fmX1DmyeS/pdyRXAOkrU8tnfR4XHPzYAAoGD0HPLYXezIG
 MjImEcbUWbM7S6dFEYdoKxesnBa36Pw3q6Yq/AUCq7zoz1WTCnCJcs920Dm6cssmwrDJ
 L13BPxX7HzUoBsqynGVhvqzAQ0q6Qx8P/1Xu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791815919; x=1792420719;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZXRxdPhUWPX6wNnesA9f6BkSL7PdB11EUWtCfs6Xc68=;
 b=QDXudt6BU+C9/HP4tSXbKBV2Pix8FAYkobk6uQBweaKnq21zYt0Q9VSB71ptabt81x
 BCtmDg+HYlxC5488QD2g0skpb1xGq750JcaTjawgQ6QgidOsWZpSiHd0Pn0eJP1+WOHB
 k1yE+erIo9C64fEsfVe11vHoGMZ+2r8N6AchwnJ3YPmKbS4/6GIutKxmoJmdX+ZBEFee
 uwtTpEkkZEvsCoQ2Uism1sdYZ9RH7fL8zE0pPH4m/PR358EPt6EupiHs8FLl2uQNWUc3
 WjAoVPVQZJ1VSB9mtZGkkUihm24t+V7HHc/1zhrvEUa3DYgH+yKqrTbKU0OCX2eTy7KZ
 pcHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxztJ6pxbSIOmGszq08rJhdE2fux7VBKwdXIHDJCP49BGQ3Hz+q9+sLMz7i6hpUKICnX7iugjc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKHb7abpDFNacrMZofwjWxvz2zwwS/vnvs9dVVO2C8Anw3wTgtD
 fTaUE1gMqt9zl4GlOuvf47BgzFCNCLgKVELL0UeIVzoQyVnqHWMHeQgialRgKgqHArY=
X-Gm-Gg: AYBFou12G2PW7rsF1lc1q+AiQmKoYED2yk+YJkd/bEmAS+1TZR2GPuYl+gb8mYUzkXB
 ywfSI9dZ98RBJY/EoWxjZ1bYMVTHscoq6it3XLcpKgZSws7en/ZlgGyWmJqVnjTEAJUBW1HyvKY
 xnY75hrcZ9ghmt52aMC2xbnZc7ZH7+lxL+377MNtmUWWVblCVe+MhPsdJU82hAHs7tcLlFKd1PJ
 3lrVbsswT7pGofJDQ/RO9YOgFrhH7POnAQFP2d3Lwv9fby0+7iUu2wtSkQ3aMXu1Y4ntPAxEULJ
 5ho1YluU9M90UqsOBuI+JbsPQp7c0ijCFKERSqb+LcFT+QgxI3mR/W4xvEaDrqi5P5apPL87eez
 neY65yDoteQ0KqvY6/TZjlymafhegLXjJNcBfHyeNNh7g2T45yp0ta63usi8nsmqKBPjt8yI1Zu
 oMHSpE43pru5bQEaarVC49uMo6dDNIBmH/grk+ST8U85pIEFyVaZqUshBFinJhDYIGIwuMO57Cc
 4xAmZRIA/4kQ9ovZLOwqttFnnU876z04RZp4axvwITNwKN+9ijmS6G9O6NBejXcLJcJtYy2a8Vm
 SofyU7bsYkO6aA1R6rU=
X-Received: by 2002:a05:6820:80c:b0:6e2:3d8b:a007 with SMTP id
 006d021491bc7-6ef0de0765fmr7193674eaf.32.1791815919347; 
 Mon, 12 Oct 2026 07:38:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6f6ed64de8asm1946604eaf.5.2026.10.12.07.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:38:38 -0700 (PDT)
Date: Mon, 12 Oct 2026 08:38:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michael Haener <michael.haener@siemens.com>,
 u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v3 3/3] xilinx: Use CONFIG_TPM_AUTOSTART on Kria
Message-ID: <20261012143836.GA3722450@bill-the-cat>
References: <20261006090504.110845-1-michael.haener@siemens.com>
 <20261006155217.187050-1-michael.haener@siemens.com>
 <20261006155217.187050-4-michael.haener@siemens.com>
 <CAC_iWjLO9LwkF6x9Eq3Rej27A20W_BZ-BXmL43OumemfG17SSA@mail.gmail.com>
 <CAFLszTjAaX-HKexye-V0AVhQwFQ_uBnxRG8JkhyxkmCBTKH+0Q@mail.gmail.com>
 <20261009153309.GC769217@bill-the-cat>
 <CAFLszTgENYuyctyZudYrSrWg_COet1xmkXELrT9Vt7J_ifx=Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Bz3AyG/mlApJ4orq"
Content-Disposition: inline
In-Reply-To: <CAFLszTgENYuyctyZudYrSrWg_COet1xmkXELrT9Vt7J_ifx=Aw@mail.gmail.com>
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


--Bz3AyG/mlApJ4orq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 08:49:22AM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 9 Oct 2026 at 16:33, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Oct 09, 2026 at 07:43:15AM +0100, Simon Glass wrote:
> > > Hi Ilias,
> > >
> > > On Thu, 8 Oct 2026 at 11:14, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Tue, 6 Oct 2026 at 18:52, Michael Haener <michael.haener@siemens=
=2Ecom> wrote:
> > > > >
> > > > > The Kria boards start the TPM with a 'tpm autostart' call in the =
board
> > > > > environment. Enable CONFIG_TPM_AUTOSTART instead and drop tpm_set=
up from
> > > > > the environment, so the TPM is started even when the preboot scri=
pt is
> > > > > changed or skipped.
> > > > >
> > > > > The TPM is now started before preboot, so the TPM reset hints for=
 some
> > > > > carrier card revisions are printed after the startup. Boards whic=
h still
> > > > > have the old environment saved run 'tpm autostart' a second time,=
 which
> > > > > is harmless.
> > > > >
> > > > > Signed-off-by: Michael Haener <michael.haener@siemens.com>
> > > > > ---
> > > > Simon there's also configs/chromebook_coral_defconfig that call the
> > > > startup. Do we need to change that as well?
> > >
> > > Tom isn't running the tests on my lab, as I understand it, so I don't
> > > think it matters.
> >
> > Setting aside that none of your hardware is part of the project
> > currently, we don't intentionally break platforms, so I believe the
> > question is if the option needs to be enabled or not, for general
> > functionality.
>=20
> How do you mean, 'none of your hardware is part of the project'? Do
> you just mean that you don't run the tests on my lab? Anyway, we can
> tidy this up later if / when it causes a problem.

Not sure what wasn't clear. None of your servers, lab, etc, are
part of the project. They aren't available in CI to anyone as they
aren't connected to project infrastructure.

--=20
Tom

--Bz3AyG/mlApJ4orq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaszw6AAKCRAr4qD1Cr/k
ClntAP9brDjfVXz8aEDWYQ1Qi8/NQoYf4zyftQOm0lU8ZsH3TQD+NQsypHr+KZ6G
SAouQHw8WQxx1lUXwbfxjkLws3ks2wg=
=BI4j
-----END PGP SIGNATURE-----

--Bz3AyG/mlApJ4orq--
