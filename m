Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8401E7718B
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 17:29:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2001180562;
	Sat, 21 Dec 2024 18:29:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eEwTtNNC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EA9B80562; Sat, 21 Dec 2024 18:29:20 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEE1C803CB
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 18:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b9ad0e84e6so289657285a.0
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 09:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734802157; x=1735406957; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3/ga7vHKJJcEyl2H4vZIzIygAh74PYvvpS8J0yhPysQ=;
 b=eEwTtNNCSe21bj3JwskozhvrE57qIjmHndYDl2L+xxdFolUcSZR8xJg/DZ0i03DYlD
 6tqr0RikoQ2FtXIOrKZM/qYl7EJnnZ9DKoFeu8MdPvpXXAnjMUyegUuYotgEDekcyDLC
 dEkBPqk8TR2UjyphKjFHEpIvgbSImwBClcqIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734802157; x=1735406957;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/ga7vHKJJcEyl2H4vZIzIygAh74PYvvpS8J0yhPysQ=;
 b=pTBGKPWZ1DFNEAbZCsi+nHSqjCOS+0hEX8iCteBmJugypnkscLZhKfBlcvhj9u7cFi
 g1ZYeIcI0YoVb2w0XF4bgJ8jbM0pL+/sUAmLr+sB65THB/0R8/yXfZ91bTa5xeYVB3dS
 I6WV52C1B7py2Edq1UCwRKnZZhAaRDX8e61t8xJcG0tzaEV3L0RdKu1B/OM5XoDBp9+B
 dZw+LDstWAxElnpwJ3fSIIKUq0GOkBsWH1TOgog1gyq84LfYJFObuIKdqLJunwahwc8S
 F5EchblhVpA6PpOLadCui7Ho000GEeai1QT/FAB+Dfu7er/5ViyuPVS4d0tMJXCbasnH
 upQA==
X-Gm-Message-State: AOJu0YwyqM63l/ExdyEA79tQf0vMkKfbvDEzXHFDkMqPIcH8ZYt50Cu2
 NGVL9xHwwhoddlIzLe+fxScAlWbI6ULqo/TYsvbF1LfT4DyVpaKE0tJlBumF2bo=
X-Gm-Gg: ASbGncu+vPiVJAorBxT2ZxL/T3xfu3UJiwZ8KBmV5Vok3ie8Wl3Wr5/KMVhJUTx3pin
 2KbbmUn0bQ62iKBLNmJ9fY7lV2UlUml2MudETg7QseLVWJ48pbeS/t2Uk2s7OV1wmqM6WfK4hsY
 eLti9BVaGv6Re7A/5b0I4WUKBj00b7FDcvzOXp3fCcb1RI5CtO1OcZeC0Xo1pVd9Vs/JgXUZKGn
 LlkxBYk9Kyph++w5NGYpGDygqcnECzfpH48zgoemLNZZjl3NZv4y3zGHA==
X-Google-Smtp-Source: AGHT+IF4N5RV8tL6vTrF3O8AhbRj4Nyc1FHioumfOQIA4NjaDLKDUaBwhxKhRjo+2SnqAt3YNalFPw==
X-Received: by 2002:a05:620a:4708:b0:7b6:c3e2:45f9 with SMTP id
 af79cd13be357-7b9ba836bb8mr1244387685a.48.1734802156817; 
 Sat, 21 Dec 2024 09:29:16 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac30e816sm237317385a.64.2024.12.21.09.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Dec 2024 09:29:15 -0800 (PST)
Date: Sat, 21 Dec 2024 11:29:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PULL] u-boot-sh/master
Message-ID: <20241221172912.GO1505244@bill-the-cat>
References: <20241221132849.9569-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5jLC8S0DTqLLcdeg"
Content-Disposition: inline
In-Reply-To: <20241221132849.9569-1-marek.vasut+renesas@mailbox.org>
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


--5jLC8S0DTqLLcdeg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 21, 2024 at 02:28:32PM +0100, Marek Vasut wrote:

> The following changes since commit 5c8ef70f0872399b3764b2addf1ed27e22dc61=
b0:
>=20
>   Merge tag 'xilinx-for-v2025.01-rc5-v2' of https://source.denx.de/u-boot=
/custodians/u-boot-microblaze (2024-12-20 08:26:16 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
>=20
> for you to fetch changes up to fa0f9e83a0654360506321e38c6d92888cb6f7ff:
>=20
>   net: rswitch: Add missing cache invalidate of TX descriptor (2024-12-20=
 22:20:37 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--5jLC8S0DTqLLcdeg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdm+uUACgkQFHw5/5Y0
tyxtggwAoy9TM9BBsWirIcN+p6hxYuTWt1UZsT49HFCKxQ8HvmQ7ktBZCwnjm7Ia
vtAn8IT/mvPh9bo0rQNj/4TaRxGgPb55fafECjpl4QzYwx6bNvV537E8wfbrhLyt
ybnqIALc1/pRrpb5PRQhKK3A0BX3C8IonQ0T2BcZRD0nKb39LJlRE0Ax8qeBn8F0
PMPlenKdUX6I9hwgdVnG52RkcGMmax+mh4huaYc/fWPB+AnW0nQnveRhHnCTJmRA
6rN0OoODKMXCHO0tzTJ75Xhk3G/f4+KLnlUH+5o8wQ58N7Tkjp0BPVOopHZXQr6B
dlDQoaJ8uF6s3gl6L1pLhC0KX9lqTUtKhbMs5M1M4wLUp8eK9XUVBuvrZEI+B0nA
wBk6swlwUSY1Ic92ppSDf6AaOH1Yyfit0N3Lo8uX/ngD9csxi4JUAEsl9Km9v0AD
2TNMScN8bLKTxmmN3bMT/ChL+LRN1xUr6QaqymnoVbw9Ho/+/Wh4EwJjLjWsPgYl
PHPq07l0
=+iMI
-----END PGP SIGNATURE-----

--5jLC8S0DTqLLcdeg--
