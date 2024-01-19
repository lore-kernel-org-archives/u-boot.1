Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C72BC4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:09:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5537F87D22;
	Fri, 19 Jan 2024 17:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oguRmvqa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 842D987D0F; Fri, 19 Jan 2024 17:08:36 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D75687D0D
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5ff9eed5278so5370497b3.0
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680513; x=1706285313; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IKg+4bk3hKmQnns6zW7MXVhuNQT86stN9fvbkX13I94=;
 b=oguRmvqan2qnu7lRtDUvVKZ4M6BHXNNy5MxUA8sngKPfPckLBXpBWo+QGGi4jgpSDF
 h/qwz6YxWLQq4NTR9OePN2p06mapkfnMlh/s6oNw1OXVW12cCCamGdQTssIL05ndkagU
 hBSJ4A6OnC3JVdmO7vcp8Ri3VftI14uNZGmiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680513; x=1706285313;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IKg+4bk3hKmQnns6zW7MXVhuNQT86stN9fvbkX13I94=;
 b=iQ7h2EaSzr8N6urSrvCc9n85PxzL0qZshNUB7Dc4D+nkTePtETLY2dX8QTpu6VPZ/L
 JDqaY5K4mqq3y74/7SbgzPz5oN2Jp/sx3cbkIy+0oy6XNlKObM3cgHcqxH5xjPbLQo4m
 vsaT+oS42KVhwneNnXbt9FFPnyCkXV0YVgXwZ6WN0pdQ5JidY8lWHdcXBbcs4XKWpcMj
 5F+z1fzsyM5wioiMdYZR7PfvE18aAL0QHkH7S4HIVz//wVtP/HyEdn95+Qj4ouJ0A5dF
 GIha9YUPkNYPG5VdsMMUaqu2CBOuzrsG6daHbh32dJ3gMJUN2V3fVjV7fM7TqOBTe8An
 kkDQ==
X-Gm-Message-State: AOJu0YzbCmYekzDUEEydlOxYtPepblwiVaySzLLAaE54HjPCn1H/3Cfv
 WMfvzlSP70o33SMFDFoDGaKS07JjaQNrkAOGEauStqlxzvtRtniPOxbfL8/Rz3qZYC/p1VEbdrh
 U
X-Google-Smtp-Source: AGHT+IFfOvpWyfRPEIzjCIrUZyZBGCvd23cNn6KB6mSdQuhOCrpUgIwxZsgUw7hRYq2BS7HL75QnfA==
X-Received: by 2002:a81:4f03:0:b0:5ff:83ce:b450 with SMTP id
 d3-20020a814f03000000b005ff83ceb450mr916852ywb.34.1705680513231; 
 Fri, 19 Jan 2024 08:08:33 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 w135-20020a81498d000000b005ff89655201sm1288827ywa.114.2024.01.19.08.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:08:32 -0800 (PST)
Date: Fri, 19 Jan 2024 11:08:31 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] boot: superfluous assignment in bootflow_menu_new()
Message-ID: <20240119160831.GN12635@bill-the-cat>
References: <20240107090107.64761-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kS9kyGbB8209n+O4"
Content-Disposition: inline
In-Reply-To: <20240107090107.64761-1-heinrich.schuchardt@canonical.com>
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


--kS9kyGbB8209n+O4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 07, 2024 at 10:01:07AM +0100, Heinrich Schuchardt wrote:

> ret is assigned a value 0 which is never used but
> is immediately overwritten in the next statement.
>=20
> Addresses-Coverity-ID: 453304 ("Unused value")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--kS9kyGbB8209n+O4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqnn8ACgkQFHw5/5Y0
tyxLNAv9G/TE7lPg4FoIwjgnwRHPTEVxR5beJ4vFQg7pjjQ0HPiKdzwk4Y42hoG+
DIjP40n/7/VWHFTqmNq8Xi6w/zPA95xhVKNbdb10UB5sJ3ntU8p4j7tuilPX/sqU
4T3m4Y49QTINvpSp2bcxhjDvK+eYVKOFKJ91HknauNoSXfxul3HAAJ804W2+aI2v
4C8F3+zevVDKzVuqwrMBDpARk+XnEuF9FuG8FYKRtYsOcqsYlbO2QHZMPqFBwIta
7rudkZ09jAtsW+FUCIGgS1uFuKjT8kV3InSq8hRDHie8UEvFJIoW9gMImnfHKvqj
6V7UplYLzuo3H4gXBxeWlBpLl7+QT0cDq+hd8AnSa38GFwJYlvEMhJau/6NpzFov
DSy2uHxDlMofoc1H4FTpfWsWEpGjgLZ5WKekWszy2Y1CMW8GqXi25vzaKIyudJKQ
KOE6tmxtKalYSCoASKO7XHgR4iQqGSTMkskO6aOSPbN+DtQJ0sycBoLh5AK/6SAr
kt/6fRIa
=JlaU
-----END PGP SIGNATURE-----

--kS9kyGbB8209n+O4--
