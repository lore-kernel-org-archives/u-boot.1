Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCAECA5FAD
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 22:51:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14238810D8;
	Tue, 29 Sep 2026 22:51:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jtvZBtUNKcke; Tue, 29 Sep 2026 22:51:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5A5DB810ED
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790722274;
	b=cRola5Sto9e+aqHxI7Qcpag6dBXnjWXvpFTk3XOKr13VGB+2tISFuzriqlZgoHDi8uRX
	 Tke8oh7cCThgW5JBRMgGmbUoAPyPL06lp5aUTA4BNqiCNnxgC9nonQldUUYU547bZgmx/
	 yTO2na4zsRcbLDm/f4oxyymDDzybjVk3Tkxh0hUWj81O6f/TIeXbq+hoBk65RBuonnY0m
	 hg+RvHQodsJ/cjbvC6q4jNjH+vXbK/0aqjCbOjTz0vKhDhzc/kDudI6WbnTYhsQO8pnHp
	 KO2fmN7VbwOuPlpy6jrf9l2WNr5NwIoQ+VrQb+x+U3vN9JW+0o2Sdz3NyJ88JF9F4ew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790722274;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wbNw6btFVYPiPyBNKeFbf4L524F3BuehODCr1ClIQwE=;
	b=pHoQmP+Q9dRTMLTCIv5d9vtkTh3v90EJfYfFI79Ei9MPTzppAcVOsqCdArehuITVsJjw
	 wdArrmX87dp5+td8H69t0GbqoqlvW49fN+zIK2BmSKgPC0CmuegVJsNGy1Qh9hoOg2whR
	 FV+NDAp5kaPVIrldefjD9U6Fj7HMFv/b7GIpKmuqA6dTjPu2Bv594yHZJpPJvAgt2rX4Z
	 DlUHV/NRhhUcNS2L2LIVhgthp2keBI8YXRpEgeEDX7SngqY1A3wFKYy6cW8Zb+2aRl5CS
	 4SkV0/XvQNz98raMUzVFen6ykRRyKrB26xl1+nHM/oOyxqiywmjkDBDgNaYaYAoU0vw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790722274;
	bh=wbNw6btFVYPiPyBNKeFbf4L524F3BuehODCr1ClIQwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HKoms6JMpoRILZ/KV+fRYhN5ujtQrki0fCoEOibVqdUCHva2Al7sNrL3vOT4URX45
	 PZQh+xVmYajtrCcbAvuZ9ZuAx9jWpY2+d7otCO2Fav19vcQSwm4RealsHAZqSANPq4
	 ovVPm3gYH99StdhC4l2NSiktl9DuP1CQSv4CyxfDlViLWfCqxp51SE/WIw/0GVwTTJ
	 Nxjw4LEu/dm5xCGANfwGl0w2zxu0q4a9jfEpyQjXN3jCRrZucm0LM1YGG8hrS+Kwji
	 lvpEqQt92a/+P/3Uv5Jfee8VaPfAI3f3QobPuBsLP6u1JMBLZDMYk/ARWrM5Dam/5h
	 0r3VZVfs4ZPcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A5DB810ED;
	Tue, 29 Sep 2026 22:51:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7796D32A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D72F4034D
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:51:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OHXy65g2YSvb for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 22:51:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8B9ED4034A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790722272;
 b=nXs6VShx8P6X2//pUz3MMUNgR/WQ/COjESG3GVng+FLUyYez8sO5vs8j9COw+EEvTTIk
 rD4usotO2Fc5+rqyOGrfZN6XWNs1fh6MQFEDX1pgFbWUvO8IYaR7yRLE8xxb8FKqNcygd
 SWUUNdBgZjuQlpQooOWRr+JV9v/JyvdRUDf/OKkrEx/uVi/FsCZxhmbULPzPd+Lu7YO1R
 tD7FDarLpnBE+ldfwv9b5pSCVg+Ce9CJCxAS2dWYLRvGClsaZPzpnPYp3ySlyDc8aEdwI
 0Zlm47l40IzIsDooSJPAsO15npg6di+bdTWde+wMrn472xrWmR8M6DpGE7xyl08fVEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790722272;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=wbNw6btFVYPiPyBNKeFbf4L524F3BuehODCr1ClIQwE=;
 b=tbWQ9Q93rSQk7lMduwNDpU2ST0j0WRPUtyPaD7Ll4iJQLoJpCipog0eYnyQeLZlzf0ba
 9bFtSLxrjclQrfoJzAOERDseNZfqw4nk07cS7m2XjKfXy5+k7ZEv18sCnCzOp64TZvGtS
 pR5pwbTcAwjr0EnDMFzpyfW4LfdjMAVtlkiRL0sHnFApiHo63ukLzBWtuC3LOc3iWrouI
 JGeiFzYeWfIaGNmM0eXdQ+xr52YGecLCEiQiJrzm8ALsv8FGmCYsGy0vFpdDgDuNhpHo4
 SLf0VkYiPEENn8uZF5TRybgO13VU/0z9I4MBHGsx+YT0alaynM1srmOKxu4xokykk+A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=dHKigpNQ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2a; helo=mail-oo2-x2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=dHKigpNQ
