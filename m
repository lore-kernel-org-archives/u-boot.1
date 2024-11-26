Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40671D5A6FE
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 08:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 948CA89BEF;
	Tue, 26 Nov 2024 09:30:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732609833;
	bh=r4a3tY9GNIX/8Sv9e4A01psGlBZQVzDvpo+gfBodCCM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HigzKxtwN9OWtqpZWUwQPEVJj3udm8XN5hqC5Ll+rA3sf3G4vvpBuvvpbNW9mcDYt
	 mbY+e1wLMl0GsL1rhU7Uhq1b0vGQpl5Cpj/iXPuEKZx3P9/YNRYdGwGnh9k4vgxTaa
	 rZZD0W24cbvl7+rx6qJNRg79ZUarYwNMJgF3ApfDdzMclOK6yw6HjyqCNseKCB4RzL
	 PUpW3P8A2AJMGie2k/yPClDVsbA0rhhgq4i/dRjmHrPCt2EilaklgY8ln+lO0bWYrT
	 z7ia9ufyqVGp2eLkgj0Xsrlg9yY0bFofvMPUi5Cs+gPHaPz7bfD3ZlapXXQERD9Gzp
	 oyOW8aHOm5q8A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAE4289BF2; Tue, 26 Nov 2024 09:30:31 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67DB889680
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 09:30:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4XyG3k5MZKz9snR;
 Tue, 26 Nov 2024 09:30:26 +0100 (CET)
Message-ID: <9fd89064-829e-42af-9234-a1022b80514e@denx.de>
Date: Tue, 26 Nov 2024 09:30:25 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/7] arm: mvebu: x240: Don't build mkeficapsule
To: Chris Packham <judge.packham@gmail.com>, u-boot@lists.denx.de
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Tom Rini <trini@konsulko.com>
References: <20241122003058.270163-1-judge.packham@gmail.com>
 <20241122003058.270163-4-judge.packham@gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241122003058.270163-4-judge.packham@gmail.com>
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
> The x240 board doesn't use EFI and our toolchains don't include gnutls
> so disable the tool in the defconfig.
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
> index 4fca1096e740..5e5b467b7bac 100644
> --- a/configs/x240_defconfig
> +++ b/configs/x240_defconfig
> @@ -77,3 +77,4 @@ CONFIG_USB_ETHER_RTL8152=y
>   CONFIG_USB_ETHER_SMSC95XX=y
>   # CONFIG_FAT_WRITE is not set
>   # CONFIG_SMBIOS is not set
> +# CONFIG_TOOLS_MKEFICAPSULE is not set

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

