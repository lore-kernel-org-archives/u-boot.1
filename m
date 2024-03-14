Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430E6C54E5D
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 04:16:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0982687F6E;
	Thu, 14 Mar 2024 05:15:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710389758;
	bh=DzGcuoz0RgxMt0LSxFM1usepQ63+IF+5a4W/tu1LN5Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QDYSUV3xc0aaII+e4D7P0eIcNCpXE2NgIx/zPAXTgfLedfFCra5GoO8puudy/oPAv
	 AAsY9D0o5w7RiaEUDy/6Z7uo+RsINvQ1errYF89piIH7pF9nb9yN3CaRymzCg7RJGc
	 LliJHjRb+laGa/Ag+qyEeZ60pRWGvvvaNyQbiofRaiXEv/RYSSC1aiVxsQTCoN2UEc
	 nN+92PeRp4qjb5ZHyOoJ+shlvISs3MrDc14BKN9DrbRX+pAP8561hewtQdOe004dWQ
	 sdWTZ2pXV48o4V/AFWLzaEWMQX/BMxX70Hw4i3HOf/zv5XhPsCAdbWEo+iRA8qf93R
	 npp3aH7JPtiXQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A9D4A87EE3;
 Thu, 14 Mar 2024 05:15:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710389755;
 bh=DzGcuoz0RgxMt0LSxFM1usepQ63+IF+5a4W/tu1LN5Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DrADiJOKA00yRpGJyAtCzw0iKkKf506G0JSrZfWRGVxCctb11S93HTxlFc7Ljg5jO
 4eD6VbbUxzBgcSbp57EaxM4sdEIZgSCsdMKPJpy7pZCgxiw2qwgewa1IdEcEEbt7gs
 WcuM91vxzFU7YVd9E6v/OOoKtTqSo/UAbA/JURa/VkJMHB+5BFjUx8sh+vUp4ht/ph
 yYWHN0nM+HUoO3rJrCouLQ0X2n4UqTHp2owiqo/OJzhxpZrMNhhiYZG8dATay7a0++
 zAQ3pJhlhsbkyYOTBpXHaYp3aIeQYUlM/Udx7v5wtg4bzqyzJ9iU9+xGqWaf9Ug2wv
 rfaImjwZCgmEw==
Message-ID: <ab5388ef-20b6-47c2-bd9f-32c40a157272@denx.de>
Date: Thu, 14 Mar 2024 05:05:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/11] imx8mp: power-domain: Expose high performance
 PLL clock
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240312070338.86127-1-sumit.garg@linaro.org>
 <20240312070338.86127-7-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240312070338.86127-7-sumit.garg@linaro.org>
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

On 3/12/24 8:03 AM, Sumit Garg wrote:
> Expose the high performance PLL as a regular Linux clock

... as clock framework clock ...

> , so the
> PCIe PHY can use it when there is no external refclock provided.
> 
> Inspired from counterpart Linux kernel v6.8-rc3 driver:
> drivers/pmdomain/imx/imx8mp-blk-ctrl.c. Use last Linux kernel driver
> reference commit 7476ddfd36ac ("pmdomain: imx8mp-blk-ctrl: Convert to
> platform remove callback returning void").

With that fixed:

Reviewed-by: Marek Vasut <marex@denx.de>
