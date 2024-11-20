Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3354D63935
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 12:56:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6193C896AB;
	Wed, 20 Nov 2024 13:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I5IDzIBe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22083895F2; Wed, 20 Nov 2024 11:40:48 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 013CF8964F
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 11:40:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6e394dea01fso4585377b3.1
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 02:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732099244; x=1732704044; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SM0yV0SdAJ9vM4zJB2ZoY4NP9oswK0lJTJQTJrpk2YU=;
 b=I5IDzIBexd81/pyU3STCLICu8rOIcWTz1V8HpANwdPG5oMbivg9osUl6ud1uO+KAvd
 KzgbiqcM6F2if6ha8tLMc1CURxxOdVObChpaEcO8ajRIub6Ohe2blaYNG4+HibH61AA+
 9mi50fPLY72lK3NFqN66OPy0WqYCRkyr90FtdeNRKKNn76txy9i7Txm8HEloiLFkOTo6
 160uzHliM/1JBDj7uZMw4mvFsR7sul0q+DU1NfiRCcb9ykf6KFAskvs8B7T6BRW1/0dR
 0nmcKyJ94OnCtZZU8+bXFBs0pJBmBiQx+mAIul0KYxz4Kg3S6cSJxEqMbIg1bSVsHKKw
 XKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732099244; x=1732704044;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SM0yV0SdAJ9vM4zJB2ZoY4NP9oswK0lJTJQTJrpk2YU=;
 b=qiblfpP+l4V8u12zGaCxCgtrP3EjBrtHPmUhVMHe7Pc+ZctfvXhmZLNdNctZk1dSgJ
 0jEYoOV9ynGUmP1Q/ROBdqmUi1gzq/siunauZPcCrkM+SsyDv+8ngnkRIgU6apOY/KkM
 lHQVRasLTcL5/SctrTyOnkItOrQFpV9IpYmfasEUYgNxRyCCu3FHTwi3/8UvLJ1bPTwE
 SwL8UWyL3iQl6QoBPPuBRLmNnPPJ+zd+A+tgvl1MjUb+AmKGUzHoB/WKSWMtSIh4rjHd
 HF7UiNLRLagkXr5k4DB0pQtA9wlmdesCW78h3lSt1cewHHo9oSzBNcUx9JyIxPBVbZW1
 so2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhDQ8kPHAHdlDZYOrK3/fAc1To7noMYJdHfr4dcYEVo4P6sUHkgnD/6PixFH8skbHVdtduDH0=@lists.denx.de
X-Gm-Message-State: AOJu0Yylce/Tb/I8zO5qFRmEij5+VtsqTKa4tPg6tp88EL2Fh8uRzL+E
 7fIjH3jjBJg0k+GSPmx04sTMrnPT1R9tANCQC+w4+m6Fgekiqxxkg1fIMAXQgWiquNNeo9Aiv1R
 AhSgIY0JNogRbtTS/ukLqAakqgZI=
X-Gm-Gg: ASbGnctXS7u6zgy7mQLFCXALOVLOtxbOszCnO4fLxq+lwkJVY8AmfDnzFz8C+Flst/6
 y42kf2JizU7SSQB7YUDTfBW/RIPxRzyI=
X-Google-Smtp-Source: AGHT+IGz3s8QZNz+onwtCpmtHGMGTJgdwzoUXjljNwDZx+oUy3z23abbZ3mWHSQ+SmrgZWSzeD+t1xhgicTcwE03+/I=
X-Received: by 2002:a05:690c:6286:b0:6ee:510c:49b7 with SMTP id
 00721157ae682-6eebcfaaefbmr8174497b3.0.1732099243704; Wed, 20 Nov 2024
 02:40:43 -0800 (PST)
MIME-Version: 1.0
References: <20241119222837.27550-1-l.rubusch@gmail.com>
 <20241119222837.27550-4-l.rubusch@gmail.com>
 <2FEF61FF-5C03-40E0-B962-34E972C2B9B5@gmx.de>
In-Reply-To: <2FEF61FF-5C03-40E0-B962-34E972C2B9B5@gmx.de>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 20 Nov 2024 11:40:07 +0100
Message-ID: <CAFXKEHZ39=V3DZpbS-OG+YZ5602u1K0EAwywUPZAEx-Hrnn=sQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] doc: develop: Fix typos and wording in
 binman/entries.rst
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: sjg@chromium.org, trini@konsulko.com, alpernebiyasak@gmail.com, 
 ada@thorsis.com, mkorpershoek@baylibre.com, 
 dario.binacchi@amarulasolutions.com, pbrobinson@gmail.com, n-francis@ti.com, 
 afd@ti.com, al.kochet@gmail.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 20 Nov 2024 13:56:12 +0100
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

Hi, thank you all! This is outstanding, such a fast feedback! As I
also just ran a tool over the texts, adjusted formatting and
reverted/accepted some changes manually to my knowledge (I'm not a
native speaker). Please, could you clarify the following?

On Wed, Nov 20, 2024 at 12:02=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
>
> Am 19. November 2024 23:28:37 MEZ schrieb Lothar Rubusch <l.rubusch@gmail=
.com>:
[...]
> > Note that some entries are subclasses of others, using and extending th=
eir
> >-features to produce new behaviours.
> >+features to produce new behaviors.
> >
>
> The project once used to prefer British English.

So, I shall revert to the original rather British i.e. "behaviour" and
"rationalise" wording, correct?

[...]
> >-Entry: alternates-fdt: Entry that generates alternative sections for ea=
ch devicetree provided
> >+Entry: alternates-fdt: Entry that generates alternative sections for ea=
ch device-tree provided
>
> 'Devicetree' is a frequently used spelling variant, cf. https://www.devic=
etree.org/ .

Since I found "device tree", "devicetree" and "device-tree", could you
please advice me, what is the preferred term here?

[...]
> >@@ -214,7 +214,7 @@ icons, for example. For verified boot it could be us=
ed for each part of the
> > image (e.g. separate FIPs for A and B) but cannot describe the whole
> > firmware image. As with FMAP there is no hierarchy defined, although FM=
AP
> > works around this by having 'section' areas which encompass others. A
> >-similar workaround would be possible with FIP but is not currently defi=
ned.
> >+similar workaround would be possible with FIP but it is not currently d=
efined.
>
> Both versions seem to be correct English.

I understand. My tool here claimed to do it a bit more formal. I have
no idea, to be honest. Shall I revert it and better leave as is?
