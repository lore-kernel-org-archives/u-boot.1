Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C95C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 20:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4BAF87687;
	Tue, 28 Nov 2023 21:42:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks-com.20230601.gappssmtp.com header.i=@gateworks-com.20230601.gappssmtp.com header.b="FuwvUW15";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA36587691; Tue, 28 Nov 2023 21:42:02 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 893C787021
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 21:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a03a900956dso36496066b.1
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 12:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks-com.20230601.gappssmtp.com; s=20230601; t=1701204118; x=1701808918;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iR1pRGRyfVJw542WkqwFnX4G4AunmVSFGFcEWfC58w0=;
 b=FuwvUW158OcWq4sdovsuPtML1jNCRT+bxMRCNoYzsyNyXImWkqmjgo9lAkHHpxlNqz
 Wtw3qq39oH/emEO72sYz3tLsnfzSY9gwAjuQ97Q4AnX/yh7O5U9vS6Qbk90NYx9nFGPz
 ZR9VjPylHnGsPnDh5Jbxk8dFJmUX+7r8a2Gv2vSTQ4gxw5m9LQvkdW3HYtXYwANBVX7x
 lT3kv7WMO449wuvT0JGaz6cip6rTAn0ASEQ/gxYlhCzSno5FgK9MOxTai86uIUKo/wEB
 ASkrDgRoEqbeUjqlHXS8VpgnwUU182MEGwiO7SlK+vULuVnVal+XL9ch+ex7zDhXBRGM
 mm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701204118; x=1701808918;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iR1pRGRyfVJw542WkqwFnX4G4AunmVSFGFcEWfC58w0=;
 b=glf0cL3BLfmAka/rcdhwHBbOvTx8QYEA8zVK1YyfMGx/FoZE4D5Xw54bT8rJ8Flp+9
 BDsDoXjwi4srdVNVtQAC0TSkqHCDKNcqeE92INyyonbivscTrCdX5ZWha+yhF1IAniV8
 lUxotkCAWAcCQvwKGJZKRxwClFPdmaz0brEbfJ+9kewhmtDwrcMbOno2EL91PUN6/Eit
 s6rGB+3LSDTAUzdpzvDww+gbRBFL4sOB4dWBR2iu18pfrKO21nUy6xf2yYIq/9GJOuua
 cdHi/YBDN7kXO8Wplpxktf1VdEZJF6oudM5pUDOjOg0oBNkJTBUPY9OSyterVa3dy+JE
 iSEA==
X-Gm-Message-State: AOJu0Yxlh5OnqXJLGEPFOOG6DZ5ngV873kRsy8piEsQFZpj853WJ6Ccz
 3h4aMgfLVGf/+ZmvECTo9r0yVRqb7dXfDQ/crB4eLg==
X-Google-Smtp-Source: AGHT+IE+DSrwaBkuyJ+Q9ilW8xEuv+qA2H0nT3aaq7TSkdwYZjx1TUb9+IVoQ3cSjIW8Vve9JS19Sh5bu3P2nXqeeHo=
X-Received: by 2002:a17:907:585:b0:9a5:9f3c:961e with SMTP id
 vw5-20020a170907058500b009a59f3c961emr12763102ejb.18.1701204117987; Tue, 28
 Nov 2023 12:41:57 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-8-maxim.uvarov@linaro.org>
 <CAOMZO5AdtdHDnpNUkUieHh7_jhxDOtXp5Mtv2ybkTVLamuxO5g@mail.gmail.com>
 <CAD8XO3bLiTsgaYrYUSJgiwfYQGn6C9+=VN=UhxmZOo_c3ox3xg@mail.gmail.com>
 <CAOMZO5BkNQaMxg1b=Rryrvwfbfe5-0sDLiMe8=D9=NFbdZK-+A@mail.gmail.com>
In-Reply-To: <CAOMZO5BkNQaMxg1b=Rryrvwfbfe5-0sDLiMe8=D9=NFbdZK-+A@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 28 Nov 2023 12:41:44 -0800
Message-ID: <CAJ+vNU0-kB_aW-T_prj-9463+uqGsfsudrX0iQRsW-KQuXC66w@mail.gmail.com>
Subject: Re: [PATHv11 07/43] net/lwip: implement wget cmd
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, goldsimon@gmx.de, Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Nov 28, 2023 at 11:12=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> Hi Maxim,
>
> On Tue, Nov 28, 2023 at 4:07=E2=80=AFPM Maxim Uvarov <maxim.uvarov@linaro=
.org> wrote:
>
> > From this log it's a little bit different wget output. My version print=
s "#"  for status. So I guess it's original wget. You can spend time on deb=
ugging it but this code will be replaced.
> > With my code I tried big iso download and check crc. I did not see any =
issues.
>
> Thanks for your feedback.
>
> I will test wget again after your series gets merged.
>

Hi Maxim,

Do you have a git repo that we can pull from to test for the wget failure?

Best regards,

Tim
