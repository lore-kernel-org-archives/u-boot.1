Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366D6606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LodqBXic;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Mbh6FRm7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EB99816F8;
	Fri, 30 Oct 2026 16:05:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xKOXCnsgE6YB; Fri, 30 Oct 2026 16:05:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5412181706
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793376330;
	b=Z5DR48yX/JhGkSxDsqbbd/RnQU3QM8/JfJg9mXV9Uh8N3N6QLZ4qrrr17eszyHaPrPGR
	 QwFS6tvc01fETzsNEVetyEdRzfey0VNIT1TIyFxnCX0ACLvfD2txf4pN6QWWLShre1ZFS
	 Lke76ROy3P+n9prP8pMtXHUouPtItoWcm2R3uS7j7Fz5i/3M07E52h84H/em34yjAehtZ
	 smMldFAXA7VUDP9FFWY0Aed1XuzgPWPOPXqB/76vJ+hbcEaILOnTYdUVgYB2Pba28t2bX
	 9Cu9WePu8B8lHQhCWkwnAsqpMnbI/KYWYtX2rHUe+ve1lX9+glhW3z/byGLKXsH163A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793376330;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7mEul3ha9HO7shJa2x2NA1A72UI2QHIbT4ii7S2vh1c=;
	b=YgxpDPM2yv6lHpCGpG6QxEtB2/yDutDNqHU5g5cn4VnZ/S8+3+GMoyJ3nhUOTK3rq/FZ
	 mQRNL5c3YDQBNpkWY2+6Yhotr1/ctIjF9+Q0CCaMBKK7gSmMKWbfvYf4OdPK09//xZKrw
	 acyzUL6UUAGERW4GXEcMvEXBPrwKPXAOpV/HGKZWN07Nx71Hzq/XRzikSbETnFxN47bZq
	 pkzZBnTrr+mXKrzXh0FDKearFixhHSUZxWoVE769JOKUsogsVmoHJZ60LgKxQ4RFFhE6w
	 PLSVsQyJKbcKB2nfviAg/ueVpeKek51mJ6yZqtoFKVYZov0fBCxi3JSOf1jniB2mc9g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793376330;
	bh=7mEul3ha9HO7shJa2x2NA1A72UI2QHIbT4ii7S2vh1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LodqBXic2cYWm0cHOOH3/fXhnKqxAi64wPQwg5ilj4HJzhPhz4pZs7lrG63zzrWpV
	 CGjabV/0iAcVWQSjji1Y0PMqWg0YaBjYH7bt8j3x0uEhqQ8erQeDcRtRFSiI426O7o
	 v6hUKN9csyFdVB2ai+8tv58dAXrtk7NGB15a7Qh17nKBOkJtXMd7VSI/5VO95fzDZB
	 pkCWH1v4cQT+SBPJM2CIYXcXij1O+dGsy5r5KXWj4fko5luNHXzdhOY0NNrt2H5DKi
	 QRw5bdt7oXwHn0OpswlkTzUkFpg+thrNEeYZKNziDbpNCHTRTJhp8yAiQlL2hhe3kZ
	 K1nOWU4ns2YNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5412181706;
	Fri, 30 Oct 2026 16:05:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 17BF23AF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F162160AA2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:05:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PsCKqzG4SO7o for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 16:05:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3AFEB60A99
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793376328;
 b=jJ7CW7XcmrgHHh7pxRAQXtvi7IeAo2Kl7SR5Rs7Z6o7NNZRkf+M++7itQS4suaScRbIn
 S7irWQgIEkTQKqAVIIPbdbyfbrjxRFYUl+mSH8EPAZsCJgt0fR+IqC7eRZ4DBoPtzq+ly
 eXQITV9Tvih7ahJqwsHon6dUvzsp01CKetzrX9ACKolfA54p7VAv9ue7TW4hFXrKkixok
 ERHr+IKChVffGoLJG7bKF7UqrT8PBP+yq7ZAtHlew7oVE3zqezK2OP1oNp/0em/PAt7JC
 e/Ah9t7B6t8HBbXxSyQA70QqjPfQyfM1/vTVNzl48exlhf0L1MmOnLQsmFr+f0UHe7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793376328;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=7mEul3ha9HO7shJa2x2NA1A72UI2QHIbT4ii7S2vh1c=;
 b=L3AI3FnvSCa6ADEVOI6fdz279tax/gxh0cOx2j/o3dGy9tbHCsi+UPLpkx4SPmfTbii0
 JcwY/RkcEOqcZTcnOXAQthGOUkC59p1mySQDuaiT3vEsSxxkiFpRjhOEAJXdQ9ZcHBFq+
 jxeqEzYNJyV+m0LY7v/mEVG9XFa/jejetgA1Cs9j0N3dXdF5EeDAyXp/qqhBg+yQUODcY
 1v+Nk1FDrtUDfygZ3xnEYN5aoPtLnPAF94Ps7QdhwU9/ko7GsJvX772jykLEeEwTdLN1g
 o2jw5sa0lh+us61mVjeQk14vp6BHZHxMuzQi667gO/kvq7leUNafNN7F0ufWFEOoIYQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Mbh6FRm7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Mbh6FRm7
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3AFEB60A99
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:05:27 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-847ac7ccd85so647761a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793376326; x=1793981126;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7mEul3ha9HO7shJa2x2NA1A72UI2QHIbT4ii7S2vh1c=;
 b=Mbh6FRm7kczbtjINZgsR0QsmZKVf8YOks3x79BBBnsqPGQbPCrKfS4QmQdhdTHxGYk
 o5WPTQBQ1Ycr2OIYF93hkMvm8fvAJVmBgbTslN+t5973OMS9QVsiU4IcwpPp69rGhTCY
 gSPiyfQdgqN6Kcp81TTnKAuP2h/DR7XthTXq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793376326; x=1793981126;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7mEul3ha9HO7shJa2x2NA1A72UI2QHIbT4ii7S2vh1c=;
 b=ycJVEBf4HKc/5cYC66x0S2VuhxN8xWq5HQkSrJ8ewLKKc7Y1aCCK5NFjHxZ/rF1fi+
 4Z7Gvs4Uc3QLksAAvaDF5+bc5pRGg9V9j1unMPc4Zd69b7OMArHErdMOQRXgUbdlBwJG
 /15/91xtEcxOQ8xrRhPwyQ009BL8hGXUAS+9opmJAMrBBNaybJ4xn5GtEwXRsMxnQ9wX
 Nl8szW8WLr1aF6da3jcyQp5DhgUWk3rKX/k6dYVbi35Vsl3yDkJM/r8jDbJ1HeeRijlm
 LIHrTaDZ/bNPopuxZptv5L+pgNhKhCZ6azv1WWtxqZ79Srfc0RZettPG0wHFmo993hBo
 oq4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMH/N0sRFvEFQINDQDxBSEqQMH42tSdpYYYspwikPBB03XNrpoHb5wt9yR2EYR4pL2RGy/X3Q=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKZ6dA7fSgtcaMxMN0P6x4glELBUkR7oAknLIfphIIzNV6M/RXV
 z/f53smAE2o/h8W3r0ZdxUZwECxWAMj7yP2TpiqNDnYk/cbvX21+13O3EvqQdQTeoYg=
