Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E162C54E58
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 00:41:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F6BE87FED;
	Thu, 14 Mar 2024 01:40:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iiBT8Wsp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D700887FDA; Thu, 14 Mar 2024 01:40:46 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 683F787FCA
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 01:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7887649cc6cso127497585a.1
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710376843; x=1710981643; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x2kQ6CqIygZ5AAnZe2HFqa87+R6MhPeqnwuoSb1iqes=;
 b=iiBT8WspnBcXAI4P9QXcqInJx4yCqbQCiFUyj2fZnvsr4u408c9m84hZ1MPicNaM0q
 OIgej+H/aYMtdH/YNgNN08rWW0gkcnbOFgjj3MecCHVl3ZUp8XIduLqUJeR5+R2yA6Ca
 asrHePBjrNsaGe8YcSoSXAdLa90IMH+++Xftw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710376843; x=1710981643;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x2kQ6CqIygZ5AAnZe2HFqa87+R6MhPeqnwuoSb1iqes=;
 b=UgKhAnK/HUg1pX+UJEX9kmaLrbf8KvW/u7ha/4qETJM/6H/fF5D2Ec9rJ6koUPiVq4
 33WcFHsmW+XuVGuKhWkFm7MMpiAuTPXBYpsuPVLo+UeM2NJn+1JpVjaGy1CFezfpLF/v
 cobTp1PEI63CCPROjvz3vMyoo4f/L0XUFuLHeK3dvoaGQUx3EYa7jdnDbg9tRBuW4ucN
 LyKDyLpPGJrwp9WEVH4Wg2HXrZulifDhGQ4ZAKkwUYxBEX48o2sfRaI+afwBdR65fG8k
 zhTG2qncLPYTaQeoQU1hLR+POtbxIzKweJU/2P2DkfcmuxOgLRed8soQtCMWxC5gSIHX
 kydQ==
X-Gm-Message-State: AOJu0YwEm/udFwE3lhofZaNuD24MVksHKNmZxgKNztcpADAUH/0h7vPl
 K5RVFSyE0lJi0IK2fxTjNxdbMAQkTtHnP3r6aKJQa7GHAyw1jFtNhl6jKWjZjmk=
X-Google-Smtp-Source: AGHT+IHjibsUtlezO/uSTjKBBPLRVq7r2cQCTbG1b931NN9qwON/m6yzp5vI6buB63hz9oDHR51KpQ==
X-Received: by 2002:a05:6214:e6a:b0:691:abc:ade5 with SMTP id
 jz10-20020a0562140e6a00b006910abcade5mr2772297qvb.27.1710376843185; 
 Wed, 13 Mar 2024 17:40:43 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 hr10-20020a05621423ca00b00690c5ec348bsm216339qvb.119.2024.03.13.17.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 17:40:42 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:40:41 -0400
From: Tom Rini <trini@konsulko.com>
To: Hanyuan Zhao <hanyuan-z@qq.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v3 3/3] cli: compile history code if and only if history
 config is selected
Message-ID: <20240314004041.GR3442575@bill-the-cat>
References: <20240305073734.14483-1-hanyuan-z@qq.com>
 <tencent_82A5BF202DB7378FFE714B6E38F401448C09@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="19LPrd++9CPJmhFO"
Content-Disposition: inline
In-Reply-To: <tencent_82A5BF202DB7378FFE714B6E38F401448C09@qq.com>
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


--19LPrd++9CPJmhFO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 03:37:37PM +0800, Hanyuan Zhao wrote:

> This commit allows user to determine whether to have history recording
> in command-line. Previously to this commit, the CMD_HISTORY only sets
> the compiling of cmd/history.c, and the history code in cli_readline.c
> is always compiled and will take a lot of space to store history even if
> we say N to CMD_HISTORY.
>=20
>=20
> Signed-off-by: Hanyuan Zhao <hanyuan-z@qq.com>

This part of your series breaks some riscv platforms:
https://source.denx.de/u-boot/u-boot/-/jobs/798333
https://source.denx.de/u-boot/u-boot/-/jobs/798334

--=20
Tom

--19LPrd++9CPJmhFO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXyR4gACgkQFHw5/5Y0
tyyzJAv+N3Xz2NmhkFWyyFjjgpnw8vhMuaO3MgxFgB4CJmDwHkY9r+o8E6vpvSme
I4qdp3jBANkBiyaguY8g0Sui5XxAKZbD7gCjNH19mU/UWEt3wygiiclygTLwGWDH
U7mJ/g5+2Mb5f6AcJrz4wUsE1eZXW0vGB1Pzv8pPlpXFMPJQYhCffHrVOnOlGutm
ykc6eakJMb+gzQI4P+fOmn7IeCp1Z//V3pN+c3x0L++xXF9mkCOwHNbOUrc6sJSs
IrC+to/jXib2oUXNOh2PtbKRLD/Bg4S3/k6JFeymZuXDlXXdyzIX9TFgq4u5YB1p
eAuqJfsCMyfRjV68G8FuZBRVGkdA1rTTVhGA8ayYAzDl7IPGVgF3g5wkxanKAXJH
wvSlWcIALOm2db9J8206K6XwK0adVnJzEkeAuEpk3vmyPnTT4VssZScTL49wSsU7
oHfgTLQZOabK9zV6hR6kYO2RhD92yFgUv7+5BmsYqurAubhQ6de3yaOwyJSbpzlJ
4jpVLdjb
=la6i
-----END PGP SIGNATURE-----

--19LPrd++9CPJmhFO--
