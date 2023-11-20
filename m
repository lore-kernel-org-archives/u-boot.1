Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B8EC197A0
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 10:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B77486F6F;
	Mon, 20 Nov 2023 11:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=marcan.st header.i=@marcan.st header.b="pRPvttM6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B11F86C72; Mon, 20 Nov 2023 11:45:42 +0100 (CET)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6797486F6F
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 11:45:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marcan@marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: marcan@marcan.st)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 09D5A447AA;
 Mon, 20 Nov 2023 10:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
 t=1700477138; bh=qmP3hWL13gso9o5mqGUPC12XwCGGaP/x+1OOolYYNvU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=pRPvttM6SrKu4eMQxtbsP+RRgDzkTgrnSi8vryaMwJNnj4MXyagn2ZE8gHYBCEhuy
 m7pLRF3P1VdL/AsnnFA8kfnqDROpHJDI8rqrX9ohjUikfrddKehEICZC4dvTmd/bIx
 Z3U0Z61JTmyRc+ZsYwKu/frzpY2u6yJwy3PuEMNj+L7B2F9Z2WUu202j2aiZ1vvbMC
 6ePIbo6nolURlMq0TnFTShxUrMbqca7W7Q/Tg3p2SNQul3aKI5L41NDRen7J/cfzSA
 r6hLjMJ9kn5Cq1FPp2p5rnSYUthfhv5IcLkcC4PXfyVS5CcS0ZCXqXH6dEsjQ9e7V1
 ZoYWqPt9NJMQw==
Message-ID: <cdb3df49-1ba3-4b87-bc2e-57c71a7ce725@marcan.st>
Date: Mon, 20 Nov 2023 19:45:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] USB fixes: xHCI error handling
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, Shantur Rathore <i@shantur.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Mark Kettenis <kettenis@openbsd.org>,
 u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20231027-usb-fixes-1-v1-0-1c879bbcd928@marcan.st>
 <fe844c63-0c44-469c-a4e0-f0e1f2ac63fc@denx.de>
 <CAHc5_t2WFZH65MJENGvC6u21ETcRn47ceQd8jrHV9DVmmM10Vw@mail.gmail.com>
 <3b662808-e047-4023-a00c-1b6728bd5c86@denx.de>
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <3b662808-e047-4023-a00c-1b6728bd5c86@denx.de>
Content-Type: text/plain; charset=UTF-8
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



On 2023/11/20 11:09, Marek Vasut wrote:
> On 11/20/23 00:17, Shantur Rathore wrote:
>> On Sun, Nov 19, 2023 at 8:08 PM Marek Vasut <marex@denx.de> wrote:
>>>
>>> On 10/27/23 01:16, Hector Martin wrote:
>>>> This series is the first of a few bundles of USB fixes we have been
>>>> carrying downstream on the Asahi U-Boot branch for a few months.
>>>>
>>>> Most importantly, this related set of patches makes xHCI error/stall
>>>> recovery more robust (or work at all in some cases). There are also a
>>>> couple patches fixing other xHCI bugs and adding better debug logs.
>>>>
>>>> I believe this should fix this Fedora bug too:
>>>>
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=2244305
>>>
>>> Was there ever a V2 of these patches I might've missed ?
>>
>> Is it this one?
>> https://patchwork.ozlabs.org/project/uboot/list/?series=379807
> 
> I think so, thanks.
> 
> And uh, my question therefore it, is there a V3 which addresses the 3/8 
> and 8/8 comment ?

Not yet, no. Sorry, I probably won't have time to work on this in a
while, currently busy with other stuff.


- Hector