X-Gm-Gg: AYBFou25L7XOvQCXhjubqj//v0vwdJ+aR+2tUwRePzu/biwxGgvgeUTz1RAkBxK0zYZ
 jwId4gzlvYxuJL6VGuGaDr324Lm53uEO5QZ/ZimciKeaQsueiE/hgN1cujkPYBBkevtDTXlIdhV
 I2m7h+PQhSZBEXUiYs4rD2lM/30lmXnH3x32/t+aWYy4zcw61MKKRoPXvyzg6vMIm/5Y18CJxc3
 4zuaQb9GResr9D2QYbvxSLS55iM4MSUuMZqTrHAp51L9+fS5EG6+kbjFL2Le2QQ2wwRVhrxdQEp
 8TjwjOnrZLc2wDDLuuBZHCGSsFlUfdk2SjCLE1/LFYHzT4BD1uOArOemgCeUVLFnkYd+U0Q7wod
 GnHGreiAYe3ghn9b1UvKAyp/XrG0Qwc6xbfcrxBOi2/Pjkw0UciqgQ7s7ARRmJG8yTGaJS3gFuk
 ay5GN38pv5R22TfNKyptHDn/CWPdIHaXURoCLbPrSa0bWs1cY6ixnVFlGoU8t2fbzy43Yp15IVC
 PZ1fnDZbjxKpODnVuzzcViBgvlqDZ7/bQPHRqFeuHh3PxJ8yAdo6MNcO/ZaPsSWm7uzhSbIhUvr
 UzMgvflZ4AV17BHlR+Ytrqln47T3Abt3BEeSEbLZgugC29QluV+ufr9tA6J+7ri3AiVFlPNv+FX
 oJc/Cq3vc69Omvjgz20zl1+RlUEifxjCbJJaic+qTzXtG2AQuHQ3F/FlA17a4ODX80PpEBq7xVx
 RtnpV8V2osVDvpMLyL4oqlCq6qVm93Hq0=
