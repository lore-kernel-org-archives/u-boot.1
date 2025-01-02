Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AA2E77188
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 16:27:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0F77803D2;
	Thu,  2 Jan 2025 17:27:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HcErrpnl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E60380196; Thu,  2 Jan 2025 15:45:01 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 557C88001F
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 15:44:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6d900c27af7so89210366d6.2
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 06:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735829098; x=1736433898; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dhTjW2VRGlH7YF4nFyiQnYZN+GDe//vWmEVEPFZS4R4=;
 b=HcErrpnl9fpQBvMEKfwGpYE0m/7OKjLqMB2ri4Z5DafV2bzx7+ALYRVMrO3O9q7cdb
 9Gjnt/VRuOCW/W2Ug9No4UcUGQA+QlpuxE60HrROVAqxjc0cRwbtMpAJa92GuYS51nby
 ppbbg0/N0UUS0vFyxnYL8FphmEenlpU8h8cUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735829098; x=1736433898;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dhTjW2VRGlH7YF4nFyiQnYZN+GDe//vWmEVEPFZS4R4=;
 b=bNoE5KeVVTgHXs4G+mWLOIthTaXE4gdcMeCUqNntrSZ3FeanIHcs6OwWaRen4kh5ip
 bb2SNkZrQ8Obo/yHlJ77pQLvc9GmTnHIHiNK6sfhR78KnwpRjiWqVocyvdpXeyVaGiO0
 rFq/u+rKXHVVPuJGJ52S2RL21gHH67lxYXNYoWsikrXcHE0kf+8lemUQwFDaoQZtog5b
 DEMmVr3Gm8aK3GIawrpu0FtCfRNPfVt1VHzXdTOuv9Im+GC6xA7pyK7bMVfNVN1PMJ4q
 7RlMP399svYlvx1qEA30HmYal3rBIGOzOqaauf/TBcPC//r70JtrIFJEu74Y0LLyOOyJ
 kvHA==
X-Gm-Message-State: AOJu0YzBJigL+Ju+VLOok9WixQ8Gls9JNR+xPau8pCiIml+/89U8lxbl
 5uq3O81JnFpYHLM3do9cIcR2VPpQRt5ItqBWpYTMKLGduq7mRqo9XKoBadJ3h/k=
X-Gm-Gg: ASbGncvO8usywZq2ssyGUe4ZzctaJ69oL0+aR6q+sVY6taNs+FLmGpAXJPRMQHrL9zG
 Wx01DdGMFmd7nrpVDhASSQSSlFx4l5/xQ+pDN0ZCfFpllZCMEmXAmFYbdiS20nB/yaWbUuELMg/
 4oZsYbgPIh6ulwFnF4BdU/tsEoXavTAX9IU0jyJDLUKOS7fHitpvgBVEfzwU99x8CtoNVsAoWDL
 7WIz02ZKjJblU4x8ipYEbw4wpc4fcGT9wWNR5Y03CI8DjLMfzKmJeO6Kw==
X-Google-Smtp-Source: AGHT+IGezGnvBzu8ekegu5WubDmmLBIs2WhW0dqmzo1NMW0kkCAZ921SfLYBdAG6hTlO5aotiU9YPg==
X-Received: by 2002:a05:6214:e67:b0:6d8:7f8a:73f5 with SMTP id
 6a1803df08f44-6dd2334daf5mr639798496d6.24.1735829098123; 
 Thu, 02 Jan 2025 06:44:58 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd1810ceebsm132736726d6.32.2025.01.02.06.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 06:44:57 -0800 (PST)
Date: Thu, 2 Jan 2025 08:44:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
 Alexander Dahl <ada@thorsis.com>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Dmitry Gerasimov <di.gerasimov@gmail.com>, Heiko Schocher <hs@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Hugo Cornelis <hugo.cornelis@essensium.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Janne Grunau <j@jannau.net>, Jerry Van Baren <vanbaren@cideas.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>, Philip Oberfichtner <pro@denx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH 00/67] upl: Align with the updated spec
Message-ID: <20250102144451.GL3476@bill-the-cat>
References: <20250101221003.1944600-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0moMSGmGXsffpxVf"
Content-Disposition: inline
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 02 Jan 2025 17:27:20 +0100
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


--0moMSGmGXsffpxVf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2025 at 11:08:46AM +1300, Simon Glass wrote:

> The current UPL spec[1] has been tidied up and improved over the last
> year, since U-Boot's original UPL support was written.
>=20
> This series addresses various issues, with a goal of having U-Boot boot
> EDK2.
>=20
> There is still more work to do, but this series gets to the point (on
> QEMU) where the ACPI tables are required. Further work will be needed to
> relocate the tables out of the QEMU firmware-filesystem.
>=20
> [1] git@github.com:UniversalPayload/spec.git commit 3f1450d

Since this is on top of your fork, and not mainline, and you aren't even
noting that in your cover letter it's probably not worth the time of
everyone you sent this to, to look at.

--=20
Tom

--0moMSGmGXsffpxVf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd2plsACgkQFHw5/5Y0
tyyiFwv+L4VEcIJpv7WzHqClL3kIyYyvaa3sucYaq1A3cREG2YnTBY7UtM7rm1h+
yLJ+hn8Q/+924Al4MyCQ/dY2Uf194fxZjnPRr0v1nj1SX1gVq3bSydSWId1jIAih
vTqc84QyF7gJzcuqMMCT+tA8zg1Xno9+QYI0efLBKB+FEzosqAfM5s/1rjIuHT4b
RGHjLafB/SMVyb60/vGy+PkNoZRhzpSbdgSG4ILL1xQ9lR2WOARwv4ykYdtUmkJB
3pyd7uxiARLLfrKutqsJOEGIfxelb6fSTbcWPcvwW79k5KCNJqDJlVYe4PZuFgWt
SGws6c1JUZu5adi+7j7mRoQDfgLZSdieYDdH/n3jd1JiubC+sRnjps0SZZoGLfaL
nkrrubJerMgqhxvC4+/6RxfGsV+Trtu18kGrfKxiMz2gsb4wl+SvxGpe086dAZQz
twGKzKEa57tSqifkeWfX40KUU0FBBfptfzsmlylE88jIlcb0CkteZfA+4isekUA4
4adwHVtL
=m+d6
-----END PGP SIGNATURE-----

--0moMSGmGXsffpxVf--
