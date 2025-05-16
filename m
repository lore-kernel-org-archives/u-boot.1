Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A01C3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 11:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6430680079;
	Fri, 16 May 2025 13:40:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1747395623;
	bh=SzxvDLTCjwqQGrVvepIxytnKWaT+w7p5RzNMuuybWkk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P0ySeLFk3MXBpgx+JXK6WAeM7KMwLeCzjRke11DpTRhZz93OJSvRFRaedNHgZR+M6
	 8MDKGAxMlRd9h2K8b4s4fv8+a6TsqbbnSuhYm45ci3r43tLS5AoxiEGfmOMESKibW5
	 NIFj8pjRd82hBZgN2JvNvdqr2SRr3r97hlHPOhvcpso4xeL1JyyYMobL09890yxJAf
	 FWXJDEDm0WYFJJv5R5MvgfwyvVVFJ1k9uTAYnRHGC7ccB+8B//QXFPq+pxuBROXb7R
	 z613/3JRweCU724iJQ5r2+gt3OMzd4RFwmA61YdkYZCwCnNOOpZX1VtzSB2UGmg2g8
	 9jGU9E4R743vQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99CA78288D; Fri, 16 May 2025 13:40:22 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D62708006D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 13:40:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4ZzQ9t5D3gz9tR5;
 Fri, 16 May 2025 13:40:18 +0200 (CEST)
Message-ID: <2838a2e4-21d5-4ae0-a1e4-8d88c64121fc@denx.de>
Date: Fri, 16 May 2025 13:40:17 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] configs: mvebu_espressobin_ultra-88f3720_defconfig:
 enable hwrng
To: Benjamin Schneider <bschnei@gmail.com>
Cc: Benjamin Schneider <ben@bens.haus>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 u-boot@lists.denx.de
References: <20250417193841.106509-1-ben@bens.haus>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250417193841.106509-1-ben@bens.haus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 17.04.25 21:37, Benjamin Schneider wrote:
> This device has a hardware random number generator. Linux can
> use this feature to randomize the location of the kernel in
> memory for better security. However, that functionality is only
> available if the bootloader firmware provides it. Enable support
> for it in the default configuration for this device.
> 
> Signed-off-by: Benjamin Schneider <ben@bens.haus>

Applied to u-boot-marvell/master

Thanks,
Stefan

> ---
> 
>   configs/mvebu_espressobin_ultra-88f3720_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/configs/mvebu_espressobin_ultra-88f3720_defconfig b/configs/mvebu_espressobin_ultra-88f3720_defconfig
> index 1cbeee8fcb7..fb8efbdf0b9 100644
> --- a/configs/mvebu_espressobin_ultra-88f3720_defconfig
> +++ b/configs/mvebu_espressobin_ultra-88f3720_defconfig
> @@ -97,3 +97,5 @@ CONFIG_USB_EHCI_HCD=y
>   # CONFIG_WATCHDOG_AUTOSTART is not set
>   CONFIG_WDT=y
>   CONFIG_WDT_ARMADA_37XX=y
> +CONFIG_DM_RNG=y
> +CONFIG_RNG_TURRIS_RWTM=y

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

