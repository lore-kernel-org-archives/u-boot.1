Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EEAC53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 17:36:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A98F606E5;
	Wed, 29 Jul 2026 17:36:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9j8B8rL9Xt-D; Wed, 29 Jul 2026 17:36:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D932D606BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785346592;
	bh=/YBcDjmQ5wqZ26ecIZvm5oApXtIUdSPT4rEwPpsWk9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wkaT2XNsLCDyQJyK02OY84DGii0MDfnCJL6kyv72HLdPLfGHjD1l+q5y6BlaCoWhV
	 C6L6VvbwM6tRQ2R4alng4mZEVz6wunm6B46q4aPccKWMzkcz37jdxl0QgTtsYFS0VS
	 w9QT4iqnkb30zNsTfWVSfQpuGrziU/4WsDtBifnB20aRgLzVm+1nYZvHoMYb2f9T8k
	 bhPCk6ZbQXeC2+kFiRGT8DAgJq/2EOznnGPl+cvg5PN/ATUu8oN90xBf1aVrDGC71N
	 J7o45r2WWJGjxibstId8agMYV85kAf8KrRi52+Aii/7vE27J59ef9rFTs7YE1XnyfG
	 yMiJxDBPxsHDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D932D606BF;
	Wed, 29 Jul 2026 17:36:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 021C9197
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 17:36:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DBB8780E8B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 17:36:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VG1x1qc9kHaJ for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 17:36:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 217B18085B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 217B18085B
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 217B18085B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 17:36:29 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6acaee38a75so332166eaf.2
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785346589; x=1785951389;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/YBcDjmQ5wqZ26ecIZvm5oApXtIUdSPT4rEwPpsWk9g=;
 b=aKtWWYe48lW+VSqVypASXYIftC7IThLwPvsiD770UGoixL95ONzIIzfGQtWygXGS6u
 dp50F6WSlXi6CTiYmYE44vUgO2E9fSGUQ4zILMNjsKs4Z4johEcuDGuOUBgh+YWOXKji
 Mv9WcGa02eYSZyI6948Cz8iHyJuZ/fjAQTc6cHEa+aGacLDKBHNwljAJ1OUAZEYs3E+A
 +JfDR26Ss+mZCe+/FuG2edg7vJSMJ5pZ+WKY07MsVTmleRGZk6SpWvFK2hvKAyJtlYuC
 awaA33YiseQ1RoSRkgb9/ohnpoyy0ecbdyStocqF0BsFG23FvhIK7cKZIok/ao5xmHBy
 hAHw==
X-Gm-Message-State: AOJu0Yy8YRC4s9+x2qstQ04Ub5F7N5qiuVl6RCPPBWHcLwydd7dxhi7f
 LIJVTpGBS2QAfebcOLvNDZqDaEB9M+cv3qOM/OsO1sL0beb56zqJB04gL+mfySrRYnw=
X-Gm-Gg: AR+sD10wBcI6EldRe/7D7VO8okKZXIrZ2xkU8leSl7c1wXVOTxMiIFMGpndTip/AkkC
 klAPEozQdzt0yz+vEFQPIJxLOXsnL0t6MIR1e+uTOiCgViEXwvZWbL5W71VOH8UyLHHHjX5eFXV
 SlvWJrR4oCQBtcSLnujc5Q1UyGBoHhUyTsrbEsM4yRjU0PjqAEREZ9wPvF2yOmv/LIr1pxYSPhu
 ZAkznhWTZ0eHnjnJsy2a7Bo7CF0VYplMdXbahbbFQ1TqQfL5u+yRbZckic96bDCYXfpyR8k8hPD
 +EJCnpPeMwDAFIfGj+JWub9a+WYiSxyTmr5VUkPr6tj45jn9frPSL6bTmbOKla/yavhhyCdbTq6
 RySB6gntLasxVhpd2nXaL8kk+bxT5Um4Ydqj4U3wfPaLxhuL6WNYYVRlsmpjytMh0bKSqnOIWlj
 OxKp3pkvsgpu6Cwu8jX1IXpseKmRYcyfTg/VLj//jXIFPOIpThwmu6+l4WSuKbO2lbKRKXycjPn
 UPNCa8MUBbINJGRNIuwN7Ak2fVZlAE0wt2r3++N8xkZdZo0jjwg39P6Me5fsue/Z8fCvFY722Ns
 W8l+bVb7AA==
X-Received: by 2002:a4a:edcb:0:b0:6a1:4040:97c1 with SMTP id
 006d021491bc7-6ac96cb29b0mr3617517eaf.56.1785346588947; 
 Wed, 29 Jul 2026 10:36:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d591cddsm2814732a34.2.2026.07.29.10.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:36:27 -0700 (PDT)
Date: Wed, 29 Jul 2026 11:36:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH] arm: imx943: Update dts files to build with v7.1-dts tag
Message-ID: <20260729173625.GD1773261@bill-the-cat>
References: <20260707220301.252935-1-trini@konsulko.com>
 <CAOMZO5CiHN50j0jcuydok3rV71eXFA1Becxfq9prjOZp6X7oPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jcF9BnTcLbSB2Uwj"
Content-Disposition: inline
In-Reply-To: <CAOMZO5CiHN50j0jcuydok3rV71eXFA1Becxfq9prjOZp6X7oPQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785346589; x=1785951389;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/YBcDjmQ5wqZ26ecIZvm5oApXtIUdSPT4rEwPpsWk9g=;
 b=awSV9Cyoso+x4L24IERaJIVE9I8LKaqTHeNN4cP9CV+M5m0wdpbzqNSTBrWqS4msAc
 AuAPiRJ9KSm+PnchHre52gUMccjEAd4HsT/heFzlikEHPf471dUhbX2WSz7TEQ+KNjlc
 oDvcdoQ9940gxJsakDNxYA+H0fqz3TAcxJXvg=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=awSV9Cyo
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--jcF9BnTcLbSB2Uwj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 06:43:24PM -0300, Fabio Estevam wrote:
> Hi Tom,
>=20
> On Tue, Jul 7, 2026 at 7:03=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>=20
> > -       usb3: usb@4c010010 {
>=20
> The removal of usb3 caused a build failure, so I did not apply this patch.

OK, so unlike the Qualcomm and Rockchip fixes, this can only go after
the v7.1-dts merge. I'll grab it then, thanks.

--=20
Tom

--jcF9BnTcLbSB2Uwj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCamo6FQAKCRAr4qD1Cr/k
Cs3pAP9H0zmbHorbOQytw2ZIr7sZGIr0YZArhVpwDZCPKSWCCQEA42Jp157rab1P
7mH/5FWcvxt9yi+C7frUzclt39HXEA4=
=rJ/5
-----END PGP SIGNATURE-----

--jcF9BnTcLbSB2Uwj--
