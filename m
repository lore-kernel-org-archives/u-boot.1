Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D44CD340B1
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 16:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5B1484132;
	Tue, 27 Jan 2026 17:38:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bffum/vZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 748F68414B; Tue, 27 Jan 2026 17:38:25 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3360184132
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 17:38:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-59b679cff1fso5779510e87.0
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 08:38:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769531902; cv=none;
 d=google.com; s=arc-20240605;
 b=YlqXF5ceNYIj2Ie9UcHjN3X8xeD2Uleg9Iony33kAn/RCKZvFWb+but9tApjEaVRMt
 xi9mBoUDhPQC/yk5+Laij09aqlCYc9R8sfrHhYDrQ+ycGFLSzll8ufo1gVkZ7BTvc+8a
 BvCAgeGIuLsAcwg5kBGHWRWQDV2u7mO5x6ziWM1CN1+/yF68zdRt0TX+5ArjjFTnyLym
 pGRQE2jvvfuBKgxbRuMdj5YzYhid4bNbabCuN3ySKmt+v4lZ8T70aHUMo0fgdAnY6JMp
 qqTt9xzokUFaBqYlilSQIdvzTuB6OpZYiP3E9r1mCHHF8IRZlVdSoLAInEqxzLPlnOQT
 sPkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DdxXgbidLYNMV8WmQXg8PRJ5At3kiQWSrxu+SMLJv74=;
 fh=kXSQRj6PKFne4Nl/3vRoVArPmee4oDNXm80DdO3Ky7M=;
 b=FJGg/cvw0INu8rnwZeIeCbEShyRrnHAaPLs4WHnucTAF9Ad7ZVwspBTp2SPmwTyVhk
 vBUNe49O/DHGKBCkcTQEUeDE1n4qToT6vAMxKYOMRIjNVxkVKxsYXUUNZmTLqSTvtVlb
 U7N1DrVglC7z6TA8ittgaMnhGC2bTSBrqG5dt/70AEUebglykpXYvNIwCwMEEENFOUj8
 uUM2HxPRnPZy8wV+laP8iks3uajUVArqVv5OrqG+ZewaZe9y1WdpdB/2SBAamEHQDvfz
 C5MfZ8wfZwpFSXOxe4JWBYiAG+BWUWtHom46DQcZcnL5y1sjHnwcy2fbmbCj1Qnsq6oD
 jAKA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769531902; x=1770136702; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DdxXgbidLYNMV8WmQXg8PRJ5At3kiQWSrxu+SMLJv74=;
 b=bffum/vZCAIPK8KGrF+hB8U3v1fGsFvETtLo8j4MunLLavAzlKeanxkqFFsRcvK2h6
 KLeQffj91aefQRT7Y4M10lqRD8V2NXhd21+Dr7l9MHdlN6Vaf+Ss2fQssMODafp/cbx2
 NNj/2A9RgEP5WXFhuTSIFhE3vjAC7VBArCkAlWk9hPqsP7qmPiAmyW9FsEyZ0aAef3uJ
 cwkdt2Cirx3lxpZHiHE+tA6BinCCVtPRui22EoRbycYFy/XAqA6efVUKwMrY+XikWcvJ
 z1ONYyLJWFhXH5LqLDHpwwFtLyxml3MpDdS6biRSyHoA1CszisYzZHaTruADAQSBo4Bz
 VTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769531902; x=1770136702;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DdxXgbidLYNMV8WmQXg8PRJ5At3kiQWSrxu+SMLJv74=;
 b=m4RjPQ7UNe4wvTS5jC5kuzvsqBzz9pZ57OsgFU1k93Y8aZGukCi5MnmxJJHtFdYuwm
 24o+khRftgihcGetPg0ID4BXlTDf4m34kf7gJpYL5Olyu6aDzJD2g99PMdzQqHJvaQV8
 1uVoJViiW53zjks4h9qKOpJdAs/DpBbMAOJyaM1an5WHTBtI9bN/ftCut+g32CT2QoeZ
 qp8xj0Ny7c0SgLrxmXChov/UwiCrXRw9p1KtUxVgD+BBF27tHMV7ub/6Eyrk7auW5xP2
 w6f8x9+/tEdxgC162XHvrsXZvQId1prGsy6Al1XBj1PVhvj6O7qB83OZms8kc0jwVYdJ
 UY7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVin1QkhTkdq2N4Td5jaCcdd2jNjtbBhRSwe7d/XgjxBrPAtH23sajvW6Zmy5PzwH9klZjT6t0=@lists.denx.de
