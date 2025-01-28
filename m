Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CD1C0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 08:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF8F081BC0;
	Tue, 28 Jan 2025 09:07:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738051633;
	bh=JaWsgqgzYwvK78CBlh3f8gjTA86cW5Lt9Bl04IPkDKk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o0NlXkpVusBv9MkNb9jrSAQjFdnpy1bOlsn0PE0E2tMtBMkE0FeIVt4sSQZrdWAeJ
	 u/RzMd22FNjos0TIWP8XAGuz6HwBqoTIIBZ38MOYA5eAIqYuEDimF0vknZjjX6E/Wj
	 Ar3Hv34CrDPl4Gi/sWkBD25FhN+Hl0K6nyuv2nvcnp8WTr00QT+uu13IKjWTKYgv9S
	 TcCTYmj5TDmDURRohghhq/e6rJw0guNxuD2wp1zzNiFwLB3ubxZIaS1oUkfARyDkRS
	 oMnctBmpFPizWqkXXmwMzbRAV4R7sshx6eLjNPd4uMakDA7ku3H1+p1GKXd4cDj3th
	 Ke1jCBEPUzyNw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A004281C84; Tue, 28 Jan 2025 09:07:11 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B30FF81B4B
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 09:07:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4YhyYl3Dmqz9sTV;
 Tue, 28 Jan 2025 09:07:07 +0100 (CET)
Message-ID: <0473a22d-db9c-4616-9f0b-ab8e261398e4@denx.de>
Date: Tue, 28 Jan 2025 09:07:06 +0100
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

Reviewed-by: Stefan Roese <sr@denx.de>

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

