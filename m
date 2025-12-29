Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8B5E92733
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 17:20:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED1E7838BB;
	Mon, 29 Dec 2025 18:20:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IVEKcpDS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34CF483EA9; Mon, 29 Dec 2025 18:20:20 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C356A838BB
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 18:20:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c765f41346so3997015a34.3
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 09:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767028816; x=1767633616; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fUdZ9tGT/9YMR5gIdNwQJdOQpq2oALkSTLW1/0/OLI0=;
 b=IVEKcpDSMYbWjEz51kbr6kQLPU0npxJxity7oF4YD0L7udP80WyBk81WFRgaKNhrtu
 0Bi9o+VYyNV8oGo5OvTQ4YdmN8lMoKGQe7DzD1HEu109tpGTKFim0RnsPAxMmc/L3Yl9
 mW9MakAQXl2nc9MuL2lrHKgDF7BoSgnfoNLkgsiESskQJ3flJ3SVmMkAbuJ6R4w4mzbH
 YWIG2gUIiN8u/TcGvmNVkTDte/mHENnAGnm4Ghvz1wXjKXf1Mc6vXoy+3IF2wZaDqFJD
 jhWZxH/WSVcStA0C1oKEUURQNiAELGtip2dyHNnAvVYQFOpU9bXht3lL+j1RwrCaYjeJ
 oOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767028816; x=1767633616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fUdZ9tGT/9YMR5gIdNwQJdOQpq2oALkSTLW1/0/OLI0=;
 b=dydsleJci/eCX6VdbuX89CxCJRh9X0pDw/uOy9gi946JvE3LItrfEov6+c7luGuO86
 ieJbCssiKdf/6tB1GCY9KfV6LYFXJv6nqSq8kYRWayHGrrnNz08u2jPtZoNB47e9OIbg
 Ac/k0Pd+gbufInwZfJqhOwNmKyMPO3JqEUPtEbEFb3hbEBQqZ1wN/+T5v/002682kZq8
 OyuhIo5+OxYqnKsUwnro1hG80huse6Smo0EiLeIt0pMT3LMXR3hMpaJPPFUlnF2N9cyG
 lRQUOHUbpH8c/c53GIHWZSpM/nkg3FRBGBLFmfaZLQvX2ozsPsolcNhHPyOPMKM7PxVU
 3zXg==
X-Gm-Message-State: AOJu0YxXzlaTsabC15iY6E7YwXQFLgDOvkMNIssXsqVG9bPIrTc/CGbo
 2Qnam5YfzWaHcbrwaa27nDyarMG1M1TJEzvxBAGMHi6FARBkOpSU69yxAOvx5gpZ4nS8K9KDp2V
 Jiwk5jEQA2gvCT1a/ft3Q/iDAXRbEKKq8BZ64UpDyyg==
X-Gm-Gg: AY/fxX5bd95AEpIX/rSH6U//J2o9NGXxysnTLW6qun3oPraG8vXvcPaFJLXBe20xV90
 yU7oT9aQYol3Ud2PVTI4Hrj7PBQ9Jd49eExVPLH15fWMvlhMO85f+qTtWpv5JrvxuL5hT+VtnoT
 8UIoNez01jZzMBiar9aS3dm8cRfHuE9HmLcJyGYMjk6V23Dsge5vSQ0yE0cUI6bLw3PF/b5qCT/
 ++Jtn3xecVqKcSrw9WhKL8XRmPlMH9MenH5xEWN3Mhofmlc24uyGfiFEzqC6NheGUlruw0ZhhiI
 GSNMy8A=
X-Google-Smtp-Source: AGHT+IFIKYjVp1EJMaw3VF8JnjRzjC7NT+y2xBC4Cmq4vdhpElUtKpblR6V1NIYcZIw8LzW51TC8PtNUvRb0eczsh6o=
X-Received: by 2002:a05:6830:4c07:b0:7c7:63b6:89d3 with SMTP id
 46e09a7af769-7cc66a6f406mr18375048a34.19.1767028816281; Mon, 29 Dec 2025
 09:20:16 -0800 (PST)
MIME-Version: 1.0
References: <20251229152200.4805-1-briansune@gmail.com>
In-Reply-To: <20251229152200.4805-1-briansune@gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 30 Dec 2025 01:20:06 +0800
X-Gm-Features: AQt7F2qnl06w3dDp5UDbntJ5WStMUtXBXH7QSXwC3lO7F9eKWeviaxaRlRWmBUQ
Message-ID: <CAN7C2SC4NgEOmhzaB5Ss+KL9JuU7Maq=cCd-jfC0hFyLG-Qygw@mail.gmail.com>
Subject: Re: [PATCH v1] Add CoreCourse socfpga Board - AC550
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>
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

Hi Tom,

Discard this patch, wrongly sent.

Thanks,
Brian

On Mon, Dec 29, 2025 at 11:22=E2=80=AFPM Brian Sune <briansune@gmail.com> w=
rote:
>
> CoreCourse Altera GEN5 Cyclone V board
> do support different size and formfactor.
> Now introducing AC550 C5 to mainstream u-boot
> This is a more complex and unified board with
> feature. More info on [1]
>
> [1] https://corecourse.cn/forum.php?mod=3Dviewthread&tid=3D29788&extra=3D=
page%3D1
>
> Signed-off-by: Brian Sune <briansune@gmail.com>
