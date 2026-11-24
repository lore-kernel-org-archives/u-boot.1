Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02089606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=v109mP7i;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=D0ybsjYR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C626860889;
	Tue, 24 Nov 2026 18:28:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qtxQTc8TU6Jf; Tue, 24 Nov 2026 18:28:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DF8586076B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795544893;
	b=S8wh0XFDzPBpdbLo0D1Jk120DYO5eyMertcQTX0SfBfKh0/ocW76YqYWql7eGVbVQ+e2
	 vUkZz2Um2mpqUWlrlt3UxkQ4gE28VnHpkrVJYfaM79ejPgMEQbb3luNgOcZWMFJJDirmd
	 qrCDHrs5xQZLlnTzQt0W7jOGk7JsG+FlzBxhCDW3HXg1DE8JkyT2XdM54rie9EkiZV+Ul
	 oOGrH779/0ZPQnb9yuuFJCQqC4YjZCLh4mo1HQndZusvOutfIXAs0fvwSchKP387iZmR+
	 f4PRre01Lrbc3JRwX3w8jXTQUCx2+MJzRl7Xzwh+cm7t9qIkVGeAxu3as8qngSuvhRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795544893;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dQv5SP1ehYZhQ3lT9QCByYrZUDRMVTP4y8t/pNEs5Wg=;
	b=m1+1Oqv+tmCQ+YCV6julrAAIS7t6sp9DEkJi/Gclr2j7ToJfOGCEsxA6b2jG8+TwztfN
	 M1g+KOJf8KJb8gm5lRTjiyhVICRDXHKeqdE1uJeo5cHPM/hkbFbEXcs7UMbQfICoo9fRE
	 L2dcX5gBw6ErM6kJK3VW/KH59ooRX4QRJfLHVYvhrdIqgb9m9/gkP5gQMCdUdRSZiP3n5
	 elc7GONKwgxScGtdpMNlD4S50HJ1aRl2aFUa9Q32OxRq8nJYl3DKLSUslF5+KwO86ipsJ
	 25rJ7YSlX8eCyKtqKBmYTsJWoMhNjpnNaJhf5k6mTHAgWLWHZh0K7TqgmpmbU4+pzAw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795544893;
	bh=dQv5SP1ehYZhQ3lT9QCByYrZUDRMVTP4y8t/pNEs5Wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v109mP7iqpZQE8iB7g7rR2HpOxJwVTQhlUomAUogbXeNEbSLED6jyKEV0uhIgqexZ
	 PMv75mO3PczSZ4/uWEJm9Z9so1m2LKbyWGBaYEpoukE3I8Khu3ZQDujlv5ifUj2Rba
	 +a5DYIyIZfQOxJD1J2+X8DBz1JrvyoR/GDpGNIfLva7nMJVR1zU/+nMWm2Skr1lfGK
	 FS5T77W6S/2oEyYbEO9YdPjqkNlrSLREC0fa5VzzjlRd0pEKm+AIt9qAViPSwOYObK
	 v+ffJmrnwd6EXOljNi5wfUuFN156qWgJZQE4yw8NamK3CJJIAkhmicGWEqabfQrPU0
	 1C0MWotV90rYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF8586076B;
	Tue, 24 Nov 2026 18:28:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 557F02DF
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:28:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 46FAA405E3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:28:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Klv-P6q4SDwY for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 18:28:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 722FF4040C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=D0ybsjYR
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 722FF4040C
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:28:05 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6b19e291cc6so4312998eaf.2
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795544884; x=1796149684;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dQv5SP1ehYZhQ3lT9QCByYrZUDRMVTP4y8t/pNEs5Wg=;
 b=D0ybsjYRmh7po8wslSEb8BnBwljtrgGfxFns65qCuxK4lifU4eFTaMMxNhr4Dfu3zE
 PoPfALyqD4zahCGH+4pTwzBU7xjeFNQwUadQf/7+koKNCJX6d5tJd7i9wSIuuYvc7hqC
 hBaapVBOTzUxPZV4B98FVPWpYUWGjL0dS/9QM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795544884; x=1796149684;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dQv5SP1ehYZhQ3lT9QCByYrZUDRMVTP4y8t/pNEs5Wg=;
 b=ePBoh9RodzwogYXYX+gd3yTZn+LfA1TKhCDyBjHa9IqaEJ+x1xk/pFdLxaXRfKkW9z
 EudLkFh/+GH82ohC7oDKlizkszcxx2EAA1gsRn5vcyeDKuDYdsL+96B7uK5gydUkqBWm
 kXZSwxcV8E0GgHd1xSANJcyVLZ4RndRqEqsDllmzUJe5+vXn2ZwywDmLc8ixkiqhypEJ
 nFM5J5kxJvgvQ9MnQmk6H8qer2s4Bqr+kRmGRqfHJrkWeE+caRnuITU1rGO8DfeJpIDr
 e4nkHhZp/oKpYZwQA8LhMrgFP+r+S+dMCQGC8wMsADCn0tle6lh3RXSL9FUwNQlbnHWn
 abRg==
X-Gm-Message-State: APuU4Z/AqllWVs44a8Ghx5CFzLKLUYulManGttAKVqcTxGW4mYVNurE5
 o+DqrcIGeWWt+uJQLFdcEG60UEiDALxVHn724DcZM43akNMYM3WjQWh213EGJ9Wj51s=
