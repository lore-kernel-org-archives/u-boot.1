Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A045C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 15:09:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7376877CF;
	Sun, 29 Oct 2023 16:09:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698592182;
	bh=46hG+NsawETpi2wR0WVCGKZIy23MNxTFsdQiXxjRoT0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cdHCCNjb5iBSWnu+Ly25aFTCxch3qCiHnKpwsZjinq1tAgaJGyeFYH5eqcWRlFQtZ
	 Yexlbro6ad3rwAEN3bFHJdeQScOrDxM13qhe7yi54ZfBOFMOiHTk9/ftsHoLR3Q8xz
	 7BoMu0vScwI8b3jho10hXrGlKGMbmG+XWKgur8xx1T7X1rltzgmFIszTvbpplAbzvd
	 5ItLD3uUbBMGSC/pYXZdJAo5I5nbtkCCSRyCxKM852pOeVgkSdpqmLbIQv8joo0vBW
	 SfK9/WYJ0S41kWD4i5uuaMYGWMBw6grFnt30Sj3t67LO2GTM2CFxIxeXMqMn1Zv7zL
	 zZpvBQKMbVplA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7206F87102;
 Sun, 29 Oct 2023 16:09:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698592179;
 bh=46hG+NsawETpi2wR0WVCGKZIy23MNxTFsdQiXxjRoT0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZghLLRAaEzfxbf1wtiWbVKNjQ4CGq+A/wypYyjm6JY4A6B2eRUMAar12ZVihBs6Nw
 o3UYoIJ57xfR3fwRc4SW6+nfAmEezSdJ1sdvYq2ltPloZZFnTUtQqMsXc8PqiUKUP9
 /nCt483FP4SW1Mwvdb0MfGGTkhVUSBlsfFLjOmPN1nmfsr+sav3uV/EHNEMgy7ttMQ
 NO2GGtWgkclcpdzM3h4rJ8T5wUCpOpMzMOhCJi2nPlnPBBQSMgl/4hrK3I+gqWhpbT
 OnqtPqW+GiH+cwMCEanYT30y9W5zyE4VROQ10Uk5xSvJ7Or5DmVkxoFphTMRY9FgEC
 WYdZGWfqWMEuQ==
Message-ID: <359fd317-d337-45ec-8970-b31a715aaba9@denx.de>
Date: Sun, 29 Oct 2023 12:36:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: Pass through timeout to drivers
Content-Language: en-US
To: Hector Martin <marcan@marcan.st>, Bin Meng <bmeng.cn@gmail.com>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>,
 u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20231029-usb-fixes-5-v1-0-54bb13001f54@marcan.st>
 <20231029-usb-fixes-5-v1-1-54bb13001f54@marcan.st>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231029-usb-fixes-5-v1-1-54bb13001f54@marcan.st>
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

On 10/29/23 08:36, Hector Martin wrote:
> The old USB code was interrupt-driven and just polled at the top level.
> This has been obsolete since interrupts were removed, which means the
> timeout support has been completely broken.
> 
> Rip out the top-level polling and just pass through the timeout
> parameter to host controller drivers. Right now this is ignored in the
> individual drivers.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>   common/usb.c                    | 21 ++-------------------
>   drivers/usb/host/ehci-hcd.c     |  5 +++--
>   drivers/usb/host/ohci-hcd.c     |  5 +++--
>   drivers/usb/host/r8a66597-hcd.c |  5 +++--
>   drivers/usb/host/usb-sandbox.c  |  6 ++++--
>   drivers/usb/host/usb-uclass.c   |  9 +++++----
>   drivers/usb/host/xhci.c         |  5 +++--
>   include/usb.h                   | 10 ++++++----
>   8 files changed, 29 insertions(+), 37 deletions(-)
> 

[...]

>   	int (*bulk)(struct udevice *bus, struct usb_device *udev,
> -		    unsigned long pipe, void *buffer, int length);
> +		    unsigned long pipe, void *buffer, int length,
> +		    int timeout);
>   	/**
>   	 * interrupt() - Send an interrupt message
>   	 *

Can timeout ever be negative value ?
