Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9574BD111A8
	for <u-boot@archiver.kernel.org>; Sun, 30 Nov 2025 05:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA2DA8382A;
	Sun, 30 Nov 2025 06:01:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="L4W9zDwt";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eXdQiPyK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F22D783106; Sun, 30 Nov 2025 06:01:14 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0746983015
 for <u-boot@lists.denx.de>; Sun, 30 Nov 2025 06:01:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dJvxz4Db6z9scY;
 Sun, 30 Nov 2025 06:01:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764478871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4jaWNx1vaFhUwNGWKw1jOMHQCcO2S5WHtYOYZsMj3zA=;
 b=L4W9zDwt7K4q9bDGAUcYwpyqmukHJoP7N4nzO4LhodTDu4aRaczYSsSf6I+ErsQuXj6QLh
 isupRbKr7LY35+jnRhYa9fcrnMtDZYmhaCiiJhs0BveWXKSD2+yPGQbptA8IY+La6pyfoK
 MjZbSD52iwst5KEeNciyf/7TcgskNPJ3IKJyhycRfsHHt5NsWYtrnqEiW50SazgG+lmRWi
 YJTARNVud2JjwSRsNxMBypytOA2DoF9GbQp8If5lEscRyBYETLzUh8uClUXOHajF5gTIXX
 hfoUbw+euWEkqTc3shC2uTweNodx+J8AQ1Iz5jtJxfnvhni1AVj9ulNZWv7Szg==
Message-ID: <a016c693-071e-47f2-b5a8-f03ccaa7a7f9@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764478869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4jaWNx1vaFhUwNGWKw1jOMHQCcO2S5WHtYOYZsMj3zA=;
 b=eXdQiPyKG6vJtGzOjydE2XNYCCaSD9dJk1A1AkINxd5S+4qVrss2jQR5U1NT/cbArsNGgX
 lwKThetUUdlQi1Zks9tIqkUd3kYbuHKzZ1mFKVXAG+Gtwa8nCLY9vPQdcVJHtowVLY872q
 /6UqXckQdsAP/A/+CLa1whdVe0hb06SJMzg1gVufiHl1BLkMe+d78BzzBiBX+7gAHjPEs7
 emw9bRrp+bM1zMG0au4/TfO/3EOomVRUyyhbIICX7od3y6/2BLijUG/FM1GccghueyRi8L
 QFy5680PhA9V1t7lEXzniwUCkiskgJic44VnRFkHNnWxfzSV05oQSh9fFQ4rOQ==
Date: Sun, 30 Nov 2025 02:05:05 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/4] ehci-mx6: Add powerup_fixup implementation
To: alice.guo@oss.nxp.com, u-boot@lists.denx.de,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marex@denx.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Stefano Babic <sbabic@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 David Zang <davidzangcs@gmail.com>, Alice Guo <alice.guo@nxp.com>
References: <20251128-usb2-v1-0-25ec5ac127ff@nxp.com>
 <20251128-usb2-v1-1-25ec5ac127ff@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251128-usb2-v1-1-25ec5ac127ff@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 057ac75191f974a2941
X-MBO-RS-META: nimpcbwjf6fof6mebs6dfndat1w7iqtz
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

On 11/28/25 2:16 PM, alice.guo@oss.nxp.com wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> When doing port reset, the PR bit of PORTSC1 will be automatically
> cleared by our IP, but standard EHCI needs explicit clear by software.
> The EHCI-HCD driver follow the EHCI specification, so after 50ms wait,
> it clear the PR bit by writting to the PORTSC1 register with value
> loaded before setting PR.
> 
> This sequence is ok for our IP when the delay time is exact. But when
> the timer is slower

How can the timer be slower ? Maybe there is some bug somewhere else ?

> , some bits like PE, PSPD have been set by controller
> automatically after the PR is automatically cleared. So the writing to
> the PORTSC1 will overwrite these bits set by controller. And eventually
> the driver gets wrong status.
> 
> We implement the powerup_fixup operation which delays 50ms and will
> check the PR until it is cleared by controller. And will update the reg
> value which is written to PORTSC register by EHCI-HCD driver. This is
> much safer than depending on the delay time to be accurate and aligining
> with controller's behaiver.
> 
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>   drivers/usb/host/ehci-mx6.c | 28 +++++++++++++++++++++++++++-
>   1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
> index 25907f22612..0b3f1b69657 100644
> --- a/drivers/usb/host/ehci-mx6.c
> +++ b/drivers/usb/host/ehci-mx6.c
> @@ -265,6 +265,25 @@ int usb_phy_mode(int port)
>   }
>   #endif
>   
> +static void ehci_mx6_powerup_fixup(struct ehci_ctrl *ctrl, uint32_t *status_reg,
> +				   uint32_t *reg)
> +{
> +	u32 result;
> +	int usec = 2000;
> +
> +	mdelay(50);
> +
> +	do {
> +		result = ehci_readl(status_reg);
> +		udelay(5);
> +		if (!(result & EHCI_PS_PR))
> +			break;
> +		usec--;
> +	} while (usec > 0);
> +
> +	*reg = ehci_readl(status_reg);
> +}
Can't the core EHCI code simply check whether PR is cleared already and 
skip updating PORTSC if it is instead ?
