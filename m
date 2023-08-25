Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EA3C3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 15:46:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DABDD86A9E;
	Fri, 25 Aug 2023 17:46:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692978390;
	bh=8CBPG3s5Cy7KGylpWGl0J+wytj8oaqMwxYfUcNOyX7g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bCxFWxCSl4ss/DPTFCmxhHrS7oK6GHLrsassn/9QBEyHVB63TWFFydTRbdO8HI3oh
	 IDRvxyqZXsGiMuiUCUkvSOWSjKP2R5ljYzZwFLXYmLuUw/ha6SapBbRWK4afG+VDHk
	 jY0zwn67wd+tNpRyoAiX4sH99rfM8EiUOQRY9TJjX6DeRLnYL/lfaE47h/wzLR94av
	 J27BGu7AJCzPsPFf9cZ+GK1UqdJoHpX7S7ZWVB6kPUxc/ravHsAs0h6fD2N/RPrC9K
	 LGztGh7RJbVNpjF6vNOy73LHw47/g6sSUIrxRyFUUyVyjIt7nMhRXVSTJfZD6kXSHi
	 /U4bwFoEdKGEg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1130986A9C;
 Fri, 25 Aug 2023 17:46:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692978389;
 bh=8CBPG3s5Cy7KGylpWGl0J+wytj8oaqMwxYfUcNOyX7g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FdxwPWbl+PQE2dk1F/h+AgoQ35Oa3cR3JeDuCOxlOn2vjR0svAXahWOZDRJi5GNEg
 tjp/QT4gQfRvPiJt1hKShCwqXWQeBBGtmHzvw3XI74nQDDgPTCymAlau1Qm0WoiPHV
 VY5LH2+aagLia0AH3iCiO2me7GvzLrvSd44+MtlWZ9p9iGVBd3OeNL6b7SkAntRHXC
 80Ien/RAikWfIQD/U0zv5w+J/QnZi/Y7qM4u4CyH6Mo1ghvIvQJZ/ig6u356SEVFZg
 i3daGDdxJRFtSSzWaahlGUyMvzv0u30qwc+hunsm4CWm0Ai27Fnt0l1zRPLl2SzfAb
 MVvH00LN0foBg==
Message-ID: <1a6804a8-40aa-531d-7172-6d17f5bc83b1@denx.de>
Date: Fri, 25 Aug 2023 17:46:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/2] usb: dwc3: Fix renaming SPL_USB_HOST_SUPPORT to
 SPL_USB_HOST
Content-Language: en-US
To: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
References: <20230825104251.28311-1-oleksandr.suvorov@foundries.io>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20230825104251.28311-1-oleksandr.suvorov@foundries.io>
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

On 8/25/23 12:42, Oleksandr Suvorov wrote:
> In the usb/dwc3-layerscape driver the first option should be renamed
> to the latter as well. Do it.
> 
> Fix original logic in dwc3_layerscape_bind() - do not enable
> 
> Fixes: 333e4a621df ("Rename SPL_USB_HOST_SUPPORT to SPL_USB_HOST")
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>

Applied bot to usb/master, thanks.

This will go in via next usb/master PR, since the current one is already 
out.
