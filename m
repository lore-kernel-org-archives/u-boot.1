Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F17C54E5D
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 02:30:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 230E487F63;
	Fri, 15 Mar 2024 03:30:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NJnucMKa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0753B87F64; Fri, 15 Mar 2024 03:06:47 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE30687D5F
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 03:06:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-413f2366ef5so8077215e9.3
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 19:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710468403; x=1711073203; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQqUTlFFh82rqrUx384vn3M7LcLdbpb9CHfpNj6JWGQ=;
 b=NJnucMKat4eVNA9CsUExpvaJF93iHTKUAYbC9TdoqAeZ1OYYRrW55m3dfeFBKSCkGe
 jIbzj/vYCubqzVgMi7SGNb/1Au3v20GqhqLRcJhAlNtXKo+bwmznFuo8rgx3+1BzyOX8
 ZyxJ71uqsC6m/n/dFl+XuQ/UHXtTA+WEIXvDaltmq9TcMTE2+6w/FiCGmSXlUEPohpRb
 vLeznN1l7facOmD5PulXukpGfnKaRUdFP7gZNRPlS6kDOV/VBNUTzI4CuwRvplt/JSLo
 yoxr2UZD/9XHz0Sh1M8kaL3ZVbAQIfx7SYor/NDdHNcYZv3st9IfFg4fykK1DOyoiVQp
 Rzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710468403; x=1711073203;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQqUTlFFh82rqrUx384vn3M7LcLdbpb9CHfpNj6JWGQ=;
 b=Qv+bE6bwJytBfyyy28d9Vkij2mK0ID8rD+iyi4W/j4SUOAmd3U+2+tWEXiPtJUylQo
 /jKG/Df//IEoLjO7HsgjZzCmzK3RKHEknN9q5nevtBnBhlWS47rlYDzDFeo2OSRf7zfk
 qdki07CL1NFz0HGCbyQhoiStGHx7KVVRF25tghxWSJ+Qq0geIiz/LPJrvZoCQLO/YHF6
 xlJrYrV+FbtXkrmc9Onj17beUVhquJoSKs2ZJzlD2nYKBqz2AUqH5CGDqhyyNVVRvepS
 sttKLqG2VRKFV2xa6B/bPLCxF9eyTI4nD+dlRHPT0/PaMCc5qoupwz6tqZ/lgQvyy6U0
 kD1Q==
X-Gm-Message-State: AOJu0Yy6Uo13fSUxhhRt7te8/UodK43CG4WoapYKsMJmNE6DtnfDTbsM
 IydjfStnb322qX1KcjFfCp3oPrmsO0dbZMx+zDad1qph7JrE9FY/TH8D7cD+QSVH7JsJ8emwSKn
 vsuMrrLp0J03TVrR94Z2D0KI9gKoZIuHyKVBhrob6CRc=
X-Google-Smtp-Source: AGHT+IHIAY86foHPw7U5I4Cyc9GDSKpf25JUhS5WJjnyd1w4T7N0BM+vqtgXWSBGTM7EqOkRwiZ59b7auqiaqwauJNs=
X-Received: by 2002:a05:6000:a90:b0:33d:6301:91c5 with SMTP id
 dh16-20020a0560000a9000b0033d630191c5mr2156373wrb.3.1710468403273; Thu, 14
 Mar 2024 19:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240310055816.11575-1-seashell11234455@gmail.com>
 <20240310055816.11575-3-seashell11234455@gmail.com>
 <ZfAnkOLt4mdCZLOP@swlinux02>
In-Reply-To: <ZfAnkOLt4mdCZLOP@swlinux02>
From: Kongyang Liu <seashell11234455@gmail.com>
Date: Fri, 15 Mar 2024 10:06:32 +0800
Message-ID: <CAOKwTdpoRW28LbEQi-WWrUubOmmUZk93FzVaUZmMwOMeKSv3cA@mail.gmail.com>
Subject: Re: [PATCH 2/3] riscv: dts: sophgo: Add ethernet node
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 15 Mar 2024 03:30:04 +0100
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

Leo Liang <ycliang@andestech.com> =E4=BA=8E2024=E5=B9=B43=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=BA=8C 17:59=E5=86=99=E9=81=93=EF=BC=9A

>
> On Sun, Mar 10, 2024 at 01:56:45PM +0800, Kongyang Liu wrote:
> > Add ethernet node for cv1800b SoC
> >
> > Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> > ---
> >
> >  arch/riscv/dts/cv18xx.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
>
> Hi KongYang,
>
> Will there be a patch adding this ethernet node for kernel as well ?
>

Currently, I'm only focusing on the u-boot for the Milk-V Duo board, while
the kernel part is being handled by others. Therefore, this patch will not
be added to the kernel.

Best regards
Kongyang Liu

> Best regards,
> Leo
