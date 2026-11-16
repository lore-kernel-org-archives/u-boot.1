Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D84A606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uGdAomSl;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=WQcddTR5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 686E080DA6;
	Mon, 16 Nov 2026 16:12:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kil7W1hHwR_m; Mon, 16 Nov 2026 16:12:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C079B80E48
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794845535;
	b=VVZYO455kG5V8CCMzBGTz+REwm9wg/yYZUxDubm73APtCqWKd8F5/zIrQpW0ljLo4Ogm
	 XUaAGHYtpZJLZxzXBmMmaAJDxooXsctkFHYSAJdszxIFUh6Z8389iLQUG/a+P2Z0P75xR
	 JojCNkdtE+reJk2YgsatQCe6xyU25/aQ88+2sBpDErtiLYdSa2frJwNoSu0pqf1hVGuXL
	 8vh3Vw4crZUVEv/4vjSoMbtebip8aG1Afsf//bUbP56csUSkkaiExzpZB9GQNgIKx/6nn
	 DRFsfV1HUJgINzwmHEbVcrrp41SnIOCOJC88gifEjyobDIfv9oBuUp9L1CoN9diIdHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794845535;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=X2EV2YkGNKw13aT/hQwsgsOB4dsBY//5jZoyBlqeZ6M=;
	b=mLO8NYO2qjBQIefPlijNKWiBSX5nv6lud2umrlnUJ7aUWb17K1t2VrskqZD19vP8o/bv
	 8cFvajU4aagRxuieuAXS5w8a4eCWdE5xYLKcPh2Q5TZLL7P1Xu0IsU3IAcAHMpX7KorHL
	 x8xZel9rhil8nefgTNHW7dwuWpaZq+f81rdLsg5mPiyAedn49iHA4YAVMbSm4Wqo5m2pW
	 ScXTzP1J46iOunmIrzPmtVPM/vTGfGR5ImnNXmA3CowDVsZQLEFfnMxz+OWXwS91WCgXJ
	 PbphbhG9mpyXtIDNDYV5M0xG+Xcx9baVaOxvE4YRvdypDlq0jIDDI22gdMlfPxYbGpg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794845535;
	bh=X2EV2YkGNKw13aT/hQwsgsOB4dsBY//5jZoyBlqeZ6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uGdAomSlb9QVdfrOByROKQANm0c7nLMnxGmSNhjUqN+sMNpauB4GwYb2o9fRFBoJl
	 IOxrkvKgNlg4oe3sh/5W/IzAU9bQtJKd1SHV2/zeIHhYJb/ynAmP1MBRaOkGX3K1nk
	 8oxFu2Azj/74787aRkGllR5ybEw5Hu2kKUtuJLO5kRxZtDuV5N1SIDJDZH+VCUmCM0
	 fL2+Wkg+Iif2asL73EDnITYuCVvKfowgCB0JLxJCpxwqKk77qqp3uYd/Wckf2SA9Fr
	 mCIz6jNiwVCHIuRRSPy/B8zMGd6zQaTMGlRZiqvIXfjsJO5vMaNAe72U8TQxAw+Apc
	 VhBgjh4jWStxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C079B80E48;
	Mon, 16 Nov 2026 16:12:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AACBC2FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:12:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9403660721
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:12:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ywjhYs75LBve for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:12:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C7E666067D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::36; helo=mail-oa1-x36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=WQcddTR5
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C7E666067D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:12:13 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-4a77dcc4ca0so3355539fac.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 08:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794845532; x=1795450332;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X2EV2YkGNKw13aT/hQwsgsOB4dsBY//5jZoyBlqeZ6M=;
 b=WQcddTR54jXNeAZTZnP8VhQiFtw4fXhiTgQjZU1daWkRGx23Pv5PFpKFW55girBUHD
 NY3Bx9W6nZpGB6tt/dWErSrDppS01e0zXNWTyiYxuNS1N8bZKkvFigJO3g67UKrno0YP
 ChNVD8KpFkxK/6W/uR2/UJGYKuVyRmRireHSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794845532; x=1795450332;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X2EV2YkGNKw13aT/hQwsgsOB4dsBY//5jZoyBlqeZ6M=;
 b=FNi4youXloazQX7+zLo66KzF+vvuxEE1L60dfgtAv3jnJ4/7u/dfs0uJc22/N1mAOI
 xqnpvmedTZKUGjMVgOXWPrTBkpiJTKLJwc2UeE9UyEDmYxQ47+ip2KwFegKAN9BBKb6A
 LPYeXVyu5lVV98Ji5n8M0BnQkxB9u6jGDmsRnBp7/t1BnzSCxp2o5C0mvJTydOHePPtm
 1PgmnIJsdayemMHliRb8ExbCReZuFyg96EjcAl+404gm0R3kN80TGLhQsUlJH+SwQ730
 Vuv6qQnWqdO6ynXtdNhBzSYjPShhn/8TRI2n55x4pH6SOZg+xVs1Qy/gEMEIq9a5iFn/
 UvMg==
