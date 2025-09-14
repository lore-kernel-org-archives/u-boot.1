Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B767CAC582
	for <u-boot@archiver.kernel.org>; Sun, 14 Sep 2025 12:24:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FF3180B9B;
	Sun, 14 Sep 2025 14:24:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="iEGR++Or";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03B5883071; Sun, 14 Sep 2025 14:24:05 +0200 (CEST)
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com
 [IPv6:2001:41d0:203:375::aa])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9798D80077
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 14:24:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1757852642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bbJb38WU3tO7kUGJwBpvRDPP1Fe4TJZcvMNUncxM2gU=;
 b=iEGR++OroNxaQYxbWB9OFCPCoX9OkzQzDnDGKNs1mexetml+pUXyxm8RwZyT6n91h0H6Ji
 2dqn8ohy441Nzjd20b2bam4l6ljat2SojA4bLudHUxr8XcFOR5hZWc2Xqisythym35S4R2
 NzvHXWfzC8718VvcGSCLF0ja4W9i6c3nVm4jVscEkrLzLjJpSE3Xm08xfosFJX8oz7YmC1
 7L3JXDjum2qzHhJJWZ6mbhfJvw99cqb19vaD8//WlcSKEH8O0AjMwgnlm2yZRYOH4+j7YL
 YlnA/LiXu/oBlEf78bWSTAo62Mnyv7VqBzcCRgSd/O0kGPxDVhM6+b98A/OHRw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Sep 2025 12:23:58 +0000
Message-Id: <DCSIR5UWG23F.17XD45AIS72TP@postmarketos.org>
To: "Simon Glass" <sjg@chromium.org>, "Ferass El Hafidi"
 <funderscore@postmarketos.org>
Cc: "Heinrich Schuchardt" <heinrich.schuchardt@canonical.com>, "Jonas
 Karlman" <jonas@kwiboo.se>, <u-boot@lists.denx.de>,
 <u-boot-amlogic@groups.io>, <~postmarketos/upstreaming@lists.sr.ht>, "Tom
 Rini" <trini@konsulko.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Peng Fan" <peng.fan@nxp.com>, "Jaehoon Chung" <jh80.chung@samsung.com>,
 "Beniamino Galvani" <b.galvani@gmail.com>
Subject: Re: [PATCH RFC 4/9] serial: serial_meson: add minimal non-DM driver
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-4-37395d9ff5af@postmarketos.org>
 <829fe59a-10e5-4cd2-a032-d293d87f68d1@gmx.de>
 <DCPE9A29ADNG.5XDSJ73VEPCS@postmarketos.org>
 <3875c210-7d29-4bca-b535-0522dc615cc8@canonical.com>
 <DCQ2ZF3T8VMM.1JN4QJ324NFM2@postmarketos.org>
 <CAFLszTjxY6c0unXvdcjC36hhpB-BwxM_FcgpRdkXBa+V3GynvQ@mail.gmail.com>
In-Reply-To: <CAFLszTjxY6c0unXvdcjC36hhpB-BwxM_FcgpRdkXBa+V3GynvQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
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

On Fri Sep 12, 2025 at 11:41 PM UTC, Simon Glass wrote:
> Hi Ferass,
>
> On Thu, 11 Sept 2025 at 09:37, Ferass El Hafidi
> <funderscore@postmarketos.org> wrote:
>>
>> On Wed Sep 10, 2025 at 8:30 PM UTC, Heinrich Schuchardt wrote:
>> > On 9/10/25 22:14, Ferass El Hafidi wrote:
>> >> On Wed Sep 10, 2025 at 7:53 PM UTC, Heinrich Schuchardt wrote:
>> >>> <...>
>> >>>> +static int meson_serial_getc(void)
>> >>>> +{
>> >>>> +  struct meson_uart *const uart =3D (struct meson_uart *)CONFIG_VA=
L(DEBUG_UART_BASE);
>> >>>> +  uint32_t status =3D readl(&uart->status);
>> >>>> +
>> >>>> +  if (status & AML_UART_RX_EMPTY)
>> >>>> +          return -EAGAIN;
>> >>>> +
>> >>>> +  if (status & AML_UART_ERR) {
>> >>>> +          u32 val =3D readl(&uart->control);
>> >>>> +
>> >>>> +          /* Clear error */
>> >>>> +          val |=3D AML_UART_CLR_ERR;
>> >>>> +          writel(val, &uart->control);
>> >>>> +          val &=3D ~AML_UART_CLR_ERR;
>> >>>> +          writel(val, &uart->control);
>> >>>> +
>> >>>> +          /* Remove spurious byte from fifo */
>> >>>> +          readl(&uart->rfifo);
>> >>>> +          return -EIO;
>> >>>> +  }
>> >>>> +
>> >>>> +  return readl(&uart->rfifo) & 0xff;
>> >>>> +}
>> >>>> +
>> >>>> +static int meson_serial_tstc(void)
>> >>>> +{
>> >>>> +  struct meson_uart *const uart =3D (struct meson_uart *)CONFIG_VA=
L(DEBUG_UART_BASE);
>> >>>
>> >>> CONFIG_SPL_DEBUG_UART_BASE only exists for CONFIG_DEBUG_UART=3Dy and
>> >>> CONFIG_SPL=3Dy. Shall all configurations depend on CONFIG_DEBUG_UART=
=3Dy?
>> >>>
>> >>> Creating this dependency does not look right to me.
>> >>>
>> >>
>> >> All Amlogic defconfigs have CONFIG_DEBUG_UART enabled, but I can remo=
ve
>> >> the dependency on CONFIG_DEBUG_UART_BASE if you think it doesn't look
>> >> right.
>> >
>> > We should avoid the possibility of build failures for changed configur=
ation.
>> >
>> > Will CONFIG_MESON_SERIAL depend on CONFIG_DEBUG_UART
>> > or will CONFIG_ARCH_MESON select CONFIG_DEBUG_UART?
>>
>> Then it might be best to not use DEBUG_UART_BASE.  I'll fix that for
>> next revision.  Thanks!
>
> I've been thinking about doing something about a minimal UART (and
> i2c) for a while.
>
> Before driver model we just called serial_putc() and *the* serial
> driver would handle it. Can we do something similar here?
>
> My suggestion for an API:
>
> CONFIG_SERIAL_ONE to indicate that driver model is not used for serial
>
> Then in serial-uclass.c update serial_putc() to use that config and
> call serial_one_putc(int ch), with that function being defined in the
> only serial driver that is compiled in. Update serial_init() to call
> serial_one_init().
>
> That way we keep things compatible with driver model and avoid
> building on the old serial.c
>
> This is similar to how the debug UART, but the debug UART is special.

Sounds good to me, I'm excited to see a very minimal serial driver API
that doesn't rely on the legacy API, while still being small enough for
SPL.

>
> Regards,
> Simon
