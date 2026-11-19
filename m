Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52D6606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GVHTvfjn;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=j5PwNoHP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9550681420;
	Thu, 19 Nov 2026 17:02:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ey7dHNo03RSG; Thu, 19 Nov 2026 17:02:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C62A981440
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795107757;
	b=hnlfdq1sbLF/LnSzWdXQ1hPJZdHwO+2mMuH6mjrnonc0bN6NYkIAo93sRwU7fSR7NUoc
	 27KaTNym9h+MtKVJZ9G0mdxT63xTPak3FIB3kjXf2NnVMy0Jk39uKGvDcHxL5582ZNGhy
	 HxJIhlr+2vdP2u6WWr64PJxqcicqES/yUT7fYhe0OdV97StmNYWHhPFxIDivC5HfrTpi2
	 jKk1WPJzg2bdl6fBluQj3WEHdFrvAqbhA6oarH9kG8EFYF7sl6RA3IXTmen2sUm+pireW
	 HohJeiExpnH/ssNWFY0nTQl3b4y2bColT0MJVw7ybx+i4k34X+8Cb78zR4Bx4cYHElg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795107757;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=3fH+Ry/8aYeCgDGZ3fQo6LrDTYPvlG0viwO8CdvzPmM=;
	b=CwWUSeoMg4lpRjVbLgzZXKwwVup2g2QglLTNmuSEL+w01yNpeipskvsFeDPaM9P0T7mm
	 SbM+3vhBmiMA/cTfAE67sh716A7yEUWHRr/Dvf4djUsCv9rnXo7n2mbmqkTi2VkwH6tb+
	 +GYtmXx0KeeBpOJgZbShBgPWvIGF9c5NpsuIzqmGPEf3RIWjgzMxkVaoEBUFQVsIXc6+o
	 /unc8SZAszmSeXo3qLPRCjgRSv9GAFBCGyxeRgRYxUo3817SO9GKiuRTqT81vsGJzVP/O
	 PvidK6E8cx6G6xMA8HSK5MTJmrIH+97By9FpFEfUwhmPwrzF3YJT3mVZplNIzCyFXKg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=j5PwNoHP;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795107756;
	bh=3fH+Ry/8aYeCgDGZ3fQo6LrDTYPvlG0viwO8CdvzPmM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GVHTvfjnjwjU6mKhAd7n4D6YWkXHKW4RzvXi/Vp0V8QpbAkep2m5FseFfQLUPO841
	 aQzo73+3qNczqdMfO+GUg+ca0ah4WDCJkBWCX+Ro5wkgqY06uB4HIGNC95ntR8yz9y
	 xS63l+eiNy4/YnAuXmwTXIx5vj7VjzwmnE6V6aVWHBbf0o/BoYEc7TgH+9Ealk7CW/
	 yoYvOD8dBwjrhqNTTXjJ8gyWV7gpKuoR5tti9fZ277+TqcFsE1bwbRcMQR4Y4+P/5V
	 KPPFnyWcne/4cSXGfIQBwUypkn9pFywNm+81wtmvmcWYHaulP5OI91ZwpN1Q/ggsNf
	 HQ7eN4We3ZIUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C62A981440;
	Thu, 19 Nov 2026 17:02:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8614E2FB
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 770AD81440
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:02:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8pQfoQjBJa7v for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 17:02:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6AD0981420
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=j5PwNoHP
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6AD0981420
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:02:33 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-71ad099391dso1392320eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795107753; x=1795712553;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3fH+Ry/8aYeCgDGZ3fQo6LrDTYPvlG0viwO8CdvzPmM=;
 b=j5PwNoHPAtLClUv9SVuPlQZFBzIEmw2zmzounCqDwHFkKUU/ZorDmx02/g4Hjt6aki
 2kn+ETSSn5YUmyJIUw5CaR4eTsAw0YB0KS9p8BJGT/UFCw9FwTrAlQzhmE69Ucrt5z+B
 Kzp+0rrXBG1MWuY1eXmfwRwbRlRJEv5MNepoewyLshdErxsfDsXO9ITCiw49S6arBvmp
 pfjdv59oNBb/3cBtLvQVol30BCeurS5X36CxOz65HpGAxEaM/7TCW374f1Q5rRQBKP09
 15jD2JlpLfzxBD+XIrAAzweFTpSAmimm8qo7Gqux1uVPW+7TiyBLBb6Wpl5XXssGRXar
 vwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795107753; x=1795712553;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3fH+Ry/8aYeCgDGZ3fQo6LrDTYPvlG0viwO8CdvzPmM=;
 b=c9QmVW1yH+NlxydSv4ja7zhXraM126nSUzaesE9UPLawJrJyalk4gpAgejyMNm98bb
 ZvPOoJGDpvkSqcog5zCvAxOjQWLDJVk4xDFCpExhlR9xRmiAm95Ge8uA0acD8S030/zS
 cY1DVWrtWprC2WfPU7kBtmPU2KpGtoqVfX2aHnBvgE2BRub363j3zydGWy7zOocn00dd
 JOvfhjcUbRJx1qA+lSuKD6yPk9kp1oGqMw3i4U+77+Mi0DHJ3QXYYD4ekN1jeQGDWgIk
 VFAs6HSsAAalaT9hRVTIJHjl/0dlgps4Rl38NZpbjXELAvLMYLe8Q+PD0JGJMveQpdfc
 yQyw==
