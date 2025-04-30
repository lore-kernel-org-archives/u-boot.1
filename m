Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F01BC369DC
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 12:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95F938215E;
	Wed, 30 Apr 2025 14:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1746014891;
	bh=Zy94j+zmzfa6MutdlUK1tDrzPozoA8JpNLF93S8hjdw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CzYC3+OGjpThBlfwFA+xkb3ynXlvdeOhXZMUycgFBHfJUrTnvwQrsIhAsot7IA443
	 IkK5/N3Xq78QfWcbAHQaKW9Yk0i49ZCTRqd14FGaX/39ZbiUKxEyc7yWHHRiQB/69E
	 Z4Qb/XGMjUQTfr9Q2EL9mZoKFdq8gd2q9Q0TsQ02xCmgc2RBD3zZr0Ln55A+yDKsXC
	 p1tw5iqbWlki7BrFzYuKQHKyHMF0BmOkGOcbWe9dx8Uw2DsYfsxPdqFu0DBxDBa0oh
	 Qh0Nhtc7st079O7ItZK2GL4fhK0PZUOxOhaGaSOt5OmWHBSYBf0ZYOC5nRReLOQ6Cx
	 Berh80gPHJoCQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 785AA82B45; Wed, 30 Apr 2025 14:08:10 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D14482153
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 14:08:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4ZnbYK3DQVz9tnN;
 Wed, 30 Apr 2025 14:08:05 +0200 (CEST)
Message-ID: <04e853ce-d728-4a52-ba6a-690ded563a4b@denx.de>
Date: Wed, 30 Apr 2025 14:08:04 +0200
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

Reviewed-by: Stefan Roese <sr@denx.de>

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

