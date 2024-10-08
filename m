Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B27CEFC31
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 16:39:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 769B788DD9;
	Tue,  8 Oct 2024 18:39:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728405550;
	bh=r9KIZw6MCr1558lntbtQZ//tgXPDcW6PQHpti3DBn6w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E357cQedHbwTly5XmYilKoKcLrrkjU7ItV6RQhNL+mOjzwFG7sbml6gflTCXOfdQ6
	 DqAVvnLQ70GHJ2ayayiCjqN63QJnGiIAnNK1yK9HFf839yA6RXw2+JHJNdnU2N95Nl
	 nP5KX53Mkz6yF/MUGYpV5b4k2pBx3x3CC6nUJgUCkyBcuftAxdPpNYysepTqUAlaQj
	 uJ/+JKpVD4j2uPdmcnaX5c3CNnGeEHdJJFRp26a/qIZ7UTPP1vKeL2YSZX0smerT+Z
	 s7P9OeMppCZG8TGSckqtf/i6w5G1GnTrsuTVqfXNrKNCGeeXKRB5umSsQnj4uIfrYs
	 l77o1fsP28vCQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 770BD88C63;
 Tue,  8 Oct 2024 18:39:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728405546;
 bh=r9KIZw6MCr1558lntbtQZ//tgXPDcW6PQHpti3DBn6w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QhZROFpR7qlxN84tORxgOQIUSgzC4pOANXLjZMcqfuJ2UGAIR2xCd6HW1JWfJTbke
 b8LPrj3Ntg7zB/enHYxdHUiEPfG2KIqs0S/itpLAmE5rx5Kc3r4xTkW6UnKFsHOIiA
 qOVv9ANitQtm3u5zRNzCc9HkxUtIsXkhS+rBVSwb+7viZmQOJbdOoaJTz8IDychjC5
 bFQpndyFVNnmjK+/oUkAVTfyafN9z/qKOGgvdj8e418TBfnDiNnw+SsCp5+WyVLAZA
 vcHJ8jGlLnS2notcxqL91sRS9GQBgjgEB4uxxx79J38+usxbzRFKKYTkfr2z9OjsEZ
 w7ZwBr+eugz3w==
Message-ID: <5c4a2d81-6f84-4ea8-af55-05dd8c7f4aaa@denx.de>
Date: Tue, 8 Oct 2024 18:15:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/7] usb: onboard-hub: add support for Microchip USB5744
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241008154139.31204-1-venkatesh.abbarapu@amd.com>
 <20241008154139.31204-4-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241008154139.31204-4-venkatesh.abbarapu@amd.com>
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

On 10/8/24 5:41 PM, Venkatesh Yadav Abbarapu wrote:
> Add support for the Microchip USB5744 USB3.0 and USB2.0 Hub.
> The usb5744 driver trigger hub reset signal after soft reset.
> The usb5744 hub need to reset after the phy initialization,
> which toggles the gpio.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Reviewed-by: Marek Vasut <marex@denx.de>
> ---
>   common/usb_onboard_hub.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 6ef9c87fc9..53b7a9c3ba 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -89,10 +89,21 @@ static int usb_onboard_hub_remove(struct udevice *dev)
>   	return ret;
>   }
>   
> +static const struct onboard_hub_data usb5744_data = {
> +	.reset_us = 10000,
> +	.power_on_delay_us = 10000,
Sort the list here please.
