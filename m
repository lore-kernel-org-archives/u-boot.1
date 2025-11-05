Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68971CCFA0D
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 12:38:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ED8383A1B;
	Wed,  5 Nov 2025 13:38:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eKPtlpIK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA9F283A28; Wed,  5 Nov 2025 13:38:02 +0100 (CET)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C8CD839FA
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 13:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-63f74b43db8so6811598d50.3
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 04:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762346279; x=1762951079; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/KSYT7ssBDFtI+nLUFevPNm9yyzHdhAT7pmcjUYnfyM=;
 b=eKPtlpIKK9aTO7Rdzhq0d8YqMRWjlQefUaZlKApUQt76hnMda42NlA55f/L1khU34Q
 KfwN/zWWRtzTdxxwehHgcl7F/1yNlOGWyZ4OqPLeNMISB9xTWFBp1I/h2+ddExpOSQmA
 +4fTf/8XscivwWr7ifhcGR45L2r6Nz6s1qg44qZZlNzKTmwEljeHnuta3Ya3uMhax+sf
 JXIrKwJQ/R4MQ2UtSzo/iPxA2+iZNXiS6kP3uUtGz4+KA9jIRVDVM8gCnvVyaYWDTXZb
 KHFcaY8wj/K+cB82auR+JVbZURq20hXBEJ9vWLb3vQH0cWmJRjIaTQx5xKei5oTj+w74
 jIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762346279; x=1762951079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/KSYT7ssBDFtI+nLUFevPNm9yyzHdhAT7pmcjUYnfyM=;
 b=YYWj/M6dlPO4vjD3FjNT4Ah4OkQs1f/8TsI2ph27lTwDT53/cSURvgkbS2eMFoyRJC
 nejSpYaz2YIHJIlupSe93d5IwsjGz8jLMUHg2uE0nf0Ganhb6ZTYqo3+pkHqNWeQ5PEk
 sIDtrMYfpuGfKxhck0JwvJmi4KTUxmkA1GFKRF3F9I7fVoXPMtKrodGi3u5u6NpWYbPg
 54bPelNWEjxI2D0K9SCPev9etIFK3RzMHnXG1CoTpd/SmBsfgaM+qBh5h4TR8jFUpbLW
 AvWRiKSI83b2DH2vA1H9rpKfdNW6gOLv9CqsTTjNZCZAHDthWZ8xU05L0FJ5JVZtycvv
 Virw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoxhY4Hd4Czi4aTAzTywHQStiogn/gsTUssgOFWkadBXXBlf79uCD+Ck4/ScMWowBEajbM5N0=@lists.denx.de
X-Gm-Message-State: AOJu0YxSF8osqhTnKj2FL29WGy64ZegcY7tzP1pvjXLyegzwzAND6PPi
 96cO3/5g4gXI7DCdblF10+dbh/DKuQB0YuqwtUYMU6amCbcDhmQCDVqYeJo2teGqjA1WYMwtbO0
 Req9jFXdMCTPmGu/+9DuPvDsCXahrY7U=
X-Gm-Gg: ASbGncuyXOYZZTtaSE/vLH3ETldh9I/ZHEpi9C9HVech+s+zIY17p8eIUHB6prTLhFk
 EvlPe4k7HRQDeTqQTGUpD32wkKtINOrwWP6C0zvoRgKSgf2zPaVEv+zCDEH4g3gOSWxuRV+ulji
 e5gyXMbW1sSWDazpD4gTNvjP6YCoQhdKD2GO4VVUamWL2TB9FZBxuhWapYAUAS97t1oWe4fRLDY
 Z604h1Hqj8ogZNz1G06xN25IcPUkQhCQ0hZ+y/t9IOqQYUkwzroPdT4JQLaUFfnRfGZ2tf9uA==
X-Google-Smtp-Source: AGHT+IH/ei1OEqmuh2x9EdAImJD5nGtKH5YMci46mt4VvcQj8BrUhoBIo45L/0FCGgV9v8K5Nwz3jCEew6O34Ce7+a8=
X-Received: by 2002:a05:690e:1597:20b0:63f:a6da:4b38 with SMTP id
 956f58d0204a3-63fd34b3f63mr2143280d50.5.1762346279417; Wed, 05 Nov 2025
 04:37:59 -0800 (PST)
MIME-Version: 1.0
References: <20251105122426.59479-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251105122426.59479-1-heinrich.schuchardt@canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 5 Nov 2025 20:37:47 +0800
X-Gm-Features: AWmQ_bm6bqgL5BkUH15sncRFgDxiYRusKltpYmfcaJh4cC31d3iY8Yq72VIFuWQ
Message-ID: <CAEUhbmUip+1EefA10YBCH2Gu6yqqZhKZsh9eqMBBoHsRs-uZQQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] efi_driver: don't leak name in
 efi_bl_create_block_device()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
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

On Wed, Nov 5, 2025 at 8:24=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> blk_create_devicef() uses a copy of parameter name.
> We can use a local variable.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         use local variable
> ---
>  lib/efi_driver/efi_block_device.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