X-Forwarded-Encrypted: i=1;
 AL+hErFJe91hiPG+5B7J1HjUwDpImUNOfqZGG66RhYgHeVSGFxJNzVzZ/lrgZ7wt6pnQomx2XrcK+JQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8Yoeccle6508VZkQpGT3bq9K9raatF2lO5HO+QMh/0tgQvsBtv
 jku63ln4uuzuysv6wSTmjozibyFnBgvIPjb+2SJGHJ0TW9fKMNNGy1uS8akNLZceMflatD7p6zt
 Y8pi1
X-Gm-Gg: AYBFou14jDClKyNZ7ukC5P5de+/N9zlf1oZz8xKd9Mo8hlSBUSl9tngAQa5sRnckeVj
 WLKB2Zio3eMBwhpbdHWhwkvakqY3Xfk/zV1qxJxXhy5/diMiczqAiFT4ybTBZIPuGpIcvJi46QF
 dT/JJZciiEnWQRZNncVA5mZ+8K47aPGPs10MpT0i5dAGozDPpMzGvV3R39jzTQA+djMyb43Y9td
 iDXW6prjzZeAg+71pT1VHb6t2hnCFdQNBDmIJQR/Zv2cV7RwhZhXnaHYetcpe1ViY4YE3SH3GE+
 WFGGK+dLMJi08yK54I0KOgeKg610d3JuVMZMovwf+CKQDH91FLix56pVPPSSRdwwBMhQOURDJWt
 GNSRGA7zgF2DLWycu5gZ4VsMFXXc0kIcZYmk8hIub+V6uGlBdTVyWP3Ml/u861wSNlfI2tw8a3P
 WERejQh+UU0VhDLd0VuBQEZgkLWK2aJtkW31ZQb9zjiarcbft8GlSzVaz4M03RHtlX4mrjngyX3
 WVOQfBnJTfsOZU7PWtpUEJUxryqgi1PkXy6WVuojhS9qSNcqdG5q8dXOcZ6ewVBoTs75Pw6xZ1N
 2k87gxK5bW1EEkKU6Zxb512q4Hv72bIR4w==
X-Received: by 2002:a05:6820:3404:10b0:716:cf08:d22c with SMTP id
 006d021491bc7-71b39555a93mr109959eaf.69.1795107752651; 
 Thu, 19 Nov 2026 09:02:32 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:43e1:bc37:7497:58db])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b380e4a6dsm381290eaf.13.2026.11.19.09.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 09:02:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 2/6] fastboot: block: Add device selection syntax
From: David Lechner <dlechner@baylibre.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Simon Glass <sjg@chromium.org>, Sam Day <me@samcday.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>
In-Reply-To: <20261115-fb_gpt-v3-2-7ddd7ef832f6@oss.qualcomm.com>
References: <20261115-fb_gpt-v3-0-7ddd7ef832f6@oss.qualcomm.com>
 <20261115-fb_gpt-v3-2-7ddd7ef832f6@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 11:01:50 -0600
