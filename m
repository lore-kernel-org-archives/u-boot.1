Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57514C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 21:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5D2F8338C;
	Fri, 23 May 2025 23:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BK8piFbB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A13E1833D3; Fri, 23 May 2025 23:25:45 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F4778334D
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 23:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72ecb4d9a10so255372a34.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 14:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748035542; x=1748640342; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MxA6yEp02XgU4F2bX7HlHPIzrHcvsTr6GzKq099Fp1Q=;
 b=BK8piFbBUZiIKpgEGxIBXJSCgXNIQUwcxZ5ZFWMMMQn4G7fL2iQw7y6LDaO4NygByh
 xHC4czvl3yTMD993OpzcfGifzrHGSlplGe65AM4k3pmg9RJh94sHldbZBrMzVofF/qZ9
 RI66sOOnyuYs5+jcw0wXs5Yjq6lscTxs8nQ3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748035542; x=1748640342;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxA6yEp02XgU4F2bX7HlHPIzrHcvsTr6GzKq099Fp1Q=;
 b=bSEHYpaUlduU34mpiLV5F4FvZgWUPlH8QAzGXGl5DYIbQ/HQzfoBAKJN92T2OguhWA
 V0w3lzOb5v3pv95hJpOw6SP46dhiVONvFiaoqYBlcJucER2SN/+Ggpir7e/3kWyQgg1c
 GqMcaZlfwvbsQTOl/Cc3oMcyFIp1fTFbfMyLAtfk0+wv+pHALdWYE4vnBybVboxLjeN3
 36n8OIJdTzh7AvqRUn+OhiJLqtab1YKANnZLQeHh9sWNoZqZopV26VnY5YYOYnwCddxO
 dVBTEGzgDK5UGbmI4r+9CofyrVWihHfcLfwl0xHP0PtUigwx7BcTG2iqjK4/EsWgBi+e
 ySPg==
X-Gm-Message-State: AOJu0YzAObZixO7xcZ6SbgF/uhgW1DEpBRHYPw3gYyd3+sr+cXvbxFeh
 FcZun+COjRtbQ54fG6uXzkoh2VNB5cHpPOCu2SoibMDeTHAUlWXC9pPZjSjzXtdUvQE=
X-Gm-Gg: ASbGnct4jhST9fRygkyb8Ey7SmNspF+ZVxNDZYAFmXeXFQUgxxNyoneksQ1xuIGS/Gd
 aDQs55zZnlFDnEctA1hFGc5YZtbU1Na9aEun+W7/JXVviF2bW9IOIOp6I4utdGbYKvYvvGlw1jf
 /22SJtDnLqdC1AIaxMlxfvXodGR8EO1ORKfgPLLY9fq3IVYynqWbaCNcpg1JoRlcqcx8S/QdQ3i
 i/pXkhsc19YeBpmWR0Sg1MBX24ocaSg5+aaq3Mp3tW2z6RwLAw1ycnaax2s9aFxZuk+rfVtxAFj
 omy7uAN6+Vydat0pB8NffyOtD0nXRNmGqHrnBJOCro9/iJkJGG/ROZDf3/7AgnDw7JSlDymagaV
 00gUBdC+7tWCe
X-Google-Smtp-Source: AGHT+IG+MHvS9IkLnQFPhU/CMA4+qvPUG21k8gqT+DXpTTopq5MQ7K5RgXIX6WGzgAa6ul7R0InwTg==
X-Received: by 2002:a05:6830:4994:b0:72a:ec6:7fc1 with SMTP id
 46e09a7af769-7355d0b7671mr764688a34.14.1748035541751; 
 Fri, 23 May 2025 14:25:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734fa986d42sm2913162a34.12.2025.05.23.14.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 14:25:40 -0700 (PDT)
Date: Fri, 23 May 2025 15:25:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 01/30] patman: Move all non-test logic into control
 module
Message-ID: <20250523212539.GX100073@bill-the-cat>
References: <20250504132356.2317305-2-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
 <CAFLszTi6LwvSoNtThF5DzKjJNFzJxB5rk5DjYi9wzsfkiwwjcg@mail.gmail.com>
 <20250523140455.GP100073@bill-the-cat>
 <CAFLszTj1v7dhvdj9vM70OP=Bb8j3FArYHS3SGcpnJO31z3Ns1g@mail.gmail.com>
 <20250523164717.GU100073@bill-the-cat>
 <CAFLszTg0CO5PqagaAZNov-N4rv6D17iUV_qnAasJ336zW=eG9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ekJIlFfPU+/DgQZ7"
