Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944A7C3DA79
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 00:45:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A561874B1;
	Tue, 16 Jan 2024 01:45:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705365915;
	bh=d+MbD0iuWfx2ByjRIVnsnPTRIfRjcV3b4h3nfSvQ/TM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MAyS6x1/GlJVCqYkFV709IjhTNSliS1SnRkrzpTvZ6ACzfsF+Kf+Q+fGZFyVbrydi
	 kvJ6DHzX37XiMboTv3HumSpd+CK1NagFDuuqXBexl8CT/w0kragkC2ZCHhYvaSeQGy
	 Y1YFJdDrDf2s8j34GfOhPcVXwD9kTHlGZy6lak0IcnKQIGYcsRvP6Vbo5mIoH7705E
	 lbQxbLWYQjbpfiXaxyQXuEik+PzQuQhSQfBLTgwQNiVhFtDxXpGTmOVNb2A/JIJG8r
	 tamuog+/zKBc2mNPNt/L2IoD4aOdA+aabTe7H33QWExVV8If+MW9sQBRg7M45jiJd7
	 de6+IXQM5WliQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 15FE2869F6;
 Tue, 16 Jan 2024 01:45:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1705365914;
 bh=d+MbD0iuWfx2ByjRIVnsnPTRIfRjcV3b4h3nfSvQ/TM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=M7qyCsYCZLNP67cNUGJNFcpm6rGxj8CqRked3RnGdD7zu05zdMlYykEClI7WWiS4j
 goNK82YKi04hJ1D+UPYBbBc9tR4ewrfHgPjBqGxzwwOUji3RlMKIqyI1HQuDwX0P82
 kMstxUNRml7TPG02xd+mARfC9VuPh1TEkC7JtvHti4NtL3tZVvsd4qgpevSlHP2nIu
 QfVjYVHvwcMP0R3zECad8GG8VfDLHhY/3FirhQ07XdOSj2+lBLyURf/tugWBSHfTNj
 a1CIJxyjn3P3jwhT1HmgfyLmLxoPyqEmRiwBMjpthQuHV8mjMgJddjbO4b+yPbkTNL
 qPi0h1rjZjczQ==
Message-ID: <2b040273-528e-4954-8258-362e0a1060ab@denx.de>
Date: Tue, 16 Jan 2024 01:45:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] common: usb-hub: Reset hub port before scanning
To: Shantur Rathore <i@shantur.com>, Tom Rini <trini@konsulko.com>
Cc: bmeng.cn@gmail.com, clamor95@gmail.com, Hector Martin <marcan@marcan.st>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20231209181057.331815-1-i@shantur.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231209181057.331815-1-i@shantur.com>
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

On 12/9/23 19:10, Shantur Rathore wrote:
> Currently when a hub is turned on, all the ports are powered on.
> This works well for hubs which have individual power control.
> 
> For the hubs without individual power control this has no effect.
> Mostly in these scenarios the hub port is powered before the USB
> controller is enabled, this can lead to some devices in unexpected
> state.
> 
> With this patch, we explicitly reset the port while powering up hub
> This resets the port for hubs without port power control and has
> no effect on hubs with port power control as the port is still off.
> 
> Before this patch AMicro AM8180 based NVME to USB adapter won't be
> detected as a USB3.0 Mass Storage device but with this it works as
> expected.
> 
> Tested working after this patch:
> 1. AMicro AM8180 based NVME to USB Adapter
> 2. Kingston DataTraveler 3.0
> 3. GenesysLogic USB3.0 Hub
> 
> The drives were tested while connected directly and via the hub.
> 
> Signed-off-by: Shantur Rathore <i@shantur.com>

Reviewed-by: Marek Vasut <marex@denx.de>

Tom, can you please pick this one up directly ?
