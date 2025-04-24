Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37999C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 13:15:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 360928056A;
	Thu, 24 Apr 2025 15:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BR6rD2ke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40219806FC; Thu, 24 Apr 2025 15:15:48 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20A5D803CC
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 15:15:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c30d9085aso745784f8f.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 06:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745500545; x=1746105345; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wwzoaqPBDniqUYOBFvctJSKh2bPT2o2AIwd++zuLUb4=;
 b=BR6rD2keOpNNlgPfFvuLeQdpxE1IvGrECFCtz1ZNwqhprdsPRQcPfElG/511lfbwd5
 lIqAXBynBcNdBEvH063XceZY7/6w0hG/wh+GiPKlwcvhu4uW8FYCjriAdD+wSgq7BLCJ
 doDl+cwoy2dOa9HHlqOh6IxjImJYFinioitHfO7W/UGsokWziQzn2Dp+98SeC6oDULS7
 TW1oEzARWdQG99TpyLRu6jCDiCUfIYixD553KML2tfHiovtZ27CkDw5Gp0RCHiQLVrso
 HXdJraJEUC5dMmqKKxiyMMzms/yhNBUr966iMJ92HGznSOsjIWAKuyUa+r6S5yLYprHw
 Nz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745500545; x=1746105345;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wwzoaqPBDniqUYOBFvctJSKh2bPT2o2AIwd++zuLUb4=;
 b=MFi08HrBACKXfymxGCV5OhTXXp3OWzXkgoL1alJ0IvDcJqc3a00dtMq3g968tE4ygJ
 HV7T+6AdMr9oWcppHH/4CcvEkD+X4aaTyV4lrm0Ir24b600XFQ0Layryg7Bb65w5+nmQ
 woUJHRL3Lq+7yxbRjq+yWHdVGVYqfdKSUrTAuuy4G6K13vDBRL2ythgfmXTFwcQeBOD9
 Wx/88vis6qGW0wUjLTV84ENLhnimWV6+kpT2bZsilMKXLADFh7B73SOCWVbgmTTNdRQw
 DnMeGhB++dxYEZH+K9m8uNq65+Dps+E1k6Ad5xCjDhK57DIjghCsmK+qzaTHTKAPpCql
 ObvQ==
X-Gm-Message-State: AOJu0YxdGqaFFyu1ZH8YZoQS6vKeQ79AvvCuw5JmIOeX7XeER/9Aqq/Z
 X1ixCpfHBLg1Z5ZjSaDmBB8jPV3SdPCSzRqQA7+vseuFYWdU8zhjfa+mg9qvyNw=
X-Gm-Gg: ASbGncsGjOG7FJTGoxiXCSOYZoCHQtHqLPvPs2dYatu+1zmMxz/qvEj5l7obw4aqQn2
 AzLunRc3tgcGmgkhEqnazJMHY25FvkOdMhj/ExfysA4tEkkLzwxHRBBj7Mg87jpvDZl1R/EK06X
 MbrHZ/EAh+gazihN9GhydssnXP10spooWjLVs5gVUdWJVpScbm2sgjolTGAeov2/KPiQKJQIBvF
 e2wv6UQzHNj/tsfCxXoCueSS3mcxxB345VTiRlapX0UBYIz/yziCt8UOKJTu+dpp0EYMw/zFKup
 byaLxT7TpofV5p8x6HI09CmEPnTmzpQK///ByOd3qxoxxoZnrSZAYX3LYyG3x3cncS8YhpuonDt
 BlhxpaWfO2SWzI6vfEA==
X-Google-Smtp-Source: AGHT+IEuJtNe9sG+TYJw0mTej1rv0UkelzjpV/E/g0O5/gtX0EZsudP3nrNAc/GW/EpKAG6Jb5owjA==
X-Received: by 2002:a05:6000:1865:b0:391:2f71:bbb3 with SMTP id
 ffacd0b85a97d-3a06cfa645cmr2247200f8f.46.1745500545453; 
 Thu, 24 Apr 2025 06:15:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:1455:2ba2:63a:a22b?
 ([2a01:e0a:3cb:7bb0:1455:2ba2:63a:a22b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d5327easm2058626f8f.74.2025.04.24.06.15.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 06:15:45 -0700 (PDT)
Message-ID: <b4edcb8d-9287-46ab-952e-cc123c5201fb@linaro.org>
Date: Thu, 24 Apr 2025 15:15:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PXE is broken on LWIP
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>
References: <c301b266-ba62-47c8-a484-4006dab5036a@canonical.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <c301b266-ba62-47c8-a484-4006dab5036a@canonical.com>
Content-Type: text/plain; charset=UTF-8
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

Hello Heinrich,

On 4/22/25 16:54, Heinrich Schuchardt wrote:
> Hello Jerome
> 
> PXE booting from standard boot with NET_LWIP just stalls if the server does not respond:
> 
> Using ethernet@16030000 device
> TFTP from server 192.168.99.1; our IP address is 192.168.99.47
> Filename 'pxelinux.cfg/01-6c-cf-39-00-2d-29'.
> Load address: 0x45900000
> Loading:
> 
> If a server cannot be connected, the network loop should be exited.

I agree. I was thinking the lwIP TFTP app would handle this but it
is not the case. I have a patch for this, which will abort the transfer
when no data is received for more than 10 seconds.

> 
> When pressing CTRL-C multiple times I see crashes with a call chain
> 
> tftp_open -> sys_check_timeouts -> memp_free -> do_memp_free_pool

tftp_open() in net/lwip/tftp.c does nothing. Do you mean tftp_loop()?
> 
> I guess in sys_check_timeouts() we must remove timed-out timers from the chain to avoid freeing them twice.

I can't reproduce this crash with qemu_arm64_lwip_defconfig.

$ make qemu_arm64_lwip_defconfig
[...]
$ make -s -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
$ qemu-system-aarch64 -M virt -nographic -cpu max -bios u-boot.bin
[...]
=> dhcp; setenv serverip 10.0.2.1; tftp
DHCP client bound to address 10.0.2.15 (3 ms)
Using virtio-net#32 device
TFTP from server 10.0.2.1; our IP address is 10.0.2.15
Filename ''.
Load address: 0x40200000
Loading:
[Press Ctrl+C]
Abort
=>

Which platform/config are you using? Can you create a reproducer with
QEMU?

Thanks,
-- 
Jerome

> 
> Best regards
> 
> Heinrich
> 
> 
