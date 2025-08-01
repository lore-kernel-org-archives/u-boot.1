Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3F4C87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 11:24:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78F9683A5C;
	Fri,  1 Aug 2025 13:24:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="mrgHkjZ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93C9E83A5D; Fri,  1 Aug 2025 13:24:26 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F616839F1
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 13:24:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-61568fbed16so1161698a12.3
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 04:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1754047464; x=1754652264;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mNjdXEr0c9V5RP/zYy+QySISgxCq/An+kOHLaA34DYE=;
 b=mrgHkjZ6Nhcjmhp9aS3bfnNJx+EuQ+r+h+4ST1iGZj/u0FsG8Iu5Gi0u4FulmslGTm
 jnGu0GN8CX3KSljB4LvhrD5eyH15nsJ5J6ur+WaYQ3OiYh2wQhsKlGmzZkaHYDRzabWA
 LieeELSGkZknbpZcuOTqK/bfJ1+DSykpeyVmIYY18GZ4CvxhuHENFpjyRVtMfEtMHZfO
 +gMFjooby0RiBCTTaFMWwN0SiQANraN/yB6LNC+nnNY2N+0q+uaIfIORJBOvi5zyftHf
 Mtsi8rdxpFq849Cc4AhQG2Ot2MKoLoh8kn9Ed3PcRqONIoo+aEtwHW5H9fAERWaSLc5K
 hIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754047464; x=1754652264;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mNjdXEr0c9V5RP/zYy+QySISgxCq/An+kOHLaA34DYE=;
 b=twNZhQeWB0iYPUZxe6DwHLYHXWgyG4YNFpcpbjc7QxeOGK4uv4VvnbcjyGbVWEx3fH
 3Vs0siPgeTKyI/ZH5ZwzjRMRClQ3TW/1ydCvA33A65WSk2rKAKMgpTUTcLFW1TZBXIf0
 SDs17Xus/u/PK0rXKvPx8Kjv14JOYETIrdt8/1du94PvycQpHe+FmSg0mQp60hJw171+
 PrlrZtHQOivJJCCf7ztLdofxksZerky+WqGjF6p74CBYpOYugMVrsP4VOF2sKsfeIeKB
 t3KF7AFPUFuHmIf2LIJBuSVjCDg86QxI1OHX2L6jOjX8ZczB7cqbV6xzRNgg4YRI1GfH
 fcZg==
X-Gm-Message-State: AOJu0YxMVUSEGUUIEpUuZ8G/p1TIkDxlN5K7aZ/Z3GUynSTv5sfDtpoK
 FeismbNmG0lLbZRRjq6fb/s0DVe6CTFJQ1TN3RS7MU/sZKI4vZ7aB8P0Xvw4CuJ4OAX6J/HhqYH
 RBsi1IPL6
X-Gm-Gg: ASbGncs1VB+c+iy/3wImARom5C29mHeZcYgv5azvKG7z6+ncT97LUtu4/TCWDrtWZSA
 svm+GcxWK6FVwAEDjk34hAi5UFVw9EPuZ7d2CavRYuLeY+mRigRbO1mn9RjaleRSeFkcdL+SVs4
 ERSe8OP1U++vb4z2hb9OMd7rfKf422YZrACIyuwmirQyNjPIjayIXAsREWHVr/yh3e9uTfd9Jad
 ykZjiX4bNnHKx4Up60LI5UhaZE/VyHGxbSBjEAlmOt+qQprmTGu27Yh1i/qUOeX5/6osbaejNPj
 i3F851UI3yrBhPXxLes76DDik0fCaTz53sZpCq6Vtedagu2u2F6Z7TeNUpBSmY0k/xcQTJJ/Bov
 Lv1LFuuWbbxcMRoBf7+t5ohU9Qo6xJ2HgjiY=
X-Google-Smtp-Source: AGHT+IGqBenNUTgp9tPOrRu2yKlfslyksLY1vj263sY+DSgQJfF1vxQ7wk0nSlMpYXzfTYg2lRPeVw==
X-Received: by 2002:a17:906:6a13:b0:ae3:63fd:c3af with SMTP id
 a640c23a62f3a-af8fd709493mr1324836566b.16.1754047463686; 
 Fri, 01 Aug 2025 04:24:23 -0700 (PDT)
