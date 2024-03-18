Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3266BC54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 16:11:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4738F87D66;
	Mon, 18 Mar 2024 17:11:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B7EJzie5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20CA187E67; Mon, 18 Mar 2024 17:11:40 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F14787D66
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 17:11:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a46bd90e696so74125866b.0
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 09:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710778297; x=1711383097; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9Iq2buhSMcDNjIiADntnsvaScNb7INWKxZiNulIelFk=;
 b=B7EJzie5nM40i0XyUpox4cSNFsv8Mph0cOkMJDU+FFp/zye812JpzLsQb9K2we3MeV
 LUUY5LpU6N2IRvZkpl/PexRqp4YCnrA9q5qpBOZlnshmBl0D9wlIXGTyWBt/UBeFR5hI
 VSiXT6gwk9hXDTn6MTJ0gUUPesXCeIWTIo+FLKMc5tWqJUyox01Uuhnn/6OTJlVpDheS
 B8t11Kq8GxhYhCHr/a3A8v+j+Qn5bO7+WC4QTRQDFnvEeCJsxKUi2lqyjLoasi3Fx3UY
 AduumJ9AQUQl4e+FXqMd5DMrsIyERnOn6t0bc833AwbuKHsPIWXYTnric7jyTJL2W2K6
 gCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778297; x=1711383097;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Iq2buhSMcDNjIiADntnsvaScNb7INWKxZiNulIelFk=;
 b=OpBViXS70wBX4vHgD5N0sh/+N4O+YU8oxSLhH8B4y9aZHcNM+3Swl6e+SrtYYXdjgc
 MQB/BOwV005tL+dqvrJ8DnsZew8yub0vyvcsjzzDK2vmoZsBTRTU9JIcoLeabk8fROMB
 kWXlv5TuxYc0RQwajh1TRvHfuoJ64scECffgaQZNGCU5dmkBQLIW4blg8T1fRj0RffsQ
 zcbhaeFr9OvGBuXU8ihdma+7v2i03OxBD98tX17mxgDZzdzmB73qDBOCLRcA8Ncm2sS3
 9ytet/VgMxJSGufXdo4UM0w/nV8Ox4EWW667FXdDyLnUJFmdm6S2hutMRx7JivC600XG
 gYfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyhF50AB3arUfYEmFbojVtBX0iNK9i1j1uic6Z5Ebn5bijPwHwJRsotiy9997QBBWtyL85lbegcQHqWra982cSzmn9bw==
X-Gm-Message-State: AOJu0YzV+kPGq6abARLwjZ93QCUpQfjLQAySm6jTjo6zGT/uevLnnBJn
 MkLohaRi+LK+nCzGQzXFZnQ7Ow4YnmdgWc2aoAtSIcF2rs4g2B+P
X-Google-Smtp-Source: AGHT+IEiMEJXSwekLBEFn/7Ony+dLrrJ2jjdWiJlk8fsYImQhxXDkQ02F9HeQX144IGBTYUNIcDe9Q==
X-Received: by 2002:a05:6402:c47:b0:565:7b88:1cff with SMTP id
 cs7-20020a0564020c4700b005657b881cffmr7270154edb.11.1710778296674; 
 Mon, 18 Mar 2024 09:11:36 -0700 (PDT)
Received: from ?IPV6:2001:b07:aac:705d:d28b:f211:5934:fe23?
 ([2001:b07:aac:705d:d28b:f211:5934:fe23])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a056402434800b00567ed79ba53sm4669799edc.67.2024.03.18.09.11.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 09:11:17 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
X-Google-Original-From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Message-ID: <fdcd46d9-ec93-48ce-9be7-86a3662867bb@toradex.com>
Date: Mon, 18 Mar 2024 17:11:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: imx7 issues with Secure and Non-Secure boot mode
To: Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de,
 Breno Matheus Lima <brenomatheus@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Marek Vasut <marex@denx.de>, Tobias Junghans <tobias.junghans@veyon.io>,
 igor.opaniuk@gmail.com, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Peng Fan <peng.fan@nxp.com>
References: <4b64a9de-a840-4065-a530-f81155b4b9f2@toradex.com>
Content-Language: en-US
In-Reply-To: <4b64a9de-a840-4065-a530-f81155b4b9f2@toradex.com>
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

On 07/03/2024 10:26, Emanuele Ghidoli wrote:
> Hello,
> 
> I'm currently facing issues with our board, Colibri-imx7,
> regarding its behavior in different boot modes:
> 
> - Secure Mode (bootm_boot_mode=sec in U-Boot):
>   When running Linux in secure mode, the idle time management does not function
>   properly. The following error message is displayed during boot: 
>   "CPUidle arm: CPU 0 failed to init idle CPU ops".
> 
> - Non-Secure Mode (bootm_boot_mode=nonsec in U-Boot):
>   In non-secure mode, the caam_jr fails to initialize correctly,
>   preventing the utilization of the hardware random number generation. 
>   The error message shown during boot is: 
>   "caam_jr 30901000.jr: failed to flush job ring before reset".
> 
> I have conducted tests using both mainline and 6.1 stable versions,
> with consistent results.
> 
> I have also reviewed the following threads for potential solutions:
> 
>  - https://lore.kernel.org/u-boot/2536787.mZni4QDSI2@crypto/
>  - https://lore.kernel.org/u-boot/CAByghJZn8d91uFr5JXSR=jXcfU4engZP_=buOk7MNNjaVeigLA@mail.gmail.com/
>  - https://lore.kernel.org/all/20220608170223.1536594-1-festevam@denx.de/T/
> 
> The first thread leave me thinking the only solution is to use OPTEE,
> but the last email is without any answer.
> So, I am considering the utilization of OPTEE, as it seems it might address 
> the issues discussed in the threads.
> Could this configuration potentially resolve my current issues?
> 
> Your advice would be greatly appreciated.
> 
> Kind regards,
> 
> Emanuele Ghidoli
Hello,
we are willing to use iMX7 without OP-TEE.

I saw that this patch was reverted, cause it is supposed that OPTEE is always used on iMX7:
22191ac35344 ("drivers/crypto/fsl: assign job-rings to non-TrustZone")

What do you think if I propose a slightly different version where 
I put the modifications conditionally under an U-Boot config?

Kind regards,
Emanuele
