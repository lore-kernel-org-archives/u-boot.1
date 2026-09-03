Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A566C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 14:49:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE66C60B75;
	Thu,  3 Sep 2026 14:49:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fVCuUuy_zoA9; Thu,  3 Sep 2026 14:49:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5EE0C60B6B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788446945;
	b=emT79IasnyvPIxeeycMi3NDrhjdkxbr/F7y1cn6EtRt9BDUUle70et6VusercTSJzlC0
	 xjtJBEpAQUUPzx+4DB8+o5kg52JCymgZ7CTvFWSVTeEikGpVNfEi8D4+weeUkZmHHtb3S
	 n6OYCNpH59XPJHRVqFRBg9FuJu55vV0WRqi4xmHkjdyCbnDTspMhCdYXgyfU8ITTkBSqC
	 +cF4Buwq5pLsxRDYr5de0tMariHfUZN1Hz4OdqG7uurr9mjnX36p2hk2E0eMWaQTpcTL2
	 cXm1cMCE1agR/0BQ6EJpdqqqA8iHcMMB+RERCm3UD3TAtoV8M0WqxZQN+wDFiHzWyEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788446945;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=a3qEds7P8bWveHPqNS7WAuCWT1e2r6SLGcVI+cQFBJg=;
	b=U1PgH9nhrmW6l17ZQPL0OaCG9jEIyNaY1yp7H7tD8wHbtxMVo6uy+/OWejC0K2j3jCka
	 bfLzd+lDnvLRqyyksGJy/cZgP1Js87JpuQyJBx8a4JuFEXhf3roMPN/+fLzKWljfMJ+JO
	 LUOz7MQkDnO1zkYY/U0cdEnl1eL2cXpDThjDmoZVyo/YIkmDTalc6wUQPOfh3uapSnSkn
	 b7o03O9ePqlwDaVFd9nA5FjlnbzJxI0JQ4CbIbcJxqsYmCuS/lzp3QFOIxL29R4AYGylb
	 5JmZGW6EW3tSAEAD8rJuxCT3d3kkBUHGyAktJW2FtJJpmFzg0OPE01A2yzTPVKVNi3Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788446945;
	bh=a3qEds7P8bWveHPqNS7WAuCWT1e2r6SLGcVI+cQFBJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XWIc02x+QJ8ACZ9bZoZdTnD9JNKt1B6v36vq9WJvnj4gC64ehP6C+A2Vwwo2eEQV6
	 pldnXWDd88pYfWNTp0SalyIZNVcz0tLs4SvNyRGCtpZnQpZsk3PYh7HzcZihJGpGO+
	 qprN1UK+Bypcws4VlApenwN8WzacJrmGwEVjniwHCAaXMZNTnZ7lqdJ8ZQGXVDpIpN
	 03V9sh+4R4+lH1ZV3KR/MBfPlEocWLjYBnZRuL7RSA2E3VCU/LfvFEftZzIMYPJ/6V
	 vbzEpcP5R4gd5lNubb/P66Rk/dbkoiJync0eupH2V1ctuf0E9jhJIMw2eoCXfqaq+t
	 ITBNukYiHv2Kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EE0C60B6B;
	Thu,  3 Sep 2026 14:49:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E845363
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:49:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4527040469
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:49:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eZ0cQs-7pw3F for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 14:49:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 86BF640462
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788446943;
 b=E7Me3yvxYQBgeqNRz7i+RYmB7HILXAm44HIkB4qiTgrBFwAlabBgl0cDVosTzZWMc4y9
 XVYUewM/tzGi8d1CEazPnH8h9hhrOvp89pzTzMKXv8bjfzE0AJ0kcCYnyD9j4lnZZo4x+
 Jl9ia/UDgxd9+dwCPolMictDAtFL6tyCvqu+dx+rVVCXv8ln+MBFkdxu3CMI1V2wkpgwO
 sKpGTwV5c+R2R4j2MWxZiS6kh3zrTAzy1EY8RuLP+53tI8fcv+kwPXagL61+U/3XS3NcH
 PVIucHoeqeSQbYdcobaTa+eGJsghIvskh0M+Le9SOMsvSKMNfyeh3x/73r4p2b0Tvpw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788446943;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=a3qEds7P8bWveHPqNS7WAuCWT1e2r6SLGcVI+cQFBJg=;
 b=FXtAGMgCndoQ67BK1mbKkPboTr0Q/gVkPeynfDS4oO3Xyql2jaL76H/CR8bj28+1k2LM
 cikwSxdfwXiNoHhXe0oQrsBCE7rbgQTy9BktBDP1Ay2xvSdbgc9wOMlQKmM1lbnUWlYkC
 xmsXPvzV2tXqpasdb+/uiGuiq21t2YhaNE9qeUk6XEbjsN4hi/B6PaazYaHXmstyqodW8
 euj/9jitNgxVTUueIsCV6YU+2ZALLReRISTl1kq8F8nClqpgfzoGDtg49GCx8Zs+MCjFj
 fYD+rE7MbMJfmsHuGL10FLWMOj6CQW5uPVRexrGN0Y4AJxj9slYc1Hk0FuwerpP0qmw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=dZ723MZs; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=dZ723MZs
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 86BF640462
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:49:01 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7f4f824de5dso1174996a34.2
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 07:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788446940; x=1789051740;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a3qEds7P8bWveHPqNS7WAuCWT1e2r6SLGcVI+cQFBJg=;
 b=dZ723MZs9XDorbcsX/Hi8SO0Q2VKhfsH03Rt2gKACyGl/3zEQj5NrZwYS6qt4y6BKT
 Gmrma/vsEbYxof5paL+Aj5vZJMVCT4RRx/ncqsgScDwHHrRGaC4zvv6Kud9bh4C1zxvH
 Dq3+JpJgw727ddfhbK2LQPAU0bqWWBuhl7Pjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446940; x=1789051740;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a3qEds7P8bWveHPqNS7WAuCWT1e2r6SLGcVI+cQFBJg=;
 b=epXtXmleBysen8Gt3SK64PSReDJrEO7DLr+DrAigcJ/bfKVa2ahyy5ubi06ggTQ9NV
 9O+8C2R+bVohoqTvD5fxRVQYSwQqjOmdMAJBUkGekJipx3ELxbX6UUWfzgiB95DQtuaX
 MjgxljdlE/vSubRPDTGCD9SBZxDkt/Dayw2L1no4LtBdgujAJSYkIjlLjDgQtWpxbC6Q
 JJ/Pspz31Q3pHG0wCmTU+j8Mg4LnZhdi9C8f6hsKLDILsbJlSwrKpgo43aWHUlIq6hEW
 sdCpnt+b6zr8ZGeVCLYYoFUBWAmfsDelaYDlz01iixcf0ZnxVWbtA8kP8DP61IqrEFR1
 //Kw==
