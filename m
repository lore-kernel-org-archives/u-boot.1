Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C433EDEC4D
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 13:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8741686983;
	Wed, 13 Sep 2023 15:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i3zFXfYf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E0FE86D1E; Wed, 13 Sep 2023 15:28:23 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BA948691E
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 15:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-401da71b7c5so77155955e9.2
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 06:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694611699; x=1695216499; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4p6u1lV+dyOrRwqrWD9pQtDiNR6wJJzkFI42hnuFESk=;
 b=i3zFXfYfCdVudLr3ghL4E51dvRjq36xSWk/qCkccqgmmiFPCfcPbY5yRU/leFksaUm
 1X44Xsu1chEq3egCp9oZpsvwXgh8GtA1kr6V3B68+7lMx29aXA3ECKM7btnhq0bgBXJJ
 9ljrz444Uq7xm/0b3YgmsLIp1V63aW6hdyWFFM2QINjD+5ybR33L6/q7xfWj4+XNSDlw
 pgNiXG1ZCTRB5dZW/TRT4kLCuzjy81kgo58wvyihE0IHk7LCCq3EKUGvocOTjUWf/Zy8
 UYNaUVRisKH0ehbIvO5I7EDlw3m3RU7fPsFzHHHwDrPzTaZz80utaQAdiKioBbgP7Ii6
 tZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694611699; x=1695216499;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4p6u1lV+dyOrRwqrWD9pQtDiNR6wJJzkFI42hnuFESk=;
 b=EcGsrTyqMvqWw9/cA/FyU6b4Xp69eNK1mjI6ITJvG1DEf+JGaJ7BA+U3BVHQ+9il3F
 WZsWI1FCSdZDcsciF/DHun8T2cK9p+9RQEc9+YVyiFZr+P6NKiqUl5f5enF06qGuOUL4
 PXMTnR38YtEiCZxB7sPiE8CWQGcCIdrx4WAax5eC2ZBRKFSbDBgCyxyqjiBGzN84BWHd
 /czMpIIs0RjdEJqxsW4SWhZABhRhcPJwUEE1czTOScyeO22vRgAFBnSx8DyVjs3496KJ
 t/1HcCM2XtoIZ6aXoKPpgu0lj+XoTHql5JiAq0ECjWB+UjnPL3Lx4a/Wd0NUPWLVHaXQ
 Zu9g==
X-Gm-Message-State: AOJu0YwpV5DrV6zImzCezLD2WaFBWYZE/U9JJZdZcuJg/ypoR23JtH7V
 eRb3h+NblQf0XUqUEb/JFstl47iPemXw6myj1YE+4NAf
X-Google-Smtp-Source: AGHT+IE4uBWxccNKhDwOW5gtMRaWM28iXyECxIxSlNcUPYqWW8T6WG9bmiLpADC6X5s8htw2pV/g1qgy3w+AjrGFOJc=
X-Received: by 2002:a5d:4941:0:b0:314:1ad7:2ea8 with SMTP id
 r1-20020a5d4941000000b003141ad72ea8mr2315364wrs.54.1694611698935; Wed, 13 Sep
 2023 06:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230902145310.107054-1-jmcosta944@gmail.com>
In-Reply-To: <20230902145310.107054-1-jmcosta944@gmail.com>
From: =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <jmcosta944@gmail.com>
Date: Wed, 13 Sep 2023 15:28:07 +0200
Message-ID: <CABfBAmBirBMaSBfJWNbBQrDJYY0be8n7xaFf6aC=m=Wx0P6uMw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Port gen_compile_commands.py from Linux to U-Boot
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, antoningodard@pm.me, 
 Y.Moog@phytec.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello,

Em s=C3=A1b., 2 de set. de 2023 =C3=A0s 16:53, Joao Marcos Costa <jmcosta94=
4@gmail.com>
escreveu:

> Hello U-Boot community,
>
> I'm submitting a patch series that ports the gen_compile_commands.py
> script from the Linux kernel's sources to U-Boot. This script, originally
> located in scripts/clang-tools/gen_compile_commands.py, enables the
> generation of compile_commands.json file for improved code navigation
> and analysis. The series consists of the initial script import, the
> necessary modifications for U-Boot compatibility, and finally some
> documentation.
>
> Your feedback on these contributions would be greatly appreciated.
>
> Best regards,
>
> Changes in v3:
> - Add documentation to index and fix syntax issues
> - Add reference to documentation in doc/build/tools
> Changes in v2:
> - Add compile_commands.json to gitignore
> - Add documentation
>
> Joao Marcos Costa (7):
>   scripts: Port Linux's gen_compile_commands.py to U-Boot
>   scripts/gen_compile_commands.py: adapt _LINE_PATTERN
>   scripts/gen_compile_commands.py: fix docstring
>   scripts/gen_compile_commands.py: add acknowledgments
>   .gitignore: add compile_commands.json
>   doc: add documentation for gen_compile_commands.py
>   doc: add new section to build/tools
>
>  .gitignore                         |   3 +
>  doc/build/gen_compile_commands.rst |  47 ++++++
>  doc/build/index.rst                |   1 +
>  doc/build/tools.rst                |  13 ++
>  scripts/gen_compile_commands.py    | 230 +++++++++++++++++++++++++++++
>  5 files changed, 294 insertions(+)
>  create mode 100644 doc/build/gen_compile_commands.rst
>  create mode 100755 scripts/gen_compile_commands.py
>
> --
> 2.41.0
>
>
Any updates?

Best regards,

www.linkedin.com/in/jmarcoscosta/
https://github.com/jmarcoscosta
