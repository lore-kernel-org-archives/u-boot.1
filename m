Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2199C25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 17:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D480881AD;
	Sun, 19 May 2024 19:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VqzTGu0W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66450882B5; Sun, 19 May 2024 19:59:11 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23FAC881AD
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 19:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5238b5c080cso4451964e87.1
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716141548; x=1716746348; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=izTP+c6Efyrn3+fC+KaeZCoSwov7P7qtiaXsMEfO3j4=;
 b=VqzTGu0WfpMoZdeksKJtTT+Rih05dJhCRCdt5XMOU2Go4DpuvtQCBSW/+UZoyq+kaY
 /NZwaQ39hQHh3iwlRegMhJrQs8TxD34hiDIxdb569YDj58kigRGJGbl8X6TGC0/dv3E+
 jA5Tjpwr8x0LSczLcd0y2ASOvOxAnuK6nIqCDlRIHEFs9xna7Rv9z5mDT/eymSLDPTRC
 Pd2x5XkuEio/eGK7gJrXQXQHSLbMpqT0xfDJPVvREAXnzTqFFcwfCHxhpbYcKHLov3/J
 wQQLTnLFbmkd1ERx2C4dD4sifdikZJPZy7Ut1Jffu8v17sXm5rQAZaQcH5QLBVs5rSn1
 3b6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716141548; x=1716746348;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=izTP+c6Efyrn3+fC+KaeZCoSwov7P7qtiaXsMEfO3j4=;
 b=l39o1PFfr6c5ztPnmpYcfpquzlTUxxFFUDr/dr0kW9jAktQoz8uT4px72dVFqaJTUF
 nU9jDRifPcXzMB88qz6g4CFiQI81R52VRxKZbS3SKMb5Ym631i6sGdo4wjQetF0tqkwS
 0cMM68T45Sdz1mlCfS9hUyuqX3tcGcJ8ZWQ0NoM3i+nJW94/p12Z5vGB7tcdl9kZI+/N
 UETvB9n8PxYNRVV6h0RBbkmWvEP4Lu9/WdCvsuxDpjFZe+VzjW2xSoyu8nmqKguAgFnW
 lxnYMSv84TOiIgdBcuAZCsj3qFZppnlzLAp/PqAky8q8cxtwy0IJiG5z9p/K85e2+xVS
 SpBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxeLuEaTDkxXs5SCDt30SCYkZLbCN9sYInRC234I/w6YUWQGo6B4Wc7PhYdEhjqxY9BG7XaKnlWl34Ne5P9toqu4IkSA==
X-Gm-Message-State: AOJu0YwcDAlAOYfY0fD4V3XD7ynEly+UfZbxNwico0D5D5Z+qjq0Ii45
 un8ofUHQPK0YjxUAvhtgg+vmOcmcDe2jWOFg8khJx/JVonmgtJ+6
X-Google-Smtp-Source: AGHT+IHD+3A/xD/OJa19k/nMBmxp12pd1tX0FmV8fQDm95fpKYKNSJpjBYtXQnxAHf0mI2za2rDlHQ==
X-Received: by 2002:a05:6512:e97:b0:51c:17d5:b56e with SMTP id
 2adb3069b0e04-5220fb6819dmr22760891e87.11.1716141548131; 
 Sun, 19 May 2024 10:59:08 -0700 (PDT)
Received: from [192.168.10.30] (77-7-142-46.pool.kielnet.net. [46.142.7.77])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5752c2e2f2dsm1881576a12.29.2024.05.19.10.59.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 May 2024 10:59:07 -0700 (PDT)
Message-ID: <f81daf78-5fc8-4a35-8974-114dd82c164a@gmail.com>
Date: Sun, 19 May 2024 19:59:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] MIPS: Provide dummy acpi_table.h
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
References: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
 <20240517-boston-v3-6-1ea7d23f4a1d@flygoat.com>
Content-Language: en-US
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
In-Reply-To: <20240517-boston-v3-6-1ea7d23f4a1d@flygoat.com>
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



On 5/17/24 20:14, Jiaxun Yang wrote:
> Some drivers need this header.
> Provide this dummy header as riscv did.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   arch/mips/include/asm/acpi_table.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 

Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
