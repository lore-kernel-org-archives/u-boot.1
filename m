Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BF5D1712B
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 19:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5559188E19;
	Mon, 21 Oct 2024 21:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729539388;
	bh=5CpDg+YXHD2qsaxleryrZOgFpG/kBdPC1jLUhJ4q3hs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PPyy7yBCNdRSqJaqrt3lItrk4krIP8ytsjG9n9dBexx46AQ+P65j9AVbDjnzFq8Ku
	 nO9qQ2EHEX3XsIVsjT0vYpkiVJ+buscD2eLEcpH8qlYpiiaCevimo9PfByj8F8hY0N
	 e7SGc046+k+0gSNk/b2x5VqZ7knfF58whxqf4zhVIGnpMr8WaRlOumDzr76Trjf3ZC
	 R/KJMWykyDr8Ke5E9g39Nd2FYG+aUeEc6a7RtT4cBFpEpAU/AwNPEjD6s74+fPW0KS
	 AtloYCFBkAvunj0bw9xD+rLotQflE+LCWdJntiHuyQ41iUIb9yRHv7RUjHic0P7NyZ
	 3iV/b8ZktGK/Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1AF2088F20;
 Mon, 21 Oct 2024 21:36:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729539386;
 bh=5CpDg+YXHD2qsaxleryrZOgFpG/kBdPC1jLUhJ4q3hs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GqKA44YfgwiE4zBFUWeqrqry2A04UxTrj3PJFThmBrilLgpxBR2lBDI6MjzJA2WqX
 tgBNIg356eiiFxHCosFMdHqMueXIr+NIF5zgL/dK8ngJ6IYZ2Bn7/w371leNHPveUK
 WxntfjJbSdZHPDu1ClQ7gI8G/CpMo+6SoVfpCz+55vSclXFGi9gViY7qvVzNTl3JIc
 EacgKjzy6bDK5wCJZE9rfRGh+hd0+hNIdgfMtYm8J9E6iFifbbP0OJw9GEERAXGYmt
 I8icjrGtbpLhV67Jo05ykqZfAbtvhCW1z+n/QJaxLmS0SjFrC/OTREDF6yC6QDYCWY
 OD25tcEu5FVYg==
Message-ID: <ebf485a1-efa8-48bf-ad02-e6ac543e489f@denx.de>
Date: Mon, 21 Oct 2024 21:34:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: stm32: remove unused include for dhcor
To: Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Tom Rini <trini@konsulko.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 u-boot@dh-electronics.com
References: <20241021181210.1.If2ca2776660cebc50014960f9a4781e8ef937d1f@changeid>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241021181210.1.If2ca2776660cebc50014960f9a4781e8ef937d1f@changeid>
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

On 10/21/24 6:12 PM, Patrick Delaunay wrote:
> Remove device tree include files no more used with OF_UPSTREAM migration
> stm32mp135f-dhcor-dhsbc.dts
> 
> Fixes: cccb29fc1270 ("ARM: dts: stm32: Switch to using upstream DT on DH
> STM32 DHSOM")
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
I found two more unused files, I will send an extended patch shortly.

Thanks for noticing this.
