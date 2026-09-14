Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FC5C88E6F
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 20:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CC4C606F0;
	Mon, 14 Sep 2026 20:44:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fRqG5NNKhlqM; Mon, 14 Sep 2026 20:44:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5AA406060D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789418666;
	b=CK/pAfL6Rn6AzsPJluVno0YcvNwksBQQJ9XhiIwbhfFI7RHjG5BoRuKg+DDKSMDiE1zv
	 HarQzzB3Ilgfq889N7+WgiSe7KC1uHRQGHxwc43dXFlkzPnKvzKE+yFwqr1nUJvM6ecAK
	 sBQ30UCtLJ67HsNPPT3CjPQDW7SKuvqlcfZgnYYcThF1IoLL3CUNyRBFbvU+IFWa5RKnU
	 72Bdn2zoFD16owMHEfJgzfwv2K5bKCzOI0DwfuL9neRlebw1qYCpjg8vTrjz90+Q9kj+g
	 KtIL01dM9W6EtKMnnYgS4kq1p2w+FGRZZMhSFwMAWzmLgrMCHfq9mRgRHmnnwms6aTg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789418666;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=NP88i3DbIX2iDHaX/uRK1G6BxBa/+ZC2U1u87Vw4l34=;
	b=KhCOtNVsYTb9sKAeZFZ6Jlhxj14JuN8vDvWaFSfV3nhkZEcr/oAnONO2hI+WlxPMK75J
	 QWrH45MemlCJyx4TbnrHe+THNvDJUD4h6GElz6/GpBz0pe1z4xi+YWwCyJQOKnfZVchNa
	 V7Ou/m05wxFUBXGkbQoHP65gfxXUJ4LZlqaLRMAshWhFs1V7VQk++snCSnwHH8H4vrjaD
	 LAQt8aPqSf7DFWGKY1z7eM021ZxmVp0nrwCkbyAbsF4Mnu+elAoxnymLK5ReodmRdTpUB
	 4xaiNEnUcb6/ufuI2W1juuMC649Z5m117cWM8t1q/R5agfTM4x1o0ni5JWB3zWi0aQA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789418666;
	bh=NP88i3DbIX2iDHaX/uRK1G6BxBa/+ZC2U1u87Vw4l34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gCFWUTNowT5UywbdV/IT37NLRga4EI+LcC1Xw9qR0SU+c9wa1r+aWvsYfXEPGb6BM
	 XycUL2BUs4Pt+76VOr22DgUcBybNUN4V4r1FElSseG3y9SgfCctnLeeARbjvxtOe+t
	 jVRas9eyLhgGn6z7z8+ZLYvcQcdeFHEGnNxsANra+jCu+GZis7d4xqpP3AuckGIu/F
	 TQT0YBhR5gUhUHsbEEd95pSvWez9HJ6WzCHoWkHRv/DOriUFDmiELQmfmMtY/0EcBE
	 qh57ktpWeBsxw27xZlywK5P7fanMYJE07VnfmRDdXkOOxWD1c3DOtG54CjS2AtFYq1
	 lVOj9xdo137jQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AA406060D;
	Mon, 14 Sep 2026 20:44:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DDBCD2E5
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:44:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DB6B080BB2
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:44:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dMT8IRF0axCk for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 20:44:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3C3C180AD0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::26"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789418664;
 b=lOKRH3L31vmgXbQ5Wx/iK8ue8cyVDKvDHzDCbUX1rCbmUQj5/DDDlRpDNf8mUFixec+K
 y0VKjqhWfF4Hhm5INSmrR5CgvwcENibCkKWdD9DuavBFJL6G0xn22n8Yalfq/+Q6TesH1
 EpN5kqZFeaKsu5jfUgtxH4csxz4bDYIc6YQDdX6XzUX0CY4mBZmhuKWLZbFfoyxvqQ6IH
 GW/aXSZcQuuqgeI9Ak622RfaK5bCbHcsoKZLrWiVMivh0Ffgf+VoXKmDL5Wg9daJsnex0
 QFzq8FESmAIvJucAltmxDAoAJqL+MyKxF2xS0HTL2Wrl5S4IH6qmW4fS44s51CsfPxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789418664;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=NP88i3DbIX2iDHaX/uRK1G6BxBa/+ZC2U1u87Vw4l34=;
 b=UGAjDwvIRikZJQs9PpWf7+8ee7wZ5bUjzXqGmiEr1T9RjmA26ZpBp2iiOjUZKRx1qLIY
 +Wm5x1HVOPcpGs4enN8t6Isp9uCk0MRjzzF/EBtqkc8UyXHTXhMvQYShzteUcAThHe+ph
 TmFwgN1cFx+/Mv6QKFdy4qTZMsk/EUWEygklg+cdXn0o8Xp2BI3M0oCClBONVOc78gKYk
 ZUUD8dRYsMkkKyTmdo0ka54hJ2aHI013h4cZoA5mC8mvweD+DGITO8WHjWsmyvTF/2a/t
 NbX7LcVjye1eEhzyJoRS0LUeuHoafagNqh8YaMIdCo9ouY8Gt0i4+ORgx8f68PwWijA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=URbjaRv3; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::26"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::26; helo=mail-oo2-x26.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=URbjaRv3
Received: from mail-oo2-x26.google.com (mail-oo2-x26.google.com
 [IPv6:2607:f8b0:4864:31::26])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3C3C180AD0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:44:23 +0000 (UTC)
