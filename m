Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7AAC5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 14:30:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E057B88075;
	Fri,  8 Mar 2024 15:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709908214;
	bh=x1XBmFPdQxPcKFZhHI9/4LugzScPOkccyfBcqvQKj4U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GDYtFnkV3v1lKDvsc5zkF+P+4RvQUbiEkCB9REXjuGODWuTY0SGkD8YKjNskQFu3x
	 9psuGRszOEJwPzsId5jwZedoC+/b9guYcG9/fpWoEB3akLr1Q6pumghgBB4Afa5gNt
	 kaaJpSha//kF/0a6fU6CXx3Ir8JfW9H8v4blUEhVfyy6hIc92ijuOu/EJKi39MN7xX
	 AA65M66NEaRcj0tLKtb/5twrxPiry2saxQrLPDVzbHiUQEQ1i201FuQJj1zPWBpNTM
	 b1f7sY0YgRBnXS1NAXfJ+paCKmZ0OkIHKn39sjittPzYWSai48YDCUFGuC0/eFb2ff
	 6UC6xB2K/7dpg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 820DE87EED;
 Fri,  8 Mar 2024 15:30:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1709908213;
 bh=x1XBmFPdQxPcKFZhHI9/4LugzScPOkccyfBcqvQKj4U=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MvzCa6Rw6vHW9J5tEn1MUv7fWdi7azxIJu/rni4OTd0h86B9OX7tfn988PrclVZv0
 gYKjLFpWf0vY+imnDczZZYEhZ7kYRIL/HZOE1Lj3Wse7CDtMl6kY9NfwWZokf6bxHC
 kzF4es7CQJg5KA1EQN2YOUf8oSkshRMRTbAvbXUxty6PmaFqq5qtLS8fxEIObI96CZ
 3sibgql/vUq2RCUFcY9NuP4UrVW69clEMIDmjGstYBAm6nwQecyYtEdZcwr6kuG6nG
 Xwb9U9CZJP+N93Jy5g6xY76pytW78+Dp7+JtsUSX+aHg2ETjGYNx1uXX8UR2Sp6XAN
 gdd+WgXzaW4BA==
Message-ID: <91fcb5d9-d38b-40f8-bb66-d4f7e8b1a697@denx.de>
Date: Fri, 8 Mar 2024 15:02:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: dts: stm32: Fix partition node name for
 stm32mp15xx-dhcom-u-boot
Content-Language: en-US
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20240308135009.2621719-1-patrice.chotard@foss.st.com>
 <20240308135009.2621719-3-patrice.chotard@foss.st.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240308135009.2621719-3-patrice.chotard@foss.st.com>
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
> Fixes: 90f992e6a58c ("arm: dts: stm32: Add partitions in flash0 and nand
> node for stm32mp15xx-dhcom/dhcor")
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Reviewed-by: Marek Vasut <marex@denx.de>
