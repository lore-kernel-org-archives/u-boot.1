Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39CAC54798
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 11:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CCFB87D91;
	Sat,  2 Mar 2024 12:07:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="uyXrLHP9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EEAD87DAF; Sat,  2 Mar 2024 12:07:49 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EE5687D91
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 12:07:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 155c18d3-d885-11ee-b571-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 155c18d3-d885-11ee-b571-005056992ed3;
 Sat, 02 Mar 2024 12:07:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=wytwv9jnmuqlfCLqE4/CLeNLmEoo6kd7r7mQTiMHLYA=;
 b=uyXrLHP9IT1VcN4pjGQa25OqvoAure5xOnX8OG7Zb2PGYknAlDRAmtn9UFPW+v/YIRpLPjUhjWLwO
 0dAOatk0zC12U1YuJzJmUF+pN7Gq78LSrR+KR7Nf+tIf6atSckIOIxN6y/DeSidsFWLqoAgxdshrH+
 CKjRt3/8E2LvoQ68i9vTt4Zn4KmpWPg4Y8nZ8QgiGGPM6hcRUMtvrZ7NzhDdY921h9mGOS0zdUB6Ap
 jKg1uj8S6ivwDZP/7BH2dT685fcA/ElgMo+tUGJ+ud7pXCTopD6xfWV51/FZF96sWI0Y63lQDQsBe2
 bXXdfOrFasvuv0A8md3Z4QNXw9ayUtQ==
X-KPN-MID: 33|2Km89LxySDqG+uwwG3Oi2HdWGwzqUiGR13Rknnsa5Un1TSL1C97b2iDgLbehQLk
 H5KOsV7tBZ1Wy3e12JtZbWIRNCvBDul97nrgK5CnVU/Q=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|zEuXQIUlnreJYPz6V7NxelFh3T8V4mJpziw2d35L4qsOraGSe3pjY9nl5J6vgfq
 oNR3nNpcBzZzwNexfojClMw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 187e3ada-d885-11ee-8956-00505699d6e5;
 Sat, 02 Mar 2024 12:07:45 +0100 (CET)
Date: Sat, 02 Mar 2024 12:07:44 +0100
Message-Id: <87jzmkhoxr.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de, pbrobinson@gmail.com
In-Reply-To: <20240302105440.587680-1-pbrobinson@gmail.com> (message from
 Peter Robinson on Sat, 2 Mar 2024 10:54:36 +0000)
Subject: Re: [PATCH v3] disk: dos: Add all options for EFI System Partitions
References: <20240302105440.587680-1-pbrobinson@gmail.com>
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

> From: Peter Robinson <pbrobinson@gmail.com>
> Date: Sat,  2 Mar 2024 10:54:36 +0000

Hi Peter,

> The EFI spec states that the ESP can be any of FAT12/16/32 but for
> compatibility doesn't necssarily require the partition to be the
> EFI partition table ID of 0xef. A number of arm devices will not
> find their firmware on a FAT partition with an ID of 0xef so also
> allow the original FAT12/16/32 partition IDs as they are also
> permissable for an ESP.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
> 
> v2:
> - Add 0x0c option
> - Make hex constants consistent
> - Move from if to switch statement
> v3:
> - Fix switch brain fart

Sorry, still not quite right...

>  disk/part_dos.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/disk/part_dos.c b/disk/part_dos.c
> index 567ead7511d..97f4ce32bed 100644
> --- a/disk/part_dos.c
> +++ b/disk/part_dos.c
> @@ -40,10 +40,21 @@ static int get_bootable(dos_partition_t *p)
>  {
>  	int ret = 0;
>  
> -	if (p->sys_ind == 0xef)
> +	switch (p->sys_ind) {
> +	case 0x01:
> +	case 0x06:
> +	case 0x0b:
> +	case 0x0c:
> +	case 0xef:
>  		ret |= PART_EFI_SYSTEM_PARTITION;
> -	if (p->boot_ind == 0x80)

The boot flag is part of p->boot_ind but the switch is for p->sys_ind
(the partition type).  You can't handle the boot flag in the same
switch!  Probably best to keep the if-statement for that bit.

> +		break;
> +	case 0x80:
>  		ret |= PART_BOOTABLE;
> +		break;
> +	default:
> +		break;
> +	}
> +
>  	return ret;
>  }
>  
> -- 
> 2.44.0
> 
> 