X-Gm-Message-State: AFuF++kFl14rgXcZJZTcegGBoRgcZpgyDRJJEMze7dt/t67y8BoYbnt5
 yHqGnpYhE1NdjAwwocbHsOKyJwHSnZGC6tvjpFpjxytmhW+GxUhSWRYb/50kBccck6U=
X-Gm-Gg: AYBFou1h6rnGYNgMGlEiQYmV3OS3mNRNmqig3KhyXJkRF7b9XFdsNW5qLq6aHYx3Djx
 MON+spZFw3/2DaM2Ld5WY+LQ5cIzXOwjQ2RGGgTYoDj6kGEQ5ACfowpj4b0fVmBBC9UcJyXNP2j
 doJQSwh/TewjxIQuiqioDG6Oz6minukRFvWYYw9KMaLSoSieR4mB2anYk9InQxXJe++Gi7P51nn
 69sMVZv5HqsOSqYJnJyPvl3NHGGNNpgvM0ecZgRu0u2U9WjdBFCGcmrxTvlPfdiIIMezjwpcnX5
 mv5iwxL8zdYoOvVV5oYnYYxiQzTIDzP21DyeRKoKWJqyBWU+2GbDRWag0ZOMxLs3nbTwPf2JTim
 pVU49RTg5epnSMgd4AV24xFYnOKQnUCH1P+ZiGBNRZa78ZCkSb74+zooSnB9SfgO8mydZCgtZoL
 o+xmhO2DzHxeCNZk1RDR3rdgGV7+3Yil3mM7hFiBXpPaeHQ3mHgIUd1I7fjEUAv1t83j6huq7o1
 qfkLqbnEJv+O67oQ5ohMT4tk3PzJ1UEG35kwB6DcrKIq2FYUaup+DJ1of+5jXiAHIvhlxykGyFI
 6kAhg2KiwA==
