Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D654CA9EBE
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 15:17:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C012F40891;
	Sat, 10 Oct 2026 15:17:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h0pQdaI5NAol; Sat, 10 Oct 2026 15:17:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E5E38406BE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791645472;
	b=F4I2u1IFep5fyn67HA35+63n2b3/ZSSCd0WkSXQe3jOQhxtZsjDf6/XSByOZgDJwc1+R
	 LyzZFrEXxEwgeTAdB7x2JsvqcAil223+HXgSQLL3XFIljmrNqOiMOllBmQmNrmTM+5LMN
	 uZeco3FGX3VcwPjGjd8kv4ZMRScsTApZWhaUBahJ63NQHgkLx2+YDN/uRXzPrX9dkV8St
	 Rx4zaC7BHHFFXYR38QTPT0dfsYPthiUtrDRxulQ6YHc7okRG8v1uwV48FXqvcmvyQOGX6
	 QSm2g+rhRx9kMOZf+EfV0RNHQoS1LnPynk57Fqll3K16KWaA5iVj+NUZI78J/tdmZrw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791645472;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rMlVcyMcRBcY28V+hAkMjA28LV5nlk7XCNmqzRFV9aU=;
	b=gNqNp3U1V3HJHXj8k11IfAqouHrrnwqbLICF1xR1hqmx107u/EDfScPLObfrmCvHsjzt
	 oA4lYGFGXb660diPK1VofJzSowy6wzkTyt5QbKvkK5u3g83+G63qtO4JlzeM7/rpsJ6kx
	 cwQ0d8PjUMA0803AmSca+7VEE44uVzfMm1BEqwC82EOIs2Il9E76aw2+LYC1VwnEaTBW3
	 vVje1EeGrJW0bl7ql4OgTxZNrnuNNcUZc/m+/1kdufobjX8eGwMXCaoOn4RWdC4Egxeq8
	 Z9DoIZRs7IDIoyBzcCW7Y1WJHRWBBFvZLD0yVpXxAZmwgDBJh2y6clvdbBP1M6BAt4g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="M03X/9E0";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791645472;
	bh=rMlVcyMcRBcY28V+hAkMjA28LV5nlk7XCNmqzRFV9aU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iywgTMYjtQQ5TmzJPb+kYgmFIgfFoRk2rh8AUO/+7j46uLP5pMX3rNepDbe6H7Blq
	 YDNVQ1Je87qy7o7VIp+mzG9fUMb9q4FnTA05oxlntwyVblqgMEbyVlHwBSDhyi7zn1
	 ME7qtjrN2gOGRtoXwsU+LXWdTioh8vORbbKXoQxSd2F6G1bAmVo/Nt8dxCdGDQTAhu
	 Uhe7ArLNIaAVs3wf+SQLpjgayYIqGJscbQGM2h3FVhNuYn4QfXGwfTOYKWKmp6l9yD
	 ksprcN9wABI6rBj94DZAAwRnN6D3oqZiOkscaxq8kAPH1ZH7v1KAXGjxb+Ef7gEFeN
	 wfcLst8+UnjSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5E38406BE;
	Sat, 10 Oct 2026 15:17:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BCFB317
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 15:17:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 41AFE406BE
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 15:17:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WF5mTvn_QMTI for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 15:17:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4EDF54064C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::f2c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791645470;
 b=LITMRccOJnyrLxGzQQwxdO9/pDGZ8y4TNhyzw2EbVtSNemRQEr3ZfbgJY9803oubfO4n
 5x5ajyU/Bwizfyubt7dXfMpovxtoxNczBPs6pQAOAiBFoLQsC3Pl/2Zu1TVA3z7IuGa7v
 8peiPENTP3desFwfThA3RSEXp/7dk2jzgRChwE5jnvrPjeuvHY7FVR1uUUnwsKInu8zDe
 ITVvF2+NR2GS76dmnLiJVNI2uJOnsGZrM79cj8hjM7/tCA/XDIMdR5OEKMHyAfFH71s4b
 tga7uMhrhpRcRoD5ACZmz4KNdFTAshFF075kSrYYDwGgXinE9bPLzgto7LkHjoeCGXg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791645470;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=rMlVcyMcRBcY28V+hAkMjA28LV5nlk7XCNmqzRFV9aU=;
 b=USzNoUWT2/hGSIeT4XghryF//Jgfh/SFNtpChXkD/zV2YthrnR2yEW/QgRZMgKEJRqBG
 PLs+FJfyiUoxn1OTCTcZY4yLimPB/P+nzhaZwg4ddfnEVku2ZeO1S3bT2Ni24deVLh6hi
 vUIgvtO6RTDcNz1s1JpZp3qA6xZdJkz0QQsZ0vrOzkA0TUVWg6Y643KHl9Ug+AhwJgUC0
 sqAJBYMjWXI959eNR2C1Jde0W3yHtAIZMMREPLLC8j8lifuNRsYgt8FlHcVyXQ7XuivJK
 aTP2eoGohVlFpmqUjiM/fzZSmIdSRrM3CAyCMermlbM9FplCjuNf+062bwcL/kSiptA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="M03X/9E0"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::f2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2c; helo=mail-qv1-xf2c.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=M03X/9E0
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4EDF54064C
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 15:17:49 +0000 (UTC)
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-917ad52d7b6so9288866d6.2
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 08:17:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791645468; cv=none;
 d=google.com; s=arc-20260327;
 b=ZvK0WtAyltFXYm15kMbKYJnTSZ4Qr3GmO2fOh+uSYXyVKDAN+Zlr92NaxdZRSI8hQn
 ABzBIDCDwBrpAA84YFF61izaW2hTV4KplPHj6FYwzkLbUH5RIuovbDGqxcaPsqo1v93n
 yHy+TJJn5+YJ160vskfzcgXc+Ajy0yAGJdvFAqDUdpGg3gr/PjefCxb/KdcIcA7+xhIk
 cWRAJR4NAQHZ/MlYWMHhaLEo/SbrdMI/pf4snD3214EpCm+vWDIsNsHMjZwNSIVkR4Lv
 Mpg6sHKuQ52rL0SQPdnW4WjCxS0E7xEpSqICLD5Obmnyk6ppMhsKhOFb7DuVLcvm99Dj
 Dlow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rMlVcyMcRBcY28V+hAkMjA28LV5nlk7XCNmqzRFV9aU=;
 fh=rei0x9NZCHRGjOp+lub3hHf9J1QXmwHTZ58ylsbOGX4=;
 b=cCn4LVmEZiU1hrNybDD+uUKbdpAlHwnfKoV7GYRmmNlHKLxOa6/mzMOcc902JJ3KcD
 vwVD3E9R1tOFW72d9zfHXr9rshOrKGEpNO6WtP4M5TTExljvNgMhZfK810RsMD+2qwlH
 /QRlUFm9bHFflf4ksABn9OVjyxqs83zK6F2oyB9yKEsy+6M5LAQUiDh2KN77yXJN+xAn
 VVsR9e51wb9xkEXvqz92+EzSFWQ+y2r0/+8I4RBHp//BfqRnH5m4nnde3B3qE+JhkCWY
 4dqYHSvbqBti5U52n0nJGA0e59EttCuKd5n9drrQPsHX1uwI28394Ho1oZVE/LaQyeSN
 rEFg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791645468; x=1792250268;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rMlVcyMcRBcY28V+hAkMjA28LV5nlk7XCNmqzRFV9aU=;
 b=M03X/9E0dvp4H0oUNm2KhII7ELXuWl156GBLqmt65gE/Vx4jZ7urvc0IKg84V4gLyI
 TeRTxFftUL3GLvf2ozzPeKxEpmZd+vOcsT6DiXDEe4ReyV7crNtvIIR2ZO2k72If9BEA
 hrqHFqWbksJ2oHqrFBX6DxURPkSGE7yTugDudrjs7hMEsn1WITvhxXuUrurIfxRRnzva
 /GkNEZ6PStkCO838iFB1F96R3QkYstfGuXPaQ0PFhGRxCeOXo+DejfQKEXk9RUwavHQ7
 V3D37v0hyaNlP6wDMh3yVqH7CN+X4+qJZZvArAnYb+ILqriL/41iUDOwnCz1UY3fyowY
 xN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791645468; x=1792250268;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rMlVcyMcRBcY28V+hAkMjA28LV5nlk7XCNmqzRFV9aU=;
 b=wJSfPGcJ8bNutUJqH0XW+6Bo9BujYl+RPbHx2KoP1FJ5ZHGKwMNIAv/lGXqWF3Tt61
 FUbe//cX4t/p6fgC0p20Ypqqb+Y5HwOaAfeqHIgd5TTlMPIp6WdBChiImPrmolv/0qOW
 y2WPMFdu4C3faFDbF9X4xZQDE6JvY4GkY96Iv7lz8UEbQ6x8/lsEih2uoUGpo9aIa2D8
 rjg5jmphvl0Jd4jfbhVBdviIhRK/HkyNbVytOdShTLrh3ylC/8/m6Aaq6YEGgBCF1azS
 LmpQJx7PRQqv6ADSchs3QbkGP/SiXdVZt4H99M1N7eGORR9JOmGWmKWyT6j4pjR5X14N
 IzqQ==
