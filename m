Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FA2CCF9E7
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 16:14:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D30B88BB6;
	Wed, 25 Sep 2024 18:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727280885;
	bh=R+lcVVp13GppF5aDvMRm0QanrhCR9fEHOP82rNkd7u4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SJE1f6A4tM1OaAHfjW0ngKzpJqlcfwMoQ38bgY2/P6Rr3VOeBw8G5oonTdhiVGBj6
	 3Zq3mxm6wm9euXm/UWdfEFfhrBVWbTjRFAKRyduXZ9Y1Ng10vTZRdjdovbJMRP787h
	 0wQzSXk6LycFEndvT4XeHLeInyt5TEbqcz04Q3m+1hZ09jfdRNiUHaFJfALdEhr7hD
	 DWewWPZDX1/SqbuOkSf9q2szSL36qhSbyNcv9/LZ2nzLnsQOui3kejiLKZZFbyOZO+
	 y15DoElRZbMHeoYHCIEhUhg+FOXjo2x3/93LmodtpNRS0h9VXBqRLTf3AtivVfExTm
	 sy/u1nJL+jqkw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 453C788B6D;
 Wed, 25 Sep 2024 18:14:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727280884;
 bh=R+lcVVp13GppF5aDvMRm0QanrhCR9fEHOP82rNkd7u4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=0FPMlTr9Pk932hxUKN7ogj+z/0Wk1FtVUBzK1WV+TCkCVepp20BWW3soJBA6HHzeI
 DyTHR3QExhasYvRR1ESabsP8AFRbNaxRAZ53Sn7OkDDNYEftZbBO9UpqSm2MAS8xC5
 omABk38Vq9OHtvALRBN7YdZ60j6hmF+YvjgyPwXT1WGdmS+HtlzSVTtjkUrHX3Rb4K
 587GcUsh0rTaZXYk5JgY3c41QETOOsvIYc1zOfIp2mnZuxMQNAYnQP+3uLvqRg8/Ha
 rQxOqXDKP/QAQGX6Qts85i1kQcJ2EKv6X27XIDGHvgJKursGT45ebKSFVA+y+RsL+V
 rXdrpbrlKOn3Q==
Message-ID: <513c48e7-0dff-46fc-8b37-1481aa132563@denx.de>
Date: Wed, 25 Sep 2024 18:08:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx8mp: Add DH i.MX8MP DHCOM SoM on DRC02
 carrier board
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
References: <20240925001119.667820-1-marex@denx.de>
 <CAOMZO5Bu-UW--EMZ7hPUcW_COWr+5mZioBrhBv3UgZPXNVBvOg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5Bu-UW--EMZ7hPUcW_COWr+5mZioBrhBv3UgZPXNVBvOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 9/25/24 3:49 PM, Fabio Estevam wrote:
> Hi Marek,
> 
> On Tue, Sep 24, 2024 at 9:12 PM Marek Vasut <marex@denx.de> wrote:
>>
>> Add support for DH electronics i.MX8MP DHCOM SoM on DRC02 carrier board.
>> This system is populated with two ethernet ports, two CANs, RS485 and RS232,
>> USB, capacitive buttons and an OLED display.
> 
> The patch looks good. Only one suggestion:
> 
> Please send a v2 indicating that the devicetree has already been
> submitted upstream and add the reference o it:
> 
> https://lore.kernel.org/linux-devicetree/20240925001628.669604-2-marex@denx.de/
Done, thanks.
