Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0876E10F995C
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 17:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39130838BB;
	Wed,  8 Apr 2026 19:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="JHuUvr6l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F325783CF5; Wed,  8 Apr 2026 19:59:29 +0200 (CEST)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1002983693
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 19:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id AE333240027
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 19:59:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1775671167; bh=381ti9YeCpkhsAah7KOocIiRWYCRsnYDEwoHkCPFepQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
 Content-Transfer-Encoding:From;
 b=JHuUvr6lOfsBKKBunLP875kC8Jxl+fLOftBcMVBIeQ3MTfCaWp0uKc4lPcpn9uxo1
 q4SVvSwLlR6l13TcR2sDFWCoIROxy3rIj7I7THvp1dnxFJg3sCZYTvpNm23rpfOz3T
 Pm28fRXiwQlPqEbas0hamzChXlmsZb1qp0uNas+6HIdjLtuWJz/xWo6b2OYiOpkVU3
 CWy4U4I5aEzdT2CffqjW/qhuxkx2XTZI2ytIGqJHsuqU3tp5T5yBR/3UPE6ZKy7KS0
 hcFy4teqa6jSMxNP9JAPx0/N+l/Zkml9Tg7wvU4lOuYCr5M10JatrXvYpCze7gGm6l
 ECrpH1MoEg++g==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4frW6R1pq7z9rxG;
 Wed,  8 Apr 2026 19:59:27 +0200 (CEST)
Message-ID: <cb9de6df-ea93-6c7e-211a-bc1e89c04e13@posteo.net>
Date: Wed, 08 Apr 2026 17:59:27 +0000
MIME-Version: 1.0
Subject: Re: [PATCH v1] arm: dts: s5p4418: fix "mmc write failed" e.g. at cmd
 saveenv
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260407172155.3419-1-stefan_b@posteo.net>
 <20260407172657.GA41863@bill-the-cat>
From: Stefan Bosch <stefan_b@posteo.net>
In-Reply-To: <20260407172657.GA41863@bill-the-cat>
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

Hi Tom,

On 07.04.26 19:26, Tom Rini wrote:
> On Tue, Apr 07, 2026 at 05:23:19PM +0000, Stefan Bosch wrote:
> 
>> s5p4418-pinctrl.dtsi: Fix mmc bus definitions to fix "mmc write failed"
>> e.g. when cmd saveenv is executed. Initialize all four GPIO of the
>> mmc-buses instead of only the first one.
>>
>> Signed-off-by: Stefan Bosch <stefan_b@posteo.net>
>> ---
>>
>>   arch/arm/dts/s5p4418-pinctrl.dtsi | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Hey, I'm curious what it would take to move this to using OF_UPSTREAM,
> where I assume this problem has already been fixed? Thanks!
> 
If I'm not mistaken, using OF_UPSTREAM is not possible because I think 
the s5p4418 SoC is not in the Linux kernel source tree and therefore 
also not in the devicetree-rebasing repo.

Regards
Stefan
