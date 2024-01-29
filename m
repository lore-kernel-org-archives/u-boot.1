Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996B0C47422
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 13:30:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A098587BDB;
	Mon, 29 Jan 2024 14:30:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EOVBYn/Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20DFD87BDB; Mon, 29 Jan 2024 14:30:44 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 075BA8798B
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 14:30:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-dc22ade26d8so2278463276.1
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 05:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1706535041; x=1707139841;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5bhBbomiJXz2hVO1BcM+CRcdMMS9XLDrgOh9ZfQ2yD4=;
 b=EOVBYn/QQ9ypq3yRZ+utzMm/CXhDMPjvher+Jq7zG2XqjekJGa8Oeax3QEaiaHUJJA
 3D8wnvcyO7hdbv59Py+4Z5TktTiGjUCKWZvXXCpR6EFPz1mbJNL/gz4dY9GVZiCQn4LD
 2r1fLzhzX9GCizDa7+xBiGVGyBLhW/8NylD1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706535041; x=1707139841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5bhBbomiJXz2hVO1BcM+CRcdMMS9XLDrgOh9ZfQ2yD4=;
 b=tUMcJjse32tf23ljtXozuFtEqH2MylRbChwWsH2YWec6AzGbjRvb2mNji2QwdZwSM6
 dmR7z7+R9PoRuVryuorSONdAUf9y7cQgfXIYKF7ZGzVVAg8et0ia6TsR+J4aexD6fqvk
 Io5c92KUXAErV1HINgsND5NdHyR5IpsnPXt2MGtNLExq46xnOlJUsgDRzviRn1+4NcGb
 qZHsLzCeO/sP8hQVMKaWwMGoHiG7kR5mwoyhMqOLYYC5zr7BltWHa/xMxDTccJne5duU
 8Zcswu6rTOjOowAgCs44KDgqt+6tRwvjK0k53bREmIDu3GoDJX4AwjrOxrolwckdpwuD
 TCdA==
X-Gm-Message-State: AOJu0Yzu/NhR+zM72KHjVuiuZ7Dd/uDBwYCTYH9xnq6s81X2bpfI3Lxb
 OqTk6fpWk1tJ9Q4FyoIzY5OvaQtNwMEdAGn003ryNheiHpM6c6tJWDgy7Ck3qZ3Yk27jQEJiZk4
 1g7OwRrjj6rfwHqt3WXE/ZO+yC9tuxaTbkXBKpg==
X-Google-Smtp-Source: AGHT+IGnsw/esIc7lV412VfrNKJf4zOWTQ1DDFF+4+ySeEil/hWdnsRTOhLh6TihUOBZ2rnetOMtzGfbqabeIOCI4gI=
X-Received: by 2002:a5b:dcf:0:b0:dc6:4b5a:410a with SMTP id
 t15-20020a5b0dcf000000b00dc64b5a410amr2491517ybr.12.1706535040671; Mon, 29
 Jan 2024 05:30:40 -0800 (PST)
MIME-Version: 1.0
References: <20240128155458.56712-1-marek.vasut+renesas@mailbox.org>
 <20240128155458.56712-7-marek.vasut+renesas@mailbox.org>
 <CAMty3ZA7sEks59cdQhHCZR+R8fSxHdAtgHUupem=X61KDUALSA@mail.gmail.com>
 <aa6740c9-4568-4469-9790-635d68a08473@mailbox.org>
In-Reply-To: <aa6740c9-4568-4469-9790-635d68a08473@mailbox.org>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 29 Jan 2024 19:00:29 +0530
Message-ID: <CAMty3ZBBcwt8Ur9v2pyojioJQVXc+m9+NG9z08DOTEMQqFzX5Q@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] mtd: spi: renesas: Add R8A779H0 V4M support
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Hai Pham <hai.pham.ud@renesas.com>, Paul Barker <paul.barker.ct@bp.renesas.com>
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

On Mon, Jan 29, 2024 at 6:57=E2=80=AFPM Marek Vasut <marek.vasut@mailbox.or=
g> wrote:
>
> On 1/29/24 12:52, Jagan Teki wrote:
> > On Sun, Jan 28, 2024 at 9:25=E2=80=AFPM Marek Vasut
> > <marek.vasut+renesas@mailbox.org> wrote:
> >>
> >> From: Hai Pham <hai.pham.ud@renesas.com>
> >>
> >> Support RPC SPI on R8A779H0 V4M SoC.
> >>
> >> Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> >> Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
> >> ---
> >> Cc: Jagan Teki <jagan@amarulasolutions.com>
> >> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> >> ---
> >
> > Applied to u-boot-spi/master
>
> I don't think this will build without 06/11 macro addition, so I'll pull
> this via u-boot-sh tree if that's OK with you ?
>
> I could use a RB though .

Yeah. Got the runner failure. Please proceed to pick this vi -sh

Thanks,
Jagan.
