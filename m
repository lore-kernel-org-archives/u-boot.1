Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80A0CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 20:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3DA183253;
	Wed, 10 Sep 2025 22:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RvOquAq+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D14883253; Wed, 10 Sep 2025 22:30:53 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D75E8319C
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 22:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9DE5E46632
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 20:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1757536250;
 bh=WWtJEueR8toJzVWql32mzVcG/XLTCSyDwFAanKV5stM=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=RvOquAq+XUIwz2Vy+UXFE0nJptOu6VdFAAyhedGK5h7xcKuQVDrTv9MvTdFpodpn/
 b4hkY3Hok9vA+G+2vsHY3bgMZu1yQkX0rLBssz1/mJStx4mZMBq80z1AogmOUGHkYr
 dDXdBKYeb+j6G/GIvCXWSGA8QP6YpK72EaNO4F7nsYZ8opSrs9DblJPJX21rJRnJFD
 WWNIyPPfOOITTCs7BgIUv1nYEFAnolP1fewuAjm0oxkzg0bG1r+pQupBa9bMIjINRi
 STny4Y5KyqRcBAFCgNkkpDdc9Qv9oMN0f/m+aF6MhcmTvVFt6BCgTbz2HVniDioE/g
 SPs5QsZO/60Ow==
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b042b53f542so566304166b.3
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 13:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757536250; x=1758141050;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WWtJEueR8toJzVWql32mzVcG/XLTCSyDwFAanKV5stM=;
 b=bDJrDYd7Ncyn09kURdc6bEMwbu6RJlU16DZDWpZqW1+pyZLxJ2nEVZQdPF9mc8FBHU
 rPyB6snu2wZ9YVHvPgpxhrfGhLOGI8BaXFrgxi95XR7mG6k6IqrYyc13/tj5sCZo8Apy
 y5bvBY/680f/fsc2aKT+ISSzKOjlHZQxp23zPLCg/GFMJXDejeD8cG/mlXVp2EiYCwBi
 fGOUOjuDlNXwjZla6sz4MauAqrMXsV5q6lNO89rg6JzAiAtnKQFkcdNb1CXkVoT4+kpH
 9kyuLBZoDrOw8D/chwevZDbg0c8KMrieZ4Xb84Lh6r15VumN2iRAvQV77G/I+hIvnsVE
 +5Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAdAdJxKKqLRX7yb2rqb4UGIZdLLkkhz7U3kBJp6kqThwqetV+nDLx+vLsWPfxAdfo7OzvlZs=@lists.denx.de
X-Gm-Message-State: AOJu0YyzEtDMY6Vd3i6RO1Tz0SAFm59thXX8Li+RQtNEoxfLRO6n/rJC
 H6dizNV52GAeLZEVbyMJnWn77LQehbTuX7Kk5OIc+rOgUkxIMmCcHSXFkFA8vH7OhYLUSVDpEfc
 2M0GGUFdqgyfC43GrqsKEVpePULOlnLwZMPKdbiea3/v6GFIK8QZWFtZSPRYQ7sEIPkmVE4E=
X-Gm-Gg: ASbGnctHa2wbmlRNTZaiY4B2PRvCGUQN1GMbkCvVfT+uXRbCunsWmsmWxZs+HmZzEVL
 B98qQBujJR83o9GWei1uf0EollPizULrWZNqnKBleknLRglx34rOKS9BtCyI/71m8NSYaj1TIR3
 b/vKCngwyxfqTWfsNqzWRUwYBza7pX5JgbTkMV+AHwRWfJBri0Vs/GwCxD+IEo7aS7PlbFTLfBx
 ZAY88JLIPz/OTu4C1NwC2ww/f0RmGDfYThAFtjEFb2j5dYNoh0v1Ugkr/rS6ShAZFApRSHUBH+0
 7mBLWDwauHWCMoxMbEAZNFsVutw/mjs1hJ8em89H1b+RSa8A8GiWG8hzZfb4EuqRnd6qNv7DWNj
 rQyL/UIfCmtvTkmnhaqpy73X9pv+o/GAdxB1Bag==
X-Received: by 2002:a17:907:c24:b0:afe:cded:bf96 with SMTP id
 a640c23a62f3a-b04b1459092mr1503430766b.6.1757536249998; 
 Wed, 10 Sep 2025 13:30:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzVNkc0ArbU5OHdk4zS4dfA9ywnKE1HaGII+qKISdGrRW0AcFuNb0RtUE39/joSb+vVf7G/g==
X-Received: by 2002:a17:907:c24:b0:afe:cded:bf96 with SMTP id
 a640c23a62f3a-b04b1459092mr1503428866b.6.1757536249557; 
 Wed, 10 Sep 2025 13:30:49 -0700 (PDT)
Received: from [192.168.103.116]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b07830ab7e2sm229528466b.34.2025.09.10.13.30.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Sep 2025 13:30:48 -0700 (PDT)
Message-ID: <3875c210-7d29-4bca-b535-0522dc615cc8@canonical.com>
Date: Wed, 10 Sep 2025 22:30:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/9] serial: serial_meson: add minimal non-DM driver
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-4-37395d9ff5af@postmarketos.org>
 <829fe59a-10e5-4cd2-a032-d293d87f68d1@gmx.de>
 <DCPE9A29ADNG.5XDSJ73VEPCS@postmarketos.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <DCPE9A29ADNG.5XDSJ73VEPCS@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/10/25 22:14, Ferass El Hafidi wrote:
> On Wed Sep 10, 2025 at 7:53 PM UTC, Heinrich Schuchardt wrote:
>> <...>
>>> +static int meson_serial_getc(void)
>>> +{
>>> +	struct meson_uart *const uart = (struct meson_uart *)CONFIG_VAL(DEBUG_UART_BASE);
>>> +	uint32_t status = readl(&uart->status);
>>> +
>>> +	if (status & AML_UART_RX_EMPTY)
>>> +		return -EAGAIN;
>>> +
>>> +	if (status & AML_UART_ERR) {
>>> +		u32 val = readl(&uart->control);
>>> +
>>> +		/* Clear error */
>>> +		val |= AML_UART_CLR_ERR;
>>> +		writel(val, &uart->control);
>>> +		val &= ~AML_UART_CLR_ERR;
>>> +		writel(val, &uart->control);
>>> +
>>> +		/* Remove spurious byte from fifo */
>>> +		readl(&uart->rfifo);
>>> +		return -EIO;
>>> +	}
>>> +
>>> +	return readl(&uart->rfifo) & 0xff;
>>> +}
>>> +
>>> +static int meson_serial_tstc(void)
>>> +{
>>> +	struct meson_uart *const uart = (struct meson_uart *)CONFIG_VAL(DEBUG_UART_BASE);
>>
>> CONFIG_SPL_DEBUG_UART_BASE only exists for CONFIG_DEBUG_UART=y and
>> CONFIG_SPL=y. Shall all configurations depend on CONFIG_DEBUG_UART=y?
>>
>> Creating this dependency does not look right to me.
>>
> 
> All Amlogic defconfigs have CONFIG_DEBUG_UART enabled, but I can remove
> the dependency on CONFIG_DEBUG_UART_BASE if you think it doesn't look
> right.

We should avoid the possibility of build failures for changed configuration.

Will CONFIG_MESON_SERIAL depend on CONFIG_DEBUG_UART
or will CONFIG_ARCH_MESON select CONFIG_DEBUG_UART?

Best regards

Heinrich
