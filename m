Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28A7CF9C6B
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 13:44:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0437F88B89;
	Wed, 25 Sep 2024 15:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727271839;
	bh=+fVEPoKY+ChRVz8aNRmIG1zGT7RLRoG2/wl7lVoBaWs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uLkKRcxJ/3CZ1BE0HitoH7aVnNc4eJjyrNaq6xv17KasqC9WCqceaOQFsmd81hxnb
	 sFl+DRJBZbePgHA7diOouClaTwK2JE5o8O7odbK9LXcHUHj62kQsVODv4h8dL7TWUw
	 Kle9iySp7PfgasjQTYguRn6JT7pxcGx+XObyjB2GXc4Se+w7YxJ7SV1xHhVvSsgVRs
	 V+P/qX5mc9j/Nc0Tk6M5D+9ByCpyxjX1apycc+t5iapeOtYkmKzOHKKHxUyDiELN4l
	 LGqB86qYs355bRJbzxiGiZGbP9meqtLbSHIaNguVvHm2UZCxrjvXw+E6FNk7jlb0sD
	 P405ZLAF2GcnA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C66F788B31;
 Wed, 25 Sep 2024 15:43:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727271838;
 bh=+fVEPoKY+ChRVz8aNRmIG1zGT7RLRoG2/wl7lVoBaWs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=phqMg9xGNHgR/jvicx/ikUiy7TR6XJw2f6MuyuT58bbW05k//nJvkwy8G2F5N7agX
 7aTQUhNAzKkTkV3/mvW/t2Q7S1nkInyftTYwXCoNN923wvJljQgb/rTF1CWPw/jQNn
 D2k+csWO/wkqZ+jGJpN3u3sUWSUtcK9imFFTVVNZVHoOoTmwV1HgNI1wpGLbcW0OwB
 r9UK1JqKiS5tXEJ02E4XAPhBW2A0BmXgzuE+Idn82X7WmEmaqXX0yHLm29gFnXS7Mg
 SpOz8OeRO+BDC0QZpr+uZAT9tadgOwaSnvZqNgcy4bbzgzgRseuGIv7pLE7ZdUwR12
 bBtzAfuTfY7oA==
Message-ID: <3aa8bf84-ea2e-4485-8a2d-e1af9d483c98@denx.de>
Date: Wed, 25 Sep 2024 14:50:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/20] arm: socfpga: agilex5: Add low level
 initialization
To: "Chee, Tien Fong" <tien.fong.chee@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 "Meng, Tingting" <tingting.meng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-5-tien.fong.chee@intel.com>
 <9cc437c8-59dc-4e78-82d4-8ef479ca9ba1@denx.de>
 <DM8PR11MB55924FDB9E2C081EE97216CCD2682@DM8PR11MB5592.namprd11.prod.outlook.com>
 <19445387-1b9a-45e9-84f2-c6de0487ce34@denx.de>
 <DM8PR11MB559230887920D1150E8F9591D2692@DM8PR11MB5592.namprd11.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <DM8PR11MB559230887920D1150E8F9591D2692@DM8PR11MB5592.namprd11.prod.outlook.com>
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

On 9/25/24 7:40 AM, Chee, Tien Fong wrote:

Hi,

>> arch/arm/cpu/armv7/lowlevel_init.S:.pushsection .text.s_init, "ax"
>> arch/arm/cpu/armv7/lowlevel_init.S:WEAK(s_init)
>> arch/arm/cpu/armv7/lowlevel_init.S:ENDPROC(s_init)
>> arch/arm/cpu/armv7/lowlevel_init.S:     bl      s_init
>>
>> Maybe such a default lowlevel_init for armv8 could also have an s_init ?
>>
>>> What's concern with lowlevel_init()? It's also wired into existing
>>> early hook function which's located inside start.S
>> I would like to avoid duplicating lowlevel_init functionality as much as
>> possible , common lowlevel_init would be very welcome .
> 
> Sure, I can add the s_init to common lowlevel_init and moving the codes to s_init.
Thanks. Then the question is, how much of this stuff can be removed 
because it is part of generic lowlevel_init, I hope a lot.
