Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7DFC28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 08:27:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2D74801FB;
	Wed, 12 Mar 2025 09:27:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GPOe5W21";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 727B8805D7; Wed, 12 Mar 2025 09:27:17 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AF3D801BE
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 09:27:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso1643961f8f.2
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 01:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741767982; x=1742372782; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZTUEC864gNKOW3+73uZzlbX9NnOrWnem2kxUF8+A6w4=;
 b=GPOe5W21EgmFHqlvtFHOtS7SMvQoIuf+96C5to0NNFi/uvdWmvBVIlqNl0uXSsRUlC
 xnr1nz7PQ6hTsZxhwStDA7lnZXQINHwp1ZXynrjGKi4VhSKHIPpxVvxtzXYeNcDlCeLz
 oidBj2QsQio1OAp4wKUX90lTHpnnrnR2E4IlW3SljVKzD1OkLrpeHQoRyqi82lifi/Gy
 J3E6+fjLo/8NRasHmCMa40/QgTM4oCC/FdSaWwhSS+N8IvLwVPSnhxKD9kAquM1xfj/i
 14YTM7Cd6HGXlxE2b0hQ/Grp3Hx7mHhOPVN2z8Xygms5xkiV9TwiWsE8fHCUdDiiRvN2
 OAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741767982; x=1742372782;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZTUEC864gNKOW3+73uZzlbX9NnOrWnem2kxUF8+A6w4=;
 b=uUU3D0bCCOV7hQMgJKEmNoUZ5EUuPVhQwne5zxawOG121WRdhjAKceT6bePPWxhfwS
 HK2Vs2fyK2AlLJ9hbzGmtdajkF/9P0lh97GDXODrkh1aIsQOpbs4+1q3WeTsWe58SVbn
 TiBOD2Q6RszzkfWhOApZat6QaR8DjeeJVxMKqM3RBV2moNwSp9mJ9Cl93whkYfGU8VMs
 gpEWqVchRHiHldaLcJw//fSVpk0Qquo8sivT4klL8ImMwB6AnkFg0TWImU5ypKmEar9D
 YvbaMI5WtfuqYxTPJcsTJnlcW4kcBz41Pcx2yZbUnli2fWfa95Mv/7C8KQju/FsSrG20
 WXzg==
X-Gm-Message-State: AOJu0YyxrG7N4+Ld1aXMvnFS5novnCQDokX0uR6frtGYS6qAjLj9P4xA
 PwCC+NTzUqTBPq//jk+dgYHcfC9JtZ4xTJrtF5xGAsdcpUBORoJia+82oFMoqVu/RuYA2tPxqSi
 GdAo=
X-Gm-Gg: ASbGnctjc2H9+/8HvIORjt3iUsmF30uHZdP74LsMpmItVXjGOEmngXGetUCl7XtZH6s
 Zyu3nDJ0YELwNeWYwGC6CMxFxc7j4Dw9bvzvEslFsYypEP7sfbbYAMBwHqzEjcN0+e7tXV9G85V
 +5/rQLye75m42lwnm68nhkCWJY4s8I3MO1OTrnUOPzWYP74/nj8qa4sDxeCbrHUBVSAzqGPDbw4
 DQbZE7vgEsvnLh7LtVbeV/kVMH6PacC7HG5hxnC1/eR+mb4eKgF4uA2UeOto3CBxoMMRZLmjEDX
 zXLVvpJ5P1Y8Q9y6pr2+63xma+FairMGBrKcvxCfGPgUbly/I9LosW6YfY6qCICXLQmnt+8d9bL
 qNw1FCFowPu9ag6TKLKlLnA==
X-Google-Smtp-Source: AGHT+IEoEMH/WjVC9On2/NlhDeHKyofHMwirwcMKvH1OclRRKnlQ9F4JcdczD/HAjG0I+I+jpQU+NA==
X-Received: by 2002:a5d:648f:0:b0:391:3150:96ff with SMTP id
 ffacd0b85a97d-39132d57d7emr16212920f8f.32.1741767982487; 
 Wed, 12 Mar 2025 01:26:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:30c0:6d8d:9e9:d83f?
 ([2a01:e0a:3cb:7bb0:30c0:6d8d:9e9:d83f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfdc5sm20003992f8f.25.2025.03.12.01.26.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 01:26:22 -0700 (PDT)
Message-ID: <bb52b0aa-044a-4081-86f2-e7e23187f911@linaro.org>
Date: Wed, 12 Mar 2025 09:26:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] net: lwip: remove superfluous newline at tftp help
 text
To: Michael Walle <mwalle@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250312073750.2281630-1-mwalle@kernel.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250312073750.2281630-1-mwalle@kernel.org>
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

On 3/12/25 08:37, Michael Walle wrote:
> The help text has a newline at the end which will lead to an empty
> line after the tftpboot when printing the help overview. Remove it.
> 
> Fixes: 4d4d7838127e ("net: lwip: add TFTP support and tftpboot command")
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  cmd/net-lwip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
> index 0fd446ecb20..249556243d6 100644
> --- a/cmd/net-lwip.c
> +++ b/cmd/net-lwip.c
> @@ -17,7 +17,7 @@ U_BOOT_CMD(ping, 2, 1, do_ping, "send ICMP ECHO_REQUEST to network host",
>  
>  #if defined(CONFIG_CMD_TFTPBOOT)
>  U_BOOT_CMD(tftpboot, 3, 0, do_tftpb,
> -	   "boot image via network using TFTP protocol\n",
> +	   "boot image via network using TFTP protocol",
>  	   "[loadAddress] [[hostIPaddr:]bootfilename]");
>  #endif
>  

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
