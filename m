Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB46D6AB16
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 21:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92B23839DF;
	Thu,  2 Apr 2026 23:02:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eH5eK/6J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FC6283D8A; Thu,  2 Apr 2026 23:02:53 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1533780212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 23:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b9c3a9fe80fso167706966b.3
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 14:02:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775163770; cv=none;
 d=google.com; s=arc-20240605;
 b=OJ4z6JdykrK4F9l+hOckm9iQmeMVUQ21dHCg4cU1sgOw1p817EIzLneTSlGSSuTNws
 6PqrjNQt0jWfPnh8naok/CJp34v5WK0H5DrD42B0PefKqCgeMlhr1cQwdo9Gaavj0hrh
 tMBsb7FA4H6DPCXo5Y84sc9B8Y2ZNXZO8vyBgtstVnvoUSU6FcMp5162raLw3TS3nX0z
 v0P0RyrcAI7slXIzEhnJLXtGIAJ9crOdKuaZ0B5jyhGgJtqHqP5NVhz2LmWB19J0dAFd
 bLHzgXguZWFbMfRCYhg3BiddIGoEve+d/8KFeayftZB2DDiVXURNfeeQbglW0sGM67RR
 539g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wkPR6nDmi7kkqZbr/RmciiSqUb3HBt7kfi+TO2VRX7A=;
 fh=Mz5s5K59ndiEsTzp70nmcZ5z7uPKj3RlsrKeilXMiyI=;
 b=ZxO/qU/C9kxUAWzLr6r/sqTEC4m0UhBfxk+Hm4xFlec9EgzP5qzxFEYMsIXPaqkSDq
 a2HNq3nkK5TGiNMtu7cB40FeqVPmbbuOeJPOne896Q0sXqYwvsqoG92rT2VSse8kMxze
 lV+QlqF+P8AfHE2VPn6D6SSKuubymF1RScE+d/hNU3ExcEjVzb4r+/JvNzI0HRnffmke
 BuwtpBRPJKjuJMI2pIo4bHRGcd8i8rzL2aTSauNHIAAfGqkIRso8cfvGMXV0f7NWevM/
 m0yzo1c8HYSfgjraNdt7X38WfiPT2Ozyzgmzbb6nOYxF9X6rbuK73tVKKqs6dPVl33lU
 FJng==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775163770; x=1775768570; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wkPR6nDmi7kkqZbr/RmciiSqUb3HBt7kfi+TO2VRX7A=;
 b=eH5eK/6JESShSJ4pzzNpuQzICNRco7KO1n7A5boOFlmF3aVJj6DaUAW3qhq5zOvLGz
 3ht2egYvGXxs7jRiTiwJ5vutasbDwQm1UyiBK1F7z7+miW3tscjSGKztlE4Gd5dKkC+j
 tdrWn6PL0Q8m58H4UGoF5/ZFD9p4EO85qSaoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775163770; x=1775768570;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wkPR6nDmi7kkqZbr/RmciiSqUb3HBt7kfi+TO2VRX7A=;
 b=VUSkgeguns9VFY2cazq/p9Kz+l6LtjpK83XRnO03n6ouPiNyMHcETAnqbx9xa9yBRc
 3fcTX3NUqmDrdhrTLfwPniQoIGmZ2OZVQ0zlE4LtUdZ3QUGBwlSd6wwqOmybk1UP3He0
 aPnHj8z7MMs4xZlLuWOPeDcrN+smbvC035+LOrXmxjqi+UAB5eTCMrmovzri3twEvli4
 P1j+h46tpVU4SrQ5StSQBA4tlO7l/Jpz6SmXDXi+fJ+JuRGgWeg/ek+LZmsKlSKLBkqN
 74HL84F9Eip6+OdW84rhPynAzXHjCpphwNi+wcZ7vpqCZmwTpZIA7BB7QEVUXc6IkjoO
 lz/Q==
X-Gm-Message-State: AOJu0YxaNqRm/v/LZHR4Ec4NnGtuwfEaaetgCl2sSaa7lt5ZWoSjsY/O
 OXDsHFG8qy6hYdjuZNIPMxPFvmD/5XTR5weEWJerw96GNsYebgoIv544JXdzBU1zyO6M7BgjIAI
 nu1KEDYJPg6q8A8sSfk2gqzqCwnU0lT+UdGAMT2QH
X-Gm-Gg: ATEYQzw0wFjheMTrY9HuiDENdiT00aXjrsZm4qZhBXfy36qlNy01WRo0/+t6gAIDaBd
 tVgINKRE4ODXp0qfm4fuz2vC5UIst1y7IVzbJmHr/lzpEvK0f1pczXATzOvWKk2BF7kuIg0UxUq
 2BU/66I2U2eww5bgeO6WuprkwBi3qsYu9s6GpEBRywS6z7W/XJDyJo/+YafODNWdNFrDxeNmsde
 HonAerRch39wIYszaHBJX17zfeEeGdrCa7c4mqkdPsnx/EVjK6fSO2hk67sVgTDeUZkQzMiXDmS
 +rV4Sw==
X-Received: by 2002:a17:907:d07:b0:b9b:fa57:d5b0 with SMTP id
 a640c23a62f3a-b9c679f4ae8mr17216966b.43.1775163770397; Thu, 02 Apr 2026
 14:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260324-boot-fit-fix-8-byte-alignement-for-overlays-v1-1-257b132b6bda@baylibre.com>
In-Reply-To: <20260324-boot-fit-fix-8-byte-alignement-for-overlays-v1-1-257b132b6bda@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Apr 2026 15:02:37 -0600
X-Gm-Features: AQROBzAX4T1oEd0TW0TwW9TDVjb-zBQFnJy1chdw_2ywmqRDGHLqA1fBlcit2fI
Message-ID: <CAFLszTjWKDezUj5Lq-UfGBLmV+0=hFHANit6-cMDTCSEm7ni+g@mail.gmail.com>
Subject: Re: [PATCH] boot/fit: remove useless else branch
To: jstephan@baylibre.com
Cc: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 David Lechner <dlechner@baylibre.com>
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

Hi Julien,

On 2026-03-24T15:33:45, Julien Stephan <jstephan@baylibre.com> wrote:
> boot/fit: remove useless else branch
>
> The assignment of load =3D data is already performed before the
> if=E2=80=93elseif logic, making the additional assignment in the else
> branch unnecessary.
>
> Remove the redundant statement to simplify
> the control flow and improve readability.
>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -2281,8 +2281,6 @@ int fit_image_load(struct bootm_headers *images, ul=
ong addr,
> -     } else {
> -             load =3D data;    /* No load address specified */
>       }

This else branch is not redundant. When fit_image_get_load() succeeds,
it writes to load, so load contains the value from the FIT image, not
data.

The else branch is reached when load_op =3D=3D FIT_LOAD_OPTIONAL_NON_ZERO
and !load - here the code intentionally resets load back to data,
meaning 'ignore a zero load address and load in place instead'.

With your patch, load would remain 0, causing problems in the caller
(e.g. the check at line 2316 would see load !=3D data and attempt to
memcpy() to address 0).

The comment "No load address specified" is misleading since we only
reach this branch when the load address WAS specified but was zero. If
you want to clean this up, please update the comment!

It also makes me wonder if we are lacking a test in this area.

Regards,
Simon