X-Received: by 2002:a05:6830:258b:b0:7e9:cce4:803b with SMTP id
 46e09a7af769-7f78002427fmr12391378a34.8.1788446940594; 
 Thu, 03 Sep 2026 07:49:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f9f6794e22sm51636a34.7.2026.09.03.07.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:48:59 -0700 (PDT)
Date: Thu, 3 Sep 2026 08:48:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, "Andrew F. Davis" <afd@ti.com>,
 Nikita Kiryanov <nikita@compulab.co.il>,
 Peng Fan <peng.fan@nxp.com>, David Lechner <dlechner@baylibre.com>,
 Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH 1/4] arm: dts: am43xx: Add missing board u-boot.dtsi files
Message-ID: <20260903144857.GJ1764417@bill-the-cat>
References: <20260903-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v1-0-47e1c63d188c@baylibre.com>
 <20260903-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v1-1-47e1c63d188c@baylibre.com>
 <20260903144032.GI1764417@bill-the-cat>
 <DL5RG53XS1VY.3PWDBU43LSE4B@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lZMkK1pKaJzNPnLD"
Content-Disposition: inline
In-Reply-To: <DL5RG53XS1VY.3PWDBU43LSE4B@baylibre.com>
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


--lZMkK1pKaJzNPnLD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2026 at 04:45:11PM +0200, Markus Schneider-Pargmann wrote:
> Hi Tom,
>=20
> On Thu Sep 3, 2026 at 4:40 PM CEST, Tom Rini wrote:
> > On Thu, Sep 03, 2026 at 03:43:12PM +0200, Markus Schneider-Pargmann (TI=
) wrote:
> >
> >> am437x-cm-t43 and am43x-epos-evm are currently missing a u-boot.dtsi
> >> overlay file. Add these in preparation for OF_UPSTREAM to include
> >> am4372-u-boot.dtsi.
> >>=20
> >> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
> >> ---
> >>  arch/arm/dts/am437x-cm-t43-u-boot.dtsi  | 21 +++++++++++++++++++++
> >>  arch/arm/dts/am43x-epos-evm-u-boot.dtsi | 21 +++++++++++++++++++++
> >>  2 files changed, 42 insertions(+)
> >>=20
> >> diff --git a/arch/arm/dts/am437x-cm-t43-u-boot.dtsi b/arch/arm/dts/am4=
37x-cm-t43-u-boot.dtsi
> >> new file mode 100644
> >> index 000000000000..bb40317cb28c
> >> --- /dev/null
> >> +++ b/arch/arm/dts/am437x-cm-t43-u-boot.dtsi
> >> @@ -0,0 +1,21 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +
> >> +#include "am4372-u-boot.dtsi"
> >> +
> >> +/ {
> >> +	ocp {
> >> +		bootph-pre-ram;
> >> +	};
> >> +};
> >> +
> >> +&uart0 {
> >> +	bootph-pre-ram;
> >> +};
> >> +
> >> +&i2c0 {
> >> +	bootph-pre-ram;
> >> +};
> >> +
> >> +&mmc1 {
> >> +	bootph-pre-ram;
> >> +};
> >
> > Not a blocker but a question, are you working to upstream these
> > additions?
>=20
> Not yet, but you are right, this should be upstream. I added it to my
> todo, but I am not sure when I will be able to work on this.

OK, thanks.

--=20
Tom

--lZMkK1pKaJzNPnLD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapmI2QAKCRAr4qD1Cr/k
Cv4sAP49d+x3/JmxOafFtOtpZ8neBTt11yft0AwbidBEpEgh8QEA+syWth+cM1ZG
/zebUuq8d1wr2u2MsCOhEwoPk7NchQ8=
=Qxgp
-----END PGP SIGNATURE-----

--lZMkK1pKaJzNPnLD--
