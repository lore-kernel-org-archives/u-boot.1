Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A25C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 14:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 748B488019;
	Fri,  8 Mar 2024 15:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709908214;
	bh=9eOOH/Fk4XbFgkFQNo0HWUmox4M/hrWvk1gGaucOmao=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qACAKwUrr/3mMH7jFvkN7G9l3D2HoWFWztuu0caGd8Vg5sfV+1i5IKB1d1HvK3UgW
	 xuSsFNXaDX26ZmDUu8zd1yOkQNprx3nlEh3v2FFrXOjUpkCC5UDrVIYK6zmVK0tjai
	 OY22eqa0mESq/bm2OxZ2pg+LgVwzziPjwXSX8coxmsSTgHn5j3HZRf5QUuQK4uA1Tw
	 wGIkErpt6mSvnbU8cr+iPoJzy0YSJvGhAvr8kirWaMGvEN7KkWc14i0RBoBoX7exsl
	 Sa5sBceNvTkVQy9VLx5yd9GQftrg8xvqWgczwmVs38PjBq7FSEwDDhWxzgKKj6zbCq
	 0/7sddIm0uYTA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E53E987C94;
 Fri,  8 Mar 2024 15:30:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1709908213;
 bh=9eOOH/Fk4XbFgkFQNo0HWUmox4M/hrWvk1gGaucOmao=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=w6mwj8wYKbaJC14UmTkO7tEBFDZbuCLI4wkLsqihm4JZp1lb1IsfF4gOEpahsIjRu
 1CtzMJNR751tBY1cExYPbpGDY9V3JsqVRFQEVse65yXFwcj8et7nY2AfvYiVqewr5+
 rD3dSz4nntiBMCsF6Uu/X3nPeVAGPwUpMOEQSTAqbFmb12vQKG3H1sIqQ6LW/CxuOj
 K+Y/8J/2CSnq7QUuuf1ZnoZx/8XFlKWVMsEiJN5mdAE3ZKfVZPsGWgygzZkRP+ZU+P
 XqxrGfvUx1lzZ/8EJ6M6H2aF5/EOsqVE3emJgNKu1NGNeCD51HVAiD59jaakHx5dSF
 wE/K87aoc1slg==
Message-ID: <22276045-8179-4544-8921-698166994bdc@denx.de>
Date: Fri, 8 Mar 2024 15:02:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ARM: dts: stm32: Fix partition node name for
 stm32mp15xx-dhcor-u-boot
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Tom Rini <trini@konsulko.com>
References: <20240308135009.2621719-1-patrice.chotard@foss.st.com>
 <20240308135009.2621719-2-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240308135009.2621719-2-patrice.chotard@foss.st.com>
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

On 3/8/24 2:50 PM, Patrice Chotard wrote:
> Fix flash@0 partition node name with correct offset.
> 
> Fixes: 90f992e6a58c ("arm: dts: stm32: Add partitions in flash0 and nand node for
> stm32mp15xx-dhcom/dhcor")
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Reviewed-by: Marek Vasut <marex@denx.de>