X-Gm-Message-State: AFq9FYLLtzvHC4jAsm/2tDECrEgBkQIXvIj/n1uHs2YwvNn0K/Y4hinj
 CMmnGt7cUrJc9iNJeNo7skPj0hNLKNrQIc+CD5nNb7CS/R/MuS0pzFY4qOROKP8FdyLVV1eWqLW
 pgyym//8hhsp5qXxcJT7EFuqM5h1FgJIlPg==
X-Gm-Gg: AYBFou17HtjXNNRg8KjP/ul7Nwn2DWJY15s1+6HfhBXsGibM7xvSZhvikN+6JNP2D0u
 APAq8SjPqBhccXkyDqffIZebU87qA6ULnDkU159JBcZ99Bh1L9n9+2D6+aio1k2JMB3U5CQLvAw
 hDA9w/T0b4ri2i1AqrGw+Ex6QIpGGbUPwFqntulBPHHSOpGC1aK1PWpxh9lIxTEegeMzpCkIwjt
 l4kgcGknU8tjPUOGgQ+uacQamUDfBK76+n0k2mRxdDbfosj8gtWrEL1vfMZ1vnumtG5C0sqAeBc
 OrxPEOiKfZNbsNN1MyF/K765LSB+0f8Hk3mI83CXi9h6TYK/7qScGr1L0C5oSB5ULk3n0JIur9H
 HQ4OzlDSKL67bjkfluCgNYjZ/GPqAwbBFGmtCmTgZH06sYbigEduWy1c1owjkrYerg1anUp4JUF
 vWpIkaPMJETXhYZlWgfBhv4LzDrrIxI0Vp2WMyHWZjNwJCzJawGA==