Content-Disposition: inline
In-Reply-To: <CAFLszTg0CO5PqagaAZNov-N4rv6D17iUV_qnAasJ336zW=eG9w@mail.gmail.com>
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


--ekJIlFfPU+/DgQZ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 09:20:37PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 23 May 2025 at 17:47, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, May 23, 2025 at 05:32:36PM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 23 May 2025 at 15:04, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, May 23, 2025 at 08:19:30AM -0500, Simon Glass wrote:
> > > > > It is easier for tests if the top-level control logic is all in o=
ne
> > > > > module. Create a new do_patman() function to handle this. Move the
> > > > > existing code into it.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > (no changes since v1)
> > > > >
> > > > >  tools/patman/__main__.py | 49 ++--------------------------------=
--
> > > > >  tools/patman/control.py  | 54 ++++++++++++++++++++++++++++++++++=
++++--
> > > > >  2 files changed, 54 insertions(+), 49 deletions(-)
> > > > >
> > > > > Applied to sjg/master, thanks!
> > > >
> > > > Odd. I thought you had posted this against master or next, intendin=
g it
> > > > for mainline, which is why I assigned it to you in patchwork. I see=
 the
> > > > cover letter is missing what commit it's against. And instead here =
you
> > > > are once again spamming the list and with messages about your perso=
nal
> > > > tree. Why?
> > >
> > > I'm applying it to my tree and intend to send you a PR at some point,
> > > with collected tools/ patches. So I believe I need to send emails
> > > about applying things and update it in patchwork. Let's discuss this
> > > in a future call.
> >
> > I don't see what there is to discuss. Please follow the normal process
> > for mainline and stop spamming the list with notices for your personal
> > tree. You're also diverging your own tree further from mainline by doing
> > this and making it less likely (multiple people have told you they don't
> > want to review things not against mainline) any follow-up work will get
> > comments other than that it's not applicable to mainline.
>=20
> For patman, I have another series [1] I'm planning to apply to my tree to=
morrow
>=20
> Would you like me to send 'applied' emails for it to the mailing list?
> Or perhaps just for the cover letter? Would you like me to send you a
> pull request?
>=20
> Regards,
> Simon
>=20
> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=3D456256

Yes, that's another series that while I disagree with the direction
you're taking things, would rather apply to mainline than let it bitrot
in mainline. So please send a PR against next. And that would also apply
to the series this email is in reply to. As again, I had expected it for
mainline and not your downstream tree even if I think we (and our users)
would all benefit from managing the python portions differently.

--=20
Tom

--ekJIlFfPU+/DgQZ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgw584ACgkQFHw5/5Y0
tywvygv/ayATUsUSZa8OpFxMFrbwnCCdfoPp9Tk/6Fe3Cm1ZcN+p41SuBF+ES/Uz
5g4uarOKWDYXEdgzQHxfzvf4BQ0AL/Iq9MACfBmNO/Nr5ami0/PZUSxCpLnmLubH
4BVvMTiILoVOnkMhZuklIKSb4zETUMwjMY5nz/HUjsFFPX2+00kPE45JVLsrvZiH
4vGWJi9oB4mCONi9vXo3Hc1iiGBABfTtoWD8Q3PuKQXFOmgBhpXjTBb7nNxdU/3U
m25aC+7VJQxE2v2wFlfvbfdIRi4L4/0VdF/0GSCX0wkarzCv0Ag1PyRZwYfQTm8w
CeXTOaaocETKaUhmE2mCqlLrQhQbyUkPpEneftC/7Y3WuWv4cbHelOGowNVQAKnJ
w2Rh35daF6ApqjlnQkEIm1ZRsAQswYfwQcCefA+/zPevEpIK4qX4bshY3QF5PLbM
iO4U3jEujSVsk/lKYoGfWGr+Gr/nruT/IcK45SEUyPiwCGPvT3bNqH+yFRcudV8M
JptR1RUM
=w0it
-----END PGP SIGNATURE-----

--ekJIlFfPU+/DgQZ7--
