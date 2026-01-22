Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7337FD3EE6B
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 14:22:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F7208397D;
	Thu, 22 Jan 2026 15:22:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KcOkrJsF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C670F839DF; Thu, 22 Jan 2026 15:22:02 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 997AB8341A
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 15:22:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-45c7a71ba20so341709b6e.2
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 06:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769091719; x=1769696519; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Xi7NAgEV4JRA06eeAhcAYyY9/f7CbFLgeVLuH4ehF+0=;
 b=KcOkrJsFkoBtFxViYDQzTF1STSxLkFEBSSj0NQ8Y4QRIW9j6/3BXxETr2HalaHt0ms
 vJ6645IQY2dWeq/f/tMcxgM8Fs2fTSrTyjEcoKyk52kCNqf4mIJlw2qFZrpYJvc7eIdo
 Osz+zq+t5jJVmKIwAXQWXy04cLBtf9JpziJiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769091719; x=1769696519;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xi7NAgEV4JRA06eeAhcAYyY9/f7CbFLgeVLuH4ehF+0=;
 b=P9r8FYZMFY/ncHWH6XbxNBW2+rcoDo2WRbJYUrVYaf02LSeaQGKwEftThStRgFz9JM
 JJ8Tk79/snVoijEdqwNK0OG0gpaVY5msiGzwl8+mIWBUP8yP3nT77Fw+q3Gkcj0b/uvx
 4bOGd2MOO8SxmdbGbANkEFc0rRzpnWoTzhkxC1juZqLE2FXKoywhxD9r5mabucXeZoPb
 t7Fo5/6QsDsQ3zUdMr78OFnxa04R628QgkXKt3mntxRua4xCgsl8sxX84Qmvb8XRRcRw
 KPhSH3flM6QIRy/pb6PYuHhjwPvImVTwmMlBHM5rFNAt6lkuOSBzSKzDxRSHSuVN7RRa
 RlTw==
X-Gm-Message-State: AOJu0Ywl3e1aX1YGLxhwTdJLUKZ+6T7nFTkc7l/OtDlr2BsH0LAxc4kz
 A8akFbySHPScLYC3B/4AtQLZTdBagjhrNmUst55PsoJB1CHJOQQe+VZPW3FdJok5q2U=
X-Gm-Gg: AZuq6aJttO7ceEeF1AbkJE2o1llVxm0jYA6GqKRDH/BYBT0DA3EKZ8KwjlBemL7wRGF
 QBEg8rQmtMLRCHD2IQ9Q80S14Z7HttccTqGZIRGN0P4gs9nS0MXuDbtH8o/ryf5MXLbMZhrvdaf
 4VAM6mBQH5jRRrQSE12kK61sm6KdgUMcRzLoTYL1I852tnqjaLEP8tjn/YvESHX+HDBPr3mAOYn
 HwbK+f7iwQDQTs8x9FpzdDakwT3iGJSYEsABTQaXKmd2YMB8nA31wExQjRrBbK5kqHox1Xd0k/Q
 YqiQ2XSb5XpKiCKn1VfifGFiDs/CBZivdc8QQC1Dd+tDieIwL5oYHcNbGIdYFsbcg4VR3h06Oi9
 YPYNpt4brGwFcBn+eXcAtIlLtxA1hgTwnA17hgWExyluYB1b762YUDb2FL8rB5Eo9DsCpHOGxvS
 NKzjvCVXyBPDCJDlscyvk/fk8SC5Kk6qqNpSml9tsu32f2b0lexgc2QSHgAsMOxM2oVyuIRx+x1
 fN4dQ2Vfnny8o3ph40LixemhbpaZGz2K0FzsZE=
X-Received: by 2002:a05:6820:1ca8:b0:662:c029:6824 with SMTP id
 006d021491bc7-662c0296967mr1806555eaf.51.1769091719142; 
 Thu, 22 Jan 2026 06:21:59 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9e03dff2sm10483210b6e.17.2026.01.22.06.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 06:21:58 -0800 (PST)
Date: Thu, 22 Jan 2026 08:21:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>
Subject: Re: [PATCH 01/10] Makefile: Have binary_size_check report only first
 match of _image_binary_end
Message-ID: <20260122142156.GW3416603@bill-the-cat>
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-2-trini@konsulko.com>
 <133ec847-0d52-413d-9d19-e62fe5987822@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5f5LnsZSA+2zkZKP"
Content-Disposition: inline
In-Reply-To: <133ec847-0d52-413d-9d19-e62fe5987822@mailbox.org>
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


--5f5LnsZSA+2zkZKP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 10:07:56AM +0100, Marek Vasut wrote:
> On 1/15/26 11:19 PM, Tom Rini wrote:
> > If we have ASSERT macros that validate the position of
> > _image_binary_end, our awk expression will report a string that causes
> > the rest of our check to fail with garbage values. Have it exit after
> > the first match to fix this.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> >   Makefile | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/Makefile b/Makefile
> > index 50737f938503..37cebd4f8edd 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1583,7 +1583,7 @@ binary_size_check: u-boot-nodtb.bin FORCE
> >   	map_size=3D$(shell cat u-boot.map | \
> >   		awk ' \
> >   			/_image_copy_start/ { start =3D $$1 } \
> > -			/_image_binary_end/ { end =3D $$1 } \
> > +			/_image_binary_end/ { end =3D $$1;exit } \
> Can this same check also confirm that _image_binary_end or __bss_end is a=
t 8
> byte aligned offset ? That would allow us to trap all the built-in DT
> alignment errors.

We should have that now via the linker scripts. Also note that this call
here isn't universal.

--=20
Tom

--5f5LnsZSA+2zkZKP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXIygAAKCRAr4qD1Cr/k
CgnjAQCZWlKBsklGq5vjpwL8Ip6vZE/sLCW/zoRrQPMvW6ouBgD/TF7VR3eodopr
WU838wtgqeJJRnfmKHUDzmcGrBJt4wg=
=TEiL
-----END PGP SIGNATURE-----

--5f5LnsZSA+2zkZKP--
