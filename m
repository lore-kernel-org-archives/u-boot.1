Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199E5C38150
	for <u-boot@archiver.kernel.org>; Sun,  7 Jul 2024 00:56:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D34C8858B;
	Sun,  7 Jul 2024 02:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720313739;
	bh=L5sgq2rjPyzyYMF0H1OocBU4xuED1PWtOmI++BxC2Xw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TP0FqedJuWf83jr/c4nlZ4BozZuFz+iV6bo4JRWJ/MjJAg2NFoKsm1vBCKezXX38j
	 KJJgsCXWmCaORpnvrXhXEv/5X3feeaVEfAHt5yxHGJHFmBkuPGJLZS6VJXuQe2mDgr
	 WfnzHN1pFpncw7cCfuJUpzTzbozPJt8YUeQurJSuIuIGBqvWVpyD+uR18jFobZP33I
	 A7QYM8BrVw0livl3wdicqPu47spNmnyyShC2bSqbb2yXP1BO5cSZObhHuNU6MKYk3c
	 38gqi3h3kGfws00U/Vs0uczZiBe/qR/lNE+6G0xXODjRrd9nJ87K8WYdrVki8uqb/n
	 sJ0h3bydFydYQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4A9E388415;
 Sun,  7 Jul 2024 02:55:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1720313737;
 bh=L5sgq2rjPyzyYMF0H1OocBU4xuED1PWtOmI++BxC2Xw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QSP31cpyN8XnBMvFhgFoIE3+7vV1FpiYL8ajeMiYD4m7W9UaE5XDGOgrq9HG//VW4
 WKI7NSSLe2L/8Xwyq8G/ygOHV/nnma9fvFHcXBW+QFzH+ux23Cwy09T3nQUd+ZCl0c
 AtUKijy/J2N14lQFWMTP/aPnli/8yx21T035Gq785oW1M+Qe+04AxMBXKg0fHlqTpQ
 0hyMY1fjbwn1JkX5739ZYt4nfhZgqQY6ZxnPiKup5jh8o3cRqkEB6GSJkbX76n/kwU
 Txj7HzSisPjamWRm49ZYY1NW1slXKNsoclh1FtqgHYZE2w9+FVz3B/GBZjR7iQ9/m4
 Ho5faSlyDVaAw==
Message-ID: <e534b055-eb45-47e1-94d4-6e840a4e7d20@denx.de>
Date: Sun, 7 Jul 2024 02:53:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [RFC] usb: xhci: Some USB devices fail to initialize
To: Elena Popa <elena.popa@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
References: <AM7PR04MB69685A41537BA13AB3D32C7590F02@AM7PR04MB6968.eurprd04.prod.outlook.com>
 <a00e3b3f-2248-48a6-ba48-544ac09f2dc1@denx.de>
 <AM7PR04MB6968BB208B38C3DA9F11B9D890F12@AM7PR04MB6968.eurprd04.prod.outlook.com>
 <9ef2b0f0-13b7-4caf-8f99-7803dffc2afb@denx.de>
 <AM7PR04MB6968EB78F957243D25BDD80890FD2@AM7PR04MB6968.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <AM7PR04MB6968EB78F957243D25BDD80890FD2@AM7PR04MB6968.eurprd04.prod.outlook.com>
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

On 6/1/24 4:23 PM, Elena Popa wrote:
> Hi Marek,

Hi,

sorry for the really late reply.

>> Does it also work if you 'setenv usb_pgood_delay 2000' ?
>>
> No, the USB stick is still not initialized.
> 
>> Can you include the 5ms patch ?
> 
> I've attached the patch which makes it work. Of course, I'm not sure if this is the correct way to fix the problem. You can apply the patch on the master branch.

Does this delay have to be added to every control message (unlikely) or 
to some specific control message (likely) ?

Could you try and use the debug() statement in xhci_submit_control_msg() 
, as well as move the mdelay(5) there , to find out which exact control 
message requires this extra delay ? I also suspect this may not really 
be related to a specific control message, but instead some early part of 
initialization .
