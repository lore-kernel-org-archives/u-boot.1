Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5343ED58D71
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 17:26:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAF8789A1C;
	Mon, 25 Nov 2024 18:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QDcZiC37";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5D0789A4D; Mon, 25 Nov 2024 18:26:39 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5AEA88E81
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 18:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b1601e853eso301417985a.2
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732555596; x=1733160396; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3xJDoCSd1+6c2y/KCQwgRixVBWwcv4pHxoeYRQLNQ2w=;
 b=QDcZiC379LAQdJIzLfeg+P+EWdEkbBD6lrXEgKKNP1BlQo/F0eLsDmivBkvmZT5p6S
 9l/zyEV6yKvwZZFnbPOJsjPqeSPMwu4ki3zloP+4dFUKDRGP2N8ujUUd01HMhomK7WnU
 0OBwnhopG5u3ni6EFm/l0iMQQDQpTbDwjEeBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732555596; x=1733160396;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3xJDoCSd1+6c2y/KCQwgRixVBWwcv4pHxoeYRQLNQ2w=;
 b=Bt2fPC79Djxrxr5kPmHdxbKKm8Z6glxpH7beRCQ5ACr0qY4nLKApvMl7vVpqP7i8NV
 3o2erXwKtOhtUeNxrxkd2PL6dqYFf+gHIuE/5qg01QPHM2S3H916DBiMc9JY3EEz9Xe4
 0GuEW+kiRkV/RnKce3uHzZnx39T4XrXCom8H3/Vk8NF8bOKMcFUpcF2O4F5wsZS4AuLw
 xIZuW+IFV+vjgIqJXJvaj4TkTh/vL/zxb/ZwBaqbTkLEmEEPylIgVFtgBZi6+IbKFwyK
 GrtlRWkCxnNbsZ6P3wirrI/C0v61gChlCmsyBYM/DdzYZ4MTs0bJBA4S1sZgjgR76K+j
 0VgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTD/MIWWgYf2T+rffIDn0EH5V4n6fQUTI8DydntJsoUy9NGPH86KDbT+sTs07RksmYmL+IT/k=@lists.denx.de
X-Gm-Message-State: AOJu0Yxt5DBfRhQ6f6X1lc57HrJFD42m2d6s4rIhHJp4gUFsxqONNSG7
 PgQhS+2WByd0kplieSyqk207IzSdMQzGJLBl4WYjshgPQp3Gu8lgpYve2am46fc=
X-Gm-Gg: ASbGnctJrFbe2VzGz05f5djhdQhsXf3QuPb496jjWLViI6uLFF3phxSeiyboduN7ivt
 ZlL0qB21c+0NeYKYxPTcQVhC6H6vFXtTXR13YVRSruL25BCSWlsxLKMYqR3mHLGdmyjZEw77MOm
 iZ0Wtty9DUr2acp8esTjufC450+ausVL8t6Bdtex5hoSPJKa98qUZxETni5sCcaOyXi3QCxBf0A
 M9VZWPeh135DRU0fF5Q4RDm0ySdgjOdXCbLyrP0PqIkmwYf/Q==
X-Google-Smtp-Source: AGHT+IFhHRAZprPvS6fyBnXn6VO9Pg7q1mbFvj6r2fF8GhCczkp1QMBH/DYu6JE+nDb9hkQb9NQoDA==
X-Received: by 2002:a05:620a:319b:b0:7b1:f1d:d0c2 with SMTP id
 af79cd13be357-7b514514e05mr1889498485a.19.1732555596495; 
 Mon, 25 Nov 2024 09:26:36 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b66aea65d2sm132020085a.103.2024.11.25.09.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 09:26:35 -0800 (PST)
Date: Mon, 25 Nov 2024 11:26:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] net: remove duplicate definition of ip_to_string()
Message-ID: <20241125172632.GI3600562@bill-the-cat>
References: <20241125150834.90448-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MejzhZ6eE5ZDk1Kv"
Content-Disposition: inline
In-Reply-To: <20241125150834.90448-1-heinrich.schuchardt@canonical.com>
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


--MejzhZ6eE5ZDk1Kv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 04:08:34PM +0100, Heinrich Schuchardt wrote:

> ip_to_string() was added to net-common.h but not removed from net-legacy.h
> in commit 9063dba2d326 ("net: net_utils: Move ip_to_string to
> lib/net_utils.c").
>=20
> Fixes: 9063dba2d326 ("net: net_utils: Move ip_to_string to lib/net_utils.=
c")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/net-legacy.h | 3 ---
>  1 file changed, 3 deletions(-)

This leads to:
/home/uboot/u-boot/u-boot/cmd/net.c: In function 'netboot_update_env':
/home/uboot/u-boot/u-boot/cmd/net.c:214:17: warning: implicit declaration o=
f function 'ip_to_string'; did you mean 'vlan_to_string'? [-Wimplicit-funct=
ion-declaration]
  214 |                 ip_to_string(net_gateway, tmp);
      |                 ^~~~~~~~~~~~
      |                 vlan_to_string

--=20
Tom

--MejzhZ6eE5ZDk1Kv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdEs0AACgkQFHw5/5Y0
tyy0Agv/aHNRTvSa47tQDyWrixhBlcXUFUeB8+1mCI2cOLoG9thv5cJMH51ED0b+
cnUm9yH9gBbx9r1G8Dth6jWB+U1vGGDIqIRXY5d2WCtAbewtO7IvfolGdCW9WxP4
Cfctuo8tWWPSqxnnsEp5N0cZ74XaY5VmvuW742jt8gp1QuPrVoWKOILizYBOz4Fv
3gzRDMlvg5tYpP7P9Z9ldnSsFoCbOZwh0yt+Y+Wv2nRSqmQ047/5aMsaBQNd0fwc
J2OxSWwQl9EuNwYhGFhMtOkrdQKZx2nb0Qop2MysxVdN/lusQCvlBT7l2clUZ2rx
Pd3wbAgy/aXWPsGIEhgSehwdC9QCuB27WppgSH+nJI1LuvC7TQmnUC6acA7N/LeZ
mv0K/oxqm6pn5w4J9A3kXwrXEbQLzkzzORiOT8xpCDfyroFqch8bVlFsiPXOXzLi
LRCOoXuZAY4fl59GO2np6S2ToJuNfAWFlvV0Lk4aFJOIp8kb+OPnuP2RYXk+/+gT
VFrJ7XwZ
=0RQN
-----END PGP SIGNATURE-----

--MejzhZ6eE5ZDk1Kv--
