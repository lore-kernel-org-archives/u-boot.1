Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AE4C83F34
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 16:32:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B91208344C;
	Thu, 17 Jul 2025 18:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ct/73QY+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 622918344E; Thu, 17 Jul 2025 18:32:04 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2ECC8343B
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 18:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-32b5226e6beso12087211fa.2
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 09:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752769921; x=1753374721; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJdcD2xrc1MSA63fQuYyTFdYFXO1jBvwgMhsHkeyeqo=;
 b=Ct/73QY++OQ3cJJDUzc2YKMfcEA6KZyeYEj8QlTBhl2zQozVJN4nxOuAYnyKih/yVh
 E8UaeRT7iPR7BRyhwTKq1foBabbPBUyAecvnFTdPwKqa5Rv+eueIi66q+711DD1efYb0
 A9J6ExVVCRD/fQAqCBP7QeK4648EPvaYeKxFpRTphUsrsJeUmUVfyLBxxcnv63g5EYbo
 nFb7njixTdjsLnhgJ80cdxdb8BwYDOBvu3aecsDK2fFyX30i64g9zJXUjpmBRSTls9dZ
 W+PzW/AVbu7OVIvt979OOG8mTVzGzCM2RoPKzYH2N1UGhESAd02qnC6wbbDsKewmTFzU
 vnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752769921; x=1753374721;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cJdcD2xrc1MSA63fQuYyTFdYFXO1jBvwgMhsHkeyeqo=;
 b=GUQTQzS20Y5tmSzAkM8IkLYctgzzLIU8Ws9rMRvaKAa3bC9jahN21WwBkzXJURBraQ
 n3w36jmZpT6N+b5IwYIiDF130oTbOYcD8crTeaIGXIGpLZjN9TTbsabxg4vVZZCcNXs3
 9gyFuA6rer5K6bu/fsGtUQaQgXZwoDwTj6WSB99G1aEPs1igiYGFaIkaZONrx9Ph/b2L
 tEHFvjHr2pmP1JTCZbJgDV6so+si53qIE5n4+vObgcpIJ5/f01Kf85d2mcV4BvMZTsR+
 F8ah6f+h5J5l9Nre474dWlvEJPJqqrh+4KyozB1KgzMxUEWHiZcbluj6ROweJkyQA8RH
 dJDg==
X-Gm-Message-State: AOJu0YwGo1EJp5y69uIc8cyz+mfyySeaTHelsjr6Fw0PVgEqV5lBvVj1
 B2/4G8hiREeCINGJYem2QYi5jPjcqYRT8xgcozIyyZSCHGyoWiNjdfJf6q45z+o8nekZufJVDu5
 6d+mW1YbVtQSOrlizcd1wITOjWB5V5lU46g==
X-Gm-Gg: ASbGncu4Z99PEOF1KTzV3Cy2q8yh2NEZdE/N/ThsrwzGxHpLX2SwUMlodTcq253zYNK
 g2Qf0ej7wiXSwbjYl74dwBWN3Nwsq9PPgHabVzBd261Vp9c9u5l6BfLdn9jThNa38aAqSZgyYKY
 YzqIi7fZ6WrCTACIXAbGNO97t3zJwEHWb8OJcRrF+5WNUFw1XJgyh9Nb9XlXQP9o+GiUsw3L74/
 KPhBb2/hhv0k/zznc53nLut4A3ji3fir7gx
X-Google-Smtp-Source: AGHT+IHFXehFqGuUszxrUKNxYkZ8SFvsi/fP/umEY93XIJaSOL0Ejf5UucXJiUIeg2bfA0Q8z6HrJk2SDBqWaS0R/FQ=
X-Received: by 2002:a05:651c:110d:b0:32b:75f0:cfa4 with SMTP id
 38308e7fff4ca-3308f5c95f9mr23662491fa.25.1752769920758; Thu, 17 Jul 2025
 09:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250711152005.2225412-1-trini@konsulko.com>
In-Reply-To: <20250711152005.2225412-1-trini@konsulko.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 17 Jul 2025 13:31:48 -0300
X-Gm-Features: Ac12FXyUlgz-f4WYKvEbY63onE3yZuKne2-coQ0_cwJwnfWCVQOiiWUOjZ6Th40
Message-ID: <CAOMZO5BC+-WUPmK-91geyqy5cMAFjgoh1rpcQopeodZ13XCGww@mail.gmail.com>
Subject: Re: [PATCH] arm: imx: Remove unused mxcmmc driver
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Fri, Jul 11, 2025 at 12:20=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> As no platforms use this driver anymore, remove it.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied, thanks.
