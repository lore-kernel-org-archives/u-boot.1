Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0440FC4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 20:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3EEE87636;
	Sun,  3 Dec 2023 21:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701636132;
	bh=Fvth2JXhO/a/HgCKYfDhllpHxdmQ1uRBxjhGAC8omgo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HC0QlYswpHrglwQht3TggNCDFItIWEqtXNr//VQdMg374XEshyo4MIYaU7L6ikhe3
	 rjpVp5wLKzqaxuEpebZEVAv1SEtjCtyUEC27eFXGReiYZhQVH7S0o91xJ46wdYJg0m
	 YCZfV71P2kDAw2QnN229tfk6a3FVmZHF/kllpg8WkRlk8vLvty+oZnESI+NRx8koVX
	 Ny4Vuo8WZ5T3U+Whf58FI7BuzZ8tVDUL/citbcDbUITDaLSjXj7PuhOOUA09bDc5mR
	 Aqu+Wp2ZsnlZZP2djAx9UhRKgObYidiLkFtaNN3ZQX2O1M81tUhTSkSkgISSHOJkJr
	 OzIOYg3tmm6MQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8B9A18756C;
 Sun,  3 Dec 2023 21:42:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1701636130;
 bh=Fvth2JXhO/a/HgCKYfDhllpHxdmQ1uRBxjhGAC8omgo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HZZRd0bZh8UUx2dauCl2Hrlx1mKbtTX4jf6H5i4FrgkDKrH9gK6EW0FhGv1XveMqP
 rYml1oiyKQja6QsZ/Zy7111x9BGlPOT7/9dpXP1OJXjCvFd4ni8b6aBZhJklGSzH0Y
 qT1Mqw57F5XC0GQ4vpKaUnnDKIigAgILrqiyq2QPs1B1yzc+Vxty4AKMm6Dn8brI0X
 sGt/6jEmsixAEmCvExwowM1gr9N+XAqfCFrjqRNZsOfQvbXUiaN+A+LYtULRQgZ/1m
 qU/lcRTcKqDlHMMwulxpT9jXHn2g4Iv8fOoi8gBQKtIcqQMeipzm9UGQ3HONnOaAKj
 8n+FaSonbpQnQ==
Message-ID: <867a396b-8546-4a7f-96a1-e5fda317c3be@denx.de>
Date: Sun, 3 Dec 2023 20:59:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci: Replace terrible formatting with different
 terrible formatting
Content-Language: en-US
To: Hector Martin <marcan@marcan.st>, u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>
References: <20231122235056.78672-1-marex@denx.de>
 <5df7617c-e8db-4067-83a3-a6601a72d334@marcan.st>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <5df7617c-e8db-4067-83a3-a6601a72d334@marcan.st>
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

On 11/27/23 06:57, Hector Martin wrote:
> On 2023/11/23 8:50, Marek Vasut wrote:
>> Replace one type of terrible code formatting with a different
>> type of terrible code formatting. No functional change.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Bin Meng <bmeng.cn@gmail.com>
>> Cc: Hector Martin <marcan@marcan.st>
>> ---
>>   drivers/usb/host/xhci-ring.c | 18 +++++++-----------
>>   1 file changed, 7 insertions(+), 11 deletions(-)
>>
> 
> Lol.
> 
> Reviewed-by: Hector Martin <marcan@marcan.st>

Thanks
