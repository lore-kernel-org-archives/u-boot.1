Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDC7D44162
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 14:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28C9E89555;
	Tue, 19 Nov 2024 15:36:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732026994;
	bh=NiCUNo3VfuP0f63se5uJAW04wozFlfMPW2BM/WaqRj8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AFxQBb5iBNBBWKTTS9XORQpK3mJrjSXJpHcttMrCtyRGsQ3sUUvc6SSCN2+/1pB1+
	 trZ/uhwz3GEmV1otbF8Lzs2zpncOxgqQ+dVgTIlkXq8rLj6+XjY5cnM2ZRTB95pmzz
	 tVuaAMzXl26GiReOxqeNh8vQwU0D/wdKM/fdSw2Yn86/pPeY591XgetPcPJIVssZIp
	 MaqRs1g4GJ/vRqXqAq3WjSPzeRJuLOKbgDS2cXtmo9ZPppty/Ov3DIgBFsB6L9cicV
	 UH7ZdGH67yzbSB2qoU0DbwmbQQyeTPwd5qs5Dv+uQ5VJGL3E/u71YWLoATzBsgIBZj
	 B/ZY7cYLX/3pw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8736D895AD;
 Tue, 19 Nov 2024 15:36:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732026991;
 bh=NiCUNo3VfuP0f63se5uJAW04wozFlfMPW2BM/WaqRj8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=X7ENwtbHCfOZl+ONw/BZ0foVzo2952TEPchXuZjB1zGpXtXHVIdSH/fbz8Zrw6U3f
 GTs5FfLh7x1hNAs3d6W4oQDF4aNWMFt4vbd43ATj8RL3C9CmzJ1K673wrbVPYtMtA6
 pYrn6RwDgfwTBRhqt0IB5X7m9d3D9zxOJ3dGpbUMkgCChG3KEZPbJloXjQB+a20DU1
 VMbXZ6/pOge71NgYgioRb2JgeWlZgtdhYbYPbKy0v1UnpTXVnjY7+CPWc+ASAuCFMJ
 z6jRZYWS92E1KCPvInZkibyChBzbXmxZ9gJboOzlG9KsFeyonYeV7z+skmmxIajsNe
 BdelTG+4Fiekw==
Message-ID: <f0abf894-9323-426a-acbe-547e4f1ea98b@denx.de>
Date: Tue, 19 Nov 2024 15:21:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] env: Switch the callback static list to Kconfig
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
References: <20241119105750.27747-1-cniedermaier@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241119105750.27747-1-cniedermaier@dh-electronics.com>
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

On 11/19/24 11:57 AM, Christoph Niedermaier wrote:
> Switch the callback static list from the board configuration varibale

variable , typo

> CFG_ENV_CALLBACK_LIST_STATIC to Kconfig CONFIG_ENV_CALLBACK_LIST_STATIC.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>

With the above typo fixed:

Reviewed-by: Marek Vasut <marex@denx.de>
