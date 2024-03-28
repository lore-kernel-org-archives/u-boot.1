Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D8BC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 09:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43FFB8808F;
	Thu, 28 Mar 2024 10:53:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711619591;
	bh=u32ax55InuGdp3rOpaQMxbK4/thi18db3EOjv+X60jI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hvyK6YPMZCSjC5neT5Lv90Ns3PQShxghTCDLcRLSixHD5vRcDfiRpbXkWccvE4tQd
	 STUXCa09LUdZp7DvEMsjrqM2tFJghdAULgMK64XefCum0y6fP2C/cE/+H15tP8E2AQ
	 e8lS0+dmdb8eA1s71Si7VQqc7KEEotXPokBKm51HhvZX6L6+uZq5F6OFlmz3XGAXaQ
	 TBpQGwaY3qATT45lrqRi/VriUPchCpV31uEErjloFj21pqzGwPcFWSDQaBKYRC+f0s
	 SNXSESekrU3NJWJAouTC8Lz0OXxf+yz9Ryq8kh2agL8mO59kXWOiWPrj/eVuKhLT8r
	 MBB1xKHc8zyMQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5A72880C5; Thu, 28 Mar 2024 10:53:10 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68D6187FAC
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:53:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4V4zPG2V76z9sNw;
 Thu, 28 Mar 2024 10:53:06 +0100 (CET)
Message-ID: <041a6b8d-536e-4dea-b51c-1e22014b8f74@denx.de>
Date: Thu, 28 Mar 2024 10:53:05 +0100
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-mvebu v3 01/18] arm: mvebu: turris_omnia: Enable
 LTO by default on Turris Omnia
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de
References: <20240327162355.24584-1-kabel@kernel.org>
 <20240327162355.24584-2-kabel@kernel.org>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240327162355.24584-2-kabel@kernel.org>
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

On 3/27/24 17:23, Marek Behún wrote:
> U-Boot builds for Turris Omnia are approaching the limit of 0xf0000
> bytes, which is the size of the U-Boot partition on Omnia.
> 
> Enable LTO to get more size optimized binaries.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   configs/turris_omnia_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
> index 29148402a1..39e15043df 100644
> --- a/configs/turris_omnia_defconfig
> +++ b/configs/turris_omnia_defconfig
> @@ -31,6 +31,7 @@ CONFIG_AHCI=y
>   CONFIG_OF_BOARD_FIXUP=y
>   CONFIG_SYS_MEMTEST_START=0x00800000
>   CONFIG_SYS_MEMTEST_END=0x00ffffff
> +CONFIG_LTO=y
>   CONFIG_HAS_BOARD_SIZE_LIMIT=y
>   CONFIG_BOARD_SIZE_LIMIT=983040
>   CONFIG_FIT=y

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
