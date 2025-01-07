Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794FEE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 11:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D759D801E8;
	Tue,  7 Jan 2025 12:30:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736249448;
	bh=iNTAjq6dtWsDa1S0w7f7485tWfKSuICyBEVGZqtDXDI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fooPfpEHNiGmp0pYgU9d4yMsMXL2ZhD9blF2UHX3tolga+ybccrf5ZZr3G3voOC7K
	 kBHRyx2mCLg/FL9BjDZQ1BL7svVG4DT7LaXzxcONlStlWs5ncHZnqeeMNnXTQQt8Yr
	 50FgvVwyIIG7Ocml+hSISI1qSOzUCUYvUdAZPykt1EIU/RSAJGkb4F83Wzkstz8Ay2
	 IQKCQKuZlZOQ2mMzlZMYvmO6q/azRmB8Yj/y1OAYgEO6FffHNacevL7EIh0DSwv/n9
	 zPngCQXvx+u6S5Xg6Weh9bCHABuKHI7lD3tJ+85I9ZZRyYvYZUegC5t2cfuW+tr5EZ
	 qo34xetnXAk6g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5FC0801FD; Tue,  7 Jan 2025 12:30:47 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFDF8801B6
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 12:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4YS84K3wlzz9sSb;
 Tue,  7 Jan 2025 12:30:41 +0100 (CET)
Message-ID: <0f39cd7a-c64c-45b6-9e69-4612b884c15f@denx.de>
Date: Tue, 7 Jan 2025 12:30:40 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] serial: ns16550: Add Intel XScale support
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Tom Rini <trini@konsulko.com>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht,
 u-boot@lists.denx.de
References: <20241231-coreprimevelte-v2-0-6a5445d92d11@skole.hr>
 <20241231-coreprimevelte-v2-1-6a5445d92d11@skole.hr>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241231-coreprimevelte-v2-1-6a5445d92d11@skole.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4YS84K3wlzz9sSb
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

On 31.12.24 17:49, Duje Mihanović wrote:
> Add compatible string for the Intel XScale variant of the 16550. Needed
> to match upstream.
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
>
> ---
>   drivers/serial/ns16550.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
> index 3f6860f39162df74c3d1f03d3f9aa90090216646..eab193395087877d2a8da38e1b4daabf46e81f2f 100644
> --- a/drivers/serial/ns16550.c
> +++ b/drivers/serial/ns16550.c
> @@ -614,6 +614,7 @@ static const struct udevice_id ns16550_serial_ids[] = {
>   	{ .compatible = "ingenic,jz4780-uart",	.data = PORT_JZ4780  },
>   	{ .compatible = "nvidia,tegra20-uart",	.data = PORT_NS16550 },
>   	{ .compatible = "snps,dw-apb-uart",	.data = PORT_NS16550 },
> +	{ .compatible = "intel,xscale-uart",	.data = PORT_NS16550 },

Looking at the Linux 8250 of_device_id struct I see this entry:

	{ .compatible = "mrvl,mmp-uart",
		.data = (void *)PORT_XSCALE, },

Wouldn't it make more sense to use this compatible property instead?

Thanks,
Stefan

