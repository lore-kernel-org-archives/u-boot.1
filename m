Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE78E77198
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 14:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4426801A0;
	Fri,  3 Jan 2025 15:27:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l+75nwxk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAA3E80275; Fri,  3 Jan 2025 15:27:01 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D39980196
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 15:26:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-467b74a1754so5175711cf.1
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 06:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735914418; x=1736519218; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ml5S0YR59DF1IB0lzqaej5gUi9nUNjYviTHht1sZdX4=;
 b=l+75nwxkEM4jRDiG+TsNJasjpYIbq2lib1ee5ONRTohWXmSP4AN3ybOkHyppZn8Cq8
 yxjMcFUCrYabayRSFREmIz8CyXLi/6UIHhHoxEWWi8l+eg3NwzTeKlFmIUvPMv4CX8p3
 tP/v9IED0ltGI25fA9NHdcDJUPX64udS50LPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735914418; x=1736519218;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ml5S0YR59DF1IB0lzqaej5gUi9nUNjYviTHht1sZdX4=;
 b=tFW64oshVdBLIlV4SolnpCGQeT2k6g3zaDjHwCp2h2fF92e44Cw1Ct9T9eImc8v5EH
 yV74BGrMmLrrgz6xbANJDNoNAhztiiFtEhxfyTEirF1q5jd540zvJB4eEW/wS6WEnc29
 cOCt5Y2hpAFUOCDr+Q9+evLeZ4owbcqvZpK8nIVlmqAthx9VpnU/VihFzsZA+AR58h/w
 MLU+ItieCawoNeAmHTl1jDLrDCGfFLqiWweAR8zrILcjeZO/HlccrjVyMd5fgyyqqcSY
 par7gi6lQ/VKgxsnyyqqkKE+uduu0jvWi/A4zXJ5kfym6BsI45iQvWbJa0qIoa8GwHE1
 wGig==
X-Gm-Message-State: AOJu0Yzvk+v9nCB1KD9Bg6swUNz9gMsQJihWut+B4jTAXNdmElKgjJOq
 suY/D81jieqD+VoAIiU016lPz0xC9L9bXRiA578+uPqPv4McjukS7bSbz9DjYbo=
X-Gm-Gg: ASbGncupN8H8XbwW7UnYhxn1ZqF6SxKo0EhtkJ1w1tViy4JzcDh1Gy3pp4GIMIayQWJ
 44TV/w5sDCoFC0E3llxLk409lV/jrAwzlnxgegQNjYUSETJQ/vFP7gZFpHhxUfIbHYosiXAm1tQ
 jyExGmPpcIVkJTwylb1p44w8k2InvTLM9h2wH4gCGBBg0aRujWnRqS/pA85Lxh7sYIHQg5hMepO
 HNZ2Tapoz3cnk7fcmj9YYb0nVL+FTcqLnE3QCVl+9DxlYn9ZByR9aRvcA==
X-Google-Smtp-Source: AGHT+IEJtQpoqFVg8Kz4n1JQBts/T2hhDpKlOZ03fdai5z/+yOpjKEuK+aMc1a26Wh5cCuE1LjlQ6w==
X-Received: by 2002:a05:622a:1314:b0:467:8734:9944 with SMTP id
 d75a77b69052e-46a4a8baedemr704900981cf.5.1735914417778; 
 Fri, 03 Jan 2025 06:26:57 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3eb1777esm146037301cf.67.2025.01.03.06.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2025 06:26:57 -0800 (PST)
Date: Fri, 3 Jan 2025 08:26:51 -0600
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
Message-ID: <20250103142651.GU3476@bill-the-cat>
References: <20250101221003.1944600-1-sjg@chromium.org>
 <20250102144451.GL3476@bill-the-cat>
 <CAFLszTiSeBykLOSPGEFG6MV74KmC_e1F0PTkAfkR1DKxYstmeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MdKp46DkU9eJrUOo"
Content-Disposition: inline
In-Reply-To: <CAFLszTiSeBykLOSPGEFG6MV74KmC_e1F0PTkAfkR1DKxYstmeg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Fri, 03 Jan 2025 15:27:07 +0100
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


--MdKp46DkU9eJrUOo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 03, 2025 at 12:45:36PM +1300, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 3 Jan 2025 at 03:44, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jan 02, 2025 at 11:08:46AM +1300, Simon Glass wrote:
> >
> > > The current UPL spec[1] has been tidied up and improved over the last
> > > year, since U-Boot's original UPL support was written.
> > >
> > > This series addresses various issues, with a goal of having U-Boot bo=
ot
> > > EDK2.
> > >
> > > There is still more work to do, but this series gets to the point (on
> > > QEMU) where the ACPI tables are required. Further work will be needed=
 to
> > > relocate the tables out of the QEMU firmware-filesystem.
> > >
> > > [1] git@github.com:UniversalPayload/spec.git commit 3f1450d
> >
> > Since this is on top of your fork, and not mainline, and you aren't even
> > noting that in your cover letter it's probably not worth the time of
> > everyone you sent this to, to look at.
>=20
> It applies to -next except for the QEMU script which you rejected. I
> can't do anything about that. So I think you may have the
> wrong end of the stick here.
>=20
> The only thing I can think of is that the UPL series depends on
> Raymond's bloblist patch [1]. But I was assuming that would be applied
> at some point and I didn't want to resend someone else's patch. I
> don't have it in the sjg tree either yet, as I was hoping he would
> write a test. In fact I would very-much like people to write tests
> (and docs if needed) without needing to be asked.
>=20
> Regards,
> Simon
>=20
> [1] https://lore.kernel.org/u-boot/CAFLszTjSGqmk8yYYbXFEaFZWFhF8uhj_rNxZz=
7ship1-Fb8p3Q@mail.gmail.com/

A 60 part series that includes changes to something that was rejected,
and depends on a series from someone else that was changes requested,
and is again, 60+ patches, is not at all helpful. Please stop doing
this.

--=20
Tom

--MdKp46DkU9eJrUOo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd386cACgkQFHw5/5Y0
tyxM/gwAjwV7fE9mq/ze2WK9FzIf7d0d2dIETbbXrDc6imtY44cKmWPUR4FfliEj
Chp3Gob0+FZ1WjZ+IUlzyEceE+M1ltWYonBdH7j0GEsOKmvCVLLy+x2NwQx6WtPa
HnuK9D3hpI8dEF27TjIMusX0PjDKelgXzHD1m9rg4JxBPcY2KOWOER1q/1YSp5iJ
RQal8Aanx1Ff6iUeqoBtAXOnY7hXK5Omb/CzxY/Cr54EQbA19VENVdFm0ZsMZdCL
Qau2RQTaHbwQgiVEVEfYSHTfplBlobURgBE/qHzOhBMnXo8i+1URCFdfudoZY7pX
kxw7mZsKuPyZ8Dd40eAfh++4G+H2qwW/HKIWmDaMJOQbEbfrp7IDZrc5ZPJ5kRH0
EZzcWK1e+GL9EnkJYR9EZEaFbkDToGpzjJiEye95iAvjENrvZYQuA2RqlK46ibgN
LGNDlDf9QUa3S2hLP8nm2Jdi9qM951cP0xmcKMWn9z3Xq0S4H5rQ/7OIGnp2axjy
nzM1R5WK
=IoNf
-----END PGP SIGNATURE-----

--MdKp46DkU9eJrUOo--
