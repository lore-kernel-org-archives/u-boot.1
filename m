Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271B5C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 18:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D49F881BF;
	Mon, 27 May 2024 20:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1716835509;
	bh=j5r2jQ/PvTwDYDYZ56JlGOWgPMokJr5matmp9b7jgNk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j8mjSHTrLoLl7I8yTey7eweH+I55HCcEebqrU9WalLQow2Z63OqwCrTXx9LgRNveH
	 FcGfBaqFcBFYONosSfmBtC0UPVpTgIibDfCIM8DCrgOjfPsZ6cZFHDOOnIhuSLkwOR
	 BTMWl/WtC8dLTMbSDX7xwTXLIF/S8PXUzLcBrk9HBwwSFx97w23tiKK+9BRrKtbWdj
	 3LH1hXjH6vfxnnBU8HPfX95RwAe8vB5EAy2RZFGHi+/6TifDrSsEPNzwIDadq0tIqj
	 rw6GxOQVGeNkSdCVZzUCwzVi4I4Yl+GMqSpmsyF79KPAyyFZ3X1+Iryxpa8aAIjyhS
	 CTrz+k7dQG9zA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4A02388210;
 Mon, 27 May 2024 20:45:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1716835508;
 bh=j5r2jQ/PvTwDYDYZ56JlGOWgPMokJr5matmp9b7jgNk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NQyJIjc4nLrTENXppC8VgSDbuaguUtF1onZ8zXbrSUsrnqQbPVFmOL1EkOKel72lM
 53ImTslYbAEIxZ0u/5X0gpDPdpNV713ODq1P6VCqJfFzkkRbIJJjTaI0r49Cqf0L+o
 GXOckbF4OPHWq6VXBlceZO1uEXMc9YhPTZ9zyRU5hCaiJhPehEZI2f/NZSol98OXX7
 b7866sPIMOEji3i9zLIJg1pG4EyWv5xaQk4tBZSEmVQ8KmUVpeMyg+l2477/JjIemM
 pAgphVa1Ndf5tyOtb3UFsTmOw7AlblH04vIHgMykwAIFfbdx7qRVDjwes+mRreGU5v
 gtu3OogP8KPxA==
Message-ID: <a00e3b3f-2248-48a6-ba48-544ac09f2dc1@denx.de>
Date: Mon, 27 May 2024 20:43:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] usb: xhci: Some USB devices fail to initialize
To: Elena Popa <elena.popa@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 "gautam.vivek@samsung.com" <gautam.vivek@samsung.com>,
 "vikas.sajjan@samsung.com" <vikas.sajjan@samsung.com>
References: <AM7PR04MB69685A41537BA13AB3D32C7590F02@AM7PR04MB6968.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <AM7PR04MB69685A41537BA13AB3D32C7590F02@AM7PR04MB6968.eurprd04.prod.outlook.com>
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

On 5/27/24 7:16 PM, Elena Popa wrote:
> Hello,

Hi,

> We've noticed that, at least, on the i.MX8M* platforms

Which exact platforms, which SoC, which board ?

> , some USB devices (especially USB2.0 sticks) fail

Which exact sticks ? USB IDs and model would be helpful.

Which U-Boot version is this ?
