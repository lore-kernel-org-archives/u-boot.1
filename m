Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB37C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 14:07:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 954C186FC9;
	Fri, 17 Nov 2023 15:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Arn1EFgl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0B6987083; Fri, 17 Nov 2023 15:07:27 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7DE986FA7
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 15:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-778711ee748so123323885a.2
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 06:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700230035; x=1700834835; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cqwiS/Aj6Y5uefvjqWW87/5GHOBtMTDq0PXna+TzxIE=;
 b=Arn1EFgl0CaQj3KInf7hM3/nZi+EqYVI8yDnPu/7NErnA07zF1lwl9nwRXZWixA7i6
 7Uy7aM2dW6Tjno0VsmkVxkGA6gZxqujg4TSvmNsTs1Jnq5ET8Vshn/9MW1EJDMCshYkM
 IuHKxOx1CmY4m8KpFEwDW11vFI3ad1OVr5flU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700230035; x=1700834835;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqwiS/Aj6Y5uefvjqWW87/5GHOBtMTDq0PXna+TzxIE=;
 b=lBmzYySLt5fvf7+BGJedBA+eQqZ1u5Sh5DL9IrX6a57LkJVi0NtMLnDNrUI6jNW3kf
 VhTPpmOtCIIH0YGwUYBNQaJADxYdRNUKpUNbS5pHKwOAFlYZeW7mB4BkxV99aog/6JNL
 19pj7q8lPS3Rk8p9wpWbHKM1D7E4o5hSJ7NRHIkZOUIJKPHVLBCLWmlJk2cX97WwT96s
 moCpKLQzhQVgLrKPRZqyeL01KhXNV3p4Iulx4s6T7E/MoT+E/StEVESEYnqq/sz3x++u
 0WvxWOQAHSdRPe07+h8+pIP1FpBumWlSC1zmnb4X+bkcSGLmLlzMKc3hMhXQRTfO3VBx
 vcgg==
X-Gm-Message-State: AOJu0YwloLvh+uYGCCBXczDBiMS+rneNZlR5eYPH74EPQMkgJ3sXltT7
 /lyZQ7RiIXz/n+jWx9xQg4KzpQ==
X-Google-Smtp-Source: AGHT+IGaZgCsxwTsxTSSy+aoN1HsebOSywKVueP8c/M+xFNGCGk4ok0jiDDPouYbdSca5n8NLfcBJA==
X-Received: by 2002:a05:620a:133a:b0:775:cf5e:a66d with SMTP id
 p26-20020a05620a133a00b00775cf5ea66dmr11077204qkj.24.1700230035565; 
 Fri, 17 Nov 2023 06:07:15 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 vv24-20020a05620a563800b0076cda7eab11sm606395qkn.133.2023.11.17.06.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 06:07:15 -0800 (PST)
Date: Fri, 17 Nov 2023 09:07:13 -0500
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: nm@ti.com, "Kumar, Udit" <u-kumar1@ti.com>, Keerthy <j-keerthy@ti.com>,
 u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH RFC 10/10] board: ti: j721e: Enable ESM initialization
 for J7200
Message-ID: <20231117140713.GD170968@bill-the-cat>
References: <20231003081038.24299-1-j-keerthy@ti.com>
 <20231003081038.24299-11-j-keerthy@ti.com>
 <838b07a0-8490-c05b-b08f-3ab6d3e1737a@ti.com>
 <20231003151033.GD8465@bill-the-cat>
 <726d44fe-bd81-4409-a9b2-776eea34fd67@ti.com>
 <20231116184052.GE170968@bill-the-cat>
 <4f440a06-892b-4098-9565-6b21778bb5bb@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WrgB1c8gDq1G5UZk"
Content-Disposition: inline
In-Reply-To: <4f440a06-892b-4098-9565-6b21778bb5bb@ti.com>
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


