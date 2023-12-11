Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D310C4332F
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 19:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D85287763;
	Mon, 11 Dec 2023 20:08:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="NYWlHQG2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EABDE87772; Mon, 11 Dec 2023 20:08:35 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73F55876E9
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 20:08:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1702321712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dfbtfpavpJjL6bBzx0CrAhhFYwDAhwC+tOxLspAb7w4=;
 b=NYWlHQG2hryoZFbnhV8Lb6GHeuZ0SvXUf5V2Uy1pHbuUFJGPwET0FWf+e8KPUcNuu8y5X9
 I8tZcSGonq6QK/xxAMJSw32H47zpFH/LxlppodpR9CKyjfCga48AXIiewD3P/F3zc4XF9r
 wszO4e9Ps/mG1HZZwzmQ5MDAgbvUsKYw5e8ZZ5AhI52fhjY9TC+wQuphy2KH4ja81th4mU
 fMLdXupWvLJLj8EU2hPSfvKdX2VyQVhXGHTtUEcxfUu7FgJsBNYkxbEnx5hGzpgrX0MJU9
 ag3BIL2ZMHd2P7kseKpC7ez2XbI5NWeVVf9HDKqp0Hy9F11EfAcJAGZ2hUpujA==
Date: Mon, 11 Dec 2023 20:08:32 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg
 <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] iommu: fix compilation when CONFIG_PCI disabled
In-Reply-To: <20231211-b4-dwc3-qcom-v1-1-46275113b4f2@linaro.org>
References: <20231211-b4-dwc3-qcom-v1-0-46275113b4f2@linaro.org>
 <20231211-b4-dwc3-qcom-v1-1-46275113b4f2@linaro.org>
Message-ID: <e99c00cbe8b0cf7f8a4c9217d5298625@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2023-12-11 19:41, Caleb Connolly wrote:
> The dev_pci_iommu_enable() function is only available when CONFIG_PCI 
> is
> enabled, replace the runtime check with a preprocessor one to fix
> compilation with pci disabled.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/iommu/iommu-uclass.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-uclass.c 
> b/drivers/iommu/iommu-uclass.c
> index 72f123df55a5..98731d5e2c44 100644
> --- a/drivers/iommu/iommu-uclass.c
> +++ b/drivers/iommu/iommu-uclass.c
> @@ -100,9 +100,10 @@ int dev_iommu_enable(struct udevice *dev)
>  		dev->iommu = dev_iommu;
>  	}
> 
> -	if (CONFIG_IS_ENABLED(PCI) && count < 0 &&
> -	    device_is_on_pci_bus(dev))
> +#if CONFIG_IS_ENABLED(PCI)
> +	if (count < 0 && device_is_on_pci_bus(dev))
>  		return dev_pci_iommu_enable(dev);
> +#endif
> 
>  	return 0;
>  }

Perhaps there's no need to introduce an ifdef here.
