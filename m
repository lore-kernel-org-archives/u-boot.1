Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EA1C10F15
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 21:48:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F43888A85;
	Mon, 22 Apr 2024 23:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fv0qcf9h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5A3788A86; Mon, 22 Apr 2024 23:48:44 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 877B388A78
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 23:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-69b5ece41dfso18712556d6.2
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 14:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713822521; x=1714427321; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y4I9Tz4k6qsiGt/x6VSu9ywKYzIXSeXXkQxdvtt9cJU=;
 b=Fv0qcf9hQUH/0zwxtQ1XlRSLdXVV1TGLKy8tOIN6M2ZREbmgZXAKQ6vOPJhrLNYizx
 tRIxj+MsNI8qn0DlSrt38ncfdgNwB99EarFt3CUGAAVvrKImMSb7JUoKUyVkaOaS8YjF
 mpxWtAmDK4XLA0gxstTCxkbguaUIYvih13aT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713822521; x=1714427321;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y4I9Tz4k6qsiGt/x6VSu9ywKYzIXSeXXkQxdvtt9cJU=;
 b=Eh9i3H8c8S3anAuLV7YqNW3Rhc9+b8hTYh+jj/31Ww3wVhtwWoZGoYdWlfTZf6aiJB
 02nomRSTANiivaphfYQ8h5zKzP3oM9UWT3/BWW4qMqI+N2jBIfhmcN+aDavRKIoXl6f0
 TvDPDx+ft2LBSLMCB0FNZR9OrUbT3qVLVdInYf8mcKatW9AHG+0IYexEXCe1lcLfnVqZ
 H2n9f76g50AczAo/bw+XwKFM1eVsdBd3vAFENnFSkfLSa1Bo8SC2UF26wHtf99JBzEXD
 PXLayBQKTIQ7MF9xXHIrRbiH2YTAiWCgqCYPm7RTjq93dMVHLb951FNdPHR/aF6Y0kfO
 000g==
X-Gm-Message-State: AOJu0YxqkPzWNRimjhET1Vs3ePPLgqEnUiBYBxqQ3EHYE8I2Iy0efzBo
 klksrltw2mpaaGZs6ZhWOpRAYZhScA0Id2+oe4T7Q1tMU5i8okuj03VrVmwDjyy/7aknjztM0mQ
 EcdubLA==
X-Google-Smtp-Source: AGHT+IHuV5AnYH5W9Vxa40jYiJRxbr+5Abj3Ty6yjOBfecY4W/5InU7mbdpIIbOSZXJjFghMt1o24Q==
X-Received: by 2002:a05:6214:14a7:b0:6a0:764a:8d82 with SMTP id
 bo7-20020a05621414a700b006a0764a8d82mr6842286qvb.5.1713822521002; 
 Mon, 22 Apr 2024 14:48:41 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 g2-20020a0cf082000000b0069c5d4b95d8sm4557142qvk.73.2024.04.22.14.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 14:48:40 -0700 (PDT)
Date: Mon, 22 Apr 2024 15:48:37 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Charles Hardin <ckhardin@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20240422214837.GY1054907@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Za0we4bLQN4xtKBc"
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


--Za0we4bLQN4xtKBc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the latest report.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Apr 22, 2024 at 3:23=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to Das
U-Boot found with Coverity Scan.

2 new defect(s) introduced to Das U-Boot found with Coverity Scan.
7 defect(s), reported by Coverity Scan earlier, were marked fixed in
the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 2 of 2 defect(s)


** CID 492766:  Control flow issues  (DEADCODE)
/lib/efi_loader/efi_var_mem.c: 236 in efi_var_mem_init()


___________________________________________________________________________=
_____________________________
*** CID 492766:  Control flow issues  (DEADCODE)
/lib/efi_loader/efi_var_mem.c: 236 in efi_var_mem_init()
230             memset(efi_var_buf, 0, EFI_VAR_BUF_SIZE);
231             efi_var_buf->magic =3D EFI_VAR_FILE_MAGIC;
232             efi_var_buf->length =3D (uintptr_t)efi_var_buf->var -
233                                   (uintptr_t)efi_var_buf;
234
235             if (ret !=3D EFI_SUCCESS)
>>>     CID 492766:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "return ret;".
236                     return ret;
237             ret =3D
efi_create_event(EVT_SIGNAL_VIRTUAL_ADDRESS_CHANGE, TPL_CALLBACK,
238
efi_var_mem_notify_virtual_address_map, NULL,
239                                    NULL, &event);
240             if (ret !=3D EFI_SUCCESS)
241                     return ret;

** CID 492765:  Uninitialized variables  (UNINIT)


___________________________________________________________________________=
_____________________________
*** CID 492765:  Uninitialized variables  (UNINIT)
/net/bootp.c: 888 in dhcp_process_options()
882                             net_root_path[size] =3D 0;
883                             break;
884                     case 28:        /* Ignore Broadcast Address Option =
*/
885                             break;
886                     case 40:        /* NIS Domain name */
887                             if (net_nis_domain[0] =3D=3D 0) {
>>>     CID 492765:  Uninitialized variables  (UNINIT)
>>>     Using uninitialized value "size" when calling "truncate_sz".
888                                     size =3D truncate_sz("NIS Domain Na=
me",
889                                             sizeof(net_nis_domain), siz=
e);
890                                     memcpy(&net_nis_domain, popt + 2, s=
ize);
891                                     net_nis_domain[size] =3D 0;
892                             }
893                             break;


--=20
Tom

--Za0we4bLQN4xtKBc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYm2zIACgkQFHw5/5Y0
tywIKwwAlaH/wJsP3xuRFxoteiLsaFGDke7iw3zwqSgY27Kmo5W+sUXYut7UtXRb
L25kx6Qa3A1rhHpWD8odm94NehckVOLm7ggmv6hRm4Fx6CmZKiUtebm6/yLXfMcL
doIliEC3sRdUSbLdbzKcNOC7vq1CLGkM1LotsseME+ZFB00BuFnnR5LrtrlyITUk
6qPkBtmOnturLO1brPhIs/V3/ZThScR927JkrPtSKH/mUEqi6KULz1zlLoVWr1AA
8mbdrMTNCE7gykC2JA2Is/9iqq7UT8HHtW9+VdcILhK2IUyGM5sdMOdzrUnqZ/iv
mHpDwdz+G+PEnk7pJhVdUwn4PsLRFGdaNhI8h+dLp4+4mvDCM9WH0So0A4VTOYlo
Q38jm+woUN/HSNLbTvlIaCdbAFR8MB2JKpVRxm4Yw/TPxCqvq+nbhgcNNbNHt/8A
ByquQg9Kko+BiYpDlYia55WmhZ64srn8t+ITxUFiP5RmrqARWsjhOvhgI8K8AsoN
FXbo0hj8
=b1lQ
-----END PGP SIGNATURE-----

--Za0we4bLQN4xtKBc--