X-Forwarded-Encrypted: i=1;
 AL+hErFzVJu4zhPLhf4JNIVU44cBhxeu+aIt2ygLQGq0kdC/zjhOx6U0jIKdTVSGiMlhf2Z+kbHNriE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8E19MiEZrRg4XvA9hJ6+3t94flMMSIA4PQjVH93zZ/9VPZt9e4
 OyD2zq9Hx9DTAMnHp8LmQBko+tqhpB9KdK/9dzzXWZJMNq2ZAu8iiUTKOX/yelhhieI=
X-Gm-Gg: AYBFou0OZ5Kj/sIBXy2z2W5YEtI7yOa2vDgVPSwfaHmmUtfcDL1bhcByDmzzT2fp1VQ
 vb0GvzzC4jbnGInbMCIUVdPSQAleZZFtqa24n2PfKkdKLuMpz/UpYuvdwtF5OwIfP7PGQsVuhNE
 Es5fsQYGSPBXxfYYwlYhwDhs1UGW2AsuhGYP2kJPuaqHDPcxPKkO9tzoNBGfOYdadcwfdndcIj7
 Nh8GVQtvrjZkUSSdPTWhYRHVoQGErEc68CAl0/FRaPUhilQLuq1rgmbOpNuQMwQAVVpBgW0VHCc
 lWDBlotZ7JLiDhxT4YxwLfJ2phdgW5DrqaAN4eFtHoC0Z5DOZdSikk9gfMuz/AkOoY4Ic1nK8Gt
 HEjjr9i84t9c3vxujQEHov28D9K1mczD/PSyF6Jyrdv4vroMqcAszehHzAfE3xSHFUsWWnUffIf
 5mrKC8PMqSU/m2chKW8SfsunL0OYzzhO6RX1SgoslBfNGw1U5tehl9QiVjLMIputNRhZ7wFQscA
 DLMh6h8l7YTrM5b5leFTGQeYAsIK2N4cNmLZ7sA4MW22oo3MJfatfUMoKkGT0fTx2OkJx0JeE0X
 NaI9KHWPme9hKAKrrAPwWCMl5hklhiCASo/iZwgxH3diovYHyuUo2LYOb/Sri2bBw3qtRAok7dm
 Ea0yYoAri35MddGOK9+O9lgwNcSpOdsDKWCT11BIn6YWkAFhDmuEj6L+WrRPATE/iDbMbq/99rO
 F4cHQzh3zz3xeMSwgSCerfacef4HXKJqo=
X-Received: by 2002:a05:6870:e18:b0:46a:d10b:bcc2 with SMTP id
 586e51a60fabf-4afdf28cc97mr8303787fac.9.1794845532161; 
 Mon, 16 Nov 2026 08:12:12 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4afe22e1fb7sm7419290fac.14.2026.11.16.08.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 08:12:11 -0800 (PST)
Date: Mon, 16 Nov 2026 10:12:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: ilias.apalodimas@linaro.org, neil.armstrong@linaro.org,
 u-boot@lists.u-boot-project.org, srk@ti.com
Subject: Re: [PATCH v3 6/7] arm: dts: k3-am654: add bootph-all to gpio@38 for
 daughtercard detection
Message-ID: <20261116161209.GA554944@bill-the-cat>
References: <20261116055029.3493551-1-s-vadapalli@ti.com>
 <20261116055029.3493551-7-s-vadapalli@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="COEx5eLFoXnZ2tVA"
Content-Disposition: inline
In-Reply-To: <20261116055029.3493551-7-s-vadapalli@ti.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--COEx5eLFoXnZ2tVA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 11:20:06AM +0530, Siddharth Vadapalli wrote:

> The GPIO Pin 38 accessible via WKUP I2C0 is used to detect the
> daughtercards mounted on the AM654 Base Board. For the daughtercards to be
> detected at the SPL stage, add 'bootph-all' property to gpio@38. This is
> required for the PCI-USB2 daughtercard to be detected at the A53 SPL
> stage followed by A53 SPL updating A53 U-Boot's device-tree by applying t=
he
> device-tree overlay corresponding to the PCI-USB2 daughtercard.
>=20
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  arch/arm/dts/k3-am654-base-board-u-boot.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

What's the status of upstreaming all the bootph parts of this file?
Thanks.

--=20
Tom

--COEx5eLFoXnZ2tVA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavsrVAAKCRAr4qD1Cr/k
CuarAQCHgNa5NjHTwD4vj+9Qp7ZAacEQhKaXEcUaajiI4dUbdwEAgGTSMrghSWo7
fdYhsEz9iDc4FdxPv/4bUQggVf5CmQQ=
=eeF7
-----END PGP SIGNATURE-----

--COEx5eLFoXnZ2tVA--
