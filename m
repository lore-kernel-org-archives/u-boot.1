Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF44D5A6FE
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 08:31:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E3EE88F55;
	Tue, 26 Nov 2024 09:31:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732609878;
	bh=Wvfe6xhO1TwwU0Qfw+GnADtIl+SCVXqC6MuALKv7ias=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nr+2oRY0os2FycleKUys6bMMSp2SJYZuyGgyGlG9qxHZRBhhofAabg4KHlrcm/HEP
	 ugGUqAbHy5knG7dvsZ0jxMOUqAzVMuRTP/aH85dh0hHo9TUVXy6BzBaqpbOqFBY9Ue
	 69/B80LIZEwWneT3OiOZz/l+eJACrm8Uz3rCIi4O+PECXxmXXgni+WH8MhecDLZdXH
	 L7vzf6XjQ2pJ/BCVOGbSquJsD0v4UqMmXbFBemp9poqUGj+qU/650CRWCTktLH7pJk
	 DFK38ZgyLgju61rWIpvvk0H7VVJI0JcCnNAW0RiPal3BtVWGNNGj4jBwu26r0MGNqd
	 97qQS9go7YuQQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B054D89677; Tue, 26 Nov 2024 09:31:17 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDBE288ECC
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 09:31:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4XyG4d4mKwz9sTS;
 Tue, 26 Nov 2024 09:31:13 +0100 (CET)
Message-ID: <2700ab07-eecb-4c51-a9af-f94a859a1c76@denx.de>
Date: Tue, 26 Nov 2024 09:31:12 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 7/7] arm: mvebu: x530: Enable IPV6 support
To: Chris Packham <judge.packham@gmail.com>, u-boot@lists.denx.de
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Tom Rini <trini@konsulko.com>
References: <20241122003058.270163-1-judge.packham@gmail.com>
 <20241122003058.270163-8-judge.packham@gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241122003058.270163-8-judge.packham@gmail.com>
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

On 22.11.24 01:30, Chris Packham wrote:
> Enable IPV6 support for the x530 board.
> 
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
>   configs/x530_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/x530_defconfig b/configs/x530_defconfig
> index a5b1cc3f8e89..815370c90ecc 100644
> --- a/configs/x530_defconfig
> +++ b/configs/x530_defconfig
> @@ -65,6 +65,7 @@ CONFIG_CMD_UBI=y
>   CONFIG_ENV_OVERWRITE=y
>   CONFIG_ARP_TIMEOUT=200
>   CONFIG_NET_RETRY_COUNT=50
> +CONFIG_IPV6=y
>   CONFIG_SPL_OF_TRANSLATE=y
>   CONFIG_DM_I2C=y
>   CONFIG_SYS_I2C_MVTWSI=y

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