Received: by mail-oo2-x26.google.com with SMTP id
 46e09a7af769-80032c08611so2308737a34.3
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789418663; x=1790023463;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NP88i3DbIX2iDHaX/uRK1G6BxBa/+ZC2U1u87Vw4l34=;
 b=URbjaRv3MZ0m0QnOs1XpFh5RHHmsFRSA77qQxvgAPPk9Cn1uuS70FDv2JvWebjq1Ie
 QpogfQ8XfMUpbcqXXYALKanCw7MmLCYWqNsBd1/kLigJEFrrfOectgVzmL7qX251kWA9
 QlqaOmJ+sYlm6crlr8kRv9mWwUy0P0ZBWR2AM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789418663; x=1790023463;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NP88i3DbIX2iDHaX/uRK1G6BxBa/+ZC2U1u87Vw4l34=;
 b=oQo/AtGB1EVJ2CtXY5hPw+MDHkm32wSDvDxvm5jIFrGd+x0fg0FMTi33zQSTljiWTB
 09Fvg8tnOkxugNL/67DsshBxxarV0zsT9DNRXHN0O/JHM6PvaYGx/sHpE8dVVzc2HNi1
 NY4Gojt+SNPFlT9Jss1vbakM2E4pFWOOxLIiXsgOMYnLHy+E4VNF9Rye6WfWHedR2KTv
 suleAEZPtjMDeRv13bGifCpl/4+xfLG5o+ojxav3mtcTaCzJ2JWIcB+Go5gs4Ts1j5GH
 V8r+nOZzpV3yuVSA7UpdVYhIJQQzl+iH9cMK7WCmCO5au7bhGdfY9g/hdYvh0OXdQ0Yn
 cFew==
X-Gm-Message-State: AFuF++lFD9acAg+8jKfOnIe3YYmDmO5Gu8CIReXpyrNBArBU1smQfWHu
 iV6VcuJqDROoFuSqMwdwoRIZgU8zPUujbLkVGlLlQtLRtWs0qH4auICbqnAAC5NLsC7e7JMCV80
 s2dT9d/wqi8W6
X-Gm-Gg: AYBFou04c/ajAvV/6JwT+AD8/pMj3eXktJ4AnMmRi1wfMEKmXpa7DAdau6fuyk0IB3m
 ndZYYT/HVevBIkHUMnlHUxovz1+qm1CTlGkds6RcwEl57QzcIJY5pfng014nqx5VREj4CubfKqN
 ZGf57Kk2ibximoYrVBWORvnMwmZd5RO8sqfvFYOqDmlfL5bFEWKAgnwKr8sFhXq+QE/EgZyTdN7
 LmZcf3uAcdHz5RTYeXBISxwtmrKQnfgPmUFPBSvHU1WWNKzTOWCdA9lNpiZ4WJRw2ZqRxb9E5uW
 8oUUIp8QlRjC6z8v3Ym4dr3eRHQtpcNHGbKmXnsXtOKYW8f0h8Va+9a4RzT3fn9JDP4fZQ0SXBV
 mviOtxhxOQtvwl0A630Fpdkv9hSMX71RTgcC0ZCmCQMquSpTYOu3s/qtA1h94SFPbqbmtZk6CDG
 YUpaOB3K8s+VnNTHzjT8JBpD6ax56tSUfRWmkXdJ1niSr8zJm+hP8T7mzb/4m4QlDIFI/vZ/vsi
 vUmTT3RoqOK+iicEEg1iwacMMJJFmcDGKdrAFYxAAeWNk+M8TLi2wEb4lul7R7RnKQ9DEFWGxyN
 iRR83U5xtBfw/tiR0Dau
X-Received: by 2002:a05:6820:161f:b0:6c3:64b0:3751 with SMTP id
 006d021491bc7-6c53ee565d9mr3595070eaf.5.1789418662951; 
 Mon, 14 Sep 2026 13:44:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80477ea9138sm11057663a34.1.2026.09.14.13.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 13:44:21 -0700 (PDT)
Date: Mon, 14 Sep 2026 14:44:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Stefan Hansson <newbyte@postmarketos.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v7 00/13] arm: u8500: Enable upstream DT based SD card boot
Message-ID: <20260914204418.GH1764417@bill-the-cat>
References: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
 <20260914200914.GA625059@bill-the-cat>
 <CAD++jLkfBaAvq7PySwyT41Syx6knHtbk1Ef=LYP1LN51pRPd2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bVESRLxnupF0zib8"
Content-Disposition: inline
In-Reply-To: <CAD++jLkfBaAvq7PySwyT41Syx6knHtbk1Ef=LYP1LN51pRPd2g@mail.gmail.com>
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


--bVESRLxnupF0zib8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 10:40:07PM +0200, Linus Walleij wrote:
> On Mon, Sep 14, 2026 at 10:09=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
>=20
> > OK, so, the problem is that since they aren't in Linus' tree, they may
> > get over-written with v7.3-dts once that exists and I do the import. Can
> > those changes live in -u-boot.dtsi file(s) under arch/arm/... until they
> > are available in devicetree-rebasing? Sorry for not catching this
> > earlier.
>=20
> We can just wait until they are upstream I guess? I'm not in
> any particular hurry.

OK, yes please, lets do that.

> Could you just merge the driver patches 1-7?
>=20
> That enables me to work a bit with some MMC throughput
> improvements on top, right now it works but it's slow.

Ah, that I think will run afoul of the email I just hit send on, sorry.

--=20
Tom

--bVESRLxnupF0zib8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqhcogAKCRAr4qD1Cr/k
Chy8AP0eZ+WSSCl3ntSxSaP88Fjkukm4a+Fqwp8KbZK9fcKXDgD/UHxCTiR8an9n
jGFDUG/1+bw9LBZicBm8xuo6JfiBKwY=
=pJ8A
-----END PGP SIGNATURE-----

--bVESRLxnupF0zib8--
