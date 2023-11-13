Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C82DC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 03:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7B8D86B54;
	Mon, 13 Nov 2023 04:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1699845114;
	bh=5scaLMJCTC/j6hnZ2UsEA/A0HWS8Rcc8Sl+3LivNHsw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eU1Gm4jqj5yMaUrT+DTe2NQnlcZdWyT8F0DmUjlgzCpDYKnzl3I8ciNiMVB7NIQku
	 M4zIeZz5yiL88vO6pqyGHFunKcRjhnn8wK1HwxlTi3CPlBjypTJro2ahXHErRjAo7N
	 WqRrMZiz5LdpyKJcJj0sqWk+feZAXJT6qV93A8R/QsQEdM4ejCA80Qd10rXZslX5JP
	 g5pnwQmitaJZiEhTkYkzjaqL78Q0jfXONU3gkrwpDTihZ/RxfISG2lVFtuEzlAorPN
	 +x9j9L9HMyYSb0JNQaiM4UFWyTfsaPe0K0JKvQoPb0HnsI8med8nZcNL8vDN81unH2
	 asyAtQGEJEjTQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A913686B54;
 Mon, 13 Nov 2023 04:11:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1699845105;
 bh=5scaLMJCTC/j6hnZ2UsEA/A0HWS8Rcc8Sl+3LivNHsw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YkhdS/oekHy1GgLzuUuXYcdy74QSN/Pb16DTRlqo5VcOv4oc1vAu5Qcfk2FJ4PmQh
 TW5ks779boh1G9532CWe0KjFY9mjwx+kQbII3XTVMmSRkFpXIdA09quK71rGfCOQsa
 hSCMWKzzNty6LqpZW00xCYDJcVkZgqGqgx++uxIkhQtp8w2/W7DWBpu+Lk0g1Ke7Ek
 56/1uee0lycbCNaAKd38eT5qv/lD4ziQJS8MrAeKcSDd8x0oaIvFhpBxt+u98aFhQ1
 yP7nuFrtDMkLCr1VXKaoiturLeDm3nK06MfRSSht2j1eUsFhaa9JSoB1pA6Zv4gwCQ
 R/CXRYIQSWTtQ==
Message-ID: <141ed34c-93e7-4ded-8697-3fa5501d4ee7@denx.de>
Date: Mon, 13 Nov 2023 04:11:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3-generic: Use combined glue and ctrl node for
 RK3588
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
References: <20231112152527.1306793-1-jonas@kwiboo.se>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231112152527.1306793-1-jonas@kwiboo.se>
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

On 11/12/23 16:25, Jonas Karlman wrote:
> Like Rockchip RK3328 and RK3568, the RK3588 also have a single node to
> represent the glue and ctrl for USB 3.0.
> 
> Use rk_ops as driver data to select correct ctrl node for RK3588 DWC3.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Reviewed-by: Marek Vasut <marex@denx.de>

Do you still want this in 2024.01 ? The MW closed just a few days ago, 
but this seems OKish to put in still .
