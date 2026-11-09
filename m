Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C939606A325
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bsQPJbD3;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=a/SWrOxr
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30D9E40604;
	Mon,  9 Nov 2026 22:16:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MUjw7ZHMw-Rj; Mon,  9 Nov 2026 22:16:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 444CF405D9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794262618;
	b=Z7cPtnBPH0oGFPQbjFcFHhNS0LcPCbBlX2oRF4D4wdD2TssbWJ1gwJegQujTRqACsegi
	 ceAjl8QwPpLKkt8ErEjFlDGK7n0Yr8b1viYcqNNa7uFokFmoB6JapL0awPSuw6bjYk/Di
	 8pZ5+3T6BIrEi09V7bcc4CVTkjVa35exeBeq0HCxx0u+zc2wCvJjoOAGBZBDa/rCsb4lg
	 yM8L7J8xhCQS1sUuRxZJYRdx17pX7TwM9/5zSBs/1euKSkfQ7zXuH8Xxt62cE/9Q05Cgt
	 0yazXENcK1xbfjnijtCG6CcosIqdfno/eKs5yZ1kslzINchUEArJU3DVs2sgPDbMYIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794262618;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gEz3VaKon9V23jiiX9F+/Hu5tQMZW3wBq+eKGwf82v4=;
	b=Bj5xTNKal0ME1+0pw3qs1419dhB1ggP5HUr0A2yH2A1wwPbFV2+4CDAsBwHUr/MPZCHa
	 2FuxCYPgvKXTOKLAsytjB4K86/rvt9ATykluZaDzKJyUATkKUUOW/ku9EHlRP/VkBi6Km
	 4GqT4fllP5YSOihz1Bryl9xAKKpTJ4EL4Uorc/xrgQqimVS5JRaP67JW2eWazNJLhlSvT
	 aLkoZbrO1D9cDsuSWkz57KlWlOXjivU06S/SvxXqdbRvuZ20zj3jRNkSn3veb/FoQPZuW
	 A0Q4Eti7uymflbiQU/0c0hRr8hnkcHEv9OZMRVZCkPpQge0EQmFrFERz6xzRXXD1+0g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794262618;
	bh=gEz3VaKon9V23jiiX9F+/Hu5tQMZW3wBq+eKGwf82v4=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bsQPJbD3zyKHTgnLwgSeI1idRiaYQ7CBXhI36RCYNcBDMuo+W0RN3vMSRkH+Q9zx/
	 ocnC1Xy2J7hKBc/NqS0ElLAu/pf/E4WDD4b5rL93jCSWZ/W1y9sge6WPA8KuSyWmM4
	 B1r+669oGiXycQatmxyR9SPDtFqWAi92226zO+SSrHb6CDWc6hn1I/61azVmw7BTpq
	 xcA0nAQQt0ty3j/+rPEglgG+d1gEP2U2k2xvh/rLhkOeC2G5O+iVJpLVmBr37rRKlA
	 U/rbaq4dwMkZWGKT4LqPFl4LJeluM/GMAkWeVoVwuTZV7PbikrD22i3S5COyngSswc
	 gI25wY9O08k0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 444CF405D9;
	Mon,  9 Nov 2026 22:16:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CB96B235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 22:16:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B0A6C80FA4
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 22:16:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Jn4o0-lpTOl for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 22:16:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2F28280DB9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::6"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::6;
 helo=mail-oo2-x06.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=a/SWrOxr
