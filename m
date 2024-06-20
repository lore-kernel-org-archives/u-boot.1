Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99069C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 11:59:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DAC58854E;
	Thu, 20 Jun 2024 13:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718884733;
	bh=hH8aQBQcnlODr0sOf6Oxhb7MYW/AvL3WaY0yAbZrzM4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kmi88/2d20WvA+c+q24QiA+6BeBGPrwj4MZ5pATvHFwD9h90NYHPGCiwCeblQhwc0
	 68tZJUygt/sE9YChyQvWAx3ujUsdg5kfgn5Oz8ri/D1zJ8KKSXb0iBfVKxRjLbQmlZ
	 2NpkYHapkfLj9ps02pILQNVcSUpwcQq0BdpLKXbEA0d09LbcRpqzwkzXu5g/RL0ZB9
	 lCHoZsJ4yagK4GYCqT5tVdvlEffydm3cYe7z4lgStav4Naaa/0ebLBBrK0iXsChmQL
	 VZiNBaebqJwuv1bwSkH9rglF9+viNAdacP+9ZTWwfvLu9GxCxI+M2uVhC+eP/2Wle5
	 yF+/orucrCLLQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 31F9C88527;
 Thu, 20 Jun 2024 13:58:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718884730;
 bh=hH8aQBQcnlODr0sOf6Oxhb7MYW/AvL3WaY0yAbZrzM4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tMiaeEeiXmQstoWoR2z4emgBjQw+KVA5oC743EJNRO58JlMos2AKLW1whQS7198tQ
 XLZvApvlZkgAGKzphrtCDZ+ly/Chfs7WJ5gHq4/KKjm9m5nxiSJWpF7dvWWID56WKd
 PDzFPL6jkH6uoCJI55fKL50NtWUVz791RRCJCcJs/jSjp8To95/65QqZQk+iDqst6b
 n9kAc8NkK/nge47NYYmo2CUkIbNZfqNBgnn9XrLHXscogO1J+0wXstpZu03Jwzrvsy
 Sc9SQc+VPI/J+sg2Jwhvh93Zvzd9YK0d9jqjEMD+fccR7uObtHNVKGtSorDCfwZ36C
 hYobX//6H/jpw==
Message-ID: <b19fd3a2-65c3-4b8b-9474-b50b1d570b3e@denx.de>
Date: Thu, 20 Jun 2024 13:54:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] usb: dwc3: meson-gxl: drop usb-gx.h and make
 dwc3_meson_gxl_force_mode static
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
 <20240620-u-boot-usb-gxl-phy-set-mode-v2-4-b81c027bc02c@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240620-u-boot-usb-gxl-phy-set-mode-v2-4-b81c027bc02c@linaro.org>
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

On 6/20/24 9:42 AM, Neil Armstrong wrote:
> Drop this useless usb-gx.h and now make dwc3_meson_gxl_force_mode
> static since only used in the dwc3-meson-gxl.c file.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Marek Vasut <marex@denx.de>
