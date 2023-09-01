Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22B9CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 06:37:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D93E286205;
	Fri,  1 Sep 2023 08:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="V7fmGp5Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A2B486564; Fri,  1 Sep 2023 08:37:20 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 225918619A
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 08:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-68bee12e842so1345038b3a.3
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 23:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1693550235; x=1694155035;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=av2NHjNEPqJ1kBItL0dZ44f4D0HJz8yMRzoLxsLph+8=;
 b=V7fmGp5YtrdIUdvgW3mrz9/OvHmGta8UKbuY9BbVMK5EILTDQoG6hAu8QxKLsoYivh
 ympUO2unAy+CWjGG/spDTedOk4QPGZPZfSCT5FWByPlc28isaCkEK3qsRMRJxa3jf4+D
 SO/rsLUbsewfd6sN7fmd8qzJ44JzQt4JNmN3pm3pyihdrBInHfOj3LC7SoXDN8MdrbiK
 VVT5CgD14kEB1tn+04SaEaaosSq3m43IGW2MHgxqDjJp8JTg9FyihCEn+HxFAzZ1uNpZ
 cVQOp/iKP6Gn8CHwseyUrjzMxYazLO5GvqiOGfT+xdIv9m0X50kZor8oT2MioqByoPeZ
 SVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693550235; x=1694155035;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=av2NHjNEPqJ1kBItL0dZ44f4D0HJz8yMRzoLxsLph+8=;
 b=TZgAbFQE+Xl/v0QCGD3WM+GOGQKS7paemrNzXNw/o9VP3e+lzRgEvqoySQmD6e1qy5
 PzvLzjP62I1+GNwDUU0g23LiWMbdNaNfGXZjW/GmuV97q6u0IcGW8lex52vsz03WH9jA
 mu0arhlwC/w3zknU5IK/20ZGUXDi50YLgyyoDXqy6w4HWIIUamYVlhzVXQDroTMYdM3o
 E+3fLNxM1nI3Xmqt99IOQPpWNl9SodSvcD9uaLMO54sPQidPrdBQGPNHJCUjouRMe51y
 qKqWPnA5MN9pcuJJWEgbqb9o95922NxlQ1YDb6asjjswCGWobBFcjZVBHP53+WJG2VUv
 Lngg==
X-Gm-Message-State: AOJu0Yx6WNVZV8+xVRp1z2Xjz02Blg98WfhTJjX8J2HNuFRB4TUYklv8
 AVg6WRDyDAdcrqjifM3AVcwwSw==
X-Google-Smtp-Source: AGHT+IGopeOHE3ODPU8bJJKe+nG0BH7MlbSXEztFJiJcg/paQzQJi+I6txjMlDavL6x43E06+9sNBw==
X-Received: by 2002:a05:6a00:1ad2:b0:68a:6746:fecb with SMTP id
 f18-20020a056a001ad200b0068a6746fecbmr2092097pfv.5.1693550235218; 
 Thu, 31 Aug 2023 23:37:15 -0700 (PDT)
Received: from [192.168.137.2] ([149.199.80.128])
 by smtp.gmail.com with ESMTPSA id
 c17-20020aa78811000000b006884549adc8sm2259787pfo.29.2023.08.31.23.37.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 23:37:14 -0700 (PDT)
Message-ID: <efd3769c-2206-9152-bef9-81755c3c0158@monstr.eu>
Date: Fri, 1 Sep 2023 08:37:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/3] arm64: versal-net: Enable CMD_KASLR and TPM
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, git@xilinx.com
References: <20230831031658.2203-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <20230831031658.2203-1-venkatesh.abbarapu@amd.com>
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



On 8/31/23 05:16, Venkatesh Yadav Abbarapu wrote:
> Enable the command kaslrseed and tpm.
> 
> Venkatesh Yadav Abbarapu (3):
>    arm64: versal-net: Enable TPM for xilinx platforms
>    arm64: versal-net: Enable sha1sum command
>    arm64: versal-net: Enable the config CMD_KASLRSEED
> 
>   configs/xilinx_versal_net_virt_defconfig | 6 +++++-
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
