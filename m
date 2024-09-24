Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04659CF9C6B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 20:01:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 301D488A29;
	Tue, 24 Sep 2024 22:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727208061;
	bh=lGoPn4dpEvF4sSMu0xoXRscQqx6+Q2RVDN1LMuuZKF0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oaDpbl1G/Lqyk1jlhok9xpKpsuN7zKx6qqAK0JrvPYfwvsFImx3lBizIgHI58sydD
	 zzyz85327/wu3zrsNA5N7LHRskKcRMarkhSISd8XAM4B7QxumtG8RQkbplrxTlEPl9
	 86/Ux22VnQmxS9x6muwzz5BlKjksGbsLAsEEoOld8gn6uIwiuCZE8/QF9+didAeR1g
	 wswLxssMM/SB3XVwFUJ/Csk1kUrjJN4ZU9XbrkEEJTOsk0tV5RZ3b4d/dYtOIcDLp4
	 JnOxl8DsFVLsKC8snTTXLWnrzgiYUrFmQ3peOsTeRRbJ9J1AWmYNUtMIfQZ7aXpRd7
	 +WDC3TE5rDITg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6EC8888A3C;
 Tue, 24 Sep 2024 22:00:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727208056;
 bh=lGoPn4dpEvF4sSMu0xoXRscQqx6+Q2RVDN1LMuuZKF0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=F5EWD0LHbSEqsCSqdJzvXFHzqvCuGhBgZb7yRJcdfuhqWXDDt23nOQRqPj3mD5rKy
 Ynxz8wOljIfoA5ZFRT5R4h9ttG9I+JMTsA1kN9FlLgNT+glwRuZ3uANrxoyvS1yS3O
 okkYi1dzzERYLCA7ZoV3OQRekNpdDVTg5Xy5doJmhY93kda8wyUUVpdxpSJ+cJFg49
 yiRZNFYIl1GmwVxr+jx2KxNZ4XZAJ5xotCx6JGaTfJh4YO42IJOxMqKeReuIIXamU8
 5h5MMfmyn5mKPtIQE6IlkzPjfetFj/uUi9q/JmXCwPXGN/1OgDKOw46CmfgnwIKkDi
 rzjl+aZLNSIjw==
Message-ID: <607e2c02-1cae-4435-b33e-9cabf8d24510@denx.de>
Date: Tue, 24 Sep 2024 20:35:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/20] arm: socfpga: agilex5: Add new system manager
 base addresses
To: "Chee, Tien Fong" <tien.fong.chee@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 "Meng, Tingting" <tingting.meng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-2-tien.fong.chee@intel.com>
 <9eca93ee-0368-49b3-951c-6953d8b2a3b6@denx.de>
 <DM8PR11MB5592DFA8540E89B15ECDC125D2682@DM8PR11MB5592.namprd11.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <DM8PR11MB5592DFA8540E89B15ECDC125D2682@DM8PR11MB5592.namprd11.prod.outlook.com>
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

On 9/24/24 6:45 AM, Chee, Tien Fong wrote:

Hi,

>>> Initial creation of new system manager base addresses for Agilex5.
>> How much of this can be converted to DT probing ?
> 
> Yes, we have dedicated resource is working to convert this to DT in conjunction with syscon support to provide
> System-wide configuration.
> 
> I can pull in this for Agilex5 first if you want to see it here or separate submission on the changes since it impacts all devices, more tests
> are needed to cover all devices.
> 
> Let me know your preference.
Either option is fine as long as this is moving toward DT probing, thanks .
