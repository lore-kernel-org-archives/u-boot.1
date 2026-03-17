Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A765FB5EAF
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 05:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A3F68407D;
	Tue, 17 Mar 2026 06:07:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="RcwlPD/4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oSvdAOPX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2DE48401A; Tue, 17 Mar 2026 06:07:17 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D25998405A
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 06:07:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fZg1b4KpXz9tvd;
 Tue, 17 Mar 2026 06:07:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773724035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DGdCp0rQs1OwwcsmCewJgkIPUCam9GqZcHzQQJH2bl8=;
 b=RcwlPD/4qJePinLQqB8vXznPrprfiPnDu6dB/nQzSjeaALTtpXyrnp7KMw4Z4TuQPGi5UX
 D6whkXx0jAcWJIC75uvhHnM8AGZHz//MbA3OlB3REMxATQ7poSN3W+g0DbixaPF6yjpy0u
 8EZS4x80VZTZIx+KGdP+H/kHjsgp3lEsmSN5V+exbFcp9fm0DDS0qMv/pzapYnxdhLgYtH
 hTi2riaSg0puxH06MJX/TTmgKf3Q6PpDNOUWeX5iRp3KzB9wXyRI4OdytYdiy8E02MCWct
 DIdVHThJSop2x6rsP0vXul7N9oHChD4YxcZxtgLj/26u7yLO71hWMSasv1Yugg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=oSvdAOPX;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <ed88ec35-7d53-48df-a65b-7da1298e265b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773724034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DGdCp0rQs1OwwcsmCewJgkIPUCam9GqZcHzQQJH2bl8=;
 b=oSvdAOPXvlM3QSek88F8n16O2dNjkcYvigzBJnI2Njv1ks8wzdRh5RSv0mTrGGawo6LicE
 FYK63bTLjLJAs6cUpQLERkssbPz1SOh67nWmBb7Q4Nt8qNjG+fx7KX/CLXMHl5WrDe929E
 E4vQfG9GD8vn5ChtAAUYxTGyx8XenkkrGsI9F6NaOfCMueA0C2uRzPSxi8ubthkXICxy/o
 SVnW65gyvVepIBxjUqRlPEVXUuWpPW24MCOp84IFRGyc1ISk2uxA9Raiow8fQ+vDZjqOZo
 +q++41oDfALsbFTWn5nfnAnJXXmT6pmKGXA59+J1uOxGkhTT8LhOmRtiOYshQA==
Date: Tue, 17 Mar 2026 03:33:57 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] reset: Correct dependencies for RESET_RZG2L_USBPHY_CTRL
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260317012443.4162600-1-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260317012443.4162600-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: be0fe9826742d2f2596
X-MBO-RS-META: buy33d9k9ume3oa34mdswbs5km4mozap
X-Rspamd-Queue-Id: 4fZg1b4KpXz9tvd
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

On 3/17/26 2:24 AM, Tom Rini wrote:
> As exposed by "make randconfig", we have an issue with the dependencies
> for RESET_RZG2L_USBPHY_CTRL. As REGULATOR_RZG2L_USBPHY depends on
> DM_REGULATOR this symbol must also depend on it as well.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
>   drivers/reset/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 66911199c8ba..3f0ec50510c0 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -239,7 +239,7 @@ config RESET_AT91
>   
>   config RESET_RZG2L_USBPHY_CTRL
>   	bool "Enable support for Renesas RZ/G2L USB 2.0 PHY control"
> -	depends on DM_RESET
> +	depends on DM_RESET && DM_REGULATOR
>   	select REGULATOR_RZG2L_USBPHY
But this already selects REGULATOR_RZG2L_USBPHY , which according to 
drivers/power/regulator/Kconfig contains:

508 config REGULATOR_RZG2L_USBPHY
509         bool "Enable driver for RZ/G2L USB PHY VBUS supply"
510         depends on DM_REGULATOR

which does depend on DM_REGULATOR transitively ?
