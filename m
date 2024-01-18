Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01963C4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 14:36:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6ADB87B89;
	Thu, 18 Jan 2024 15:36:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K+Ck9qr/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 378FB87AEC; Thu, 18 Jan 2024 15:36:05 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CA278795B
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 15:36:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3bd4e6a7cb0so4557741b6e.3
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 06:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705588561; x=1706193361; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cb1xr93nN3hvw/SzFnfthHMhVrBAqcR8yvDhkERyqEo=;
 b=K+Ck9qr/frM/qUad1hDJxvKoqUVcI1Z1lScQ1u+0ehakZu8xCk6TqA9zl5tXlB/ana
 z3kOiJU6JdSseTWfZYSdxwqocXlIPwIp+NLfAZrAN/drBCZ58AJmkxV2MZM8cLHMjeGr
 kJkMGQaGtpk1jM7S2iVmjHJoimJ1d9rrlCyXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705588561; x=1706193361;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cb1xr93nN3hvw/SzFnfthHMhVrBAqcR8yvDhkERyqEo=;
 b=ra3oWAEu002J7RlBPXwOxAR5iEHnjNe+Jxx1ZlecoChyzkrv4yNci8P/xLW/DDPYId
 Sg19mZfUWSrQqc/KTDLnWKVUqSiD/ijlD9TiNRKi38q4hixH2MMlhAVbcF+WUjOPu2ZD
 wX3X3vds7S5kX2YVciMP4ErcruP8RqkabPNBVc8zfQP+bBENGxIpCLOlOSqdUaldWRy9
 hM9QFUMz8ebLCyIbmxw+kuoCzW4RQZQzDmyCsQ7widEriabCjxU7EMwKdWG1TKCLBWa3
 uPiN+VokI15VF+3YXQ4CgrEpCOwEwroKMkoT656JAMnZekCJn2er2gFU7G/BZG/ZviOZ
 RTWw==
X-Gm-Message-State: AOJu0YwbY2qqnl4HLVToXk321M/i1y2z6EdfaT41By6LvSSFlPQBgmRu
 1YX2FpU5aDe6OHm7wScx6i6mB3J8uNSw3JgNNpEvUgOiX9FZYdOkis8b8UyWVk8or3s+ifua77k
 C
X-Google-Smtp-Source: AGHT+IEMLdtJXiziw2B60gQPbqfIISXmOjaoe07OelxuhqtA7gx7ulvQ1+gO2NAJ8gEm47UZ8UOoYg==
X-Received: by 2002:a05:6808:648d:b0:3bc:1f34:63c4 with SMTP id
 fh13-20020a056808648d00b003bc1f3463c4mr1109767oib.113.1705588560933; 
 Thu, 18 Jan 2024 06:36:00 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 os5-20020a05620a810500b007831ffa4234sm5333645qkn.42.2024.01.18.06.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 06:36:00 -0800 (PST)
Date: Thu, 18 Jan 2024 09:35:58 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20240118143558.GC12635@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XtPcu9EW/PHIme6P"
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


--XtPcu9EW/PHIme6P
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the current set of new issues since I last ran Coverity.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Thu, Jan 18, 2024 at 9:20=E2=80=AFAM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to Das
U-Boot found with Coverity Scan.

2 new defect(s) introduced to Das U-Boot found with Coverity Scan.
16 defect(s), reported by Coverity Scan earlier, were marked fixed in
the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 2 of 2 defect(s)


** CID 478334:  Memory - corruptions  (OVERRUN)


___________________________________________________________________________=
_____________________________
*** CID 478334:  Memory - corruptions  (OVERRUN)
/cmd/eficonfig.c: 534 in eficonfig_create_device_path()
528             p +=3D fp_size;
529             *((struct efi_device_path *)p) =3D END;
530
531             dp =3D efi_dp_shorten(dp_volume);
532             if (!dp)
533                     dp =3D dp_volume;
>>>     CID 478334:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type efi_device_path of 4 bytes by passing it to=
 a function which accesses it at byte offset 5 using argument "fp->dp.lengt=
h" (which evaluates to 6).
534             dp =3D efi_dp_concat(dp, &fp->dp, false);
535             free(buf);
536
537             return dp;
538     }
539

** CID 478333:  Error handling issues  (CHECKED_RETURN)
/lib/efi_loader/efi_firmware.c: 413 in efi_firmware_set_fmp_state_var()


___________________________________________________________________________=
_____________________________
*** CID 478333:  Error handling issues  (CHECKED_RETURN)
/lib/efi_loader/efi_firmware.c: 413 in efi_firmware_set_fmp_state_var()
407             /*
408              * GetVariable may fail, EFI_NOT_FOUND is returned if FmpSt=
ate
409              * variable has not been set yet.
410              * Ignore the error here since the correct FmpState variable
411              * is set later.
412              */
>>>     CID 478333:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "efi_get_variable_int" without checking return value (as is=
 done elsewhere 29 out of 33 times).
413             efi_get_variable_int(varname, image_type_id, NULL,
&size, var_state,
414                                  NULL);
415
416             /*
417              * Only the fw_version is set here.
418              * lowest_supported_version in FmpState variable is
ignored since



--=20
Tom

--XtPcu9EW/PHIme6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWpN0YACgkQFHw5/5Y0
tyy0RQv+Jwm4C9CltZ/jNKVW5tyXo2jBoaPAtc9X1KcvZNhm+siYHV3Hk7vT9wRC
3xrBmaYcQz9OMKJGXR1b/M03y74+83yEPz+DPgGD34bCbseP0hJYJNLzjG14vvQ3
bIl+9fK9qwSjyKttfPp/wIc22V8xJCOisK9ovOTyyNfYxYn3w8MHM4K86ItiBcs0
FECoqVYX/Ow2FrsicXab1/je4b0reAv6uRxqtloIEPgSdds5VUrS9CZQJ1W8C6We
yPboqbqy/seGZJANBqxb1kn82NOCwp5BXh1fCGq4t1MPWzsWwpUdQDGEGOUfpLRV
dO133QDfjPwSuC6tAeP/2ZxHsUvppWoBnCxujD91oaWkEx3Gf5vNGVdmwMEwz2aK
ZQvQZFrb6HlLgXsoeYDfQxPUdIvlfHSRMQdusECaTkeH1B24o6VngWgjfCp8HzWl
3J1ScfU8VSH3fGFxbdXINd4lmyE536s5ZQLQgeFuXvg8TWWUOsl6GUyIAzU8xAy9
DMS9z6SN
=U2WX
-----END PGP SIGNATURE-----

--XtPcu9EW/PHIme6P--
