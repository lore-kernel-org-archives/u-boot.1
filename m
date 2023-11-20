Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FD6C197A0
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 10:32:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82F928712E;
	Mon, 20 Nov 2023 11:32:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hOclQ9ZI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6D6287549; Mon, 20 Nov 2023 11:32:26 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46C528751F
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 11:32:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=inindev@gmail.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1f5bd86ceb3so1576287fac.2
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 02:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700476333; x=1701081133; darn=lists.denx.de;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmGZTcc5PSA3jvzmqaPDBw4H1+x544PQIcCM/Muuzd0=;
 b=hOclQ9ZIHKLC7fefYhFZADsoUtfKSuiaKb0syo1d+1NW3qz+QTXSVCMpbBknevVgp5
 c4x1Z7mJvD0MJo7pR5bBJoJOGpOOcEoeIAlzgHLtbhUIGn5lTS33rnI0P7+sfMHcRJwf
 p76QzheG5y9cnm6T/D/YUquRkjy2olkjk4everYxUzrj15X9yvHXu62N2lVnEC7Su6f6
 UKAgP4EkkV7ZPpbuNQroF0LcAP8vJ7iXSZJ9gB8VzPzooHkIW2YCl9HzyL3mwVKgbf1P
 RYaiIzH88HZaROGQIvvFRdmMrWcru7hvtiTSSlbUZDU0NKZB702Sdt2/oxaZhPSR2nHn
 LpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700476333; x=1701081133;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fmGZTcc5PSA3jvzmqaPDBw4H1+x544PQIcCM/Muuzd0=;
 b=Xn60ZEhRgKlQAgQ8Coj+s2hdkrilu9Sgkb2tIzclkbUvtMRdpc2qRbiuly6t/ZkFxX
 vpK8k+i49MqOXriQmlHcNMMdUYFmHV88pIEsqdUg5YQq/Ja4WK2jYykIOiNBa3eDDw/m
 sn4eKqH8ZL850FCq93BZO5jtHzqUE1FS5OkA/vpZgTAaaT+0M/oS27P/1ZyaVLFDZ8QZ
 2IYvLEjJ1SSGJeWbGBt9GufUTp2wR6QHIS6JaUbeKJMAqZkheKtroX2mSFpyklRli0rb
 JPTgWeKZBd3/iJ4YxJm6HxI3ynITZ3hsPpF+hKUgrYmXr+dUsKg6hXf2x4yxQH1P4aNo
 wC5w==
X-Gm-Message-State: AOJu0YydQb4szFatewr6V2uX2vYx9OGT+jasZ/xDRrkpIyMfLft97Z4f
 0G1SqowiQnG/Nf5Vt2Nb8EOElSXeKf0=
X-Google-Smtp-Source: AGHT+IE6siWquf88aOW9SfxvnFoVNNEfMnDC3vMJv0W7olwZkh+zJfLpY4ye/bhr0Sr9QMhVsVMxRA==
X-Received: by 2002:a05:6870:37cd:b0:1f5:c2bb:ea9e with SMTP id
 p13-20020a05687037cd00b001f5c2bbea9emr8918496oai.30.1700476332740; 
 Mon, 20 Nov 2023 02:32:12 -0800 (PST)
Received: from [192.168.20.212] (cpe-107-15-246-199.nc.res.rr.com.
 [107.15.246.199]) by smtp.gmail.com with ESMTPSA id
 g15-20020a05620a278f00b007743671a41fsm2549446qkp.72.2023.11.20.02.32.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 02:32:11 -0800 (PST)
Message-ID: <55aa1478-8342-1183-2917-15107374b8e2@gmail.com>
Date: Mon, 20 Nov 2023 05:32:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] starfive: visionfive2: add device tree overlay support
Content-Language: en-US
To: Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: Yanhong Wang <yanhong.wang@starfivetech.com>, u-boot@lists.denx.de
References: <20231120023549.13902-1-inindev@gmail.com>
From: John Clark <inindev@gmail.com>
In-Reply-To: <20231120023549.13902-1-inindev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


> device tree overlay support requires fdtoverlay_addr_r to be set
>
> before
> ~~~~~~
> Invalid fdtoverlay_addr_r for loading overlays
>
> after
> ~~~~~
> Retrieving file: /boot/overlay/rtc-ds3231.dtbo
>
> Signed-off-by: John Clark<inindev@gmail.com>
> ---
>
>   include/configs/starfive-visionfive2.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/include/configs/starfive-visionfive2.h b/include/configs/starfive-visionfive2.h
> index ff43113f24..29c74470c7 100644
> --- a/include/configs/starfive-visionfive2.h
> +++ b/include/configs/starfive-visionfive2.h
> @@ -40,6 +40,7 @@
>   	"kernel_comp_addr_r=0x88000000\0" \
>   	"kernel_comp_size=0x4000000\0" \
>   	"fdt_addr_r=0x46000000\0" \
> +	"fdtoverlay_addr_r=0x45800000\0" \
>   	"scriptaddr=0x43900000\0" \
>   	"pxefile_addr_r=0x45900000\0" \
>   	"ramdisk_addr_r=0x46100000\0" \

Additional detail as to the selection of 0x45800000 as the location to 
place fdtoverlay_addr_r:

"kernel_comp_addr_r=0x88000000\0" \     "ramdisk_addr_r=0x46100000\0" 
\   0x41F00000         "fdt_addr_r=0x46000000\0" \     0x100000     
"pxefile_addr_r=0x45900000\0" \     0x700000 
  "fdtoverlay_addr_r=0x45800000\0" \     0x100000         
"scriptaddr=0x43900000\0" \    0x1F00000      
"kernel_addr_r=0x40200000\0" \    0x3700000    
"kernel_comp_size=0x4000000\0" \

