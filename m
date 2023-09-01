Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EFCCA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 06:37:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B6F2867D0;
	Fri,  1 Sep 2023 08:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="1GYrdqGL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A9D867EF; Fri,  1 Sep 2023 08:37:26 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 759B08619A
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 08:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3a85c5854deso1087526b6e.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 23:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1693550242; x=1694155042;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qL1FtPtxTU17xWW0/tcNg4aGfiF7Ju5cEHBHtjNOfZ8=;
 b=1GYrdqGLFRz1sbDiO/etDyjC7XkLuaxSsUPXVUHOYJbMYc5VjWhYuLs1sEKrXQgiJ5
 j/fvLaVCxhcpW6BPh9VqzY5HnS9kM6MgZTcRtsM2/A2gRiP/dTFLbunKhCRPOe7xh2/p
 pKMUioOCcAG4Xmc2ala7UUqv65uI9jeJxseiE1QQdVILHu1lVqWDA5XHOS7TIH+Jqbyb
 8ploTfAEohmN9Mbuu+ahrM6ZxrPUZv1o4WQIUoYBqjTZvnwUhzMpK5alf3mkfHO99XRs
 x4C4SSPMyXs+1l6gp3FGR4Y+DMUkkldwfI4IKC9GoTta/kmSlUC00z+S5CiAPzC6oLC+
 h7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693550242; x=1694155042;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qL1FtPtxTU17xWW0/tcNg4aGfiF7Ju5cEHBHtjNOfZ8=;
 b=OhRU4N/aG4mMt59VpyTsbhArZXT7fIy6dIa81bwx0irpTTktAUZ5pLqfvv+SvP/Rzw
 sxwVllWEX3DF7qejYR8Kmb3eqhXVQs3oQVRbme1x1yech252l3Ysor2bj/Z+GC6e6Wgx
 OxEXA2Fo+om402vzMqReKc6k9hg+MmdyYJcW1YXsZsbpu4KJkSOcOw5CCGq/Q59ImYbY
 0ZvYFJ31vF7S37uEyitsQgJhOFWxnsWQhdYlNZofkIfmiFUNdQ9Lujw692lUSbssPTra
 lQLxPsN3I2V5TZvI6NYioJrwaARfD/jnH9kza+BcfTHFb6Tp07A2+ibXujVJz9VnS9TR
 pVEg==
X-Gm-Message-State: AOJu0Yyby3ydD+cKYPKsSsZ7DMPqwBeddkRAbqEjgioSsyepwCG77f7O
 eEwDRkRNpz1Xjqv5QGCipkYu3g==
X-Google-Smtp-Source: AGHT+IGoMwnPuEGZOnMlZev7Wzy1PJeQ3HmKehZgEz7HXgdIM5HPSj8ZYrbsC9069hzt7NAC1CM7hQ==
X-Received: by 2002:a05:6808:1487:b0:3a7:9666:2a60 with SMTP id
 e7-20020a056808148700b003a796662a60mr2181820oiw.51.1693550241964; 
 Thu, 31 Aug 2023 23:37:21 -0700 (PDT)
Received: from [192.168.137.2] ([149.199.80.128])
 by smtp.gmail.com with ESMTPSA id
 v14-20020a63bf0e000000b00566089d5b92sm1908712pgf.63.2023.08.31.23.37.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 23:37:21 -0700 (PDT)
Message-ID: <e281230c-7cab-67af-bc23-98dc41954617@monstr.eu>
Date: Fri, 1 Sep 2023 08:37:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 0/3] arm64: versal: Enable CMD_KASLR and TPM
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, git@xilinx.com
References: <20230831032612.2729-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <20230831032612.2729-1-venkatesh.abbarapu@amd.com>
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



On 8/31/23 05:26, Venkatesh Yadav Abbarapu wrote:
> Enable the command kaslrseed and tpm.
> 
> Changes in v2:
> - Updated the commit text in the cover letter.
> 
> Venkatesh Yadav Abbarapu (3):
>    arm64: versal: Enable TPM for xilinx platforms
>    arm64: versal: Enable sha1sum command
>    arm64: versal: Enable the config CMD_KASLRSEED
> 
>   configs/xilinx_versal_virt_defconfig | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
