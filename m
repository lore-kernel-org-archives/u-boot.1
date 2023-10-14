Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9AFCDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:26:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FD3786F52;
	Sun, 15 Oct 2023 08:45:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qhZ+182D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58C6086BD3; Sun, 15 Oct 2023 08:42:56 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BE7986F6C
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-41819a68143so24665011cf.3
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697352104; x=1697956904; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i0PgxlVWi+UiptpmIj6Vdz5hUqkwOJ6GZykG8LjUoq8=;
 b=qhZ+182DumOmgsCX0ami/+mfBb4XFhDeioXbLGSP4SakDzmFeWHb904Hz7fmjvS90g
 XUXKfFj0WIwnD6lQqpmGTovpsOdk7LdjPX2rkFASDiXjIbL0UJweifEHvIuzz2pTS2vB
 vVyC6pZ+IpS2cVQNnRISYA5lgj6K2uXwmt5yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697352104; x=1697956904;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i0PgxlVWi+UiptpmIj6Vdz5hUqkwOJ6GZykG8LjUoq8=;
 b=kgSlJFrf6X8mu+f8Wm6BXEr5frKNPZGsVduUJ5LHL/r6sfI1Tgd3kZfqO2UneDRqLV
 pXsnfimI/7v4laE/og/6wWlMxYwaUPFHflMj3tJqsvxp1oqUUn7MahpeIX5S8ClcmvRN
 6bKHFBy0iNqEAUwnYpURRqH54fZAjR9xnVxh1y/m+Q/gwQPf4L2T2a5evYJ8awKNl8DP
 D+7NQS4c60F2cYPlrQd3hTiZ/pjil6/P7KdcH4XHAzy8fu4B3n9sRaZN4/e2ADe7ehMB
 h59Uh6EhTvzxTOzQckMFuhLc1EVm/nWa7kDjqYSutlKy5/uYllHm4Vd2hrubdkUUzxyA
 f/+A==
X-Gm-Message-State: AOJu0YzerRt1S+G5hurEHzu5F5naRm/1Q16FlCb01xtnHGktSXIe1zro
 WlQGxWaO/Tj076uZQ7bJYs9L2rfwq/kX9QSytojXLA==
X-Google-Smtp-Source: AGHT+IEDaB8v6z11M70FlW6wQPXD22cghufJ6bwq1vV40pg/obHDDbTESWeA6KCoB0tAuT1Bw3xrog==
X-Received: by 2002:ad4:4eac:0:b0:66d:1a62:4109 with SMTP id
 ed12-20020ad44eac000000b0066d1a624109mr10301513qvb.1.1697318552884; 
 Sat, 14 Oct 2023 14:22:32 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 y2-20020a0cec02000000b0065b29403540sm1977352qvo.127.2023.10.14.14.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 14:22:31 -0700 (PDT)
Date: Sat, 14 Oct 2023 17:22:29 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH v2 16/29] net: bootp: Move port numbers to header
Message-ID: <20231014212229.GB3119521@bill-the-cat>
References: <20231014204805.439009-1-seanga2@gmail.com>
 <20231014204805.439009-17-seanga2@gmail.com>
 <70B2C086-30BC-4CAC-B4DC-C1B7B32BB95C@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nIZBizC2iclUH8pY"
Content-Disposition: inline
In-Reply-To: <70B2C086-30BC-4CAC-B4DC-C1B7B32BB95C@gmx.de>
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


--nIZBizC2iclUH8pY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 14, 2023 at 11:20:31PM +0200, Heinrich Schuchardt wrote:
>=20
>=20
> Am 14. Oktober 2023 22:47:52 MESZ schrieb Sean Anderson <seanga2@gmail.co=
m>:
> >These defines are useful when testing bootp.
> >
> >Signed-off-by: Sean Anderson <seanga2@gmail.com>
> >Reviewed-by: Simon Glass <sjg@chromium.org>
> >Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >---
> >
> >(no changes since v1)
> >
> > net/bootp.c | 3 ---
> > net/bootp.h | 3 +++
> > 2 files changed, 3 insertions(+), 3 deletions(-)
> >
> >diff --git a/net/bootp.c b/net/bootp.c
> >index 8b1a4ae2ef8..2053cce88c6 100644
> >--- a/net/bootp.c
> >+++ b/net/bootp.c
> >@@ -41,9 +41,6 @@
> >  */
> > #define TIMEOUT_MS	((3 + (CONFIG_NET_RETRY_COUNT * 5)) * 1000)
> >=20
> >-#define PORT_BOOTPS	67		/* BOOTP server UDP port */
> >-#define PORT_BOOTPC	68		/* BOOTP client UDP port */
> >-
> > #ifndef CFG_DHCP_MIN_EXT_LEN		/* minimal length of extension list */
> > #define CFG_DHCP_MIN_EXT_LEN 64
> > #endif
> >diff --git a/net/bootp.h b/net/bootp.h
> >index 567340ec5d4..4e32b19d424 100644
> >--- a/net/bootp.h
> >+++ b/net/bootp.h
> >@@ -15,6 +15,9 @@
> >=20
> > /**********************************************************************/
> >=20
> >+#define PORT_BOOTPS	67		/* BOOTP server UDP port */
>=20
> Reading code I would have a hard time to immediately see what this consta=
nt name stands for.
>=20
> Shouldn't this be renamed BOOTP_SERVER_PORT to create readable code?

We're just moving the code around for now, and this should get replaced
by lwip in time.

--=20
Tom

--nIZBizC2iclUH8pY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUrBpUACgkQFHw5/5Y0
tyxn4gwApq4MX3HafxEcSv6I4zV8uzz0IWM1bDyn4tJXOUZergmUHq2YS00equ7a
spqQxXmuCRTcHJBPjQ6WG74O0wZjNy9JY/Q4K7pE1B2kNkg/QM3JfNNCCDWmtkxZ
BTKicGOhdpg/6cUT4rfIhi2vqz6EOpBREvoYR6mCkXez8ZjqTqHTSd08rOMBMlvc
I3al+70vYkIjTn/FuQChZ6swINRhtyXEczc4jvIzH12fUnYzIg1QR9BEdb4xqEXJ
c3ZJKJU67uLaaneM1Ke3g6X633jWhGX+K2sHInINjNYLjScL8tXtJmX72taFctl/
1koCqrhoWvCYZNGM4XciO1fPkZKRHnqMyJBf8VZ/50uKp0KFG2lm4BUqDF6qnvYQ
0NcLAczPDLYizSxati60g9ui0lTiYDBd9SBhb8U2oMQL2ayqdqTl9hwVeWKoTclP
Pq+t9dAPIQUjW4l1M1WmD4X4BEl3rcRUSKnJok5l5GIj+S3bS6QSeOuPrJDDTuTx
WuAaKzS6
=eGo5
-----END PGP SIGNATURE-----

--nIZBizC2iclUH8pY--