--WrgB1c8gDq1G5UZk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 02:00:43PM +0530, Neha Malcom Francis wrote:
> Hi Tom
>=20
> On 17/11/23 00:10, Tom Rini wrote:
> > On Thu, Nov 16, 2023 at 11:43:50AM +0530, Neha Malcom Francis wrote:
> > > Hi Tom,
> > >=20
> > > Trying to bring back this series here.
> > >=20
> > > On 03/10/23 20:40, Tom Rini wrote:
> > > > On Tue, Oct 03, 2023 at 07:57:04PM +0530, Kumar, Udit wrote:
> > > > >=20
> > > > > On 10/3/2023 1:40 PM, Keerthy wrote:
> > > > > > Enable ESM initialization for J7200
> > > > > >=20
> > > > > > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > > > > > ---
> > > > > >     board/ti/j721e/evm.c | 6 ++++--
> > > > > >     1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > >=20
> > > > > > diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
> > > > > > index 42fa94b7a5..070b28326f 100644
> > > > > > --- a/board/ti/j721e/evm.c
> > > > > > +++ b/board/ti/j721e/evm.c
> > > > > > @@ -543,7 +543,8 @@ void spl_board_init(void)
> > > > > >     	}
> > > > > >     #ifdef CONFIG_ESM_K3
> > > > > > -	if (board_ti_k3_is("J721EX-PM2-SOM")) {
> > > > > > +	if ((board_ti_k3_is("J721EX-PM2-SOM")) ||
> > > > > > +	    IS_ENABLED(CONFIG_TARGET_J7200_R5_EVM)) {
> > > > >=20
> > > > >=20
> > > > > Could we align on one kind of check,=A0 For J721E check is done a=
gainst
> > > > > board-id, whereas for J7200 checking
> > > >=20
> > > > We should look at figuring out how to split this file in two.  One =
for
> > > > "generic J721E systems" and one for "TI EVMs", as I've mentioned in
> > > > other threads, so that it's easier for custom platforms to drop code
> > > > they don' require.
> > > >=20
> > >=20
> > > Yes that does make sense. Would it be okay if we solve that problem
> > > separately in a different patch series? We can move along with this c=
urrent
> > > series for now (after making the required change in CONFIG/board-id f=
or v2)
> > > since ESM support is important for these platforms.
> >=20
> > Well, I think part of the answer to your question is (and this is a more
> > general TI one too), what outstanding changes need to come in now to
> > make existing platforms functional for v2024.01 ? My first thought is
> > that this series would be taken to -next, if I took it now, which means
> > there's time before it would be in master, and so if it really makes the
> > re-org later easier, we could take it, but if not, can we re-org then do
> > this? But if we need this to deal with regressions, OK, yes, we can take
> > it like this now.
> >=20
>=20
> Maybe focusing on the re-org after having in the changes would help give
> more perspective on how we can split? Not sure just a thought... in that
> case I prefer taking this in and having a working error signaling module =
in
> rather than delaying it if that's okay.

OK, please rebase on top of whatever other series are needed (and note
so in the cover letter) and mark it as non-RFC, thanks.

--=20
Tom

--WrgB1c8gDq1G5UZk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXc5EACgkQFHw5/5Y0
tywWmAv+IMhrLD0S0YAxyZtoWTy4BsEVZxWWel56oiXed9g2SuSZKecBolQTt+4V
YSaOgOcTBSZidYdIArlrV+PNItvhukkjnaedke6uteuiZlsZ62VSra00Hp1usl/6
v2HBbOKbjtyP/5XMItYN5OGOM+Wr0Zsynn+K5pfudWthalLf+2fMbCQr1YoMnUl6
/qsxJadEnlfSZyqyOJj9dR8tkHk8IHLsmIlpVqD69U94uFknLTv203kWQqrGiNOe
pH1vuhGTKTbTc/+i7uLR14iZqlKWynS/SXWqw6pjYkkKO+xMd/D8fQc0OQupeV/t
Xbp6UpUCCBY3y5ytvsA2U9hwZ2EzM+Fs010CoyGdIoFd58wF/dtjwivk+1H0DpvT
Ikb6xuWGDzUJZEtSKo0THgNrTy9hDB6oa5bUVEDKIgT7ABo4kiBjjjCsPS/YpP4w
EcpGgh9zHdbN7dNp8/jDkPfRQsTvkErf7lwJrUfDLO32EILa1QiApXbGmWBBsqvp
kRRIzeP/
=fr7w
-----END PGP SIGNATURE-----

--WrgB1c8gDq1G5UZk--
