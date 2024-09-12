Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B326EEE270
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 23:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4465C88216;
	Fri, 13 Sep 2024 01:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726182722;
	bh=T8N2YGR+bPoe4CsCXENE5lKhd0BByR8+at/cIVA0K9E=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d+X5T9YdKz39wAnJacnmU3GOlMYIxiamrNZktEsFITnky6ZUHMnBcCw8N3irTVUVU
	 4L95hDs2LK4jKUoRsK6TUDwB2QTBXLkfRsqEN1WYQI2cwZCgi+416Kv5x+bGGb3bRW
	 nTezi6Px/SzLxJc4FwzkPYG+flH5Sm2ucW0W3htBgQWl/e/jwUFaLRsCbTaby9DFvv
	 NHEt9v6jTLky3K87PoBT4L9A4z67ouhOeZ9vJe+9CGWplkHEoNr6Pdh/EPKbonzEZ8
	 /FaeAV+hY/Q48g1x0EWmZm4ft0D006iFkiffqWNOuyhsGP/F1Ptcx/F9o/R4hDIHuG
	 /GvtI4PkFMdMQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 51FDA89100;
 Fri, 13 Sep 2024 01:11:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1726182719;
 bh=T8N2YGR+bPoe4CsCXENE5lKhd0BByR8+at/cIVA0K9E=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=lZEyofVD3AC500F1+4KsgttTiZiu/H/l+bKiHWv2BEb+/M9GQyGQmB7lz3Ccam8TB
 91W+J582FcgplRV3ESyY5njPNaWXj4jG0wGfa4kKruAi30gnGlt/C/HE20i+Vm3ADO
 AKW94IWCb473ZNAM54KzuKBqC9pQtcJWA2MT99XiT+teVbPT3hfaHkxfxHyL4onFhd
 ZYjTcsWz2nqUeZjbrmCJdyynQ9uWv+LOleDqJls4f0JvhQY2xxfhWAuXH0kqiKq0n2
 r69xg78QTS4kuzDAntcAEmpXoqL3KfoHmgFNOGa9xrHblgeGxGVM4YcoBVwPGZgFDR
 wuAMgS/sCMZDg==
Message-ID: <c0861d70-afd8-4235-86ad-dee1d8bec79e@denx.de>
Date: Fri, 13 Sep 2024 01:04:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] ARM: socfpga: add si5338 clock generator support
To: Lothar Rubusch <l.rubusch@gmail.com>, u-boot@lists.denx.de,
 trini@konsulko.com, simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
References: <20240912060649.190-1-l.rubusch@gmail.com>
 <20240912060649.190-9-l.rubusch@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240912060649.190-9-l.rubusch@gmail.com>
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

On 9/12/24 8:06 AM, Lothar Rubusch wrote:
> The si5338 clock generator is needed on some Enclustra Socfpga SoMs.
> Introduce minimal support of this device.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>   drivers/clk/Kconfig                          |   1 +
>   drivers/clk/Makefile                         |   1 +
>   drivers/clk/skyworks/Kconfig                 |  10 +
>   drivers/clk/skyworks/Makefile                |   3 +
>   drivers/clk/skyworks/Si5338-RevB-Registers.h | 441 +++++++++++++++++++

Is there a matching Linux driver which could be imported instead ?