X-Gm-Gg: AZFdTZft/wI4jS9FQYqXVpxBkhAMTmz9F5tpk+iOiDoV9C/Y7U9oRPsG/U1F3uAC6d/
 Yd1vJUlgvrB6ItcNqkhBKtCDUrpIVD8H3LKvIYF7QUMXdwWBUqZYrIjHfhuJr6L+WpbUV+YpUVN
 8prgkTqM/ZzHmMeNXIwf1AjZmT+yk799INpk6zc1zcjoAjYZpsyNN7QO3qIp9+GLaEaV4JMcuqi
 vzOHuj9/uaokm9xeGzWXPYhWIvnrfIKVxYgbYFzEZ9Dq8xxkLQnu/eX9xHxm+MCzGZCnRvSphB2
 QqkrIoNZVQg3cz97ilCIcXMKTF8WK3IvvqMKYEQLweg7+fS8rO/FJZttKEyW84hWKJWTLOvcvju
 70x4YerWJqCtGVJALYbh5j/mGe0osmTbrSHhXEliJUl490sF9wbatMrFJ1jeOYWKbdWz7Tun/8c
 gXLOH7vDR9Mi1y5RrJ2+dw7XOattnYNCDn1YWRjixXGX9v2xFOmXouI33C0ANmDgXL+qfuimCYW
 uDSPXtPcF2M/jNIJI6dBdZ9II9ucRWUrICGSQWiU0EPx78o4yRbtg+TFzGdwGWTcYyQ7h6TVdNk
 VdAjTRGzUrIYxLB5L216voOBSv+AqF2dm7l30wL+J0LT4CyVl45+yOPAkgaccuUYiCIylfYLR+n
 QcrTN8zczNstHJDQirXjlEqsmoyMG+FOeEYZxBldRNoR073WliTkuqaJdzFj25S75n9LJ3BBFiz
 SqCK2oYt6JRdSVCBjhUc85KcJpo94BWn8=
X-Received: by 2002:a05:6820:625:b0:71a:e33c:f9f1 with SMTP id
 006d021491bc7-71b76ebfb0bmr736665eaf.3.1795544884226; 
 Tue, 24 Nov 2026 10:28:04 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc60497300sm14991097fac.11.2026.11.24.10.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:28:03 -0800 (PST)
Date: Tue, 24 Nov 2026 12:28:00 -0600
From: Tom Rini <trini@konsulko.com>
To: "Richard Genoud (Synaptics)" <richard.genoud@bootlin.com>
Cc: u-boot@lists.u-boot-project.org,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Terry Zhou <terryzhou05@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Michal Simek <michal.simek@amd.com>, Linus Walleij <linusw@kernel.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Chris Packham <judge.packham@gmail.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@nabladev.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Peng Fan <peng.fan@nxp.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 David Lechner <dlechner@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Guodong Xu <guodong@riscstar.com>, Yixun Lan <dlan@kernel.org>,
 Jisheng Zhang <jszhang@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 2/8] arm: dts: sl2619: Introduce sl2619-rdk-u-boot.dtsi
Message-ID: <20261124182800.GV3176972@bill-the-cat>
References: <20261123-sl2619_base-v2-0-9e3b28c77cda@bootlin.com>
 <20261123-sl2619_base-v2-2-9e3b28c77cda@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OLsrbzkwj1wuBjrN"
Content-Disposition: inline
In-Reply-To: <20261123-sl2619_base-v2-2-9e3b28c77cda@bootlin.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--OLsrbzkwj1wuBjrN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 03:22:01PM +0100, Richard Genoud (Synaptics) wrote:
> Setup console before relocation
>=20
> In order to setup the console before relocation, bootph-all is needed on
> sm_uart0 and on its clock provider sm_clk
>=20
> Signed-off-by: Richard Genoud (Synaptics) <richard.genoud@bootlin.com>
> ---
>  MAINTAINERS                         | 1 +
>  arch/arm/dts/sl2619-rdk-u-boot.dtsi | 9 +++++++++
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5f66db5d4608..279193e8239e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -712,6 +712,7 @@ M:	Richard Genoud <richard.genoud@bootlin.com>
>  M:	Terry Zhou <terryzhou05@gmail.com>
>  S:	Maintained
>  N:	synaptics
> +N:	sl261[x0-9]
> =20
>  ARM TEGRA
>  M:	Thierry Reding <treding@nvidia.com>
> diff --git a/arch/arm/dts/sl2619-rdk-u-boot.dtsi b/arch/arm/dts/sl2619-rd=
k-u-boot.dtsi
> new file mode 100644
> index 000000000000..72e2adebde3e
> --- /dev/null
> +++ b/arch/arm/dts/sl2619-rdk-u-boot.dtsi
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +&sm_uart0 {
> +	bootph-all;
> +};
> +
> +&sm_clk {
> +	bootph-all;
> +};

These properties should be upstreamed too, thanks.

--=20
Tom

--OLsrbzkwj1wuBjrN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawXXLwAKCRAr4qD1Cr/k
CuMAAQD7Og9uCuwJislIIehDH7DvJlMWVnHgMVIDDQ+qkSS9zwD9Fjo9zv2Xsix1
Mg9009wnWANaWGCp+MbkShEP9kiSXA0=
=SgZJ
-----END PGP SIGNATURE-----

--OLsrbzkwj1wuBjrN--
