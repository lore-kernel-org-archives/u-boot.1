Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0EDCCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 13:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DD1483971;
	Mon,  3 Nov 2025 14:21:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QxKUqgdX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64826838AE; Mon,  3 Nov 2025 10:51:46 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4273283642
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 10:51:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-475dc6029b6so37355475e9.0
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 01:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762163504; x=1762768304; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Mb/aTVBihR0SVnND2H4pqleb6SPzIzGmlS1xW4GSyM=;
 b=QxKUqgdXgTr2M5cZ3/dkBQOAhjfnQeiqobOSNJqxx5KZvJKV6ntPYku+wHWgzWSgZT
 5K0tcAtJ82i+yCo4LEiokGqhS+EpJuYGPXmi00CiaIzP6ixFFybVWfURYrO6qzdi/lsh
 4UPa0ncKkztE9E9iiBobiRsdLt69fgvPj6NWdXuAuH47m8jAv+WpO2iN7TdskWcXb24/
 OZy8Ig64z7UHCLAw4/noPc4jiJarA2hKV3GqO7cYPDCzsiSenmM1ZW/EjVAMXDps3trD
 +gdsMoB41Dkr+3FqX8d/xU3YqvyAKEsEXsKk+T+GxLxXeX2naLotJV8IEoLXf9QJS0xh
 350w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762163504; x=1762768304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Mb/aTVBihR0SVnND2H4pqleb6SPzIzGmlS1xW4GSyM=;
 b=DBr/yssc0N2mTXUp3XxfsKGNT+NNrM38TNn8AFoKFW5lx2uWVCRAEJZt4uWyQyNR3z
 14JHEA8h/TyGAXzobtrm3M3XIZbYDPhVjv93oFk6cKjdt/xePw/+6jYpv5xId4XT+NAW
 pKmlUe+evvLtcnA0IcHQGe9wMvDfnSyFBUteuxekWPp99iQUY7gE4C++tLH+QWO6jwSV
 atE4itcSHfVXpRK3s5FwJszCpgdzx4wcey/gAO0aUHI8XE0tUqZtoSpqK15TrnK7Cil2
 ybKAbDQpZZBXEOMXBTi9O84TBBJd4gjAAVIFdNSf65fjdNHAKY3PpxA8ES6PCUxZz6Yz
 YKMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrf2d9zBNuDiUQcP4k66B8OHdB6bICeVVoHXnJmFLzvNT9yHTSRm8/R/uZl+hJChJgzGVY0tw=@lists.denx.de
X-Gm-Message-State: AOJu0Yxu52Fo2aJmenm8CMjNBzgfn/3Sb6nrsvOvCQR2+fS+5gDOwEtD
 DgKYgwHp5zbcCRVO/Kj0kQbi2hd3++HqRttV2/a7KIlADkbiF0ShT2nW/sEZp4aMHXd4Uzzw1qN
 QXrmxfD4rk2730GqxkGEzJX7cro8aWW4=
X-Gm-Gg: ASbGncubbIGwMTxzPW8PQzhiztnvVv+7vT+OPzXefl9ZN7cLK4ircLCSGe2zEfyFmzu
 p3P7lyemFJJdjVbH/UJtiYyUBXjT48sr1OkUUinvescFGNt7QG7k3qA9fC47AFFD8Q4fEOUqeiV
 W8tQLgk4HmChm0Dzsq3FzPNoVXx1JfBbAXBemcq46lF7GAtVrhqmatzmuBHfjGTHO3Dlcfm6Vey
 Yav63zPhqtok9VX3kQHzkCK/oG1uloJ6qhATbA1LAR/b5weZEzXQ3QjYhJOqu+XXIeaZeawFA==
X-Google-Smtp-Source: AGHT+IEaCt4EHjIYmCNV87/5/ZikyPKZ/ng2NAf2VNpJ4HQid+1gdXddjF72NGjwo8QJV67+MpHAwyx0aNXluC7ECtc=
X-Received: by 2002:a05:600c:1553:b0:471:16e5:6d7a with SMTP id
 5b1f17b1804b1-477307ba7d2mr101001325e9.13.1762163503444; Mon, 03 Nov 2025
 01:51:43 -0800 (PST)
MIME-Version: 1.0
References: <20251031195253.621971-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251031195253.621971-1-heinrich.schuchardt@canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 3 Nov 2025 17:51:26 +0800
X-Gm-Features: AWmQ_blINMWqT98T3rwAQRH3kK4sgIKDl5U0nTNqisPmuW2y0ZbeL-SqVyFpzIE
Message-ID: <CAEUhbmVofTR7Ng8v-rb33TTGwnU5oQFuz5ZLKB8QjQThhR6h5w@mail.gmail.com>
Subject: Re: [PATCH 1/1] acpi: use U-Boot ACPI vendor ID
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Matthias Brugger <mbrugger@suse.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 03 Nov 2025 14:21:42 +0100
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

On Sat, Nov 1, 2025 at 3:53=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The U-Boot project has been assigned the vendor ID 'UBOO' [1]. Use this
> vendor ID and our release version in the ACPI table headers.
>
> [1] ACPI ID Registry
>     https://uefi.org/ACPI_ID_List
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/x86/lib/acpi_nhlt.c  |  2 +-
>  arch/x86/lib/acpi_table.c |  2 +-
>  include/acpi/acpi_table.h | 20 +++++++++++---
>  lib/acpi/acpi_table.c     |  6 ++---
>  test/dm/acpi.c            | 55 +++++++++++++++++++++++----------------
>  5 files changed, 54 insertions(+), 31 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
