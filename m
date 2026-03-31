Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0CDFF60D5
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 19:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 939EB83E7A;
	Tue, 31 Mar 2026 21:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MHq0jVaJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53E0D84068; Tue, 31 Mar 2026 21:50:40 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61CF683AA9
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 21:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-661b16ac011so11510803a12.2
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 12:50:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774986638; cv=none;
 d=google.com; s=arc-20240605;
 b=AINABXUxghQ/c2mHb0HLJKRmPDT8zjXxpfw3atCcEOMvacC0UPOPmAhcHUXhxXTZRf
 5t0NbT/ncUqf4V6qOb0krMoui6es3piEwbj7kIwbsbaK+PBDpP82IEIJGLWjQPuxmnQ+
 IOTMXE2fW9coNISl5T8uxJIh6v+QHZXaywFA52cLpT5PhwDJAYoaUozpVZqxa7HWhWYp
 tO+03zVfDnDuQ0RH60XhtHi84M5SuVECMYCoOujy6wMyvo/gykAXkialRE67wPn8k1Xx
 6+g6spo50lAg6UdjVq0Qie4nGrhZTU5FM9rOfqZx5R9KmQMovfFLJy/NNptdv0jPoLj5
 mPkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8FUQxLPBAs8JGSzO/O25HC5NdTsYNcnr1iBdbfohA9M=;
 fh=DYstxKtlDD14uM5rS8H3CStGEqQbPmu7ddhD9xucVtA=;
 b=JkEqZ0HtH4of4Y7EYmKCyR11/mZ2AQL1uycbBAza4Tggd4AQSnBFWn/JsqvLHsp8+m
 zGXx6uABHyy9OuzgmFuWydw1VLvMJ0a12b80NLe0ym3MHa/434A0pdK2Ei8HS/fYpD9S
 2UrJhimW7XdqTVPGCe4VD9XmrSFL1v3YmxfrJJbqQ60OiPdcPxOmFQuGK7TJM41svR82
 +c47DPuTxwuQogW+xZmBx8ua+6/kLs6/SIuv26A9MDtOBa6nD5v0TP56cS7+0dn74kNN
 3g8wf/RYC871/11v1pyNaqWhR+FKhJjlGw9se3mul6ISjfdojZ6aSJ2vYY7C6/i4os1G
 ja6A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774986638; x=1775591438; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8FUQxLPBAs8JGSzO/O25HC5NdTsYNcnr1iBdbfohA9M=;
 b=MHq0jVaJNxkPluUpOq1HUxZOg6/NF0PT1CFqia+j8ePRwZmaGzreLl9MRmTqDFiot4
 LM4YvGtwIFliRy2trRNXF1/PimWbCTXyGaFvGgn9tdhSw6bKywQHV/taQtVi7gHxTE1Y
 iOtWE8Ssf2QW7CqaTi2Gm1DGhpsXWfg0S8cQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774986638; x=1775591438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8FUQxLPBAs8JGSzO/O25HC5NdTsYNcnr1iBdbfohA9M=;
 b=klQAimJtwzU1Nw0NHZVnwk/0IsTtyYXzOnMH4Y+UBj9FvxILZfwN7CJJvh8jCu8MO+
 Y6KeXFk0zJuljx5YU2xqhfGyK5YT89swL9IqKyutR1ndnw7F+T2LsjMc5kabymVGcFbj
 heWlW2zobz7UWBChph01VOa0KGt5oG7ecbxfAwG8/j5BbuwzxunD3MWj2g429AfLSBDw
 a7aPnfC3swiJ29MJN12c/fKbpFN2Wh81lWKmsplEkoSlmvs/6XHh5jMe2mHQTdy/DcFC
 b4MOmsgfuDi68DxRHW9YH+KYI5e4MIKtJ6XZc9m9N0b3/LpnwbDaBGQp3ax6xVrnASU/
 6QHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV42gBvpaN5YH/c1/WesjxXFJfUV9uyp8cH1U9vrJHBUkOTVEl+owFyE3SqAg8lvESZpZ5Du2E=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0zoxUK7TCRQG1qw7IK8Jcx9t90H4E/DOMZe2iWGfyXitCZBci
 NknTMiKlWB31rmw/ZEMquiqXnR/yj5UxZd3mGylNOoRu5jlWL7+HbmgH3uwkOP/xINXtXqKhP48
 gWllw2IZecZOzrW//6uWXQ1g0WDi9e8zvwa5X1xEg
X-Gm-Gg: ATEYQzw7/wEGn1DUSoIursTNCteJ3m3hoA+EKxYAYwMXuPx75hg8VmsvODXMKZPvhGW
 O0gS695ykL7DGszEWYACRKT01D9JEpWzFJs/YgwAAMSoTlUUanJ9NA5smfIfoyp3pJeYaQIi0xe
 I2cuDw0bTLYLxDA79oVN0htHzkFRCP+NJSbWvCnHfOur+9NI+/gvNzWrg9K3V2eQzu1cBlQ4xLp
 tL6OMRq8Qq4/ybJYKcfSy+4JxgzqS/TRhsR3gg5SKY8mv7wvKmQNcF31YW5G17pkTA+sFTNStTz
 75FOfw==
