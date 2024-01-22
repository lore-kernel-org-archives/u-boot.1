Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937ABC46CD2
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 23:31:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E98B86FCE;
	Tue, 23 Jan 2024 00:31:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Bg183LVQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F9FA8753C; Tue, 23 Jan 2024 00:31:03 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CE198640C
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 00:31:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-600094c5703so11744957b3.3
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 15:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705966259; x=1706571059; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H4XHnT0DW1qgd60SLKEdvd1Vic25DF98KE0J6nWPV8g=;
 b=Bg183LVQLG2a4bwzlY90QUDEsFUMdoaqju1c6YqmbYLoMVuBq8QSgeXXX167tx3Rp0
 6VGYRHzZXRjlwIZZP/QtyZ83jBQaNnAHfgej7Y4d6XrePlWdApqcYzOFrrxK35iUs6Ow
 aXog4h43mfDAWFoC+Qz6SXwoCNEGxteviV/gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705966259; x=1706571059;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H4XHnT0DW1qgd60SLKEdvd1Vic25DF98KE0J6nWPV8g=;
 b=M8DsIB8fXIUcrysFsUkSt6i33Z8eIz9CsHnkFklOcdBO9vE230tgAZq3CcpLg4cihW
 yppb5HSk9mKA5uLVAsfS+C8UfgnrHqZw3ZKT0E8Vibu7f0qn2jS4hqNeE9KRRys/jTsI
 FqaVyrs5BzM/JmULiUkF05dTojIVK+wf0JFUIRJZpATyxRzEb4YsPuEmW/T9kcvgSpUA
 ZQS7ABcFIcGJdAB1U4UHk8QQIS4zgnG2EmjHzAIy549IOEiNOWa0lYbakeRECn6UDCHS
 4AYKjoHjY+a5vod7mdEAM4H09prKzJ5hfdBW/Fkc6cd4Lai7s5UZWDVeTRgOPa2/vnoX
 DSqg==
X-Gm-Message-State: AOJu0Yyoz6q/ySwAXPMgf5jB05C6OxSeBtXZOBJxAw3HkKcEj55emgfM
 NZbLtBx70QsCk9manfNe4ixLkDaoX/QFAigk8hVFlR8DlTPMVhjAym3UDdltDGImmyAdnfshLa2
 H
X-Google-Smtp-Source: AGHT+IFIFzcga4VFLlkQxgKDuorqzp7MekyD6bAWn1KHdf+xvTAUGi3XK+4Uhfwn08KXVq3iJuhYxg==
X-Received: by 2002:a81:840a:0:b0:5f6:f591:ca13 with SMTP id
 u10-20020a81840a000000b005f6f591ca13mr3781143ywf.55.1705966259576; 
 Mon, 22 Jan 2024 15:30:59 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 n16-20020a819e50000000b005ffb91a94e6sm1735133ywj.59.2024.01.22.15.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 15:30:59 -0800 (PST)
Date: Mon, 22 Jan 2024 18:30:57 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Hugo Cornelis <hugo.cornelis@essensium.com>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20240122233057.GR3652023@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e13dw8Nmmd8lsjTQ"
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


--e13dw8Nmmd8lsjTQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Here's the latest Coverity scan report.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Jan 22, 2024 at 6:26=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to Das
U-Boot found with Coverity Scan.

1 new defect(s) introduced to Das U-Boot found with Coverity Scan.
7 defect(s), reported by Coverity Scan earlier, were marked fixed in
the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 1 of 1 defect(s)


** CID 478860:  Code maintainability issues  (UNUSED_VALUE)
/tools/image-host.c: 359 in fit_image_read_key_iv_data()


___________________________________________________________________________=
_____________________________
*** CID 478860:  Code maintainability issues  (UNUSED_VALUE)
/tools/image-host.c: 359 in fit_image_read_key_iv_data()
353             if (ret >=3D sizeof(filename)) {
354                     printf("Can't format the key or IV filename
when setting up the cipher: insufficient buffer space\n");
355                     ret =3D -1;
356             }
357             if (ret < 0) {
358                     printf("Can't format the key or IV filename
when setting up the cipher: snprintf error\n");
>>>     CID 478860:  Code maintainability issues  (UNUSED_VALUE)
>>>     Assigning value "-1" to "ret" here, but that stored value is overwr=
itten before it can be used.
359                     ret =3D -1;
360             }
361
362             ret =3D fit_image_read_data(filename, key_iv_data, expected=
_size);
363
364             return ret;


----- End forwarded message -----

--=20
Tom

--e13dw8Nmmd8lsjTQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWu+q4ACgkQFHw5/5Y0
tyz+Lgv/TD0A8Dgc7pBSjlE/1HS+tzGgreFITs1wAPM5wpUFvyxC3tFQ08eRSd8G
L3ClJZr917UH44k0QxK+n/4htqBVcujSvbPo6x/0tgQ3zm5wK2SuaoL9frqkmCHZ
/KMwG2fECWxzhISEK96xE+llP+prYXv4zPF8m0N+J3KjtajHp9pL37pmmaIXRwr+
s26l6XsDdT1diQEmregfeh+ztauN3OVN3VRK3j/yJeYf3LrT4vP7bvklG+1wYXoN
Cxe4fZQv8NyBAQvP10DKvKk9s4G4o43BmGjdxj3rW/0/rekG5wsZN0HWv+qNkxRj
fgV8O24zf+wXh57aaBoL02W41c0hFo3ME9nuxhXsa7O7l2cV+ekgaIkaKQolkMEb
telvOq2BvXX9CLRqJGOHr9G19pYy5lLq0iBIH9vi9b2r5Qg07yjx+jOTiVljBmRs
Mi9m7UgOPhYc4DfN17mt8XoxqCA6Gq//HesvxhKeZ9APniuzJ9sNkdQ82y3NF/Gb
UoU241oS
=odxI
-----END PGP SIGNATURE-----

--e13dw8Nmmd8lsjTQ--
