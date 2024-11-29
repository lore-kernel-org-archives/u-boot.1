Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C95AD70E19
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 03:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BCAF89397;
	Fri, 29 Nov 2024 04:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732851974;
	bh=UsNsz/kdWFbtvJJZg0t1691vnp1fU9LoY5Ye0FSwHnI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YtPphYXYLgm19KO/mKWyKX5kZ2lwIskHT3/vxTSwEPwGv9GwYrEmOto2KfJqc85V6
	 msTLWFS6djiBOPyaiDAyMYQOup2NfgZdEfEXy3Fd6ZNVygwJKHONlGcN9dfWTaeJHv
	 YVG6CcpvAErrXlCNfg0lAvH9GBzsBNsVjnjYsvQSbHdBnoXAXjCNve2NnFQKcsaP0Y
	 0iH5/Ube/uoIU8aqSFDUE1wqt3U4XUIi9AAehBhegjiiD8ssV+hzkOiA3qlYLpomgl
	 4KZm331Rl+A4KY8Fn6wp2vmZBOui7m2x4/xuoQe5IJW8W3BTkrQyhzFABjN+T1NFyV
	 qHso171VSL4gQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 412D489383;
 Fri, 29 Nov 2024 04:46:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732851972;
 bh=UsNsz/kdWFbtvJJZg0t1691vnp1fU9LoY5Ye0FSwHnI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=E9a5qNG0JF4x9L4PPwfnurIJdmphYgjkUGqFBOklW8uWaxfzindn/pJ9XkQr1mdvK
 KkPJvcD6P6mW0wrUkZAKk/4LdOLBHuIEXS9wL1HvqlKdrsjC5ihtvO3kJ3fFiOhg7r
 QYrkt+vjN703BHvXkn0q7QK3JfgYkddBIJp35i/n96xdjCCTN4J4Sz49FazBSdmFhm
 apxb85NgYQAqxyS1vq5RX1RFvyFDiEXEFuiOXd18/USgxDxDEnmFU/wSJ0N044nlfV
 mDoFndGXk/sn5fvfurBDouHQFAzyq8zi+f4dISot7eh+SlndWnC8UVAx49ZnHRrnHe
 SfJ3dOGgle+Qg==
Message-ID: <448173c9-b251-4dae-bcfa-36ef17324b46@denx.de>
Date: Fri, 29 Nov 2024 04:14:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ARM: dts: imx: Make DRAM coding GPIOs available in
 all phases on Data Modul i.MX8M Mini/Plus eDM SBC
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>
References: <20241128032623.269459-1-marex@denx.de>
 <CAOMZO5B+W2m6VzS725SBrfgWq7FguLbD8EiK21sacj0_hVGFAw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5B+W2m6VzS725SBrfgWq7FguLbD8EiK21sacj0_hVGFAw@mail.gmail.com>
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

On 11/28/24 3:48 PM, Fabio Estevam wrote:
> Hi Marek,
> 
> On Thu, Nov 28, 2024 at 12:26 AM Marek Vasut <marex@denx.de> wrote:
>>
>> The DRAM configuration GPIO straps must be accessible in all boot phases
>> because the GPIOs are sampled both in U-Boot SPL as well as early on in
>> U-Boot proper. The already present bootph-pre-ram DT property made the
>> GPIO controllers available in SPL, but not early on in U-Boot proper,
>> which made gpio_request_list_by_name_nodev() in board dmo_get_memcfg()
>> fail. Add missing bootph-all DT property to all GPIO controllers which
>> are referenced in dmo,ram-coding-gpios DT property to make those GPIO
>> controllers available early in U-Boot proper as well.
>>
>> Fixes: 8c103c33fb14 ("dm: dts: Convert driver model tags to use new schema")
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> I'm getting CI errors with this series applied:
> 
> https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/962602
> 
> Please check and resend.

Fixed in V2 by adding CONFIG_ARM and CONFIG_ARCH_IMX8M to each defconfig 
, so buildman would recognize them as arm64 targets.
