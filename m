Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CAFC0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 08:02:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3574C819B1;
	Tue, 28 Jan 2025 09:02:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738051362;
	bh=RMAiLyVzCuYqtVR9OaWmIuinCWEC3UwYmvWxnI2TACQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S6haVDYkZq9FMwwfnabGu5+pD2R7r2tY8++HNSKCi+kmuWIfmPESyb+kRo8e3a54y
	 0kypu6YW2RJfzz4B4f0KcrPMH7B4Rib9JoesNE2Iuz2SsDpLGlzL7+utwKD3ULgKAo
	 QhYcDgy8LV/zYzSCejmK+GE8OPA8yRcQ+ekAPVLWK4IKztiO0fWHIDBPSmblPtaWBs
	 zC8N+Rzp1cPgyzZq3rhtiyvMOAkoJZHr607Ukio0OMFAyLMVkVjya4uN1qVt1KJwrZ
	 Lxb7q7SezQNWgei1YnR2pKFOtgThw+PCxUsmqqCKKLBmJpUIQdwYe/krcnsVOi/rH+
	 GbdB+s0sH2KzQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 117A481B4B; Tue, 28 Jan 2025 09:02:41 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DA5F8197D
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 09:02:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4YhySX6SFCz9sSX;
 Tue, 28 Jan 2025 09:02:36 +0100 (CET)
Message-ID: <25ad954d-6471-4847-947b-836c4f68a51e@denx.de>
Date: Tue, 28 Jan 2025 09:02:35 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/3] serial: ns16550: Add Intel XScale support
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Tom Rini <trini@konsulko.com>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht,
 u-boot@lists.denx.de
References: <20250124-coreprimevelte-v3-0-870dd251b1d1@skole.hr>
 <20250124-coreprimevelte-v3-1-870dd251b1d1@skole.hr>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250124-coreprimevelte-v3-1-870dd251b1d1@skole.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4YhySX6SFCz9sSX
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

On 24.01.25 16:47, Duje Mihanović wrote:
> Add compatible string for the Intel XScale variant of the 16550. Needed
> to match upstream.
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   drivers/serial/ns16550.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
> index 039da835f5f6cdd30080bd16e0b0da7be1619171..0e267d097c53524e63145747db619266984950d8 100644
> --- a/drivers/serial/ns16550.c
> +++ b/drivers/serial/ns16550.c
> @@ -605,6 +605,7 @@ static const struct udevice_id ns16550_serial_ids[] = {
>   	{ .compatible = "ingenic,jz4780-uart",	.data = PORT_JZ4780  },
>   	{ .compatible = "nvidia,tegra20-uart",	.data = PORT_NS16550 },
>   	{ .compatible = "snps,dw-apb-uart",	.data = PORT_NS16550 },
> +	{ .compatible = "intel,xscale-uart",	.data = PORT_NS16550 },
>   	{}
>   };
>   #endif /* OF_REAL */
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

