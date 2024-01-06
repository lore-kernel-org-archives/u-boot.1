Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B8BC46CD2
	for <u-boot@archiver.kernel.org>; Sat,  6 Jan 2024 14:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BDEF879EF;
	Sat,  6 Jan 2024 15:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CmLFAUpW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62B29879F1; Sat,  6 Jan 2024 15:19:17 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C80586F42
 for <u-boot@lists.denx.de>; Sat,  6 Jan 2024 15:19:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7831386ee01so41475485a.3
 for <u-boot@lists.denx.de>; Sat, 06 Jan 2024 06:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704550754; x=1705155554; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=phmcxDawFw5ZG5tF6o/pLfixiRBuzabilnUEZLhGKkA=;
 b=CmLFAUpWAbmqeN03mWVpk94BRnl7wevyuCfMJJ/INyrFXPphRlqTMeMpRN2KXzSWEK
 ZHrSceYgZgS2UrsVWYplQCRczJBYrjs9n/Aocb7AuwbrLBsmq/Hg9Hj5TPdLWyKCaeSd
 bab9sft93dvVQfJqzqb2yVPJ3dHIL836XeuiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704550754; x=1705155554;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phmcxDawFw5ZG5tF6o/pLfixiRBuzabilnUEZLhGKkA=;
 b=PW+ApQyoOXGwqjv4IQMz4a62X/liJXRYg500PlfftybF0bY7y0R4WYfctqKCPN2wut
 Tz4ECibp0qmBBpphGnlPMquwDTuYcKkDPl1KoUn+6wZDJIZDfcvKFPkb4BLTUI134lZh
 4CdKdVsdavVBu43bVepFHvRLIF/W+WtpcTlYjHmPpQ0hvwHQLY7eFya6CjanqKdwHRoF
 zEbdCmtfWiRP89f6fxccIr1LvNz+VrMm8nBFd5v/amL5S8PuxjqtVZAILSDhzdnxw3c5
 xzTsG1rFk1toNdAHFrgaL89FS+glnciwUQOlwaa6cuQWsYQ4ajOm58p3A1W6ClBtLiFw
 YYnA==
X-Gm-Message-State: AOJu0Yxjb/kbPjPIzzG8/wUHoch1xtxm4QI7d8A3WjJTSsurHgGQWFjz
 RPlXgKJkYpTZqokKBCDhc3MY6VXvFHXjSA==
X-Google-Smtp-Source: AGHT+IGIU9IcySm1N84Xy+BZDMznmpnl/ZqDFwO3VHz3DXu+18W33ktWiio1uVnn3C+B1M38wfGVRw==
X-Received: by 2002:a05:620a:8214:b0:781:5767:7b08 with SMTP id
 ow20-20020a05620a821400b0078157677b08mr992771qkn.4.1704550753758; 
 Sat, 06 Jan 2024 06:19:13 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 x17-20020ae9e911000000b007830d4508d2sm913457qkf.20.2024.01.06.06.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jan 2024 06:19:13 -0800 (PST)
Date: Sat, 6 Jan 2024 09:19:10 -0500
From: Tom Rini <trini@konsulko.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: UBoot Mailing List <u-boot@lists.denx.de>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Simon Glass <sjg@chromium.org>, Bryan Brattlof <bb@ti.com>,
 "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Subject: Re: [PATCH] arm: dts: iot2050: Fix by syncing from Linux
Message-ID: <20240106141910.GX1610741@bill-the-cat>
References: <94c3b346-f131-4648-bc1f-f8ce46449f07@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/wldzLv5TzYZOLZW"
Content-Disposition: inline
In-Reply-To: <94c3b346-f131-4648-bc1f-f8ce46449f07@siemens.com>
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


--/wldzLv5TzYZOLZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 06, 2024 at 01:39:07PM +0100, Jan Kiszka wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> This restores support for IOT2050 by widely synchronizing its DT files
> with the Linux kernel. We additionally need to add the alias restoration
> that is still waiting for its upstream merge and the not-yet-upstreamed
> bits needed for watchdog reboot detection.
>=20
> Fixes: 4dbdc84754ea ("arm: dts: k3-am654: pull in dtb update from Linux")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Applied to u-boot/master, thanks!

--=20
Tom

--/wldzLv5TzYZOLZW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWZYVsACgkQFHw5/5Y0
tyyY+wv/Qqpu6GcaV/TrjFZKARTEbE9AzonWxqdmpB9PAaQkEWrw071A87nxEjqk
CHs1tPqUpW9jeUU/0qQoSOt1/yUPCvZuypwIwDgdi9rmkGSsyi8vKmBK5x6ZmqDj
L7g4AhJKD+b3A39gWjW4WhGrBdRw7cpLefwn15hY4fjJ0lf8hTZFX95DzxQcP2ta
f7nq1SqEJXjH+6Q4ANWLqSOOHsZm0G9NZtDOfnSVdxCioSajyNSoG4xsKOvqsy0i
oDfpRufe2Fdbn/ch3POBBZvcSL60fKNjoN8T6qMSajDRkE6+PzLBJHoqUypr92qN
cAo4UXGBoHMaHf4MC1RBa/okLFtFmYu7qz5AvOceL+e/2ou4o1zWxLO6bUvug04c
v3bQXdctpcaS8nH5V25qgCSj1dc+vfmg/LlQ33vgLdebWS0SiiZhrw4g0gszIJyq
c92lq+VjlxufwoLYPvNT9q6uF2hWUbNAmE9OFGCm6m2gsJ7fp5/nMJyDslYx7+BO
NBiQJIGK
=2Lcb
-----END PGP SIGNATURE-----

--/wldzLv5TzYZOLZW--
