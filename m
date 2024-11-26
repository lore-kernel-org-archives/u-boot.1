Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76104D5A6FD
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 08:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A8C288F55;
	Tue, 26 Nov 2024 09:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732609843;
	bh=UGf7Iza/oVEx/8XdqU0eto1XK2KEhATi1kDYG5Bycck=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n8JkaZxnrtAHhWipqxVgMVc0oOPWDe52yeXYFVbA9KhbCbi4sjcYC07nrNuHVBx9E
	 uAVdrMIdfOELKUnrAgnEBATxSDebW+emWxZQG5QHFDGDQMpeVzjIBgJg2VBGZEgHiR
	 XzXkxA1W/SZk/NXZ9Lcjv7Eg+eMEiogeFAtgVTHFEgYBskhwQdDfr/ofMAhRoyvbBb
	 QyvkW9utzV97axhRo+AxobxObt3+oEO9D/5ADBbF0Vc25sQnGuTmWEyPE03cR0EqQ7
	 7mL5Q1wvDsfXS2HIGNCLMqfyz/4oWD95joDoeJmA/V2fzIMsrOPtHaRN5sklIWySu0
	 xS6JdMeNCrmxg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 659BD88ECC; Tue, 26 Nov 2024 09:30:42 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C55589681
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 09:30:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4XyG3y2G0Sz9sTS;
 Tue, 26 Nov 2024 09:30:38 +0100 (CET)
Message-ID: <14ac3c55-8bd1-4957-9f83-cfea2e593823@denx.de>
Date: Tue, 26 Nov 2024 09:30:37 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 4/7] arm: mvebu: x240: Enable IPV6 support
To: Chris Packham <judge.packham@gmail.com>, u-boot@lists.denx.de
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Tom Rini <trini@konsulko.com>
References: <20241122003058.270163-1-judge.packham@gmail.com>
 <20241122003058.270163-5-judge.packham@gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241122003058.270163-5-judge.packham@gmail.com>
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
> Enable IPV6 support for the x240 board.
> 
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
>   configs/x240_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/x240_defconfig b/configs/x240_defconfig
> index 5e5b467b7bac..ff64916204cc 100644
> --- a/configs/x240_defconfig
> +++ b/configs/x240_defconfig
> @@ -32,6 +32,7 @@ CONFIG_CMD_TIME=y
>   CONFIG_CMD_REGULATOR=y
>   CONFIG_CMD_UBI=y
>   CONFIG_ENV_IS_IN_SPI_FLASH=y
> +CONFIG_IPV6=y
>   CONFIG_CLK=y
>   CONFIG_CLK_MVEBU=y
>   CONFIG_GPIO_HOG=y

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

