Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1776CFB440
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 12:16:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C65A88D63;
	Mon,  7 Oct 2024 14:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728303352;
	bh=YdFbnthyeTFF0TD3JOVW/Z6qE/XFOtuscsvmL1/5vTc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZC1Z0XgLPTaE0s5uQZ3eUz3fIPfbb2t62VH13N7opFPitlAZzyAtYfzPQ1mGYiJDA
	 y4Ot0biHGeYm6mM83mdRzS7MPGSYrXXjwPjyoDjvDRcw+rPl0N0JlIH0mGlYWkPgcO
	 Bt+nkeYMcjh8KJglBuSrjI2HIgvCLA79S276JzhcaE6lcyvo+7sz4onipo3fDSHwXq
	 TP9HHmWlkmIw2fCZpj/cAjYT6LGZSLYmgTqesdrrw/Xq93fhPqHnb3+iqyl/eGTaUO
	 GOok1Q2UFTrIn0wYwX4227CqQ6byeNdQND1VMv+c0w5xgh0fj9aqgorDiqP/GgnlCd
	 0MNeQHf2AmNOQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C385688CD9;
 Mon,  7 Oct 2024 14:15:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728303350;
 bh=YdFbnthyeTFF0TD3JOVW/Z6qE/XFOtuscsvmL1/5vTc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cGIZatECEuF4MjYDzrxV7lGTmJnWcySXnxNvUxuUnrKDsGSwy0kPZUJggzcd0CjSS
 t6JcQXFlCpQ9MhCyEisfUEUiQusXWUZCm7VCyg1E4YXLLDSDBF2rtAucEbAKhtYzci
 hpkyivTv5MQH62OBY/mJENihL/H2kynXJADqJJCZ7SuWwzqU98rSkpWAWoaKjdXtFO
 dshJtswHr0+MRZmx/RT2vTiR3q7wieNo31/WGcRx7wsXYKXFXFcFYUQb7rJd1DANc+
 Fmf2TN9xe6kKc15hB1KyX/oMHa2aHocm1pVFmZvDrsiRIIb1nuzSEydAITBzTbhigt
 Ntj3m/31A3XuA==
Message-ID: <3f96e737-7cc8-4237-997e-e321ca9c76ee@denx.de>
Date: Mon, 7 Oct 2024 14:10:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] usb: onboard-hub: Add i2c initialization for
 usb5744 hub
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241007044547.23896-1-venkatesh.abbarapu@amd.com>
 <20241007044547.23896-5-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241007044547.23896-5-venkatesh.abbarapu@amd.com>
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

On 10/7/24 6:45 AM, Venkatesh Yadav Abbarapu wrote:

> @@ -99,6 +199,7 @@ static int usb_onboard_hub_remove(struct udevice *dev)
>   static const struct onboard_hub_data usb5744_data = {
>   	.reset_us = 10000,
>   	.power_on_delay_us = 10000,
> +	.init = usb5744_i2c_init,
>   };
>   
>   static const struct udevice_id usb_onboard_hub_ids[] = {

Please keep the list sorted.
