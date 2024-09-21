Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F26CCF9C69
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 14:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FC7A88BBC;
	Sat, 21 Sep 2024 16:05:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726927526;
	bh=KsD+kw7IrcEblj6WgHEKuukSfVNs7t1o7jE1ZC10A8g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XGT7AQCn7XaFX/TpMBYFDbSSuQMilzl2DvWkEHwD6iy4qcTJLQ10QYCrDwSQA8Cju
	 3PZTbPRY3mP6+oaSxJGaxjxjpSjBqbW23+EC2OONtS+Fanf0TmnUld4SYLwQBmRCMY
	 4aZ65FBcPvcwB/MH3EnVnITd8m09ZR+Sv7D8Haaa4TWm+sE0ieBU8WZBwixhxNZqQC
	 slmGxAHr1q6pwT+hKn5+XgdW00DutlphYCgNf1Eu1VXvyNaq0qC9WLPSnqt9hAUXQG
	 wUKrO/sCiEM1+mfcSLiD55mqH0wPOO2cAnDGTnn9jJfj5IMmheCJ/nlnHwAnXQFhx0
	 GNdzRZGrviY3A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D856288AAC;
 Sat, 21 Sep 2024 16:05:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1726927521;
 bh=KsD+kw7IrcEblj6WgHEKuukSfVNs7t1o7jE1ZC10A8g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ItKrg9SgYTy2cQRCxGkz88ka7tL7Zv/eIir5W762sBxW5RGVEQu1dDRT/1HxJNnBv
 zXrX2Df2ej0qwOrZvFmDUjfSKCxqwEAnylyQEgqsw0/7ydTkMkg8AbrnTdZjrmf+kC
 GUYTqXXO2qz+XXMXfkTwHJ+VXbJhW39xKOVkqadIJfbC7c0l+BAnZbjfS8DgMEMISw
 Pj5KXq7pqo0rptghiozsAh9UeLEbiZgiVKJv2BB+AHyQ8OHNs82OTEg2yhqV88gY0S
 or84WkQ3k1bLr40jqGSr6k1ZZF8hC0oYQzoob8vh9NQEdfMaqEXWQbzFQ2b5xnIxP5
 uR6K4EUMolSVA==
Message-ID: <30cf32f0-75e1-47d8-b340-5cf3dd68a8c4@denx.de>
Date: Sat, 21 Sep 2024 15:51:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/20] sysreset: Add reset support to SoCFPGA Agilex5
 device
To: tien.fong.chee@intel.com, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-10-tien.fong.chee@intel.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240920070242.20884-10-tien.fong.chee@intel.com>
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

On 9/20/24 9:02 AM, tien.fong.chee@intel.com wrote:

[...]

> +	if (reset && !strcmp(reset, "warm")) {
> +		/* Ensure content in dcache is flushed to system memory */
> +		flush_dcache_all();
> +
> +		/* request a warm reset */
> +		puts("Do warm reset now...\n");
> +
> +		/* doing architecture system reset */
> +		psci_system_reset2(0, 0);
Can this use SYSRESET_PSCI driver instead ?
