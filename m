Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3708DC54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 10:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8F6488137;
	Thu, 28 Mar 2024 11:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711621544;
	bh=5u4CGUDa/OlsJOFNXXcwajWt2JvdLOt+cfEamLHzB5c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ihuyUzIQIQ7dS+xVMk6hJLNf8cGJ+Ka9dCZpniNqDo2f7v8MgY/W4bN9NviyokARR
	 o1rfh0oi2cneDLxSTSzRYTqhjdUVSJGNfZCxiFDp+SMb4+glKaOglQl9MOf2QjhL3z
	 QVGhful6t3GXmjVPIGPbUB+O1a781i1OR+iJvX/HGDihpRQwjyd1F59o6U4WiAhNJ6
	 9A6pGDQWo0mfm2MCKYVB1sNnkP7p20IOrBhduurO1qQUZg74Z+XpLYOCkCn5UAQK3D
	 1uXlUzNljOi487Mrk/VctqqyhKlgN6mRM51xeLv9TcqY+BT76GCNoPk/uLaPL5QlIa
	 GdzQL2l5lk5mA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB59787E9D; Thu, 28 Mar 2024 11:25:42 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 346B488137
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 11:25:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4V506q1bm4z9spM;
 Thu, 28 Mar 2024 11:25:39 +0100 (CET)
Message-ID: <fb681165-fda3-49ce-97eb-0e8fe3f4c596@denx.de>
Date: Thu, 28 Mar 2024 11:25:38 +0100
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-mvebu v3 18/18] arm: mvebu: turris_omnia: Enable
 rng command in defconfig
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de
References: <20240327162355.24584-1-kabel@kernel.org>
 <20240327162355.24584-19-kabel@kernel.org>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240327162355.24584-19-kabel@kernel.org>
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
> Now that Turris Omnia has a rng driver provided in the MCU driver,
> enable the rng command in defconfig.
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
> index 4c21635ec9..f2b39115fe 100644
> --- a/configs/turris_omnia_defconfig
> +++ b/configs/turris_omnia_defconfig
> @@ -73,6 +73,7 @@ CONFIG_CMD_WDT=y
>   CONFIG_CMD_TFTPPUT=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_TIME=y
> +CONFIG_CMD_RNG=y
>   CONFIG_CMD_AES=y
>   CONFIG_CMD_HASH=y
>   CONFIG_CMD_BTRFS=y

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
