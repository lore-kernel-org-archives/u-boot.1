Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AE5C5478C
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 11:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6726687DE5;
	Sat,  2 Mar 2024 12:33:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="bn+XGjja";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1674987DEB; Sat,  2 Mar 2024 12:33:04 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 253D387DDE
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 12:33:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 9cc552f0-d888-11ee-b571-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 9cc552f0-d888-11ee-b571-005056992ed3;
 Sat, 02 Mar 2024 12:32:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=MpERSftQ0IrM2oBg9HMjXb+kp1Q/f1yP9Il+4R0Km5Q=;
 b=bn+XGjjaJaOCtRT8yN0cWt6vADN0lLg4I8CI9blVXOeFAAf3VmshcyZbfmivCJY4gl+GFJPVqLjYP
 pCcoM5j5SIQffGt5Zct82GIucQi4qyCmwKZx19WkXOudo6E/6zdc2hX3SLRlqQTSMjjHysr1PAv9o8
 CeeYsb0PAZW+6whBrzS5BlAi6YStZGoEOFJxIZkIoT78gYuieBF8/SKjTKR9v6SBulmbG/AjHAfi7a
 UnXaFDd02acYDyYXj8FyAjPKNKZiqgqwqfq4W0mkYbAuBvZjcnqCAq8bBJ6gg80zExrxYkGeFUQsWJ
 FSXHledYvhfUZn0n2KAIGtGWfglXZew==
X-KPN-MID: 33|A3TLKWQ9fplXA/BNhMiKzgPHhk5kHtlSOxxeCYxAKAxs4H/aJWrazfWFtUlsrY4
 Eu+fTYaUstXkmfq9u2c6dL1nYwN8/S0VekujyXpaCIlg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|XC8Ya9wnQWgnDPRARFHRCTDiMHH48yqa//lS0qfTeV3m132ifMM4NL7k000JQ0Y
 6FFtS2J6B2qvA1lBFiTTSwQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 9ff641e7-d888-11ee-8956-00505699d6e5;
 Sat, 02 Mar 2024 12:33:01 +0100 (CET)
Date: Sat, 02 Mar 2024 12:33:00 +0100
Message-Id: <87il24hnrn.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de, pbrobinson@gmail.com
In-Reply-To: <20240302112034.593441-1-pbrobinson@gmail.com> (message from
 Peter Robinson on Sat, 2 Mar 2024 11:20:31 +0000)
Subject: Re: [PATCH v4] disk: dos: Add all options for EFI System Partitions
References: <20240302112034.593441-1-pbrobinson@gmail.com>
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
> Date: Sat,  2 Mar 2024 11:20:31 +0000
> 
> The EFI spec states that the ESP can be any of FAT12/16/32 but for
> compatibility doesn't necssarily require the partition to be the
> EFI partition table ID of 0xef. A number of arm devices will not
> find their firmware on a FAT partition with an ID of 0xef so also
> allow the original FAT12/16/32 partition IDs as they are also
> permissable for an ESP.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> ---
> 
> v2:
> - Add 0x0c option
> - Make hex constants consistent
> - Move from if to switch statement
> v3:
> - Fix switch brain fart
> v4:
> - Drop boot_ind out of switch
> 
>  disk/part_dos.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/disk/part_dos.c b/disk/part_dos.c
> index 567ead7511d..a35181dff4f 100644
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
> +		break;
> +	default:
> +		break;
> +	}
> +
>  	if (p->boot_ind == 0x80)
>  		ret |= PART_BOOTABLE;
> +
>  	return ret;
>  }
>  
> -- 
> 2.44.0
> 
> 
