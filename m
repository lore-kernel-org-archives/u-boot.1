Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06CBFD8FD6
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 16:31:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5074383F4D;
	Thu, 26 Feb 2026 17:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pI+5d4cg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1188783F36; Thu, 26 Feb 2026 17:31:28 +0100 (CET)
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFD2883F60
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 17:31:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc43.google.com with SMTP id
 006d021491bc7-6775a46c6dfso428118eaf.2
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 08:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772123480; x=1772728280; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iE/2V1ohfPYoTF2/NdgUG5Nd+kkGo9rC4JRzts+2JwY=;
 b=pI+5d4cg7bu2FyjvVF0JEOHK8De3I5mbNh1DEGF5BtSdjILwpQ4jH5bB/abYBJgJ29
 X3J/OLTIZXxO7LfTAs8yaf4eQiyO4nIZaGB+97HJPJgZbjGx6sHnJlU2e5hDHo/4bERn
 yRAd506cwe76Ix+nLbmUsH4/Rd8SNwWIyrSYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772123480; x=1772728280;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iE/2V1ohfPYoTF2/NdgUG5Nd+kkGo9rC4JRzts+2JwY=;
 b=bbIDVkgLzpGcbWtADwN4qACkqiMh8vcyqNEJMwXG6jUwKo3QqKLmqizVERoJrJ30F4
 ja/a9u2xhakKk16cc1uh2kjsJbRiy94uKBoW/R4StEhHVJLbe3WcdPNeQNwaE2yptfsN
 03QB45lKAue4zVJGB3HVzNvd4/FuoXx0QKtVCbpOd/qEhT9Y7vIuQzNjSrMFUvLsMX1f
 A+cpBrcyFpMEDyUsTOnLOmDUBRzOKLShStJDD2wNVnL/jFFVD0vQVBIMyCbUFwxHiZUk
 Wp+uE/XB3goyfEO/tFDj3Fr30JKrt3xHMAluNyGiGMb3wEWLrWxUeqEpcSQiVCRtD1ts
 EjHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnlPRvTQm6BIgFvKqu9ud2wbj/0OCXoB1pMcuhtSdKlM97rtFNRmNz//64iKQ5RvLUidKyK3U=@lists.denx.de
X-Gm-Message-State: AOJu0YzxY3uhHFeo4C+9WI7BseMYTytV7iapXOV9Qy2HKkA3exVE3rh6
 4jQVbG6C7lmVxe/1tkRUoDA/4ZYBsufRB4C5kyWHwdEqgS2EKaBrUE4zHozVwKyjTrM=
X-Gm-Gg: ATEYQzxz4AIfFMsYUvEXayJeuImLuu0SuiWua1JNg9E3mhBeRd2JDJzU5Kn4UMurrrf
 1e5xCGkfErA8SSPsrY65497QaYucgJ5P81STK6pT9YOUGL5ayzbD9CnzgkZMgCVWlKpP9OHAe0E
 ItE71WxW5SEZVaZNIDbLyf4rfr1ypWPVPnDwuHxhckjGq6deFch93+51u/7Nboub2bEBRR/3941
 REzObky8iDPdxiEzJ0mugcn+ZYKU64hZwhB3rNVqPGRC3kCDoM6pzEUceToZptM5bwbYGRkQiU+
 VjsVrMta34lLcbFemJ169dnz+lSQElnkp4jNRuDRnyMtW2yzAuxl2WCzCvB9/rX0+kU5gcyQc7F
 nOnEWElAIacb/wOblJcti1ZyAGYqb1QHqx5s/eyYdi2GN/YwtYs2zWufo1KIFzj9SXWhVFOKzUN
 cyXQqzpR7gzoTGwrmRIcpOJT3IZ7TEiEGrSTzF6aUwMFZfdQVoUUjzcR5o8gQ8qaVi8mg/eZW6x
 eWtDEaWx2oz+bN05ByYQ0n3CfYGdYq8CjUKcpiwMK115aF1g1o=
X-Received: by 2002:a05:6820:4cca:b0:65f:5b63:2bd with SMTP id
 006d021491bc7-679ef80b59dmr2156835eaf.16.1772123480465; 
 Thu, 26 Feb 2026 08:31:20 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679f2bcbf22sm1773728eaf.2.2026.02.26.08.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 08:31:19 -0800 (PST)
Date: Thu, 26 Feb 2026 10:31:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 stefan.eichenberger@toradex.com, s-k6@ti.com, w.egorov@phytec.de,
 n-francis@ti.com, emanuele.ghidoli@toradex.com,
 francesco.dolcini@toradex.com, u-boot@lists.denx.de
Subject: Re: [PATCH v1] common/memsize.c: Fix get_ram_size() original data
 restore
