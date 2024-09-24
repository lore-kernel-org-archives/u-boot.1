Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B921CF9C6B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 20:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B27CB88AD7;
	Tue, 24 Sep 2024 22:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727208061;
	bh=E+KLsFWJm7HQ22CLT8sV2skLxWOH9clrVZsOIp/KFrU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YFEeG0P1OnmuzuJcT8kUB/0K1bcTn1/CkS62f66dGFrHncxYHV/wAUttiQ1V4O2W3
	 W86l0ZAv6FI2ZwTcUk0kMUWvyAE/59c8zprh/BGDUtGlttU/EbTHkBhVXWARGy7JM7
	 AAOOtu9RopQSI43ZLw6E8ERPk+3en1/7SJ7IeCmI3LlZt7D1ZlZW8O3OjuhCeQ+1/T
	 6EniPQHDQm7djDczauEEPpZXPTY0chXRHtU0PoLbfzRfGnRSzUSYCtpRDLNDtMooJE
	 m19feeYRT6OjDIFPYMclWmVnYWzHwywmxPTfxWYrYIPqj3FmaggYD3EaM/AqF3X+Qi
	 74fDg51yThI7Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 126B788A43;
 Tue, 24 Sep 2024 22:00:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727208057;
 bh=E+KLsFWJm7HQ22CLT8sV2skLxWOH9clrVZsOIp/KFrU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HbiymbBh9XrRRYhnJ7hujm/YCaOMHkGiTdgkihNpELa9QR7IK6SWfydBp/3tgKhak
 T6YAOibvpKUMxHFSxzTwbzAXVs/J9H+ovn7c4J+caJlZT2AL+PwKbarPFmVR1f9p1n
 x6aR8mtOZhG7xS+skgXiNMZTB5UxIiSyBVJTDQW127L7a1Z8rDh/bqDa7+7W6jmFhe
 jgnHqlIIh+8akp99kBjCW/qD8W0rcCfpYDK0u8nUGYOLdJVwpT2Bm/FzR0vtGw0lsY
 Vb0Fbyw7evIuWTechq9j/nRPvVgpUdu9oBTqEnndgYXFOQu6hgNxeulWB0Zs2k2HQ6
 Zho50tuYKoMVQ==
Message-ID: <4f7c1b66-7ed1-4333-beb7-345639a3ff2b@denx.de>
Date: Tue, 24 Sep 2024 20:35:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/20] linker: Add SPL linker script for SoC64 devices
To: "Chee, Tien Fong" <tien.fong.chee@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 "Meng, Tingting" <tingting.meng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-4-tien.fong.chee@intel.com>
 <858854ad-bebb-4199-bd8f-a5807a2144dd@denx.de>
 <DM8PR11MB55923CF1E2F876C6EB68FC9BD2682@DM8PR11MB5592.namprd11.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <DM8PR11MB55923CF1E2F876C6EB68FC9BD2682@DM8PR11MB5592.namprd11.prod.outlook.com>
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

On 9/24/24 7:48 AM, Chee, Tien Fong wrote:

Hi,

>>> Add a new .data section for preserving the original state of the .data
>>> section of SoC64 SPL. This new .data section is required to make SPL
>>> reentrant after warm reset.
>> Where is the linker script copied from ? What is the original file name and
>> path ?
> 
> I think the script is copied from arch/arm/cpu/armv8/u-boot-spl.lds .
Can arch/arm/cpu/armv8/u-boot-spl.lds be extended somehow instead , or 
are there too many differences ?
