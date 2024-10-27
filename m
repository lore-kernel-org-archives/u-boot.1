Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D089D13585
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 21:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 521BA8880B;
	Sun, 27 Oct 2024 22:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730062978;
	bh=ZwQH3uJeJLEhVO7oxIHMBLYZQU/oBVZ+PqtEqAvNvvs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T9nFdfcpveCCk9FdJShVq6qndGD0J6q+ojCxPuHsL99dq1rUZAo20U/tAfO25RjBI
	 TygIAIQQ7Eo3AnS6CgSBHGqfBqj1qrGHuB4EZfdkTAv3SeooHJxWdjbNZW3uNd3EIQ
	 lxKJI6logLmG7Fdmj6SuTdkhIGULxr3ToDJXa8pn9W6bpbgouhmY2nqRdJdM2+2C1b
	 ZKjd9RDPLcxhugUHTLXiGc0qeFumpwoU/lO12Iewi8TBHfmfE+XhC+pCj7mMkZoEVM
	 NdeCRh6+11FItGTlrumer5EZ2+NKTDU7k+1GSvCdaVbkEhpIRFtVukhitQmTwA59RC
	 e0jFRHbmOkJLQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 116948811C;
 Sun, 27 Oct 2024 22:02:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730062976;
 bh=ZwQH3uJeJLEhVO7oxIHMBLYZQU/oBVZ+PqtEqAvNvvs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QT+TXs6L9YGkvo7N6dJBWWxrUHwh1zvflgs+G/4g+1tagJ6UrfKAWpb3fHK6dNtoG
 ojW+1Q23ztA2S06hTA+MqYBanElT/HXe0TvybzMSBCTJsKerV9C3iQ0FrIxsomGK4h
 JTQr/PTqBaU2yqYYZSzrGIeUTSZShIZxFbeFPsEWdg9Hw6FHn439w+F6D51eMkDfRT
 f37y0PLYVVKLuPW6BR/w+i0hKNFM5W9RqmWrURuafJlDc+zW8bmSMsJzcerO9yc5pr
 AH5hYbjw6Vnzl3Bkf4ZPON2gLKajpnKYRWxRg5uuFvHeEaqEZqiInCvbEiK8RQUIj0
 ye2zdCJNcTmkA==
Message-ID: <16b090de-2fbb-4905-909d-0da92cb1946c@denx.de>
Date: Sun, 27 Oct 2024 22:01:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx: hab: fix size of IVT+CSF blob tacked on to u-boot.itb
To: Fabio Estevam <festevam@gmail.com>, hs@denx.de
Cc: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@denx.de>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>
References: <20241024122735.893319-1-ravi@prevas.dk>
 <3606fb53-c36e-93c7-6ff9-9947ae43c408@denx.de>
 <CAOMZO5Aae_0cDXX-E9syhVPwMF7_NVu2__40m6Tmi7daePyVbg@mail.gmail.com>
 <CAOMZO5DNQ6cKyNqsQaU8CE-FwoOQdgaf99S8dQ4_FE9XZDvmCw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5DNQ6cKyNqsQaU8CE-FwoOQdgaf99S8dQ4_FE9XZDvmCw@mail.gmail.com>
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

On 10/25/24 5:09 PM, Fabio Estevam wrote:
> On Fri, Oct 25, 2024 at 11:51 AM Fabio Estevam <festevam@gmail.com> wrote:
> 
>>>> Heiko, can you check if this works for you?
>>>
>>> Works fine for me, thanks!
>>
>> Applied, thanks.
> 
> Sorry, applied it too soon. I see there is an ongoing discussion.
> 
> I will wait for more time.

Go ahead, nothing to add from my side, but it would be good to get a TB 
from Heiko maybe ?
