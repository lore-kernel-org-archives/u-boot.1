Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC2BCF2579
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 16:15:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46FFC88FB5;
	Sun, 13 Oct 2024 18:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MMJqQJjF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 911B988EFD; Sun, 13 Oct 2024 18:15:28 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1627188881
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 18:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-460391553ecso34424181cf.1
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 09:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728836125; x=1729440925; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nLsbhyassk1fa5AwCS98HTcJ7CXp1GIVfi1IA5QQofU=;
 b=MMJqQJjF5gVgZOaG8dBx/ah1KJza46GGIv6gU4u9IDj34kuasonw/wquAIYVvPSoB7
 tqssu1c+tlIZdlRgS0MuaLlwJL74u9s2PjI7/7yEYY83z3ITSno1Lp5iUSFm1FkRKrYT
 5aYWg1CwA/vgDmZ/FBOSM0Y/qf6qifEI3kvcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728836125; x=1729440925;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLsbhyassk1fa5AwCS98HTcJ7CXp1GIVfi1IA5QQofU=;
 b=FN6yGi9Lr5tLXTY/Y87eIj9ZUjXZ31GJKrile0iK6jAKcRxKX8WlpCQg9fM48Vqu2m
 Sjm5aH/bqTt8auiNN06ONMeLQ26hJDQggZwUcJcLRCQ2iUJo6mBzs+knaUs97/tvS9O9
 7vPKLsvjsIibLyaXMs2QvIcPsE/NVdo+McRIynNe7cMzFj0KhpzXAZC4H69fMAehCjvN
 mTDOq0CQsGWDYqtqdL71XlbrF1NTwSuaRRZUH1rrsG8dF1jDXd5HIYDPtsFU4yirkzC7
 dSYBvOkoNBlPkyl/nVVmPSQyotJPVHYeCeQYtjR48WbSnr8SvMfUF6lBpg0u8vSeQPsR
 up2A==
X-Gm-Message-State: AOJu0YypVE7+oBGK/lbbYzyBy21zIfYTVnovkLaJCiii1f5Ws6USrNdE
 ppaH0VzyywwrtEr82srzEiOGtMNoTc8WF0gIWquJz1CRqOQGvzjwFQIpllsduR8=
X-Google-Smtp-Source: AGHT+IFf+q4Ak4QDgGMm5Dq2fzCe4580OPqvkQhTQ+aoH4bC8SCanMRGBxM1yb6EH1BTOHcwXvWqdQ==
X-Received: by 2002:ac8:5747:0:b0:458:355c:362c with SMTP id
 d75a77b69052e-4605846c6ccmr106536151cf.28.1728836124817; 
 Sun, 13 Oct 2024 09:15:24 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46042807aa1sm35734661cf.47.2024.10.13.09.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 09:15:23 -0700 (PDT)
Date: Sun, 13 Oct 2024 10:15:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/2] qconfig: Ignore defconfigs containing #include
Message-ID: <20241013161520.GM14210@bill-the-cat>
References: <20241012232231.5638-1-sjg@chromium.org>
 <20241012232231.5638-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LaY2oJ+gMqWxsFRm"
Content-Disposition: inline
In-Reply-To: <20241012232231.5638-2-sjg@chromium.org>
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


--LaY2oJ+gMqWxsFRm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 05:22:30PM -0600, Simon Glass wrote:

> Running "tools/qconfig.py -s" will re-sync files with #include in them
> and so un-#include them.
>=20
> Ignore these and mark them as failures.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/28

How about marking them as warnings? It may be good to re-sync
configs/am62px_evm_a53_defconfig for example and then re-add the
#include line, but configs/am62x_evm_a53_ethboot_defconfig on the other
hand very much should not be resynced. Thanks for getting on this issue
so quickly.

--=20
Tom

--LaY2oJ+gMqWxsFRm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcL8hgACgkQFHw5/5Y0
tyw7zwv8DeBPthxhJiwm6W8vIlAE4WmjUHwnf1gAPlKFCTLsT04XN2xTNHbXDj+s
nwNvJGcQThusI24PGYpknxGRxpLybjD0vshcdLNaJhH113PbzToIqs1RDhej5pYE
PtM/zfkMHvuR50JO2QbPvb6RArn0y/IyOFTq0UYtgA6mtbXC69L29vjHxiKAfIdE
zUqdcbuQgqTyUQF2M15bmf2agUSakGHa0DDCVbeg8Oh/dR9hRvRIVV0/AjA6jzwE
4/G8qJeZ+vmbtHCeWCKyJEC81gr8sB2A+gMKAlmziwgUvwg4Blab5d3xyqjtN8Ti
QvhCB31q/nrspbtBmiJO62YKstl0gUqDAhRXEBOH3KzlLyAVrNnKFZaLPFVP0r9Z
1N5UrrsfzYlj/WkiwMzbhqoSGzPIE9QREvoqRSic/6CYvV/63uFn2onbwIYMa6Bb
zm3pa2XCRBwcK8a9MOZIvPQFpJ4Ssfr4K+HuP1w2XtwRnfq95S8zCA4z+tL/OUnt
o25QnUyf
=AM7m
-----END PGP SIGNATURE-----

--LaY2oJ+gMqWxsFRm--
