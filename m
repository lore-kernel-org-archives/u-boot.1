Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF924D6AAFA
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 01:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FDA68382A;
	Fri,  3 Apr 2026 03:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nnAzn022";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C62B839DF; Fri,  3 Apr 2026 03:39:07 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90F0083693
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 03:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5a2a70bb69eso1635019e87.2
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 18:39:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775180343; cv=none;
 d=google.com; s=arc-20240605;
 b=VTsjOm3W7Iqybsvkolrcuha0iKyhGS2J5ukBxVFhrt4x+AF438daBVQMZpZoGiezNG
 A1gMTjEBW2/s3D81bueBtaYA9BHJ32uAQa/0ucWZvnnrsbDNw6mqkg1901g90Km2yb72
 KoPHIGk0bz1XjRLB7xyvt3gRQz90cv1I3+MutHBkAOGW9dYdWtJVNdSps1XAIbKG6+0O
 Z6a0WBLblovaXJl/prF3JgDk6B64Z5bMSf+yZdwv7EkctYQcX3fTeC3OgtK+m4s3RC52
 wRMB1aGb2f6ZM/579/2fphD3y+Yt3VXCEoVpT890d/PdvmfGcm9ZJ4JNtS1ZtsU1CI3Z
 VykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lPkJv2EQH2afVff9Mq34ytEY2Z+iSK0FMW3UZZJPojQ=;
 fh=GCDHkA5ziAWihh87eUKGvpL/+qMP4zk1XVxbShwRSbc=;
 b=Hgbx8FUUnbAqgAlQn9wybCQjsrOGUz3naUfXr3rIjoSOe9ajBKzUKjyUEYqO6mVfjZ
 CpDvLtzQRFyLrlM90PFl1X6tlrhrotuSM6wG7hqxZ6XtcN7krJ37Pp6j3qZV+mmcohFF
 dhGdRU0ElniIwCAeeNZMBuQkBqeWJBE1GXDM9A3P+gyqrcqLQt1hvU6AuhXu+ZBaXdyI
 xTz1N2zcdikNJXFZ7FmhuD3KwcRg/Fh+OQfsUO0AJ6oP7Ys+fdMuK5NwDE9yCHqSm8V9
 rzjJBEXPmymriSTgZ6sCa9usQTUoMuzH/tRClBDNOtcBZO3wkY0x3kTw+ZfJvtKwO/G9
 f2Kg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775180343; x=1775785143; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lPkJv2EQH2afVff9Mq34ytEY2Z+iSK0FMW3UZZJPojQ=;
 b=nnAzn022gsBDE2Vpi416ColqmQUxjnm5AdkBQ5oJqwTLapztB7qlqrHw7U0QDtV3KF
 bVXvMxUonRkCVYiXwyV4GGGOwjZxn4HZGmDCmQsNRvk/EMoFlkxpiWBlzRaWBqR0Qjq+
 hqVhKR/onnPXNoiCaTKj/ej1X634+n5f+7bqBbtjjqXm1U7RyXtw3wAiVEB5EKKtaF3C
 92fu+66eiv25igxVUjdlyd2wKp+cEqoJJHjoS9zAH77WWNVHBwt+r2q0v+j+kc2qxdS8
 0boLRIakk/NKeP+ArJMEGtVBwzDRTotKadhHEN2EEkV+HwjMlNI8pAiGftFteMXajzsE
 fDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775180343; x=1775785143;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lPkJv2EQH2afVff9Mq34ytEY2Z+iSK0FMW3UZZJPojQ=;
 b=YjyA6EtHNhWBY5J3psFS7yppYk0CaqTOr55ty0QWYahy9kmkLGiuVCVC+VxprmSnLg
 FVzGanqtrM1/tkbcmv4DwZyClm1fL5KYikpyOcBo7FjXuUvfxlrKFLfZpIPJnovNQzL2
 0blW23aADvXZaRVcs8xAQE2oI16HFGB+UhGJZDQDNLwz8Iad76XISKQg0PEqNDWqvxPZ
 5UrFyWXblZ6o7Es/y3N9Fz+QxjhUkzn8FlxEDUQ7mHs2idtcpVqP2YBPhXTQjDjEnBb6
 mo3Hg/csP+vBlI9y4yu7R63ubj8JgeF5HK2avwdmVbLPFGTcFr9dMraaKWcMkdaRkqGS
 w43Q==
X-Gm-Message-State: AOJu0YzBeoj6Dwzk7k90tv0SKErbC1OvoTvrrni7nY4dHnMdyFNokbtZ
 sNKagvYPrd0kGijrFs/g8dpOkyYhkG+n3Bo5xQ6/moT5vJcHhquFQxRulw8cVIUUZFovky0F0xH
 RSq4bQPcWN22B+YlHlH1WKRlLEvqOkug=
X-Gm-Gg: AeBDies6YUBqhCB+IVRDydn3W8GYbhkf5fV1vsYpeP1vMk9urvkl0iWUJvGefjGE4aQ
 5SVvzf/ny6pM9Zx3fSIIhGcoM+4GACOsOCpRyXWtWjfpxUsHYW6//eltK/7uJ3qQeVRQyVTsG1t
 LqegwBa8AMrtP9Wg6W9FVeLRxCULKNuOP1Am+Af4O72aDMEIGr58BzUPRf7nRO5iDAeZTV2eyv4
 WPLIaJREPcmVucyMULd8XsFDZWG1KPqNXdL6eLhLu8WD7Vg+pk5JZ26Z+nsuZngvAc/vYT9qbke
 8J7p6yKNr1hJFAgL8rESUeY9a9eYMpQifMze7aAgyzci+DcFN1KzNqn4mVu9WhotJ9KDpXgo
X-Received: by 2002:a05:6512:2206:b0:5a2:7c1c:749 with SMTP id
 2adb3069b0e04-5a33758f4bemr304682e87.39.1775180343218; Thu, 02 Apr 2026
 18:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260401191617.20141-1-marex@nabladev.com>
In-Reply-To: <20260401191617.20141-1-marex@nabladev.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 2 Apr 2026 22:38:51 -0300
X-Gm-Features: AQROBzBCCobrMaKZt9a-p2SxeQZY1VFO76h0QP5kkeQpKtudVsVaQK3_dMUuZQ4
Message-ID: <CAOMZO5CjE4QPOw_5m49XRh+dRHhftv91GCJR4Ek6aPYkpoNLoA@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: imx8mp: Fold inline ECC into spl.c on DH
 i.MX8MP DHCOM SoM
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
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

On Wed, Apr 1, 2026 at 4:16=E2=80=AFPM Marek Vasut <marex@nabladev.com> wro=
te:
>
> The inline ECC configuration is identical for 2 GiB DRAM variants
> and 4 GiB DRAM variants of the SoM, no matter the rank count. Fold
> the ECC configuration directly into spl.c to simplify the upcoming
> deduplication. No functional change.
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Applied all, thanks.
