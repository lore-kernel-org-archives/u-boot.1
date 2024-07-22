Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0787C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 23:58:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 158BB885F4;
	Tue, 23 Jul 2024 01:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721692691;
	bh=hf/qRaFQTshgtN5ScUbkLDKunHQq/A2SyMzjgvUlRQM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WIUe6wJtq+PShiKrmRzanIaNBezffQUlYeyz79hLZEMxEnrFkORtU/Dota3s9HW21
	 uw0pQ3eGfkrq8QnSc3k8hEQj24vE6KxnvOnWIBhxLaWuFK8i58keN55hjBl1L1Q1gJ
	 baw16Kt3r/PrOeNZo7XhaF62oW2UhKgpvuHJvcZC0PrZPZA+a0fAaedNzW97oQPEgY
	 +r75HQGR2CggPtNUVQFSfXT3iDQyKiCJlOJIaMjF1NmXcVVdtS06LwI7kKwH4tJ4T0
	 OcBxzY+depsC2AYtT+hRbDyehQ/JURauTNEQ3r5HBKWaRH8JlPxlMncSc5WtrSLL9/
	 jRvFODR5BlGag==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E6C8B88440;
 Tue, 23 Jul 2024 01:58:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721692690;
 bh=hf/qRaFQTshgtN5ScUbkLDKunHQq/A2SyMzjgvUlRQM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SNVvFnD1Xo8sPcrYprmsezLH0zQYlQEbo49f8KhZwBvO/qvtVzeIfvBivhoCAyMTd
 wsQNK8nigUE9R+MHZmpxLWtw42Js0Laucnzk/rnTxj1vAKbeeO0Cyb7iRhCMQWTaAD
 g1d3RaSkxaaoCLMXelvmpFp1TKuDE50DycrMZgzuGq+xHdCN2Fzd7KJhDdRZIjwjCL
 63YaXhFOkRhKjwLatM9JHdJ5NSguCJkq8/bD8GGgmrIZWYSi2XxqWBhnWCDe/FykKd
 voUTl13sAKzL5Rz+xNMSVtOZUZS7qS3/g+HeWO4jrGly8iVDnPA5Z7tbs/vh+zFfdg
 VpwV/ktj1jKXw==
Message-ID: <57f5a68f-6f12-4bf2-8f6a-851c9064c930@denx.de>
Date: Tue, 23 Jul 2024 01:41:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] usb: gadget: atmel: Code refactor part 2
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>, u-boot@lists.denx.de
References: <20240722202426.190986-1-zli@ogga.fr>
 <20240722202426.190986-3-zli@ogga.fr>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240722202426.190986-3-zli@ogga.fr>
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

On 7/22/24 10:23 PM, Zixun LI wrote:
> - Rename atmel_usba_start() / atmel_usba_stop() to usba_udc_enable()
>    / usba_udc_disable(), remove atmel_ prefix to be inline with other
>    functions. Also avoid confusion with DM start() / stop() functions.
> - Replace printf() by log_err()
> - Spelling paramter -> parameter

I think I have to push a bit more here, can you please split each bullet 
point into a separate patch ? I think that'd be ideal, because it seems 
that each bullet point is one type of change, and one type of change 
should be in one patch.
