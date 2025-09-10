Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9A1CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 20:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B33A1831D5;
	Wed, 10 Sep 2025 22:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="QgwD3xx0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E30383236; Wed, 10 Sep 2025 22:14:38 +0200 (CEST)
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com
 [91.218.175.178])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ABC78319C
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 22:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1757535275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EIHi2yLlQln9x2oitwhOP5qmvpen/xQ0aS7pfcWCmZs=;
 b=QgwD3xx0pw7152vKgEwmdWt2L3dFW2v7OwhCBNNR9jD17n/2Vo1B5kMCqxxL9Znrl285if
 8OGeZL/hbSKleHzOXMjmZXFXNgHFrXhTU2RlAZWEdFcX/Ejtwywpnd6tfMT3bkedYxYZLg
 BVU9RAJHFMY38/bQDzkd7kcJUDOlBeavpXRoAYeDldFoCjJ6ph+xtutyhxlWyd8qRIUIk5
 +xDIx0AK4cEaZhsS+6d7R4KFapceutJfRuvXzxkfLJ5gxBsNJKdeovI9PnbeSXu0anU46G
 UcIdINqCt0IB7MThoZSt0cDPZgGwmunIfli2ctquJ46aOj5FuVzrX46ovmhuwQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Sep 2025 20:14:32 +0000
Message-Id: <DCPE9A29ADNG.5XDSJ73VEPCS@postmarketos.org>
Cc: "Jonas Karlman" <jonas@kwiboo.se>, "Simon Glass" <sjg@chromium.org>,
 <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <~postmarketos/upstreaming@lists.sr.ht>, "Tom Rini" <trini@konsulko.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Peng Fan"
 <peng.fan@nxp.com>, "Jaehoon Chung" <jh80.chung@samsung.com>, "Beniamino
 Galvani" <b.galvani@gmail.com>
Subject: Re: [PATCH RFC 4/9] serial: serial_meson: add minimal non-DM driver
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
To: "Heinrich Schuchardt" <heinrich.schuchardt@canonical.com>, "Ferass El
 Hafidi" <funderscore@postmarketos.org>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-4-37395d9ff5af@postmarketos.org>
 <829fe59a-10e5-4cd2-a032-d293d87f68d1@gmx.de>
In-Reply-To: <829fe59a-10e5-4cd2-a032-d293d87f68d1@gmx.de>
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

On Wed Sep 10, 2025 at 7:53 PM UTC, Heinrich Schuchardt wrote:
> <...>
>> +static int meson_serial_getc(void)
>> +{
>> +	struct meson_uart *const uart =3D (struct meson_uart *)CONFIG_VAL(DEBU=
G_UART_BASE);
>> +	uint32_t status =3D readl(&uart->status);
>> +
>> +	if (status & AML_UART_RX_EMPTY)
>> +		return -EAGAIN;
>> +
>> +	if (status & AML_UART_ERR) {
>> +		u32 val =3D readl(&uart->control);
>> +
>> +		/* Clear error */
>> +		val |=3D AML_UART_CLR_ERR;
>> +		writel(val, &uart->control);
>> +		val &=3D ~AML_UART_CLR_ERR;
>> +		writel(val, &uart->control);
>> +
>> +		/* Remove spurious byte from fifo */
>> +		readl(&uart->rfifo);
>> +		return -EIO;
>> +	}
>> +
>> +	return readl(&uart->rfifo) & 0xff;
>> +}
>> +
>> +static int meson_serial_tstc(void)
>> +{
>> +	struct meson_uart *const uart =3D (struct meson_uart *)CONFIG_VAL(DEBU=
G_UART_BASE);
>
> CONFIG_SPL_DEBUG_UART_BASE only exists for CONFIG_DEBUG_UART=3Dy and=20
> CONFIG_SPL=3Dy. Shall all configurations depend on CONFIG_DEBUG_UART=3Dy?
>
> Creating this dependency does not look right to me.
>

All Amlogic defconfigs have CONFIG_DEBUG_UART enabled, but I can remove
the dependency on CONFIG_DEBUG_UART_BASE if you think it doesn't look
right.

> Best regards
>
> Heinrich
>

Thanks.
