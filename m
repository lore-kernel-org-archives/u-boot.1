Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4439ECEACE4
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 23:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CB52841CD;
	Sat, 15 Nov 2025 00:02:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Wa/RP1fA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9076842A1; Sat, 15 Nov 2025 00:02:26 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E72D1841C9
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 00:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d7Xhv0PpBz9tQg;
 Sat, 15 Nov 2025 00:02:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763161343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XXOFOibIIDLrRk9aW6C1cUngFnC1kQ5j2/xmavy+m6s=;
 b=Wa/RP1fAmgaV7x71m1WtqMg2g8Helu7CaexiZ7kEp91qRZf6zpv2jsUe+ChcK4wdg2iK6l
 ypacMoe4nN3WZXL3ZJUtNbd659VSVu+ogvPXGcV2B39kUMQmCyCtqw/xqZxL1tY7Bm90mo
 inYUfejNj7OIIvRqq9+ddmq/xInMrWbJfub4dx+hnLDLCfnYbriumTrrFDSdD6txoJNXsx
 3R3SVY6ng9x/W5r8nDgOeco0b64HiuT9M6iTVCg7m4bOq/Y2nzmMyvzk2R2EYdStSzOfeA
 zqeYuoIBtzMn42fPJ1qFt8MNfFDXzDvzSnrdt0MCSXuWihlrhGP4S4JJ5DCRpQ==
Message-ID: <3a301812-1778-49d6-b244-dc3bf5ada265@mailbox.org>
Date: Sat, 15 Nov 2025 00:02:04 +0100
MIME-Version: 1.0
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH 1/1] usb: USB_EHCI_PCI depends on PCI && USB_EHCI_HCD
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Alice Guo
 <alice.guo@nxp.com>, u-boot@lists.denx.de
References: <20251114101952.79261-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
In-Reply-To: <20251114101952.79261-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 1a9db8e04eb55e714e0
X-MBO-RS-META: zzzggfrq6bn5od9sdqrgkicntkw57mi4
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

On 11/14/25 11:19 AM, Heinrich Schuchardt wrote:
> CONFIG_USB_EHCI_PCI cannot work without CONFIG_PCI.
> The detection of an EHCI PCI device fails without CONFIG_USB_EHCI_HCD.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   drivers/usb/host/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 427b62e934b..7282a34ff00 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -271,6 +271,7 @@ config USB_EHCI_MSM
>   
>   config USB_EHCI_PCI
>   	bool "Support for PCI-based EHCI USB controller"
> +	depends on PCI && USB_EHCI_HCD

Isn't this symbol already wrapped in 'if USB_EHCI_HCD' at line cca. 168 
? Does it have to be 'depends on PCI && USB_EHCI_HCD' here , or would 
'depends on PCI' be enough ?
