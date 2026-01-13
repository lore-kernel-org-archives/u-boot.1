Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86386D0C85E
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 11:44:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2189482B20;
	Tue, 13 Jan 2026 12:44:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wk5qpYXQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0F1F83015; Tue, 13 Jan 2026 12:44:00 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA42D8003E
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 12:43:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dr6pN58p2z9ssQ;
 Tue, 13 Jan 2026 12:43:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768304636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=05LLSC/MeEXk8LUhvUl5UbCTgi+AuDsrgFBah2jRZQs=;
 b=wk5qpYXQCCm7WuJI70hKDMMUMQjyG5lTka4SIGdRj2DVPVP1839UMjGzgheUSgrVny/y5o
 142+nxea0PALdf0T3cJOuybpz8Hm7nGjvnEx7Nm1wZ7C5eJXwtX0z1hbhDvASM+ttlqGe9
 vU5B+SlUfkQloQ0JtjC7nm2IuqPenYnbtg9esxufCKG9B8fwRFFDg+fL0wuwSRNZ1Suoqd
 xCcfQQzzTYAHQx9FtIhtagaF2zHF0rdHJaT1Gvka8MfIs2uevTxe2s974DCwWzg53o5O7i
 GmzaBuifHP8H5BhHUw96WioX/AAMMzC9Vr//IE135I9CzG0+dmvIPgthhBCheQ==
Message-ID: <9e0dba4b-60bf-4e44-a83d-36d247d1b513@mailbox.org>
Date: Tue, 13 Jan 2026 12:43:55 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] gardena-smart-gateway-mt7688: Disable CMD_LICENSE
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20260113013211.1947438-1-trini@konsulko.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260113013211.1947438-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 7d1b5fa3e01c77fb6a6
X-MBO-RS-META: 3et6mqza9ixbr6qffx16uxy339fexdbi
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

On 1/13/26 02:32, Tom Rini wrote:
> This platform is unfortunately frequently very close to the binary
> size limit. Currently it is so close that generic bug fixes can trigger
> build failure. Remove the license command from the image as that frees
> up nearly 7KiB of space.
> 
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Stefan Roese <stefan.roese@mailbox.org>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   configs/gardena-smart-gateway-mt7688_defconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/configs/gardena-smart-gateway-mt7688_defconfig b/configs/gardena-smart-gateway-mt7688_defconfig
> index 10a595a1df47..a78eebd5fd87 100644
> --- a/configs/gardena-smart-gateway-mt7688_defconfig
> +++ b/configs/gardena-smart-gateway-mt7688_defconfig
> @@ -47,7 +47,6 @@ CONFIG_SPL_MAX_SIZE=0x10000
>   CONFIG_SPL_SYS_MALLOC_SIMPLE=y
>   CONFIG_SPL_NOR_SUPPORT=y
>   CONFIG_HUSH_PARSER=y
> -CONFIG_CMD_LICENSE=y
>   # CONFIG_BOOTM_NETBSD is not set
>   # CONFIG_BOOTM_PLAN9 is not set
>   # CONFIG_BOOTM_RTEMS is not set

