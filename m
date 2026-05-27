Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAD8CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 04:39:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26B99846AA;
	Wed, 27 May 2026 06:39:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O1Ioy2aJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C303846D1; Wed, 27 May 2026 06:39:13 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BBF3846AA
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 06:39:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bd85ebb368fso1663560666b.1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 21:39:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779856751; cv=none;
 d=google.com; s=arc-20240605;
 b=Km+QMWrUu+2eZ81AjUr6EE9QwfiqSm4sL0vK7hhApJgYdg+1rjs1y6jU0J1JdXKgBL
 Xdf3LIJSWn0oAgaYYe+lW7EeVCbByEkOAYkLDiSBT0yCrtAe50qBK4a4slwtpXlywF4I
 r3rv/F2JkFIhUhKeYPoQWoQRZHnY+2fHbhtphrEwhF189wXSGzjCj/Ltte46Si/Likfe
 ScjJ8dfKa8NdM97BmfTJ+qzrP9AcrI+9ZCTwaICadXZbBRSFIcYg1wyPGG0EBIuXgWXg
 vw68HJDOSfwR/REE/a+1ek5ocWMpH3L67cC0HjgoMLnRFFvs9pMLeajl/yGIYEMzGwvm
 asxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AWvg5evFWttoqu/NWmNSTDEy1L/On6aCfF/JeENHer8=;
 fh=nqXbri/t605KwzaYj6FnepUyH8OpYdQ47z347Vj1Qjo=;
 b=PRQ4I6IK8lm9OycDzX3CFoo3KmwQZJ1w8Fw5Lzr7zereKOBv1ddh6795i0ZA+bxg7S
 G0oeuGUa+5IKPLiZFY8Qlw/nqlGQd49E2eDYI53zvFvgRFdNL4QhsvRMQ7rUWULgK4G0
 jWRjOiy6pC9i+eI+5HlvQbJCrJPPdGz3U8HCCT7HvxlT9JrbDuahGDIggjfuugZKS2N9
 5rgZZ1jxX5cOcqVc3gzbvK7RjvzHwTKeP4s5/dLE04QvV2ePWZZnY1N/y5CQve0JIyzj
 XRJ58i8mWFyypYiVqu9KaHuR3FqKD0d9DZKY/Ixn/4tttjUyB4Wn3OIfTNDB4ZwGPa2J
 ZKsQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779856751; x=1780461551; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWvg5evFWttoqu/NWmNSTDEy1L/On6aCfF/JeENHer8=;
 b=O1Ioy2aJ5qcIKFqCGXFejK/i0hPc5z7qo4b3zd/JTzBM2xrUCv1gEdDHmhM5cQosfG
 TGXNEMLsWkvJqAa+YR59StI+X+JN4STX7pzy4V6lXEnC2/URp6yFLB0/xBYs3QFEG7OF
 0YPh1NHOlKSPvUJxQIX7NLp0DwuSs3C0jxOgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779856751; x=1780461551;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AWvg5evFWttoqu/NWmNSTDEy1L/On6aCfF/JeENHer8=;
 b=GL3kCyzEqPH6hv1aTpJ/FSxO7QZ53ADIlQ5Sn5qAxz4ucKA1OyW2GSb7fzSGOr4au1
 9Ntp4++DEgxBwWFMx24f9NIKDXjMa5altKFMf+EUTtZyrSXitwyuWoNZqckOiwJeoTXp
 TvF3mFLKVEz6I8z31d3POEycnm0bI0b5mDsLtVZijEFgR2dPFUC5qW1Hze11942bwAqz
 S634Uvlr0MYFHm6njmyd8cFqxHYljrHmwAsskEGNTKJbYNjH9HRSaiL6P/UACBwqdFkA
 FG/wsTHyOmQrMLtd6QSOvdlVYBwoBlbfksrekJ7WC7TFx09yAl9XvOIjZQFQG53ZaPPI
 8JUw==
X-Gm-Message-State: AOJu0Yzu1CRK+JWglBXu+JVBA5jVo9K0CeZP+GcbY/qnHyPny37CPpD4
 MahNixjpuBs2W8RhN25OwEa1CxzOE0vgDXEgoCNIuhwAjAdC4B9z+R4pZkU11V1WpAAPm1VH0zi
 jRHOdSF1eRmQrsfhXySu3Pj6vcHX0y6tuzCvTJ8xO
X-Gm-Gg: Acq92OE1wK+Q2hVlwmZ3jZaoQsIJaAnn9apatGSCuQPk39PgTsT4Vucocg4UW42TuPi
 Ohtb8kr54CQ+bKTkba/PjCJE+U2lHU2zfVuoCX8dD/2Yg4UbNJi8SNZq1UpAAA5YB2VzSYcI2Af
 C9cj/KZMJ/q1FywViEcqOwirb2t+LLun4UZo/OOkF5mQ7duo8dkbsm63OpIcAZ/L//XxWIYq+SM
 6RdGqZa/BYkmH9OJ2D0zDBFH3v4KWaaR6IljV5yecX3K7BuYFCjJne/rXFdMKO/j/mqNiVDZC2i
 fezAXA==
