Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5799FC47DA9
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 23:55:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B188C87BDB;
	Tue, 30 Jan 2024 00:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TZOWvZcQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 687B687BEE; Tue, 30 Jan 2024 00:55:43 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 484DB87B77
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 00:55:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-602a0a45dd6so31083207b3.1
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 15:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706572540; x=1707177340; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZL1FW0lEq/DX13jB7HvCpe/2KReZwy4tdMSfxaf2ako=;
 b=TZOWvZcQ834rddkn5EO5EaS7GfNF0xg4lNoQdinVpRW44KMjCCGLk1W0NqwttG8zwF
 S4O77xt3JgzuzpwvrpPdgGWd47LinI7X7/CIPSY9VqEg5VdN/bBbxpdaAsa5JV9K7nSp
 MfKISOGreRV+cZLssAi+43oikLSt2HL5QnFf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706572540; x=1707177340;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZL1FW0lEq/DX13jB7HvCpe/2KReZwy4tdMSfxaf2ako=;
 b=WbGcxOa1Kup/bcJwQsNxGgaZIOk9YpFVCemRRpPgkVoAkoQ+Z8JBLORVaRfYJgVhWd
 ZlYtOVeNPW7iG3auuJ0hq8cxJLa4fMbSt8PlRQdpCf9hy7F299P/g7Zh3HioWnKT94Em
 7WLgQH+TzPUCZF08G9BSleP/sCByjdmc9DSF3sn7TCONe5DdBtk03Eyq3Vjcwjk/C/cr
 4VpYyG5Na6L57T/mGgRLG+QbPAWmocDqcO/tb4e8M5gs2Zqcp0JELfj1OPQnse+WKnHE
 L6E8BspiFSxJmu0VPqb366fVLbpzpERarH3pN4tGTsgq2ogyoqC86WKUb7H6Ai+YSUTm
 OIhA==
X-Gm-Message-State: AOJu0YzBcTId/Imk/drzGeYjc/mDRI/39aa/TEAwJhOmJz9mh/hhVugQ
 fuQw4XzLiaVCRUj5kgIhXasB36zCx0gM6AOtCTLKG5hdRNbxUbq/HLvbWzt8sxzJ/9r+uBYBSAV
 3
X-Google-Smtp-Source: AGHT+IGyZd+t2gFnWbb7F9AiCpHqI0muuPLqiwSGAeJsbcmfox31xcMu+gBRb4ajhSQ/2NLGOvmUtw==
X-Received: by 2002:a05:690c:3603:b0:602:c2e0:39e4 with SMTP id
 ft3-20020a05690c360300b00602c2e039e4mr6422987ywb.16.1706572539846; 
 Mon, 29 Jan 2024 15:55:39 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 fq14-20020a05690c350e00b0060076613cbesm2809386ywb.86.2024.01.29.15.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:55:39 -0800 (PST)
Date: Mon, 29 Jan 2024 18:55:37 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20240129235537.GO1152441@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zL3wNefqe+ZQEN70"
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


--zL3wNefqe+ZQEN70
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the latest report.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Jan 29, 2024 at 6:51=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to Das
U-Boot found with Coverity Scan.

1 new defect(s) introduced to Das U-Boot found with Coverity Scan.
1 defect(s), reported by Coverity Scan earlier, were marked fixed in
the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 1 of 1 defect(s)


** CID 480240:  Insecure data handling  (TAINTED_SCALAR)
/cmd/efidebug.c: 192 in do_efi_capsule_esrt()


___________________________________________________________________________=
_____________________________
*** CID 480240:  Insecure data handling  (TAINTED_SCALAR)
/cmd/efidebug.c: 192 in do_efi_capsule_esrt()
186
187             printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
188             printf("ESRT: fw_resource_count=3D%d\n", esrt->fw_resource_=
count);
189             printf("ESRT: fw_resource_count_max=3D%d\n",
esrt->fw_resource_count_max);
190             printf("ESRT: fw_resource_version=3D%lld\n",
esrt->fw_resource_version);
191
>>>     CID 480240:  Insecure data handling  (TAINTED_SCALAR)
>>>     Using tainted variable "esrt->fw_resource_count" as a loop boundary.
192             for (int idx =3D 0; idx < esrt->fw_resource_count; idx++) {
193                     printf("[entry
%d]=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D\n", idx);
194                     printf("ESRT: fw_class=3D%pUL\n",
&esrt->entries[idx].fw_class);
195                     printf("ESRT: fw_type=3D%s\n",
EFI_FW_TYPE_STR_GET(esrt->entries[idx].fw_type));
196                     printf("ESRT: fw_version=3D%d\n",
esrt->entries[idx].fw_version);
197                     printf("ESRT: lowest_supported_fw_version=3D%d\n",

----- End forwarded message -----

--=20
Tom

--zL3wNefqe+ZQEN70
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW4OvYACgkQFHw5/5Y0
tyxYGgwAk0CqscFqGba+R+WGMicDI9YaZkLbxVK/3yfrCvsFWJutA5y4oLHnrl0n
CJEXSgFHbgaY6YcaVcvMA3sJBW+NERYaDa7c2HfTFWoIDfn1IV0mscKwoSzAnPDe
2DGcNnN8l+xLeIjdMNaCOMmSOnlOwZfB2W+9MJCnZg6AhF8sL4DiDLY5fjE9mKuM
tYShUEByMc93E7cbejRDlRmpuWPYv97K1J1mlwws/WYFrDhhEn9s2afIt/atyV45
KypnNjBTpy1eo8I3tK9jqyZpml1/uXP/ITqeIxKDHNzBKKeFVOa0sKlWU890wQzv
GNsb/cUj+4valhWXw4cKusr4b/8Qct2dC0agGT8BJ3lOTsmR8UAtcCoEYaacV05H
NPPjX8Fpq8XeAP5ybu2S0kyFDo2gioAZbf9qst0LqiiWmMZpIe3LU2Rz+ueJ7FHd
IASW/ZRUX7TvhRWGRLVVxmnyancExZ5l/mkB1ruEm1M5Ut0+Q920CLimuYIC8zzY
DpIEn9Ls
=tHuU
-----END PGP SIGNATURE-----

--zL3wNefqe+ZQEN70--
