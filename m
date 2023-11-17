Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36412C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 13:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94E2887509;
	Fri, 17 Nov 2023 14:50:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="FTriseKU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A23A287513; Fri, 17 Nov 2023 14:50:10 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D17C874F6
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:50:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [100.94.55.57] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 0C5C76607380;
 Fri, 17 Nov 2023 13:49:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1700229000;
 bh=2q4DzzHCx/If+WR4fgxK3v+cgWofyvyTeQY9yHF2mkA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FTriseKUYiBKMHSxRcviMQtotc4fJ4IapZB3oJ4wby7KeuSKzl5nkuDaexRzntTU+
 BrB8lkWvpO00/L0I8FBbrbH006cCs6++AaBZ5N+nX5rXSQClekg69vSvu2xtN48eUB
 tU7aRw7mJFI/BBtz8lzVMo5+Bo2KJJDLSeVsDC5tw5VCTwWRPsJtq/3XWQLVlLuzNN
 F8qWYPQfCBMDO3xbKTWapJX66x4Uk0xluIyJEvEASGgpL65qsO87uypX+awPT6rYYX
 8FXqutsPtWOFQcvweQX3gLYOGvKy0cBngSI/Xco1tE5zhfrKCEQj53lnVHM/nn9R+4
 DrVzLpYci6Yow==
Message-ID: <5009cc6a-6f48-4cea-96b1-e7ce8370ed5d@collabora.com>
Date: Fri, 17 Nov 2023 15:49:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: Enable SYS_THUMB_BUILD on AT91
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Sean Anderson <seanga2@gmail.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Aubin.Constans@microchip.com
References: <20231105022742.632175-1-seanga2@gmail.com>
 <170022845734.752997.10698883770687016451.b4-ty@konsulko.com>
 <7c54854e-9319-4577-aa10-44a49a9160c1@collabora.com>
 <20231117134633.GB170968@bill-the-cat>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20231117134633.GB170968@bill-the-cat>
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

On 11/17/23 15:46, Tom Rini wrote:
> On Fri, Nov 17, 2023 at 03:45:02PM +0200, Eugen Hristev wrote:
>> On 11/17/23 15:40, Tom Rini wrote:
>>> On Sat, 04 Nov 2023 22:27:42 -0400, Sean Anderson wrote:
>>>
>>>> Several AT91 boards are quite close to their SPL size limit. For example,
>>>> sama5d27_wlsom1_ek_mmc is just 173 bytes short of its limit and doesn't
>>>> even fit with older GCCs.
>>>>
>>>> All AT91 processors should have thumb support. Enable SYS_THUMB_BUILD. This
>>>> shrinks SPL by around 30%.
>>>>
>>>> [...]
>>>
>>> Applied to u-boot/next, thanks!
>>>
>>
>> so I'd assume that it would go through at91 tree.
> 
> Ah, sorry. Since it was blocking two other series from coming in and you
> had gotten it tested I had assumed I could pull it to -next now to
> unblock that work.
> 

This is yet another time at91 patches get applied directly. Maybe you do 
not really need an at91 maintainer ?