X-Received: by 2002:a05:6808:16a6:b0:4cb:f21c:a79f with SMTP id
 5614622812f47-5640df8d97bmr1865584b6e.39.1793376326631; 
 Fri, 30 Oct 2026 09:05:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5640fc49923sm1740563b6e.1.2026.10.30.09.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 09:05:25 -0700 (PDT)
Date: Fri, 30 Oct 2026 10:05:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Abhilash V <abhilash.v@oss.qualcomm.com>
Cc: ilias.apalodimas@linaro.org, aswin.murugan@oss.qualcomm.com,
 lukma@nabladev.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: Re: [PATCH v4 2/2] arm: dts: shikra: enable IQS SPL SD boot
Message-ID: <20261030160522.GA3309461@bill-the-cat>
References: <20261030053824.447668-1-abhilash.v@oss.qualcomm.com>
 <20261030053824.447668-3-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9kSBXXM4zFPWfHr/"
Content-Disposition: inline
In-Reply-To: <20261030053824.447668-3-abhilash.v@oss.qualcomm.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--9kSBXXM4zFPWfHr/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 10:38:24PM -0700, Abhilash V wrote:

> Update the IQS device tree for SD card boot in SPL.
> Retain the SDHC2 and power dependencies required by the SPL
> boot flow and configure the controller for SD operation.
>=20
> Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
> ---
>  arch/arm/dts/shikra-iqs-evk-u-boot.dtsi | 19 +++++++++++++++++++
>  drivers/gpio/msm_gpio.c                 |  3 +--
>  2 files changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi b/arch/arm/dts/shikr=
a-iqs-evk-u-boot.dtsi
> index a1e506f7dff..f2265c741bd 100644
> --- a/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi
> +++ b/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi
> @@ -46,6 +46,25 @@
>  	bootph-all;
>  };
> =20
> +&sdc2_default {
> +	bootph-all;
> +	clk-pins { bootph-all; };
> +	cmd-pins { bootph-all; };
> +	data-pins { bootph-all; };
> +};
> +
> +&sdc2_sleep {
> +	bootph-all;
> +	clk-pins { bootph-all; };
> +	cmd-pins { bootph-all; };
> +	data-pins { bootph-all; };
> +};
> +
> +&sdc2_card_det_n { bootph-all; };
> +&sdhc_2 { bootph-all; };
> +&pm8150_l10 { bootph-all; };
> +&pm8150_l2 { bootph-all; };
> +
>  &qupv3_0 {
>  	bootph-all;
>  };

I thought we had gone with upstream the DTS files first, bring them back
to U-Boot.

--=20
Tom

--9kSBXXM4zFPWfHr/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauTANgAKCRAr4qD1Cr/k
CoFxAP9onK2hTzUzG09KPcJqlo6M04dE0NEv50ps5I2Ch56pbwD/ZZ7kCP2FKLE4
0qS5M+rOE+MBvP7yYe5ny2ImbsMfpQo=
=JBJC
-----END PGP SIGNATURE-----

--9kSBXXM4zFPWfHr/--