X-Received: by 2002:a05:6214:20af:b0:917:a58b:3629 with SMTP id
 6a1803df08f44-91b55561e5amr92768976d6.26.1791645468551; Sat, 10 Oct 2026
 08:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20261010-b4-pinephone-pro-defconfig-v1-1-55487e8c269e@protonmail.com>
In-Reply-To: <20261010-b4-pinephone-pro-defconfig-v1-1-55487e8c269e@protonmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 10 Oct 2026 16:17:35 +0100
X-Gm-Features: AclHuK9g55E0vTytXrPPsTBhm1T1ayCH7toYcAvwWvV2Zwf4iYR7Ti1b1AqYjSw
Message-ID: <CALeDE9OoUi0T17mJivPsCmMvEXms_P8vUU+NVYO0CzszFd-W2A@mail.gmail.com>
Subject: Re: [PATCH] configs: pinephone-pro-rk3399: Update defconfig
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, David Heidelberg <david@ixit.cz>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Sat, 10 Oct 2026 at 14:15, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
>
> From: Petr Hodina <petr.hodina@protonmail.com>
>
> Enable:
> - the ADC volume keys and the keyboard glue with phone key remap
> - the USB gadget stack with DFU (SF/MMC/RAM) and mass storage

USB support isn't there yet, upstream DT doesn't even have the bits
needed, how did you test that?

