Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9398E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 19:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 352A78022B;
	Thu, 19 Dec 2024 20:56:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jocJ6+vX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fCqN8kgs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 527EC80243; Thu, 19 Dec 2024 20:56:53 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5502B8021D
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:56:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YDhC70WQxz9snv;
 Thu, 19 Dec 2024 20:56:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734638211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Af9PWT7lPtcqN0esTMqJM0VcnVq2eWW8lH0/5fJAePY=;
 b=jocJ6+vXr09uoKyzMRSQmk99zu6voWpatDKR9nOxfmYwPpRnjICQrd+Rpxwtr2q5kA86P1
 n2Vj0W992xOEfOLqXslNAp5gHwT+hsbb3K146MXc5ldpQk8nm0skDdnrIJ+xDw5e+IN8Nm
 TyJ6/bWBqpe/KQNKuLpPyMjsAqCzqYwvKJIqs0d94B9XxHE4j4K+DMxDD19Z5s1A9qepJx
 fBj1vyQS8562IyYIxohjjQsEcav/ObCaj23TgHnnS8JhERB18/UxgpBuPDWYezTawSuvxN
 qbVzdcXVz1gVZwWd1LHQQc/Cs7HlAJbyAI72AvRF7ELlWjxfXA4GMIAG5X7AQw==
Message-ID: <a9390faf-f4de-4c52-8149-5d3e7959a477@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734638209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Af9PWT7lPtcqN0esTMqJM0VcnVq2eWW8lH0/5fJAePY=;
 b=fCqN8kgsuKKquOLAKh1JSOxoRnf0PrffJ4qgDfvb2fcvkW2TXAYsqdDo9Pxssz3I1Wfzns
 bQveeKNddiiuWjh0XxtGmxePXt/1NUO6D2RjjoKVAehgzfhWeWzlw0XjsQB23JOP+igcdU
 YfK1v2OvDcKmrmoAsffD2LUe5XED3TVKECrpngcMhh815ptyEX168I6e1+smyvUH1Ayybu
 njZX+LaNEljs1BBlqTLJWIUpkf0NUqZa3iMiGJaA1yw4wQglzzxu0TpSgRv40DDZLzOe4A
 Q0uCFWrRh4lu9C30B6NPoBaO8eQOs9FbVhy+ObLYSJFCW5wnhCb0oiPfkhFKyg==
Date: Thu, 19 Dec 2024 20:56:44 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] arm: dts: Use upstream dts for additional bcmbca
 devices
To: david regan <dregan@broadcom.com>, u-boot@lists.denx.de,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, Tom Rini <trini@konsulko.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, dregan@mail.com
References: <20241219184953.226978-1-dregan@broadcom.com>
 <20241219184953.226978-2-dregan@broadcom.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241219184953.226978-2-dregan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b4eeb3b16b7fbd058c5
X-MBO-RS-META: n1xb975zag4yihrizpnfnza1hyinrypj
X-Rspamd-Queue-Id: 4YDhC70WQxz9snv
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

On 12/19/24 7:49 PM, david regan wrote:
> Make use of OF_UPSTREAM which uses Linux dts.

...

> --- a/configs/bcm963148_defconfig
> +++ b/configs/bcm963148_defconfig
> @@ -9,7 +9,7 @@ CONFIG_TARGET_BCM963148=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x2000000
> -CONFIG_DEFAULT_DEVICE_TREE="bcm963148"
> +CONFIG_DEFAULT_DEVICE_TREE="broadcom/bcm963148"
>   CONFIG_SYS_BOOTM_LEN=0x4000000
>   CONFIG_SYS_LOAD_ADDR=0x01000000
>   CONFIG_IDENT_STRING=" Broadcom BCM63148"
> @@ -17,6 +17,15 @@ CONFIG_ENV_VARS_UBOOT_CONFIG=y
>   CONFIG_OF_STDOUT_VIA_ALIAS=y
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_HUSH_PARSER=y
> +CONFIG_CMD_NAND=y
This patch seems to be doing more than the commit message claims it does?
