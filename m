Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B30C3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 14:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07A8981F7B;
	Mon, 31 Mar 2025 16:11:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Mfdabw/I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C210B81F54; Mon, 31 Mar 2025 16:11:29 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DEA281F7B
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 16:11:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-72c14138668so1000655a34.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743430285; x=1744035085; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eEofPODxh6K9rXgVaEgca34yMjRY0+wqRliyCvi2l90=;
 b=Mfdabw/IDEqdkx2SNqEQpX6qCf/5dn5Gi6Y+OJq8sdjHxnsm51lxPvpRUWSWDoI2db
 qwQoyelXA0/Uj9Tef8JrYzMUOBxR+taLEcDGAGCccQS8LKjIKjsJ52GCyST/aiLZn+r9
 74C2idmlaGYEG9ERnR2utpLepKS1dVWs5wQeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743430285; x=1744035085;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eEofPODxh6K9rXgVaEgca34yMjRY0+wqRliyCvi2l90=;
 b=SZhPnHwspYgEf6Z3KV/dWhJoPtyYgmZhvg+MQoKz9CBd5IMmvlEV2R3wE50uUJSZT1
 DCPiVMlbocWyCbq5oVEJjqj5MOAGmi4YG49/zsVZerWUOIDACTSQ4FpHU7pmmW0/Ognh
 9doq5ixGqttXl0lUrdj47lvobC30liKFtAmA/+xKW2bUaf0LZsuopDz1cmwvo9BeDIcj
 jkrswwgBjm67hCyqudsX2/uK89OkGHbpYheeccGtBo+oltTC1bEwvmXQJf8oLCE13EwT
 3o2/S2wJDG+WwFkXwFnvkzE82KE6ervjcQFza5YbXK2dw2KjXoboTNaM+Ip3ldNAa/SD
 No2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzeMCutmJ4mJZifADjFfR+fBknAVQGAjOAuEBBOvyiVdVr8r6lz6c5bQib5rhv4Dl1Z/XE5jE=@lists.denx.de
X-Gm-Message-State: AOJu0YyuissaC+BNed9ucD/5E+EZ9ZaUU+rPx9emcEHlbCsZc3DPgZ2/
 uqtwnZ9rP9AYc55Bp3zUwYh7vV+KpOSwiyBsH0akvYh5KPUNS8MhhR/uNJVMQk8=
X-Gm-Gg: ASbGncvWd09FQGn8lZjN2MmYrfcrZAQqgbJ6hp1aqeNFbCr6Kv3AKYDIM48wjpblQN4
 GpWSXSqeavE/wvS49aDgegneP5NGzIs4RgcPAlqtdmerI/brmqDsApCbqGWml2z8AvPcCIAOskZ
 PRooutPopI82sQYTg1yB/A3IX8IVUOEhayCbRg3bxJpuiS47sExpPEh4+VC/3ZGlXPrbXKTzHf1
 PkiERyoEqP/xfGuO6JwKkYG39xCQ02VDAEVrDowq7yl1i+mESoHGnvzt8DythBkLnk/9OPsJTZP
 ych9K5GNuvTW2zudLbrLRq4ywoKt8nYOvM/SvHsN7nZ0CGy0P94dIDHSPcBhlHINIAFZdW8ewli
 3NF5g6g==
X-Google-Smtp-Source: AGHT+IFLXTisgEcAUhl+myUwqnyfrfDvE4+NLlR8Z2IN8QStVV2w3DoHvlkntpAFa3dIr7Lti8pDdA==
X-Received: by 2002:a05:6830:4988:b0:72a:327:eed3 with SMTP id
 46e09a7af769-72c6376d61dmr5923675a34.5.1743430285043; 
 Mon, 31 Mar 2025 07:11:25 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c58267b79sm1493119a34.47.2025.03.31.07.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 07:11:24 -0700 (PDT)
Date: Mon, 31 Mar 2025 08:11:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 04/18] use proper fallthrough annotations
Message-ID: <20250331141121.GV93000@bill-the-cat>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
 <20250327153313.2105227-5-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fVdfdkzsqjqKf9+G"
Content-Disposition: inline
In-Reply-To: <20250327153313.2105227-5-andre.przywara@arm.com>
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


--fVdfdkzsqjqKf9+G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 03:32:59PM +0000, Andre Przywara wrote:

> In some cases in the generic code, we were already using switch/case
> fallthrough annotations comments, though in a way which might not be
> understood by most compilers.
>=20
> Replace two non-standard /* no break */ comments with our fallthrough;
> statement-like macro, to make this visible to the compiler.
> Also use this macro in place of an /* Fall through */ comment, to be
> more consistent.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--fVdfdkzsqjqKf9+G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfqookACgkQFHw5/5Y0
tyzr3Qv+IBu4yXmv+YPUO8/jxXh/ENOxvD8GeApsIZGJAyWZ2IYezh+UkqQMdcKf
bWv26pwuLPQKhEtDib76KvwASVBxNxDd0esdcX0xVJjnOn9AbbhBh3wNN55c+pqd
6jjufVsOAgTAeXhjDF/rclJeBZaFvbDimX0PZrTegbdIr/4zMPc1tXPCihJ8eAKH
e4XBkSHp35W59ozpwHK5NtDd/PCPKJcrJ2dsDqdboSTdjZift0bioOxUxQnJvH8h
CbWZnFRaILnU/OHUdc2O+//G4TQEQxdLvn6muEai8qToAoZb6JyzTnmstQfvc1nr
VleutRZBJdn1Qj8mBVBphUrZNrMUTUDFt26Jg8oGBVlV+YJatx7fqxT9+XbakTui
CDn3/Jy3x2t3eyVZA5iddCBOkVLw2XJHWWjKQ5tQ+jqqZhirKQx73KRKzN98qM++
obZtiBB4WO4VSU+atdfs5eUkqb7k9HXXRtvLHPuP8VUfGoJq0bfpuadnRVoi30us
bJaAcVcT
=ED/4
-----END PGP SIGNATURE-----

--fVdfdkzsqjqKf9+G--