> - the watchdog
> - the clk/pause commands

What are they needed for?

The change log should explain why, not what, the later can be seen in
the change itself. Also it should be broken down into individual bits.
EG the USB isn't needed for keys etc.

>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
> Enable the pieces needed to drive the Pinephone Pro without a serial
> console:
> - the ADC and GPIO buttons with the keyboard glue and phone key
> remap
> - the USB gadget stack with DFU (RAM/MMC/SF) and mass storage,
> - the watchdog
> - the clk/pause commands.
>
> The volume keys depend on the separate "button: adc: implement
> get_code()" patch to produce key codes.
> ---
>  configs/pinephone-pro-rk3399_defconfig | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/configs/pinephone-pro-rk3399_defconfig b/configs/pinephone-pro-rk3399_defconfig
> index 81bc6d5400d..492b188f904 100644
> --- a/configs/pinephone-pro-rk3399_defconfig
> +++ b/configs/pinephone-pro-rk3399_defconfig
> @@ -29,21 +29,31 @@ CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
>  CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>  CONFIG_TPL=y
>  CONFIG_CMD_BOOTZ=y
> +CONFIG_CMD_CLK=y
> +CONFIG_CMD_DFU=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_I2C=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
>  # CONFIG_CMD_SETEXPR is not set
>  CONFIG_CMD_TIME=y
> +CONFIG_CMD_PAUSE=y
>  CONFIG_CMD_PMIC=y
>  CONFIG_CMD_REGULATOR=y
>  CONFIG_SPL_OF_CONTROL=y
>  CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>  CONFIG_ENV_IS_IN_SPI_FLASH=y
>  CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> +CONFIG_BUTTON_REMAP_PHONE_KEYS=y
> +CONFIG_BUTTON_ADC=y
> +CONFIG_DFU_MMC=y
> +CONFIG_DFU_RAM=y
> +CONFIG_DFU_SF=y
>  CONFIG_ROCKCHIP_GPIO=y
>  CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_BUTTON_KEYBOARD=y
>  CONFIG_LED=y
>  CONFIG_LED_GPIO=y
>  CONFIG_MMC_DW=y
> @@ -80,8 +90,10 @@ CONFIG_SYS_USB_EVENT_POLL_VIA_INT_QUEUE=y
>  CONFIG_USB_HOST_ETHER=y
>  CONFIG_USB_ETHER_ASIX=y
>  CONFIG_USB_ETHER_RTL8152=y
> +CONFIG_USB_GADGET=y
>  CONFIG_VIDEO=y
>  CONFIG_DISPLAY=y
>  CONFIG_VIDEO_ROCKCHIP=y
>  CONFIG_DISPLAY_ROCKCHIP_EDP=y
> +CONFIG_WDT=y
>  CONFIG_ERRNO_STR=y
>
> ---
> base-commit: ece349ade2973e220f524ce59e59711cc919263f
> change-id: 20261010-b4-pinephone-pro-defconfig-f83a60a75767
>
> Best regards,
> --
> Petr Hodina <petr.hodina@protonmail.com>
>
>
