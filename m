Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AE7C0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 12:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48C5A81DB4;
	Tue, 28 Jan 2025 13:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738068965;
	bh=YjMlq7Ina5GBx771Kt5cKG4MTEhBit5ubdx89cT2cEQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZkZpfXMUWJ9K3GApV0sCWf0z/qns4sR62G5zOGsPqsnR1SqVsAZqpBDQoBvf9+jDS
	 ayYieHSSEmUDi8HFxEw99gMRBp7Q5QBhyZS8y/+VCl2qUpuTEB8ql0iaEKhsE3BL1i
	 L/SWn7HQA4SiDtGTBaaLjT/nIaN4AB+AF7PAlYBeltFKKUNzeCkDBv6GaaN5HApiTb
	 KkhwIY6JaIS5xGBvxcCTq22QZ4N7x0+7QQ7GwUCzHfGi3a0bVvjkTL36i0/HxrE2WH
	 MZE6sw1sqJQSII46WeWe7q3VnmN2i4EzsTHaFgbgXvt0CIkriADDBZXYqptDVWeMXU
	 YVaFd/KcggFZQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07C7481DCD; Tue, 28 Jan 2025 13:56:05 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11B6C81951
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 13:56:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4Yj4z46H6lz9t1K;
 Tue, 28 Jan 2025 13:56:00 +0100 (CET)
Message-ID: <98144645-8105-46b0-a9e3-b32625c34fe9@denx.de>
Date: Tue, 28 Jan 2025 13:55:59 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] configs: mvebu_espressobin_ultra-88f3720_defconfig:
 enable full bootflow functionality
To: bschnei@gmail.com
Cc: Ben Schneider <ben@bens.haus>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 u-boot@lists.denx.de
References: <20241206211015.9640-1-ben@bens.haus>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241206211015.9640-1-ben@bens.haus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Yj4z46H6lz9t1K
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

On 06.12.24 22:09, bschnei@gmail.com wrote:
> From: Ben Schneider <ben@bens.haus>
> 
> This appliance has multiple devices from which it can boot. Enable full
> bootflow functionality so users can choose a non-default boot device.
> 
> Signed-off-by: Ben Schneider <ben@bens.haus>

Applied to u-boot-marvell/master

Thanks,
Stefan

> ---
> 
>   configs/mvebu_espressobin_ultra-88f3720_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/mvebu_espressobin_ultra-88f3720_defconfig b/configs/mvebu_espressobin_ultra-88f3720_defconfig
> index aa9026acc3..6f1a66f5f1 100644
> --- a/configs/mvebu_espressobin_ultra-88f3720_defconfig
> +++ b/configs/mvebu_espressobin_ultra-88f3720_defconfig
> @@ -16,6 +16,7 @@ CONFIG_SYS_LOAD_ADDR=0x6000000
>   CONFIG_PCI=y
>   CONFIG_AHCI=y
>   # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_BOOTSTD_FULL=y
>   CONFIG_DISTRO_DEFAULTS=y
>   CONFIG_OF_BOARD_SETUP=y
>   CONFIG_USE_PREBOOT=y

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