Received: from [10.254.183.223] ([149.199.62.131])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-615a8ffbde5sm2588980a12.54.2025.08.01.04.24.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 04:24:23 -0700 (PDT)
Message-ID: <9bf5398d-0d2a-4ae6-8306-d3184857716f@monstr.eu>
Date: Fri, 1 Aug 2025 13:24:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] serial: uartlite: Use private data instead of platform
From: Michal Simek <monstr@monstr.eu>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>
References: <8d32af596f80a2220d9f5d7fb98476e6d2b5f303.1753261604.git.michal.simek@amd.com>
Content-Language: en-US
In-Reply-To: <8d32af596f80a2220d9f5d7fb98476e6d2b5f303.1753261604.git.michal.simek@amd.com>
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



On 7/23/25 11:06, Michal Simek wrote:
> plat data should be used only in probe or of_to_plat to fill it information
> from DT. Then in probe platform data should be stored in private structure
> which should be used by the other driver functions.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/serial/serial_xuartlite.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/serial/serial_xuartlite.c b/drivers/serial/serial_xuartlite.c
> index eb234108746d..00155aba5eb2 100644
> --- a/drivers/serial/serial_xuartlite.c
> +++ b/drivers/serial/serial_xuartlite.c
> @@ -35,6 +35,10 @@ struct uartlite_plat {
>   	struct uartlite *regs;
>   };
>   
> +struct uartlite_priv {
> +	struct uartlite *regs;
> +};
> +
>   static u32 uart_in32(void __iomem *addr)
>   {
>   	if (little_endian)
> @@ -53,8 +57,8 @@ static void uart_out32(void __iomem *addr, u32 val)
>   
>   static int uartlite_serial_putc(struct udevice *dev, const char ch)
>   {
> -	struct uartlite_plat *plat = dev_get_plat(dev);
> -	struct uartlite *regs = plat->regs;
> +	struct uartlite_priv *priv = dev_get_priv(dev);
> +	struct uartlite *regs = priv->regs;
>   
>   	if (uart_in32(&regs->status) & SR_TX_FIFO_FULL)
>   		return -EAGAIN;
> @@ -66,8 +70,8 @@ static int uartlite_serial_putc(struct udevice *dev, const char ch)
>   
>   static int uartlite_serial_getc(struct udevice *dev)
>   {
> -	struct uartlite_plat *plat = dev_get_plat(dev);
> -	struct uartlite *regs = plat->regs;
> +	struct uartlite_priv *priv = dev_get_priv(dev);
> +	struct uartlite *regs = priv->regs;
>   
>   	if (!(uart_in32(&regs->status) & SR_RX_FIFO_VALID_DATA))
>   		return -EAGAIN;
> @@ -77,8 +81,8 @@ static int uartlite_serial_getc(struct udevice *dev)
>   
>   static int uartlite_serial_pending(struct udevice *dev, bool input)
>   {
> -	struct uartlite_plat *plat = dev_get_plat(dev);
> -	struct uartlite *regs = plat->regs;
> +	struct uartlite_priv *priv = dev_get_priv(dev);
> +	struct uartlite *regs = priv->regs;
>   
>   	if (input)
>   		return uart_in32(&regs->status) & SR_RX_FIFO_VALID_DATA;
> @@ -89,9 +93,12 @@ static int uartlite_serial_pending(struct udevice *dev, bool input)
>   static int uartlite_serial_probe(struct udevice *dev)
>   {
>   	struct uartlite_plat *plat = dev_get_plat(dev);
> +	struct uartlite_priv *priv = dev_get_priv(dev);
>   	struct uartlite *regs = plat->regs;
>   	int ret;
>   
> +	priv->regs = regs;
> +
>   	uart_out32(&regs->control, 0);
>   	uart_out32(&regs->control, ULITE_CONTROL_RST_RX | ULITE_CONTROL_RST_TX);
>   	ret = uart_in32(&regs->status);
> @@ -131,6 +138,7 @@ U_BOOT_DRIVER(serial_uartlite) = {
>   	.id	= UCLASS_SERIAL,
>   	.of_match = uartlite_serial_ids,
>   	.of_to_plat = uartlite_serial_of_to_plat,
> +	.priv_auto	= sizeof(struct uartlite_priv),
>   	.plat_auto	= sizeof(struct uartlite_plat),
>   	.probe = uartlite_serial_probe,
>   	.ops	= &uartlite_serial_ops,

Applied both.
M
-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