Message-ID: <20260226163117.GJ1593142@bill-the-cat>
References: <20250314100734.23777-1-eichest@gmail.com>
 <20260226070502.GA6701@francesco-nb>
 <20260226142345.GB1593142@bill-the-cat>
 <20260226160901.GA29510@francesco-nb>
 <aaB1DifzODCVv4SU@eichest-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wB8w8AB3yotKDVJg"
Content-Disposition: inline
In-Reply-To: <aaB1DifzODCVv4SU@eichest-laptop>
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


--wB8w8AB3yotKDVJg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 05:30:06PM +0100, Stefan Eichenberger wrote:
> Hi Francesco and Tom,
>=20
> On Thu, Feb 26, 2026 at 05:11:49PM +0100, Francesco Dolcini wrote:
> > +Emanuele
> >=20
> > Hello Tom,
> >=20
> > On Thu, Feb 26, 2026 at 08:23:45AM -0600, Tom Rini wrote:
> > > On Thu, Feb 26, 2026 at 08:05:02AM +0100, Francesco Dolcini wrote:
> > > > Hello Tom,
> > > >=20
> > > > On Fri, Mar 14, 2025 at 11:06:49AM +0100, Stefan Eichenberger wrote:
> > > > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > > >=20
> > > > > The get_ram_size() function fails to restore the original RAM dat=
a when
> > > > > the data cache is enabled. This issue was observed on an AM625 R5=
 SPL
> > > > > with 512MB of RAM and is a regression that became visible with
> > > > > commit bc07851897bd ("board: ti: Pull redundant DDR functions to =
a common
> > > > > location and Fixup DDR size when ECC is enabled").
> > > > >=20
> > > > > Observed boot failure messages:
> > > > >   Warning: Did not detect image signing certificate. Skipping aut=
hentication to prevent boot failure. This will fail on Security Enforcing(H=
S-SE) devices
> > > > >   Authentication passed
> > > > >   Starting ATF on ARM64 core...
> > > > >=20
> > > > > The system then hangs. This indicates that without a data cache f=
lush,
> > > > > data in the cache is not coherent with RAM, preventing the system=
 from
> > > > > booting. This was verified by printing the content of this addres=
s when
> > > > > the issue occurs.
> > > > >=20
> > > > > Add a data cache flush after each restore operation to resolve th=
is
> > > > > issue.
> > > > >=20
> > > > > Fixes: bc07851897bd ("board: ti: Pull redundant DDR functions to =
a common location and Fixup DDR size when ECC is enabled")
> > > > > Fixes: 1c64b98c1ec4 ("common/memsize.c: Fix get_ram_size() when c=
ache is enabled")
> > > > > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.c=
om>
> > > >=20
> > > > Tom, can we merge this?
> > > > This is the last bit to solve the regression reported here,
> > > > https://lore.kernel.org/all/20260224152405.GD340942@francesco-nb/
> > >=20
> > > I wasn't happy with this at the time, and Stefan's last email in the
> > > thread left me with the impression more investigation was needed and
> > > likely something else was the root cause.
> >=20
> > I believe that this patch is needed.
> >=20
> > On AM62 what is happening is the following.
> >=20
> > We have a cortex-R5 that is the first core booting (there is also a
> > cortex-m4, but it's not relevant for this discussion).
> >=20
> > It runs from internal memory and it configures the DDR ram
> >=20
> > We load to DDR memory various pieces of firmware (TFA, U-Boot for the
> > cortex A53, ...)
> >=20
> > We do execute get_ram_size(), that read/write the memory, and it is
> > supposed to restore it back the original content
> >=20
> > However when we have the cache enabled, we might miss to write back the
> > original memory content, where the other pieces of firmware are.
> >=20
> > And after that we start the cortex A53, running in DDR, and there the
> > memory content might not be correct, because there is no cache coherency
> > between the cortex-A and the cortex-R. And because of that we have
> > crashes.
> >=20
> > Stefan: any comment here? Can you help?
>=20
> I think what you wrote summarises the issue well. If I recall correctly,
> I "fixed" the issue last time by simply calling get_ram_size() once
> before enabling the cache. This was in commit 4164289db882e. The SPL
> then informs U-Boot of the memory size via fdt fixup. However, something
> has probably changed now (possibly in the R5 SPL), meaning the cache is
> enabled earlier, so the cache is enabled again when get_ram_size() is
> called.
>=20
> For the AMP use case, either "get_ram_size" should not be called once
> the cache is enabled, or a similar patch to the one I proposed is
> required.

I would lean towards the former if at all possible.

--=20
Tom

--wB8w8AB3yotKDVJg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaB1VQAKCRAr4qD1Cr/k
CnjcAQDe55B/+0cOAohcVxNTpuv/MZPycszvPU53ztW4UuNMFwD+Op2K1OnQ1usM
JTW8hkLx3aIutTOLbK1QR7Q7606L9w4=
=SVqu
-----END PGP SIGNATURE-----

--wB8w8AB3yotKDVJg--