X-Gm-Message-State: AOJu0YzfVgsG/50k15IocvMzi6GPdr7MrehouD6t4EsbaXHkAKqPHY+N
 h8AJmenVzg+Jb6RpulaXxNseeSiPviosK3d0ZiSHpyHkLiZNIavAa9mMVzzvor+PI616qA9xd7h
 qtS1MEav4GvZHACfwHWeLlk3Iurhbs6E=
X-Gm-Gg: AZuq6aJpaXJHZOkKp7nEIb3AY/q6Z0whWDVydBoYvo9nF/wgvC30egvPXJkwkhJSjjZ
 VHpiMB1XTVz3yBWX+HOgHn+9bRJ7AKVHSWMV/cumcTLHqX1LEzchLbIbHaA5gf5cYansDPcg3/e
 MIaqug+8kUmOfXJlgBNJWQ3xEzn1FQSUIAwM/jZmqGvBtBd70EQOiKOMrR5zA55SmpojX0a+1ZX
 uMeU4uPFOhmwJtDPgpmjoXkwKKXsNsyqDKlo306QGk9pkP582AgpW8Iuvggyot/quC1jf5+/bYs
 7evfsCHAaPI70MWPgoqTG6DbR9E=
X-Received: by 2002:ac2:4f13:0:b0:59d:d65a:7440 with SMTP id
 2adb3069b0e04-59e040263e9mr816597e87.29.1769531901976; Tue, 27 Jan 2026
 08:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20260126204548.GX3416603@bill-the-cat>
 <c2737282-7001-46f3-8ada-58e4007329fe@cherry.de>
 <20260127145335.GA3416603@bill-the-cat>
In-Reply-To: <20260127145335.GA3416603@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 27 Jan 2026 13:38:10 -0300
X-Gm-Features: AZwV_Qjb3qvIPMjesZF-FL_HYMTZyFEXZLR9HofkMGSNxkyK0SUhp848KKh6IBM
Message-ID: <CAOMZO5Bqx0OqKjJ22ekaN12mamEJbTpUg2UB13TWy5JdihJARQ@mail.gmail.com>
Subject: Re: [ANN] U-Boot v2026.04-rc1 released
To: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de, 
 u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
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

On Tue, Jan 27, 2026 at 11:59=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:

> ... Oh blah. I knew I got sidetracked and would forget something. I was
> looking at the final linker / dtb problem (that Fabio reported) and so
> forgot entirely to write a changelog.

BTW, I tested your
https://github.com/u-boot/u-boot/commit/380ddb473c6bdf87e66c0fb93e256d1e233=
c6f5b

It does not work on RV1103:

$ cat spl/u-boot-spl.map | grep __bss_end
                0x0000000000015f18                __bss_end =3D .
                0x0000000000000268                __bss_size =3D
(__bss_end - __bss_start)

$ hexdump -Cv spl/u-boot-spl.bin | grep 'd0 0d fe ed'
000029f0  d0 0d fe ed 00 29 05 db  8a 18 03 d2 43 6a 1b ba  |.....)......Cj=
..|
00015f10  00 00 00 00 d0 0d fe ed  00 00 0a 43 00 00 00 38  |...........C..=
.8|

FDT_MAGIC appears at 15f14 instead of 15f18.

I saw it was reverted later.

Please let me know if there is anything you want me to test.
