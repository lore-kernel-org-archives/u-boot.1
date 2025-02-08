Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB7DC0219B
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 21:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A068F80885;
	Sat,  8 Feb 2025 22:31:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h3oF1g+N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53C558082A; Sat,  8 Feb 2025 22:29:22 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AF33807FE
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 22:29:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6efe4e3d698so28589057b3.0
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 13:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739050159; x=1739654959; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IbjZofVlnDdKduV/Rra39CwYDOK5JFmUOGp/pFDbr4c=;
 b=h3oF1g+NQ8YHxy9++/fPR3uyPbIWjJLRz5DypMW+HlXzsNQLV83uNj71PfeM9yfFHm
 I4YLQJqts9t0MCWO3ComLCSJOOowNS3Y6Ek0nGhYlq8HW7KGEJ3lP9MiFHyaAlMSMhNr
 H7zTTOeDyKdzOnO45GXeF8+R5xL82GgIppsfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739050159; x=1739654959;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IbjZofVlnDdKduV/Rra39CwYDOK5JFmUOGp/pFDbr4c=;
 b=vX3aANSXu4T3Q3UvZekAhI8fcFbXp4NqpbCMrHQFDlhbv1b7/oCqKzAJteSQTGFKPb
 3kGjSwSQbap+80mOxwjxu5fGBAmANSciEpeSJCY+MgRdOgFMUXv1w9tlLu3iUsfNItfX
 4wPk6+KBZvjG1HRPWzrvxUuhFcDf5NQII4uuegPE49ATee8lh1Z3B4IymhbsMezraEgK
 T1UsP+OD2ufdKluKucr6M/XGhtJXvfI8tPn4A26EPzAGzv2mAj/vtmia0SAc6pnPnuae
 Y/PE8NbrPVhH2SClA18ohuz9XIu0jbae1X64kxkLnXT7c9uCGL+YPiwPpba6kjJgAcHk
 AD5w==
X-Gm-Message-State: AOJu0YwhS8yz5OBs0c/0Y8U3L3dhoruNgMDmloyNq4JRSYH98SIODdTK
 /vxvu76paA5yP7J4hYwwem2v7WRF0axC9jQQY2TkDgQmFXEFC3h+mUXMlyvLVMc=
X-Gm-Gg: ASbGnctMXsn3lzzC2MZuWrm1wfciOb494v7EuI1hEDNU9TonW1CxUSJhUdHAJeQnRbj
 VyxePhewcGAfacjWCcCB8NH0yDwRQ3F+u0dBw+PejMU4yBd6FRys3BP84TUX/Z/CyY5zHrUtgPd
 HeCQ9zh8ky0mMGuwx7oB1sS2abV8/PBUru1tKubAm1hU3pfiSbqSeE9Kjdzj0o/LGN2MMBR/nxb
 e+hbPas3TCNZ5MQmaOqX4c+hJ0GpHCNbKrnMMGIefdiSLVgqEKrCO0/iKBiUQKJp3UDV+ytL5n7
 /lb1NJHcXpY6Uco=
X-Google-Smtp-Source: AGHT+IGsVpBxOh30XxHvLr7R/6wDia06bgGKgIb4jcRymn5L3c5nJ8l3daOZXPtralu9LusLdI3RGg==
X-Received: by 2002:a05:690c:3382:b0:6f9:acb3:4439 with SMTP id
 00721157ae682-6f9b288659bmr68130507b3.22.1739050158935; 
 Sat, 08 Feb 2025 13:29:18 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99fd55c9dsm10036737b3.63.2025.02.08.13.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 13:29:17 -0800 (PST)
Date: Sat, 8 Feb 2025 15:29:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Anatolij Gustschin <agust@denx.de>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Anton Bambura <jenneron@protonmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>, Heiko Schocher <hs@denx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Leo <ycliang@andestech.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Matthew Garrett <mgarrett@aurora.tech>,
 Matthias Brugger <mbrugger@suse.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Richard Weinberger <richard@nod.at>, Rick Chen <rick@andestech.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH v2 00/29] arm: Support building as an EFI app
Message-ID: <20250208212912.GE1233568@bill-the-cat>
References: <20250208171154.1305761-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sT8dXPsEyGFqaLj2"
Content-Disposition: inline
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sat, 08 Feb 2025 22:31:19 +0100
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


--sT8dXPsEyGFqaLj2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2025 at 10:11:20AM -0700, Simon Glass wrote:

[snip]
> Changes in v2:
> - Depend on CONFIG_EFI_APP instead
> - Drop change to u-boot-elf rule
> - Mention '64-bit ARM' here, rather than just 'ARM'
> - Drop the word 'Sadly'
> - Mention '64-bit ARM' here, rather than just 'ARM'
> - Add new patch to rename VENDOR_EFI to ARCH_EFI
> - Update to use ARCH_EFI instead of VENDOR_EFI
> - Mention '64-bit ARM' here, rather than just 'ARM'
> - Mention '64-bit ARM' here, rather than just 'ARM'
> - Rework the commit message to clarify the relationship to link-scripts
> - Expand commit message to explains that EFI_APP skips relocation
> - Mention '64-bit ARM' here, rather than just 'ARM'
> - Document the x86 field better and add a comment for ARM too
> - Mention '64-bit ARM' here, rather than just 'ARM'
> - Put the EFI-app case first in setup_mon_len(), for clarity
> - Use ARCH_EFI instead of VENDOR_EFI
> - Merge the linker-script rules into Kconfig in this patch
> - Drop patch 'Select the EFI linker script for the app'

There's things that were mentioned for v1 that aren't in this list, did
you miss them or disagree with them?

--=20
Tom

--sT8dXPsEyGFqaLj2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmenzKAACgkQFHw5/5Y0
tyx9XwwAmWdcWyMzZiM/Mw8yMyvLUlXUpjfk78BtLDZinnZDOmYZpbDYTW7UVkBL
48ijZnFhHc4yvq/yf+Ix00RAj5IvBMUnGhEwDItS2VzQKeghqzju3d0CM6Ufb1xJ
WphT5hKovOYIFpYItwTFFMwx/Ms/mdhxa5gG29UXeieqweGaUwYNYFJ5HO26ka0X
p+1jAfb1shvs9qc7H4PZ/Aq3R4owk8VC8iaTWBixkUTxoQqaz8xdWMU42BXdMwZo
haX5jBrmZ5CXOkRlLov8pEJGWm2Aeeg9GFlrr7T3g43g/jRtBp6RmoE5JrNQYPqP
onYVkW/CAKGAAUOQvrYbxf1HPPFYMRGvNkQPk/+7drGrurz7RrlwgJUR214yN1pZ
Lbw641qycnCTIapHcGQUEBb4bRPjXCW27AGaFs/bDq/o/L+1hV5YyV5uUs0eh9ay
z+1hLvcREXOujpx4NB61+9Z+kyoULX+WEbWAYamO00kEcat5hrRl6yHSb2Gt+B77
Nac/v/57
=h5qN
-----END PGP SIGNATURE-----

--sT8dXPsEyGFqaLj2--
