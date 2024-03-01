Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58468C48BF6
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 02:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 756D587D15;
	Fri,  1 Mar 2024 03:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="LlyX9Hby";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AA8787D15; Fri,  1 Mar 2024 03:33:45 +0100 (CET)
Received: from mail-m127175.xmail.ntesmail.com
 (mail-m127175.xmail.ntesmail.com [115.236.127.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7898B87CAC
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 03:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhangzj@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=LlyX9HbyyOJOl8tD4QFRV4jOW+54Si3ydk5WAKTp8+pOMLSZCiwwHQjWJVPH2rymJ1Y5oHNwTbZpnammUf7lZ+53+scX7Mt7yZVPwP+Q1nfaYhVIUbCtFlLtKW1+gPfASJtteF680eI3OBlnoGzmK2C0ZPDq+BnBhBS7CpPX/v8=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=VYehq1Nj9jb18xXafUpZ7CyTQnNbvIMKs9AZypOrRHk=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.9.51] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id CCA572A01FB;
 Fri,  1 Mar 2024 10:33:25 +0800 (CST)
Message-ID: <883dd300-9c66-2ebe-0e99-3b8c33c20715@rock-chips.com>
Date: Fri, 1 Mar 2024 10:33:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] board: rockchip: add Rockchip Toybrick TB-RK3588X board
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 weizhao.ouyang@arm.com, u-boot@lists.denx.de
References: <20240229120416.998975-1-zhangzj@rock-chips.com>
 <20240229150834.GU3040305@bill-the-cat>
From: Elon Zhang <zhangzj@rock-chips.com>
In-Reply-To: <20240229150834.GU3040305@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQklKQlZNTUMdShpOSUlDTh9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8df7dbfd7a03aakunmcca572a01fb
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P006Gio5GjMXTAM1Sk8UCxUC
 FxAwFCJVSlVKTEtCSU1LT0tNT0JLVTMWGhIXVQETGhUcARE7CRQYEFYYExILCFUYFBZFWVdZEgtZ
 QVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ0tINwY+
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

Hi Tom,

On 2/29/2024 23:08, Tom Rini wrote:
> On Thu, Feb 29, 2024 at 08:04:16PM +0800, Elon Zhang wrote:
>
>> TB-RK3588X board is a Rockchip Toybrick RK3588 based development board.
>>
>> Specification:
>> 	Rockchip Rk3588 SoC
>> 	4x ARM Cortex-A76, 4x ARM Cortex-A55
>> 	8/16GB Memory LPDDR4x
>> 	Mali G610MC4 GPU
>> 	2× MIPI-CSI0 Connector
>> 	1x 2Lanes PCIe3.0 Connector
>> 	1x SATA3.0 Connector
>> 	32GB eMMC Module
>> 	2x USB 2.0, 2x USB 3.0
>> 	1x HDMI Output, 1x HDMI Input
>> 	2x Ethernet Port
>>
>> Functions work normally:
>> 	[1] USB2.0 Host
>> 	[2] Ethernet0 with PHY RTL8211F
>>
>> More information can be obtained from the following websites:
>> 	[1] https://t.rock-chips.com/en/wiki/EN/tb-rk3588x_en/index.html
>> 	[2] http://t.rock-chips.com/
>>
>> Kernel commits:
>> 	8ffe365f8dc7 ("arm64: dts: rockchip: Add devicetree support for TB-RK3588X board")
>> 	7140387ff49d ("dt-bindings: arm: rockchip: Add Toybrick TB-RK3588X")
>>
>> Signed-off-by: Elon Zhang <zhangzj@rock-chips.com>
> [snip]
>> +config BOARD_SPECIFIC_OPTIONS # dummy
>> +	def_bool y
> Is this just a copy/paste thing that keeps getting re-used? Ideally,
> BOARD_SPECIFIC_OPTIONS shouldn't exist and it's either a select/imply at
> the TARGET_... level or something in the defconfig. But having an empty
> one is very confusing.
Yes... It will be removed later. Thanks for review!

Best regards,
Elon
>
