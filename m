Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9ACC47DD9
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 14:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2AA787DCF;
	Sun, 25 Feb 2024 15:23:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="mDnlzk44";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D7F787DDA; Sun, 25 Feb 2024 15:23:55 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FB7387DCD
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 15:23:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 6d42530c-d3e9-11ee-99a2-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 6d42530c-d3e9-11ee-99a2-005056999439;
 Sun, 25 Feb 2024 15:23:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=1SSfZZTSlwBL8CfEjB6rjZAOE4nUfaLydLJI9yiSNcY=;
 b=mDnlzk441Yi4mY2t5QElzd5sz6hq8uyVsFNPZN4FzessoSo2fF7kgxC8+s8hywNsB6eanp8IouB6i
 0sCwS62Kc/NGA5KjuYUnOZmnE6cPGN36nCv9uXmVUOsrVvStJ/fJSLXomvqH0EFVVuQ7uW4uA0Su27
 53x0KGUQtvIO1z2rGLmsHxCxxj7PpDp8aLCDYZErv1jnFWEetYFa6RNVzhpXSitUnDdq5Xdkz9RDia
 yiinqMeevfAMrZ7FieURqVbqMsSd8S3Oj09zfVorcmZqe5Brzm0q4aiNP2+McAYERqJi/XYyy/8CD9
 Ql03n+uRJNkU1Tu1j5OCoU2jr09RgFw==
X-KPN-MID: 33|+fr02YwibquXrkfMJHNjW+oZTK1oyH/0SqLnACa/X7EKWQShd6It7Xpli7475Vk
 cB2qD+8QS+Zjc3hymrDH0hn758RsPQCBOGypfeyT8ghs=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|QH62rEf75iVk51ClExEWGcI0zOHl121Wm6j3DqyDLH8N2Y4t7JsKUJ5LuzQV6+r
 EUaK+8WLV/wzlgAx/jWsTSw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 7f050e01-d3e9-11ee-8952-00505699d6e5;
 Sun, 25 Feb 2024 15:23:51 +0100 (CET)
Date: Sun, 25 Feb 2024 15:23:50 +0100
Message-Id: <87h6hwk4g9.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de, pbrobinson@gmail.com
In-Reply-To: <20240225141457.48209-1-pbrobinson@gmail.com> (message from Peter
 Robinson on Sun, 25 Feb 2024 14:14:55 +0000)
Subject: Re: [PATCH v2] disk: dos: Add all options for EFI System Partitions
References: <20240225141457.48209-1-pbrobinson@gmail.com>
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
> Date: Sun, 25 Feb 2024 14:14:55 +0000
> 
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

Erh...

>  disk/part_dos.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/disk/part_dos.c b/disk/part_dos.c
> index 567ead7511d..ab855adf347 100644
> --- a/disk/part_dos.c
> +++ b/disk/part_dos.c
> @@ -40,10 +40,23 @@ static int get_bootable(dos_partition_t *p)
>  {
>  	int ret = 0;
>  
> -	if (p->sys_ind == 0xef)
> +	switch (p->sys_ind){
> +	case 0x01:
>  		ret |= PART_EFI_SYSTEM_PARTITION;
> -	if (p->boot_ind == 0x80)
> +	case 0x06:
> +		ret |= PART_EFI_SYSTEM_PARTITION;
> +	case 0x0b:
> +		ret |= PART_EFI_SYSTEM_PARTITION;
> +	case 0x0c:
> +		ret |= PART_EFI_SYSTEM_PARTITION;
> +	case 0xef:
> +		ret |= PART_EFI_SYSTEM_PARTITION;
> +	case 0x80:
>  		ret |= PART_BOOTABLE;
> +	default:
> +		break;
> +	}
> +

That really didn't go well.  The 0x80 check was for a different struct
member and there are missing break statements.  And I suppose the
suggestion to use a switch was to bunch up the EFI partition type
cases.

ENOCOFFEE?

>  	return ret;
>  }
>  
> -- 
> 2.43.2
> 
> 
