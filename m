Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B627C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:33:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C14F86FFD;
	Mon,  6 Nov 2023 17:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rM/EnIuc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCC7B87069; Mon,  6 Nov 2023 17:32:48 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C230A870A4
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:32:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-41e1974783cso29738031cf.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 08:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699288364; x=1699893164; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ydhaEQFohny1Bgsvz2wE8VVquDhy58ZbYgQG/GuWLW8=;
 b=rM/EnIuciu9RA8R9bR7qFm8upjVJmPUwTy7iupU2/d65VyN+bYAqzmCv/eFMW6evMT
 42LbyO1A79HixYqPQlc1Qkqvb1paTgLYylTph045uInm+4CPjwTruJjROAqmWW6MZZKq
 NmiaHFt+gmIVnDUJuq2AAgRXYij0lD5+x+ycM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288364; x=1699893164;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ydhaEQFohny1Bgsvz2wE8VVquDhy58ZbYgQG/GuWLW8=;
 b=pl2I7TWTp5xXJJIbdfgPDp7oqakfE/rIE9qziawPFv2FKA7MUln2Da2jMLP29jDxsn
 MV9EDRCYBziCoRHJEPxewAj2o0bJjk2j0N63WoezA6yfK4TZ9ScO2DTpu4zHnMZ3TEPz
 mW579fjfkBx3O3OYQsVirmafno70EcjJHxwPXVOYMfaPJO7k9QK4+0ABhC+2/zaICqS8
 a7Vsr4z36lh2MZGQUU0KkeGQGTyyXRqCExvM6y8cmnEkYAdcAyNfmJlHi/dh2TPQPLSt
 LRJdWZHH++6Vbafa8A4KzS4H5kZFbTFtCBD12KmrDnO9Nsy8yXvXV+sHsr4t7Z50c/T6
 XG3w==
X-Gm-Message-State: AOJu0YzK28fcqIvD81sRvZk3PRbZIyOLl+570m8X/t6ibkkWoR2pf1lE
 NKNuydWCtgNVR/lOKqeaoRIQecVpqz2/AeEeP5jVIA==
X-Google-Smtp-Source: AGHT+IHovXecf7s31YVJ2GIaFZQvps/mQO/SRg/4hl0hSiJsLDbZY2aMBPabUir3PkKa+KweTliRXA==
X-Received: by 2002:ac8:5c48:0:b0:418:597:b71d with SMTP id
 j8-20020ac85c48000000b004180597b71dmr38087044qtj.4.1699288364462; 
 Mon, 06 Nov 2023 08:32:44 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 a22-20020ac84d96000000b0041b12d5fd91sm3550113qtw.55.2023.11.06.08.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 08:32:44 -0800 (PST)
Date: Mon, 6 Nov 2023 11:32:42 -0500
From: Tom Rini <trini@konsulko.com>
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com
Subject: Re: [PATCH] net: Get pxe config file from dhcp option 209
Message-ID: <20231106163242.GM496310@bill-the-cat>
References: <20230725232030.6531-1-seanedmond@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ODkrh+uyG4DstjvP"
Content-Disposition: inline
In-Reply-To: <20230725232030.6531-1-seanedmond@linux.microsoft.com>
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


--ODkrh+uyG4DstjvP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 04:20:30PM -0700, seanedmond@linux.microsoft.com wr=
ote:

> From: Sean Edmond <seanedmond@microsoft.com>
>=20
> Allow dhcp server pass pxe config file full path by using option 209
>=20
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>

Applied to u-boot/master, thanks!

--=20
Tom

--ODkrh+uyG4DstjvP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJFSoACgkQFHw5/5Y0
tywP1Av+J04RnpsXlrI0vVVqcpzCzeHg1k5cj5dd1sAIEK/Kw/AXcG3vB1GWGJgY
tPR3eaHUSEumdlADJTnfEON135Pp01aYF3SNSjoMC6PEIE3WibG2x/EapB8luq8M
jrN7KMBPwPm1vRDV3Q5sMnRrcvrV0ze6CyEnHJ+21WqclfZFUt5IhHYak0MhJ2zI
Aopg7T1XMlfht9SAqS8A/BQIN6oRqk/Y1LdV658YfFvjaW/FJPvOvEZzNMup0sVR
/ck2Ii63CjwM642ansS1lnnO/ITPdqNlYMRENV+uxCnm2avvXWXed1BQ64IVLWb0
DYZIy5GSu0Djg+TuPv+06wRrvgPRG/MotrU6ZcTgqJydr110a5dCnms/04xu49Ic
iB1rXJrngicgpZtF0obsyJDk1wLmgMu5LQuTwYk1HQ3Po/H8HBaZw0v6Pqbe/RqT
DpKXX202s0WFk6jQV/QxhzWUmI9UHVCUzAASm1aQ0XIY4AWFwbUr4s1EMhVUNb80
W2LS7Cx9
=AshG
-----END PGP SIGNATURE-----

--ODkrh+uyG4DstjvP--
