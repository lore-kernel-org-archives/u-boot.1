Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4388AC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 13:54:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75D248700A;
	Mon,  6 Nov 2023 14:54:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UEthuX9j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FEFF87026; Mon,  6 Nov 2023 14:54:08 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AA1387005
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 14:54:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6cd0963c61cso2359528a34.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 05:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699278845; x=1699883645; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=glzYlQK+Tpg+eRKC67XkY0snIZ7KfAWbro6R6T6DHeg=;
 b=UEthuX9jb9OkIZ8cIOfoavNGxm+P+DTcyUjQynDm6SO+0+yqnl3/YH5vXqtW5w1h9h
 ++Tvg4f6CJiFgaQq72XIjvFHSPx0ZXFNuvPb09DL87r5Zzu3vLj2OXauqoDGgoKisRw3
 5IKCBo4yLmwrT+lqtHFZLcNcobkJnFrziJ/VVCqvVl/MCZPuwVuvOd4zNgJPLWpwsGq+
 +qUY3NJwKEEma47dl8Z91ruMASL9G8qXKrj2dvcX8XwNGyh4p9Qn1H2SlZ0cN8j6hDF+
 YTgQgUffJccfZ2IgxH9PHMqtafsGsYvn7cVTZOHSIx82sjtc4CfAVBS0bf3fR3vwKRN2
 BgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699278845; x=1699883645;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=glzYlQK+Tpg+eRKC67XkY0snIZ7KfAWbro6R6T6DHeg=;
 b=GXnyn6Z5pZY8EfEc1MjzHxekUlBYNOMJwSLix0P0tPywu4Bn6GkS5yR+R/Ppcb/JHH
 q9DO3GqDEaYEp/8pag4SS9WTQEw54ZXg+RZ6MrZjPgkvc70HrpRJ1h4uoE5EqiXpdERb
 yTpcGrVn7DFCbuyJNLlJW0IEq37kwtDZXLNJLvWtoNEIeb+Zbr0RZ3vC5tqHlN4OuKGE
 qc2PSdQqARuaSk+Qqn4/xs1F4tE6XcoJqMRDMqLdLTGyqNWob8HQo9tAUMBLFKLyj407
 dzecJcSGr/jMoWwXEahBXChfmeCeTfcsIZ7xfOldNdtkgq6bGJoG8YwDfE0XX7Tm84Zt
 azjQ==
X-Gm-Message-State: AOJu0Yxl/39lfHIAjBYOo96/yQBWK+ZhyUGgxiWHJtbZDajkJJBCogQa
 KB/LC5TRgmNR3KfXnPacR7Q=
X-Google-Smtp-Source: AGHT+IF9etcOYqVJW8Db/O5WkM/ZEGw0KxQk2QEV4Ps/08IZHxat0FJ+xnR3f346sL/aWhdhQo6+Ow==
X-Received: by 2002:a9d:6390:0:b0:6d3:1e5a:d928 with SMTP id
 w16-20020a9d6390000000b006d31e5ad928mr13652446otk.9.1699278844670; 
 Mon, 06 Nov 2023 05:54:04 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 ki23-20020a05622a771700b004166ab2e509sm3395792qtb.92.2023.11.06.05.54.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 05:54:04 -0800 (PST)
Message-ID: <f546ba08-10b9-0cb4-4fa7-f7541dab1288@gmail.com>
Date: Mon, 6 Nov 2023 08:54:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 08/25] spl: Refactor spl_load_info->read to use units
 of bytes
Content-Language: en-US
To: Xavier Drudis Ferran <xdrudis@tinet.cat>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Stefan Roese <sr@denx.de>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 uboot-imx@nxp.com
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-9-seanga2@gmail.com>
 <ZUjdhAccsYbJS6AL@xdrudis.tinet.cat>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <ZUjdhAccsYbJS6AL@xdrudis.tinet.cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/6/23 07:35, Xavier Drudis Ferran wrote:
> Thanks for your work. I'm still reading... but...
> 
> 
> El Sun, Nov 05, 2023 at 09:25:46PM -0500, Sean Anderson deia:
>> diff --git a/include/spl.h b/include/spl.h
>> index 951e136b9ea..ecfc50e0095 100644
>> --- a/include/spl.h
>> +++ b/include/spl.h
>> @@ -297,10 +297,10 @@ struct spl_load_info {
>>   	 * read() - Read from device
>>   	 *
>>   	 * @load: Information about the load state
>> -	 * @sector: Sector number to read from (each @load->bl_len bytes)
>> -	 * @count: Number of sectors to read
>> +	 * @offset: Offset to read from in bytes, in multiples of @load->bl_len
>> +	 * @count: Number of bytes to read, in multiples of @load->bl_len
> 
> I'm no native English speaker, but would it be easier to understand? :
> 
> +	 * @offset: Offset to read from in bytes, a multiple of @load->bl_len
> +	 * @count: Number of bytes to read, a multiple of @load->bl_len
> 
> 
> 

I think it would have to be worded

@offset: Offset to read from in bytes, as a multiple of @load->bl_len

but to me these both mean the same thing.

--Sean