Message-Id: <179510771079.2216103.5715688744743238662.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3196; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=YJI0b8Dm1dAbQytrf9NXeY/2y5Qz+KU1KMe8lvnfVxU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq/yuKLpoLIyw2ZaARbUmFPlY9p4jfXQVQuMCo/
 vqO6gAtGmCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCav8rihYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AP+cH/1LDamX0MrHQRKyZkulushKh19LOs8zHuz7zOXq
 W+GDDf6OkAUS4T3tTCgRc7jQVFh2G3JRuwXafu0VjB5x4pcIikwgQTLADOO9vrGqIekPEqZZGkE
 26JBTU357yMKAGBfjv4rXfruNGaIMAGRPve5hh75V2+h8b140dFyKSBf2St9bRJOywV7016nmMK
 lyqsHL325GKJb19H+vlmGHpKSCLL7xKKtvfusQnwoREElOIoTLj0lCpj0JcpEn57Xu/D7K1y+rV
 tDoA3HFlMhiiWtmzuxgFh1JZGTLHwyiDdOTmEwDGfdb8hmggovD1zeXpfdbVbXB+DjQRDSLgmwV
 aS4I=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> The block backend can only look up partitions by name on the device
> set by CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, so a board with more
> than one device on the configured interface cannot flash or erase
> partitions on the others.
> 
> Do the same as the MMC backend: look up the name on the default
> device first, and if that fails, hand it to
> part_get_info_by_dev_and_name_or_num(). This accepts "<dev>#<partname>"
> to select a partition by name and "<dev>:<partnum>" to select it by
> number, the same syntax used elsewhere in the disk layer. Since
> fastboot_block_get_part_info() is shared by flash, erase and getvar,
> all of them accept the new forms.
> 
> Example usage:
>   fastboot flash 1#boot boot.img  # partition "boot" on device 1
>   fastboot erase 1:3              # partition 3 on device 1
>   fastboot flash boot boot.img    # partition "boot" on the default device
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v3:
> - Use '#' for name lookup to match the disk layer, instead of ':'
> - Use part_get_info_by_dev_and_name_or_num() instead of a local parser,
>   as fb_mmc.c does
> - Move the NULL check fix to a separate patch
> - Mention erase and getvar in the commit message
> 
> Changes in v2:
> - Newly created in v2
> - Has only device selection syntax related changes
> ---
>  drivers/fastboot/fb_block.c | 12 ++++++++----
>  include/fb_block.h          |  4 ++++
>  2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
> index 16b94b8a0b2..fb0face0429 100644
> --- a/drivers/fastboot/fb_block.c
> +++ b/drivers/fastboot/fb_block.c
> @@ -146,13 +146,17 @@ int fastboot_block_get_part_info(const char *part_name,
>  		return -EINVAL;
>  	}
>  
> +	/* First try a partition name on the default device */
>  	*dev_desc = blk_get_dev(interface, device);
> -	if (!*dev_desc) {
> -		fastboot_fail("no such device", response);
> -		return -ENODEV;
> +	if (*dev_desc) {
> +		ret = part_get_info_by_name(*dev_desc, part_name, part_info);
> +		if (ret >= 0)
> +			return ret;
>  	}
>  
> -	ret = part_get_info_by_name(*dev_desc, part_name, part_info);
> +	/* Then try <dev>#<partname> or <dev>:<partnum> */
> +	ret = part_get_info_by_dev_and_name_or_num(interface, part_name,
> +						   dev_desc, part_info, true);

I have been using this patch for some work I am doing and it is quite noisy.
part_get_info_by_dev_and_name_or_num() prints for every partition:

  ** Bad device specification scsi foo_a **
  ** Bad device specification scsi foo_a **
  Couldn't find partition scsi foo_a

even though everything works fine. Should we only be calling this if e.g. the
name contains '#' or ':' to avoid the irrelevant error messages?


And second point on the same line of code. Passing true for allow_whole_dev
means that "<dev>:0" selects the whole device, not just the first partition.
None of the commit message, documentation (patch 6), or code comments mention
this. I assume this was intentional so should just be documented.

-- 
David Lechner <dlechner@baylibre.com>
