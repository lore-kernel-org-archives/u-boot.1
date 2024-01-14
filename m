Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85628C47077
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 23:22:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6F4F8785F;
	Mon, 15 Jan 2024 00:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="feTc//V8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93092879CC; Mon, 15 Jan 2024 00:22:51 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4595E8780E
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 00:22:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-78333ad3a17so663041285a.3
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 15:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705274568; x=1705879368; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vohUKrHKFDuE0VHc/wt0U0bAX88NDZUQNm//n10v6wA=;
 b=feTc//V8kqjgrRFtiXozo4hQygSDWVhLUpOFwT3YqJvz7E3lnLGcGgq3lSoEIt0lOO
 sUBZJF96b5c9vfYlS+cfDzFfDLstXNtbhUQofsskmJNUPzoOVxZUr4Hr6ixo4Zavizmo
 dPHXbleJcX+G35wo0anetlkY85ykzYRFJOyls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705274568; x=1705879368;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vohUKrHKFDuE0VHc/wt0U0bAX88NDZUQNm//n10v6wA=;
 b=DyiEa4dgD3VWhP3rILl4NH1YiIO+M68OydfT71RjmaZGwZ/x5l5ohotLgCjDay/Qc8
 Zavt2oVHEPEI5F1m8aIIBWmAluZ9iGEtl3RHLb8lbVUrd5Mo6vKaKd63S/4ccNT2D6rE
 HohCm3+lcIZ8tN4hZ0fSTruURNNcUXEuSokwAOQqVD6vDVnTDJ3vdwyn4Xv2+nnIMUWs
 YTd9ZKZIZYyDmURioypeX/YSNEOlIsi8r2NTbvpN2suazBPc77LumDbscu2+V+xJjlam
 Z3d3/rxy/gXWMyxITqljiqP3PHRoCDm+jV067AULpSJRDjpHb24M3oEra0kTfzPUSALV
 Rh4w==
X-Gm-Message-State: AOJu0YxYcPQ3QHVhtbd/FqzXho1iJjDreQO+5R+1zMJymRrKTtHi8D7L
 z/umfG11V0OLuvx2HrTpXJBDuY+eXD4J2w==
X-Google-Smtp-Source: AGHT+IEgqHbZ8F4+NXlDnY+KGCgs6lZV9CpG1OAF5RJHVsI/vtnlHukVvvM1L/o6CoMc1WnoXv8JuQ==
X-Received: by 2002:a05:620a:24c5:b0:783:25f9:ca96 with SMTP id
 m5-20020a05620a24c500b0078325f9ca96mr6381010qkn.118.1705274567974; 
 Sun, 14 Jan 2024 15:22:47 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 bk20-20020a05620a1a1400b00781133906f6sm2546965qkb.65.2024.01.14.15.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 15:22:46 -0800 (PST)
Date: Sun, 14 Jan 2024 18:22:44 -0500
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-sh/master-sync-dts-663
Message-ID: <20240114232244.GM1610741@bill-the-cat>
References: <20240114224641.14950-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Rq8NFF79R94mfRzC"
Content-Disposition: inline
In-Reply-To: <20240114224641.14950-1-marek.vasut+renesas@mailbox.org>
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


--Rq8NFF79R94mfRzC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2024 at 11:46:02PM +0100, Marek Vasut wrote:

> The following changes since commit 817fdce324cac70fb4216ba42976f7b9c2ba9f=
99:
>=20
>   Merge tag 'efi-2024-04-rc1' of https://source.denx.de/u-boot/custodians=
/u-boot-efi (2024-01-14 09:34:14 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master-sync-dts-=
663
>=20
> for you to fetch changes up to 73595fd4c007d03765acdbf5420539682ef270ba:
>=20
>   ARM: dts: renesas: Synchronize R-Car R8A779F0 S4 DTs with Linux 6.6.3 (=
2024-01-14 20:35:21 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Rq8NFF79R94mfRzC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWkbL0ACgkQFHw5/5Y0
tyya8Qv/XRbS2EDGi7U6AYCJDI8C+gHmGbNRnCrBoZ5M80uTh4vYtpPnd64WMT5A
7WSQJwzuzyiATxYAJuma2x/Pg6MPr41LPcyIHp7xa+Eb1MxrlGmT4XC1Q7WOXeOO
8q8/AoSFd3As+mq91DelV+DtV7lvA3Yt8clmltqlmNhb/Aq0VuhDOhQNQlebXTFS
CrdiX6hDuXZLDKzKTA9zTjOG6FOu0IET/3opSrP4/WpBBHcYWg8W+JIBG1KZDuAt
HVLVymQ2WTu2qS3LGRJiYo7bZe6ED2+Hm0ZBjgDO+D+Ha174twYrEXjXakgppH1A
PFvKbsvGZYgI1vihQBNNR0tkM9vt9excy09ZJIFW7HCtJEpzMLQa+2U52ioHA5jH
1k2sKQIvCA1nogc0mOI5zZf5martNeO7Oy6IeCZ7wvXc0iqluyzjBjMj9k6rC3E/
04Adj7huHINWd8z2n4QKpwFv0WTqLVYWkksn568IDRwPsxzBV7uYdJThMuszvsLo
UUiB7WPB
=Ur1x
-----END PGP SIGNATURE-----

--Rq8NFF79R94mfRzC--
