Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2F8C4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 11:23:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A35187E38;
	Thu,  8 Feb 2024 12:22:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="Q3W1/6B0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3831F87D1E; Thu,  8 Feb 2024 12:22:58 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31CCC87D1E
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 12:22:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 69aabb5c-c674-11ee-90ec-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 69aabb5c-c674-11ee-90ec-00505699b430;
 Thu, 08 Feb 2024 12:22:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=+c86awgLgIOYWRvTC7Zd74i5LeP72LH+JwGNhX+F7x0=;
 b=Q3W1/6B0VNLbXnAz2ILJgPe94378zryem4ypSt/dKh0xuthR1on3E9LmCutTLbiwfRFERinHXlLk2
 6cy7SEARFaj2nSCjj7okSi1yPs+FEyYsBeND2sT7W0JXhDXc4+v4QXg6jhM8hZ5JzMNKrU5LWBYCu3
 QqMB9RuJmLiqlRQwqvOrb1bH6Dyxuv/Yf2jJZ5OrbmtT7MBfT2iBUVgt8SnsZzXlsYcEsUMr2xk8v1
 G92KBwHQWix3KUt0tpWHNA3sg+D2rMF8RRU/gVdXCVzDTVe2nhWkTl69WkiR57l2tXNqn5n7AWzWtj
 7WHuPj0exOqXFzyd9f0DuCwSF3Y4fVw==
X-KPN-MID: 33|59PR5+IPDeBoTfw3Yj2DnAvOd0cDEKVLi0PdT6u0yJuibOUbjuI+6HCuht/KP/q
 xh8TbA/t9FGeR+a5pn+IZwI7aMcOUnp87uXgiaGgx7mY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|WTb0QxMK6q9AysdDmuQaroSlJ9VSV/aCXBPSPqkK6mWHOxJuw+D7biQzfmcevez
 J2fAQzbOMUykN6EbOBE2xoA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 67277ced-c674-11ee-9e74-00505699772e;
 Thu, 08 Feb 2024 12:22:55 +0100 (CET)
Date: Thu, 08 Feb 2024 12:22:54 +0100
Message-Id: <87il2zp5dd.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: trini@konsulko.com, sjg@chromium.org, u-boot@lists.denx.de,
 heinrich.schuchardt@canonical.com
In-Reply-To: <20240208104952.19964-1-heinrich.schuchardt@canonical.com>
 (message from Heinrich Schuchardt on Thu, 8 Feb 2024 11:49:50 +0100)
Subject: Re: [PATCH 0/2] smbios: fill wake-up type
References: <20240208104952.19964-1-heinrich.schuchardt@canonical.com>
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

> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Date: Thu,  8 Feb 2024 11:49:50 +0100
> 
> We should not use the reserved value 0x00 for the wake up type but
> use 0x06 (Power Switch).

Well, if I look at my collection of boards, many don't even have a
power switch.  So I think the only sensible default value is 0x02
(Unknown).

If there is a compelling use-case for providing a more accurate value,
that should probably be done by the various PMIC drivers.

> Correctly display wake-up type in smbios command.
> 
> Display SMBIOS type 1 field family in smbios command.
> 
> Heinrich Schuchardt (2):
>   cmd: smbios: type 1 wake-up time, family
>   smbios: fill wake-up type
> 
>  cmd/smbios.c     | 25 +++++++++++++++++++++++--
>  include/smbios.h |  2 ++
>  lib/smbios.c     |  1 +
>  3 files changed, 26 insertions(+), 2 deletions(-)
> 
> -- 
> 2.43.0
> 
> 
