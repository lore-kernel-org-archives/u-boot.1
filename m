Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF87CA0ED0
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 01:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 765FD88D23;
	Fri, 30 Aug 2024 03:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724981201;
	bh=jqlqavXuN0vaX0XhPXJ+qy1geiP1aNhgCLQm6tGoqio=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a14rzM1SvaAZaJWD064p3fuqcwN6e0kaZ+UyHnC1gH9HiDIIhdgCYsa5GEarVLuGY
	 oZbuyYEnk4hI7URa0IKA7O7832VTX8YclBWxRP0zu7hA8CTmL1QQRMljwAV23b4dLD
	 +2y/qYAgmQyeozqE9s/nss7zIIMvU0Yrmz7EiqjcIJJHs3vpx5b2UEW5aDh9vUxksQ
	 /d/qOYgPE6+Rv+4tgO7FQ083Rwuoypp7eq1L/wnSr7Ai+KoDpmF4Wd5Jw856t9bJ7G
	 cR/Ojhin7WzF3HGA+wfmRWiECKX04oFnZZf6pEoThwmrxto+Df5Xoo9K3EdydXgL1x
	 LMJ/CPS6Pxghw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id F3C9187DC7;
 Fri, 30 Aug 2024 03:26:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724981200;
 bh=jqlqavXuN0vaX0XhPXJ+qy1geiP1aNhgCLQm6tGoqio=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rc/JHRkYTHbQyUPApe5nvlL4uv7AqBNFl1rvZ5hAfX3izjI9cePB3r5VnGbgtj2ND
 kZ2EuLNq45fW4t9p/y7goBukO8eIUOW4QkoN0C032JymoHPYX8bZKsy7UUoq3hRMiU
 x0HZozTRDgQkXupRSWhSWPTZLxl8xXACr+fKRTclZ+x6a9qANznZCWuwDRJyVLhaEP
 IRKh8XNIPmtZrqKZXv0MGznGtehogJl0QCgkQ5KZDsiIDhbq8hntyGpirkTCBVdacu
 4d/Sm0FOqdpvQKOzf0vaMt44GYmzjrT/9gzpllb/RkUTn7NTWlf1Mrt3YQQJFZeWTN
 MQuVBng9xTztg==
Message-ID: <dda77821-fae4-4a35-9fd8-802e8f917dcb@denx.de>
Date: Fri, 30 Aug 2024 03:11:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] usb: cdns3: Set USB PHY mode in
 cdns3_drd_update_mode()
To: Minda Chen <minda.chen@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>
References: <20240829013058.6178-1-minda.chen@starfivetech.com>
 <20240829013058.6178-2-minda.chen@starfivetech.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240829013058.6178-2-minda.chen@starfivetech.com>
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

On 8/29/24 3:30 AM, Minda Chen wrote:
> USB PHY maybe need to set PHY mode in different USB
> dr mode. So translate USB PHY mode to generic PHY mode
> and call generic_phy_set_mode().
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Reviewed-by: Marek Vasut <marex@denx.de>
