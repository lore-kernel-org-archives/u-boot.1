Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11277C197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 00:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1029C86D85;
	Fri, 17 Nov 2023 01:02:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MmIaeC16";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2D1586EDA; Fri, 17 Nov 2023 01:02:37 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7238386CBD
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 01:02:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7a67b9cd230so47228639f.1
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 16:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700179349; x=1700784149; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+C/0f0RwwMrCcpiivnqc0iwtsTAvMud5uUB5t84DlvE=;
 b=MmIaeC16TTgSVkGZGiP/IoSxtipti14xPwDZIZGKeD9rMVpu3eyyoBVMRGyn4PYpLO
 +S0bNhSJTHIhYmWNKYH/O9WTQo88HRTqwGxBNrXq7aLrCSmXuYhJVJNqJcIJgmwHG63m
 9cWuXn+5HuniXsapqPsuhY8ogYNWMtgbkKO6qI4uAPlQC1WURR6vbTrat2MKaM8PCnTr
 JpGFjsiALw/M1Dd74M2YnGGCpFQS6ld7vtR6ty/r/x6e7qc6eboJRDTwa4H/Xfk0SwL1
 nUP08ryLnh5tHfJfr7WOkaqvFgTqn0NiR9nlt4KFymfcmN22+lt2rlcwrVZ+FWmRjHEX
 cRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700179349; x=1700784149;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+C/0f0RwwMrCcpiivnqc0iwtsTAvMud5uUB5t84DlvE=;
 b=tPAv+bzEnqaWg/VlXoY3ow/XO0Z195OMu1C0XgW4XCZnPhDmh7wdEIesQye8owlgj+
 KP5dNQ5f7FKH2t453wgdk8QApbvgajpiEU+bkEvnxsSH20NmTNHm45EqOoFQzrd3Mlm5
 FNDnK/e/OyntVmS4rmGnGonaf7n9GmfrBU/R7bIPKnSnx0OuTDA5iFBOAMSwy2ErnBin
 h4sGHalZodlAxM0qfbKFggI9g8d3SJ+lBXHH6Ju/nbCrqatyo4XnLUsb8VrWPWh2g8xA
 HyteD5/ty4p63Mcl77cBSgi45D3Bwb5d2ccgEcWQJrxkAqHMFVF/wx6K7AH2b7GoXc5f
 /FtA==
X-Gm-Message-State: AOJu0Ywi/hBs7hoc4QZVcxIdH0ABjZbjijUjNWH2+EmPQqwzkKV3dulh
 6e6ajXUhKdT17tR3eW0aWRc=
X-Google-Smtp-Source: AGHT+IG7DD8CuYDK3wR3G6ILckPsZRml8ENJjFGrnHS60pf9bTdk2CN3qFtmeAv9wc4+vuam8NMqfA==
X-Received: by 2002:a05:6602:b98:b0:792:9416:9c7f with SMTP id
 fm24-20020a0566020b9800b0079294169c7fmr24740952iob.9.1700179349083; 
 Thu, 16 Nov 2023 16:02:29 -0800 (PST)
Received: from ?IPV6:2001:470:42c4:101:d821:af43:e0a8:c160?
 ([2001:470:42c4:101:d821:af43:e0a8:c160])
 by smtp.gmail.com with ESMTPSA id
 p18-20020a02b892000000b004648955bda2sm144282jam.97.2023.11.16.16.02.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 16:02:28 -0800 (PST)
Message-ID: <df0b432c-483b-5ebb-20bd-29800554b860@gmail.com>
Date: Thu, 16 Nov 2023 17:02:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] fs: btrfs: fix reading when length specified
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, u-boot@lists.denx.de,
 =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>
References: <20231111151904.149009-1-CFSworks@gmail.com>
 <fff8b725-1c64-4407-acb8-c47c258e6571@gmx.com>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <fff8b725-1c64-4407-acb8-c47c258e6571@gmx.com>
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

On 11/15/23 21:43, Qu Wenruo wrote:
> 
> I'm not sure why this happend for the EFI environment.
> 
> Doesn't the EFI runtime should also try to read the whole file? Or that
> EFI environment has specified the length to read instead?
> 

Hi Qu,

The Linux EFISTUB file loading routine (handle_cmdline_files) reads 
files in chunks, and not (necessarily) the whole file in one go. On x86 
platforms, the chunk size is 1MB, and the comments explain that this is 
to work around firmware implementations that have problems with large 
reads. On non-x86 platforms, the chunk size is ULONG_MAX -- which in 
practice means it reads the whole file in one exact-filesize chunk.

So, to answer your questions: "either/both depending on platform."

(The bug in the U-Boot implementation doubtlessly affects more than just 
EFI; I only happened to discover it while trying to use EFI.)

>>
>> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> 
> Anyway, the fix looks good to me.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>

Thank you greatly for the review!

> 
> Thanks,
> Qu

Likewise,
Sam
