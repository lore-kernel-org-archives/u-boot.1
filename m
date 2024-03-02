Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D0CC5478C
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 15:06:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CF1887E87;
	Sat,  2 Mar 2024 16:06:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CH/R1GAy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C080B87E9A; Sat,  2 Mar 2024 16:06:49 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9176B87E80
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 16:06:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33d855caf7dso373040f8f.0
 for <u-boot@lists.denx.de>; Sat, 02 Mar 2024 07:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709392007; x=1709996807; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=htBEO1k2mQgdDscTclUGfQyLsnolV2lgWzoPBmQvG90=;
 b=CH/R1GAyKYQuWDjnix7SzzTEhTss+ggCbAKcg3wHzI+WJxvUNfGvmi9ieletYtjNOo
 QIK0DEnBtHLHcNhql7i8yG5Xq8k1SgyHrfaKDwo4p07FvVuP3QuOzGzkmBouWpi3gIPf
 Dcf/UCcnwofp6UUy+Jtc1YwZ9PYE77d1WlbhzqXs4v7qdwhHHp3bYP49kVRn2kTrnkD7
 HVFFguO6wYKsh80bi5KCESCZtBUkKUeEVdAXfFq+7byK+A3mODr9JutJOHYfDJukFV0S
 DJrMWigdUNmVPAmuMjOfcXRMxvGF5WmktxhOQkRoxu86GLSUVC10yqRmz3rtchaEMJoa
 B26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709392007; x=1709996807;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=htBEO1k2mQgdDscTclUGfQyLsnolV2lgWzoPBmQvG90=;
 b=csB/p0A0KPUWegM7sfGn/h3rJn870IattQOqxGT3uPmAxIhve6IYmNBGDGUF1cSnBh
 6PYvpdyebqg1YLiKN+x0JVSjE0vcdsuHsTiY4mokkcCX/xgAKNBPK2EvuWbEghx3dOW/
 HWN8tQGW7lJSsabuIuCg2WqMBYXScnxC8g8xeqWUesWiHzt8hyZAXW8d9KiZLgDwy68j
 8pzmd8EdwT2r4iAHss0mU4oV8WYGP9WcQ8FF1/dULaikJGi176NlrHaQWqn08d6Yr2c6
 6f4/C/psZigykE07oUxAHBVYuVcfcerOaJ9gVSUi1hnZxy2fsAgcoRDP+VZqVMccPgot
 2aaQ==
X-Gm-Message-State: AOJu0YwN9ondsMYchNnyY2sPhfWnnhidrPDjcVkrPMrYTjWoVqjGTxZ1
 UATKDpFC2ObIi4v9x1kW+Id6I07kDX1jC4LAOiWQ7fVN5wcB1RLRLwOM+J38dlUFsP9Xr7Qrkr7
 b28TbhlRukzk9VtAezVIYYbtoB+Z7kXns
X-Google-Smtp-Source: AGHT+IFLGtzyFIsrDrWTg6L4gzz2uwXuPIIAMg2WEssTXgcAB27sQYA/ySM3AUO9kLyq+u6QAAdpOM00fBjClR27MEM=
X-Received: by 2002:a5d:550c:0:b0:33e:1b4e:5a0d with SMTP id
 b12-20020a5d550c000000b0033e1b4e5a0dmr3372149wrv.6.1709392006856; Sat, 02 Mar
 2024 07:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20240211185616.1041356-1-igor.opaniuk@foundries.io>
 <20240301233117.GA1492435@bill-the-cat>
In-Reply-To: <20240301233117.GA1492435@bill-the-cat>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Sat, 2 Mar 2024 16:06:34 +0100
Message-ID: <CAByghJZ5k-h48tUBQoikkuCNe1eSYpJWryW33E-n791c36zTig@mail.gmail.com>
Subject: Re: [PATCH v1] cmd: md5sum: use hash_command
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,

On Sat, Mar 2, 2024 at 12:31=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:

> On Sun, Feb 11, 2024 at 07:56:16PM +0100, Igor Opaniuk wrote:
>
> > From: Igor Opaniuk <igor.opaniuk@gmail.com>
> >
> > Drop old implementation and use hash_command() instead, as
> > how it's currently done for crc32 and sha1sum cmds.
> >
> > Test:
> > =3D> md5sum 0x60000000 0x200
> > md5 for 60000000 ... 600001ff =3D=3D> e6bbbe95f5b41996f4a9b9af7bbd4050
> >
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> > ---
> >
> >  cmd/md5sum.c | 149 ++++-----------------------------------------------
> >  1 file changed, 9 insertions(+), 140 deletions(-)
>
> This breaks building of imx8mm_phg.
>
Thanks, fixed and sent v2.


> --
> Tom
>



--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
http://ua.linkedin.com/in/iopaniuk
