Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B68C48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 10:48:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1447F880DF;
	Wed, 21 Feb 2024 11:43:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708512206;
	bh=gbHCQVJ7X1iqmmNBdvhZI9jCjpb0ip4V3IAY7oYyytI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g/cuiCasx0qPgjekdMn1vpYQ1m6tRNEFbMwqn+IzhkbCu+KUAV/EFaHnGR8NeAg4o
	 QDPFngVY09DPMjCLGv0jGQD/F4DsJ6yFzYtmZgBBIMIlaI2t4dFHNbKKaJJBYNz1TJ
	 XfYhkszXqPscqgkKTtyzipK2Bs1yukXi34bO1x6v7Yfm4FUnuwKWp/JUtJfzPktS+M
	 YKPOjK4VhSw+3UpkNDRwq9n9FQnrwC1U54bhezuWU9ADm66iIzu52sv2O7o6c1+w8P
	 K/kKxPbWPDaQl0hAjeQvBFh7UY2JX949RowOzd36Irj3rB2NDGe04Y9DJtOmYhEdD2
	 AyzgHqDmyVWQA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CE5D788062;
 Wed, 21 Feb 2024 11:41:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708512079;
 bh=gbHCQVJ7X1iqmmNBdvhZI9jCjpb0ip4V3IAY7oYyytI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qDlKNRXRLnc7aoPNccaJ2LXc0Zh3GGUXNyLfrp8zEN9UCcLPrk5riZ4ug+1W+9Ej9
 hP0l19n2uCEXQtbkMTmBQ/IRDE4w2RPIX5YvEhW7OWu78J5oW/lCs/3+/v3oKVkZGj
 vmdpm6K5BdkE5ZPvCuYEpPNNn2tsmXM1lkY30l8DZ5xMNO1eRlDdkwZib5E2HrGSYj
 TT2kD5GHYUbBNGSVrOC/RvBboNvmNfoSrNznmNqubXbQreMAy1xdMekPlZFJvCczzB
 pprPR+kTs+3Hul+MlwNlytunEtEr+LqPdPIkZP2SB5b9+NAKfOuQ+sC1QqsJqsUXdQ
 GmcsilKuCPZXg==
Message-ID: <dec0af80-b953-4b45-bd6a-6967865fc03f@denx.de>
Date: Wed, 21 Feb 2024 10:44:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] pci: Add DW PCIe controller support for iMX8MP SoC
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-7-sumit.garg@linaro.org>
 <61361608-8b4f-4ebb-b7dd-260d08ac5e8b@denx.de>
 <CAFA6WYMoNRKVvzS+6gwXp4gwQXHKZoWA73fcPEy16Qy=qzgy2w@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFA6WYMoNRKVvzS+6gwXp4gwQXHKZoWA73fcPEy16Qy=qzgy2w@mail.gmail.com>
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

On 2/21/24 07:25, Sumit Garg wrote:

[...]

>>> +static int wait_link_up(struct pcie_dw_imx8 *priv)
>>> +{
>>> +     unsigned long timeout;
>>> +
>>> +     timeout = get_timer(0) + PCIE_LINK_UP_TIMEOUT_MS;
>>
>> wait_for_bit() or read_poll_timeout()
> 
> They won't appropriately fit here as I would like to add delay in
> between consecutive polls too...
> 
>>
>>> +     while (!is_link_up(priv)) {
>>> +             if (get_timer(0) > timeout)
>>> +                     return 0;
>>> +             mdelay(10);
> 
> ...here.

include/linux/iopoll.h:#define read_poll_timeout(op, val, cond, 
sleep_us, timeout_us, args...)  \

That's the "sleep_us" , is it not ?

>>> +     };
>>> +
>>> +     return 1;
>>
>> return -ETIMEDOUT ?
> 
> Here 0 represents timeout and 1 represents success condition.

0 generally represents success, non-zero error, please fix.

[...]
