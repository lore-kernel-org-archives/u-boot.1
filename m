Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8D0C369C2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 13:57:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B40A82D32;
	Thu, 17 Apr 2025 15:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L3MMccEK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89BFB82F5A; Thu, 17 Apr 2025 15:57:18 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52FF782D18
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 15:57:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-400b74336b7so192168b6e.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 06:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744898235; x=1745503035; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vff/qtLOkJLHqwQQP/GoT+nGxIq6muIvsUvr3ksQhEo=;
 b=L3MMccEKTqUnyj1fPX0/W2CAz1xOwEE9djVdt8hAFRs6TOkyy95BeTiIOo2NWj+s6x
 Ir6QZVFkhpONkN891agjKwTlWZ3QPvQg2aT4PALg5W6zEZSXRS/pn78TGHUCw0APdRm3
 LORN5DS6/a1q2wVpQ82JBsN6ssI5rXr5kElwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744898235; x=1745503035;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vff/qtLOkJLHqwQQP/GoT+nGxIq6muIvsUvr3ksQhEo=;
 b=ZaK/MQ63nDkJgoMEH3qwf8PlrCNh7U/sSxphPpfeF0I1a4DfoEN51PW5OfVUL1/eCs
 4fdsV8oVdiK90+pXC6HZB/oVS+AYkxwzAT8ihOTe8O1U3FnOZLdU4SUyMr95mUIyY70f
 IuwwQhrI4PBqWYzUyNd/9OOCud6GlbUuVzzyOCStqmfAzZ33fpjeDcJgylH/UXbBBl0X
 hGZ+MfW0dmi9aQ3sCiy8756FQ61Uu5BIYhKCckAwObO0+F/jka9/jAXrXRqDNTeIIbZp
 FR4mPaYEMbMmpiV2ulBCbuHU87FH9uzH40KZqjvmk9VF/CfeQP1UwjCe5/DVZ7kK+lkD
 +5qw==
X-Gm-Message-State: AOJu0YyzE6OkKDU8Yqh9uGPiqC0BETYTHgK99u6DoRa17QYxHroGGmOG
 qi7WueunqYVo2w1AYB3YGtpYC1AiHp93c36zWn3lYJvqptL4JEYrEsIxEKZrq2g=
X-Gm-Gg: ASbGncuvRpcLES2R/kDCkyY2mbaIMjSIuscMfCQkBRGJQGSvEro59c9x5cX7IpAJZtP
 vE+aTYG69ivIen+1//ONlYFsEfSX4i2MqQGE/GldNIVD5/Lx9nM19BSBj0sMNrNmXgmcjWpeZrG
 2T2TSvUfc76fsfv9kRbarjqq3xm+xuz2E7O8/oOfwhLJZSNKSvwMMUw1Y01k1cb5fF7/YAYXBio
 rZY9tFgX5IXOiv85HANu+sqeNRYc2AvrqmUuLTSfWgV935AsB9/ZZ6QSA+NpeYcK8QbMRPGTnDA
 vEqy7fhpKT7WDpT0mfm6aY1oubF0gOSm43q4kBgQ6RHun7cSQHsFi90GwOnIgL96Ydo+6nHLlPV
 oJuxXKWaCei2E
X-Google-Smtp-Source: AGHT+IHvhaxsvi9pj61zJuAbPqW4/ZUQyGsW+/IuelBuOjh82trlhaSce86pR4wtFWS5HbiyQsqpfw==
X-Received: by 2002:a05:6808:218b:b0:3f8:1df6:400 with SMTP id
 5614622812f47-400b01cb615mr3886069b6e.10.1744898235035; 
 Thu, 17 Apr 2025 06:57:15 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-400763ba82bsm3147271b6e.49.2025.04.17.06.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 06:57:14 -0700 (PDT)
Date: Thu, 17 Apr 2025 07:57:11 -0600
From: Tom Rini <trini@konsulko.com>
To: dinesh.maniyam@altera.com
Cc: u-boot@lists.denx.de, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: Re: [resend v4 00/12] Add Synopsys MIPI I3C Driver support
Message-ID: <20250417135711.GU5495@bill-the-cat>
References: <20250417021840.6212-1-dinesh.maniyam@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6shan8aTboAzN92O"
Content-Disposition: inline
In-Reply-To: <20250417021840.6212-1-dinesh.maniyam@altera.com>
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


--6shan8aTboAzN92O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 10:18:28AM +0800, dinesh.maniyam@altera.com wrote:

> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>=20
> This patchset add Synopsys MIPI I3C Driver support for
> Intel Agilex5 devices.
>=20
> The i3c driver is leveraged from the master/dw-i3c-master.c,
> i3c/device.c and i3c/master.c Linux version 6.6.37 LTS
> And few header files included to be
> part of the migration; i3c/internals.h, include/linux/i3c/ccc.h,
> include/linux/i3c/device.h and include/linux/i3c/master.h.
> Additional i3c uclass driver and command files added to support
> i3c read and write in U-Boot.
>=20
> Patch status:
>=20
> Detail changelog can find in commit message.

If there's a v5, please drop "resend" from the subject line, thanks.

--=20
Tom

--6shan8aTboAzN92O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgBCK8ACgkQFHw5/5Y0
tyy3SQv/R03jD7SLTSbPEbFgcxV7enti8xzK1S+UFK+49R7PLqY7yqNnGzeXTi8U
OcRccsfk7O7NpZIDPb6D38ZIY2vV4bITTtMcwc+Lw0i+U0N549J8Vwbe1JzXsnhs
WA/FQZEQTLZyAW87ytXs4+xsjRTkBen6VcmKWnlqM+2h/SwuRc7ziNlMythgrFm8
A2ta93rkDJfubwbUERHUvHZ/8dONOjZH5W8YZIDdgvhk6ftSCk5dr8jHls7guuDb
ESHvkZZmmbp//lswK2CbDSfzHRGPiMbo5RKFPFb5HtUbR6WWZbp1GtoEB3UYsR91
jqBY6AwlDJcY6ibfJL4Aesb7+b/m8JYY10GI2Pqzp7T8880Eqpbw30bGnnRoK1rR
LyRG7qgCGkL4bXOH/gIu05qP7q0/QcXyo5G+0nbN5pPsd+zYPoqEuE3/WoQGyHV9
hP0ci+jNYarOzwoISu/LA2fXFpZWZBGfcmalMKgTbBGDCtpwmc0owEV4iAOaUvvc
MrVgK/uW
=LQlm
-----END PGP SIGNATURE-----

--6shan8aTboAzN92O--
