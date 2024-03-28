Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906F2C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 15:09:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFBD58819C;
	Thu, 28 Mar 2024 16:09:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o/3czWby";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D07BF88198; Thu, 28 Mar 2024 16:09:10 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D147C8819F
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 16:09:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-78a3bccc41dso34563885a.0
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 08:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711638548; x=1712243348; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RR8DUPy7FRbIIYKUrlkmFjI3Rc10io0EFl/yK1MJuLo=;
 b=o/3czWbyNe8I20xZ8rIgDjpPV3gJ8vQmpp+hAQBSKki2wXmiuEGXtpZn+aKgUCORo4
 cq80C1XxkHvbz1MUWrcop4wBo8dyDLDYekRxhhRMwPQWHUqixDIumTQ1/KpZPOp612Ag
 wuRQeGCAkPk21GGOSw8X1bYjus9C4AUiOgnkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711638548; x=1712243348;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RR8DUPy7FRbIIYKUrlkmFjI3Rc10io0EFl/yK1MJuLo=;
 b=Egrzoesria3CRqCUlW4sXFSoJTGPHoEkajLaX4Aii5pEhI3y38TEk3owbDKU0UVnxh
 iXb7XcxWsoKRd9kkaVxaSqOJWRHk8ETOhZmeRvdND2J+9X9D42m+L6DI8H9PX1emLG/t
 3MFB81flZ07BPrktiKl3rxYKWOnsHFSna6Ctod1AoaBcsmqjCMdXfLRTAJfYA/7m+ZUC
 01HMPTyzSKvg/RLeu+gPvQrn05X6qgbzaUgZIiRG+4rNhk9C09U0WCb+LTCkaaQZC8vF
 rlDwuXyvuVMs0gS/migCjj++Wd3GcKygD4zXDEcAmr75Ryj7XJbFbzWaTwM9ind5fCb3
 /e+Q==
X-Gm-Message-State: AOJu0YxYSnk/cFT7O78/d5reeKyxC549Ss5n5uAnsjaFFkCFSvrw/oU4
 5N0fqbFtciTnq29F0BEQPwI+wIpGDeumxeJJaVDy2GDVMo0pjm7BOQcL7FSRPQk=
X-Google-Smtp-Source: AGHT+IE2Yj5CCsPcF9k3nzQruEpNnZnHponwNxCFh0h22160djnPwznYWyXltsUGugF3J06TQLuWVw==
X-Received: by 2002:ad4:424d:0:b0:698:ec67:aa6f with SMTP id
 l13-20020ad4424d000000b00698ec67aa6fmr63007qvq.0.1711638547761; 
 Thu, 28 Mar 2024 08:09:07 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 t7-20020ad45bc7000000b00698b0639689sm249953qvt.11.2024.03.28.08.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 08:09:07 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:09:05 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH] net: phy: broadcom: Configure LEDs on BCM54210E
Message-ID: <20240328150905.GW3442575@bill-the-cat>
References: <20240101210820.87486-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="byX3Pr0TG+Moul1L"
Content-Disposition: inline
In-Reply-To: <20240101210820.87486-1-marex@denx.de>
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


--byX3Pr0TG+Moul1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 01, 2024 at 10:07:47PM +0100, Marek Vasut wrote:

> Configure LEDs on BCM54210E so they would blink on activity
> and indicate link speed. Without this the LEDs are always on
> if cable is plugged in.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied to u-boot/next, thanks!

--=20
Tom

--byX3Pr0TG+Moul1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYFiBEACgkQFHw5/5Y0
tywq6Qv+OK6aVwpOgnH1pr2OmvZfyo9GgvJOYd+LNobOtnVaMAkxkkk5oOMsXjEz
dxII6bRtNtyrYazhgJzTw7hgre25qWyY0QeBBUaR2PXPuWK+XtThFo2ywOcTJs+f
kkoydCPS/U5SXMYlY+riV7zrlcCdEzu49RWWM5Q9ZaLgvkWTnXIW/h1uEBtSlUlX
dwJ/XJYLuAx2gt7xyRhNyhC1XfCc/J+xdy/wVgVzHtRFqaHOXl08sAcKOQA4OBOT
KmwFDyrmZvegUO9CkBJs3wapzKmSYHWGUvfZU/5lQJO6QrVcJ9faKva6+BzM0ya9
elhf8eZ0iX8dIsJsud+A2/wc4a1b1rNQxAIDX7CIrYH3BnJOtb7JbvZHUBJyzjkQ
2hhzlB+KcOGg9ml3a63Z5KSk471ylxzuwDLHGU3VbUGUOx/05JShdeCT/8oO0Yez
+R10kphE3stvajMs81oNORur0AFMqAPKYr2FiHxEcr7JFWahche0AuRkz+1fwUv+
IkT0dVn/
=0y04
-----END PGP SIGNATURE-----

--byX3Pr0TG+Moul1L--
