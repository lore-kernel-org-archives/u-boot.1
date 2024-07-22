Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023BEC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 10:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78D8488276;
	Mon, 22 Jul 2024 12:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="UepjY7H5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8CFC88263; Mon, 22 Jul 2024 12:09:24 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2ED287E50
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 12:09:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7fe8d029fbeso161506839f.3
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 03:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1721642961; x=1722247761;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zFMn63Y6UALjTceLm9QpUxvJ+xBtLUiM8IOCsYhYz6Y=;
 b=UepjY7H5hKybD7q1fNlvtUm5U76kRq3dvASvhKaFFDdtlHxZOgPTpbJLDeE0Ke8BZz
 LaoVd1+8m6bkCLOvnkA+4IWoTeskoUKAh0IUnKmoX/oYLpNiSWCZ7UYTm0h+Pu6kixym
 ahr3UX3Yilqg8bloCIgac0nGr29uxyQaJNMh24DvLDpe+VTwvcHCLb7L71rtYUhqrnS4
 VRk7l+MYgi8lniW4Gd41vG6ziEQ2AH/mhe4Npd1vXGhaFWX42cVLBdypg9D2iiglBWvg
 cYo7pGYh0FCyFx3muGea2P1FfjRD+7UfDhPQpr9sWLqgln8ByKxWo7JpFWaz5usByisS
 CYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721642961; x=1722247761;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zFMn63Y6UALjTceLm9QpUxvJ+xBtLUiM8IOCsYhYz6Y=;
 b=jKYD4ujHQ6kAxl6jsnTojLLskfrrjVeAPK9XMoCU9a+Nh1u7jdJmOEnZIhvhJPCgv/
 AeC6wI0D99Ero92y1yN5wOoIRIbBrEYs/veFF5LmSwLvCqAHz6kgRnatiAmFHcV4y2IA
 o+4WwGAW3qn5WnoxdAiRTYH0yUNwre2vW8wuYbyb4rSVRZRoXikLrEmjQzs8F0o47TGE
 47u51NatXYaKMKFtzVsWiM3b7KvtVA58lJLmSIUrV2xV9IwQ2uowDmRXKgb7xClfZ5XR
 uDKTAMuWv2BK6qtZDB8tB+b9g8WeZ5rk70R9GMkyKANOHWdaJZXk/plmj+6qrquJt+fj
 w2cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0mDsJ3zQk9jnMe/ca2uYSgUexc7I3VACuEemnvSxeOObTQ3bl04DnrldHVIlTlG+IwXrO1C8VH6N6sUYvmjQchB0PDQ==
X-Gm-Message-State: AOJu0YxccdyKHX87RjideG/iKnLCfDMGKydXwrLYtUAWt4ZN2xuYsD8s
 WOhfjU7KGAqj9jVz38OWI2m0izvQPhLvN7IRKiPjG4cG7Y8+CIUPe+DLNg2hmg==
X-Google-Smtp-Source: AGHT+IHxRu04HV3eqcmBXiT//P1DULpXC0Zht0dkl38HKYNpW2ogtmhHatTsyVwHOyNVp8MI94cGaQ==
X-Received: by 2002:a05:6602:6d05:b0:805:3d47:19d6 with SMTP id
 ca18e2360f4ac-81aa9bce5ccmr827004539f.6.1721642961394; 
 Mon, 22 Jul 2024 03:09:21 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c24284184fsm1150349173.63.2024.07.22.03.09.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 03:09:21 -0700 (PDT)
Message-ID: <1d4f445f-dbe3-4701-a90f-b65b656bbb59@monstr.eu>
Date: Mon, 22 Jul 2024 12:09:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/37] board: opalkelly: Remove duplicate newlines
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
 <20240719104948.323791-24-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <20240719104948.323791-24-marek.vasut+renesas@mailbox.org>
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



On 7/19/24 12:49, Marek Vasut wrote:
> Drop all duplicate newlines. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
>   board/opalkelly/zynq/zynq-syzygy-hub/ps7_init_gpl.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/board/opalkelly/zynq/zynq-syzygy-hub/ps7_init_gpl.c b/board/opalkelly/zynq/zynq-syzygy-hub/ps7_init_gpl.c
> index 0cbfc08183c..1c63277d928 100644
> --- a/board/opalkelly/zynq/zynq-syzygy-hub/ps7_init_gpl.c
> +++ b/board/opalkelly/zynq/zynq-syzygy-hub/ps7_init_gpl.c
> @@ -254,7 +254,6 @@ unsigned long ps7_reset_apu_3_0[] = {
>   	EMIT_EXIT(),
>   };
>   
> -
>   int ps7_post_config(void)
>   {
>   	return ps7_config(ps7_post_config_3_0);

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
