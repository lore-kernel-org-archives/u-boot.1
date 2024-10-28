Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CF3D1356B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 03:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EF138895E;
	Mon, 28 Oct 2024 04:12:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JSIRgHmz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8727587BF4; Mon, 28 Oct 2024 04:12:04 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00A1688F2A
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 04:12:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b154f71885so379160185a.0
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 20:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730085121; x=1730689921; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7a/UCi5AtxrfFEEg5N0WEaiiv4+4816U99hIMf8wB6g=;
 b=JSIRgHmzNmvQCMOWz+BHVEa2rglhse75GkJrMAcXWel3Nu1TfUcmwuazDKx836ATpW
 sex9R7bwh0LNLEZjtYxLkhJKcrfKzaTRLmVCgY+rH1l9Yvnb8vfjakamCS5H5IIlWams
 FhXlxHP85boibT49hgyGuvDsDG7AhtPdebf3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730085121; x=1730689921;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7a/UCi5AtxrfFEEg5N0WEaiiv4+4816U99hIMf8wB6g=;
 b=VlEnRUd6hqEac1aZQ9L2bwlij9g/h6Dx506ztxiIxmlf8UwZd++FKzaUi5lclUC562
 Gs4bqZw8qxsCOXN0Sd7KLdXV5M5KkCxJOZuRCEe5Fj7TC2rWL84PLg96b3HqreFGf2Mi
 JQkTztXQ+H9H0/tgTHg0VQMSmHFeierTgwT4nWVNPmi0bHYsRGQ7FVv5CN6vrR3Wg32/
 ayZ252rYr61a/dk22Jvj/8tyMCKk07xbFX+tloltl+HX/QY4zY3XS8myQsXgu26MnyQM
 U84BdZFCoOyGJG1C2Qw7hhPEg1nFPwD5W7F561GLNhCn02pCUqcCWPd1/sulkr2bgyaI
 yegg==
X-Gm-Message-State: AOJu0YymVcK0LPvUr36BZEqs5T51ZPKaOADEnH7Y5b0dCY+s8WHvalzl
 zTFxopngHyx173K2vDYQNA9Nn1bdAIL+pl8qAsWeQMz2HzsggT3WGSnmy6AWO5tjj14demzdcJr
 iCUY=
X-Google-Smtp-Source: AGHT+IE+g0D+8oDqWWN2RzynD/hywZN1pMj81fI4FaO3OkNc7zgoDbrgsKz6apXwKKss5m8VWbpd8A==
X-Received: by 2002:a05:620a:4007:b0:7ac:b04e:34c6 with SMTP id
 af79cd13be357-7b193f3e313mr1248965085a.50.1730085120880; 
 Sun, 27 Oct 2024 20:12:00 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d2aac53sm280242185a.59.2024.10.27.20.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2024 20:11:59 -0700 (PDT)
Date: Sun, 27 Oct 2024 21:11:56 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20241028031156.GN4959@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+ffc/KOSQtB2P50z"
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


--+ffc/KOSQtB2P50z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the latest report.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Sun, Oct 27, 2024 at 9:05=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to Das
U-Boot found with Coverity Scan.

1 new defect(s) introduced to Das U-Boot found with Coverity Scan.


New defect(s) Reported-by: Coverity Scan
Showing 1 of 1 defect(s)


** CID 511435:  Integer handling issues  (SIGN_EXTENSION)
/lib/acpi/acpi_table.c: 476 in acpi_write_spcr()


___________________________________________________________________________=
_____________________________
*** CID 511435:  Integer handling issues  (SIGN_EXTENSION)
/lib/acpi/acpi_table.c: 476 in acpi_write_spcr()
470             default:
471                     space_id =3D ACPI_ADDRESS_SPACE_IO;
472                     break;
473             }
474
475             serial_width =3D serial_info.reg_width * 8;
>>>     CID 511435:  Integer handling issues  (SIGN_EXTENSION)
>>>     Suspicious implicit sign extension: "serial_info.reg_offset" with t=
ype "u8" (8 bits, unsigned) is promoted in "serial_info.reg_offset << seria=
l_info.reg_shift" to type "int" (32 bits, signed), then sign-extended to ty=
pe "unsigned long" (64 bits, unsigned).  If "serial_info.reg_offset << seri=
al_info.reg_shift" is greater than 0x7FFFFFFF, the upper bits of the result=
 will all be 1.
476             serial_offset =3D serial_info.reg_offset << serial_info.reg=
_shift;
477             serial_address =3D serial_info.addr + serial_offset;
478
479             /* Encode register access size */
480             switch (serial_info.reg_shift) {
481             case 0:

----- End forwarded message -----

--=20
Tom

--+ffc/KOSQtB2P50z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcfAPkACgkQFHw5/5Y0
tyzjkgv/dF5L44JxHrcbCftcQ+QF9fcVO7lNa06XmZGXX4gpNEjoiZ1Jkn8AMQfq
jUYUMieU8nSuf5qqJFSESlkuLwtzxLixzRkn+Dz0vVd08isFPwDR74UFffYtGZWC
HEuLo0lfPw1M78aYkHGAYn7sycK2VlfLOqeqL45ivEQmB4j2yqp28tY0aOoxprrV
YcTLSH9F6OhtjXi3CaQPW7CY6uvcC4makEBgBLYEgz7QNCJJ9sMzv1sigIbSwd0K
bzosOyLAGpwf+uOnxjPzc0OVSHojGYSPFSAbsOgU699hgDeAk7Co80zIn84kddgT
vIbr1uNV2wV3FRRNQMxbA8gwrlxAEfz+ItUVfy4UYnVVosKn1edVnAK0Z6/sCcsI
Q8LLLiLIEPWG3zJJwfbS9oQm5kOuRfZaO6gZJ/R89g5aiMfrhbJDzt07P9QTWuyA
/qgHoYyxtGFxk+4FBWYJk9fhVbKpR9evuS2oWUYZz4ZAYRY3Gy8sPBfoB44lUQFl
dj06MoNQ
=B96B
-----END PGP SIGNATURE-----

--+ffc/KOSQtB2P50z--