Received: from mail-oo2-x2a.google.com (mail-oo2-x2a.google.com
 [IPv6:2607:f8b0:4864:31::2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8B9ED4034A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:51:12 +0000 (UTC)
Received: by mail-oo2-x2a.google.com with SMTP id
 46e09a7af769-81be5042c56so2329689a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790722271; x=1791327071;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wbNw6btFVYPiPyBNKeFbf4L524F3BuehODCr1ClIQwE=;
 b=dHKigpNQ02UDpI+EM2MZ8DRrUVLcJdcaCjNAr8X8Eohty3hPYJpNHNqbB4bkAY83kw
 BIjqKY8nmLieHhljODRCsUfZJ0ynjUn9et7Pb36XAWpG7N6Vsg71G06wYU0slRcBaPkW
 ngoId0dPYlrGaOV2Q3IIpKdBSeWmffy2HpNIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790722271; x=1791327071;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wbNw6btFVYPiPyBNKeFbf4L524F3BuehODCr1ClIQwE=;
 b=pyH7c5eTBOUlYYOGtr1qVZ9HxIJGmAGKdF1CVXibV+NAZcxsroBwtpwxv10clNMnde
 ZrrGFj05fn/8Obo62Unqn59oDIysV+/aDcuecEubsCCNtXmY2dsjfe3YY8zR5pASwbFi
 36Lg8o1n78aTiQvfsQB2ch7R3mloacwrFGv8s3/Q01NRdO/C5OLU9PQeC5iRW7/eQMtQ
 iGUionVgG0QxXv65+rgHOf1zyR+gDc5mdBzxmCOaQwCeFmPWonrhypGKOPh1+FitFgXC
 CaTlkMPkWjexl53L05RikBvPAfFOdFZ6VEs8BwI0PWmubo+bv+ehLWh73OmO/E5xexYj
 9KSQ==
X-Gm-Message-State: AFuF++kvklhqTHf5a0hNv8VhcUZtAkLPnNlfRaqIiINumSFrgP3ZNpcZ
 Ad3LUIpZstQz7immj3yGknDGDrg8UNWKes3lTm0KadKG2+nwBqZy7gQNbgwEbEDeqHQ=
X-Gm-Gg: AYBFou2y6RxAWYoA3aqdc424VUQB+aPm0G9/KGo7/GYbeha5rGC03rogV2XmRZU+Vht
 EHNH3nZPFVoVn4F6H94+nI/n6nUNg8hrnrMkSpoBLbV3UKir3IZ6rElBXe7inw1rDkm8kWRdIMj
 w0RV66x2SHT2cM+Wakvo+2aIQGF67da0uTpM732bNA6TXXgZp/iw0osrN+7tIRDqT30vHTlXAZg
 Fx0wgVJiaaNcNvT5AZSNB/h0wXO4Ypymr5pHcweQ65pjW24UHOeCUcclW2shxXjURQWMmIbQJPr
 pMhadnILemI5Y/4h5+l8zk5C7v+fD0qOnmPBed7+zrBpcWnoDD/lMXiT1BGYMIsRS1QBvjByFZy
 epJZC98L1ZIBBIQBnwCp9z23eNkQp4UjVPB4ZDCGc5PiZoQRvDkDoYkvlNiXqqdB7VxDTxMjbkl
 s0DuyDBcXUhtotFFWvevr1nHOPhcPQO88kzdZOH82nop9tzNzIU8WF+24xfyyYP5d9e+u5LW8yT
 2gAp6/wn+DTFBy5rEXFV5uSo6vWSSdegPZ/4kJg1x6dh9SYkkgAMd9UZdTNwYg5yh5YLhQnnkzK
 zHVqMdUI3cazTtVEz6s=
X-Received: by 2002:a05:6830:6736:b0:814:b62d:3122 with SMTP id
 46e09a7af769-81fd6137c82mr860515a34.22.1790722271116; 
 Tue, 29 Sep 2026 15:51:11 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81faf30c204sm1288422a34.12.2026.09.29.15.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 15:51:10 -0700 (PDT)
Date: Tue, 29 Sep 2026 16:51:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] cmd: config: Add additional embedded text option
Message-ID: <20260929225108.GD858934@bill-the-cat>
References: <20260929173244.369402-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9G0XGw4REiY8HViD"
Content-Disposition: inline
In-Reply-To: <20260929173244.369402-1-marek.vasut+renesas@mailbox.org>
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


--9G0XGw4REiY8HViD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 07:31:59PM +0200, Marek Vasut wrote:

> Add empty string Kconfig option, which depends on CMD_CONFIG and lets
> user embed a short piece of text into the U-Boot config, which is then
> printed by the "config" command as part of the embedded .config.
>=20
> This can be used for example to embed OE /etc/os-release into the U-Boot
> binary, which can then be used to identify the exact OE build from which
> the U-Boot build was built from:
>=20
> Insert content of buildinfo:
> "
> $ sed 's@$@\\n@' /etc/buildinfo | tr -d "\n" | \
>   sed 's@.*@CONFIG_CMD_CONFIG_EXTRA_TEXT=3D"&"\n@' >> .config
> "
>=20
> Print the configuration option:
> "
> =3D> config CONFIG_CMD_CONFIG_EXTRA_TEXT=3D
> "
>=20
> The output is a one-liner print of the embedded string, it is possible
> to interpret the result and the embedded control characters using e.g.
> echo:
>=20
> "
> $ echo -e "-----------------------\nBuild Configuration:  |\n...\n"
> -----------------------
> Build Configuration:  |
> ...
> "
>=20
> Please note that this does increase the U-Boot binary size, and
> therefore use with caution.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  cmd/Kconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index ff90a87024c..0d8b152f12c 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -170,6 +170,17 @@ config CMD_CONFIG
>  	  command.  This provides information of which options are enabled on
>  	  the running U-Boot.
> =20
> +config CMD_CONFIG_EXTRA_TEXT
> +	string "Additional text embedded in .config variable"
> +	depends on CMD_CONFIG
> +	default ""
> +	help
> +	  This option can include additional text embedded in U-Boot .config,
> +	  which is printed as part of the .config by the "config" command.
> +	  This is useful for example for embedding build information into
> +	  the U-Boot binary, e.g. content of OE /etc/buildinfo, but please
> +	  do keep in mind that this does also increase the U-Boot binary size.
> +
>  config CMD_CONSOLE
>  	bool "coninfo"
>  	default y

Is this just intended as a do-not-apply? Otherwise, it needs a gating
option as well.

--=20
Tom

--9G0XGw4REiY8HViD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarxA2AAKCRAr4qD1Cr/k
ChhvAP9itSUMjcgsur9BKcAEWf/EMF4SR8vq+KMAxie23InABwD/Rmh6Lf2XMtyo
qwdRdUYK1U7N0iP0fHhItLFPBe9TuQk=
=0R++
-----END PGP SIGNATURE-----

--9G0XGw4REiY8HViD--
