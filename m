Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44A1C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 15:49:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1132382153;
	Tue,  6 May 2025 17:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j+bk55XN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3B6B82161; Tue,  6 May 2025 17:48:59 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9AA0820EB
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 17:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6060a70ba80so3014128eaf.2
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 08:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746546534; x=1747151334; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FT2qYiV4WAFtSxPA47clQYIhIWZG7ryajlMJXYbxq24=;
 b=j+bk55XNJHb5iPj5Zj47NHUkbCtzr4Jgngql2iCOjNpRIYuQBYsGNrds7x6OtOZ75p
 dXuSUAjPe1YrjnYdNVgsQkGi20gb5JLjV0NsFUINu9LF3u4vX5HyybTLvpiOUx5TUW32
 KgLvDWqjVChEAD1CMjojCFNxmLStLtuV/lBeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746546534; x=1747151334;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FT2qYiV4WAFtSxPA47clQYIhIWZG7ryajlMJXYbxq24=;
 b=XhTgvEdN0+hnW8HwjNBbMmfZDAc2XmPsXLu8wXgjgqoAVR5MvoMS+RbAs6ykdrGrwy
 ImHG4P8E1b2RVEEZhh9269dq6toRx2z3PCSQCE4ekvACQ+tl02OxTr2IndyYMl1XGTE/
 CutMIu775gh10bonWltFar0iHxSsCOGzzFfycHgY180y98vklsTMa9a0nfRkRdTcFu6u
 lItIF6HsUosddaUNhUxjs3+Iddq97SF8nMl6y3sc7Qu49I4dp9+RGAW9h+sn6dUe7YIb
 rOYUItit95ykKeNfXcp88D3KCKcc8IC8hm0uNQ1A+uKb25WH1lthvBRQzZhnd1lFwEjD
 tl1A==
X-Gm-Message-State: AOJu0YwVcHyeSilcsFzyzBK6l6S/lQwIja9Lly2c+UdR29uAmkKaGn8N
 h5v4gHFDRRy9RT3pJdArw6ZzuTh91Y7O+lZfSdmbUqrP1njLuXtZxfkeAsEcwqepApuAJtMpbhE
 k
X-Gm-Gg: ASbGncsbkFazz0af27ZGlI1OZDX/OJvLyJUvfhM14CIrJMFBW6jmnTjVBObbx7m+SKQ
 GfuBig0fpOUFIV0tSt61w3mdy/McAyBR1N9dM5g8sEAZ+EUOpdugtRW2WrBbQTA2K5PZHAGi8Vs
 djMkAqBGqgWAWwHcXLHJgHKsEGtMPKKWKJE2tr4QOrKhb56FAH+sunUAw4QAhgkyEgsfUJ/zBtH
 hnX9pVzoshwsLgtbLsxOV69Bbe+dRFFCWR+1bGpdZKFcoqZ+2VSg6qSwhpTVTFN+xHLbGjJXQRO
 lJv4o60c8lw33lKggqJU8OoKhxU1Hc7EL7RYETEgoFFREqvT/oa7UoGgQAJi9IODJyvpyFlpnTN
 XqfKry+lIV/PK
X-Google-Smtp-Source: AGHT+IEmygzEqma3BFeMG4cuYbrGr9kO8cQGSLqcVvQDZY907+Xx+HKuHODpci/rUcq4VeYLoUH/uQ==
X-Received: by 2002:a05:6820:818a:b0:603:f820:7be4 with SMTP id
 006d021491bc7-608002fe960mr7249207eaf.8.1746546534632; 
 Tue, 06 May 2025 08:48:54 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7ca1647sm2210231eaf.1.2025.05.06.08.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:48:53 -0700 (PDT)
Date: Tue, 6 May 2025 09:48:51 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Latest Coverity scan results
Message-ID: <20250506154851.GW5430@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oFVJOJx65R1hFc/P"
Content-Disposition: inline
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


--oFVJOJx65R1hFc/P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Unfortunately it looks like Coverity scan no longer generates the email
report with code snippets and only send me a high level report now. So,
the latest report is visible only to project members when logged in, and
is:
https://scan8.scan.coverity.com/#/project-view/22486/10710

So I'm making my own summary and either explaining what the problem is, or
copy/pasting from the viewer.

This has 3 new defects. Two of which are in
drivers/video/console_rotate.c and the console_putc_xy_1 and
console_putc_xy_3 functions noting that height/width arguments are
reversed in the return line call to video_damage. On looking at the
code, I think x/y are as well and maybe this is intentional but not
clearly commented enough?

The third defect is in boot/bootm_os.c the do_bootm_efi function:
503        /* Run EFI image */
504        printf("## Transferring control to EFI (at address %08lx) ...\n",
505               images->os.image_start);
506        bootstage_mark(BOOTSTAGE_ID_RUN_OS);
507
      2. Condition images->ft_len, taking true branch.
      3. function_return: Function efi_binary_run(image_buf, images->os.ima=
ge_len, (images->ft_len ? images->ft_addr : NULL), (void *)images->initrd_s=
tart, (size_t)(images->initrd_end - images->initrd_start)) returns -9223372=
036854775799.
    =20
CID 550810: (#1 of 1): Overflowed constant (INTEGER_OVERFLOW)
4. overflow_const: Expression ret, where efi_binary_run(image_buf, images->=
os.image_len, (images->ft_len ? images->ft_addr : NULL), (void *)images->in=
itrd_start, (size_t)(images->initrd_end - images->initrd_start)) is known t=
o be equal to 9223372036854775817, overflows the type of ret, which is type=
 int.
508        ret =3D efi_binary_run(image_buf, images->os.image_len,
509                             images->ft_len
510                             ? images->ft_addr : EFI_FDT_USE_INTERNAL,
511                                 (void *)images->initrd_start,
512                                 (size_t)(images->initrd_end - images->i=
nitrd_start));
513
514        return ret;

--=20
Tom

--oFVJOJx65R1hFc/P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgaL18ACgkQFHw5/5Y0
tyyoIwwAhx3khreOg3l0uc8snjYzTKlB4RXnJd7LJshIjFdaJ1NE80BF5Xp76FJJ
gR5ypx8k59TKGW6jraIvY66G0sGGY68BF9TfUII+zmSB2CDX7G1CZ7jHF0khEX3M
f1dQHb9P6VcKvvXXhQd2jOVnPzZ693CxeyLMFPOJNZkv3gCxvoQ+45R3YctQzlUr
nI4HyMmOtSKFQ8DiQUdrx8JPuPPWeaWOxJjy+v9DmFUytcwCoxfmECFpf7tr5/Tg
3d5/LqKgc7dofJqa1JS2nFzUnbvkWUx8cAXrwePOROi7segnrSNpOLP+bTcz+T75
K4E10VWoTrq1zZLA/k/NzE2srGX3G2qFc3maafYTLUHmPxbC2yCa5RIwgFJl5/KU
KbEHfQLoBTVnGX0fhAly7YtSxsunZxDf1eT9yKdeJJ0P5yiVBhRp/QxspVu+u1NT
OKf1pPPKbQZ8WkyszhnCY3ALeFWvFG0B88BWFl3PgzLmOaFqdQnlbdsR7tkSBafg
4WshDeir
=HQaV
-----END PGP SIGNATURE-----

--oFVJOJx65R1hFc/P--