X-Received: by 2002:a17:907:cb24:b0:b97:a459:b66a with SMTP id
 a640c23a62f3a-b9c13aee75dmr48257166b.25.1774986637739; Tue, 31 Mar 2026
 12:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
 <20260330171419.1117817-7-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260330171419.1117817-7-aswin.murugan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 31 Mar 2026 15:50:26 -0400
X-Gm-Features: AQROBzCAV9SritE2NJiivq1amuPj2WNx02GuCxAmA47SS0D02WLDUJ5JkYD9bFo
Message-ID: <CAFLszTj+gKNQOjAawNeff2-+HpnE8Fn=-tXjXUjO1SONHycObA@mail.gmail.com>
Subject: Re: [v3,
 6/7] test: dm: add comprehensive tests for NVMEM bit field operations
To: aswin.murugan@oss.qualcomm.com
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, sjg@chromium.org, seanga2@gmail.com, 
 sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, gchan9527@gmail.com, 
 mkorpershoek@kernel.org, hs@nabladev.com, marek.vasut+renesas@mailbox.org, 
 msp@baylibre.com, dinesh.maniyam@altera.com, peng.fan@nxp.com, 
 quentin.schulz@cherry.de, kever.yang@rock-chips.com, 
 jamie.gibbons@microchip.com, justin@tidylabs.net, xypron.glpk@gmx.de, 
 n-francis@ti.com, h-vm@ti.com, ycliang@andestech.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
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

On 2026-03-30T17:14:12, Aswin Murugan <aswin.murugan@oss.qualcomm.com> wrote:
> diff --git a/test/dm/reboot-mode.c b/test/dm/reboot-mode.c
> @@ -15,6 +15,8 @@
> +#include <nvmem.h>
> +#include <misc.h>

These NVMEM bit field tests have nothing to do with the reboot-mode
tests in this file. How about a new file like nvmem.c ?

> diff --git a/test/dm/reboot-mode.c b/test/dm/reboot-mode.c
> @@ -66,3 +68,138 @@
> +static int nvmem_test_write_raw(struct udevice *dev, uint offset,
> +                             const void *buf, uint size)
> +{
> +     return misc_write(dev, offset, buf, size);
> +}
> +
> +static int nvmem_test_read_raw(struct udevice *dev, uint offset,
> +                            void *buf, uint size)
> +{
> +     return misc_read(dev, offset, buf, size);
> +}

The device is UCLASS_I2C_EEPROM but you are calling misc_read/write()
which call device_get_ops(dev) expecting UCLASS_MISC ops. This will
interpret the I2C EEPROM ops as misc_ops and likely crash or return
garbage. You could use i2c_eeprom_read/write() here instead.

> diff --git a/test/dm/reboot-mode.c b/test/dm/reboot-mode.c
> @@ -66,3 +68,138 @@
> +     /* Test reg = <0x18 0x4>; bits = <4 12>: Spanning byte boundary */
> +     cell.offset = 0x18;
> +     cell.size = 4;
> +     cell.bit_offset = 4;
> +     cell.nbits = 12;
> +     hw_value_u16 = 0x000F;
> +     ut_assertok(nvmem_test_write_raw(nvmem_dev, cell.offset, (u8 *)&hw_value_u16, 2));
> +     value = 0xFFF;
> +     ut_assertok(nvmem_cell_write(&cell, &value, sizeof(value)));
> +     ut_assertok(nvmem_test_read_raw(nvmem_dev, cell.offset, (u8 *)&hw_value_u16, 2));
> +     ut_asserteq(0xFFFF, hw_value_u16);

Lower-case hex

The cell has size 4 but the raw seed write and verification only touch
2 bytes, so the remaining 2 bytes of the cell are uninited

This test (and the 'upper 2 bytes' test below) should call
nvmem_cell_read() to check that the bit extraction path works for
multi-byte spanning fields.

> diff --git a/test/dm/reboot-mode.c b/test/dm/reboot-mode.c
> @@ -66,3 +68,138 @@
> +     /* Test bit field exceeding cell size */
> +     cell.nvmem = nvmem_dev;
> +     cell.offset = 0xd;
> +     cell.size = 1;
> +     cell.bit_offset = 0;
> +     cell.nbits = 9;
> +
> +     value = 0xFF;
> +     ret = nvmem_cell_write(&cell, &value, sizeof(value));
> +     ut_assert(ret < 0);

Please can you use ut_asserteq(-EINVAL, ret) so we know exactly what
error is used.

Also, the error cases only test the write path - can you add calls to
nvmem_cell_read() calls too?

Regards,
Simon
