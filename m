Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F0ACF9C69
	for <u-boot@archiver.kernel.org>; Sun, 22 Sep 2024 21:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4498988C86;
	Sun, 22 Sep 2024 23:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727041318;
	bh=f8KIjGbaPgU6GDNRuY85D2T6cnz4KBgl7SpobPhliHQ=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xLQGPES/ZyrfE40kQhjvMvj/OC+bhRozGWxIF1T655S0MjwHMv1afDZXC9yaBY/ZL
	 pGum+d0et56HzpEzzBtF73O2XjJpXROcoQBanAaBG+bFiGwOOVpEN+10y8bam4YwZA
	 eEbesh3V4lGmDyguwpqX4iRIBBovBYo8n2r1fl1JsalC4CCdSq+ME0A6zrYYkrdbLX
	 pB94gJEmAm3DAhm79a+7n8SyHPeILHATQarTieKyc2Ksyk3w8wpD7t/ZGd4WKpocue
	 oSm/E6m4YV6WEkw6lZuxzC9NLrcMXTO8rfyk8BfXWGUapVQoa1ldB+yUNSBzN0Cnd8
	 zjwrdGr1eHZdg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D107A88CA3;
 Sun, 22 Sep 2024 23:41:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727041316;
 bh=f8KIjGbaPgU6GDNRuY85D2T6cnz4KBgl7SpobPhliHQ=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=R9nxqGfh6l43/UA/Ae9bGCkxbG1JhBvT2LsTWrvAq+uldtKJ1QOgENwPDuY/pE7Go
 xOLYWNmpq/MOsgC29t8Z9dCtJky3l49h7j+PBARTKu+gCLu72IzXUhA+NvD4rFKSB0
 397Yrz3ef1/Exxi9Q6j+KbUQMLzkpl+W/sqbmTy1/DrCu0YxTNbffL0wIyqyJF0zFj
 26lyIB4dxbA9bCpmJ1pofaXB2K4zLCCYQrBxr7nPYbH3BWaJIlNssfbpcX3vNQCco0
 qktxC5OPkpuXsgGeH8hGkpi3UaQuz9ZhvKbhXuaCU8K5wY36bgcFX3M2wUl8HJ/wao
 YjY4PNzuCqmGQ==
Message-ID: <5622f206-f6dc-4242-ae62-b1f7a9ad71df@denx.de>
Date: Sun, 22 Sep 2024 23:31:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] ARM: socfpga: add Enclustra AA1 boot scripts
To: Lothar Rubusch <l.rubusch@gmail.com>, u-boot@lists.denx.de,
 trini@konsulko.com, simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
References: <20240917062157.3181-1-l.rubusch@gmail.com>
 <20240917062157.3181-7-l.rubusch@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240917062157.3181-7-l.rubusch@gmail.com>
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

On 9/17/24 8:21 AM, Lothar Rubusch wrote:
> Add support to boot Enclustra SoMs from MMC, SD or QSPI flash.
Where are these scripts used ?
