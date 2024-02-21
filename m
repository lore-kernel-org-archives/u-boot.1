Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E18C48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 10:47:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B52DE880DA;
	Wed, 21 Feb 2024 11:43:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708512205;
	bh=BB+73KMgQe1j4iWsswgrUKfDF4aY9y6YsM7mt35EgSc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FSlGs+YuUYIRz4B70ZZXqW6JiVyEo9S1jIZiz2vavd/6glnGgz4hRHsfSYqrEKYOB
	 EA0lhDARVfFg0qjFgN0uWB+67jgeLxEFTkVY9Ip9Jua5gcZj6vZpwv2IOs4OzzDWNh
	 Yt9c/fsyGAQ3du7nC3uz5+IakwJuDrsFbPHh8/a8ark+KlQVtoexrzZQH22jlBwMq0
	 57u8g8l2ShzY6H1+L4vNbsUDqqsiAEpZrgpJj6rCJhKv7EAUbU6aKlYcpqCh6Gaf+/
	 d0YH5gkfPkc1VFtPVnnN1qR4zUNH+mVjXpTsSC+CXewP6RWxZCpB0+AS2PzSUUyRFa
	 3hCac0ByOs9OQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7DA8F8806D;
 Wed, 21 Feb 2024 11:41:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708512073;
 bh=BB+73KMgQe1j4iWsswgrUKfDF4aY9y6YsM7mt35EgSc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=yaQZr90m9gWF4c/kziHGt7mgaPlGV0On2crVUpfM1Dle6RQBDVF3enkAvUQFud6cp
 +OpZK2+6+EMHbyIoZAikK7m/iJsK2JafAvTU+WNJ5oh1S//d+elxB55IDZ4hZccghr
 geqVVr38SIwSPnlUexUlChTHJD4gFkCnuRCW2afYLWqMNxerunsc3cUh2b66UL8WSa
 CZ6qPlT/H30pVxdXXaJs+Il/MhHMrk1I56o1Li/D+Vs1fKoHodrcTPNebi5BHKWp2L
 /67EKmv442WONY7REuzxEI4uMx2CWfc/gCoYvkZwla/oRUaJyuT1RWpXnCi3BP2+E5
 luzP0BFlEhbvA==
Message-ID: <40d01eff-6efc-48ac-910d-ee057f081bfa@denx.de>
Date: Wed, 21 Feb 2024 10:42:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] phy: phy-imx8m-pcie: Add support for i.MX8M{M/P} PCIe
 PHY
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-6-sumit.garg@linaro.org>
 <55e11f56-0080-41a7-b4b9-43c3abe61264@denx.de>
 <CAFA6WYMQtHysuS1nor_kZnq4xy3tk7Q=RezWdCfOVdBq0ee-iQ@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFA6WYMQtHysuS1nor_kZnq4xy3tk7Q=RezWdCfOVdBq0ee-iQ@mail.gmail.com>
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

On 2/21/24 07:17, Sumit Garg wrote:
> On Tue, 20 Feb 2024 at 21:02, Marek Vasut <marex@denx.de> wrote:
>>
>> On 2/20/24 14:10, Sumit Garg wrote:
>>> Add initial support for i.MX8M{M/P} PCIe PHY. On i.MX8M{M/P} SoCs PCIe
>>> PHY initialization moved to this standalone PHY driver.
>>>
>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>>
>> Is this based on Linux ? If so, include Linux commit ID from which the
>> code was imported.
> 
> Yeah it is derived from the corresponding Linux driver (see header for
> phy-imx8m-pcie.c file). I can add the corresponding Linux version
> (v6.8-rc3) in the commit message.

Please do, this is useful for further synchronizations with Linux.
I can imagine MX9x support will be one such synchronization.