Received: from mail-oo2-x06.google.com (mail-oo2-x06.google.com
 [IPv6:2607:f8b0:4864:31::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2F28280DB9
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 22:16:54 +0000 (UTC)
Received: by mail-oo2-x06.google.com with SMTP id
 46e09a7af769-8217177c5daso392268a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 14:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794262613; x=1794867413;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:to
 :from:date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gEz3VaKon9V23jiiX9F+/Hu5tQMZW3wBq+eKGwf82v4=;
 b=a/SWrOxrB/If6yER3bJv/6bMc1Ab0b8Q6rUpco3S1UHk8/yhlM4inYli0lUoVHpWEq
 gYBg3yJQuC/J3x1jN5JZgWP00y9OEvodM68C3OgS7dzIIZADRqr5xhg8ISnFXerFJW8d
 L/BaD6YxS4coeuDS2+ZO8X+mKk+kh04SMicnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794262613; x=1794867413;
 h=content-disposition:content-type:mime-version:message-id:subject:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gEz3VaKon9V23jiiX9F+/Hu5tQMZW3wBq+eKGwf82v4=;
 b=FJh/UjmfOfCBOQtqXPLlH1O4EVEkAp2SOFVSbAB7Q8fu6wBETprADliRADtwWhXMzL
 I1xavn4FtJxUD8Ev7PIuOLHSEBuAHkM0Q4rmY9AhMv+yr88HKyV5RImG/yl3yHGy1E73
 4n9V1GFrz5mNphvWQgj+F8nqFpxC0FAvB4Bp9I5pMcmSl1JBf4cbcPJyvgsaRO/RWz4F
 nDgtY1p+znwMs3b3r/+nIsXcjp6XqdeoDKjqzTsogXRUO4D4Qu9DxLbL48DZOXTaBcJa
 /hhcU1xR9f9UCBtTCPVNfCoWTM/rZR3K3uo6VxaZ5379RCJSVTw9U5rQ4G7Ewfwetn40
 humg==
X-Gm-Message-State: APuU4Z/x/05A2Id+ZikGQrZO6LNajXBOe703q2926CyNCRL5MKcfOMAO
 QWp0bFPMGzkt0Xk+rPUGlvKwyA5jvwzzpgjwhYQ2Uczq+cNmF+IqC/+eTj6T8RbLygxLC+ljb9q
 lcgJdVXLuo+ajAMg=
X-Gm-Gg: AYBFou0cZ5dpVwyPY1IngsZUvxnyXbO3R9irs52VETAacFkhGYgUvEfs8KMU75cMApP
 xxw4I9nigwV0EJrb5l52kh94foJDpBJj4yzXyWOvjYxJzcX97w3e+K/wjBHRZurDlzQb7+M45BD
 mcDkIZjJaT20uNvig4PcRvutezYyiw8a9VTyOofYM1WYmUNZssTFT46EMKxFMBLgQk6mBKDu9cI
 GGnFgEIHjWFgQK1LhwLAHBLjmstfWi2xIau6rRI1Sga0QJcosRtA8LAOYS0z3tyNuplzX/cW3lk
 V+2tz/4rYSoJxrprOjxQeRE2XEgohgyrGIQgEX18Ze9rM1krblOP0XsoJkgvzYTsEL4v/TZOw5w
 qFFpP7XXnt9RZPMOBzG9t+KPzBm2ABYg49RnF0/NTaPizf2BriOyzfXOh4AEX1ZnsShbHZLF+iU
 H6x+idwhIn4ureRvexYNKEs/ZMcjiCMZTyLpEkLyMn9UoshWfIlHNibP7j39wKvKOuDw9KkHmWZ
 n61Ml+v388myMtRXYGJWh1hmYvDvZCvHXfFT9LDDo/CnQH+on66N9kOWprudxWYHDx77Eqbtf/P
 zkWVD7WEf97gB0dpnHFOK6O3KRnNSLXA0gk7/rfB7zOwtzDoRMZn+eVbCY4R54fkqBUxrO0ubYU
 p17LzXy/W1+llAzegYN1XhiKAvvsdQQzAsRD+gymt/mFP/LWo2AsdN8NG8zdwTCIR5aWABCpbCQ
 xqK8m3Uk20OmRsRgEF8YxeBb2Kyrd+Qoc=
X-Received: by 2002:a05:6830:6809:b0:818:56c:a8f6 with SMTP id
 46e09a7af769-860dc84598fmr473980a34.26.1794262613406; 
 Mon, 09 Nov 2026 14:16:53 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860dcc237f6sm470903a34.24.2026.11.09.14.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:16:52 -0800 (PST)
Date: Mon, 9 Nov 2026 16:16:50 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Linus Walleij <linusw@kernel.org>,
 Aristo Chen <aristo.chen@canonical.com>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20261109221650.GA3741582@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IcwZ+L7xXqYWP4au"
Content-Disposition: inline
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--IcwZ+L7xXqYWP4au
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the latest report.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Nov 9, 2026 at 4:13=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 2
   - 2 defect(s), reported by Coverity Scan earlier, were marked fixed in
   the recent build analyzed by Coverity Scan.
   - *Defects Shown:* Showing 2 of 2 defect(s)

Defect Details

** CID 661899:       Insecure data handling  (TAINTED_SCALAR)


___________________________________________________________________________=
__________________
*** CID 661899:         Insecure data handling  (TAINTED_SCALAR)
/boot/image-fit.c: 2244             in fit_image_load_storage()
2238     	fit_image_get_comp(fit, noffset, &img_comp);
2239
2240     	if (img_comp =3D=3D IH_COMP_NONE && load_op !=3D FIT_LOAD_IGNORED=
 &&
2241     	    !fit_image_get_load(fit, noffset, &img_load)) {
2242     		dst =3D map_sysmem(img_load, data_sz);
2243
>>>     CID 661899:         Insecure data handling  (TAINTED_SCALAR)
>>>     Passing tainted expression "data_sz" to "imagemap_map_to", which us=
es it as an offset.
2244     		mapped =3D imagemap_map_to(images->imagemap, data_off, data_sz,
2245     					 dst);
2246     		unmap_sysmem(dst);
2247     	} else {
2248     		mapped =3D imagemap_map(images->imagemap, data_off, data_sz);
2249     	}

** CID 661898:       Insecure data handling  (TAINTED_SCALAR)
/drivers/pinctrl/pinctrl-nomadik.c: 171           in nmk_pinctrl_set_state()


___________________________________________________________________________=
__________________
*** CID 661898:         Insecure data handling  (TAINTED_SCALAR)
/drivers/pinctrl/pinctrl-nomadik.c: 171             in nmk_pinctrl_set_stat=
e()
165     			continue;
166
167     		cfg =3D ofnode_parse_phandle(node, "ste,config", 0);
168     		if (!ofnode_valid(cfg))
169     			cfg =3D node;
170
>>>     CID 661898:         Insecure data handling  (TAINTED_SCALAR)
>>>     Using tainted variable "count" as a loop boundary.
171     		for (i =3D 0; i < count; i++) {
172     			const char *name;
173     			unsigned int pin;
174
175     			ret =3D ofnode_read_string_index(node, "pins", i, &name);
176     			if (ret)



View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--IcwZ+L7xXqYWP4au
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavJGRgAKCRAr4qD1Cr/k
CtRNAP4nlFyS6iJwqKE4e+fYiJsFMyurAU/LlmdTkzpOid6eDgEAksI7+jWYLKmU
JlDRtMZjvRXcbC3jAmAMoNNQUaCk4gE=
=/65o
-----END PGP SIGNATURE-----

--IcwZ+L7xXqYWP4au--