X-Received: by 2002:a17:907:2675:b0:bd3:66e:e4f6 with SMTP id
 a640c23a62f3a-bdd238ed554mr1000364366b.20.1779856750847; Tue, 26 May 2026
 21:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
 <20260213112717.1256823-3-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260213112717.1256823-3-aswin.murugan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 23:38:57 -0500
X-Gm-Features: AVHnY4JdjR7RUdvVxTfrUxoFUXAc8gG6cjLSbFsPr0voGhPEIFGPBiMqXZYRHcE
Message-ID: <CAFLszThT2zwgqAVv86DmyqK+hs6weA=3Ykv=y4+8WBZ34RJbPQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] misc: Add support for bit fields in NVMEM cells
To: aswin.murugan@oss.qualcomm.com
Cc: u-boot@lists.denx.de, sumit.garg@kernel.org, casey.connolly@linaro.org, 
 u-boot-qcom@groups.io, seanga2@gmail.com, trini@konsulko.com, 
 marek.vasut+renesas@mailbox.org, neil.armstrong@linaro.org, peng.fan@nxp.com, 
 quentin.schulz@cherry.de, n-francis@ti.com, xypron.glpk@gmx.de, h-vm@ti.com, 
 justin@tidylabs.net, jamie.gibbons@microchip.com, ycliang@andestech.com, 
 me@samcday.com, sughosh.ganu@arm.com, gchan9527@gmail.com, 
 ilias.apalodimas@linaro.org
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

Hi Aswin,

On 2026-02-13T11:27:11, Aswin Murugan <aswin.murugan@oss.qualcomm.com> wrot=
e:
> misc: Add support for bit fields in NVMEM cells
>
> NVMEM cells currently only support byte-level access. Many hardware
> registers pack multiple fields into single bytes, requiring bit-level
> granularity. For example, Qualcomm PMIC PON registers store a 7-bit
> reboot reason field within a single byte, with bit 0 reserved for other
> purposes.
>
> Add support for the optional 'bits' property in NVMEM cell device tree
> bindings. This property specifies <bit_offset num_bits> to define a bit
> field within the cell's register space.
>
> Implement multi-byte bit field support by porting bit manipulation
> algorithms from the Linux kernel driver [1]:
>
> 1. nvmem_shift_read_buffer_in_place() - Extract bit fields from raw
>    bytes by shifting and masking across byte boundaries. Handles fields
>    that span multiple bytes.
>
> 2. nvmem_cell_prepare_write_buffer() - Perform Read-Modify-Write to
> [...]
>
> drivers/misc/nvmem.c | 241 ++++++++++++++++++++++++++++++++++++++++++++++=
++---
>  include/nvmem.h      |   4 +
>  2 files changed, 231 insertions(+), 14 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/include/nvmem.h b/include/nvmem.h
> @@ -26,11 +26,15 @@
>   * @nvmem: The backing storage device
>   * @offset: The offset of the cell from the start of @nvmem
>   * @size: The size of the cell, in bytes
> + * @bit_offset: Bit offset within the cell (0 for byte-level access)
> + * @nbits: Number of bits to use (0 for byte-level access)
>   */

The note on @bit_offset is misleading =E2=80=94 a valid bit-field can have
bit_offset =3D=3D 0. It's nbits =3D=3D 0 alone that selects byte-level acce=
ss.
Please reword.

> diff --git a/drivers/misc/nvmem.c b/drivers/misc/nvmem.c
> @@ -121,13 +320,27 @@ int nvmem_cell_get_by_index(struct udevice *dev, in=
t index,
> +     ret =3D ofnode_read_u32_index(args.node, 'bits', 0, &cell->bit_offs=
et);
> +     if (ret) {
> +             cell->bit_offset =3D 0;
> +             cell->nbits =3D 0;
> +     } else {
> +             ret =3D ofnode_read_u32_index(args.node, 'bits', 1, &cell->=
nbits);
> +             if (ret)
> +                     return -EINVAL;
> +
> +             if (cell->bit_offset + cell->nbits > cell->size * 8)
> +                     return -EINVAL;
> +     }

The binding requires nbits >=3D 1 when 'bits' is present, but this
accepts nbits =3D=3D 0 (silently falling back to byte mode and confusing
the read/write paths). Please also reject bit_offset >=3D 8 - the
binding caps it at 0..7. Better to complain about malformed DT than to
silently accept it.

Regards,
Simon
